package com.go.controller.baseinfo;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

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
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.SystemConfigUtil;
import com.go.common.util.Util;
import com.go.common.util.Zip;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.ClassInfoService;
import com.go.service.baseinfo.ClassStudentService;
import com.go.service.baseinfo.HomeWorkService;
import com.go.service.baseinfo.TeacherInfoService;
import com.go.service.baseinfo.UploadLogService;

/**
 * 作业管理控制器
 * @author zhangjf
 * @create_time 2015-9-23 下午7:10:54
 */
@Controller
@RequestMapping("/baseinfo/homework/*")
public class HomeWorkController extends BaseController {

	@Autowired
	private HomeWorkService homeworkService;
	@Autowired
	private TeacherInfoService teacherInfoService;
	@Autowired
	private ClassStudentService classStudentService;
	@Autowired
	private UploadLogService uploadLogService;
	@Autowired
	private ClassInfoService classInfoService;
	
	/**
	 * 跳转到列表页面
	 * @author zhangjf
	 * @create_time 2015-9-23 下午7:12:58
	 * @return
	 */
	@RequestMapping("redirect.do")
	public String redirect(){
		return "admin/baseinfo/homework/list";
	}
	
	/**
	 * 异步查询作业列表数据
	 * @author zhangjf
	 * @create_time 2015-9-23 下午7:19:00
	 */
	@RequestMapping("list.do")
	public void list(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前用户
		  parameter.put("userId", user.get("id").toString());
		  Map<String,Object> classes=classInfoService.managerClasses(parameter);
		  if(classes!=null&&!classes.isEmpty()&&classes.containsKey("idStr")){
			  String classesId=classes.get("idStr").toString();
			  if(StringUtils.isNotBlank(classesId)){
				  parameter.put("classIds", classesId);
			  }
		  }
		  JSONObject jsonObj = this.homeworkService.findPageBean(parameter);
		  this.ajaxData(response, jsonObj.toJSONString());
	}
	
