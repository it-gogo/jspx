package com.go.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.apache.tools.zip.ZipOutputStream;

public class Zip {
	public static final String Father="a";
	public static final String Mother="b";
	public static final String Grandfather="c";
	public static final String Grandmother="d";
	public static final String Other="e";
	/**
	 * 压缩文件-由于out要在递归调用外,所以封装一个方法用来
	 * 调用ZipFiles(ZipOutputStream out,String path,File... srcFiles)
	 * @param zip
	 * @param path
	 * @param srcFiles
	 * @throws IOException
	 * @author isea533
	 */
	public static void ZipFiles(File zip,String path,File... srcFiles) throws IOException{
		ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zip));
		Zip.ZipFiles(out,path,srcFiles);
		out.close();
		System.out.println("*****************压缩完毕*******************");
	}
	public static void ZipStream(OutputStream fos,String path,File... srcFiles) throws IOException{
		ZipOutputStream out = new ZipOutputStream(fos);
		Zip.ZipFiles(out,path,srcFiles);
		out.close();
	}
	public static void ZipStreamByName(OutputStream fos,String path,File[] srcFiles,String[] fileNames) throws IOException{
		ZipOutputStream out = new ZipOutputStream(fos);
		Zip.ZipFiles(out,path,srcFiles,fileNames);
		out.close();
	}
	/**
	 * 压缩文件-File
	 * @param zipFile  zip文件
	 * @param srcFiles 被压缩源文件
	 * @author isea533
	 */
	public static void ZipFiles(ZipOutputStream out,String path,File[] srcFiles){
		path = path.replaceAll("\\*", "/");
		if(!path.endsWith("/")){
			path+="/";
		}
		byte[] buf = new byte[1024];
		try {
			for(int i=0;i<srcFiles.length;i++){
				if(srcFiles[i].isDirectory()){
					File[] files = srcFiles[i].listFiles();
					String srcPath = srcFiles[i].getName();
					srcPath = srcPath.replaceAll("\\*", "/");
					if(!srcPath.endsWith("/")){
						srcPath+="/";
					}
					out.putNextEntry(new ZipEntry(path+srcPath));
					ZipFiles(out,path+srcPath,files);
				}
				else{
					FileInputStream in = new FileInputStream(srcFiles[i]);
					System.out.println(path + srcFiles[i].getName());
					out.putNextEntry(new ZipEntry(path + srcFiles[i].getName()));
					out.setEncoding("gbk");
//					out.putNextEntry(new ZipEntry(path + "chb-"+srcFiles[i].getName()));
					int len;
					while((len=in.read(buf))>0){
						out.write(buf,0,len);
					}
					out.closeEntry();
					in.close();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 自定义压缩文件里面的文件名称
	 * @author chenhb
	 * @create_time  2015-10-22 下午4:39:49
	 * @param out
	 * @param path
	 * @param srcFiles
	 * @param fileNames
	 */
	public static void ZipFiles(ZipOutputStream out,String path,File[] srcFiles,String[] fileNames){
		path = path.replaceAll("\\*", "/");
		if(!path.endsWith("/")){
			path+="/";
		}
		byte[] buf = new byte[1024];
		try {
			for(int i=0;i<srcFiles.length;i++){
				if(srcFiles[i].isDirectory()){
					File[] files = srcFiles[i].listFiles();
					String srcPath = srcFiles[i].getName();
					srcPath = srcPath.replaceAll("\\*", "/");
					if(!srcPath.endsWith("/")){
						srcPath+="/";
					}
					out.putNextEntry(new ZipEntry(path+srcPath));
					ZipFiles(out,path+srcPath,files);
				}
				else{
					FileInputStream in = new FileInputStream(srcFiles[i]);
					System.out.println(path + srcFiles[i].getName());
//					out.putNextEntry(new ZipEntry(path + srcFiles[i].getName()));
					out.putNextEntry(new ZipEntry(path + fileNames[i]));
					SystemConfigUtil.getInstance();
					out.setEncoding(SystemConfigUtil.getParameter("encoding"));
					int len;
					while((len=in.read(buf))>0){
						out.write(buf,0,len);
					}
					out.closeEntry();
					in.close();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 解压到指定目录
	 * @param zipPath
	 * @param descDir
	 * @author isea533
	 */
	public static void unZipFiles(String zipPath,String descDir)throws IOException{
		unZipFiles(new File(zipPath), descDir);
	}
	/**
	 * 解压文件到指定目录
	 * @param zipFile
	 * @param descDir
	 * @author isea533
	 */
	@SuppressWarnings("rawtypes")
	public static List<String> unZipFiles(File zipFile,String descDir)throws IOException{
		List<String> res=new ArrayList<String>();
		File pathFile = new File(descDir);
		if(!pathFile.exists()){
			pathFile.mkdirs();
		}
		ZipFile zip = new ZipFile(zipFile,"gbk");
		for (Enumeration entries = zip.getEntries(); entries.hasMoreElements();) {
			InputStream in=null;
			OutputStream out=null;
			try {
				ZipEntry entry = (ZipEntry) entries.nextElement();
				String zipEntryName = entry.getName();
				in = zip.getInputStream(entry);
				String fileName = zipEntryName.substring(zipEntryName.lastIndexOf("/") + 1, zipEntryName.length());
				if(fileName==null || "".equals(fileName)){
					continue;
				}
				String resName=fileName;
				fileName=fileName.substring(0, fileName.lastIndexOf("."));
				String[] arr=fileName.split("_");
				if(arr.length==3){//符合格式名图片
					String cw=arr[2];//称谓
					if("学生".equals(cw)){
						fileName=arr[0]+".jpg";
					}else if("父亲".equals(cw)){
						fileName=arr[0]+Father+".jpg";
					}else if("母亲".equals(cw)){
						fileName=arr[0]+Mother+".jpg";
					}else if("爷爷".equals(cw)){
						fileName=arr[0]+Grandfather+".jpg";
					}else if("奶奶".equals(cw)){
						fileName=arr[0]+Grandmother+".jpg";
					}else{//其他
						fileName=arr[0]+Other+".jpg";
					}
					
					String outPath = (descDir + fileName).replaceAll("\\*", "/");
					// 判断路径是否存在,不存在则创建文件路径
					File file = new File(outPath.substring(0, outPath.lastIndexOf('/')));
					if (!file.exists()) {
						file.mkdirs();
					}
					if (!"".equals(resName)) {
						res.add(resName);
					}
					// 判断文件全路径是否为文件夹,如果是上面已经上传,不需要解压
					if (new File(outPath).isDirectory()) {
						continue;
					}
					out = new FileOutputStream(outPath);
					byte[] buf1 = new byte[1024];
					int len;
					while ((len = in.read(buf1)) > 0) {
						out.write(buf1, 0, len);
					}
				}
			} finally {
				if(in!=null){
					in.close();
				}
				if(out!=null){
					out.close();
				}
			}
		}
		zip.close();
		return res;
	}
	
	
	
    
    
	public static void main(String[] args) throws Exception {
		/** 
         * 解压文件 
         */  
//        File zipFile = new File("D:\\apache-tomcat-7.0.53\\webapps\\user\\upload/1441201485555.zip");  
//        String path = "d:/zipfile/";  
//        System.out.println(unZipFiles(zipFile, path));  
        File[] arr={new File("D:1.xls"),new File("D:你好.xls")};
        ZipFiles(new File("d:chb.zip"), "", arr);
//		File file=new File("D:1.xls");
//		file.renameTo(new   File("D:123.xls"));
	}
}
