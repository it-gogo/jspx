package com.go.service.site;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Service;
import com.alibaba.fastjson.JSONObject;
import com.go.common.util.Util;
import com.go.po.common.PageBean;
import com.go.service.base.BaseService;
/**
 * 门户文章管理逻辑层
 * @author zhangjf
 * @create_time 2016-3-25 上午9:32:28
 */
@Service
public class ArticleManagementService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("articleManagement.findCount", "articleManagement.findList", parameter);
	}
	public  PageBean<Map<String,Object>>  pageBean(Map<String,Object> parameter){
		return this.getBaseDao().findPageBean("articleManagement.findCount", "articleManagement.findList", parameter);
	}
	public  List<Map<String,Object>>  findAll(Map<String,Object> parameter){
		return this.getBaseDao().findList("articleManagement.findAll", parameter);
	}
	public  List<Map<String,Object>>  findAll1(Map<String,Object> parameter){
		return this.getBaseDao().findList("articleManagement.findAll1", parameter);
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("articleManagement.load", parameter);
	}
	
	/**
	 * 更新阅读数
	 * @author zhangjf
	 * @create_time 2015-10-20 下午4:22:58
	 * @param params
	 */
	public void addCount(Map<String,Object> params){
		this.getBaseDao().update("articleManagement.addCount", params);
	}
	
	/**
	 * 上一条数据
	 * @author chenhb
	 * @create_time  2015-10-9 下午5:27:43
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  pre(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("articleManagement.pre", parameter);
	}
	/**
	 * 下一条数据
	 * @author chenhb
	 * @create_time  2015-10-9 下午5:27:43
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  next(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("articleManagement.next", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
		this.getBaseDao().insert("articleSection.add", parameter);
	    this.getBaseDao().insert("articleManagement.add", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		List<String> ids=new ArrayList<String>();
		ids.add(parameter.get("id").toString());
		this.getBaseDao().delete("articleSection.delete", ids);//删除之前的关联栏目数据
		this.getBaseDao().insert("articleSection.add", parameter);
		this.getBaseDao().update("articleManagement.update", parameter);
	}
	
	
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter,HttpServletRequest request){
		//1.查询删除文章内容
		List<Map<String,Object>> articles=listByIds(parameter);
		Map<String, Object> params=null;
		for (Map<String, Object> article : articles) {
			Object picUrl =article.get("picUrl");
			Object accessoryUrl=article.get("accessoryUrl");
			String path="";
			if(picUrl!=null){
				 path=request.getSession().getServletContext().getRealPath(picUrl+"");
				Util.deleteFile(path);
			}
			if(accessoryUrl!=null){
				path=request.getSession().getServletContext().getRealPath(accessoryUrl+"");
				Util.deleteFile(path);
			}
			params=new HashMap<String, Object>();
			params.put("id", article.get("id"));
			params.put("sectionId", article.get("sectionId"));
			deleteOther(params);
		}
		this.getBaseDao().delete("articleManagement.delete", parameter);
	}
	
	/**
	 * 删除文章相关内容
	 * @author zhangjf
	 * @create_time 2015-11-6 上午11:42:38
	 * @param params
	 */
	public void deleteOther(Map<String,Object> params){
		this.getBaseDao().delete("articleManagement.deleteOther", params);
	}
	
	/**
	 * 
	 * @author zhangjf
	 * @create_time 2015-11-6 上午11:27:29
	 * @param parameter
	 */
	public List<Map<String,Object>> listByIds(List<String> parameter){
		return this.getBaseDao().findList("articleManagement.listByIds", parameter);
	}
	
	
	/**
	 * 创建RSS最新文章导读
	 * @author zhangjf
	 * @create_time 2016-1-7 下午5:21:36
	 * @param request
	 *//*
	public void createRssXml(HttpServletRequest request){
		 *//**
		   * zhangjf 2016-01-07若对文章进行增加和修改生成RSS访问xml文件start
		   *//*
		  if("true".equals(SystemConfigUtil.getInstance().getParameter("isRss"))){
			  String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
			  String xmlDir = request.getSession().getServletContext().getRealPath("rss");//保存xml文件地址
			  File xmlFile = new File(xmlDir);       
		        if(!xmlFile.exists()){
		        	xmlFile.mkdirs();//创建目录
		        }
			  String fileName="hcqsng.xml";
			  //网站描述相关信息
			  Map<String,String> siteMap=new HashMap<String, String>();
			  siteMap.put("siteTitle", "海沧青少年宫");
			  siteMap.put("siteDescription", "最新文章导读列表");
			  siteMap.put("siteUrl", basePath);
			  siteMap.put("siteCopyright", "Copyright 2015-2016 海沧青少年宫版权所有");
			  //获取最新导读文章
			  Map<String,Object> params=new HashMap<String, Object>();
				params.put("limit", "limit 0,20");
				params.put("front", true);
				List<Map<String,Object>> updateList=this.findAll(params);//最近更新列表
				for (Map<String, Object> map : updateList) {
					String url= basePath+"client/qsng/detail.do?id="+map.get("id");
					map.put("description","<a href='"+url+"'>"+map.get("title")+"</a>");
					map.put("link",url);
				}
				RSSUtil.createXml(updateList, siteMap, xmlDir+File.separator+fileName);
		  }
		  *//**
		   * zhangjf 2016-01-07若对文章进行增加和修改生成RSS访问xml文件end
		   *//*
	}*/
	
	
}
