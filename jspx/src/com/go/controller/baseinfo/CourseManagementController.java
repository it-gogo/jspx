
package com.go.controller.baseinfo;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.ExtendDate;
import com.go.common.util.JSONUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.SystemConfigUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.CourseManagementService;
/**
 * 课程管理控制
 * @author chenhb
 * @create_time  2015-9-24 上午12:21:08
 */
@Controller
@RequestMapping("/baseinfo/courseManagement")
public class CourseManagementController extends BaseController {
	  @Resource
	  private  CourseManagementService  courseManagementService;
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/baseinfo/courseManagement/list";
	  }
	  
	  /**
	   * 下载资料
	   * @author chenhb
	   * @create_time  2015-9-28 上午10:12:49
	   * @param request
	   * @param response
	   * @param tempName
	   * @throws IOException
	   */
	  @RequestMapping("downloadData.do")  
	  public void downloadData(HttpServletRequest request, HttpServletResponse response) throws IOException {  
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
	      OutputStream os = response.getOutputStream();  
	      try {  
	    	  Map<String,Object> vo=courseManagementService.load(parameter);
	    	  String dataUrl=parameter.get("dataUrl").toString();
	    	  String fileName=vo.get("name")+dataUrl.substring(dataUrl.lastIndexOf("."), dataUrl.length());
	    	  response.reset();  
	    	  response.setHeader("Content-Disposition", "attachment; filename="+new String(fileName.getBytes("utf-8"),"iso8859-1"));  
	    	  response.setContentType("application/octet-stream; charset=utf-8");
	          os.write(FileUtils.readFileToByteArray(new File(request.getServletContext().getRealPath(dataUrl))));  
	          os.flush();  
	      } finally {  
	          if (os != null) {  
	              os.close();  
	          }  
	      }  
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
		  Map<String,Object> courseManagement=courseManagementService.findOne(parameter);
		  if(courseManagement==null){//不是授课教师
			  parameter.remove("userId");
		  }
		  List<Map<String,Object>> list=courseManagementService.findAll(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
	  }
	  /**
	   * 添加数据页面(单位)
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  return  "admin/baseinfo/courseManagement/edit";
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
		  Map<String,Object>  res = this.courseManagementService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/baseinfo/courseManagement/edit";
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
		  MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
		   /**得到图片保存目录的真实路径**/      
	        String logoRealPathDir = request.getSession().getServletContext().getRealPath("admin/course");     
	        /**根据真实路径创建目录**/      
	        File logoSaveFile = new File(logoRealPathDir);       
	        if(!logoSaveFile.exists())       
	            logoSaveFile.mkdirs();             
	         /**页面控件的文件流**/      
	        /**页面控件的文件流**/
	       MultipartFile multipartFile = multipartRequest.getFile("dataFile");   
	       //文件后缀
	       String suffix=StringUtils.isNotBlank(multipartFile.getOriginalFilename())?multipartFile.getOriginalFilename():"";
	       if(suffix!=null && !"".equals(suffix)){
	    	   String[] suff = suffix.split("\\.");
	    	   String fileName=new SimpleDateFormat("yyyy-MM-dd HH_mm_ss_SSS").format(new Date())+"";
	    	   if(suff.length>1){
	    		   fileName +="."+suff[suff.length-1];
	    	   }
	    	   Util.saveFileFromInputStream(multipartFile.getInputStream(), logoRealPathDir, fileName);
	    	   parameter.put("dataUrl", "admin/course/"+fileName);
	       }
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			  parameter.put("creator", userMap.get("id"));
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  this.courseManagementService.add(n_parameter);//添加
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
			  this.courseManagementService.update(parameter);
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
		  parameter.put("userId", userMap.get("id"));
		  Map<String,Object> courseManagement=courseManagementService.findOne(parameter);
		  if(courseManagement==null){//不是授课教师
			  parameter.remove("userId");
		  }
		  JSONObject jsonObj = this.courseManagementService.findPageBean(parameter);
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
		  this.courseManagementService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
}
