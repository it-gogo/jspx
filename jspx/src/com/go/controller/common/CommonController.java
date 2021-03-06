package com.go.controller.common;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.go.common.util.Util;
import com.go.common.util.Word2Html;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;

@Controller
@RequestMapping("/common")
public class CommonController extends BaseController {
	/**
	   * 导出老师信息模板
	   * @author chenhb
	   * @create_time {date} 下午3:55:58
	   * @param request
	   * @param response
	   * @throws IOException
	   */
	  @RequestMapping("downloadTemp.do")  
	  public void downloadTemp(HttpServletRequest request, HttpServletResponse response,String tempName) throws IOException {  
	      OutputStream os = response.getOutputStream();  
	      try {  
	    	  response.reset();  
	    	  response.setHeader("Content-Disposition", "attachment; filename="+tempName);  
	    	  response.setContentType("application/octet-stream; charset=utf-8");
	          os.write(FileUtils.readFileToByteArray(new File(request.getServletContext().getRealPath("admin/temp/"+tempName))));  
	          os.flush();  
	      } finally {  
	          if (os != null) {  
	              os.close();  
	          }  
	      }  
	  }
	  /**
	   * 判断文件是否存在
	   * @author chenhb
	   * @create_time  2015-9-28 上午10:24:19
	   * @param request
	   * @param response
	   * @param fileUrl
	   */
	  @RequestMapping("exists")
	  public void exists(HttpServletRequest request, HttpServletResponse response,String fileUrl){
		  File f=new File(request.getSession().getServletContext().getRealPath(fileUrl));
		  if( f.exists()){
			  this.ajaxMessage(response, Syscontants.MESSAGE,"文件存在");
		  }else{
			  this.ajaxMessage(response, Syscontants.ERROE,"文件不存在");
		  }
	  }
	  
	  /**
	   * 下载资料
	   * @author chenhb
	   * @create_time  2015-9-28 上午10:12:49
	   * @param request
	   * @param response
	   * @param tempName
	   * @throws IOException
	   */
	  @RequestMapping("downloadData.do")  
	  public void downloadData(HttpServletRequest request, HttpServletResponse response,String fileUrl,String fileName) throws IOException {  
	      OutputStream os = response.getOutputStream();  
	      try {  
	    	  fileName=fileName+fileUrl.substring(fileUrl.lastIndexOf("."), fileUrl.length());
	    	  response.reset();  
	    	  response.setHeader("Content-Disposition", "attachment; filename="+new String(fileName.getBytes("utf-8"),"iso8859-1"));  
	    	  response.setContentType("application/octet-stream; charset=utf-8");
	          os.write(FileUtils.readFileToByteArray(new File(request.getServletContext().getRealPath(fileUrl))));  
	          os.flush();  
	      } finally {  
	          if (os != null) {  
	              os.close();  
	          }  
	      }  
	  }
	  /**
	   * 导入民族信息
	   * @author chenhb
	   * @create_time {date} 上午9:11:46
	   * @param request
	   * @param response
	   * @throws Exception
	   */
	  @RequestMapping("upload.do")
	  public void importNation(HttpServletRequest request, HttpServletResponse response) throws Exception{
	        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
	           /**得到图片保存目录的真实路径**/      
	        String logoRealPathDir = request.getSession().getServletContext().getRealPath("admin/temp");     
	        /**根据真实路径创建目录**/      
	        File logoSaveFile = new File(logoRealPathDir);       
	        if(!logoSaveFile.exists())       
	            logoSaveFile.mkdirs();             
	         /**页面控件的文件流**/
	        MultipartFile multipartFile = multipartRequest.getFile("fileId");   
	  }
	  
	  
	 /**
	  * 导入excel和word处理
	  * @author zhangjf
	  * @create_time 2016-3-25 上午11:14:24
	  * @param request
	  * @param response
	  * @throws IOException
	  * @throws Exception
	  */
	  @RequestMapping("xlsAnddocToStr.do")
	  public  void  excelToTable(HttpServletRequest request, HttpServletResponse response) throws IOException, Exception{
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
	         /**页面控件的文件流**/
	        MultipartFile multipartFile = multipartRequest.getFile("excel"); 
	        //文件后缀
	        String suffix=StringUtils.isNotBlank(multipartFile.getOriginalFilename())?multipartFile.getOriginalFilename():"";
	        String[] suff = suffix.split("\\.");
	        if(suff.length>1){
	        	if("xls".equals(suff[suff.length-1])){
	        		List<String[]> list=Util.ExcelToList(multipartFile.getInputStream());
	        		StringBuffer sb=new StringBuffer("<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"border-collapse: collapse;\">");
	        		for(String[] arr:list){
	        			sb.append("<tr>");
	        			for(String str:arr){
	        				sb.append("<td>"+str+"</td>");
	        			}
	        			sb.append("</tr>");
	        		}
	        		sb.append("</table>");
	        		 this.ajaxData(response, sb.toString());
	        	}else if("doc".equals(suff[suff.length-1])){
	        		  /**得到图片保存目录的真实路径**/      
	                String logoRealPathDir = request.getSession().getServletContext().getRealPath("admin/doc");     
	                /**根据真实路径创建目录**/      
	                File logoSaveFile = new File(logoRealPathDir);       
	                if(!logoSaveFile.exists())       
	                   logoSaveFile.mkdirs();             
	        		
	                String fileName=System.currentTimeMillis()+".doc";
	                Util.saveFileFromInputStream(multipartFile.getInputStream(), logoRealPathDir, fileName);
	                File file=new File(logoRealPathDir+"/"+fileName);
	        		String str=Word2Html.toHtmlString(file, logoRealPathDir, request.getContextPath()+"/admin/doc");
	        		file.delete();
	        		 this.ajaxData(response, str);
	        	}else{
	        		this.ajaxData(response, "上传文件类型不对，请上传.xls,.doc格式文件");
	        	}
			}
	  }
	  
	  
}
