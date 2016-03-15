
package com.go.controller.resources;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.DateUtil;
import com.go.common.util.ExtendDate;
import com.go.common.util.JSONUtil;
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.resources.AbsoluteManagementService;
import com.go.service.resources.AssessPicService;
import com.go.service.resources.FileManagementService;
import com.go.service.resources.FolderSharedService;
import com.go.service.resources.SharedRoleService;
import com.go.service.resources.TopFolderService;
/**
 * 文件管理
 * @author chenhb
 * @create_time  2015-11-18 上午11:25:38
 */
@Controller
@RequestMapping("/resources/fileManagement")
public class FileManagementController extends BaseController {
	  @Resource
	  private  FileManagementService  fileManagementService;
	  @Resource
	  private  AbsoluteManagementService  absoluteManagementService;
	  @Resource
	  private  FolderSharedService  folderSharedService;
	  @Resource
	  private  SharedRoleService  sharedRoleService;
	  @Resource
	  private  TopFolderService  topFolderService;
	  @Resource
	  private  AssessPicService  assessPicService;
	  
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  List<Map<String,Object>> schoolList=new ArrayList<Map<String,Object>>();//学校文件夹list
		  if(!"管理员账号".equals(user.get("type"))){//非管理员
			  /**
			   * 通过查询共享顶级资源文件
			   */
			  Map<String,Object> params=new HashMap<String, Object>();
			  params.put("userId", user.get("id"));
			  schoolList=fileManagementService.findShareSchoolFolder(params);//顶级文件为top_folder
		  }else{
			  /**
			   * 管理员账号查询所有顶级资源文件夹
			   */
			  Map<String,Object> parame=new HashMap<String, Object>();
			  parame.put("type", "资源文件夹");
			  schoolList=topFolderService.findAll(parame);
		  }
		  model.addAttribute("schoolList", schoolList);
		  return  "admin/resources/fileManagement/departList";
	  }
	  /**
	   * 管理页面
	   * @author chenhb
	   * @create_time  2015-11-18 下午1:58:59
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("management.do")
	  public String management(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  model.addAttribute("vo", parameter);
		  Map<String,Object> pvo=new HashMap<String, Object>();
		  pvo.put("id", parameter.get("parentId"));
		  pvo=topFolderService.findTopFolder(pvo);//顶级文件夹（科室文件夹，学校文件夹，文件夹）
		  if(pvo==null){
			  return "admin/resources/fileManagement/list";
		  }
		  model.addAttribute("pvo", pvo);
		  /*Map<String,Object> assessPic=new HashMap<String, Object>();
		  assessPic.put("loginId", user.get("id"));
		  assessPic.put("topFileId", pvo.get("topFileId"));
		  assessPic=assessPicService.findOne(assessPic);
		  if(assessPic!=null){
			  return  "admin/resources/fileManagement/list";
		  }*/
		  
		  if(!"管理员账号".equals(user.get("type"))){//非管理员
			  //获取得到共享的文件夹列表
			  parameter.put("userId", user.get("id"));
			  List<Map<String,Object>> sharedList=fileManagementService.findShared(parameter);
			  Map<String,Object> res=new HashMap<String, Object>();
			  for(Map<String,Object> shared:sharedList){
				  String type=shared.get("type").toString();
				  res.put(type, "1");
			  }
			  model.addAttribute("resType", res);
		  }
		  return  "admin/resources/fileManagement/list";
	  }
	  /**
	   * 排序
	   * @author chenhb
	   * @create_time  2015-11-18 下午5:32:28
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("seq.do")
	  public String seq(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  model.addAttribute("vo", parameter);
		  List<Map<String,Object>> list = this.fileManagementService.findAll(parameter);
		  model.addAttribute("list", list);
		  return  "admin/resources/fileManagement/seq";
	  }
	  /**
	   * 添加数据页面
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  model.addAttribute("vo", parameter);
		  return  "admin/resources/fileManagement/edit";
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
		  Map<String,Object>  res = this.fileManagementService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/resources/fileManagement/edit";
	  }
	  /**
	   * 文件夹共享
	   * @author chenhb
	   * @create_time  2015-11-20 上午9:55:33
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("share.do")
	  public  String share(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> vo=new HashMap<String, Object>();
		  vo.put("fileId", parameter.get("parentId"));//当前文件夹Id
		  vo.put("creator", userMap.get("id"));
		  vo.put("topFileId", parameter.get("topFileId"));
		  vo = this.folderSharedService.findOne(vo);
		  if(vo==null || vo.size()==0){
			  vo=new HashMap<String, Object>();
			  vo.put("fileId", parameter.get("parentId"));
		  }else{
			  vo.put("sharedId", vo.get("id"));
			  List<Map<String,Object>> shareRoleList=sharedRoleService.findAll(vo);
			  Map<String,List<Map<String,Object>>> map=new HashMap<String, List<Map<String,Object>>>();
			  map.put("只读", new ArrayList<Map<String,Object>>());
			  map.put("可添加", new ArrayList<Map<String,Object>>());
			  map.put("可新建文件夹", new ArrayList<Map<String,Object>>());
			  map.put("可修改（覆盖）", new ArrayList<Map<String,Object>>());
			  map.put("可删除", new ArrayList<Map<String,Object>>());
			  StringBuffer roles_read=new StringBuffer("");
			  StringBuffer roles_add=new StringBuffer("");
			  StringBuffer roles_addFolder=new StringBuffer("");
			  StringBuffer roles_modify=new StringBuffer("");
			  StringBuffer roles_delete=new StringBuffer("");
			  for(Map<String,Object> shareRole:shareRoleList){
				  String type=shareRole.get("type")+"";
				  map.get(type).add(shareRole);
				  if(shareRole.get("roleId")!=null){
					  if("只读".equals(type)){
						  roles_read.append(shareRole.get("roleId")+",");
					  }else if("可添加".equals(type)){
						  roles_add.append(shareRole.get("roleId")+",");
					  }else if("可新建文件夹".equals(type)){
						  roles_addFolder.append(shareRole.get("roleId")+",");
					  }else if("可修改（覆盖）".equals(type)){
						  roles_modify.append(shareRole.get("roleId")+",");
					  }else if("可删除".equals(type)){
						  roles_delete.append(shareRole.get("roleId")+",");
					  }
				  }
			  }
			  model.addAttribute("shareRoleMap", map);
			  vo.put("roles_read", roles_read);
			  vo.put("roles_add", roles_add);
			  vo.put("roles_addFolder", roles_addFolder);
			  vo.put("roles_modify", roles_modify);
			  vo.put("roles_delete", roles_delete);
		  }
		  vo.put("topFileId", parameter.get("topFileId"));
		  model.addAttribute("vo", vo);
		  return  "admin/resources/fileManagement/share";
	  }
	  /**
	   * 保存共享
	   * @author chenhb
	   * @create_time  2015-11-20 下午12:08:33
	   * @param request
	   * @param response
	   * @throws Exception
	   */
	  @RequestMapping("saveShare.do")
	  public  void saveShare(HttpServletRequest request, HttpServletResponse response,String[] type,String[] roles_read,String[] roles_add,String[] roles_addFolder,String[] roles_modify,String[] roles_delete) throws Exception{
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  List<Map<String,Object>> shareRoleList=new ArrayList<Map<String,Object>>();
		  Object status=parameter.get("status");
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  String id="";
		  if(isIDNull){//新增
			  id=SqlUtil.uuid();
			  parameter.put("id", id);
		  }else{//修改
			  id=parameter.get("id")+"";
		  }
		  if("所有人可见".equals(status)){//所有人可见处理
			  if(type==null || type.length==0){
				  this.ajaxMessage(response, Syscontants.ERROE,"请指定访问权限。");
				  return;
			  }
			  for(String str:type){
				  Map<String,Object> shareRole=new HashMap<String, Object>();
				  shareRole.put("id", SqlUtil.uuid());
				  shareRole.put("sharedId", id);
				  shareRole.put("type", str);
				  shareRoleList.add(shareRole);
			  }
		  }else if("指定角色可见".equals(status)){//指定角色可见处理
			  if(type==null || type.length==0){
				  this.ajaxMessage(response, Syscontants.ERROE,"请指定访问权限。");
				  return;
			  }
			  boolean ok=false;
			  for(String str:type){
				  if("只读".equals(str)){
					  if(roles_read!=null && roles_read.length>0){
						  for(String role:roles_read){
							  if("".equals(role)){
								  continue;
							  }
							  Map<String,Object> shareRole=new HashMap<String, Object>();
							  shareRole.put("id", SqlUtil.uuid());
							  shareRole.put("sharedId", id);
							  shareRole.put("roleId", role);
							  shareRole.put("type", str);
							  shareRoleList.add(shareRole);
						  }
					  }else{
						  this.ajaxMessage(response, Syscontants.ERROE,"请为只读权限添加角色。");
						  return;
					  }
				  }else if("可添加".equals(str)){
					  if(roles_add!=null && roles_add.length>0){
						  for(String role:roles_add){
							  if("".equals(role)){
								  continue;
							  }
							  Map<String,Object> shareRole=new HashMap<String, Object>();
							  shareRole.put("id", SqlUtil.uuid());
							  shareRole.put("sharedId", id);
							  shareRole.put("roleId", role);
							  shareRole.put("type", str);
							  shareRoleList.add(shareRole);
						  }
					  }else{
						  this.ajaxMessage(response, Syscontants.ERROE,"请为可添加权限添加角色。");
						  return;
					  }
				  }else if("可新建文件夹".equals(str)){
					  if(roles_addFolder!=null && roles_addFolder.length>0){
						  for(String role:roles_addFolder){
							  if("".equals(role)){
								  continue;
							  }
							  Map<String,Object> shareRole=new HashMap<String, Object>();
							  shareRole.put("id", SqlUtil.uuid());
							  shareRole.put("sharedId", id);
							  shareRole.put("roleId", role);
							  shareRole.put("type", str);
							  shareRoleList.add(shareRole);
						  }
					  }else{
						  this.ajaxMessage(response, Syscontants.ERROE,"请为可新建文件夹权限添加角色。");
						  return;
					  }
				  }else if("可修改（覆盖）".equals(str)){
					  if(roles_modify!=null && roles_modify.length>0){
						  for(String role:roles_modify){
							  if("".equals(role)){
								  continue;
							  }
							  Map<String,Object> shareRole=new HashMap<String, Object>();
							  shareRole.put("id", SqlUtil.uuid());
							  shareRole.put("sharedId", id);
							  shareRole.put("roleId", role);
							  shareRole.put("type", str);
							  shareRoleList.add(shareRole);
						  }
					  }else{
						  this.ajaxMessage(response, Syscontants.ERROE,"请为可修改（覆盖）权限添加角色。");
						  return;
					  }
				  }else if("可删除".equals(str)){
					  if(roles_delete!=null && roles_delete.length>0){
						  for(String role:roles_delete){
							  if("".equals(role)){
								  continue;
							  }
							  Map<String,Object> shareRole=new HashMap<String, Object>();
							  shareRole.put("id", SqlUtil.uuid());
							  shareRole.put("sharedId", id);
							  shareRole.put("roleId", role);
							  shareRole.put("type", str);
							  shareRoleList.add(shareRole);
						  }
					  }else{
						  this.ajaxMessage(response, Syscontants.ERROE,"请为可删除权限添加角色。");
						  return;
					  }
				  }
			  }
		  }else if("不共享".equals(status)){
		  }
		  if(isIDNull){
			  //设置ID
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  parameter.put("creator", userMap.get("id"));
			  //添加菜单
			  this.folderSharedService.add(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"共享成功");
		  }else{
			  this.folderSharedService.update(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"共享成功");
		  }
		  List<String> ids=new ArrayList<String>();
		  ids.add(id);
		  sharedRoleService.delete(ids);
		  if(shareRoleList!=null && shareRoleList.size()>0){
			  parameter.put("list", shareRoleList);
			  sharedRoleService.addAll(parameter);
		  }
	  }
	  /**
	   * 异步导出
	   * @author chenhb
	   * @create_time  2015-11-18 下午4:53:28
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("loadByAjax.do")
	  public  void loadByAjax(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object>  res = this.fileManagementService.load(parameter);
		  if(res==null || res.size()==0){
			  //TODO 
//			  res=departService.load(parameter);
			  res=topFolderService.findTopFolder(parameter);//顶级文件夹（科室文件夹，学校文件夹，文件夹）
		  }
		  this.ajaxData(response, JSONUtil.objToJSonStr(res));
	  }
	  /**
	   * 保存
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("save.do")
	  public  void save(HttpServletRequest request, HttpServletResponse response) throws Exception{
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  parameter.put("type", "文件夹");//文件夹类型
			  Map<String,Object> depart=new HashMap<String, Object>();
			  depart.put("id", parameter.get("topFileId"));
//			  depart=departService.load(depart);//查询顶级文件
			  depart=topFolderService.findTopFolder(depart);//查询顶级文件
			  
			  Map<String,Object> absolute=new HashMap<String, Object>();
			  absolute.put("topFileId", parameter.get("topFileId"));
			  absolute=absoluteManagementService.findOne(absolute);//查询顶级文件绑定绝对地址
			  if(absolute==null || absolute.size()==0){
				  this.ajaxMessage(response, Syscontants.ERROE, "顶级文件必须绑定地址。");
				  return ;
			  }
			  
			  Map<String,Object> pvo=new HashMap<String, Object>();
			  pvo.put("id", parameter.get("parentId"));
			  pvo=fileManagementService.load(pvo);//查询父文件
			  if(pvo==null || pvo.size()==0){
				  parameter.put("relativeUrl", depart.get("name")+"/"+parameter.get("name"));
				  parameter.put("absoluteId", absolute.get("id"));
			  }else{
				  parameter.put("relativeUrl", pvo.get("relativeUrl")+"/"+pvo.get("name")+"/"+parameter.get("name"));
				  parameter.put("absoluteId", absolute.get("id"));
			  }
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  n_parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  n_parameter.put("creator", userMap.get("id"));
			  //添加菜单
			  this.fileManagementService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
			  
		  }else{
			  Map<String,Object>  historyMap = this.fileManagementService.load(parameter);
			  String historyRelativeUrl=historyMap.get("relativeUrl")+"";
			  String historyName=historyMap.get("name")+"";
			  String hUrl=historyRelativeUrl.substring(0, historyRelativeUrl.lastIndexOf(historyName));
			  parameter.put("historyRelativeUrl", historyRelativeUrl);
			  parameter.put("nowUrl", hUrl+parameter.get("name"));
			  parameter.put("modifydate", ExtendDate.getYMD_h_m_s(new Date()));
			  parameter.put("modifier", userMap.get("id"));
			  String msg=this.fileManagementService.update(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,StringUtils.isBlank(msg)?"修改成功":msg);
		  }
	  }
	  /**
	   * 保存排序
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("saveSeq.do")
	  public  void saveSeq(HttpServletRequest request, HttpServletResponse response) throws Exception{
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  if(parameter==null || parameter.size()==0){
			  this.ajaxMessage(response, Syscontants.ERROE, "没有文件无需排序。");
			  return;
		  }
		  List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		  Iterator<String> it=parameter.keySet().iterator();
		  while(it.hasNext()){
			  String key=it.next();
			  Map<String,Object> map=new HashMap<String, Object>();
			  map.put("id", key);
			  map.put("seq", parameter.get(key));
			  list.add(map);
		  }
		  fileManagementService.updateSeq(list);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "排序成功");
	  }
	  /**
	   * 查询列表
	   * @param request
	   * @param response
	   */ 
	  @RequestMapping("list.do")
	  public  void  findList(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  JSONObject jsonObj = this.fileManagementService.findPageBean(parameter);
		  this.ajaxData(response, jsonObj.toJSONString());
	  }
	  /**
	   * 文件夹树
	   * @author chenhb
	   * @create_time  2015-11-26 上午9:29:21
	   * @param request
	   * @param response
	   * @param model
	   */
	  @RequestMapping("folderTree.do")
	  public  void  folderTree(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  parameter.put("type", "文件夹");
		  List<Map<String,Object>> list = this.fileManagementService.findTree(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
	  }
	  
	  /**
	   * 查询共享列表数据
	   * @author zhangjf
	   * @create_time 2015-11-21 上午9:30:43
	   * @param request
	   * @param response
	   * @param model
	   */
	  @RequestMapping("shareList.do")
	  public  void  shareList(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  parameter.put("userId", userMap.get("id"));
		  JSONObject jsonObj = this.fileManagementService.sharePageBean(parameter);
		  this.ajaxData(response, jsonObj.toJSONString());
	  }
	  
	  /**
	   * 删除数据
	   * @param request
	   * @param response
	   */
	  @RequestMapping("delete.do")
	  public  void  delete(HttpServletRequest request, HttpServletResponse response){
		  Map<String,Object> parameter=sqlUtil.queryParameter(request);
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  List<String> list = sqlUtil.getIdsParameter(request);
		  parameter.put("list", list);
		  parameter.put("deleter", userMap.get("id"));
		  parameter.put("modifydate", ExtendDate.getYMD_h_m_s(new Date()));
		  this.fileManagementService.deleteStatus(parameter);
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
			this.fileManagementService.changeStatus(parameter);
		}
	  
	  /**
	   * 跳转到上传页面
	   * @author zhangjf
	   * @create_time 2015-11-18 下午5:25:37
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("toUpload.do")
	  public String toUpload(HttpServletRequest request,HttpServletResponse response,ModelMap model){
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  model.addAttribute("vo", parameter);
		  return "admin/resources/fileManagement/upload";
	  }
	  
	  /**
	   * 服务器导入页面
	   * @author zhangjf
	   * @create_time 2015-11-19 上午11:53:52
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("toImport.do")
	  public String toImport(HttpServletRequest request,HttpServletResponse response,ModelMap model){
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  model.addAttribute("vo", parameter);
		  return "admin/resources/fileManagement/import";
	  }
	  
	  /**
	   * 服务器端导入操作
	   * @author zhangjf
	   * @create_time 2015-11-19 下午12:05:28
	   * @param request
	   * @param response
	   */
	  @RequestMapping("serverImport.do")
	  public void serverImport(HttpServletRequest request,HttpServletResponse response){
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Object serverPath=parameter.get("serverPath");
		  if(serverPath==null){
			  	this.ajaxMessage(response, Syscontants.ERROE, "请填写需要导入文件夹路径");
				return; 
		  }
		  List<Map<String,Object>> fileList=new ArrayList<Map<String,Object>>();//保存文件管理集合
		  /**
			 * 第一步:根据上一层文件夹ID获取路径;若不存在则根据顶级ID创建目录
			 */
			Map<String,Object> params=new HashMap<String, Object>();
			params.put("id", parameter.get("parentId"));
			Map<String,Object> parentPath=fileManagementService.load(params);
			Map<String,Object> topPath=null;
			String relativeUrl="";//相对地址
			Object absoluteId=null;
			if(parentPath==null||parentPath.isEmpty()){
				topPath=absoluteManagementService.findOne(parameter);
				if(topPath==null||topPath.isEmpty()){
					this.ajaxMessage(response, Syscontants.ERROE, "请先在路径管理配置科室文件夹路径！");
					return;
				}
				params.put("id", topPath.get("topFileId"));
//				Map<String,Object> departMap=departService.load(params);
				Map<String,Object> departMap=topFolderService.findTopFolder(params);
				if(departMap==null||departMap.isEmpty()){//校验部门是否存在
					this.ajaxMessage(response, Syscontants.ERROE, "操作非法,请稍后重试！");
					return;
				}
				//path+=departPath+"/"+departMap.get("name");//获取绝对路径拼接串
				relativeUrl=departMap.get("name")+"";//获取相对路径拼接串
				absoluteId=topPath.get("id");
			}else{
				topPath=absoluteManagementService.findOne(parentPath);
				if(topPath==null||topPath.isEmpty()){
					this.ajaxMessage(response, Syscontants.ERROE, "操作非法,请稍后重试！");
					return;
				}
				//path+=topPath.get("absoluteUrl")+"/"+parentPath.get("relativeUrl")+"";//获取绝对路径拼接串
				relativeUrl=parentPath.get("relativeUrl")==null?"":parentPath.get("relativeUrl")+"";//获取相对路径拼接串
				absoluteId=parentPath.get("absoluteId");
			}
			
			 Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			 String currentTime=DateUtil.getCurrentTime();
			 params=new HashMap<String, Object>();
			 params.putAll(parameter);
			 params.put("absoluteId", absoluteId);
			 params.put("creator", userMap.get("id"));
			 params.put("createdate", currentTime);
			 params.remove("parentId");
			 if(!serverPath.toString().contains(File.separator)){
				 this.ajaxMessage(response, Syscontants.ERROE, "导入路径有误");
				 return;
			 }
			 File file= new File(serverPath+"");
				/**
				 * 第二步:根据导入路径获取文件和文件夹相关的列表集合
				 */
			 String splitPath=file.getAbsolutePath();
			// System.out.println(splitPath.substring(splitPath.lastIndexOf("\\")+1, splitPath.length()));
			 String folderName=splitPath.substring(splitPath.lastIndexOf("\\")+1, splitPath.length());
			 Map<String, Object> t_params=new HashMap<String, Object>();
			 t_params.put("name", folderName);
			 t_params.put("parentId", parameter.get("parentId"));
			 Map<String,Object> alreadyMap=fileManagementService.findOne(t_params);
			 if(alreadyMap!=null&&!alreadyMap.isEmpty()){
				 this.ajaxMessage(response, Syscontants.ERROE, "当前目录"+folderName+"已经存在");
				 return;
			 }
			 Util.fileList(file, splitPath.substring(0, splitPath.lastIndexOf("\\")), fileList, parameter.get("parentId")+"", relativeUrl, params);
			if(!fileList.isEmpty()){
				int len=fileList.size();
				int step=1000;
				if(len>1000){//超过1000进行分割操作
					int count=(len%step)==0?(len/step):(len/step)+1;
					 List<Map<String,Object>> subList=null;
					for (int i = 1; i <= count; i++) {
						   if ((len%step)==0)
				            {
							   subList = fileList.subList((i-1)*step,step*(i));
							   
				            }
				            else
				            {
				             if (i==count)
				             {
				                 subList= fileList.subList((i-1)*step,len); 
				             }
				             else
				             {
				                 subList= fileList.subList((i-1)*step,step*(i));
				             }
					}
						   params=new HashMap<String, Object>();
						   params.put("list", subList);
						   fileManagementService.addAll(params);
					
				}
				}else{
					params=new HashMap<String, Object>();
					params.put("list", fileList);
					fileManagementService.addAll(params);
				}
				
			}
			this.ajaxMessage(response, Syscontants.MESSAGE, "导入成功");
	  }
	  
	  /**
	   * 检测文件夹重名
	   * @author chenhb
	   * @create_time  2015-11-25 上午9:11:31
	   * @param request
	   * @param response
	   */
	  @RequestMapping("checkName.do")
		public void checkName(HttpServletRequest request,HttpServletResponse response){
			Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
			Object id=parameter.get("id");
			Map<String,Object> n_parameter=new HashMap<String,Object>();
			n_parameter.put("name", parameter.get("name"));
			n_parameter.put("parentId", parameter.get("parentId"));
			 Map<String,Object>  res = this.fileManagementService.findOne(n_parameter);
			 if(res==null || res.size()==0){//不存在
				 this.ajaxMessage(response, Syscontants.MESSAGE,"文件夹名称不存在");
			 }else{
				 if(id==null || "".equals(id)){
					 this.ajaxMessage(response, Syscontants.ERROE,"文件夹名称存在");
				 }else{
					 if(id.equals(res.get("id"))){
						 this.ajaxMessage(response, Syscontants.MESSAGE,"文件夹名称不存在");
					 }else{
						 this.ajaxMessage(response, Syscontants.ERROE,"文件夹名称存在");
					 }
				 }
			 }
		}
	  
	  /**
	   * 文件下载功能
	   * @author zhangjf
	   * @create_time 2015-11-27 下午2:22:03
	   * @param request
	   * @param response
	   */
	  @RequestMapping("download.do")
	  public void download(HttpServletRequest request,HttpServletResponse response){
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> fileMap=fileManagementService.load(parameter);
		  Map<String,Object> topPath=null;
		  if(fileMap!=null&&!fileMap.isEmpty()){
			  Object absoluteUrl=fileMap.get("absoluteUrl");
			  if(absoluteUrl!=null){//若为服务器端导入则根据绝对路径进行数据导出
				  fileDownLoad(absoluteUrl+"", fileMap.get("name")+"", response);
			  }else{
				  topPath=absoluteManagementService.findOne(fileMap);
				  String path=topPath.get("absoluteUrl")+"/"+fileMap.get("relativeUrl");
				  fileDownLoad(path, fileMap.get("name")+"", response);
			  }
		  }else{
			  response.setCharacterEncoding("UTF-8");
			  response.setContentType("text/html");
			 PrintWriter pw;
			try {
				pw = response.getWriter();
				 pw.write("<span style='color:red;font-size:16px;'>下载的文件不存在或已删除</span>");
				 pw.close();
				 return;
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		  }
	  }
	  /**
	   * 文件下载方法
	   * @author zhangjf
	   * @create_time 2015-10-22 下午1:52:26
	   * @param path
	   * @param title
	   * @param response
	   */
	  private void fileDownLoad(String path,String title, HttpServletResponse response){
		  File file = new File(path);// path是根据日志路径和文件名拼接出来的
		  if(!file.exists()){
			  response.setCharacterEncoding("UTF-8");
			  response.setContentType("text/html");
			 PrintWriter pw;
			try {
				pw = response.getWriter();
				 pw.write("<span style='color:red;font-size:16px;'>下载的文件不存在或已删除</span>");
				 pw.close();
				 return;
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		  }
		  String filename = file.getName();// 获取日志文件名称
		  OutputStream os =null;
		  InputStream fis =null;
		   try {
			 //  String[] suff = filename.split("\\.");
			  // filename=title+"."+suff[suff.length-1];
			    fis = new BufferedInputStream(new FileInputStream(path));
			    byte[] buffer = new byte[fis.available()];
			    fis.read(buffer);
			    fis.close();
			    response.reset();
			    // 先去掉文件名称中的空格,然后转换编码格式为utf-8,保证不出现乱码,这个文件名称用于浏览器的下载框中自动显示的文件名
			    response.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.replaceAll(" ", "").getBytes("utf-8"),"iso8859-1"));
			    response.addHeader("Content-Length", "" + file.length());
			     os = new BufferedOutputStream(response.getOutputStream());
			    response.setContentType("application/octet-stream");
			    os.write(buffer);// 输出文件
			    os.flush();
			    os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				if(fis!=null){
					fis.close();
				}
				if(os!=null){
					os.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}  
	}
	  
	  /**
	   * 查看图片
	   * @author chenhb
	   * @create_time  2015-11-30 上午11:24:27
	   * @param request
	   * @param response
	   * @throws Exception
	   */
	  @RequestMapping("lookImg.do")
	  public  synchronized void lookImg(HttpServletRequest request, HttpServletResponse response) throws Exception{
		  Map<String,Object> parameter=sqlUtil.queryParameter(request);
		  Map<String,Object> vo=fileManagementService.load(parameter);
		  if(vo==null){
			  return;
		  }
		  String absoluteUrl="";
		  if(vo.get("absoluteUrl")==null){
			  Map<String,Object> absolute=absoluteManagementService.findOne(vo);
			  absoluteUrl=absolute.get("absoluteUrl").toString()+"/"+vo.get("relativeUrl").toString()+"/"+vo.get("name");
		  }else{
			  absoluteUrl=vo.get("absoluteUrl").toString();
		  }
			File  ifile = new File(absoluteUrl);
			if(!ifile.exists()){
				return;
			}
			FileInputStream in = new FileInputStream(ifile);
			// 设置页面不缓 ?
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
			response.setContentType(" image/x-png");
			response.setCharacterEncoding("UTF-8");
			BufferedImage  image = ImageIO.read(in);
	    	try {
	    		String end=vo.get("suffix").toString();
				ImageIO.write(image, end.substring(1, end.length()), response.getOutputStream());
			} catch (IOException e) {
				e.printStackTrace();
			}finally{
				response.getOutputStream().flush();
				response.getOutputStream().close();
			}
		}
	  
	  /**
	   * xls文件转成字符串
	   * @author chenhb
	   * @create_time  2015-11-30 上午11:57:19
	   * @param request
	   * @param response
	   * @throws IOException
	   * @throws Exception
	   */
	  @RequestMapping("lookExcel.do")
	  public  String   lookExcel(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws IOException, Exception{
		  Map<String,Object> parameter=sqlUtil.queryParameter(request);
		  Map<String,Object> vo=fileManagementService.load(parameter);
		  if(vo==null){
			  return "admin/resources/fileManagement/lookHtml";
		  }
		  String absoluteUrl="";
		  if(vo.get("absoluteUrl")==null){
			  Map<String,Object> absolute=absoluteManagementService.findOne(vo);
			  absoluteUrl=absolute.get("absoluteUrl").toString()+"/"+vo.get("relativeUrl").toString()+"/"+vo.get("name");
		  }else{
			  absoluteUrl=vo.get("absoluteUrl").toString();
		  }
			File  ifile = new File(absoluteUrl);
			if(!ifile.exists()){
				return "admin/resources/fileManagement/lookHtml";
			}
			InputStream is =new FileInputStream(ifile);
			String suffix=vo.get("suffix").toString();
        	if(".xls".equals(suffix.toLowerCase())){
        		//TODO chenhb 注释
        		/*List<String[]> list=Util.ExcelToList(is);
        		StringBuffer sb=new StringBuffer("<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"border-collapse: collapse;\">");
        		for(String[] arr:list){
        			sb.append("<tr>");
        			for(String str:arr){
        				sb.append("<td>"+str+"</td>");
        			}
        			sb.append("</tr>");
        		}
        		sb.append("</table>");
        		model.addAttribute("content", sb.toString());*/
        	}
        	return "admin/resources/fileManagement/lookHtml";
		}
	  /**
	   * 查看word文件
	   * @author chenhb
	   * @create_time  2015-11-30 下午2:18:56
	   * @param request
	   * @param response
	   * @throws IOException
	   * @throws Exception
	   */
	  @RequestMapping("lookWord.do")
	  public  void   lookWord(HttpServletRequest request, HttpServletResponse response) throws IOException, Exception{
		  Map<String,Object> parameter=sqlUtil.queryParameter(request);
		  Map<String,Object> vo=fileManagementService.load(parameter);
		  if(vo==null){
			  return ;
		  }
		  String absoluteUrl="";
		  if(vo.get("absoluteUrl")==null){
			  Map<String,Object> absolute=absoluteManagementService.findOne(vo);
			  absoluteUrl=absolute.get("absoluteUrl").toString()+"/"+vo.get("relativeUrl").toString()+"/"+vo.get("name");
		  }else{
			  absoluteUrl=vo.get("absoluteUrl").toString();
		  }
			File  ifile = new File(absoluteUrl);
			if(!ifile.exists()){
				return;
			}
			String suffix=vo.get("suffix").toString();
        	if(".doc".equals(suffix.toLowerCase())){
        		  /**得到图片保存目录的真实路径**/      
                String logoRealPathDir = request.getSession().getServletContext().getRealPath("admin/fileLook");     
                /**根据真实路径创建目录**/      
                File logoSaveFile = new File(logoRealPathDir);       
                if(!logoSaveFile.exists())       
                   logoSaveFile.mkdirs();             
        		File f=new File(logoRealPathDir+"/"+vo.get("id")+".html");
                if(f.exists()){//存在
                	this.ajaxMessage(response, Syscontants.MESSAGE, "admin/fileLook/"+vo.get("id")+".html");
                	return ;
                }
                File file=new File(absoluteUrl);
              //TODO chenhb 注释
//        		Word2Html.convert1(file, f.getPath());
        		//file.delete();
        		this.ajaxMessage(response, Syscontants.MESSAGE, "admin/fileLook/"+vo.get("id")+".html");
        	}
		}
}
