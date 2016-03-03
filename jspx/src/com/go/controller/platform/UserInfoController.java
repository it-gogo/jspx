package com.go.controller.platform;

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
import com.go.common.util.SysUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.TeacherInfoService;
import com.go.service.platform.UserInfoService;
/**
 * 用户管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/platform/userInfo")
public class UserInfoController extends BaseController {
	  @Resource
	  private  UserInfoService  userInfoService;
	  @Resource
	  private  TeacherInfoService  teacherInfoService;
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/platform/userInfo/list";
	  }
	  
	  /**
	   * 添加数据页面
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object> parameter=new HashMap<String,Object>();
		  Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前用户
		  return  "admin/platform/userInfo/edit";
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
		  Map<String,Object>  res = this.userInfoService.load(parameter);
		  model.addAttribute("vo", res);
		  return "forward:add.do";
	  }
	  /**
	   * 修改密码页面
	   * @author chenhb
	   * @create_time {date} 下午2:34:56
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("toModifyPW.do")
	  public  String toModifyPW(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前用户
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  parameter.put("userId", user.get("id"));
		  Map<String,Object> teacherInfo=teacherInfoService.findOne(parameter);
//		  Map<String,Object>  res = this.userInfoService.load(parameter);
		  model.addAttribute("teacherInfo", teacherInfo);
		  return  "admin/platform/userInfo/modifyInfo";
	  }
	  
	  /**
	   * 保存后台的菜单
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("save.do")
	  public  void save(HttpServletRequest request, HttpServletResponse response,String newpw) throws Exception{
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  if(newpw!=null && !"".equals(newpw)){//有输入密码
			  newpw=Util.Encryption(newpw);
		  }else{
			  Object obj=parameter.get("password");
			  if(obj==null || "".equals(obj)){//有输入密码
				  newpw=Util.Encryption("123456");
			  }else{
				  newpw=obj.toString();
			  }
		  }
		  parameter.put("password", newpw);
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  parameter.put("id", n_parameter.get("id"));
			  n_parameter.put("type", "管理员账号");
			  //添加菜单
			  this.userInfoService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
			  this.userInfoService.update(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"修改成功");
		  }
	  }
	  /**
	   * 修改密码
	   * @author chenhb
	   * @create_time {date} 下午2:33:40
	   * @param request
	   * @param response
	   * @throws Exception
	   */
	  @RequestMapping("modifyPassword.do")
	  public  void modifyPassword(HttpServletRequest request, HttpServletResponse response) throws Exception{
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  teacherInfoService.update(parameter);
		  if(parameter.containsKey("password")){
			  String password=parameter.get("password").toString();
			  if(!password.equals(parameter.get("rpw"))){
				  this.ajaxMessage(response, Syscontants.ERROE,"两次密码不统一。");
				  return;
			  }
			  parameter.put("password", Util.Encryption(password));
			  Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前用户
			  user.put("password", parameter.get("password"));
			  this.userInfoService.modifyPassword(user);
		  }
		  this.ajaxMessage(response, Syscontants.MESSAGE,"修改成功");
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
		  JSONObject jsonObj = this.userInfoService.findPageBean(parameter);
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
		  this.userInfoService.delete(parameter);
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
		this.userInfoService.updatestat(parameter);
	}
	
	@RequestMapping("checkText.do")
	public void checkText(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		Object id=parameter.get("id");
		Map<String,Object> n_parameter=new HashMap<String,Object>();
		n_parameter.put("text", parameter.get("text"));
		 Map<String,Object>  res = this.userInfoService.findOne(n_parameter);
		 if(res==null || res.size()==0){//不存在
			 this.ajaxMessage(response, Syscontants.MESSAGE,"账号不存在");
		 }else{
			 if(id==null || "".equals(id)){
				 this.ajaxMessage(response, Syscontants.ERROE,"账号存在");
			 }else{
				 if(id.equals(res.get("id"))){
					 this.ajaxMessage(response, Syscontants.MESSAGE,"账号不存在");
				 }else{
					 this.ajaxMessage(response, Syscontants.ERROE,"账号存在");
				 }
			 }
		 }
	}
}
