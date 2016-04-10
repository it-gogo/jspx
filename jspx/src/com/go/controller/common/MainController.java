package com.go.controller.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.go.common.util.SysUtil;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.ClassInfoService;
import com.go.service.baseinfo.ClassStudentService;
import com.go.service.site.ArticleManagementService;
import com.go.service.supervise.SchoolSuperviseService;
import com.go.service.train.NoticeInfoService;
import com.go.service.train.NoticeManagementService;

@Controller
@RequestMapping("/main")
public class MainController extends BaseController {
	  @Resource
	  private  ClassInfoService  classInfoService;
	  @Resource
	  private  ClassStudentService  classStudentService;
	  @Autowired
	  private ArticleManagementService articleManagementService;
	  @Autowired
	  private NoticeInfoService noticeInfoService;
	  @Autowired
	  private NoticeManagementService noticeManagementService;
	  @Autowired
	  private SchoolSuperviseService schoolSuperviseService;
	  
	  
	/**
	 * 首页
	 * @author chenhb
	 * @create_time  2015-9-2 上午9:38:57
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("index.do")
	public String index(HttpServletRequest request,
                           HttpServletResponse response,Model  model){
		Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);
		  Map<String,Object> parameter=new HashMap<String, Object>();
		  parameter.put("classUserId", userMap.get("id"));
		  List<Map<String,Object>> list=classInfoService.findAll(parameter);
		  model.addAttribute("vo", parameter);
		  if(list==null || list.size()==0){
			  list=classInfoService.findAll(null);
		  }
		  model.addAttribute("classList", list);//跟该账户有关系的班级
		  	//zhangjf 2016-04-07 加载最新导读文章
		  	Map<String,Object> params=new HashMap<String, Object>();
		  	params.put("sectionType", "oa栏目");
		  	params.put("limit", " limit 0,8 ");
			model.addAttribute("newest", articleManagementService.findAll1(params));//最新文章
			//查询老师通知信息
		    params=new HashMap<String, Object>();
		    params.put("isRead", "未阅读");
		    params.put("loginId", userMap.get("id"));
		    params.put("isInstation", "站内短信");
		    params.put("limit", " limit 0,8");
		    model.addAttribute("noticeList", noticeManagementService.findAll(params));
		    //zhangjf 2016-04-10查看状态为待提交的督学项目
		      params=new HashMap<String, Object>();
		      String type=userMap.get("type").toString();
			  if("老师账号".equals(type) || "单位账号".equals(type)){
				  params.put("flag", userMap.get("flag"));
			  }
			  params.put("flowStatus", "待学校上传材料");
			  model.addAttribute("todoProjects", schoolSuperviseService.findAll(params));
		    
		return  "admin/index";
	}
	
	/**
	 * 班级首页
	 * @author chenhb
	 * @create_time  2015-9-28 上午11:48:18
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("classIndex.do")
	public String classIndex(HttpServletRequest request,
                           HttpServletResponse response,Model  model){
		Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  model.addAttribute("vo", parameter);
		  parameter.put("userId", userMap.get("id"));
		  Map<String,Object> map=classStudentService.findOne(parameter);
		  boolean isStudent=false;
		  if(map!=null && map.size()>0){
			  isStudent=true;
		  }
		  model.addAttribute("isStudent", isStudent);
		return  "admin/classIndex";
	}
}
