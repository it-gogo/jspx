package com.go.controller.resources;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
 * 提交项目控制类
 * @author chenhb
 * @create_time  2016-3-15 上午11:19:08
 */
@Controller
@RequestMapping("/resources/fileSubmit")
public class FileSubmitController extends BaseController {
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
		  return  "admin/resources/fileSubmit/list";
	  }
	  /**
	   * 添加数据页面
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  return  "admin/resources/fileSubmit/edit";
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
		  Map<String,Object>  res = this.fileSubmitService.load(parameter);
		  model.addAttribute("vo", res);
		  
		  parameter.clear();
		  parameter.put("submitId", res.get("id"));
		  List<Map<String,Object>> list=submitTeacherService.findAll(parameter);
		  if(list!=null && list.size()>0){
			  StringBuffer teacherIds=new StringBuffer();
			  for(int i=0;i<list.size();i++){
				  Map<String,Object> map=list.get(i);
				  teacherIds.append(map.get("userId")+",");
			  }
			  res.put("teacherIds", teacherIds.substring(0, teacherIds.length()-1));
		  }
		  
		  return  "admin/resources/fileSubmit/edit";
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
			  map.put("id", SqlUtil.uuid());
			  map.put("teacherId", teacherId);
			  teacherList.add(map);
		  }
		  parameter.put("teacherList", teacherList);
		  
		  MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
		   /**得到图片保存目录的真实路径**/      
	        String logoRealPathDir = request.getSession().getServletContext().getRealPath("file/fileSubmit");     
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
	    		   parameter.put("accessoryUrl", "file/fileSubmit/"+fileName);
	    	   }
	       }
		  
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  parameter.put("creator", userMap.get("id"));
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  //添加菜单
			  this.fileSubmitService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
			  
		  }else{
			  this.fileSubmitService.update(parameter);
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
		  JSONObject jsonObj = this.fileSubmitService.findPageBean(parameter);
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
		  this.fileSubmitService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
	  
	  /**
	 *更新数据状态
	 * @param request
	 * @param response
	 */
	  @RequestMapping("changestatus")
		public void changestatus(HttpServletRequest request,HttpServletResponse response){
			Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
			Object obj=parameter.get("status");
			if("禁用".equals(obj)){
				 this.ajaxMessage(response, Syscontants.MESSAGE,"启用成功");
				 parameter.put("status", "启用");
			}else{
				 parameter.put("status", "禁用");
				this.ajaxMessage(response, Syscontants.MESSAGE,"禁用成功");
			}
			this.fileSubmitService.changeStatus(parameter);
		}
}
