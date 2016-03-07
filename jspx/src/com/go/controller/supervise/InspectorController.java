package com.go.controller.supervise;

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
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.UnitInfoService;
import com.go.service.platform.UserInfoService;
import com.go.service.supervise.InspectorService;
import com.go.service.supervise.InspectorUnitService;
/**
 * 督学管理控制层
 * @author chenhb
 * @create_time  2016-3-3 上午11:16:19
 */
@Controller
@RequestMapping("/supervise/inspector")
public class InspectorController extends BaseController {
	  @Resource
	  private  InspectorService  inspectorService;
	  @Resource
	  private  UserInfoService  userInfoService;
	  @Resource
	  private  InspectorUnitService  inspectorUnitService;
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time  2016-3-3 上午11:17:34
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/supervise/inspector/list";
	  }
	  /**
	   * 绑定学校信息
	   * @author chenhb
	   * @create_time  2015-8-18 上午10:39:15
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("bindSchool.do")
	  public  String bindSchool(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  model.addAttribute("vo", parameter);
		  return  "admin/supervise/inspector/bindSchool";
	  } 
	  /**
	   * 保存学校
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("saveSchool.do")
	  public  void saveSchool(HttpServletRequest request, HttpServletResponse response,String[] unitId) throws Exception{
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  List<String> list=new ArrayList<String>();
		  list.add(parameter.get("inspectorId").toString());
		  inspectorUnitService.delete(list);//删除之前绑定的
		  
		  if(unitId==null || unitId.length==0){
			  this.ajaxMessage(response, Syscontants.MESSAGE,"保存成功");
			  return;
		  }
		  List<Map<String,Object>> res=new ArrayList<Map<String,Object>>();
		  for(String unit:unitId){
			  Map<String,Object> map=new HashMap<String, Object>();
			  map.put("id", SqlUtil.uuid());
			  map.put("inspectorId", parameter.get("inspectorId"));
			  map.put("unitId", unit);
			  res.add(map);
		  }
		  parameter.put("list", res);
		  inspectorUnitService.add(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE,"保存成功");
	  }
	  /**
	   * 添加数据页面
	   * @author chenhb
	   * @create_time  2016-3-3 上午11:17:42
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object> parameter=new HashMap<String,Object>();
		  Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前用户
		  return  "admin/supervise/inspector/edit";
	  }  
	  /**
	   * 导出数据
	   * @author chenhb
	   * @create_time  2016-3-3 上午11:17:52
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("load.do")
	  public  String load(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object>  res = this.inspectorService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/supervise/inspector/edit";
	  }
	  
	  /**
	   * 
	   * 保存
	   * @author chenhb
	   * @create_time  2016-3-3 上午11:17:58
	   * @param request
	   * @param response
	   * @throws Exception
	   */
	  @RequestMapping("save.do")
	  public  void save(HttpServletRequest request, HttpServletResponse response) throws Exception{
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			  parameter.put("creator", user.get("id"));
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  //账号数据创建
			  Map<String,Object> userMap=new HashMap<String, Object>();
			  Object userId=SqlUtil.uuid();
			  userMap.put("id", userId);
			  userMap.put("text", n_parameter.get("text"));
			  Object password=n_parameter.get("password");
			  if(password==null || "".equals(password)){
				  password="123456";
			  }
			  userMap.put("password", Util.Encryption(password.toString()));
			  userMap.put("type", "督学账号");
			  n_parameter.put("userMap", userMap);
			  n_parameter.put("userId", userId);
			  //添加菜单
			  this.inspectorService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
			  //登陆账号操作
			  if(sqlUtil.isIDNull(parameter,"userId")){//不存在用户
				  Map<String,Object> user=new HashMap<String, Object>();
				  Object userId= SqlUtil.uuid();
				  parameter.put("userId", userId);
				  user.put("id", userId);
				  user.put("text", parameter.get("text"));
				  Object password=parameter.get("password");
				  if(password==null || "".equals(password)){
					  password="123456";
				  }
				  user.put("password", Util.Encryption(password.toString()));
				  user.put("type", "督学账号");
				  parameter.put("addUser", user);
//				  this.userInfoService.add(user);//添加用户
			  }else{
				  Map<String,Object> user=new HashMap<String, Object>();
				  user.put("id", parameter.get("userId"));
				  user=userInfoService.load(user);
				  user.put("text", parameter.get("text"));
//				  userInfoService.update(user);
				  parameter.put("updateUser", user);
			  }
			  
			  
			  this.inspectorService.update(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"修改成功");
		  }
	  }
	  /**
	   * 查询列表
	   * @author chenhb
	   * @create_time  2016-3-3 上午11:18:04
	   * @param request
	   * @param response
	   * @param model
	   */
	  @RequestMapping("list.do")
	  public  void  findList(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前用户
		  JSONObject jsonObj = this.inspectorService.findPageBean(parameter);
		  this.ajaxData(response, jsonObj.toJSONString());
	  }
	  /**
	   * 删除数据
	   * @author chenhb
	   * @create_time  2016-3-3 上午11:18:10
	   * @param request
	   * @param response
	   */
	  @RequestMapping("delete.do")
	  public  void  delete(HttpServletRequest request, HttpServletResponse response){
		  List<String> parameter = sqlUtil.getIdsParameter(request);
		  this.inspectorService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
	 /**
   * 更新数据状态
   * @author chenhb
   * @create_time  2016-3-3 上午11:18:18
   * @param request
   * @param response
   */
	@RequestMapping("changestatus")
	public void changestatus(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		Object obj=parameter.get("status");
		if("禁用".equals(obj)){
			 this.ajaxMessage(response, Syscontants.MESSAGE,"启用成功");
			 parameter.put("status", "启用");
		}else{
			 parameter.put("status", "禁用");
			this.ajaxMessage(response, Syscontants.MESSAGE,"禁用成功");
		}
		this.inspectorService.changeStatus(parameter);
	}
	
}
