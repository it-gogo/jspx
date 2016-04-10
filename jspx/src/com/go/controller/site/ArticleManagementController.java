package com.go.controller.site;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import com.alibaba.fastjson.JSONObject;
import com.go.common.util.DateUtil;
import com.go.common.util.ExtendDate;
import com.go.common.util.JSONUtil;
import com.go.common.util.LogUtil;
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.CodeDataService;
import com.go.service.site.ArticleManagementService;
/**
 * 门户文章管理控制器
 * @author zhangjf
 * @create_time 2016-3-25 上午9:33:36
 */
@Controller
@RequestMapping("/site/articleManagement")
public class ArticleManagementController extends BaseController {
	  @Autowired
	  private  ArticleManagementService  articleManagementService;
	  @Autowired
	  private CodeDataService codeDataService;
	  
	  /**
	   * 初始化（列表）
	   * @author zhangjf
	   * @create_time 2016-3-25 上午9:33:51
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("redirectLook.do")
	  public String redirectLook(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  model.addAttribute("vo", parameter);
		  return  "admin/site/articleManagement/listLook";
	  }
	  
	  /**
	   * 初始化（oa）
	   * @author zhangjf
	   * @create_time 2016-3-25 上午11:43:13
	   * @return
	   */
	  @RequestMapping("redirectOA.do")
	  public String redirectOA(){
		  return  "admin/site/articleManagement/list";
	  }
	  /**
	   * 添加数据页面（oa）
	   * @return
	   */
	  @RequestMapping("addOA.do")
	  public  String addOA(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object>  vo = sqlUtil.setParameterInfo(request);
		  vo.put("pubishDate", DateUtil.getCurrentTime());
		  model.addAttribute("vo", vo);
		  return  "admin/site/articleManagement/edit";
	  }  
	  /**
	   * 导出数据（oa）
	   * @param request
	   * @param response
	   * @return
	   */
	  @RequestMapping("loadOA.do")
	  public  String loadOA(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object>  res = this.articleManagementService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/site/articleManagement/edit";
	  }
	  
