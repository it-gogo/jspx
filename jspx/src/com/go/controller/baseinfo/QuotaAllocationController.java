package com.go.controller.baseinfo;

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
import com.go.common.util.JSONUtil;
import com.go.common.util.SysUtil;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.ClassStudentService;
import com.go.service.baseinfo.QuotaAllocationService;
/**
 * 名额分配管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/baseinfo/quotaAllocation")
public class QuotaAllocationController extends BaseController {
	  @Resource
	  private  QuotaAllocationService  quotaAllocationService;
	  @Resource
	  private  ClassStudentService  classStudentService;
	  /**
	   * 添加数据页面
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前用户
//		  Map<String,Object> res=new HashMap<String, Object>();
//		  res.put("classId", parameter.get("classId"));
		  model.addAttribute("vo", parameter);
		  return  "admin/baseinfo/quotaAllocation/edit";
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
		  Map<String,Object>  res = this.quotaAllocationService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/baseinfo/quotaAllocation/edit";
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
			  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			  parameter.put("creator", user.get("id"));
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  //添加菜单
			  this.quotaAllocationService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
			  List<String> list=new ArrayList<String>();
			  list.add(parameter.get("schoolId").toString());
			  parameter.put("list", list);
			  List<Map<String,Object>> res=classStudentService.findNum(parameter);
			  if(res!=null && res.size()>0){
				 Map<String,Object> map=res.get(0);
				 long numed=(Long) map.get("num");
				 int num=Integer.parseInt(parameter.get("number").toString()) ;
				 if(num<numed){
					 this.ajaxMessage(response, Syscontants.ERROE,"修改失败，录入学员数量已超过当前设置数。");
					 return ;
				 }
			  }
			  this.quotaAllocationService.update(parameter);
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
		  Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前用户
		  JSONObject jsonObj = this.quotaAllocationService.findPageBean(parameter);
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
		  this.quotaAllocationService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
}
