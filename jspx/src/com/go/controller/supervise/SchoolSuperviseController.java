package com.go.controller.supervise;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
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
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.UnitInfoService;
import com.go.service.supervise.ProjectService;
import com.go.service.supervise.SchoolSuperviseService;
import com.go.service.supervise.SuperviseService;

/**
 * 学校督导控制器
 * @author chenhb
 * @create_time  2016-3-8 下午2:17:59
 */
@Controller
@RequestMapping("/supervise/schoolSupervise")
public class SchoolSuperviseController extends BaseController {
		@Autowired
		private SchoolSuperviseService schoolSuperviseService;
		@Autowired
		private SuperviseService superviseService;
		@Autowired
		private ProjectService projectService;
		@Autowired
		private UnitInfoService unitInfoService;
	
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time  2016-3-3 上午11:17:34
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/supervise/schoolSupervise/list";
	  }
	  
	  /**
	   * 查看列表
	   * @author chenhb
	   * @create_time  2016-3-8 下午2:32:27
	   * @param request
	   * @param response
	   * @param model
	   */
	  @RequestMapping("list.do")
	  public  void  findList(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前用户
		  String type=user.get("type").toString();
		  if("老师账号".equals(type) || "单位账号".equals(type)){
			  parameter.put("flag", user.get("flag"));
		  }
		  JSONObject jsonObj = this.schoolSuperviseService.findPageBean(parameter);
		  this.ajaxData(response, jsonObj.toJSONString());
	  }
	  /**
	   * 导出数据
	   * @author chenhb
	   * @create_time  2016-3-3 上午11:17:52
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("load.do")
	  public  String load(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object>  res = this.superviseService.load(parameter);
		  res.put("unitId", parameter.get("unitId"));
		  model.addAttribute("vo", res);
		  
		  Map<String,Object> superviseUnit=new HashMap<String, Object>();
		  superviseUnit.put("unitId", res.get("unitId"));
		  superviseUnit.put("superviseId", res.get("id"));
		  superviseUnit=schoolSuperviseService.findOneSU(superviseUnit);
		  model.addAttribute("superviseUnit", superviseUnit);
		  
		  Map<String,Object> parame=new HashMap<String, Object>();
		  parame.put("superviseId", res.get("id"));
		  List<Map<String,Object>> projectList=schoolSuperviseService.findProject(parame);
		  parame.clear();
		  boolean isNext=false;
		  for(Map<String,Object> project:projectList){//遍历查询学校资料
			  parame.put("superviseId", res.get("id"));
			  parame.put("unitId", res.get("unitId"));
			  parame.put("projectId", project.get("id"));
			  parame.put("type", "学校材料");
			  List<Map<String,Object>> schoolMaterials=schoolSuperviseService.findMaterial(parame);
			  
			  project.put("schoolMaterials", schoolMaterials);
		  }
		  model.addAttribute("projectList", projectList);
		  return  "admin/supervise/schoolSupervise/edit";
	  }
	  /**
	   * 保存材料
	   * @author chenhb
	   * @create_time  2016-3-8 下午5:05:05
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("saveMaterial.do")
	  public  void saveMaterial(HttpServletRequest request, HttpServletResponse response) throws Exception {
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  
		  
		  Map<String,Object> parame=new HashMap<String, Object>();
		  parame.put("id", parameter.get("superviseId"));
		  Map<String,Object> supervise=superviseService.load(parame);
		  parame.put("id", parameter.get("unitId"));
		  Map<String,Object> unit=unitInfoService.load(parame);
		  parame.put("id", parameter.get("projectId"));
		  Map<String,Object> project=projectService.load(parame);
		  
		  String path="material/"+supervise.get("name")+"/"+unit.get("name")+"/"+project.get("name");
		  
		  MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
		   /**得到图片保存目录的真实路径**/      
	        String logoRealPathDir = request.getSession().getServletContext().getRealPath(path);     
	        /**根据真实路径创建目录**/      
	        File logoSaveFile = new File(logoRealPathDir);       
	        if(!logoSaveFile.exists())       
	            logoSaveFile.mkdirs();             
	         /**页面控件的文件流**/      
	        /**页面控件的文件流**/
	       MultipartFile multipartFile = multipartRequest.getFile("fileId");   
	       //文件后缀
	       String suffix=StringUtils.isNotBlank(multipartFile.getOriginalFilename())?multipartFile.getOriginalFilename():"";
	       if(suffix!=null && !"".equals(suffix)){
	    	   String[] suff = suffix.split("\\.");
//	    	   parameter.put("name", suff[0]);
	    	   String fileName=suff[0]+"-"+new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date());
//	    	   String fileName=schoolSuperviseService.findMaxName(parameter);
	    	   if(suff.length>1){
	    		   fileName +="."+suff[suff.length-1];
	    	   }
	    	   parameter.put("name", fileName);
	    	   Util.saveFileFromInputStream(multipartFile.getInputStream(), logoRealPathDir, fileName);
	    	   parameter.put("url", path+"/"+fileName);
	    	   
	    	   parameter.put("id", SqlUtil.uuid());
	    	   this.schoolSuperviseService.addMaterial(parameter);
	 		   this.ajaxMessage(response, Syscontants.MESSAGE,"上传成功");
	       }
	       this.ajaxMessage(response, Syscontants.ERROE,"上传失败");
	  }
	  
	  /**
	   * 删除材料
	   * @author chenhb
	   * @create_time  2016-3-9 下午2:23:43
	   * @param request
	   * @param response
	   * @param fileUrl
	   */
	  @RequestMapping("deleteMaterial")
	  public void deleteMaterial(HttpServletRequest request, HttpServletResponse response,String fileUrl){
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  File f=new File(request.getSession().getServletContext().getRealPath(fileUrl));
		  if( f.exists()){
			  f.delete();
		  }
		  this.ajaxMessage(response, Syscontants.MESSAGE,"删除成功");
		  schoolSuperviseService.deleteMaterial(parameter);
	  }
	  
	  @RequestMapping("approvalMaterial.do")
	  public  void approvalMaterial(HttpServletRequest request, HttpServletResponse response) throws Exception {
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> material=schoolSuperviseService.loadMaterial(parameter);
		  schoolSuperviseService.approvalMaterial(parameter);
	       this.ajaxMessage(response, Syscontants.ERROE,"审批成功");
	  }
	
}