	  /**
	   * 初始化
	   * @author zhangjf
	   * @create_time 2016-3-25 上午9:34:48
	   * @return
	   */
	  @RequestMapping("redirect.do")
	  public String redirect(){
		  return  "admin/wechat/articleManagement/list";
	  }
	  /**
	   * 添加数据页面
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  
		  return  "admin/wechat/articleManagement/edit";
	  }  
	/**
	 * 查询所有
	 * @author zhangjf
	 * @create_time 2016-3-25 上午9:34:57
	 * @param request
	 * @param response
	 * @param model
	 */
	  @RequestMapping("all.do")
	  public  void all(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  List<Map<String,Object>>  list = this.articleManagementService.findAll1(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
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
		  Map<String,Object>  res = this.articleManagementService.load(parameter);
		  model.addAttribute("vo", res);
		  return  "admin/wechat/articleManagement/edit";
	  }
	  
	  /**
	   * 查看文章
	   * @author zhangjf
	   * @create_time 2016-3-25 上午9:35:10
	   * @param request
	   * @param response
	   * @param model
	   * @return
	   */
	  @RequestMapping("look.do")
	  public  String look(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object>  res = this.articleManagementService.load(parameter);
		  model.addAttribute("vo", res);
		  if(res!=null && res.size()>0){
			  Map<String,Object> countMap=new HashMap<String, Object>();
			  if(res.containsKey("readCount")&&res.get("readCount")!=null){
				  int historyCount=Integer.parseInt(res.get("readCount").toString());
				  countMap.put("id", res.get("id"));
				  countMap.put("readCount", (historyCount+1));
			  }else{
				  countMap.put("id", res.get("id"));
				  countMap.put("readCount",1);
			  }
			  articleManagementService.addCount(countMap);
		  }
		  return  "admin/site/articleManagement/look";
	  }
	  /**
	   * 保存
	   * @author zhangjf
	   * @create_time 2016-3-25 上午9:35:20
	   * @param request
	   * @param response
	   * @param sectionId
	   * @throws Exception
	   */
	  @RequestMapping("save.do")
	  public  void save(HttpServletRequest request, HttpServletResponse response,String[] sectionId) throws Exception{
		  List<File> deleteFile=new ArrayList<File>();
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> vo=articleManagementService.load(parameter);
		  if(sectionId==null || sectionId.length==0){
			  this.ajaxMessage(response, Syscontants.ERROE, "至少选择一个栏目。");
			  return;
		  }
		  List<Map<String,Object>> sectionList=new ArrayList<Map<String,Object>>();
		  for(String str:sectionId){
			  Map<String,Object> map=new HashMap<String, Object>();
			  map.put("id", SqlUtil.uuid());
			  map.put("sectionId", str);
			  sectionList.add(map);
		  }
		  parameter.put("list", sectionList);
		  MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
		   /**得到图片保存目录的真实路径**/      
	        String logoRealPathDir = request.getSession().getServletContext().getRealPath("admin/articlePic");     
	        /**根据真实路径创建目录**/      
	        File logoSaveFile = new File(logoRealPathDir);       
	        if(!logoSaveFile.exists())       
	            logoSaveFile.mkdirs();             
	        /**页面控件的文件流**/
	       MultipartFile multipartFile = multipartRequest.getFile("picFile");   
	       if(multipartFile!=null){
	    	   //文件后缀
		       String suffix=StringUtils.isNotBlank(multipartFile.getOriginalFilename())?multipartFile.getOriginalFilename():"";
		       if(suffix!=null && !"".equals(suffix)){
		    	   String[] suff = suffix.split("\\.");
		    	   String fileName=new SimpleDateFormat("yyyy-MM-dd~HH_mm_ss_SSS").format(new Date())+"";
		    	   String fileName1=fileName;
		    	   if(suff.length>1){
		    		   fileName +="."+suff[suff.length-1];
		    	   }
		    	   Util.saveFileFromInputStream(multipartFile.getInputStream(), logoRealPathDir, fileName);
		    	   
		    	   Map<String,Object> dictType=new HashMap<String, Object>();
		    	   dictType.put("code", "SPHZ");//视频后缀
		    	   List<Map<String,Object>> dataList=codeDataService.findAll(dictType);
		    	   if(dataList!=null && dataList.size()>0){
		    		   String end_new="."+suff[suff.length-1].toLowerCase();
		    		   boolean isVideo=false;
		    		   for(Map<String,Object> data:dataList){//遍历后缀
		    			   String end=data.get("name")+"";
		    			   if(end_new.equals(end.toLowerCase())){//是视频后缀文件
//		    				   parameter.put("picUrl", "admin/articlePic/"+fileName);
		    				   isVideo=true;
		    				   break;
		    			   }
		    		   }
		    		   if(isVideo){//是视频文件
		    			   Util.getVideoImg(logoRealPathDir+"/"+fileName, request.getSession().getServletContext().getRealPath("ffmpeg/ffmpeg.bat"));//创建视频缩略图
		    			   parameter.put("picUrl", "admin/articlePic/"+fileName1+".jpg");//
		    			   parameter.put("videoUrl", "admin/articlePic/"+fileName);//附件地址存视频
		    			   if(vo!=null){
		    				   Object picUrl=vo.get("picUrl");
		    				   if(picUrl!=null){
		    		    		   File file=new File(request.getSession().getServletContext().getRealPath(picUrl.toString()));
		    		    		   if(file.exists()){
		    		    			   deleteFile.add(file);
		    		    		   }
		    		    	   }
		    				   Object videoUrl=vo.get("videoUrl");
		    				   if(videoUrl!=null){
		    		    		   File file=new File(request.getSession().getServletContext().getRealPath(videoUrl.toString()));
		    		    		   if(file.exists()){
		    		    			   deleteFile.add(file);
		    		    		   }
		    		    	   }
		    			   }
		    		   }else{//不是视频文件
		    			   parameter.put("picUrl", "admin/articlePic/"+fileName);
		    			   if(vo!=null){
		    				   Object picUrl=vo.get("picUrl");
		    				   if(picUrl!=null){
		    		    		   File file=new File(request.getSession().getServletContext().getRealPath(picUrl.toString()));
		    		    		   if(file.exists()){
		    		    			   deleteFile.add(file);
		    		    		   }
		    		    	   }
		    			   }
		    		   }
		    	   }else{
		    		   parameter.put("picUrl", "admin/articlePic/"+fileName);
		    		   if(vo!=null){
	    				   Object videoUrl=vo.get("videoUrl");
	    				   if(videoUrl!=null){
	    		    		   File file=new File(request.getSession().getServletContext().getRealPath(videoUrl.toString()));
	    		    		   if(file.exists()){
	    		    			   deleteFile.add(file);
	    		    		   }
	    		    	   }
	    			   }
		    	   }
		       }
		        
	       }
	      
	       /**页面控件的文件流**/
	       multipartFile = multipartRequest.getFile("accessoryFile");   
	       //文件后缀
	       if(multipartFile!=null){
	       String suffix=StringUtils.isNotBlank(multipartFile.getOriginalFilename())?multipartFile.getOriginalFilename():"";
	       if(suffix!=null && !"".equals(suffix)){
	    	   String[] suff = suffix.split("\\.");
	    	   String fileName=new SimpleDateFormat("yyyy-MM-dd HH_mm_ss_SSS").format(new Date())+"";
	    	   if(suff.length>1){
	    		   fileName +="."+suff[suff.length-1];
	    	   }
	    	   Util.saveFileFromInputStream(multipartFile.getInputStream(), logoRealPathDir, fileName);
	    	   parameter.put("accessoryUrl", "admin/articlePic/"+fileName);
	    	   if(vo!=null){
				   Object accessoryUrl=vo.get("accessoryUrl");
				   if(accessoryUrl!=null){
		    		   File file=new File(request.getSession().getServletContext().getRealPath(accessoryUrl.toString()));
		    		   if(file.exists()){
		    			   deleteFile.add(file);
		    		   }
		    	   }
			   }
	       }
	       }
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			  parameter.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			  parameter.put("creator", userMap.get("id"));
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  //添加菜单
			  this.articleManagementService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
			  
		  }else{
			  this.articleManagementService.update(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"修改成功");
		  }
		  
		  try {
			  if(deleteFile!=null && deleteFile.size()>0){//删除旧文件
				  for(File file:deleteFile){
					  file.delete();
				  }
			  }
			  //zhangjf 2016-01-07更新或创建文章订阅信息
			 // this.articleManagementService.createRssXml(request);
		} catch (Exception e) {
			e.printStackTrace();
			LogUtil.error(this.getClass(), e);
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
		  JSONObject jsonObj = this.articleManagementService.findPageBean(parameter);
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
		  this.articleManagementService.delete(parameter,request);
		  //zhangjf 2016-01-07更新或创建文章订阅信息
		//  this.articleManagementService.createRssXml(request);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
	  
	  /**
	   * 下载文件
	   * @author chenhb
	   * @create_time  2015-10-22 下午3:12:53
	   * @param request
	   * @param response
	   * @param tempName
	   * @throws IOException
	   */
	  @RequestMapping("download.do")  
	  public void download(HttpServletRequest request, HttpServletResponse response) throws IOException {  
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  Object url=parameter.get("url");
		  if(url==null){
			  return;
		  }
		  String str=url.toString();
		  String end=str.substring(str.lastIndexOf("."), str.length());
		  Map<String,Object>  res = this.articleManagementService.load(parameter);
	      OutputStream os = response.getOutputStream();  
	      try {  
	    	  response.reset();  
	    	  response.setHeader("Content-Disposition", "attachment; filename="+new String(res.get("title").toString().getBytes("utf-8"),"iso-8859-1")+end);  
	    	  response.setContentType("application/octet-stream; charset=utf-8");
	          os.write(FileUtils.readFileToByteArray(new File(request.getServletContext().getRealPath(url.toString()))));  
	          os.flush();  
	      } finally {  
	          if (os != null) {  
	              os.close();  
	          }  
	      }  
	  }
}
