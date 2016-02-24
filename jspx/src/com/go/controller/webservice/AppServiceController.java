package com.go.controller.webservice;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.go.common.util.ExtendDate;
import com.go.common.util.SqlUtil;
import com.go.controller.base.BaseController;
import com.go.service.baseinfo.ArtificialAttendanceService;
import com.go.service.baseinfo.AttendanceInfoService;
import com.go.service.baseinfo.ClassInfoService;
import com.go.service.baseinfo.TeacherInfoService;
import com.go.service.platform.UserInfoService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;


/**
 * app应用接口
 * @author zhangjf
 * @create_time 2015-9-30 上午9:50:29
 */
@Controller
@RequestMapping("/webservice/app/*")
@SuppressWarnings("all")
public class AppServiceController extends BaseController {

	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private AttendanceInfoService attendanceInfoService;
	@Autowired
	private ClassInfoService classInfoService;
	@Autowired
	private TeacherInfoService teacherInfoService;
	@Autowired
	private ArtificialAttendanceService artificalAttendanceService;
	
	/**
	 * app进行登陆验证操作
	 * @author zhangjf
	 * @create_time 2015-9-30 上午9:55:25
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("login.do")
	public @ResponseBody Map<String,Object> login(HttpServletRequest request,HttpServletResponse response){
		 Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		 Map<String,Object> msg=new HashMap<String, Object>();
		 //1.校验提交参数
		 if(!parameter.containsKey("username")||!parameter.containsKey("password")){
			 msg.put("isSuccess", "false");
			 msg.put("message", "参数异常,登陆失败");
			 return msg;
		 }
		 try {
			 msg=userInfoService.appLogin(parameter);
			 
			 if(msg==null||msg.isEmpty()){
				 msg=new HashMap<String, Object>();
				 msg.put("isSuccess", "false");
				 msg.put("message", "用户名或密码错误！");
			 }else{
				 msg.put("isSuccess", "true");
				 msg.put("message", "获取成功");
			 }
		} catch (Exception e) {
			e.printStackTrace();
			 msg.put("isSuccess", "false");
			 msg.put("message", "系统繁忙,请稍后重试！");
		}
		 return msg;
	}
	
	/**
	 * 上传签到数据
	 * @author zhangjf
	 * @create_time 2015-9-30 上午11:20:14
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("uploadData.do")
	public @ResponseBody Map<String,Object> uploadData(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);//获取请求参数
		Map<String,Object> msg=new HashMap<String, Object>();
		 if(!parameter.containsKey("studentList")){
			 msg.put("isSuccess", "false");
			 msg.put("message", "参数异常,上传失败");
			 return msg;
		 }
		
		try {
			/*String jsonStr="{data:[" +
									"{\"idcard\":\"350122155648542121\",\"ip\":\"app_1\",\"type\":\"1\",\"attendanceDate\":\"2015/09/14 16:00:08\"}," +
									"{\"idcard\":\"350205200706163022\",\"ip\":\"app_2\",\"type\":\"2\",\"attendanceDate\":\"2015/09/14 18:00:08\"}," +
									"{\"idcard\":\"350122155648542223\",\"ip\":\"app_3\",\"type\":\"1\",\"attendanceDate\":\"2015/09/14 20:00:08\"}" +
									"]" +
									"}";*/
			String jsonStr=parameter.get("studentList")==null?"":parameter.get("studentList").toString();
			//JSONArray jsonary=JSONArray.fromObject(jsonStr);
			JSONObject json=JSONObject.fromObject(jsonStr);
			String data=json.getString("data");
			GsonBuilder builder = new GsonBuilder();
			Gson gson = builder.create();
			//2.上传数据列表
			List<Map<String,Object>> mapList = gson.fromJson(data, new TypeToken<List<Map<String,Object>>>(){}.getType());
			String rs=attendanceInfoService.appAttendance(mapList);
			if(StringUtils.isBlank(rs)){
				 msg.put("isSuccess", "true");
				 msg.put("message", "签到成功！");
				 return msg;
			}else{
				 msg.put("isSuccess", "false");
				 msg.put("message", rs);
				 return msg;
			}
		}catch(RuntimeException re){
			re.printStackTrace();
			msg.put("isSuccess", "false");
			msg.put("message", re.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			msg.put("isSuccess", "false");
			msg.put("message", "系统繁忙,请稍后重试！");
		}
		return msg;
	}
	
	/**
	 * 加载学生列表接口
	 * @author zhangjf
	 * @create_time 2015-9-30 下午2:59:40
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("loadStudent.do")
	public @ResponseBody Map<String,Object> loadStudent(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);//获取请求参数
		Map<String,Object> msg=new HashMap<String, Object>();
		if(parameter.isEmpty()||!parameter.containsKey("teacherCardNum")){
			msg.put("isSuccess", "false");
			msg.put("message", "参数错误,获取列表失败！");
			return msg;
		}
		String id_card_no=parameter.get("teacherCardNum")==null?"":parameter.get("teacherCardNum").toString();
		//String id_card_no="350205200908013020";
		if(StringUtils.isNotBlank(id_card_no)){
			//1.先判断当前账号是否为班主任
			try {
				Map<String,Object> params=new HashMap<String, Object>();
				params.put("id_card_no", id_card_no);
				List<Map<String,Object>> classMasters=classInfoService.isMaster(params);
				if(classMasters==null&&classMasters.isEmpty()){
					msg.put("isSuccess", "false");
					msg.put("message", "当前身份证号不属于 班主任！");
					return msg;
				}
				String ids="";
				//2.获取管理的班级ID
				for (Map<String, Object> classMap : classMasters) {
					ids+=StringUtils.isBlank(ids)?classMap.get("id").toString():","+classMap.get("id").toString();
				}
				params.put("ids", ids);
				List<Map<String,Object>> stuList=teacherInfoService.listByParams(params);
				msg.put("studentList", stuList);
				msg.put("isSuccess", "true");
				msg.put("message", "获取成功！");
			} catch (Exception e) {
				e.printStackTrace();
				msg.put("isSuccess", "false");
				msg.put("message", "系统繁忙,请稍后重试！");
			}
		}else{
			msg.put("isSuccess", "false");
			msg.put("message", "未找到身份证号参数！");
			
		}
		return msg;
	}
	
	/**
	 * 同步数据接口
	 * @author zhangjf
	 * @create_time 2015-10-14 下午1:59:34
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("synData.do")
	public @ResponseBody Map<String,Object> synData(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object>msg=new HashMap<String, Object>();
		try {
			/**
			 * 第一步:查询登陆用户信息列表
			 */
			 List<Map<String,Object>> teachers=userInfoService.listLoginInfo();
			 msg.put("teachers", teachers);
			/**
			 * 第二步:获取所有学生数据
			 */
			 List<Map<String,Object>> students=teacherInfoService.synStudents();
			 msg.put("students", students);
			 msg.put("isSuccess", "true");
			 msg.put("message", "获取同步数据成功！");
		} catch (Exception e) {
			e.printStackTrace();
			msg.put("isSuccess", "fasle");
			msg.put("message", "系统繁忙,同步数据列表失败！");
		}
		return msg;
	}
	
	
	
}
