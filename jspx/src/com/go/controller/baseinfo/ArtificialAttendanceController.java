package com.go.controller.baseinfo;

import java.text.SimpleDateFormat;
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
import com.go.service.baseinfo.ArtificialAttendanceService;
import com.go.service.baseinfo.AttendanceInfoService;
/**
 * 人工考勤管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/baseinfo/artificialAttendance")
public class ArtificialAttendanceController extends BaseController {
	  @Resource
	  private  ArtificialAttendanceService  artificialAttendanceService;
	  @Resource
	  private  AttendanceInfoService  attendanceInfoService;
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/baseinfo/artificialAttendance/list";
	  }
	  
	  /**
	   * 添加数据页面
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object> parameter=new HashMap<String,Object>();
		  Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前用户
		  return  "admin/baseinfo/artificialAttendance/edit";
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
		  Map<String,Object>  res = this.artificialAttendanceService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/baseinfo/artificialAttendance/modify";
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
			  if("2".equals(parameter.get("categoryId"))){//忘带卡
				  for(String str:arr){
					  Map<String,Object> map=new HashMap<String, Object>(parameter);
					  Object attendanceDate=map.get("date");
					  if(attendanceDate!=null){
						  SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
						  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						  map.put("attendanceDate", sdf.format(sdf1.parse(attendanceDate.toString())));
					  }
					  
					  map.put("creator", user.get("id"));
					  map.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
					  map.put("studentId", str.trim());
					  map.put("id", SqlUtil.uuid());
					  res.add(map);
					  int attendanceId=attendanceInfoService.add(new HashMap<String, Object>(map));
					  map.put("attendanceId", attendanceId);
				  }
//				  if(res.size()>0){
//					  parameter.put("list", res);
//					  attendanceInfoService.addByArtificial(parameter);
//				  }
			  }else{//请假
				  for(String str:arr){
					  Map<String,Object> map=new HashMap<String, Object>(parameter);
					  map.put("creator", user.get("id"));
					  map.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
					  map.put("studentId", str.trim());
					  map.put("id", SqlUtil.uuid());
					  res.add(map);
				  }
			  }
		  }else{
			  this.ajaxMessage(response, Syscontants.ERROE,"添加失败，至少选择一个学员。");
			  return;
		  }
		  
		  //添加菜单
		  if(res.size()>0){
			  parameter.put("list", res);
			  this.artificialAttendanceService.addAll(parameter);
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
		  if(parameter.containsKey("attendanceId")){//存在考勤先删除在插入
			  List<String> list=new ArrayList<String>();
			  list.add(parameter.get("attendanceId").toString());
			  attendanceInfoService.delete(list);
			  parameter.put("attendanceId", null);
		  }
		  if("2".equals(parameter.get("categoryId"))){
			  parameter.put("attendanceId", SqlUtil.uuid());
			  Object attendanceDate=parameter.get("date");
			  if(attendanceDate!=null){
				  SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				  parameter.put("attendanceDate", sdf.format(sdf1.parse(attendanceDate.toString())));
			  }
			  int attendanceId=attendanceInfoService.add(new HashMap<String, Object>(parameter));
			  parameter.put("attendanceId", attendanceId);
//			  List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
//			  list.add(parameter);
//			  parameter.put("list", list);
//			  attendanceInfoService.addByArtificial(parameter);
		  }
		  this.artificialAttendanceService.update(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE,"更新成功");
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
		  JSONObject jsonObj = this.artificialAttendanceService.findPageBean(parameter);
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
		  this.artificialAttendanceService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
}
