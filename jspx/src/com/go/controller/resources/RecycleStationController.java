package com.go.controller.resources;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.SysUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.resources.AbsoluteManagementService;
import com.go.service.resources.FileManagementService;
/**
 * 文档管理回收站控制器
 * @author zhangjf
 * @create_time 2015-11-18 下午8:00:33
 */
@Controller
@RequestMapping("/resources/recycleStation")
public class RecycleStationController extends BaseController {
	  @Resource
	  private  FileManagementService  fileManagementService;
	  @Resource
	  private  AbsoluteManagementService  absoluteManagementService;
	  
	  /**
	   * 回收站列表页面
	   * @author zhangjf
	   * @create_time 2015-11-18 下午8:03:58
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(HttpServletRequest request,HttpServletResponse response,ModelMap model){
		  return "admin/resources/fileManagement/recycleList";
	  }
	  
	  /**
	   * 查询列表
	   * @param request
	   * @param response
	   */ 
	  @RequestMapping("recycleList.do")
	  public  void  recycleList(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  //TODO 预留处理后期用户查看数据全选
		  JSONObject jsonObj = this.fileManagementService.recyclePageBean(parameter);
		  this.ajaxData(response, jsonObj.toJSONString());
	  }
	  
	  /**
	   * 回收站内容删除
	   * @author zhangjf
	   * @create_time 2015-11-19 上午10:01:14
	   * @param request
	   * @param response
	   */
	  @RequestMapping("delete.do")
	  public  void  delete(HttpServletRequest request, HttpServletResponse response){
		  List<String> list = sqlUtil.getIdsParameter(request);
		  List<Map<String,Object>> recycleList=fileManagementService.loadByIds(list);
		  Map<String,Object>topPath=null;
		  for (Map<String, Object> recycle : recycleList) {
			  topPath=absoluteManagementService.findOne(recycle);
			if("文件夹".equals(recycle.get("type"))){
					Util.deleteDirectory(topPath.get("absoluteUrl")+"/"+recycle.get("relativeUrl"));
			}else{
					Util.deleteFile(topPath.get("absoluteUrl")+"/"+recycle.get("relativeUrl")+"/"+recycle.get("name"));
			}
		}
		  this.fileManagementService.delete(list);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
	  
	  /**
	   * 回收站数据还原
	   * @author zhangjf
	   * @create_time 2015-11-19 上午10:19:32
	   * @param request
	   * @param response
	   */
	  @RequestMapping("reduction.do")
	  public void reduction(HttpServletRequest request,HttpServletResponse response){
		  List<String> list = sqlUtil.getIdsParameter(request);
		  this.fileManagementService.reduction(list);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "还原成功");
	  }
	  
	  /**
	   * 清空回收站数据
	   * @author zhangjf
	   * @create_time 2015-11-19 上午10:27:26
	   * @param request
	   * @param response
	   */
	  @RequestMapping("removeAll.do")
	  public void removeAll(HttpServletRequest request,HttpServletResponse response){
		  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  //TODO 预留清空用户所拥有的权限文件和文件夹
		  //1.查询用户所拥有的文件和文件夹列表
		  Map<String,Object> params=new HashMap<String, Object>();
		  //TODO
		  List<Map<String,Object>> recycleList=fileManagementService.recycleAll(null);
		  //2.遍历进行删除
		  Map<String,Object>topPath=null;
		  List<String> idList=new ArrayList<String>();;
		  for (Map<String, Object> recycle : recycleList) {
			  params=new HashMap<String, Object>();
			  params.put("topFileId", recycle.get("topFileId"));
			  topPath=absoluteManagementService.findOne(params);
			if("文件夹".equals(recycle.get("type"))){
					Util.deleteDirectory(topPath.get("absoluteUrl")+"/"+recycle.get("relativeUrl"));
			}else{
					Util.deleteFile(topPath.get("absoluteUrl")+"/"+recycle.get("relativeUrl")+"/"+recycle.get("name"));
			}
			idList.add(recycle.get("id")+"");
		}
		  
		 if(idList!=null&&!idList.isEmpty()){
			 this.fileManagementService.delete(idList);
		 }
		 this.ajaxMessage(response, Syscontants.MESSAGE, "清空成功");
	  }
	  
	  
}
