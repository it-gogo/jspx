package com.go.controller.platform;

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
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.platform.MenuInfoService;
import com.go.service.platform.RoleMenuService;
import com.go.service.platform.RoleService;
import com.go.service.platform.RoleUserService;
import com.go.service.platform.UserInfoService;

/**
 * 角色管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/platform/role")
public class RoleController extends BaseController {
	  @Resource
	  private  RoleService  roleService;
	  @Resource
	  private  MenuInfoService  menuInfoService;
	  @Resource
	  private  RoleMenuService  roleMenuService;
	  @Resource
	  private  UserInfoService  userInfoService;
	  @Resource
	  private  RoleUserService  roleUserService;
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/platform/role/list";
	  }
	  /**
	   * 角色树
	   * @author chenhb
	   * @create_time  2016-3-14 下午6:00:57
	   * @param request
	   * @param response
	   * @param model
	   */
	  @RequestMapping("roleTree.do")
	  public  void roleTree(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  Object isSuperadmin=user.get("isSuperadmin");
		  if("超级管理员".equals(isSuperadmin)){
			  
		  }else{
			  parameter.put("isSuperadmin", "超级管理员");
		  }
		  List<Map<String,Object>> list=roleService.findAll(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
	  }
	  /**
	   * 添加数据页面
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object> parameter=new HashMap<String,Object>();
		  Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前用户
		  return  "admin/platform/role/edit";
	  }  
	  /**
	   * 绑定模块
	   * @author chenhb
	   * @create_time  2015-8-17 下午7:47:46
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("bindMenu.do")
	  public  String bindMenu(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  model.addAttribute("vo", parameter);
		  return  "admin/platform/role/bindMenu";
	  }  
	  /**
	   * 权限树
	   * @author chenhb
	   * @create_time  2015-8-18 上午8:49:14
	   * @param request
	   * @param response
	   * @param model
	 * @throws Exception 
	   */
	  @RequestMapping("menuTree.do")
	  public  void menuTree(HttpServletRequest request,HttpServletResponse response,Model  model) throws Exception{
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  Object isSuperadmin=user.get("isSuperadmin");
		  if("超级管理员".equals(isSuperadmin)){
			  
		  }else{
			  parameter.put("userId", user.get("id"));
		  }
		  List<Map<String,Object>> list=menuInfoService.roleMenu(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
	  }
	  /**
	   * 保存权限
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("saveAuthority.do")
	  public  void saveAuthority(HttpServletRequest request, HttpServletResponse response,String[] menuId) throws Exception{
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  List<String> list=new ArrayList<String>();
		  list.add(parameter.get("roleId").toString());
		  roleMenuService.delete(list);//删除之前绑定的
		  
		  if(menuId==null || menuId.length==0){
			  this.ajaxMessage(response, Syscontants.ERROE,"保存失败，至少选择一个菜单。");
			  return;
		  }
		  List<Map<String,Object>> res=new ArrayList<Map<String,Object>>();
		  for(String menu:menuId){
			  Map<String,Object> map=new HashMap<String, Object>();
			  map.put("id", SqlUtil.uuid());
			  map.put("roleId", parameter.get("roleId"));
			  map.put("menuId", menu);
			  res.add(map);
		  }
		  parameter.put("list", res);
		  roleMenuService.add(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE,"保存成功");
	  }
	  /**
	   * 绑定登陆信息
	   * @author chenhb
	   * @create_time  2015-8-18 上午10:39:15
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("bindUser.do")
	  public  String bindLogin(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  model.addAttribute("vo", parameter);
		  return  "admin/platform/role/bindUser";
	  }  
	  /**
	   * 登陆信息列表
	   * @author chenhb
	   * @create_time  2015-8-18 上午11:35:19
	   * @param request
	   * @param response
	   * @param model
	   */
	  @RequestMapping("userList.do")
	  public  void userList(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  parameter.put("flag", user.get("flag"));
		  List<Map<String,Object>> list=userInfoService.roleUser(parameter);
		  JSONObject obj=new JSONObject();
		  obj.put("rows", list);
		  this.ajaxData(response, obj.toJSONString());
	  }
	  /**
	   * 保存绑定登陆信息
	   * @author chenhb
	   * @create_time  2015-8-18 上午11:38:03
	   * @param request
	   * @param response
	   * @param loginId
	   * @throws Exception
	   */
	  @RequestMapping("saveUser.do")
	  public  void saveLogin(HttpServletRequest request, HttpServletResponse response,String[] userId) throws Exception{
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  List<String> list=new ArrayList<String>();
		  list.add(parameter.get("roleId").toString());
		  Map<String,Object> parame=new HashMap<String, Object>();
		  parame.put("list", list);
		  parame.put("flag", userMap.get("flag"));
		  roleUserService.delete(parame);//删除之前绑定的
		  
		  if(userId==null || userId.length==0){
//			  this.ajaxMessage(response, Syscontants.ERROE,"保存失败，至少选择一个用户信息。");
			  this.ajaxMessage(response, Syscontants.MESSAGE,"保存成功");
			  return;
		  }
		  List<Map<String,Object>> res=new ArrayList<Map<String,Object>>();
		  for(String user:userId){
			  Map<String,Object> map=new HashMap<String, Object>();
			  map.put("id", SqlUtil.uuid());
			  map.put("roleId", parameter.get("roleId"));
			  map.put("userId", user);
			  res.add(map);
		  }
		  parameter.put("list", res);
		  roleUserService.add(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE,"保存成功");
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
		  Map<String,Object>  res = this.roleService.load(parameter);
		  model.addAttribute("vo", res);
		  return "forward:add.do";
	  }
	  
	  /**
	   * 保存后台的菜单
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
			  parameter.put("createTime", ExtendDate.getYMD_h_m_s(new Date()));
			  parameter.put("updateTime", ExtendDate.getYMD_h_m_s(new Date()));
			  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			  parameter.put("creator", user.get("id"));
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  parameter.put("id", n_parameter.get("id"));
			  //添加菜单
			  this.roleService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
			  parameter.put("updateTime", ExtendDate.getYMD_h_m_s(new Date()));
			  this.roleService.update(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"修改成功");
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
		  Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前用户
		  parameter.put("creator", user.get("id"));
		  JSONObject jsonObj = this.roleService.findPageBean(parameter);
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
		  this.roleService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
  /**
	 *更新数据状态
	 * @param request
	 * @param response
	 */
	  @RequestMapping("changeStatus")
		public void changeStatus(HttpServletRequest request,HttpServletResponse response){
			Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
			Object obj=parameter.get("status");
			if("禁用".equals(obj)){
				 this.ajaxMessage(response, Syscontants.MESSAGE,"启用成功");
				 parameter.put("status", "启用");
			}else{
				 parameter.put("status", "禁用");
				this.ajaxMessage(response, Syscontants.MESSAGE,"禁用成功");
			}
			this.roleService.changeStatus(parameter);
		}
	
}
