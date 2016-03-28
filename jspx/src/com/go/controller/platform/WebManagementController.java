package com.go.controller.platform;

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
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.platform.WebManagementService;
/**
 * 门户网站管理控制器
 * @author zhangjf
 * @create_time 2016-3-25 下午4:02:09
 */
@Controller
@RequestMapping("/platform/webManagement")
public class WebManagementController extends BaseController {
	  @Resource
	  private  WebManagementService  webManagementService;
	  
	  /**
	   * 添加数据页面
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object> vo=webManagementService.findOne(null);
		  model.addAttribute("vo", vo);
		  return  "admin/platform/webManagement/edit";
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
		  Map<String,Object> vo=webManagementService.findOne(null);
		  List<File> deleteFile=new ArrayList<File>();
		  MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
		   /**得到图片保存目录的真实路径**/      
	        String logoRealPathDir = request.getSession().getServletContext().getRealPath("admin/webManagement");     
	        /**根据真实路径创建目录**/      
	        File logoSaveFile = new File(logoRealPathDir);       
	        if(!logoSaveFile.exists())       
	            logoSaveFile.mkdirs();             
	        /**页面控件的文件流**/
	       MultipartFile multipartFile = multipartRequest.getFile("hLogoFile"); //后台logo图片
	       //文件后缀
	       String suffix=StringUtils.isNotBlank(multipartFile.getOriginalFilename())?multipartFile.getOriginalFilename():"";
	       if(suffix!=null && !"".equals(suffix)){
	    	   String[] suff = suffix.split("\\.");
	    	   String fileName=new SimpleDateFormat("yyyy-MM-dd HH_mm_ss_SSS").format(new Date())+"";
	    	   if(suff.length>1){
	    		   fileName +="."+suff[suff.length-1];
	    	   }
	    	   Util.saveFileFromInputStream(multipartFile.getInputStream(), logoRealPathDir, fileName);
	    	   parameter.put("hLogo", "admin/webManagement/"+fileName);
	    	   Object hLogo=vo.get("hLogo");
	    	   if(hLogo!=null){
	    		   File file=new File(request.getSession().getServletContext().getRealPath(hLogo.toString()));
	    		   if(file.exists()){
	    			   deleteFile.add(file);
	    		   }
	    	   }
	       }
	       
	       /**页面控件的文件流**/
	       multipartFile = multipartRequest.getFile("bLogoFile");   //背景logo图片
	       //文件后缀
	       suffix=StringUtils.isNotBlank(multipartFile.getOriginalFilename())?multipartFile.getOriginalFilename():"";
	       if(suffix!=null && !"".equals(suffix)){
	    	   String[] suff = suffix.split("\\.");
	    	   String fileName=new SimpleDateFormat("yyyy-MM-dd HH_mm_ss_SSS").format(new Date())+"";
	    	   if(suff.length>1){
	    		   fileName +="."+suff[suff.length-1];
	    	   }
	    	   Util.saveFileFromInputStream(multipartFile.getInputStream(), logoRealPathDir, fileName);
	    	   parameter.put("bLogo", "admin/webManagement/"+fileName);
	    	   Object bLogo=vo.get("bLogo");
	    	   if(bLogo!=null){
	    		   File file=new File(request.getSession().getServletContext().getRealPath(bLogo.toString()));
	    		   if(file.exists()){
	    			   deleteFile.add(file);
	    		   }
	    	   }
	       }
	       
	       /**页面控件的文件流**/
	       multipartFile = multipartRequest.getFile("qLogoFile");   //前台logo图片
	       //文件后缀
	       suffix=StringUtils.isNotBlank(multipartFile.getOriginalFilename())?multipartFile.getOriginalFilename():"";
	       if(suffix!=null && !"".equals(suffix)){
	    	   String[] suff = suffix.split("\\.");
	    	   String fileName=new SimpleDateFormat("yyyy-MM-dd HH_mm_ss_SSS").format(new Date())+"";
	    	   if(suff.length>1){
	    		   fileName +="."+suff[suff.length-1];
	    	   }
	    	   Util.saveFileFromInputStream(multipartFile.getInputStream(), logoRealPathDir, fileName);
	    	   parameter.put("qLogo", "admin/webManagement/"+fileName);
	    	   Object qLogo=vo.get("qLogo");
	    	   if(qLogo!=null){
	    		   File file=new File(request.getSession().getServletContext().getRealPath(qLogo.toString()));
	    		   if(file.exists()){
	    			   deleteFile.add(file);
	    		   }
	    	   }
	       }
	       
	       /**页面控件的文件流**/
	       multipartFile = multipartRequest.getFile("iconFile");   //网站logo图标
	       //文件后缀
	       suffix=StringUtils.isNotBlank(multipartFile.getOriginalFilename())?multipartFile.getOriginalFilename():"";
	       if(suffix!=null && !"".equals(suffix)){
	    	   String[] suff = suffix.split("\\.");
	    	   String fileName=new SimpleDateFormat("yyyy-MM-dd HH_mm_ss_SSS").format(new Date())+"";
	    	   if(suff.length>1){
	    		   fileName +="."+suff[suff.length-1];
	    	   }
	    	   Util.saveFileFromInputStream(multipartFile.getInputStream(), logoRealPathDir, fileName);
	    	   parameter.put("iconUrl", "admin/webManagement/"+fileName);
	    	   Object iconUrl=vo.get("iconUrl");
	    	   if(iconUrl!=null){
	    		   File file=new File(request.getSession().getServletContext().getRealPath(iconUrl.toString()));
	    		   if(file.exists()){
	    			   deleteFile.add(file);
	    		   }
	    	   }
	       }
	       
	       
	       /**页面控件的文件流**/
	       multipartFile = multipartRequest.getFile("adFile");   //网站广告图片
	       //文件后缀
	       suffix=StringUtils.isNotBlank(multipartFile.getOriginalFilename())?multipartFile.getOriginalFilename():"";
	       if(suffix!=null && !"".equals(suffix)){
	    	   String[] suff = suffix.split("\\.");
	    	   String fileName=new SimpleDateFormat("yyyy-MM-dd HH_mm_ss_SSS").format(new Date())+"";
	    	   if(suff.length>1){
	    		   fileName +="."+suff[suff.length-1];
	    	   }
	    	   Util.saveFileFromInputStream(multipartFile.getInputStream(), logoRealPathDir, fileName);
	    	   parameter.put("adPic", "admin/webManagement/"+fileName);
	    	   Object iconUrl=vo.get("adPic");
	    	   if(iconUrl!=null){
	    		   File file=new File(request.getSession().getServletContext().getRealPath(iconUrl.toString()));
	    		   if(file.exists()){
	    			   deleteFile.add(file);
	    		   }
	    	   }
	       }
	       
	       
		  
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  parameter.put("id", n_parameter.get("id"));
			  //添加菜单
			  this.webManagementService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
			  this.webManagementService.update(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"修改成功");
		  }
		  request.getServletContext().setAttribute("webManagement", parameter);
		  for(File file:deleteFile){
			  file.delete();
		  }
	  }
	
}
