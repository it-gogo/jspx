
package com.go.controller.baseinfo;

import java.io.IOException;
import java.io.OutputStream;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.ExtendDate;
import com.go.common.util.ImportInfo;
import com.go.common.util.JSONUtil;
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.UnitInfoService;
import com.go.service.platform.UserInfoService;
/**
 * 单位组织机构管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/baseinfo/unitInfo")
public class UnitInfoController extends BaseController {
	  @Resource
	  private  UnitInfoService  unitInfoService;
	  @Resource
	  private  UserInfoService  userInfoService;
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/baseinfo/unitInfo/list";
	  }
	  
	  /**
	   * 不分页查询
	   * @author chenhb
	   * @create_time {date} 下午3:09:05
	   * @param request
	   * @param response
	   * @param model
	   */
	  @RequestMapping("findAll.do")
	  public  void findAll(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  Map<String,Object> unitInfo=new HashMap<String, Object>();
		  unitInfo.put("userId", userMap.get("id"));
		  unitInfo=this.unitInfoService.findOne(unitInfo);
		  if(unitInfo!=null){
			  parameter.put("flag", unitInfo.get("flag"));
		  }
		  List<Map<String,Object>> list=unitInfoService.findAll(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
	  }
	  /**
	   * 
	   * @author chenhb
	   * @create_time {date} 上午10:52:09
	   * @param request
	   * @param response
	   * @param tempName
	   * @throws IOException
	 * @throws Exception 
	   */
	  @RequestMapping("batchPassword.do")  
	  public void batchPassword(HttpServletRequest request, HttpServletResponse response) throws  Exception {  
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  if(!parameter.containsKey("type")){
			  parameter.put("type", "2");
		  }
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  Map<String,Object> unitInfo=new HashMap<String, Object>();
		  unitInfo.put("userId", userMap.get("id"));
		  unitInfo=this.unitInfoService.findOne(unitInfo);
		  if(unitInfo!=null){
			  if(!parameter.containsKey("flag")){
				  parameter.put("flag", unitInfo.get("flag"));
			  }
			  if(!parameter.containsKey("type")){
				  parameter.put("type", unitInfo.get("type"));
			  }
		  }
		  String[] header={"学校名称","学校代码","管理账号","管理密码",};
		  List<Map<String,Object>> list = this.unitInfoService.findAll(parameter);
		  List<String[]> res=new ArrayList<String[]>();
		  String chars = "abcdefghijklmnopqrstuvwxyz";

		  for(Map<String,Object> map:list){
			  int n1=(int) (Math.random() * 10);
			  int n2=(int) (Math.random() * 10);
			  int n3=(int) (Math.random() * 10);
			  int n4=(int) (Math.random() * 10);
			  char c1=chars.charAt((int)(Math.random() * 26));
			  char c2=chars.charAt((int)(Math.random() * 26));
			  
			  String name=map.get("name").toString();
			  String code=map.get("code").toString();
			  String text=map.get("text").toString();
			  String password=""+c1+n1+n2+n3+c2+n4;
			  String[] arr={name,code,text,password};
			  res.add(arr);
			  map.put("password", Util.Encryption(password));
		  }
		  
	      OutputStream os = response.getOutputStream();  
	      String tempName=ExtendDate.getYMD_h_m_s(new Date())+".xls";
	      try {  
	    	  response.reset();  
	    	  response.setHeader("Content-Disposition", "attachment; filename="+tempName);  
	    	  response.setContentType("application/octet-stream; charset=utf-8");
	    	  Util.createExcel(os, header, res);
	          os.flush();  
	          unitInfoService.batchPassword(list);
	      } finally {  
	          if (os != null) {  
	              os.close();  
	          }  
	      }  
	  }
	  /**
	   * 导入老师信息
	   * @author chenhb
	   * @create_time {date} 上午9:11:46
	   * @param request
	   * @param response
	   * @throws Exception
	   */
	  @RequestMapping("importInfo.do")
	  public void importInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		  String[]  header = new String[]{
					"名称","单位代码","学校类型","学校类别","附属单位(该单位管理导入可以为空)","管理账号","管理密码"
				};
		  
	        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
	         /**页面控件的文件流**/      
	        MultipartFile multipartFile = multipartRequest.getFile("fileId");   
	        List<String[]> list=ImportInfo.importFile(multipartFile.getInputStream(),header);
	        if(list==null){
	        	this.ajaxMessage(response, Syscontants.ERROE,"添加失败，格式错误!");
	        	return ;
	        }
	        Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
	        Map<String,Object> unitInfo=new HashMap<String, Object>();
	        unitInfo.put("userId", userMap.get("id"));
	        unitInfo=unitInfoService.findOne(unitInfo);
	        String pid=null;
	        if(unitInfo!=null){
	        	pid=unitInfo.get("id").toString();
	        }
	        String str=unitInfoService.addAll(list, pid,userMap.get("id"));
	        if(str==null || "".equals(str)){
	        	this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功!");
	        }else{
	        	this.ajaxMessage(response, Syscontants.MESSAGE,str);
	        }
	  }
	  /**
	   * 查询学校
	   * @author chenhb
	   * @create_time {date} 上午10:03:08
	   * @param request
	   * @param response
	   * @param model
	 * @throws Exception 
	   */
	  @RequestMapping("school.do")
	  public  void school(HttpServletRequest request,HttpServletResponse response,Model  model) throws Exception{
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  Map<String,Object> unitInfo=new HashMap<String, Object>();
		  unitInfo.put("userId", userMap.get("id"));
		  unitInfo=this.unitInfoService.findOne(unitInfo);
		  if(unitInfo!=null){
			  parameter.put("flag", unitInfo.get("flag"));
		  }
		  List<Map<String,Object>> list=unitInfoService.findSchool(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
	  }
	  
	  /**
	   * 菜单树(上级单位)
	   * @author chenhb
	   * @create_time {date} 上午10:03:08
	   * @param request
	   * @param response
	   * @param model
	   */
	  @RequestMapping("unitTree.do")
	  public  void unitTree(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  Map<String,Object> unitInfo=new HashMap<String, Object>();
		  unitInfo.put("userId", userMap.get("id"));
		  unitInfo=this.unitInfoService.findOne(unitInfo);
		  if(unitInfo!=null){
			  parameter.put("flag", unitInfo.get("flag"));
		  }
		  List<Map<String,Object>> list=unitInfoService.findUnitTree(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
	  }
	  
	  /**
	   * 菜单树(左边树形数据)
	   * @author chenhb
	   * @create_time {date} 上午10:03:08
	   * @param request
	   * @param response
	   * @param model
	 * @throws Exception 
	   */
	  @RequestMapping("tree.do")
	  public  void tree(HttpServletRequest request,HttpServletResponse response,Model  model) throws Exception{
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
		  return  "admin/baseinfo/unitInfo/edit";
	  }  
	  /**
	   * 添加数据页面(学校)
	   * @return
	   */
	  @RequestMapping("addSchool.do")
	  public  String addSchool(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  model.addAttribute("vo", parameter);
		  return  "admin/baseinfo/unitInfo/editSchool";
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
		  Map<String,Object>  res = this.unitInfoService.load(parameter);
		  model.addAttribute("vo", res);
		  if("1".equals(res.get("type"))){
			  return  "admin/baseinfo/unitInfo/edit";
		  }else{
			  return  "admin/baseinfo/unitInfo/editSchool";
		  }
	  }
	  
	  
	  /**
	   * 保存单位
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("saveUnit.do")
	  public  void saveUnit(HttpServletRequest request, HttpServletResponse response) throws Exception{
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			  parameter.put("creator", userMap.get("id"));
			  parameter.put("type", "1");//单位
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  
			  if(!parameter.containsKey("pid")){
				  Map<String,Object> unitInfo=new HashMap<String, Object>();
				  unitInfo.put("userId", userMap.get("id"));
				  unitInfo=this.unitInfoService.findOne(unitInfo);
				  if(unitInfo!=null)
					  parameter.put("pid", unitInfo.get("id"));
			  }
			  
			  
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			 
			  Map<String,Object> user=new HashMap<String, Object>();
			  Object userId=SqlUtil.uuid();
			  user.put("id", userId);
			  user.put("text", n_parameter.get("text"));
			  Object password=n_parameter.get("password");
			  if(password==null || "".equals(password)){
				  password="123456";
			  }
			  user.put("password", Util.Encryption(password.toString()));
//			  user.put("unitId", n_parameter.get("id"));
			  this.userInfoService.add(user);//添加用户
			  n_parameter.put("userId", userId);
			  user.put("isActives", "1");
			  this.unitInfoService.add(n_parameter);//添加
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
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
				  user.put("isActives", "1");
				  this.userInfoService.add(user);//添加用户
			  }else{
				  Map<String,Object> user=new HashMap<String, Object>();
				  user.put("id", parameter.get("userId"));
				  user=userInfoService.load(user);
				  user.put("text", parameter.get("text"));
				  userInfoService.update(user);
			  }
			  this.unitInfoService.update(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"修改成功");
		  }
	  }
	  /**
	   * 保存学校
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("saveSchool.do")
	  public  void saveSchool(HttpServletRequest request, HttpServletResponse response) throws Exception{
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			  parameter.put("creator", userMap.get("id"));
			  parameter.put("type", "2");//学校
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  //添加
			  Map<String,Object> user=new HashMap<String, Object>();
			  Object userId= SqlUtil.uuid();
			  n_parameter.put("userId", userId);
			  user.put("id", userId);
			  user.put("text", n_parameter.get("text"));
			  Object password=n_parameter.get("password");
			  if(password==null || "".equals(password)){
				  password="123456";
			  }
			  user.put("password", Util.Encryption(password.toString()));
			  user.put("isActives", "1");
			  this.userInfoService.add(user);//添加用户
			  this.unitInfoService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
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
				  user.put("isActives", "1");
				  this.userInfoService.add(user);//添加用户
			  }else{
				  Map<String,Object> user=new HashMap<String, Object>();
				  user.put("id", parameter.get("userId"));
				  user=userInfoService.load(user);
				  user.put("text", parameter.get("text"));
				  userInfoService.update(user);
			  }
			  this.unitInfoService.update(parameter);
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
		  if(!parameter.containsKey("type")){
			  parameter.put("type", "1");
		  }
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  Map<String,Object> unitInfo=new HashMap<String, Object>();
		  unitInfo.put("userId", userMap.get("id"));
		  unitInfo=this.unitInfoService.findOne(unitInfo);
		  if(unitInfo!=null){
			  if(!parameter.containsKey("flag")){
				  parameter.put("flag", unitInfo.get("flag"));
			  }
			  if(!parameter.containsKey("type")){
				  parameter.put("type", unitInfo.get("type"));
			  }
		  }
		  JSONObject jsonObj = this.unitInfoService.findPageBean(parameter);
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
		  this.unitInfoService.delete(parameter);
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
		this.unitInfoService.updatestat(parameter);
	}
}
