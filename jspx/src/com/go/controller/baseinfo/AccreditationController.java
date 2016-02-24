package com.go.controller.baseinfo;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.SysUtil;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.AccreditationService;
import com.go.service.baseinfo.AttendanceInfoService;
import com.go.service.baseinfo.ClassInfoService;
import com.go.service.baseinfo.HomeWorkService;
/**
 * 资格确认
 * @author chenhb
 * @create_time  2015-9-28 下午2:02:59
 */
@Controller
@RequestMapping("/baseinfo/accreditation")
public class AccreditationController extends BaseController {
	  @Resource
	  private  AccreditationService  accreditationService;
	  @Resource
	  private  ClassInfoService  classInfoService;
	  @Resource
	  private  AttendanceInfoService  attendanceInfoService;
	  @Autowired
	  private HomeWorkService homeworkService;
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/baseinfo/accreditation/list";
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
			  if(!parameter.containsKey("classId")){
				  parameter.put("classId", classInfo.get("id"));
			  }
		  }
		  JSONObject jsonObj = this.accreditationService.findPageBean(parameter);
		  this.ajaxData(response, jsonObj.toJSONString());
	  }
	  /**
	   * 考勤列表
	   * @author chenhb
	   * @create_time  2015-9-28 下午5:31:05
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   * @throws Exception
	   */
	  @RequestMapping("attendance.do")
	  public String attendance(HttpServletRequest request, HttpServletResponse response,Model  model) throws Exception{
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  Map<String,Object> map=attendanceInfoService.statisticsDetail(parameter);
		  model.addAttribute("map", map);
		  return "admin/baseinfo/accreditation/attendance";
	  }
	  
	  /**
	   * 加载作业汇总数据列表
	   * @author zhangjf
	   * @create_time 2015-9-29 上午11:38:06
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("homework.do")
	  public String homework(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  Map<String,Object> map=homeworkService.collect(parameter);
		  model.addAttribute("map", map);
		  return "admin/baseinfo/accreditation/homework";
	  }
	  
	  /**
	   * 是否通过确认
	   * @author chenhb
	   * @create_time  2015-9-28 下午5:31:34
	   * @param request
	   * @param response
	   */
		@RequestMapping("isPass")
		public void isPass(HttpServletRequest request,HttpServletResponse response){
			Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
			Object obj=parameter.get("isPass");
			if("1".equals(obj)){
				 this.ajaxMessage(response, Syscontants.MESSAGE,"确认通过成功");
			}else{
				this.ajaxMessage(response, Syscontants.MESSAGE,"确认未通过成功");
			}
			this.accreditationService.updatePass(parameter);
		}
}
