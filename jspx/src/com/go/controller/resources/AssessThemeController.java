package com.go.controller.resources;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.ExtendDate;
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.resources.AssessPicService;
import com.go.service.resources.AssessThemeService;
/**
 * 评估主题
 * @author chenhb
 * @create_time  2015-11-27 下午1:37:03
 */
@Controller
@RequestMapping("/resources/assessTheme")
public class AssessThemeController extends BaseController {
	  @Resource
	  private  AssessThemeService  assessThemeService;
	  @Resource
	  private  AssessPicService  assessPicService;
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/resources/assessTheme/list";
	  }
	  /**
	   * 添加数据页面
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  return  "admin/resources/assessTheme/edit";
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
		  parameter.put("assessId", parameter.get("id"));
		  List<Map<String,Object>> list=this.assessPicService.findAll(parameter);
		  StringBuffer loginIds=new StringBuffer("");
		  for(Map<String,Object> map:list){
			  loginIds.append(map.get("loginId")+",");
		  }
		  Map<String,Object>  res = this.assessThemeService.load(parameter);
		  res.put("loginIds", loginIds.substring(0, loginIds.length()-1));
		  model.addAttribute("vo", res);
		  return  "admin/resources/assessTheme/edit";
	  }
	  /**
	   * 保存
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("save.do")
	  public  void save(HttpServletRequest request, HttpServletResponse response,String[] loginId) throws Exception{
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  
		  if(loginId==null || loginId.length==0){
			  this.ajaxMessage(response, Syscontants.ERROE, "至少选择一个用户。");
			  return;
		  }
		  List<Map<String,Object>> loginIdList=new ArrayList<Map<String,Object>>();
		  for(String str:loginId){
			  Map<String,Object> map=new HashMap<String, Object>();
			  map.put("id", SqlUtil.uuid());
			  map.put("loginId", str);
			  loginIdList.add(map);
		  }
		  parameter.put("list", loginIdList);
		  
		 
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  parameter.put("creator", userMap.get("id"));
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  n_parameter.put("topFileId", SqlUtil.uuid());
			  n_parameter.put("absoluteId", SqlUtil.uuid());
			  //添加菜单
			  this.assessThemeService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
			  
		  }else{
			  parameter.put("creator", userMap.get("id"));
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  
			  parameter.put("modifier", userMap.get("id"));
			  parameter.put("modifydate", ExtendDate.getYMD_h_m_s(new Date()));
			  this.assessThemeService.update(parameter);
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
		  JSONObject jsonObj = this.assessThemeService.findPageBean(parameter);
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
		  this.assessThemeService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
	  
}
