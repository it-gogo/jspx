
package com.go.controller.baseinfo;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.ExtendDate;
import com.go.common.util.ImportInfo;
import com.go.common.util.JSONUtil;
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.ClassInfoService;
import com.go.service.baseinfo.TeacherInfoService;
import com.go.service.baseinfo.UnitInfoService;
import com.go.service.platform.UserInfoService;
/**
 * 单位组织机构管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/baseinfo/teacherInfo")
public class TeacherInfoController extends BaseController {
	  @Resource
	  private  TeacherInfoService  teacherInfoService;
	  @Resource
	  private  UserInfoService  userInfoService;
	  @Resource
	  private  UnitInfoService  unitInfoService;
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
		  return  "admin/baseinfo/teacherInfo/list";
	  }
	  @RequestMapping("tree.do")
	  public  void unitTree(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  Map<String,Object> unitInfo=new HashMap<String, Object>();
		  unitInfo.put("userId", userMap.get("id"));
		  unitInfo=this.unitInfoService.findOne(unitInfo);
		  if(unitInfo!=null){
			  parameter.put("flag", unitInfo.get("flag"));
		  }
		  List<Map<String,Object>> list=teacherInfoService.findTeacherTree(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
	  }
	  
	  /**
	   * 导入老师信息
	   * @author chenhb
	   * @create_time {date} 上午9:11:46
	   * @param request
	   * @param response
	   * @throws Exception
	   */
	  @RequestMapping("importInfo.do")
	  public void importInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		  String[]  header = new String[]{
					"姓名","性别","民族","党派","身份证","联系电话","家庭地址","QQ",
					"主科学段","主科学科","副科学段","副科学科","学校(学校管理员导入可以不填)","管理账号","管理密码"
				};  
		  MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
	         /**页面控件的文件流**/
	        MultipartFile multipartFile = multipartRequest.getFile("fileId");   
	        List<String[]> list=ImportInfo.importFile(multipartFile.getInputStream(),header);
	        if(list==null){
	        	this.ajaxMessage(response, Syscontants.ERROE,"添加失败，格式错误!");
	        	return ;
	        }
	        Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
	        Map<String,Object> unitInfo=new HashMap<String, Object>();
	        unitInfo.put("userId", userMap.get("id"));
	        unitInfo=unitInfoService.findOne(unitInfo);
	        String schoolId=null;
	        if(unitInfo!=null){
	        	schoolId=unitInfo.get("id").toString();
	        }
	        String str=teacherInfoService.addAll(list, schoolId,userMap.get("id"));
	        if(str==null || "".equals(str)){
	        	this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功!");
	        }else{
	        	this.ajaxMessage(response, Syscontants.MESSAGE,str);
	        }
	  }
	  
	  /**
	   * 添加数据页面(单位)
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  Map<String,Object> unitInfo=new HashMap<String, Object>();
		  unitInfo.put("userId", userMap.get("id"));
		  unitInfo=unitInfoService.findOne(unitInfo);
		  model.addAttribute("unitInfo", unitInfo);
		  return  "admin/baseinfo/teacherInfo/edit";
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
		  Map<String,Object>  res = this.teacherInfoService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "forward:add.do";
	  }
	  
	  
	  /**
	   * 保存单位
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
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  Map<String,Object> user=new HashMap<String, Object>();
			  Object userId=SqlUtil.uuid();
			  user.put("id", userId);
			  user.put("text", n_parameter.get("text"));
			  Object password=n_parameter.get("password");
			  if(password==null || "".equals(password)){
				  password="123456";
			  }
			  user.put("password", Util.Encryption(password.toString()));
			  user.put("type", "老师账号");
			  this.userInfoService.add(user);//添加用户
			  n_parameter.put("userId", userId);
			  this.teacherInfoService.add(n_parameter);//添加
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
			  if(sqlUtil.isIDNull(parameter,"userId")){//不存在用户
				  Map<String,Object> user=new HashMap<String, Object>();
				  Object userId= SqlUtil.uuid();
				  parameter.put("userId", userId);
				  user.put("id", userId);
				  user.put("text", parameter.get("text"));
				  Object password=parameter.get("password");
				  if(password==null || "".equals(password)){
					  password="123456";
				  }
				  user.put("password", Util.Encryption(password.toString()));
				  user.put("type", "老师账号");
				  this.userInfoService.add(user);//添加用户
			  }else{
				  Map<String,Object> user=new HashMap<String, Object>();
				  user.put("id", parameter.get("userId"));
				  user=userInfoService.load(user);
				  user.put("text", parameter.get("text"));
				  userInfoService.update(user);
			  }
			  this.teacherInfoService.update(parameter);
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
		  Map<String,Object> unitInfo=new HashMap<String, Object>();
		  unitInfo.put("userId", userMap.get("id"));
		  unitInfo=this.unitInfoService.findOne(unitInfo);
		  if(unitInfo!=null){
			  if(!parameter.containsKey("flag")){
				  parameter.put("flag", unitInfo.get("flag"));
			  }
		  }
		  
		  Map<String,Object> classInfo=new HashMap<String, Object>();
		  classInfo.put("userId", userMap.get("id"));
		  classInfo=classInfoService.findOne(classInfo);
		  if(classInfo!=null){//是班主任
			  parameter.put("classIdStr",classInfo.get("id"));
		  }
		  JSONObject jsonObj = this.teacherInfoService.findPageBean(parameter);
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
		  this.teacherInfoService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
  /**
	 *更新数据状态
	 * @param request
	 * @param response
	 */
	@RequestMapping("changestat")
	public void changestat(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		Object obj=parameter.get("isActives");
		if("1".equals(obj)){
			 this.ajaxMessage(response, Syscontants.MESSAGE,"启用成功");
			 parameter.put("isActives", "0");
		}else{
			 parameter.put("isActives", "1");
			this.ajaxMessage(response, Syscontants.MESSAGE,"禁用成功");
		}
		this.teacherInfoService.updatestat(parameter);
	}
}
