package com.go.controller.resources;

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
import com.go.common.util.SysUtil;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.resources.TopFolderService;
/**
 * 顶级文件夹
 * @author chenhb
 * @create_time  2015-11-26 下午2:52:30
 */
@Controller
@RequestMapping("/resources/topFolder")
public class TopFolderController extends BaseController {
	  @Resource
	  private  TopFolderService  topFolderService;
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/resources/topFolder/list";
	  }
	  /**
	   * 添加数据页面
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  return  "admin/resources/topFolder/edit";
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
		  Map<String,Object>  res = this.topFolderService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/resources/topFolder/edit";
	  }
	  /**
	   * 保存
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
			  //添加菜单
			  this.topFolderService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
			  
		  }else{
			  this.topFolderService.update(parameter);
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
		  JSONObject jsonObj = this.topFolderService.findPageBean(parameter);
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
		  this.topFolderService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
	  
	  /**
	 *更新数据状态
	 * @param request
	 * @param response
	 */
	  @RequestMapping("changestatus")
		public void changestatus(HttpServletRequest request,HttpServletResponse response){
			Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
			Object obj=parameter.get("status");
			if("禁用".equals(obj)){
				 this.ajaxMessage(response, Syscontants.MESSAGE,"启用成功");
				 parameter.put("status", "启用");
			}else{
				 parameter.put("status", "禁用");
				this.ajaxMessage(response, Syscontants.MESSAGE,"禁用成功");
			}
			this.topFolderService.changeStatus(parameter);
		}
}
