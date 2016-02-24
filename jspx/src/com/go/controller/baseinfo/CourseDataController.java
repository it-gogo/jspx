
package com.go.controller.baseinfo;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.go.service.baseinfo.CourseDataService;
/**
 * 课程资料
 * @author chenhb
 * @create_time  2015-9-24 上午12:21:08
 */
@Controller
@RequestMapping("/baseinfo/courseData")
public class CourseDataController extends BaseController {
	  @Resource
	  private  CourseDataService  courseDataService;
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  model.addAttribute("vo", parameter);
		  return  "admin/baseinfo/courseData/list";
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
		  Map<String,Object> courseData=courseDataService.findOne(parameter);
		  if(courseData==null){//不是授课教师
			  parameter.remove("userId");
		  }
		  List<Map<String,Object>> list=courseDataService.findAll(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
	  }
	  /**
	   * 添加数据页面(单位)
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  model.addAttribute("vo", parameter);
		  return  "admin/baseinfo/courseData/edit";
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
		  Map<String,Object>  res = this.courseDataService.load(parameter);
		  res.putAll(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/baseinfo/courseData/edit";
	  }
	  
	  
	  /**
	   * 保存单位
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("save.do")
	  public  void save(HttpServletRequest request, HttpServletResponse response) throws Exception{
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object>  vo = this.courseDataService.load(parameter);
		  List<File> deleteFile=new ArrayList<File>();
		  MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
		   /**得到图片保存目录的真实路径**/      
	        String logoRealPathDir = request.getSession().getServletContext().getRealPath("admin/course");     
	        /**根据真实路径创建目录**/      
	        File logoSaveFile = new File(logoRealPathDir);       
	        if(!logoSaveFile.exists())       
	            logoSaveFile.mkdirs();             
	        /**页面控件的文件流**/
	       MultipartFile multipartFile = multipartRequest.getFile("dataFile"); //资料
	       //文件后缀
	       String suffix=StringUtils.isNotBlank(multipartFile.getOriginalFilename())?multipartFile.getOriginalFilename():"";
	       if(suffix!=null && !"".equals(suffix)){
	    	   String[] suff = suffix.split("\\.");
	    	   String fileName=new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date())+"";
	    	   if(suff.length>1){
	    		   fileName +="."+suff[suff.length-1];
	    	   }
	    	   Util.saveFileFromInputStream(multipartFile.getInputStream(), logoRealPathDir, fileName);
	    	   parameter.put("dataUrl", "admin/course/"+fileName);
	    	   if(vo!=null){
	    		   Object dataUrl=vo.get("dataUrl");
	    		   if(dataUrl!=null){
	    			   File file=new File(request.getSession().getServletContext().getRealPath(dataUrl.toString()));
	    			   if(file.exists()){
	    				   deleteFile.add(file);
	    			   }
	    		   }
	    	   }
	       }
		  
		  
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			  parameter.put("creator", userMap.get("id"));
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  this.courseDataService.add(n_parameter);//添加
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
			  this.courseDataService.update(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"保存成功");
		  }
		  
		  for(File file:deleteFile){
			  file.delete();
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
		  parameter.put("userId", userMap.get("id"));
		  Map<String,Object> courseData=courseDataService.findOne(parameter);
		  if(courseData==null){//不是授课教师
			  parameter.remove("userId");
		  }
		  JSONObject jsonObj = this.courseDataService.findPageBean(parameter);
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
		  this.courseDataService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
}
