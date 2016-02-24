
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
import com.go.common.util.JSONUtil;
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.ClassInfoService;
import com.go.service.baseinfo.UnitInfoService;
import com.go.service.platform.UserInfoService;
/**
 * 班级管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/baseinfo/classInfo")
public class ClassInfoController extends BaseController {
	  @Resource
	  private  ClassInfoService  classInfoService;
	  @Resource
	  private  UserInfoService  userInfoService;
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
		  return  "admin/baseinfo/classInfo/list";
	  }
	  /**
	   * 班主任列表
	   * @author chenhb
	   * @create_time {date} 上午8:52:10
	   * @return
	   */
	  @RequestMapping("findClassTeacher.do")
	  public String findClassTeacher(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  if(!parameter.containsKey("name")){
			  parameter.put("name", "classTeacherName");
		  }
		  if(!parameter.containsKey("id")){
			  parameter.put("id", "classTeacherId");
		  }
		  model.addAttribute("vo", parameter);
		  return  "admin/baseinfo/classInfo/classTeacherList";
	  }
	  /**
	   * 班级学员列表
	   * @author chenhb
	   * @create_time {date} 下午2:21:25
	   * @return
	   */
	  @RequestMapping("findClassStudent.do")
	  public String findClassStudent(){
		  return  "admin/baseinfo/classInfo/classStudentList";
	  }
	  /**
	   * 不分页查询
	   * @author chenhb
	   * @create_time {date} 下午1:38:47
	   * @param request
	   * @param response
	   * @param model
	   * @throws Exception
	   */
	  @RequestMapping("all.do")
	  public  void findAll(HttpServletRequest request,HttpServletResponse response,Model  model) throws Exception{
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  parameter.put("userId", userMap.get("id"));
		  Map<String,Object> classInfo=classInfoService.findOne(parameter);
		  if(classInfo==null){//不是班主任
			  parameter.remove("userId");
		  }
		  List<Map<String,Object>> list=classInfoService.findAll(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
	  }
	  /**
	   * 学校树
	   * @author chenhb
	   * @create_time  2015-9-23 下午11:55:59
	   * @param request
	   * @param response
	   * @param model
	   * @throws Exception
	   */
	  @RequestMapping("schoolTree.do")
	  public  void schoolTree(HttpServletRequest request,HttpServletResponse response,Model  model) throws Exception{
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  Map<String,Object> unitInfo=new HashMap<String, Object>();
		  unitInfo.put("userId", userMap.get("id"));
		  unitInfo=this.unitInfoService.findOne(unitInfo);
		  if(unitInfo!=null){
			  parameter.put("flag", unitInfo.get("flag"));
		  }
		  List<Map<String,Object>> list=unitInfoService.findTree(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
	  }
	  /**
	   * 添加数据页面(单位)
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  Map<String,Object> unitInfo=new HashMap<String, Object>();
		  unitInfo.put("userId", userMap.get("id"));
		  unitInfo=unitInfoService.findOne(unitInfo);
		  model.addAttribute("unitInfo", unitInfo);
		  
		  Map<String,Object>  res=new HashMap<String, Object>();
		  res.put("id", SqlUtil.uuid());
		  model.addAttribute("vo", res);
		  return  "admin/baseinfo/classInfo/edit";
	  }  
	  /**
	   * 导出数据
	   * @param request
	   * @param response
	   * @return
	   */
	  @RequestMapping("load.do")
	  public  String load(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object>  res = this.classInfoService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/baseinfo/classInfo/edit";
	  }
	  
	  
	  /**
	   * 保存单位
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("save.do")
	  public  void save(HttpServletRequest request, HttpServletResponse response,String[] xdId,String[] xkId) throws Exception{
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  Object id=parameter.get("id");
		  if(isIDNull){
			  id=SqlUtil.uuid();
			  parameter.put("id", id);
		  }
		  if(xdId!=null){//选择学段
			  List<Map<String,Object>> xdList=new ArrayList<Map<String,Object>>();
			  for(String xd:xdId){
				  Map<String,Object> m=new HashMap<String, Object>();
				  m.put("id", SqlUtil.uuid());
				  m.put("classId", parameter.get("id"));
				  m.put("xdId", xd);
				  xdList.add(m);
			  } 
			  if(xdList.size()>0){
				  parameter.put("xdList", xdList);
			  }
		  }
		  if(xkId!=null){//选择学科
			  List<Map<String,Object>> xkList=new ArrayList<Map<String,Object>>();
			  for(String xk:xkId){
				  Map<String,Object> m=new HashMap<String, Object>();
				  m.put("id", SqlUtil.uuid());
				  m.put("classId", parameter.get("id"));
				  m.put("xkId", xk);
				  xkList.add(m);
			  }
			  if(xkList.size()>0){
				  parameter.put("xkList", xkList);
			  }
		  }
		  
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  parameter.put("creator", userMap.get("id"));
		  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
		  if(classInfoService.load(parameter)==null){
			  //设置ID
//			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  this.classInfoService.add(parameter);//添加
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
			  this.classInfoService.update(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"保存成功");
		  }
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
		  
		  parameter.put("userId", userMap.get("id"));
		  Map<String,Object> classInfo=classInfoService.findOne(parameter);
		  if(classInfo==null){//不是班主任
			  parameter.remove("userId");
		  }
		  JSONObject jsonObj = this.classInfoService.findPageBean(parameter);
		  this.ajaxData(response, jsonObj.toJSONString());
	  }
	  
	  
	  /**
	   * 删除数据
	   * @param request
	   * @param response
	   */
	  @RequestMapping("delete.do")
	  public  void  delete(HttpServletRequest request, HttpServletResponse response){
		  List<String> parameter = sqlUtil.getIdsParameter(request);
		  this.classInfoService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
  /**
	 *更新数据状态
	 * @param request
	 * @param response
	 */
	@RequestMapping("changestat")
	public void changestat(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		Object obj=parameter.get("isActives");
		if("1".equals(obj)){
			 this.ajaxMessage(response, Syscontants.MESSAGE,"启用成功");
			 parameter.put("isActives", "0");
		}else{
			 parameter.put("isActives", "1");
			this.ajaxMessage(response, Syscontants.MESSAGE,"禁用成功");
		}
		this.classInfoService.updatestat(parameter);
	}
}