	/**
	 * 跳转到作业添加界面
	 * @author zhangjf
	 * @create_time 2015-9-23 下午7:53:18
	 * @return
	 */
	@RequestMapping("add.do")
	public String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		 Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		 Map<String,Object>  res = this.homeworkService.load(parameter);
		 model.addAttribute("vo", res);
		return "admin/baseinfo/homework/edit";
	}
	
	/**
	 * 数据保存
	 * @author zhangjf
	 * @create_time 2015-9-24 上午8:49:46
	 * @return
	 */
	@RequestMapping("save.do")
	public void save(HttpServletRequest request, HttpServletResponse response){
		 Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  if(isIDNull){
			  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			  parameter.put("uploader", user.get("id"));
			  parameter.put("uploadTime", ExtendDate.getYMD_h_m_s(new Date()));
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  //添加菜单
			  this.homeworkService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  }else{
			  this.homeworkService.update(parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"修改成功");
		  }
	}
	
	
	/**
	 * 删除
	 * @author zhangjf
	 * @create_time 2015-9-24 下午3:29:45
	 */
    @RequestMapping("delete.do")
	public void delete(HttpServletRequest request, HttpServletResponse response){
    	 List<String> parameter = sqlUtil.getIdsParameter(request);
    	 Map<String,Object> params=new HashMap<String, Object>();
    	 params.put("list", parameter);
    	 try {
			List<Map<String,Object>> works=homeworkService.findList(params);
			 if(works!=null&&works.size()>0){
				 for (Map<String, Object> work : works) {//遍历进行数据删除
					 String path=request.getSession().getServletContext().getRealPath("/")+work.get("homeworkUrl").toString();
					Util.deleteFile(path);
				}
			 }
			 homeworkService.delete(parameter);
			 this.ajaxMessage(response, Syscontants.MESSAGE,"删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			this.ajaxMessage(response, Syscontants.ERROE,"删除失败");
		}
    	 
	}
	
	
	/**
	 * 作业上传功能
	 * @author zhangjf
	 * @create_time 2015-9-23 下午8:01:40
	 * @return
	 */
	@RequestMapping("upload.do")
	public void upload(HttpServletRequest request, HttpServletResponse response){
		Map<String,Object> parameter = sqlUtil.queryParameter(request);
		String filePath=parameter.containsKey("path")?parameter.get("path").toString():"";
		String currentDate=new SimpleDateFormat("yyyyMMdd").format(new Date());
		  /**得到图片保存目录的真实路径**/
		String logoRealPathDir="";
        if(StringUtils.isBlank(filePath)){
        	logoRealPathDir = request.getSession().getServletContext().getRealPath("homework/"+currentDate+"/");     
        }else{
        	logoRealPathDir = request.getSession().getServletContext().getRealPath("homework/"+currentDate+"/"+filePath+"/"); 
        }
		
        //第二部获取访问路径
		String serverURL="";
		if(StringUtils.isBlank(filePath)){
			serverURL="homework/"+currentDate+"/";
		}else{
			serverURL="homework/"+currentDate+"/"+filePath+"/";
		}
				
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 

        /**根据真实路径创建目录**/      
        File logoSaveFile = new File(logoRealPathDir);       
        if(!logoSaveFile.exists())       
           logoSaveFile.mkdirs();             
         /**页面控件的文件流**/
        MultipartFile multipartFile = multipartRequest.getFile("homework"); 
        //文件后缀
        String suffix=StringUtils.isNotBlank(multipartFile.getOriginalFilename())?multipartFile.getOriginalFilename():"";
        String[] suff = suffix.split("\\.");
        String fileName=System.currentTimeMillis()+"";
       /* if(parameter.containsKey("title")){
        	fileName=parameter.get("title").toString();
        }else{
            fileName=suffix;
        }*/
        if(suff.length>1){
        	if(Util.isAllow(suff[suff.length-1], SystemConfigUtil.getInstance().getAllowType())){
        		fileName +="."+suff[suff.length-1];
        	}else{
        		this.ajaxMessage(response, Syscontants.ERROE,"上传文件不是允许上传类型");
        		return;
        	}
		}
        /**
         * 进行文件保存
         */
        try {
			Util.saveFileFromInputStream(multipartFile.getInputStream(), logoRealPathDir, fileName);
			this.ajaxMessage(response, Syscontants.MESSAGE,serverURL+fileName);
			return;
		} catch (IOException e) {
			e.printStackTrace();
			this.ajaxMessage(response, Syscontants.ERROE,"上传失败");
		}  
	}
	
	/**
	 * 学生下载作业列表
	 * @author zhangjf
	 * @create_time 2015-9-24 下午5:57:04
	 * @param request
	 * @param resonse
	 */
	@RequestMapping("downLoadList.do")
	public void downLoadList(HttpServletRequest request,HttpServletResponse response){
		 List<String> classesIds=null;
		 Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前学生班级
		  /**
		   * 查询学生所有的班级ID start
		   */
		  Map<String,Object> params=new HashMap<String, Object>();
		  params.put("userId", user.get("id"));
		  Map<String,Object> stuMap=teacherInfoService.findOne(params);
		  if(stuMap!=null&&!stuMap.isEmpty()){
			  params.clear();
			  params.put("studentId", stuMap.get("id"));
			  List<Map<String,Object>> classesList=classStudentService.findClasses(params);
			  if(classesList!=null&&classesList.size()>0){
				  classesIds=new ArrayList<String>();
				  for (Map<String, Object> map : classesList) {
					  classesIds.add(map.get("classId").toString());
				}
			  }
		  }
		  /**
		   * 查询学生所有班级的ID end
		   */
		  if(classesIds!=null&&!classesIds.isEmpty()){
			  parameter.put("list", classesIds);
		  }
		 // parameter.put("uploader", user.get("id").toString());
		  JSONObject jsonObj = this.homeworkService.downloadPageBean(parameter);
		  this.ajaxData(response, jsonObj.toJSONString());
	}
	
	/**
	 * 学生下载作业功能
	 * @author zhangjf
	 * @create_time 2015-9-25 上午9:05:57
	 * @param request
	 * @param resonse
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("download.do")
	public void download(HttpServletRequest request,HttpServletResponse response){
		 Map<String,Object> parameter = sqlUtil.queryParameter(request);
		 Map<String,Object> homework=homeworkService.load(parameter);//作业列表
		 String localPath=request.getSession().getServletContext().getRealPath("/"); 
		 if(homework!=null&&!homework.isEmpty()){
			 String filePath=homework.get("homeworkUrl").toString();
			 fileDownLoad(localPath+filePath,homework.get("title").toString(), response);
		 }
		 Map<String,Object>logMap=uploadLogService.load(parameter);//学生上传列表
		 if(logMap!=null&&!logMap.isEmpty()){
			 String filePath=logMap.get("uploadUrl").toString();
			 fileDownLoad(localPath+filePath,logMap.get("student").toString(), response);
		 }
	}
	
	/**
	 * 文件下载	
	 * @author zhangjf
	 * @create_time 2015-9-25 上午9:11:54
	 * @param path
	 * @param response
	 */
	private void fileDownLoad(String path,String title, HttpServletResponse response){
		  File file = new File(path);// path是根据日志路径和文件名拼接出来的
		  if(!file.exists()){
			  response.setCharacterEncoding("UTF-8");
			  response.setContentType("text/html");
			 PrintWriter pw;
			try {
				pw = response.getWriter();
				 pw.write("<span style='color:red;font-size:16px;'>下载的作业文件不存在或已删除,请联系对应的老师或班主任</span>");
				 pw.close();
				 return;
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		  }
		  String filename = file.getName();// 获取日志文件名称
		  OutputStream os =null;
		  InputStream fis =null;
		   try {
			   String[] suff = filename.split("\\.");
			   filename=title+"."+suff[suff.length-1];
			    fis = new BufferedInputStream(new FileInputStream(path));
			    byte[] buffer = new byte[fis.available()];
			    fis.read(buffer);
			    fis.close();
			    response.reset();
			    // 先去掉文件名称中的空格,然后转换编码格式为utf-8,保证不出现乱码,这个文件名称用于浏览器的下载框中自动显示的文件名
			    response.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.replaceAll(" ", "").getBytes("utf-8"),"iso8859-1"));
			    response.addHeader("Content-Length", "" + file.length());
			     os = new BufferedOutputStream(response.getOutputStream());
			    response.setContentType("application/octet-stream");
			    os.write(buffer);// 输出文件
			    os.flush();
			    os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				if(fis!=null){
					fis.close();
				}
				if(os!=null){
					os.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}  
	}
	
	/**
	 * 跳转到作业提交页面
	 * @author zhangjf
	 * @create_time 2015-9-25 上午11:57:49
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("toUpload.do")
	public String  toUpload(HttpServletRequest request,HttpServletResponse response,Model model){
		 Map<String,Object> parameter = sqlUtil.queryParameter(request);//获取参数
		 Map<String,Object>homeworkMap= homeworkService.load(parameter);
		 model.addAttribute("vo", homeworkMap);
		return "admin/baseinfo/homework/toUpload";
	}
	
	
	/**
	 * 学生作业上传
	 * @author zhangjf
	 * @create_time 2015-9-25 上午10:14:51
	 * @param request
	 * @param response
	 */
	@RequestMapping("upload_homwork.do")
	public void upload_homework(HttpServletRequest request,HttpServletResponse response){
		String localPath=request.getSession().getServletContext().getRealPath("/");
		 Map<String,Object> parameter = sqlUtil.queryParameter(request);//获取参数
		 Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前学生
		 String currentTime=new SimpleDateFormat("yyyy-MM-dd HH:00").format(new Date());
		 /**
		  * 第一步:根据作业ID查询是否存在作业
		  */
		 String homeworkId=parameter.get("homeworkId").toString();
		 String uploadUrl=parameter.get("uploadUrl").toString();
		 Map<String,Object> params=new HashMap<String, Object>();
		 if(StringUtils.isNotBlank(homeworkId)){
		 try {		
			 params.put("id", homeworkId);
			Map<String,Object>homeworkMap= homeworkService.load(params);
			 /**
			  * 第二步:判断当前提交是否超时
			  */
			int times=getTimeStamp(homeworkMap.get("endUploadTime").toString(),currentTime,"HH");
			if(times<0){
					Util.deleteFile(localPath+uploadUrl);//删除文件
				 this.ajaxMessage(response, Syscontants.ERROE, "当前已超过作业设置的提交截止时间！");
				 return;
			}
			params.clear();
			params.put("userId", user.get("id").toString());
			params.put("homeworkId", homeworkId);
			 /**
			  * 第二步:判断是否有重复数据
			  */
			Map<String,Object> alreadyUpload=uploadLogService.loadByParams(params);
			if(alreadyUpload!=null&&!alreadyUpload.isEmpty()){//如果存在相同作业相同学生 则对该数据进行删除更新数据
				//进行数据删除
				String uploadUrl_=alreadyUpload.get("uploadUrl").toString();
				Util.deleteFile(localPath+uploadUrl_);//删除文件
				params.clear();
				params.put("id", alreadyUpload.get("id").toString());
				uploadLogService.delete(params);//删除数据
			}
			
			/**
			 * 开始创建上传记录start
			 */
			 Map<String,Object> logMap=new HashMap<String, Object>();
			 logMap.put("id", SqlUtil.uuid());//设置ID
			 logMap.put("userId", user.get("id"));
			 logMap.put("homeworkId", homeworkId);
			 logMap.put("uploadUrl",uploadUrl );
			 logMap.put("uploadTime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			 uploadLogService.add(logMap);
			 this.ajaxMessage(response, Syscontants.MESSAGE, "提交成功！");
			 return;
			 } catch (Exception e) {
				 Util.deleteFile(localPath+uploadUrl);//删除文件
					e.printStackTrace();
					this.ajaxMessage(response, Syscontants.ERROE, "作业提交失败,请稍后重试！");
					 return;
				}

			/**
			 * 开始创建上传记录end
			 */
			
		 }else{
			 Util.deleteFile(localPath+uploadUrl);//删除文件
			 this.ajaxMessage(response, Syscontants.ERROE, "所提交的作业记录不存在或已删除！");
			 return;
		 }
	}
	
	/**
	 * 跳转到作业上传列表页面
	 * @author zhangjf
	 * @create_time 2015-9-28 下午5:04:38
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping("log_redirect.do")
	public String log_redirect(HttpServletRequest request,HttpServletResponse response,Model model){
		 Map<String,Object> parameter = sqlUtil.queryParameter(request);//获取参数
		 Map<String,Object> homework=homeworkService.load(parameter);
		 model.addAttribute("vo", homework);
		 return "admin/baseinfo/homework/logList";
	}
	
	/**
	 * 根据作业加载学生上传列表数据
	 * @author zhangjf
	 * @create_time 2015-9-28 下午5:11:15
	 * @param request
	 * @param response
	 */
	@RequestMapping("log_list.do")
	public void log_list(HttpServletRequest request,HttpServletResponse response){
		 Map<String,Object> parameter = sqlUtil.queryParameter(request);//获取参数
		 JSONObject jsonObj = this.uploadLogService.findPageBean(parameter);
		  this.ajaxData(response, jsonObj.toJSONString()); 
	}
	
	/**
	 * 作业评分操作
	 * @author zhangjf
	 * @create_time 2015-9-29 上午9:15:04
	 * @param request
	 * @param response
	 */
	@RequestMapping("assess.do")
	public void assess(HttpServletRequest request,HttpServletResponse response){
		 try {
			Map<String,Object> parameter = sqlUtil.queryParameter(request);//获取参数
			 Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前学生
			 Map<String,Object> uploadMap=uploadLogService.load(parameter);
			 if(uploadMap!=null&&!uploadMap.isEmpty()){
				 uploadMap.put("score", parameter.get("score"));
				 uploadMap.put("assessTime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
				 uploadMap.put("assesstor", user.get("id"));
				 uploadLogService.update(uploadMap);
				 this.ajaxMessage(response, Syscontants.MESSAGE, "评分成功！");
			 }
			 this.ajaxMessage(response, Syscontants.ERROE, "作业评分失败,未找到对应的作业信息！");
		} catch (Exception e) {
			e.printStackTrace();
			 this.ajaxMessage(response, Syscontants.ERROE, "系统繁忙,作业评分失败！");
		}
	}
	/**
	 * 老师批量下载学生提交作业
	 * @author zhangjf
	 * @create_time 2015-9-29 上午9:44:11
	 * @param request
	 * @param response
	 */
	@RequestMapping("downLoadZip.do")
	public void downLoadZip(HttpServletRequest request,HttpServletResponse response){
		 Map<String,Object> parameter = sqlUtil.queryParameter(request);//获取参数
		 String localPath=request.getSession().getServletContext().getRealPath("/"); 
		 String temPath=request.getSession().getServletContext().getRealPath("/tmp/");
		 List<Map<String,Object>> logs=uploadLogService.findAll(parameter);
		 if(logs!=null&&logs.size()>0){
			 File[] files=new File[logs.size()];
			 int index=0;
			 for (Map<String, Object> log : logs) {
				File file=new File(localPath+log.get("uploadUrl").toString());
				if(file.exists()){
					String fileName=file.getName();
					 String[] suff = fileName.split("\\.");
					 fileName=log.get("student")+"."+suff[suff.length-1];
					try {
						Util.saveFileFromInputStream(new FileInputStream(file), temPath, fileName);
						File file_=new File(temPath+"/"+fileName);
						if(file_.exists()){
							files[index]=file_;
							index++;
						}
						
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			//创建zip文件
			 String filname=new SimpleDateFormat("yyyyMMddHHmmsss").format(new Date());
			 File ZipFile=new File(temPath+"/"+filname+".zip");
			try {
				Zip.ZipFiles(ZipFile, "", files);
				fileDownLoad(temPath+"/"+filname+".zip", "批量下载", response);
				Util.deleteDirectory(temPath);//删除临时文件夹
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		 }
	}
	
	/**
	 * 获取两个时间差
	 * @author zhangjf
	 * @create_time 2015-9-25 上午11:33:27
	 * @param time1
	 * @param time2
	 * @param part
	 * @return
	 */
	private  int getTimeStamp(String time1,String time2,String part){
		TimeZone.setDefault(TimeZone.getTimeZone("GMT+8"));
		Calendar cal1 = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();
		try {
			cal1.setTime(new SimpleDateFormat("yyyy-MM-dd HH:00").parse(time1));
			cal2.setTime(new SimpleDateFormat("yyyy-MM-dd HH:00").parse(time2));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		long s_times = cal1.getTimeInMillis() - cal2.getTimeInMillis();
		if(StringUtils.isNotBlank(part)){
			if(part.equals("date") || part.equals("dd"))
				return (int)(s_times / 1000 / 60 / 60 / 24);
			else if(part.equals("hour") || part.equals("HH"))
				return (int)(s_times / 1000 / 60 / 60);	
		}else{
			throw new RuntimeException("获取时间差部分异常");
		}
		return 0;
	}
	
	
}
