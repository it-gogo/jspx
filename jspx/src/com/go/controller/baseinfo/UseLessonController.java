
package com.go.controller.baseinfo;

import java.util.Date;
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
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.UseLessonService;
/**
 * 使用课时控制
 * @author chenhb
 * @create_time  2015-9-24 上午12:21:08
 */
@Controller
@RequestMapping("/baseinfo/useLesson")
public class UseLessonController extends BaseController {
	  @Resource
	  private  UseLessonService  useLessonService;
	  
	  
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
		  Map<String,Object> lesson=useLessonService.load(parameter);
		  if(lesson==null || lesson.size()==0){
			  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			  parameter.put("creator", userMap.get("id"));
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  this.useLessonService.add(parameter);//添加
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
			  this.useLessonService.update(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"保存成功");
		  }
	  }
	  
	  /**
	   * 查询选择课时列表
	   * @param request
	   * @param response
	   */ 
	  @RequestMapping("selectLesson.do")
	  public  void  selectLesson(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  JSONObject jsonObj = this.useLessonService.selectLesson(parameter);
		  this.ajaxData(response, jsonObj.toJSONString());
	  }
}
