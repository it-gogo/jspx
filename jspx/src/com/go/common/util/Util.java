package com.go.common.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

import com.thoughtworks.xstream.core.util.Base64Encoder;

public class Util {
	//验证字符串是否为正确路径名的正则表达式 
	private static String matches = "[A-Za-z]:\\\\[^:?\"><*]*"; //通过 sPath.matches(matches) 方法的返回值判断是否正确 
	
	public static String Encryption(String str) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("md5");
		byte[] buf = md.digest(str.getBytes());
		return new Base64Encoder().encode(buf);
	}
	/**
	 * 扩容
	 * 
	 * @param arr
	 * @param value
	 * @return
	 */
	public static <T> T[] expansion(T[] arr, T value) {
		arr = Arrays.copyOf(arr, arr.length + 1);
		arr[arr.length - 1] = value;
		return arr;
	}
	/**
	  * 保存文件
	  */
	public static void saveFileFromInputStream(InputStream stream,String path,String filename) throws IOException {      
		/***
		 * 如果文件夹不存在则创建文件夹
		 */
		File fls = new File(path);
		if(!fls.exists()){
			fls.mkdirs();
		}
       FileOutputStream fs=new FileOutputStream( path + "/"+ filename);
       byte[] buffer =new byte[1024*1];
       while (stream.read(buffer)!=-1)
       {
       	fs.write(buffer);
       	fs.flush();
       } 
       fs.close();
       stream.close();      
   }  
	
	/**
	 * 根据路径删除指定的目录或文件，无论存在与否 
	 * @author zhangjf
	 * @create_date 2015-6-25 下午9:48:36
	 * @param path
	 * @return
	 */
	public static boolean deleteFolder(String path){
		boolean flag=false;
		File file=new File(path);
		//判断目录或文件是否存在
		if(!file.exists()){//不存在则返回flag
			return flag;
		}else{
			//判断是否文件
			if(file.isFile()){//是文件时调用删除文件方法
				return deleteFile(path);
			}else{//为目录时调用删除目录方法
				return deleteDirectory(path);
			}
		}//end exists
	}

	/**
	 * 单个文件删除方法
	 * @author zhangjf
	 * @create_date 2015-6-25 下午9:52:01
	 */
	public static boolean deleteFile(String path) {
		File file=new File(path);
		//路径为文件且不为空则进行删除
		if(file.isFile()&&file.exists()){
			file.delete();
			return true;
		}
		return false;
	}
	
	/**
	 * 删除目录（文件夹）以及目录下的文件 
	 * @author zhangjf
	 * @create_date 2015-6-25 下午9:52:22
	 */
	public static  boolean deleteDirectory(String path) {
		boolean flag=true;
		 //如果path不以文件分隔符结尾，自动添加文件分隔符 
		if(!path.endsWith(File.separator)){
			path+=File.separator;
		}
		File dirFile=new File(path);
		 //如果dir对应的文件不存在，或者不是一个目录，则退出  
		if(!dirFile.exists()||!dirFile.isDirectory()){
			return false;
		}
		//删除文件夹下的所有文件(包括子目录) 
		File[] files=dirFile.listFiles();
		for (int i = 0,len=files.length; i < len; i++) {
			File file=files[i];
			if(file.isFile()){//若是文件则进行文件删除
				flag = deleteFile(file.getAbsolutePath()); 
				if (!flag){
					break;  
				}
			}else{
				 flag = deleteDirectory(file.getAbsolutePath());
				 if (!flag){
					 break;  
				 }
			}
		}//end for
		if (!flag) {
			return false; 
		}
		//删除当前目录  
		if (dirFile.delete()) { 
			 return true;  
		}else{
			return false;  
		}
	}
	/**
	 * 深度拷贝list
	 * @param src
	 * @return
	 * @throws IOException
	 * @throws ClassNotFoundException
	 */
	public static List copyBySerialize(List src) throws IOException,ClassNotFoundException {
		ByteArrayOutputStream byteOut = new ByteArrayOutputStream();
		ObjectOutputStream out = new ObjectOutputStream(byteOut);
		out.writeObject(src);

		ByteArrayInputStream byteIn = new ByteArrayInputStream(
				byteOut.toByteArray());
		ObjectInputStream in = new ObjectInputStream(byteIn);
		List dest = (List) in.readObject();
		return dest;
	}
	/**
	   * 创建Excel
	   * @author chenhb
	   * @create_time {date} 下午4:03:52
	   * @param os
	   * @param header
	   * @param data
	   * @throws WriteException
	   * @throws IOException
	   */
	  public static void createExcel(OutputStream os,String[] header,List<String[]> data) throws WriteException,IOException{
	        //创建工作薄
	        WritableWorkbook workbook = Workbook.createWorkbook(os);
	        //创建新的一页
	        WritableSheet sheet = workbook.createSheet("First Sheet",0);
	        //创建要显示的内容,创建一个单元格，第一个参数为列坐标，第二个参数为行坐标，第三个参数为内容
	        for(int i=0;i<header.length;i++){
	        	sheet.addCell(new Label(i,0,header[i]));
	        }
	        
	        for(int i=0;i<data.size();i++){
	        	String[] arr=data.get(i);
	        	for(int j=0;j<arr.length;j++){
	        		sheet.addCell(new Label(j,i+1,arr[j]));
	        	}
	        }
	        //把创建的内容写入到输出流中，并关闭输出流
	        workbook.write();
	        workbook.close();
	        os.close();
	    }
	  
	  /**
	   * 判断上传文件是否是允许上传类型
	   * @author zhangjf
	   * @create_time 2015-8-19 下午3:38:07
	   * @param suffix
	   * @param allowType
	   * @return
	   */
	  public static boolean isAllow(String suffix,String allowType){
		 String[] allows=allowType.split(";");
		 for (String allow : allows) {
			if(suffix.equals(allow)){
				return true;
			}
		}
		 return false;
	  }
	  
	  
	  /**
		 * 文件复制
		 * @author zhangjf
		 * @create_time 2015-8-19 下午4:13:49
		 * @param src
		 * @param dest
		 * @return
		 */
		public static boolean copy(File src, File dest) {
			BufferedInputStream bis = null;
			BufferedOutputStream bos = null;
			try {
				bis = new BufferedInputStream(new FileInputStream(src));
				bos = new BufferedOutputStream(new FileOutputStream(dest));
				byte[] bts = new byte[1024];
				int len = -1;
				while ((len = bis.read(bts)) != -1) {
					bos.write(bts, 0, len);
				}
				return true;
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			} finally {
				if (bis != null) {
					try {
						bis.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if (bos != null) {
					try {
						bos.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		/**
		 * 通过seq排序
		 * @author chenhb
		 * @create_time  2016-3-3 下午2:03:12
		 * @param list
		 * @param field
		 */
		public static void sortListByseq(List<Map<String,Object>> list,final String field){
			 Collections.sort(list, new Comparator<Object>() {
			     @Override
			      public int compare(Object o1, Object o2) {
			    	  Map<String,Object> m1=(Map<String, Object>) o1;
			    	  Map<String,Object> m2=(Map<String, Object>) o2;
			    	  int seq1=Integer.parseInt(m1.get(field)==null ?"-1":m1.get(field).toString());
			    	  int seq2=Integer.parseInt(m2.get(field)==null ?"-1":m2.get(field).toString());
			        return seq1-seq2;
			      }
			    });
		}
		
		/**
		 * 根据导入文件地址进行数据保存
		 * @author zhangjf
		 * @create_time 2015-11-19 下午4:23:37
		 * @param file 导入的地址
		 * @param path 替换的地址
		 * @param mapList 转换后的数据集合
		 * @param parentId 父ID
		 * @param relativeUrl 相对地址
		 * @param params 其他参数
		 */
		public static void fileList(File file,String path,List<Map<String,Object>> mapList,String parentId,String relativeUrl,Map<String,Object> params){
			if(file.isFile()){
				Map<String,Object> fileMap=new HashMap<String, Object>();
				fileMap.put("id", SqlUtil.uuid());
				fileMap.put("type", "文件");
				fileMap.put("parentId", parentId);
				fileMap.put("absoluteUrl", file.getAbsolutePath());
				fileMap.put("relativeUrl", relativeUrl+file.getAbsolutePath().replace(path, "").replace("\\", "/"));
				fileMap.put("name", file.getName());
				fileMap.put("fileSize", file.length());
				String[] suff=file.getName().split("\\.");
				fileMap.put("suffix", "."+suff[suff.length-1]);
				fileMap.putAll(params);
				mapList.add(fileMap);
			}
			if((!file.isHidden() && file.isDirectory()) && !isIgnoreFile(file)) {
				/**
				 * 创建文件夹集合
				 */
				Map<String,Object>dirMap=new HashMap<String, Object>();
				dirMap.put("id", SqlUtil.uuid());
				dirMap.put("type", "文件夹");
				dirMap.put("parentId", parentId);
				dirMap.put("absoluteUrl", file.getAbsolutePath());
				dirMap.put("relativeUrl", relativeUrl+file.getAbsolutePath().replace(path, "").replace("\\", "/"));
				dirMap.put("name", file.getName());
				dirMap.putAll(params);
				mapList.add(dirMap);
				File[] subFiles = file.listFiles();
				for(int i = 0; i < subFiles.length; i++) {
					fileList(subFiles[i],path,mapList,dirMap.get("id")+"",relativeUrl,params);
				}
			}
		}

		/**
		 * 获取视频缩略图
		 * @author zhangjf
		 * @create_time 2016-3-25 上午10:57:31
		 * @param videoUrl 视频地址
		 * @param batUrl ffmpeg.bat Url
		 * @return
		 */
		public  static String getVideoImg(String videoUrl,String batUrl){
			if(videoUrl==null|| "".equals(videoUrl)){
				return "";
			}
			String imgUrl="";
			imgUrl=videoUrl.substring(0, videoUrl.lastIndexOf("."))+".jpg";
			try {
				Runtime.getRuntime().exec("cmd /c start "+batUrl+" "+ videoUrl + " " + imgUrl);
			} catch (IOException e) {
				e.printStackTrace();
			}  
			return imgUrl;
		}
		
		
		/**
		 * 忽略文件
		 * @author zhangjf
		 * @create_time 2015-11-19 上午10:51:18
		 * @param file
		 * @return
		 */
		private static boolean isIgnoreFile(File file) {
			List<String> ignoreList = new ArrayList<String>();
			ignoreList.add(".svn");
			ignoreList.add("CVS");
			ignoreList.add(".cvsignore");
			ignoreList.add("SCCS");
			ignoreList.add("vssver.scc");
			ignoreList.add(".DS_Store");
			for(int i = 0; i < ignoreList.size(); i++) {
				if(file.getName().equals(ignoreList.get(i))) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * excel内容转换为list集合
		 * @author zhangjf
		 * @create_time 2016-3-25 上午11:15:17
		 * @param is
		 * @return
		 * @throws Exception
		 */
		 public static   List<String[]>  ExcelToList(InputStream is) throws Exception{
				Workbook  workbook = Workbook.getWorkbook(is);   
				Sheet  sheet = workbook.getSheet(0);
				int row = sheet.getRows();
				int col = sheet.getColumns();
		        Cell cell = null;
		        String[]  rdata = null;
		        List<String[]>  list = new ArrayList<String[]>();
		        for(int i=0;i<row;i++){
		        	rdata = new String[col];
		        	for(int j=0;j<col;j++){
		        		cell = sheet.getCell(j,i);
		        		rdata[j] = cell.getContents();
		        	}
		        	 list.add(rdata);
		        }
		        workbook.close();
		        return list;
			}
		
		
}
