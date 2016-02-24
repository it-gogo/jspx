
package com.go.controller.train;

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
import com.go.common.util.SysUtil;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.ClassInfoService;
import com.go.service.train.NoticeInfoService;
/**
 * 班级管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/train/noticeInfo")
public class NoticeInfoController extends BaseController {
	  @Resource
	  private  NoticeInfoService  noticeInfoService; 
	  @Resource
	  private  ClassInfoService  classInfoService;
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/train/noticeInfo/list";
	  }
	  /**
	   * 查看公告
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("lookNoticeList.do")
	  public String lookNoticeList(HttpServletRequest request,Model  model){
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);
		  Map<String,Object> parameter=new HashMap<String, Object>();
		  parameter.put("classUserId", userMap.get("id"));
		  List<Map<String,Object>> list=classInfoService.findAll(parameter);
		  if(list!=null && list.size()>0){
			  String classIds="'";
			  for(Map<String,Object> map:list){
				  classIds+=map.get("id")+"','";
			  }
			  classIds=classIds.substring(0, classIds.length()-2);
			  parameter.put("classIds", classIds);
		  }
		  model.addAttribute("vo", parameter);
		  return  "admin/train/noticeInfo/lookList";
	  }
	  /**
	   * 添加数据页面(单位)
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  return  "admin/train/noticeInfo/edit";
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
		  Map<String,Object>  res = this.noticeInfoService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/train/noticeInfo/edit";
	  }
	  /**
	   * 查看数据
	   * @param request
	   * @param response
	   * @return
	   */
	  @RequestMapping("look.do")
	  public  String look(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object>  res = this.noticeInfoService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/train/noticeInfo/look";
	  }
	  
	  /**
	   * 保存单位
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("save.do")
	  public  void save(HttpServletRequest request, HttpServletResponse response,String[] xdId,String[] xkId) throws Exception{
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			  parameter.put("creator", userMap.get("id"));
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  this.noticeInfoService.add(n_parameter);//添加
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
			  this.noticeInfoService.update(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"保存成功");
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
		  JSONObject jsonObj = this.noticeInfoService.findPageBean(parameter);
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
		  this.noticeInfoService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
}
