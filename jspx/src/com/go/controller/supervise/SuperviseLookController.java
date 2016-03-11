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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.go.common.util.ExtendDate;
import com.go.common.util.JSONUtil;
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.UnitInfoService;
import com.go.service.supervise.InspectorApprovalService;
import com.go.service.supervise.ProjectService;
import com.go.service.supervise.SchoolSuperviseService;
import com.go.service.supervise.SuperviseService;

/**
 * 督导项目查询
 * @author chenhb
 * @create_time  2016-3-10 上午9:05:22
 */
@Controller
@RequestMapping("/supervise/superviseLook")
public class SuperviseLookController extends BaseController {
		@Autowired
		private SchoolSuperviseService schoolSuperviseService;
		@Autowired
		private InspectorApprovalService inspectorApprovalService;
		@Autowired
		private SuperviseService superviseService;
		@Autowired
		private ProjectService projectService;
		@Autowired
		private UnitInfoService unitInfoService;
	
		/**
		   * 查询学校
		   * @author chenhb
		   * @create_time {date} 上午10:03:08
		   * @param request
		   * @param response
		   * @param model
		 * @throws Exception 
		   */
		  @RequestMapping("school.do")
		  public  void school(HttpServletRequest request,HttpServletResponse response,Model  model) throws Exception{
			  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
			  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			  Map<String,Object> unitInfo=new HashMap<String, Object>();
			  unitInfo.put("userId", userMap.get("id"));
			  unitInfo=this.unitInfoService.findOne(unitInfo);
			  if(unitInfo!=null){
				  parameter.put("flag", userMap.get("flag"));
			  }
			  parameter.put("userType", userMap.get("type"));
			  parameter.put("userId", userMap.get("id"));
			  List<Map<String,Object>> list=unitInfoService.findSchool(parameter);
			  this.ajaxData(response, JSONUtil.listToArrayStr(list));
		  }
		  
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time  2016-3-3 上午11:17:34
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/supervise/superviseLook/list";
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
		  if("督学账号".equals(type)){
			  parameter.put("userId", user.get("id"));
		  }
		  JSONObject jsonObj = this.inspectorApprovalService.findPageBean(parameter);
		  /*JSONArray jsonArr=jsonObj.getJSONArray("rows");
		  List<Map<String,Object>> list=JSONUtil.jsonstrToList(jsonArr.toJSONString(), Map.class);
		  Map<String,Object> parame=new HashMap<String, Object>();
		  for(int i=0,j=list.size();i<j;i++){
			  Map<String,Object> obj=list.get(i);
			  parame.put("superviseId", obj.get("id"));
			  parame.put("unitId", obj.get("unitId"));
			  parame.put("type", "督导报告");
			  List<Map<String,Object>> superviseMaterials=inspectorApprovalService.findMaterial(parame);
			  obj.put("superviseMaterials", superviseMaterials);
		  }
		  jsonObj.put("rows", JSONUtil.listToArray(list));*/
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
//		  res.put("step", parameter.get("step"));
		  model.addAttribute("vo", res);
		  
		  Map<String,Object> superviseUnit=new HashMap<String, Object>();
		  superviseUnit.put("unitId", res.get("unitId"));
		  superviseUnit.put("superviseId", res.get("id"));
		  superviseUnit=inspectorApprovalService.findOneSU(superviseUnit);
		  res.put("step", superviseUnit.get("step"));
		  model.addAttribute("superviseUnit", superviseUnit);
		  
		  Map<String,Object> parame=new HashMap<String, Object>();
		  parame.put("superviseId", res.get("id"));
		  List<Map<String,Object>> projectList=inspectorApprovalService.findProject(parame);
		  parame.clear();
		  for(Map<String,Object> project:projectList){//遍历查询学校资料
			  parame.put("superviseId", res.get("id"));
			  parame.put("unitId", res.get("unitId"));
			  parame.put("projectId", project.get("id"));
			  parame.put("type", "学校材料");
			  List<Map<String,Object>> schoolMaterials=inspectorApprovalService.findMaterial(parame);
			  
			  project.put("schoolMaterials", schoolMaterials);
		  }
		  model.addAttribute("projectList", projectList);
		  
		  
		  //检查材料
		  parame.clear();
		  parame.put("superviseId", res.get("id"));
		  parame.put("unitId", res.get("unitId"));
		  parame.put("type", "检查材料");
		  List<Map<String,Object>> checkMaterials=schoolSuperviseService.findMaterial(parame);
		  res.put("checkMaterials", checkMaterials);
		//整改材料
		  parame.clear();
		  parame.put("superviseId", res.get("id"));
		  parame.put("unitId", res.get("unitId"));
		  parame.put("type", "整改材料");
		  List<Map<String,Object>> modifyMaterials=schoolSuperviseService.findMaterial(parame);
		  res.put("modifyMaterials", modifyMaterials);
		  
		//督导报告
		  parame.clear();
		  parame.put("superviseId", res.get("id"));
		  parame.put("unitId", res.get("unitId"));
		  parame.put("type", "督导报告");
		  List<Map<String,Object>> superviseMaterials=inspectorApprovalService.findMaterial(parame);
		  res.put("superviseMaterials", superviseMaterials);
		  return  "admin/supervise/superviseLook/edit";
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
		  inspectorApprovalService.deleteMaterial(parameter);
	  }
	  
	  @RequestMapping("approvalMaterial.do")
	  public  void approvalMaterial(HttpServletRequest request, HttpServletResponse response) throws Exception {
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> material=inspectorApprovalService.loadMaterial(parameter);
		  inspectorApprovalService.approvalMaterial(parameter);
	       this.ajaxMessage(response, Syscontants.ERROE,"审批成功");
	  }
	
}
