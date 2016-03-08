package com.go.controller.supervise;

import java.io.File;
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
import com.go.common.util.JSONUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.supervise.ProjectService;
/**
 * 项目管理
 * @author chenhb
 * @create_time  2016-3-4 下午5:11:21
 */
@Controller
@RequestMapping("/supervise/project")
public class ProjectController extends BaseController {
	  @Resource
	  private  ProjectService  projectService;
	  /**
	   * 菜单树
	   * @author chenhb
	   * @create_time {date} 上午10:03:08
	   * @param request
	   * @param response
	   * @param model
	 * @throws Exception 
	   */
	  @RequestMapping("tree.do")
	  public  void tree(HttpServletRequest request,HttpServletResponse response,Model  model) throws Exception{
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  parameter.put("type", "绑定");
		  List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		  if(parameter.containsKey("isSelect")){
			  Map<String,Object> map=new HashMap<String, Object>();
			  map.put("id", "");
			  map.put("text", "请选择");
			  list.add(map);
		  }
		  list.addAll(projectService.findTree(parameter));
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
	  }
	  /**
	   * 查询未绑定数据
	   * @author chenhb
	   * @create_time  2016-3-7 下午5:18:55
	   * @param request
	   * @param response
	   * @param model
	   * @throws Exception
	   */
	  @RequestMapping("findUnbinding.do")
	  public  void findUnbinding(HttpServletRequest request,HttpServletResponse response,Model  model) throws Exception{
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  List<Map<String,Object>> unbindingList=projectService.findUnbinding(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(unbindingList));
	  }
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	 * @throws Exception 
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(HttpServletRequest request,HttpServletResponse response,Model  model) throws Exception{
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  return  "admin/supervise/project/list";
	  }
	  
	  /**
	   * 添加数据页面
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  return  "admin/supervise/project/edit";
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
		  Map<String,Object>  res = this.projectService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/supervise/project/edit";
	  }
	  
	  /**
	   * 保存后台的菜单
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("save.do")
	  public  void save(HttpServletRequest request, HttpServletResponse response) throws Exception{
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			  parameter.put("creator", userMap.get("id"));
			  String time=ExtendDate.getYMD_h_m_s(new Date());
			  parameter.put("createdate", time);
			  parameter.put("bindingTime", time);
			  parameter.put("type", "绑定");
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  //添加菜单
			  this.projectService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
			  this.projectService.update(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"修改成功");
		  }
	  }
	  /**
	   * 查询列表
	   * @param request
	   * @param response
	 * @throws Exception 
	   */ 
	  @RequestMapping("list.do")
	  public  void  findList(HttpServletRequest request, HttpServletResponse response,Model  model) throws Exception{
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前用户
		  parameter.put("type", "绑定");
		  JSONObject jsonObj = this.projectService.findPageBean(parameter);
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
		  this.projectService.delete(parameter);
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
			Object obj=parameter.get("status");
			if("禁用".equals(obj)){
				 this.ajaxMessage(response, Syscontants.MESSAGE,"启用成功");
				 parameter.put("status", "启用");
			}else{
				 parameter.put("status", "禁用");
				this.ajaxMessage(response, Syscontants.MESSAGE,"禁用成功");
			}
			this.projectService.updatestat(parameter);
		}
	/**
	 * 设置已读
	 * @author chenhb
	 * @create_time  2016-3-7 下午6:00:17
	 * @param request
	 * @param response
	 */
	@RequestMapping("readF.do")
	  public  void  readF(HttpServletRequest request, HttpServletResponse response){
		Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  String time=ExtendDate.getYMD_h_m_s(new Date());
		  parameter.put("bindingTime", time);
		  this.projectService.readF(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "设置成功");
	  }
	/**
	 * 绑定项目
	 * @author chenhb
	 * @create_time  2016-3-8 上午9:36:07
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("binding.do")
	  public  String binding(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object>  res = this.projectService.load(parameter);
		  String time=ExtendDate.getYMD_h_m_s(new Date());
		  res.put("bindingTime", time);
		  res.put("type", "绑定");
		  model.addAttribute("vo", res);
		  return  "admin/supervise/project/binding";
	  }
}
