package com.go.controller.site;

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
import com.go.service.site.ArticleTitleColorService;
/**
 * 文章标题颜色控制器
 * @author zhangjf
 * @create_time 2016-3-25 下午2:48:46
 */
@Controller
@RequestMapping("/site/articleTitleColor")
public class ArticleTitleColorController extends BaseController {
	  @Resource
	  private  ArticleTitleColorService  articleTitleColorService;
	  /**
	   * 初始化
	   * @author chenhb
	   * @create_time {date} 下午5:17:53
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/site/articleTitleColor/list";
	  }
	  /**
	   * 添加数据页面
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  return  "admin/site/articleTitleColor/edit";
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
		  Map<String,Object>  res = this.articleTitleColorService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/site/articleTitleColor/edit";
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
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  List<Map<String,Object>>  list = this.articleTitleColorService.findAll(parameter);
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
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			  parameter.put("creator", user.get("id"));
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  parameter.put("id", n_parameter.get("id"));
			  //添加菜单
			  this.articleTitleColorService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
			  this.articleTitleColorService.update(parameter);
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
		  JSONObject jsonObj = this.articleTitleColorService.findPageBean(parameter);
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
		  this.articleTitleColorService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
	  
}
