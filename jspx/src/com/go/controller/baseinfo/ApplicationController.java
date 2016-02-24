
package com.go.controller.baseinfo;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.ExtendDate;
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.ApplicationService;
import com.go.service.baseinfo.ApplicationapplicationClassStudentService;
import com.go.service.baseinfo.UnitInfoService;
/**
 * 学生申请管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/baseinfo/application")
public class ApplicationController extends BaseController {
	  @Resource
	  private  ApplicationService  applicationService;
	  @Resource
	  private  ApplicationapplicationClassStudentService  applicationClassStudentService;
	  @Resource
	  private  UnitInfoService  unitInfoService;
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/baseinfo/application/list";
	  }
	  /**
	   * 添加数据页面(单位)
	   * @return
	   */
	  @RequestMapping("application.do")
	  public  String application(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  if(parameter.containsKey("xdIds")){
			  String xdIds=parameter.get("xdIds").toString();
			  xdIds=xdIds.replaceAll(",", "','");
			  xdIds="'"+xdIds+"'";
			  parameter.put("xdIds", xdIds);
		  }
		  if(parameter.containsKey("xkIds")){
			  String xkIds=parameter.get("xkIds").toString();
			  xkIds=xkIds.replaceAll(",", "','");
			  xkIds="'"+xkIds+"'";
			  parameter.put("xkIds", xkIds);
		  }
		  model.addAttribute("vo", parameter);
		  return  "admin/baseinfo/application/studentList";
	  }  
	  /**
	   * 保存申请学生
	   * @author chenhb
	   * @create_time  2015-8-31 下午3:22:15
	   * @param request
	   * @param response
	   * @param studentId
	   * @throws Exception
	   */
	  @RequestMapping("saveApplication.do")
	  public  void saveApplication(HttpServletRequest request, HttpServletResponse response,String[] studentId) throws Exception{
		//获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  if(studentId==null || studentId.length==0){
			  this.ajaxMessage(response, Syscontants.ERROE,"至少提交一个学生申请！");
			  return;
		  }
		  List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		  Map<String,Object> m=new HashMap<String, Object>();
		  m.put("applicationDate", ExtendDate.getYMD_h_m_s(new Date()));
		  m.put("applicant", userMap.get("id"));
		  for(String str:studentId){
			  Map<String,Object> map=new HashMap<String, Object>(m);
			  map.put("id", SqlUtil.uuid());
			  map.put("studentId", str);
			  map.put("classId",parameter.get("classId"));
			  map.put("status","1");
			  list.add(map);
		  }
		  parameter.put("list", list);
		  applicationClassStudentService.batchAdd(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE,"申请成功！");
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
	  @RequestMapping("studentList.do")
	  public  void  studentList(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  JSONObject jsonObj = this.applicationService.lookStudent(parameter);
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
		  return  "admin/baseinfo/application/lookStudent";
	  }
	  
	  /**
	   * 删除数据
	   * @param request
	   * @param response
	   */
	  @RequestMapping("delete.do")
	  public  void  delete(HttpServletRequest request, HttpServletResponse response){
		  List<String> parameter = sqlUtil.getIdsParameter(request);
		  this.applicationService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
}
