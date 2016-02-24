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

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.ExtendDate;
import com.go.common.util.JSONUtil;
import com.go.common.util.SysUtil;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.CodeDataService;
import com.go.service.baseinfo.CodeTypeService;
/**
 * 字典数据管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/baseinfo/codeData")
public class CodeDataController extends BaseController {
	  @Resource
	  private  CodeDataService  codeDataService;
	  @Resource
	  private  CodeTypeService  codeTypeService;
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/baseinfo/codeData/list";
	  }
	  
	  /**
	   * 根据条件查询所有
	   * @return
	   */
	  @RequestMapping("all.do")
	  public  void all(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  List<Map<String,Object>>  list = this.codeDataService.findAll(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
	  }
	  
	  /**
	   * 添加数据页面
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> res=new HashMap<String, Object>();
		  if(parameter.containsKey("id")){
			  parameter=codeTypeService.load(parameter);
			  res.put("typeId", parameter.get("id"));
			  res.put("typeName", parameter.get("name"));
		  }
		  model.addAttribute("vo", res);
		  return  "admin/baseinfo/codeData/edit";
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
		  Map<String,Object>  res = this.codeDataService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/baseinfo/codeData/edit";
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
			  this.codeDataService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
			  this.codeDataService.update(parameter);
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
		  JSONObject jsonObj = this.codeDataService.findPageBean(parameter);
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
		  this.codeDataService.delete(parameter);
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
		this.codeDataService.updatestat(parameter);
	}
}
