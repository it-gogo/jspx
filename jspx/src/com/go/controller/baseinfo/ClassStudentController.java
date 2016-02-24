
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.ExtendDate;
import com.go.common.util.ImportInfo;
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.ClassStudentService;
import com.go.service.baseinfo.QuotaAllocationService;
import com.go.service.baseinfo.UnitInfoService;
/**
 * 班级学员管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/baseinfo/classStudent")
public class ClassStudentController extends BaseController {
	  @Resource
	  private  ClassStudentService  classStudentService;
	  @Resource
	  private  QuotaAllocationService  quotaAllocationService;
	  @Resource
	  private  UnitInfoService  unitInfoService;
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(HttpServletRequest request,Model  model,String classId){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  model.addAttribute("vo",parameter);
		  return  "admin/baseinfo/classStudent/list";
	  }
	  /**
	   * 添加数据页面(单位)
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  if(parameter.containsKey("xdIds")){
			  String xdIds=parameter.get("xdIds").toString();
			  xdIds=xdIds.replaceAll(",", "','");
			  xdIds="'"+xdIds+"'";
			  parameter.put("xdIds", xdIds);
		  }
		  if(parameter.containsKey("xkIds")){
			  String xkIds=parameter.get("xkIds").toString();
			  xkIds=xkIds.replaceAll(",", "','");
			  xkIds="'"+xkIds+"'";
			  parameter.put("xkIds", xkIds);
		  }
		  model.addAttribute("vo",parameter);
		  return  "admin/baseinfo/classStudent/edit";
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
		  Map<String,Object>  res = this.classStudentService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/baseinfo/classStudent/edit";
	  }
	  
	  
	  /**
	   * 添加班级学员
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("save.do")
	  public  void save(HttpServletRequest request, HttpServletResponse response,String[] studentId) throws Exception{
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
			List<String>  listParameter = new ArrayList<String>();
			if(studentId!=null&&studentId.length>0){
				for(int i=0;i<studentId.length;i++){
					listParameter.add(studentId[i]);
				}
			}else{
				 this.ajaxMessage(response, Syscontants.ERROE,"保存失败，至少保存一条数据。");
				 return;
			}
			List<Map<String,Object>> schoolNum=classStudentService.getSchoolNum(listParameter);
			List<Map<String,Object>> quotaAllocationList=quotaAllocationService.findAll(parameter);
			if(quotaAllocationList!=null && quotaAllocationList.size()>0){
				Map<String,Object> res=new HashMap<String, Object>();
				List<Map<String,Object>> resList=new ArrayList<Map<String,Object>>();
				for(Map<String,Object> quotaAllocation:quotaAllocationList){
					res.put(quotaAllocation.get("schoolId").toString(), quotaAllocation);
				}
				List<String> arr=new ArrayList<String>();
				for(Map<String,Object> num:schoolNum){
					Object schoolId=num.get("schoolId");
					arr.add(schoolId.toString());
					if(res.containsKey(schoolId)){
						Map<String,Object> quotaAllocation=(Map<String, Object>) res.get(schoolId);
						Map<String,Object> map=new HashMap<String, Object>();
						map.put("schoolId", schoolId);//学校ID
						map.put("schoolName", quotaAllocation.get("schoolName"));//学校名称
						map.put("num", quotaAllocation.get("number"));//总数
						map.put("numing", num.get("num"));//将插入数
						resList.add(map);
					}
				}
				parameter.put("list", arr);
				List<Map<String,Object>> studentList=classStudentService.findNum(parameter);
				Map<String,Object> student=new HashMap<String, Object>();
				if(studentList!=null && studentList.size()>0){
					for(Map<String,Object> m:studentList){
						student.put(m.get("schoolId").toString(), m);
					}
				}
				for(Map<String,Object> m:resList){
					Object schoolId=m.get("schoolId");
					int num=(Integer) m.get("num");
					long numing=(Long) m.get("numing");
					long numed=0;//已插入数
					if(student.containsKey(schoolId)){
						numed=(Long) ((Map<String,Object>)student.get(schoolId)).get("num");
					}
					if(num<(numing+numed)){//已插入数加将查人数大于总数
						this.ajaxMessage(response, Syscontants.ERROE,"保存失败，"+m.get("schoolName")+"名额过多！");
						 return;
					}
				}
			}
		  
		 
//		  parameter.put("id", SqlUtil.uuid());
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  parameter.put("creator", userMap.get("id"));
		  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
		  List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		  Object classId=parameter.get("classId");
		  if(studentId!=null){
			  for(String sid:studentId){
				  Map<String,Object> map=new HashMap<String, Object>();
				  map.put("id", SqlUtil.uuid());
				  map.put("classId", classId);
				  map.put("studentId", sid);
				  list.add(map);
			  }
		  }
		  if(list.size()==0){
			  this.ajaxMessage(response, Syscontants.ERROE,"保存失败，至少保存一条数据。");
		  }else{
			  parameter.put("list", list);
			  this.classStudentService.batchAdd(parameter);
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
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  Map<String,Object> unitInfo=new HashMap<String, Object>();
		  unitInfo.put("userId", userMap.get("id"));
		  unitInfo=this.unitInfoService.findOne(unitInfo);
		  if(unitInfo!=null){
			  parameter.put("flag", unitInfo.get("flag"));
		  }
		  JSONObject jsonObj = this.classStudentService.findPageBean(parameter);
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
		  this.classStudentService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
	  
	  
	  /**
	   * 初始化(用于分数填写)
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirectScores.do")
	  public String redirectScores(HttpServletRequest request,Model  model,String classId){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  model.addAttribute("vo",parameter);
		  return  "admin/baseinfo/classStudent/scoresList";
	  }
	  /**
	   * 填写分数
	   * @author chenhb
	   * @create_time  2015-9-25 下午3:17:23
	   * @param request
	   * @param response
	   */
	  @RequestMapping("scores.do")
	  public void scores(HttpServletRequest request, HttpServletResponse response){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  this.classStudentService.scores(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "录入成功");
	  }
	  /**
	   * 导入分数
	   * @author chenhb
	   * @create_time {date} 上午9:11:46
	   * @param request
	   * @param response
	   * @throws Exception
	   */
	  @RequestMapping("importScores.do")
	  public void importInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		  String[]  header = new String[]{
				"学员姓名","性别","学校","培训班","考试分数"
			};  
		  
		  MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
	         /**页面控件的文件流**/      
	        MultipartFile multipartFile = multipartRequest.getFile("fileId");   
	        List<String[]> list=ImportInfo.importFile(multipartFile.getInputStream(),header);
	        if(list==null){
	        	this.ajaxMessage(response, Syscontants.ERROE,"添加失败，格式错误!");
	        	return ;
	        }
	        String str=classStudentService.addScores(list);
	        if(str==null || "".equals(str)){
	        	this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功!");
	        }else{
	        	this.ajaxMessage(response, Syscontants.MESSAGE,str);
	        }
	  }
}
