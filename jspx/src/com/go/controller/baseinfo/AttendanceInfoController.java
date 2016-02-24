package com.go.controller.baseinfo;

import java.io.OutputStream;
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
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.AttendanceInfoService;
import com.go.service.baseinfo.ClassInfoService;
import com.go.service.baseinfo.ClassTimeService;
/**
 * 考勤信息管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/baseinfo/attendanceInfo")
public class AttendanceInfoController extends BaseController {
	  @Resource
	  private  AttendanceInfoService  attendanceInfoService;
	  @Resource
	  private  ClassTimeService  classTimeService;
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
		  return  "admin/baseinfo/attendanceInfo/list";
	  }
	  /**
	   *总 统计页面
	   * @return
	 * @throws Exception 
	   */
	  @RequestMapping("summaryStatistics.do")
	  public  String summaryStatistics(HttpServletRequest request,HttpServletResponse response,Model  model) throws Exception{
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  model.addAttribute("vo", parameter);
		  Map<String,Object> classInfo=new HashMap<String, Object>();
		  classInfo.put("id", parameter.get("classId"));
		  classInfo=classInfoService.load(classInfo);
		  model.addAttribute("classInfo", classInfo);
		  return  "admin/baseinfo/attendanceInfo/summaryStatistics";
	  }  
	  /**
		 * 总统计列表
		 * @author chenhb
		 * @create_time  2015-8-17 上午11:09:26
		 * @param request
		 * @param response
		 * @param model
		 * @throws Exception
		 */
		  @RequestMapping("summaryStatisticsList.do")
		  public  void  summaryStatisticsList(HttpServletRequest request, HttpServletResponse response,Model  model) throws Exception{
			  Map<String,Object> parameter = sqlUtil.queryParameter(request);
			  List<Map<String,Object>> list = this.attendanceInfoService.summaryStatistics(parameter);
			  JSONObject  jsonobj = new JSONObject();
			  jsonobj.put("rows", list);
			  this.ajaxData(response, jsonobj.toJSONString());
		  }
		  @RequestMapping("summaryStatisticsXLS.do")
		  public  void  summaryStatisticsXLS(HttpServletRequest request, HttpServletResponse response,Model  model) throws Exception{
			  Map<String,Object> parameter = sqlUtil.queryParameter(request);
			  List<Map<String,Object>> list = this.attendanceInfoService.summaryStatistics(parameter);
			  String[] header={"姓名","性别","附属学校","总节数","准到","迟到","旷课","早退","准退"};
			  List<String[]> res=new ArrayList<String[]>();
			  for(Map<String,Object> map:list){
				  String studentName=map.get("studentName").toString();
				  String sex=map.get("sex").toString();
				  if("1".equals(sex)){
					  sex="男";
				  }else{
					  sex="女";
				  }
				  String schoolName=map.get("schoolName").toString();
				  String total=map.get("total").toString();
				  String zd=map.get("zd").toString();
				  String cd=map.get("cd").toString();
				  String kk=map.get("kk").toString();
				  String zaot=map.get("zaot").toString();
				  String zt=map.get("zt").toString();
				  String[] arr={studentName,sex,schoolName,total,zd,cd,kk,zaot,zt};
				  res.add(arr);
			  }
			  OutputStream os = response.getOutputStream();  
		      String tempName=ExtendDate.getYMD_h_m_s(new Date())+".xls";
		      try {  
		    	  response.reset();  
		    	  response.setHeader("Content-Disposition", "attachment; filename="+tempName);  
		    	  response.setContentType("application/octet-stream; charset=utf-8");
		    	  Util.createExcel(os, header, res);
		          os.flush();  
		      } finally {  
		          if (os != null) {  
		              os.close();  
		          }  
		      }  
		  }
		  @RequestMapping("statisticsXLS.do")
		  public  void  statisticsXLS(HttpServletRequest request, HttpServletResponse response,Model  model) throws Exception{
			  Map<String,Object> parameter = sqlUtil.queryParameter(request);
			  List<Map<String,Object>> list = this.attendanceInfoService.statistics(parameter);
			  String[] header={"姓名","性别","附属学校","上课状态","下课状态"};
			  List<String[]> res=new ArrayList<String[]>();
			  for(Map<String,Object> map:list){
				  String studentName=map.get("studentName").toString();
				  String sex=map.get("sex").toString();
				  if("1".equals(sex)){
					  sex="男";
				  }else{
					  sex="女";
				  }
				  String schoolName=map.get("schoolName")==null?"":map.get("schoolName").toString();
				  String classStatus=map.get("classStatus")==null?"":map.get("classStatus").toString();
				  String classFinishStatus=map.get("classFinishStatus")==null?"":map.get("classFinishStatus").toString();
				  String[] arr={studentName,sex,schoolName,classStatus,classFinishStatus};
				  res.add(arr);
			  }
			  OutputStream os = response.getOutputStream();  
		      String tempName=ExtendDate.getYMD_h_m_s(new Date())+".xls";
		      try {  
		    	  response.reset();  
		    	  response.setHeader("Content-Disposition", "attachment; filename="+tempName);  
		    	  response.setContentType("application/octet-stream; charset=utf-8");
		    	  Util.createExcel(os, header, res);
		          os.flush();  
		      } finally {  
		          if (os != null) {  
		              os.close();  
		          }  
		      }  
		  }
	  /**
	   * 统计页面
	   * @return
	 * @throws Exception 
	   */
	  @RequestMapping("statistics.do")
	  public  String statistics(HttpServletRequest request,HttpServletResponse response,Model  model) throws Exception{
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  model.addAttribute("vo", parameter);
		  Map<String,Object> classTime=classTimeService.findOne(parameter);
		  model.addAttribute("classTime", classTime);
		  return  "admin/baseinfo/attendanceInfo/statistics";
	  }  
	/**
	 * 统计列表
	 * @author chenhb
	 * @create_time  2015-8-17 上午11:09:26
	 * @param request
	 * @param response
	 * @param model
	 * @throws Exception
	 */
	  @RequestMapping("statisticsList.do")
	  public  void  statisticsList(HttpServletRequest request, HttpServletResponse response,Model  model) throws Exception{
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  List<Map<String,Object>> list = this.attendanceInfoService.statistics(parameter);
		  JSONObject  jsonobj = new JSONObject();
		  jsonobj.put("rows", list);
		  this.ajaxData(response, jsonobj.toJSONString());
	  }
	  /**
	   * 统计自定义
	   * @author chenhb
	   * @create_time  2015-9-25 上午8:59:59
	   * @param request
	   * @param response
	   * @param model
	   * @throws Exception
	   */
	  @RequestMapping("statisticsZDYlist.do")
	  public void statisticsZDYlist(HttpServletRequest request, HttpServletResponse response,Model  model) throws Exception{
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  List<Map<String,Object>> list = this.attendanceInfoService.statisticsZDY(parameter);
		  JSONObject  jsonobj = new JSONObject();
		  jsonobj.put("rows", list);
		  this.ajaxData(response, jsonobj.toJSONString());
	  }
	  /**
	   *总 统计页面
	   * @return
	 * @throws Exception 
	   */
	  @RequestMapping("statisticsZDY.do")
	  public  String statisticsZDY(HttpServletRequest request,HttpServletResponse response,Model  model) throws Exception{
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  model.addAttribute("vo", parameter);
		  Map<String,Object> classInfo=new HashMap<String, Object>();
		  classInfo.put("id", parameter.get("classId"));
		  classInfo=classInfoService.load(classInfo);
		  model.addAttribute("classInfo", classInfo);
		  if(parameter.containsKey("classTimeId")){
			  Map<String,Object> classTime=new HashMap<String, Object>();
			  classTime.put("id", parameter.get("classTimeId"));
			  classTime=classTimeService.load(classTime);
			  model.addAttribute("classTime", classTime);
		  }
		  return  "admin/baseinfo/attendanceInfo/statisticsZDY";
	  }  
	  @RequestMapping("statisticsZDYXLS.do")
	  public  void  statisticsZDYXLS(HttpServletRequest request, HttpServletResponse response,Model  model) throws Exception{
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  List<Map<String,Object>> list = this.attendanceInfoService.statisticsZDY(parameter);
		  String[] header={"姓名","性别","附属学校","总节数","准到","迟到","旷课","早退","准退"};
		  List<String[]> res=new ArrayList<String[]>();
		  for(Map<String,Object> map:list){
			  String studentName=map.get("studentName").toString();
			  String sex=map.get("sex").toString();
			  if("1".equals(sex)){
				  sex="男";
			  }else{
				  sex="女";
			  }
			  String schoolName=map.get("schoolName").toString();
			  String total=map.get("total").toString();
			  String zd=map.get("zhundao").toString();
			  String cd=map.get("chidao").toString();
			  String zaot=map.get("zaotui").toString();
			  String zt=map.get("zhuntui").toString();
			  String kk=/*map.get("kk").toString()*/(Integer.parseInt(total)-Integer.parseInt(zd)-Integer.parseInt(cd)-Integer.parseInt(zaot)-Integer.parseInt(zt))+"";
			  String[] arr={studentName,sex,schoolName,total,zd,cd,kk,zaot,zt};
			  res.add(arr);
		  }
		  OutputStream os = response.getOutputStream();  
	      String tempName=ExtendDate.getYMD_h_m_s(new Date())+".xls";
	      try {  
	    	  response.reset();  
	    	  response.setHeader("Content-Disposition", "attachment; filename="+tempName);  
	    	  response.setContentType("application/octet-stream; charset=utf-8");
	    	  Util.createExcel(os, header, res);
	          os.flush();  
	      } finally {  
	          if (os != null) {  
	              os.close();  
	          }  
	      }  
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
		  if(!parameter.containsKey("studentId")){
			  this.ajaxMessage(response, Syscontants.ERROE,"添加失败，至少选择一个学员。");
			  return;
		  }
		  String studentId=parameter.get("studentId").toString();
		  String[] arr=studentId.split(",");
		  List<Map<String,Object>> res=new ArrayList<Map<String,Object>>();
		  if(arr!=null && arr.length>0){
			  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			  for(String str:arr){
				  Map<String,Object> map=new HashMap<String, Object>(parameter);
				  map.put("creator", user.get("id"));
				  map.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
				  map.put("studentId", str.trim());
				  map.put("id", SqlUtil.uuid());
				  res.add(map);
			  }
		  }else{
			  this.ajaxMessage(response, Syscontants.ERROE,"添加失败，至少选择一个学员。");
			  return;
		  }
		  
		  //添加菜单
		  if(res.size()>0){
			  parameter.put("list", res);
			  this.attendanceInfoService.addAll(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
			  this.ajaxMessage(response, Syscontants.ERROE,"添加失败");
		  }
	  }
	  
	  /**
	   * 更新
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("modify.do")
	  public  void modify(HttpServletRequest request, HttpServletResponse response) throws Exception{
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  this.attendanceInfoService.update(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE,"更新成功");
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
		  JSONObject jsonObj = this.attendanceInfoService.findPageBean(parameter);
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
		  this.attendanceInfoService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
}
