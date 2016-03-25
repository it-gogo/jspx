package com.go.controller.site;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.ExtendDate;
import com.go.common.util.JSONUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.site.SectionManagementService;

/**
 * 文章栏目管理控制器
 * @author zhangjf
 * @create_time 2016-3-24 下午5:50:38
 */
@Controller
@RequestMapping("/site/sectionManagement")
public class SectionManagementController extends BaseController {
	  @Resource
	  private  SectionManagementService  sectionManagementService;
	  
	  
	  /**
	   * 初始化（oa栏目）
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirectOA.do")
	  public String redirectOA(HttpServletRequest request, Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  model.addAttribute("vo", parameter);
		  return  "admin/site/sectionManagement/list";
	  }
	  /**
	   * 添加数据页面（oa栏目）
	   * @return
	   */
	  @RequestMapping("addOA.do")
	  public  String addOA(HttpServletRequest request,HttpServletResponse response,Model  model){
		  return  "admin/site/sectionManagement/edit";
	  }  
	  /**
	   * 导出数据（oa栏目）
	   * @param request
	   * @param response
	   * @return
	   */
	  @RequestMapping("loadOA.do")
	  public  String load(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object>  res = this.sectionManagementService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/site/sectionManagement/edit";
	  }
	  /**
	   * 查询所有
	   * @author chenhb
	   * @create_time  2015-8-19 上午9:31:51
	   * @param request
	   * @param response
	   * @param model
	   */
	  @RequestMapping("all.do")
	  public  void all(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  List<Map<String,Object>>  list = this.sectionManagementService.findAll(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
	  }
	  /**
	   * 栏目树
	   * @author chenhb
	   * @create_time  2015-10-9 上午9:28:54
	   * @param request
	   * @param response
	   * @param model
	   */
	  @RequestMapping("tree.do")
	  public  void tree(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  
		  List<Map<String,Object>>  list = this.sectionManagementService.tree(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
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
		  MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
		   /**得到图片保存目录的真实路径**/      
	        String logoRealPathDir = request.getSession().getServletContext().getRealPath("admin/wechatPic");     
	        /**根据真实路径创建目录**/      
	        File logoSaveFile = new File(logoRealPathDir);       
	        if(!logoSaveFile.exists())       
	            logoSaveFile.mkdirs();             
	         /**页面控件的文件流**/      
	        /**页面控件的文件流**/
	       MultipartFile multipartFile = multipartRequest.getFile("picFile");   
	       //文件后缀
	       String suffix=StringUtils.isNotBlank(multipartFile.getOriginalFilename())?multipartFile.getOriginalFilename():"";
	       if(suffix!=null && !"".equals(suffix)){
	    	   String[] suff = suffix.split("\\.");
	    	   String fileName=new SimpleDateFormat("yyyy-MM-dd HH_mm_ss_SSS").format(new Date())+"";
	    	   if(suff.length>1){
	    		   fileName +="."+suff[suff.length-1];
	    	   }
	    	   Util.saveFileFromInputStream(multipartFile.getInputStream(), logoRealPathDir, fileName);
	    	   parameter.put("picUrl", "admin/wechatPic/"+fileName);
	       }
		  
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  parameter.put("creator", userMap.get("id"));
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  //添加菜单
			  this.sectionManagementService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
			  
		  }else{
			  this.sectionManagementService.update(parameter);
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
		  JSONObject jsonObj = this.sectionManagementService.findPageBean(parameter);
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
		  this.sectionManagementService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
  /**
	 *更新数据状态
	 * @param request
	 * @param response
	 */
	@RequestMapping("changeStatus")
	public void changeStatus(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		Object obj=parameter.get("status");
		if("禁用".equals(obj)){
			 this.ajaxMessage(response, Syscontants.MESSAGE,"启用成功");
			 parameter.put("status", "启用");
		}else{
			 parameter.put("status", "禁用");
			this.ajaxMessage(response, Syscontants.MESSAGE,"禁用成功");
		}
		this.sectionManagementService.changeStatus(parameter);
	}
}
