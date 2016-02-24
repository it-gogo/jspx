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

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.go.common.util.ExtendDate;
import com.go.common.util.JSONUtil;
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.ClassInfoService;
import com.go.service.baseinfo.ClassTimeService;
import com.go.service.baseinfo.UnitInfoService;
import com.go.service.baseinfo.UseLessonService;
/**
 * 上课时间管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/baseinfo/classTime")
public class ClassTimeController extends BaseController {
	  @Resource
	  private  ClassTimeService  classTimeService;
	  @Resource
	  private  ClassInfoService  classInfoService;
	  @Resource
	  private  UnitInfoService  unitInfoService;
	  @Resource
	  private  UseLessonService  useLessonService;
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/baseinfo/classTime/list";
	  }
	  
	  /**
	   * 添加数据页面
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object> parameter=new HashMap<String,Object>();
		  Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前用户
		  return  "admin/baseinfo/classTime/edit";
	  }  
	  
	  /**
	   * 查询学校
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
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  parameter.put("userId", userMap.get("id"));
		  Map<String,Object> classInfo=classInfoService.findOne(parameter);
		  if(classInfo==null){//不是班主任
			  parameter.remove("userId");
		  }
		  List<Map<String,Object>> list=classTimeService.findTree(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
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
		  Map<String,Object>  res = this.classTimeService.load(parameter);
		  model.addAttribute("vo", res);
		  return "forward:add.do";
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
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  parameter.put("userId", userMap.get("id"));
		  parameter.put("isEdb", "1");
		  Map<String,Object> unitInfo=unitInfoService.findOne(parameter);
		  Map<String,Object> classInfo=classInfoService.findOne(parameter);
		  if(unitInfo==null && classInfo==null){//不是教育局管理账号也不是班主任账号
			  this.ajaxMessage(response, Syscontants.ERROE,"保存失败，只有班主任或者教育局管理账号才能操作。");
			  return;
		  }
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  parameter.put("id", SqlUtil.uuid());
		  }
		  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  parameter.put("creator", user.get("id"));
		  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
		  
		  if(parameter.containsKey("data")){
			  Object data=parameter.get("data");
				JSONObject jsonObj=JSON.parseObject(data.toString());
				JSONArray jsonArr=JSONArray.parseArray(jsonObj.get("rows").toString());
				List<Map<String,Object>> useLessonList=new ArrayList<Map<String,Object>>();
				for(int i=0;i<jsonArr.size();i++){
					Map<String,Object> map=new HashMap<String, Object>();
					JSONObject obj=jsonArr.getJSONObject(i);
					int lesson=0;
					Object o=obj.get("lesson");
					if(o!=null && !"".equals(o)){
						lesson=Integer.parseInt(o.toString());
					}
					int totalLesson=0;
					o=obj.get("totalLesson");
					if(o!=null && !"".equals(o)){
						totalLesson=Integer.parseInt(o.toString());
					}
					int useLesson=0;
					o=obj.get("useLesson");
					if(o!=null && !"".equals(o)){
						useLesson=Integer.parseInt(o.toString());
					}
					if(lesson<totalLesson+useLesson){
						this.ajaxMessage(response, Syscontants.ERROE,"保存失败，"+obj.getString("subjectName")+"科目课时数量已超过最大课时。");
						return;
					}
					if(useLesson!=0){
						map.put("useLessonId", SqlUtil.uuid());
						map.put("lessonId", obj.getString("id"));
						map.put("useLesson", useLesson);
						useLessonList.add(map);
					}
				}
				if(useLessonList!=null && useLessonList.size()>0){
					parameter.put("list", useLessonList);
					parameter.put("classTimeId", parameter.get("id"));
					useLessonService.deleteByMap(parameter);
					useLessonService.batchAdd(parameter);
				}
		  }
		 
		  if(isIDNull){
			  this.classTimeService.add(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
			  this.classTimeService.update(parameter);
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
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  Map<String,Object> classInfo=new HashMap<String, Object>();
		  classInfo.put("userId", userMap.get("id"));
		  classInfo=classInfoService.findOne(classInfo);
		  if(classInfo!=null){//是班主任
			  parameter.put("bzrUserId", userMap.get("id"));
		  }
		  JSONObject jsonObj = this.classTimeService.findPageBean(parameter);
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
		  this.classTimeService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
}
