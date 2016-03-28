package com.go.controller.site;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import com.alibaba.fastjson.JSONObject;
import com.go.common.util.ExtendDate;
import com.go.common.util.SysUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.site.PicLinkService;

/**
 * 门户网站图片链接管理
 * @author zhangjf
 * @create_time 2016-3-25 上午11:52:36
 */
@Controller
@RequestMapping("/site/picLink/*")
public class PicLinkController extends BaseController {
	@Autowired
	private PicLinkService picLinkService;
	
	/**
	 * 列表页面
	 * @author zhangjf
	 * @create_time 2015-10-19 下午5:15:01
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("redirect.do")
	public String redirect(HttpServletRequest request,HttpServletResponse response){
		return "admin/site/picLink/list";
	}
	
	 /**
	   * 添加数据页面
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  return  "admin/site/picLink/edit";
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
		  Map<String,Object>  res = this.picLinkService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/site/picLink/edit";
	  }
	  /**
	   * 保存
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("save.do")
	  public  void save(HttpServletRequest request, HttpServletResponse response) throws Exception{
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
		   /**得到图片保存目录的真实路径**/      
	        String logoRealPathDir = request.getSession().getServletContext().getRealPath("admin/picLink");     
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
	    	   parameter.put("picUrl", "admin/picLink/"+fileName);
	       }
	       
	       boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
			  if(isIDNull){
				//  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
				  parameter.put("createTime", ExtendDate.getYMD_h_m_s(new Date()));
				  //设置ID
				  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
				  //添加菜单
				  this.picLinkService.add(n_parameter);
				  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
				  
			  }else{
				  this.picLinkService.update(parameter);
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
		  Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前用户
		  parameter.put("userId", user.get("id"));
		  JSONObject jsonObj = this.picLinkService.findPageBean(parameter);
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
		  this.picLinkService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
	  
	  /**
	   * 状态变更
	   * @author zhangjf
	   * @create_time 2015-10-19 下午6:14:20
	   * @param request
	   * @param response
	   */
	  	@RequestMapping("changestatus.do")
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
			this.picLinkService.changeStatus(parameter);
		}
}
