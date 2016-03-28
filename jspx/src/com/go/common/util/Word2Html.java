package com.go.common.util;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.ConnectException;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.commons.lang3.StringUtils;
import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;
//import com.artofsolving.jodconverter.openoffice.converter.StreamOpenOfficeDocumentConverter;
/**
 * word文档转换为HTML工具类
 * @author zhangjf
 * @create_time 2015-11-13 下午2:23:14
 */
@SuppressWarnings("static-access")
public class Word2Html {
		
	/**
	   * 将word文档转换成html文档
	   * @author zhangjf
	   * @create_time 2015-11-13 下午2:27:47
	   * @param docFile 需要转换的word文档
	   * @param filepath 转换之后html的存放路径
	   * @return
	   */
	  public static File convert1(File docFile, String filepath) {
		    // 创建保存html的文件
//		    File htmlFile = new File(filepath + "/" + new Date().getTime()+ ".html");
		    File htmlFile = new File(filepath);
		    // 创建Openoffice连接
		    String portStr=SystemConfigUtil.getInstance().getParameter("openOfficePort");
		    if(StringUtils.isBlank(portStr)){
		    	portStr="8100";
		    }
		    OpenOfficeConnection con = new SocketOpenOfficeConnection(Integer.parseInt(portStr));
		    try {
		        // 连接
		        con.connect();
		    } catch (ConnectException e) {
		        System.out.println("获取OpenOffice连接失败...");
		        e.printStackTrace();
		    }
		    // 创建转换器
		    DocumentConverter converter = new OpenOfficeDocumentConverter(con);
		    // 转换文档问html
		    converter.convert(docFile, htmlFile);
		    // 关闭openoffice连接
		    con.disconnect();
		    return htmlFile;
		 }
	/**
	 * 将word转换成html文件，并且获取html文件代码。
	 * @author zhangjf
	 * @create_time 2015-11-13 下午2:24:53
	 * @param docFile 需要转换的文档
	 * @param filepath 文档中图片的保存绝对路径
	 * @param showUrl  文档中图片显示的相对对路径
	 * @return 转换成功的html代码
	 */
	public static  String toHtmlString(File docFile, String filepath,String showUrl){
		 // 转换word文档
	    File htmlFile = convert(docFile, filepath);
	    // 获取html文件流
	    StringBuffer htmlSb = new StringBuffer();
		String readCoding=SystemConfigUtil.getInstance().getParameter("readCoding");
	    if(StringUtils.isBlank(readCoding)){
	    	readCoding="gbk";
	    }
	    try {
	        BufferedReader br = new BufferedReader(new InputStreamReader(
	            new FileInputStream(htmlFile),readCoding));
	        while (br.ready()) {
	        htmlSb.append(br.readLine());
	        }
	        br.close();
	        // 删除临时文件
	        htmlFile.delete();
	    } catch (FileNotFoundException e) {
	        e.printStackTrace();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    // HTML文件字符串
	    String htmlStr = htmlSb.toString();
	    // 返回经过清洁的html文本
	    return clearFormat(htmlStr, showUrl);
	}
	
	  /**
	   * 将word文档转换成html文档
	   * @author zhangjf
	   * @create_time 2015-11-13 下午2:27:47
	   * @param docFile 需要转换的word文档
	   * @param filepath 转换之后html的存放路径
	   * @return
	   */
	  public static File convert(File docFile, String filepath) {
		    // 创建保存html的文件
		    File htmlFile = new File(filepath + "/" + new Date().getTime()+ ".html");
//		    File htmlFile = new File(filepath);
		    // 创建Openoffice连接
		    String portStr=SystemConfigUtil.getInstance().getParameter("openOfficePort");
		    if(StringUtils.isBlank(portStr)){
		    	portStr="8100";
		    }
		    OpenOfficeConnection con = new SocketOpenOfficeConnection(Integer.parseInt(portStr));
		    try {
		        // 连接
		        con.connect();
		    } catch (ConnectException e) {
		        System.out.println("获取OpenOffice连接失败...");
		        e.printStackTrace();
		    }
		    // 创建转换器
		    DocumentConverter converter = new OpenOfficeDocumentConverter(con);
		    // 转换文档问html
		    converter.convert(docFile, htmlFile);
		    // 关闭openoffice连接
		    con.disconnect();
		    return htmlFile;
		 }
	  
	  /**
	   * 清除一些不需要的html标记
	   * @author zhangjf
	   * @create_time 2015-11-13 下午2:29:27
	   * @param htmlStr
	   * @param docImgPath
	   * @return
	   */
	  protected static String clearFormat(String htmlStr, String docImgPath) {
		    // 获取body内容的正则
		    String bodyReg = "<BODY .*</BODY>";
		    Pattern bodyPattern = Pattern.compile(bodyReg);
		    Matcher bodyMatcher = bodyPattern.matcher(htmlStr);
		    if (bodyMatcher.find()) {
		        // 获取BODY内容，并转化BODY标签为DIV
		        htmlStr = bodyMatcher.group().replaceFirst("<BODY", "<DIV")
		            .replaceAll("</BODY>", "</DIV>");
		    }
		    // 调整图片地址
		    htmlStr = htmlStr.replaceAll("<IMG SRC=\"", "<IMG SRC=\"" + docImgPath
		        + "/");
		   // htmlStr = htmlStr.replaceAll("(<P)([^>]*)(>.*?)(<\\/P>)", "<p$3</p>");
		    return htmlStr;
		    }
	  
	  public static void main(String[] args) {
		    System.out
		        .println(toHtmlString(new File("D://test//before//a.doc"), "D://test//after","D://zhangjf//test"));
	  }
	
}
