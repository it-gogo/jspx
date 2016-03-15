package com.go.controller.common;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.go.common.util.DateUtil;
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.resources.AbsoluteManagementService;
import com.go.service.resources.FileManagementService;
import com.go.service.resources.TopFolderService;

/**
 * 文件上传控制器
 * @author zhangjf
 * @create_time 2015-11-18 下午1:41:13
 */
@Controller
@RequestMapping("/common/upload/*")
public class UploadController extends BaseController {

	@Autowired
	private FileManagementService fileManagementService;
	@Autowired
	private AbsoluteManagementService absoluteManagementService;
	@Autowired
	private TopFolderService topFolderService;
	/**
	 * 处理上传文件
	 * @author zhangjf
	 * @create_time 2015-11-18 下午1:42:36
	 * @param request
	 * @param response
	 * @param Filedata
	 */
	@RequestMapping("upload.do")
	public void upload(HttpServletRequest request,HttpServletResponse response,@RequestPart MultipartFile Filedata){
		if(Filedata==null||Filedata.isEmpty())
		{
			this.ajaxMessage(response, Syscontants.ERROE, "操作非法,请稍后重试！");
			return;
		}
		Map<String,Object> parameter = sqlUtil.setParameterInfo(request);//获取请求参数
		Map<String,Object> fileMap=new HashMap<String, Object>();//用于保存文件的集合
		/**
		 * 第一步:根据上一层文件夹ID获取路径;若不存在则根据顶级ID创建目录
		 */
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("id", parameter.get("parentId"));
		Map<String,Object> parentPath=fileManagementService.load(params);
		Map<String,Object> topPath=null;
		String path="";//取到存放的地址
		String relativeUrl="";//相对地址
		if(parentPath==null||parentPath.isEmpty()){
			//params.put("id", parameter.get("topFileId"));
			//查找部门文件ID作为父ID
			topPath=absoluteManagementService.findOne(parameter);
			if(topPath==null||topPath.isEmpty()){
				this.ajaxMessage(response, Syscontants.ERROE, "请先在路径管理配置科室文件夹路径！");
				return;
			}
			fileMap.put("topFileId", topPath.get("topFileId"));
			fileMap.put("parentId", topPath.get("topFileId"));
			fileMap.put("absoluteId", topPath.get("id"));
			Object departPath=topPath.get("absoluteUrl");
			params.put("id", topPath.get("topFileId"));
//			Map<String,Object> departMap=departService.load(params);
			Map<String,Object> departMap=topFolderService.findTopFolder(params);
			if(departMap==null||departMap.isEmpty()){//校验部门是否存在
				this.ajaxMessage(response, Syscontants.ERROE, "操作非法,请稍后重试！");
				return;
			}
			path+=departPath+"/"+departMap.get("name");
			relativeUrl=departMap.get("name")+"";
		}else{
			topPath=absoluteManagementService.findOne(parentPath);
			if(topPath==null||topPath.isEmpty()){
				this.ajaxMessage(response, Syscontants.ERROE, "请先在路径管理配置科室文件夹路径！");
				return;
			}
			path+=topPath.get("absoluteUrl")+"/"+parentPath.get("relativeUrl")+"";
			//path=parentPath.get("absoluteUrl")==null?"":parentPath.get("absoluteUrl")+"";
			relativeUrl=parentPath.get("relativeUrl")==null?"":parentPath.get("relativeUrl")+"";
			fileMap.put("parentId", parentPath.get("id"));
			fileMap.put("absoluteId", parentPath.get("absoluteId"));
			fileMap.put("topFileId", parentPath.get("topFileId"));
		}
		fileMap.put("id", SqlUtil.uuid());
		fileMap.put("relativeUrl", relativeUrl);
		//fileMap.put("absoluteUrl", path);
		fileMap.put("type", "文件");
		try {
			/**
			 * 第二步:进行文件保存操作
			 */
			String filename = StringUtils.isNotBlank(Filedata.getOriginalFilename())?Filedata.getOriginalFilename():"";//获取文件名
			if(filename!=null && !"".equals(filename)){
		    	   String[] suff = filename.split("\\.");
		    	   if(suff.length>1){
		    		   fileMap.put("suffix", "."+suff[suff.length-1]);
		    	   }
		    	   /**zhangjf 2015-11-30 重名处理start**/
					 params=new HashMap<String, Object>();
					 params.put("name", filename);
					 params.put("parentId", parameter.get("parentId"));
					 Map<String,Object> alreadyMap=fileManagementService.findOne(params);
					 if(alreadyMap!=null&&!alreadyMap.isEmpty()){
						 filename=suff[0]+"_"+System.currentTimeMillis()+"."+suff[suff.length-1];
					 }
					 /**zhangjf 2015-11-30 重名处理end**/   
		    	   
		    	   
		     }else{
		    	 this.ajaxMessage(response, Syscontants.ERROE, "操作非法,请稍后重试！");
				 return;
		     }
			
			fileMap.put("name", filename);
			Long fileSize=Filedata.getSize();//获取文件大小
			fileMap.put("fileSize", fileSize);
			 Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
			 fileMap.put("creator", userMap.get("id"));
			 fileMap.put("createdate", DateUtil.getCurrentTime());
			InputStream stream = Filedata.getInputStream(); 
			Util.saveFileFromInputStream(stream, path, filename);//保存上传文件
			/**
			 * 第三步：进行数据库记录保存
			 */
			fileManagementService.add(fileMap);
			 this.ajaxMessage(response, Syscontants.MESSAGE, "200");
		} catch (Exception e) {
			e.printStackTrace();
			this.ajaxMessage(response, Syscontants.ERROE, "系统繁忙:"+e.getMessage());
		}
	}
}
