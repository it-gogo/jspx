package com.go.controller.supervise;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.go.common.util.TreeUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.supervise.ProjectService;
import com.go.service.supervise.SuperviseService;

/**
 * 督学管理自定义督导项目控制器
 * @author zhangjf
 * @create_time 2016-3-8 下午2:48:38
 */
@Controller
@RequestMapping("/supervise/customize")
public class CustomizeController extends BaseController {
		@Autowired
		private SuperviseService superviseService;
		@Autowired
		private ProjectService projectService;
	
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time  2016-3-3 上午11:17:34
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/supervise/customize/list";
	  }

	  /**
	   * 数据添加
	   * @author zhangjf
	   * @create_time 2016-3-8 下午2:49:01
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object> parameter=new HashMap<String,Object>();
		  Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前用户
		  return  "admin/supervise/customize/edit";
	  }  
	  
	  /**
	   * 数据加载
	   * @author zhangjf
	   * @create_time 2016-3-8 下午2:49:13
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("load.do")
	  public  String load(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object>  res = this.superviseService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/supervise/customize/edit";
	  }
	  
	  /**
	   * 统一项目数据保存方法
	   * @author zhangjf
	   * @create_time 2016-3-7 下午3:04:57
	   * @param request
	   * @param response
	   * @param projectId
	   * @param remark
	   * @param unitId 设置学校 无选择则默认全部
	 * @throws Exception 
	   * @throws Exception
	   */
	  @RequestMapping("save.do")
	  public  void save(HttpServletRequest request, HttpServletResponse response,String[] projectId,String[] text,String[] remark,String[] parentId,String[] totalScore) {
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  if(projectId==null||text==null){
			  this.ajaxMessage(response, Syscontants.ERROE,"至少选择一个督导项目");
			  return;
		  }
		  Map<String,Object> vo=superviseService.load(parameter);
		  List<File> deleteFile=new ArrayList<File>();
		  Object unitIds=parameter.get("unitId");
		  String[] unitId=null;
		  if(unitIds!=null){
			 unitId=unitIds.toString().split(",");
		  }
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"aid");
		  try {
		  MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
		   /**得到图片保存目录的真实路径**/      
	        String logoRealPathDir = request.getSession().getServletContext().getRealPath("file/supervise");     
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
	    		   String fileName=new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date())+"";
	    		   if(suff.length>1){
	    			   fileName +="."+suff[suff.length-1];
	    		   }
	    		   Util.saveFileFromInputStream(multipartFile.getInputStream(), logoRealPathDir, fileName);
	    		   parameter.put("accessoryUrl", "file/supervise/"+fileName);
	    		   
		    	   if(vo!=null && vo.get("accessoryUrl")!=null){
		    		   File file=new File(request.getSession().getServletContext().getRealPath(vo.get("accessoryUrl").toString()));
		    		   if(file.exists()){
		    			   deleteFile.add(file);
		    		   }
		    	   }
	    	   }
	       }
		 
			if(isIDNull){
				  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
				  parameter.put("creator", user.get("id"));
				  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
				  //设置ID
				  parameter.put("aid", SqlUtil.uuid());
				 String msg= this.superviseService.addData(parameter,projectId,text,remark,unitId,parentId,totalScore);
				 if(StringUtils.isBlank(msg)){
					 this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
				 }else{
					 this.ajaxMessage(response, Syscontants.ERROE,msg);
				 }
			  }else{
				  String msg= this.superviseService.updateData(parameter,projectId,text,remark,unitId,parentId,totalScore);
				  if(StringUtils.isBlank(msg)){
					  this.ajaxMessage(response, Syscontants.MESSAGE,"修改成功");
					 }else{
						 this.ajaxMessage(response, Syscontants.ERROE,msg);
					 }
			  }
			
			for(File file:deleteFile){
				  file.delete();
			  }
		} catch (Exception e) {
			e.printStackTrace();
			 this.ajaxMessage(response, Syscontants.ERROE,"系统繁忙,稍后重试！");
		}
	  }
	  
	  /**
	   * 查询统一设置项目数据列表
	   * @author zhangjf
	   * @create_time 2016-3-7 下午5:58:08
	   * @param request
	   * @param response
	   * @param model
	   */
	  @RequestMapping("list.do")
	  public  void  findList(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  parameter.put("type", "自定义");
		  JSONObject jsonObj = this.superviseService.findPageBean(parameter);
		  this.ajaxData(response, jsonObj.toJSONString());
	  }
	  /**
	   * 删除数据
	   * @author chenhb
	   * @create_time  2016-3-3 上午11:18:10
	   * @param request
	   * @param response
	   */
	  @RequestMapping("delete.do")
	  public  void  delete(HttpServletRequest request, HttpServletResponse response){
		  List<String> parameter = sqlUtil.getIdsParameter(request);
		  this.superviseService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
	 /**
   * 更新数据状态
   * @author chenhb
   * @create_time  2016-3-3 上午11:18:18
   * @param request
   * @param response
   */
	@RequestMapping("changestatus")
	public void changestatus(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		Object obj=parameter.get("status");
		if("禁用".equals(obj)){
			 this.ajaxMessage(response, Syscontants.MESSAGE,"启用成功");
			 parameter.put("status", "启用");
		}else{
			 parameter.put("status", "禁用");
			this.ajaxMessage(response, Syscontants.MESSAGE,"禁用成功");
		}
		try {
			this.superviseService.changeStatus(parameter,user);
		} catch (Exception e) {
			e.printStackTrace();
			this.ajaxMessage(response, Syscontants.MESSAGE,"系统繁忙,"+obj+"操作失败");
		}
	}
	
	/**
	 * 根据督导查询督导项目列表
	 * @author zhangjf
	 * @create_time 2016-3-7 下午4:55:41
	 * @param request
	 * @param response
	 */
	@RequestMapping("projectList.do")
	public void projectList(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		this.ajaxData(response, JSONUtil.listToArrayStr(TreeUtil.createTree(projectService.listBySuperviseId(parameter))));
	}
	
}
