package com.go.controller.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.go.common.util.SysUtil;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.ClassInfoService;
import com.go.service.baseinfo.ClassStudentService;

@Controller
@RequestMapping("/main")
public class MainController extends BaseController {
	  @Resource
	  private  ClassInfoService  classInfoService;
	  @Resource
	  private  ClassStudentService  classStudentService;
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
