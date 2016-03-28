package com.go.controller.train;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


import com.alibaba.fastjson.JSONObject;
import com.go.common.util.ExtendDate;
import com.go.common.util.JSONUtil;
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.UnitInfoService;
import com.go.service.train.NoticeManagementService;
import com.go.service.train.NoticeTeacherService;
/**
 * 站内短信
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/train/noticeManagement")
public class NoticeManagementController extends BaseController {
	  @Resource
	  private  NoticeManagementService  noticeManagementService;
	  @Resource
	  private  NoticeTeacherService  noticeTeacherService;
	  @Resource
	  private UnitInfoService unitInfoService;
	  /**
	   * 查看通知
	   * @author zhangjf
	   * @create_time 2016-3-10 上午10:15:14
	   * @return
	   */
	  @RequestMapping("redirectLook.do")
	  public String redirectLook(){
		  return  "admin/train/noticeManagement/lookList";
	  }
	 
	  /**
	  * 查询列表
	  * @author zhangjf
	  * @create_time 2016-3-10 上午10:15:20
	  * @param request
	  * @param response
	  * @param model
	  */
	  @RequestMapping("lookList.do")
	  public  void  lookList(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  parameter.put("loginId", user.get("id"));
		  JSONObject jsonObj = this.noticeTeacherService.findPageBean(parameter);
		  this.ajaxData(response, jsonObj.toJSONString());
	  }
	  
	  /**
	   * 初始化
	   * @author zhangjf
	   * @create_time 2016-3-10 上午10:15:28
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/train/noticeManagement/list";
	  }
	  /**
	   * 添加数据页面
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  return  "admin/train/noticeManagement/edit";
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
		  Map<String,Object>  res = this.noticeManagementService.load(parameter);
		  parameter.clear();
		  parameter.put("noticeId", res.get("id"));
		  List<Map<String,Object>> list=noticeTeacherService.findAll(parameter);
		  if(list!=null && list.size()>0){
			  StringBuffer teacherIds=new StringBuffer();
			  for(int i=0;i<list.size();i++){
				  Map<String,Object> map=list.get(i);
				  teacherIds.append(map.get("teacherId")+",");
			  }
			  res.put("teacherIds", teacherIds.substring(0, teacherIds.length()-1));
		  }
		  model.addAttribute("vo", res);
		  return  "admin/train/office/noticeManagement/edit";
	  }
	  /**
	   * 初始化（站内短信）
	   * @author zhangjf
	   * @create_time 2016-3-10 上午10:15:38
	   * @return
	   */
	  @RequestMapping("redirectSMS.do")
	  public String redirectSMS(){
		  return  "admin/train/noticeSMS/list";
	  }
	  /**
	   * 添加数据页面
	   * @return
	   */
	  @RequestMapping("addSMS.do")
	  public  String addSMS(HttpServletRequest request,HttpServletResponse response,Model  model){
		  return  "admin/train/noticeSMS/edit";
	  }  
	  /**
	   * 导出数据
	   * @param request
	   * @param response
	   * @return
	   */
	  @RequestMapping("loadSMS.do")
	  public  String loadSMS(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object>  res = this.noticeManagementService.load(parameter);
		  parameter.clear();
		  parameter.put("noticeId", res.get("id"));
		  List<Map<String,Object>> list=noticeTeacherService.findAll(parameter);
		  if(list!=null && list.size()>0){
			  StringBuffer teacherIds=new StringBuffer();
			  for(int i=0;i<list.size();i++){
				  Map<String,Object> map=list.get(i);
				  teacherIds.append(map.get("teacherId")+",");
			  }
			  res.put("teacherIds", teacherIds.substring(0, teacherIds.length()-1));
		  }
		  model.addAttribute("vo", res);
		  return  "admin/train/noticeSMS/edit";
	  }
	  
	  /**
	   * 查看站内短信
	   * @author zhangjf
	   * @create_time 2016-3-10 上午10:15:50
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("lookSMS.do")
	  public  String lookSMS(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object>  res = this.noticeManagementService.load(parameter);
		  parameter.clear();
		  parameter.put("noticeId", res.get("id"));
		  List<Map<String,Object>> list=noticeTeacherService.findAll(parameter);
		  model.addAttribute("teacherList", list);
		  model.addAttribute("vo", res);
		  return  "admin/train/noticeSMS/look";
	  }
	  /**
	   * 查看数据
	   * @param request
	   * @param response
	   * @return
	   */
	  @RequestMapping("look.do")
	  public  String look(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object>  res = this.noticeManagementService.load(parameter);
		  model.addAttribute("vo", res);
		  Map<String,Object> map=new HashMap<String, Object>();
		  map.put("noticeId", res.get("id"));
		  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  map.put("loginId", user.get("id"));
		  map.put("readDate", ExtendDate.getYMD_h_m_s(new Date()));
		  noticeTeacherService.updateRead(map);
		  return  "admin/train/noticeManagement/look";
	  }
	  /**
	   * 查看(老师是否查看)
	   * @param request
	   * @param response
	   * @return
	   */
	  @RequestMapping("lookTeacher.do")
	  public  String lookTeacher(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object>  res = this.noticeManagementService.load(parameter);
		  model.addAttribute("vo", res);
		  
		  parameter.clear();
		  parameter.put("noticeId", res.get("id"));
		  List<Map<String,Object>> list=noticeTeacherService.findAll(parameter);
		  model.addAttribute("teacherList", list);
		  
		  return  "admin/train/noticeManagement/lookTeacher";
	  }

	  /**
	   * 查询所有
	   * @author zhangjf
	   * @create_time 2016-3-10 上午10:16:01
	   * @param request
	   * @param response
	   * @param model
	   */
	  @RequestMapping("all.do")
	  public  void all(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  List<Map<String,Object>>  list = this.noticeManagementService.findAll(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
	  }
	  /**
	   * 保存
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("save.do")
	  public  void save(HttpServletRequest request, HttpServletResponse response,String[] teacherIds) throws Exception{
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  List<Map<String,Object>> teacherList=new ArrayList<Map<String,Object>>();
		  for(String teacherId:teacherIds){
			  Map<String,Object> map=new HashMap<String, Object>();
			  map.put("noticeTeacherId", SqlUtil.uuid());
			  map.put("teacherId", teacherId);
			  teacherList.add(map);
		  }
		 
		  parameter.put("list", teacherList);
		  MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
		   /**得到图片保存目录的真实路径**/      
	        String logoRealPathDir = request.getSession().getServletContext().getRealPath("admin/notice");     
	        /**根据真实路径创建目录**/      
	        File logoSaveFile = new File(logoRealPathDir);       
	        if(!logoSaveFile.exists())       
	            logoSaveFile.mkdirs();             
	         /**页面控件的文件流**/      
	        /**页面控件的文件流**/
	       MultipartFile multipartFile = multipartRequest.getFile("accessoryFile");   
	       if(multipartFile!=null){
	    	   //文件后缀
	    	   String suffix=StringUtils.isNotBlank(multipartFile.getOriginalFilename())?multipartFile.getOriginalFilename():"";
	    	   if(suffix!=null && !"".equals(suffix)){
	    		   String[] suff = suffix.split("\\.");
	    		   String fileName=new SimpleDateFormat("yyyy-MM-dd HH_mm_ss_SSS").format(new Date())+"";
	    		   if(suff.length>1){
	    			   fileName +="."+suff[suff.length-1];
	    		   }
	    		   Util.saveFileFromInputStream(multipartFile.getInputStream(), logoRealPathDir, fileName);
	    		   parameter.put("accessoryUrl", "admin/notice/"+fileName);
	    	   }
	       }
	       
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  parameter.put("creator", userMap.get("id"));
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  parameter.put("id", n_parameter.get("id"));
			  //添加菜单
			  this.noticeManagementService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
			//  noticeTeacherService.batchAdd(n_parameter); 
		  }else{
			  
			  this.noticeManagementService.update(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"修改成功");
			 // noticeTeacherService.batchAdd(parameter);
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
		  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  JSONObject jsonObj = this.noticeManagementService.findPageBean(parameter);
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
		  this.noticeManagementService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
	  
	  
	  /**
	   * 下载文件
	   * @author zhangjf
	   * @create_time 2016-3-10 上午10:16:14
	   * @param request
	   * @param response
	   * @throws IOException
	   */
	  @RequestMapping("download.do")  
	  public void download(HttpServletRequest request, HttpServletResponse response) throws IOException {  
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  Object url=parameter.get("url");
		  if(url==null){
			  return;
		  }
		  String str=url.toString();
		  String end=str.substring(str.lastIndexOf("."), str.length());
		  Map<String,Object>  res = this.noticeManagementService.load(parameter);
	      OutputStream os = response.getOutputStream();  
	      try {  
	    	  response.reset();  
	    	  response.setHeader("Content-Disposition", "attachment; filename="+new String(res.get("title").toString().getBytes("utf-8"),"iso-8859-1")+end);  
	    	  response.setContentType("application/octet-stream; charset=utf-8");
	          os.write(FileUtils.readFileToByteArray(new File(request.getServletContext().getRealPath(url.toString()))));  
	          os.flush();  
	      } finally {  
	          if (os != null) {  
	              os.close();  
	          }  
	      }  
	  }
	  
	  /**
	   * 查询老师人员树
	   * @author zhangjf
	   * @create_time 2016-3-10 上午11:04:56
	   * @param request
	   * @param response
	   * @param model
	   * @throws Exception
	   */
	  @RequestMapping("tree.do")
	  public  void tree(HttpServletRequest request,HttpServletResponse response,Model  model) throws Exception{
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  List<Map<String,Object>> list=unitInfoService.findTeacherTree(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
	  }
	  
	  /**
	   * 站外通知公告
	   * @author zhangjf
	   * @create_time 2016-3-25 下午3:31:43
	   * @return
	   */
	  @RequestMapping("redirectOA.do")
	  public String redirectOA(){
		  return  "admin/train/notify/list";
	  }
	  
	  /**
	   * 添加数据页面（oa站外）
	   * @return
	   */
	  @RequestMapping("addOA.do")
	  public  String addOA(HttpServletRequest request,HttpServletResponse response,Model  model){
		  return  "admin/train/notify/edit";
	  } 
	  
	  /**
	   * 导出数据（oa站外）
	   * @param request
	   * @param response
	   * @return
	   */
	  @RequestMapping("loadOA.do")
	  public  String loadOA(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object>  res = this.noticeManagementService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/train/notify/edit";
	  }
	  
	  /**
	   * 保存（oa站外）
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("saveOA.do")
	  public  void saveOA(HttpServletRequest request, HttpServletResponse response) throws Exception{
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  
		  MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
		   /**得到图片保存目录的真实路径**/      
	        String logoRealPathDir = request.getSession().getServletContext().getRealPath("admin/notice");     
	        /**根据真实路径创建目录**/      
	        File logoSaveFile = new File(logoRealPathDir);       
	        if(!logoSaveFile.exists())       
	            logoSaveFile.mkdirs();             
	         /**页面控件的文件流**/      
	        /**页面控件的文件流**/
	       MultipartFile multipartFile = multipartRequest.getFile("accessoryFile");   
	       //文件后缀
	       String suffix=StringUtils.isNotBlank(multipartFile.getOriginalFilename())?multipartFile.getOriginalFilename():"";
	       if(suffix!=null && !"".equals(suffix)){
	    	   String[] suff = suffix.split("\\.");
	    	   String fileName=new SimpleDateFormat("yyyy-MM-dd HH_mm_ss_SSS").format(new Date())+"";
	    	   if(suff.length>1){
	    		   fileName +="."+suff[suff.length-1];
	    	   }
	    	   Util.saveFileFromInputStream(multipartFile.getInputStream(), logoRealPathDir, fileName);
	    	   parameter.put("accessoryUrl", "admin/notice/"+fileName);
	       }
	       
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			  parameter.put("creator", user.get("id"));
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  //添加菜单
			  this.noticeManagementService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
			  this.noticeManagementService.update(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"修改成功");
		  }
	  }
	  
}
