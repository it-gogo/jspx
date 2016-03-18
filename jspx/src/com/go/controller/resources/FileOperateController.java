package com.go.controller.resources;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
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
import com.go.common.util.DateUtil;
import com.go.common.util.ExtendDate;
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.resources.AbsoluteManagementService;
import com.go.service.resources.FileManagementService;
import com.go.service.resources.FileSubmitService;
import com.go.service.resources.SubmitTeacherService;
/**
 * 文件操作
 * @author chenhb
 * @create_time  2015-10-22 下午2:42:10
 */
@Controller
@RequestMapping("/resources/fileOperate")
public class FileOperateController extends BaseController {
	  @Resource
	  private  FileSubmitService  fileSubmitService;
	  @Resource
	  private  SubmitTeacherService  submitTeacherService;
	  @Resource
	  private  FileManagementService  fileManagementService;
	  @Resource
	  private  AbsoluteManagementService  absoluteManagementService;
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/resources/fileOperate/list";
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
		  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
	      parameter.put("userId", user.get("id"));
		  Map<String,Object>  res = this.fileSubmitService.findOne(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/resources/fileOperate/edit";
	  }
	  /**
	   * 保存
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("save.do")
	  public  void save(HttpServletRequest request, HttpServletResponse response) throws Exception{
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  
		  MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
	        /**页面控件的文件流**/
	       MultipartFile multipartFile = multipartRequest.getFile("submitFile");   
	       if(multipartFile!=null){
	    	   Map<String,Object> fileMap=new HashMap<String, Object>();//文件数据
	    	   Map<String,Object> file=new HashMap<String, Object>();
	    	   file.put("id", parameter.get("fileId"));
	    	   file=fileManagementService.load(file);
	    	   String absoluteUrl="";//获取文件保存路径
	    	   String relativeUrl="";
	    	   if(file!=null){//存在父文件
	    		   if(file.get("absoluteUrl")==null){
	    			   Map<String,Object> absolute=absoluteManagementService.findOne(file);
	    			   absoluteUrl=absolute.get("absoluteUrl").toString()+"/"+file.get("relativeUrl").toString();
	    		   }else{
	    			   absoluteUrl=file.get("absoluteUrl").toString();
	    		   }
	    		   
	    		   //创建文件信息
	    		   fileMap.put("parentId", file.get("id"));
	   				fileMap.put("absoluteId", file.get("absoluteId"));
	   				fileMap.put("topFileId", file.get("topFileId"));
	   				relativeUrl=file.get("relativeUrl")==null?"":file.get("relativeUrl")+"";
	    	   }else{//父文件为顶级文件
	    		   file=new HashMap<String, Object>();
	    		   file.put("topFileId", parameter.get("fileId"));
	    		   file=absoluteManagementService.findOne(file);
	    		   absoluteUrl=file.get("absoluteUrl").toString();
	    		   //创建文件信息
	    		   fileMap.put("topFileId", file.get("topFileId"));
	   			  fileMap.put("parentId", file.get("topFileId"));
	   			  fileMap.put("absoluteId", file.get("id"));
	   			  relativeUrl=file.get("name")==null?"":file.get("name")+"";
	   			  
	   			
	    	   }
	    	   //创建文件信息
	    	   String fileId=SqlUtil.uuid();
	    	   fileMap.put("id", fileId);
	   		   fileMap.put("type", "文件");
	   		   fileMap.put("relativeUrl", relativeUrl);
	   		   
	    	   File  logoSaveFile = new File(absoluteUrl);
	    	   if(!logoSaveFile.exists()){
	    		   logoSaveFile.mkdirs();
	    	   }
	    	   
	    	   
	    	   //文件后缀
	    	   String suffix=StringUtils.isNotBlank(multipartFile.getOriginalFilename())?multipartFile.getOriginalFilename():"";
	    	   if(suffix!=null && !"".equals(suffix)){
	    		   String filename=suffix;
	    		   String[] suff = suffix.split("\\.");
	    		   fileMap.put("suffix", "."+suff[suff.length-1]);
	    		   Map<String,Object> pvo=new HashMap<String, Object>();
	    		   pvo.put("parentId", parameter.get("fileId"));
	    		   pvo.put("name", suffix);
	    		   pvo=fileManagementService.findOne(pvo);
	    		   if(pvo!=null && pvo.size()>0 && !pvo.get("id").equals(parameter.get("id"))){
	    			   //重名处理
	    			   filename=suff[0]+"_"+System.currentTimeMillis()+"."+suff[suff.length-1];
	    		   }
	    		   
	    		   Util.saveFileFromInputStream(multipartFile.getInputStream(), absoluteUrl, filename);
	    		   parameter.put("submitUrl", absoluteUrl+"/"+filename);
	    		   
	    		   
	    		   //创建文件信息
	    		   fileMap.put("name", filename);
		   		   Long fileSize=multipartFile.getSize();//获取文件大小
		   		   fileMap.put("fileSize", fileSize);
		   		   Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		   		   fileMap.put("creator", userMap.get("id"));
		   		   fileMap.put("createdate", DateUtil.getCurrentTime());
//		   		   fileManagementService.add(fileMap);
		   		   parameter.put("fileMap", fileMap);
	    	   }
	    	   
	    	   parameter.put("fileId", fileId);
	       }
		  
		  
		  
	       Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
	       parameter.put("userId", user.get("id"));
		  parameter.put("submitDate", ExtendDate.getYMD_h_m_s(new Date()));
		  this.submitTeacherService.updateSubmit(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE,"提交成功");
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
		  parameter.put("userId", user.get("id"));
		  JSONObject jsonObj = this.fileSubmitService.findOperate(parameter);
		  this.ajaxData(response, jsonObj.toJSONString());
	  }
}
