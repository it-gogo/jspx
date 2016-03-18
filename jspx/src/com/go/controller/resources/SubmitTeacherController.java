package com.go.controller.resources;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.Util;
import com.go.common.util.Zip;
import com.go.controller.base.BaseController;
import com.go.service.resources.FileSubmitService;
import com.go.service.resources.SubmitTeacherService;
/**
 * 老师文件提交
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/resources/submitTeacher")
public class SubmitTeacherController extends BaseController {
	  @Resource
	  private  SubmitTeacherService  submitTeacherService;
	  @Resource
	  private  FileSubmitService  fileSubmitService;
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  model.addAttribute("vo", parameter);
		  return  "admin/resources/submitTeacher/list";
	  }
	  /**
	   * 查询列表
	   * @param request
	   * @param response
	   */ 
	  @RequestMapping("list.do")
	  public  void  findList(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  List<Map<String,Object>> list= this.submitTeacherService.findAll(parameter);
		  JSONObject jsonObj=new JSONObject();
		  jsonObj.put("rows", list);
		  this.ajaxData(response, jsonObj.toJSONString());
	  }
	  /**
	   * 下载文件
	   * @author chenhb
	   * @create_time  2015-10-22 下午3:12:53
	   * @param request
	   * @param response
	   * @param tempName
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
		  Map<String,Object>  res = this.fileSubmitService.findOne(parameter);
	      OutputStream os = response.getOutputStream();  
	      try {  
	    	  String name=res.get("title")+"-"+res.get("teacherName");
	    	  response.reset();  
	    	  response.setHeader("Content-Disposition", "attachment; filename="+new String(name.getBytes("utf-8"),"iso-8859-1")+end);  
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
	   * 一键下载文件
	   * @author chenhb
	   * @create_time  2015-10-22 下午3:12:53
	   * @param request
	   * @param response
	   * @param tempName
	   * @throws IOException
	   */
	  @RequestMapping("downloadAll.do")  
	  public void downloadAll(HttpServletRequest request, HttpServletResponse response) throws IOException {  
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  List<Map<String,Object>> list= this.submitTeacherService.findAll(parameter);
		  File[] arr={};
		  String[] fileNames={};
		  for(Map<String,Object> map:list){
			  Object submitUrl=map.get("submitUrl");
			  if(submitUrl!=null){
//				  String fileUrl=request.getServletContext().getRealPath(submitUrl.toString());
				  String fileUrl=submitUrl.toString();
				  File file=new File(fileUrl);
				  arr=Util.expansion(arr, file);
				  String end=fileUrl.substring(fileUrl.lastIndexOf("."), fileUrl.length());
				  String str=map.get("teacherName").toString();
				  fileNames=Util.expansion(fileNames, str+end);
			  }
		  }
	      OutputStream os = response.getOutputStream();  
	      try {  
	    	  response.reset();  
	    	  response.setHeader("Content-Disposition", "attachment; filename="+new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())+".zip");  
	    	  response.setContentType("application/octet-stream; charset=utf-8");
	    	  response.setCharacterEncoding("utf-8");
	    	  Zip.ZipStreamByName(os, "", arr,fileNames);
	          os.flush();  
	      } finally {  
	          if (os != null) {  
	              os.close();  
	          }  
	      }  
	  }
}

