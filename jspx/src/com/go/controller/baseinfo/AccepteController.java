package com.go.controller.baseinfo;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.ExtendDate;
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.ApplicationService;
import com.go.service.baseinfo.ClassStudentService;
import com.go.service.baseinfo.UnitInfoService;

/**
 * 学生申请信息受理控制器
 * @author zhangjf
 * @create_time 2015-8-31 下午5:09:01
 */
@Controller
@RequestMapping("/baseinfo/accepte/*")
public class AccepteController extends BaseController{
	 @Autowired
	 private  ApplicationService  applicationService;
	 @Autowired
		private  ClassStudentService  classStudentService;
	@Autowired
	private  UnitInfoService  unitInfoService;
	/**
	 * 跳转到列表页面
	 * @author zhangjf
	 * @create_time 2015-8-31 下午5:11:41
	 * @return
	 */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/baseinfo/accepte/list";
	  }
	  
	  /**
	   * 查询列表
	   * @param request
	   * @param response
	   */ 
	  @RequestMapping("list.do")
	  public  void  findList(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  Map<String,Object> unitInfo=new HashMap<String, Object>();
		  unitInfo.put("userId", userMap.get("id"));
		  unitInfo=this.unitInfoService.findOne(unitInfo);
		  if(unitInfo!=null){
			  parameter.put("flag", unitInfo.get("flag"));
		  }
		  JSONObject jsonObj = this.applicationService.findPageBean(parameter);
		  this.ajaxData(response, jsonObj.toJSONString());
	  }
	  
	  /**
	   * 查询学生列表
	   * @param request
	   * @param response
	   */ 
	  @RequestMapping("lookStudent.do")
	  public  String  lookStudent(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  model.addAttribute("vo", parameter);
		  return  "admin/baseinfo/accepte/lookStudent";
	  }
	  
	  /**
	   * 查询学生列表
	   * @param request
	   * @param response
	   */ 
	  @RequestMapping("studentList.do")
	  public  void  studentList(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  JSONObject jsonObj = this.applicationService.lookStudent(parameter);
		  this.ajaxData(response, jsonObj.toJSONString());
	  }
	  
	  /**
	   * 审核通过
	   * @author zhangjf
	   * @create_time 2015-8-31 下午5:45:42
	   * @param request
	   * @param response
	   */
	  @RequestMapping("accepted.do")
	  public void accepted(HttpServletRequest request, HttpServletResponse response){
		  List<String> parameter = sqlUtil.getIdsParameter(request);
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);
		  Map<String,Object> params = sqlUtil.queryParameter(request);
		  params.put("checkor", userMap.get("id"));
		  params.put("checkDate", ExtendDate.getYMD_h_m_s(new Date()));
		  params.put("ids", parameter);
		  this.applicationService.accepteList(params);
		  /**
		   * chenhb 2015-09-01
		   */
		  if("2".equals(params.get("status"))){//审核通过
			  List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
			  for(String str:parameter){
				  Map<String,Object> map=new HashMap<String, Object>();
				  map.put("acs",str);//application_class_student表的id
				  map.put("id", SqlUtil.uuid());
				  list.add(map);
			  }
			  params.put("list", list);
			  classStudentService.accepted(params);
		  }
		  this.ajaxMessage(response, Syscontants.MESSAGE, "审核成功");
	  }	  
}
