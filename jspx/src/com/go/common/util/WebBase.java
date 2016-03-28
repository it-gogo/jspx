package com.go.common.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.ui.ModelMap;

import com.go.po.common.PageBean;
import com.go.service.baseinfo.ClassInfoService;
import com.go.service.site.ArticleManagementService;
import com.go.service.site.CarouselManagementService;
import com.go.service.site.PicLinkService;
import com.go.service.site.SectionManagementService;
import com.go.service.site.SectionPositionService;
import com.go.service.site.VisitLogService;
import com.go.service.train.NoticeManagementService;

/**
 * 门户基础数据查询
 * @author chenhb
 * @create_time  2016-1-27 下午1:35:25
 */
public class WebBase {
	/**
	 * 导航初始化
	 * @author zhangjf
	 * @create_time 2015-11-4 上午9:16:24
	 * @param model
	 */
	public static void nav(ModelMap model,SectionManagementService sectionManagementService){
		 /**
		 * 导航栏目
		 */
		Map<String,Object >params=new HashMap<String, Object>();
		params.put("type", "oa栏目");
		params.put("isNavShow", "是");
		params.put("isRoot", "Y");
		List<Map<String,Object>> sections=sectionManagementService.findAll(params);//加载所有门户网站栏目
		for (Map<String, Object> se : sections) {//遍历栏目获取二级栏目
			//根据当前节点查询下一级菜单
			params=new HashMap<String, Object>();
			params.put("parentId", se.get("id"));
			List<Map<String,Object>> childrens=sectionManagementService.findAll(params);//获取二级菜单
			se.put("childrens", childrens);
		}
		model.addAttribute("sections", sections);
	}
	/**
	 * 轮播初始化
	 * @author chenhb
	 * @create_time  2016-1-27 下午1:42:12
	 * @param model
	 * @param carouselManagementService
	 */
	public static void carousel(ModelMap model,CarouselManagementService carouselManagementService){
		/**
		 * 获取轮播图片
		 */
		Map<String,Object >params=new HashMap<String, Object>();
		params.put("type", "oa轮播");
		List<Map<String,Object>> carousels=carouselManagementService.findAll(params);//加载门户网站的轮播图片列表
		model.addAttribute("carousels", carousels);
	}
	/**
	 * 通知公告初始化
	 * @author chenhb
	 * @create_time  2016-1-27 下午1:43:26
	 * @param model
	 * @param noticeManagementService
	 */
	public static void notice(ModelMap model,NoticeManagementService noticeManagementService){
		/***
		 * 获取通知公告列表
		 */
		Map<String,Object >params=new HashMap<String, Object>();
		params.put("isInstation", "oa通知");
		String noticeNum=SystemConfigUtil.getInstance().getParameter("noticeNum");
		if(noticeNum!=null){
			params.put("limit", "limit 0,"+noticeNum);
		}
		List<Map<String,Object>> notifys=noticeManagementService.findAll(params);//获取通知列表
		model.addAttribute("notifys", notifys);
	}
	/**
	 * 内容栏目初始化
	 * @author chenhb
	 * @create_time  2016-1-27 下午1:52:01
	 * @param model
	 * @param sectionPositionService
	 * @param articleManagementService
	 * @param sectionManagementService
	 */
	public static void contentSection(ModelMap model,SectionPositionService sectionPositionService,ArticleManagementService articleManagementService,SectionManagementService sectionManagementService){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("type", "前台网站");
		List<Map<String,Object>> sections=sectionPositionService.findAll(params);//加载所有门户网站栏目
		int loadNum=Integer.parseInt(SystemConfigUtil.getInstance().getValByKey("articleNum"));
		String sectionArticleNum=SystemConfigUtil.getInstance().getParameter("sectionArticleNum");
		int index=0;
		for (Map<String, Object> section : sections) {//遍历栏目获取最新文章
			Object articleNumber=section.get("articleNumber");
			int number=loadNum;
			if(articleNumber!=null){
				number=Integer.parseInt(articleNumber.toString());
			}
			params=new HashMap<String, Object>();
			Object positionName=section.get("positionName");
			if("最新导读".equals(positionName)){
				section.put("name","最新导读");
				//获取最新更新文章
				params=new HashMap<String, Object>();
				params.put("limit", "limit 0,"+number);
				params.put("distinct", true);
				params.put("front", true);
				List<Map<String,Object>> updateList=articleManagementService.findAll(params);//最近更新列表
				section.put("articles", updateList);
				continue;
			}
			params.put("sectionIds", section.get("id"));
			params.put("loadNum", number);
			params.put("limit", "limit 0,"+number);
			List<Map<String,Object>> articles=articleManagementService.findAll(params);
			section.put("articles", articles);
			//根据当前节点查询下一级菜单
			params=new HashMap<String, Object>();
			params.put("parentId", section.get("id"));
			List<Map<String,Object>> childrens=sectionManagementService.findAll(params);//获取二级菜单
			if(index==0){//遍历二级菜单取文章
				for (Map<String, Object> children : childrens) {
					params=new HashMap<String, Object>();
					params.put("sectionId", children.get("id"));
					params.put("loadNum", sectionArticleNum);
					params.put("limit", "limit 0,"+sectionArticleNum);
					List<Map<String,Object>> articleList=articleManagementService.findAll(params);
					children.put("articles", articleList);
				}
			}
			index++;
			section.put("childrens", childrens);
		}
		model.addAttribute("contentSections", sections);
	}
	/**
	 * 获取一个栏目的文章
	 * @author chenhb
	 * @create_time  2016-3-9 上午10:37:32
	 * @param model
	 * @param sectionPositionService
	 * @param articleManagementService
	 * @param sectionManagementService
	 * @param i
	 */
	public static void oneSection(ModelMap model,SectionPositionService sectionPositionService,ArticleManagementService articleManagementService,SectionManagementService sectionManagementService,String limit){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("type", "oa栏目");
		params.put("limit",  limit);
		List<Map<String,Object>> sections=sectionPositionService.findAll(params);//加载所有门户网站栏目
		int loadNum=Integer.parseInt(SystemConfigUtil.getInstance().getValByKey("articleNum"));
		for (Map<String, Object> section : sections) {//遍历栏目获取最新文章
			int number=loadNum;
			Object articleNumber=section.get("articleNumber");
			if(articleNumber!=null){
				number=Integer.parseInt(articleNumber.toString());
			}
			params=new HashMap<String, Object>();
			Object positionName=section.get("positionName");
			if("最新导读".equals(positionName)){
				section.put("name","最新导读");
				//获取最新更新文章
				params=new HashMap<String, Object>();
				params.put("limit", "limit 0,"+number);
				params.put("distinct", true);
				params.put("front", true);
				List<Map<String,Object>> updateList=articleManagementService.findAll(params);//最近更新列表
				section.put("articles", updateList);
				continue;
			}
			params.put("sectionIds", section.get("id"));
			params.put("loadNum", number);
			params.put("limit", "limit 0,"+number);
			List<Map<String,Object>> articles=articleManagementService.findAll(params);
			section.put("articles", articles);
		}
		model.addAttribute("oneSection", sections);
	}
	/**
	 * 获取当前栏目
	 * @author chenhb
	 * @create_time  2016-1-27 下午2:09:04
	 * @param parameter
	 * @param sectionManagementService
	 * @return
	 */
	public static Map<String,Object> currentSection(Map<String,Object> parameter,SectionManagementService sectionManagementService){
		/**
		 * 第一步：获取当前栏目
		 */
		Map<String,Object> section=new HashMap<String, Object>();
		section.put("id", parameter.get("sectionId"));
		section=sectionManagementService.load(section);
		if(section==null){
			section=new HashMap<String, Object>();
			section.put("id", "#");
		}
		return section;
	}
	public static Map<String,Object> parentSection(Map<String,Object> section,SectionManagementService sectionManagementService){
		/**
		 * 第二步：获取父栏目
		 */
		Map<String,Object> parentsection=new HashMap<String, Object>();
		parentsection.put("id", section.get("parentId"));
		parentsection=sectionManagementService.load(parentsection);
		return parentsection;
	}
	/**
	 * 获取列表页面左边栏目
	 * @author chenhb
	 * @create_time  2016-1-27 下午2:12:12
	 * @param section
	 * @param sectionManagementService
	 * @return
	 */
	public static List<Map<String,Object>> listSection(Map<String,Object> section,SectionManagementService sectionManagementService){
		/**
		 * 第四步：获取列表页面左边栏目
		 */
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("parentId", section.get("id"));
		List<Map<String,Object>> childrenList=sectionManagementService.findAll(params);//获取二级菜单
		if(childrenList==null || childrenList.size()==0){
			if(section.get("parentId")!=null){
				params.put("parentId", section.get("parentId"));
				childrenList=sectionManagementService.findAll(params);//获取同级级菜单
			}else{//加载一级栏目
				params=new HashMap<String, Object>();
				params.put("type", "oa栏目");
				params.put("isRoot", "Y");
				params.put("isNavShow", "是");
				childrenList=sectionManagementService.findAll(params);//加载所有门户网站栏目
			}
		}
		return childrenList;
	}
	
	/**
	 * 根据当前栏目获取子栏目列表
	 * @author zhangjf
	 * @create_time 2016-3-24 下午2:23:24
	 * @param section
	 * @param sectionManagementService
	 * @return
	 */
	public static List<Map<String,Object>> childSections(Map<String,Object> section,SectionManagementService sectionManagementService){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("parentId", section.get("id"));
		List<Map<String,Object>> childrenList=sectionManagementService.findAll(params);//获取二级菜单
		return childrenList;
	}
	
	
	/**
	 * 列表页面内容
	 * @author chenhb
	 * @create_time  2016-1-27 下午1:59:20
	 * @param model
	 * @param section
	 * @param sectionManagementService
	 */
	public static void listContent(ModelMap model,Map<String,Object> parameter,SectionManagementService sectionManagementService,ArticleManagementService articleManagementService){
		/**
		 * 第一步：获取当前栏目
		 */
		Map<String,Object> section=currentSection(parameter, sectionManagementService);
		model.addAttribute("section", section);
		/**
		 * 第二步：获取父栏目
		 */
		Map<String,Object> parentsection=parentSection(section, sectionManagementService);
		model.addAttribute("parentsection", parentsection);
		/**
		 * 第三步：获取文章分页列表
		 */
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("code", section.get("code"));
		params.put("page", parameter.get("page"));
		PageBean<Map<String,Object>>  pageBean = articleManagementService.pageBean(params);
		model.addAttribute("pageBean", pageBean);
		/**
		 * 第四步：获取列表页面左边栏目
		 */
		List<Map<String,Object>> childrenList=listSection(section, sectionManagementService);
		model.addAttribute("childrenList", childrenList);
	}
	
	/**
	 * 内容页面内容
	 * @author chenhb
	 * @create_time  2016-1-27 下午1:59:20
	 * @param model
	 * @param section
	 * @param sectionManagementService
	 */
	public static void detailContent(ModelMap model,Map<String,Object> parameter,SectionManagementService sectionManagementService,ArticleManagementService articleManagementService){
		Map<String,Object> article=articleManagementService.load(parameter);
		model.addAttribute("article", article);
		//第一步:先递增阅读数
		Map<String,Object> countMap=new HashMap<String, Object>();
		if(article.containsKey("readCount")&&article.get("readCount")!=null){
			int historyCount=Integer.parseInt(article.get("readCount").toString());
			countMap.put("id", article.get("id"));
			countMap.put("readCount", (historyCount+1));
		}else{
			countMap.put("id", article.get("id"));
			countMap.put("readCount",1);
		}
		//第二步：获取当前栏目
		Map<String,Object> section=new HashMap<String, Object>();
		section.put("sectionId", article.get("sectionId"));
		section=WebBase.currentSection(section, sectionManagementService);
		model.addAttribute("section", section);
		  
		//第三步：获取父栏目
		Map<String,Object> parentsection=WebBase.parentSection(section, sectionManagementService);
		model.addAttribute("parentsection", parentsection);
		
		//第四步：获取左边栏目
		List<Map<String,Object>> childrenList=WebBase.listSection(section, sectionManagementService);
		model.addAttribute("childrenList", childrenList);
		  
		  
		//第五步：获取上下文章
		articleManagementService.addCount(countMap);
		parameter.put("createdate", article.get("createdate"));
		model.addAttribute("preArticle", articleManagementService.pre(parameter));
		model.addAttribute("nextArticle", articleManagementService.next(parameter));
	}
	/**
	 * 友情链接
	 * @author chenhb
	 * @create_time  2016-2-29 下午2:31:10
	 * @param model
	 * @param picLinkService
	 */
	public static void findLinks(ModelMap model,PicLinkService picLinkService){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("type", "友情链接");
		model.addAttribute("friend_links", picLinkService.findAll(params));//友情链接
	}
	
	/**
	 * 根据类型查询图片链接
	 * @author zhangjf
	 * @create_time 2016-3-24 下午3:33:55
	 * @param model
	 * @param picLinkService
	 * @param type
	 */
	public static List<Map<String,Object>> findLinks(PicLinkService picLinkService,String type){
		if(StringUtils.isBlank(type)){
			type="友情链接";
		}
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("type", type);
		return picLinkService.findAll(params);
	}
	
	/**
	 * 获取一个广告图片
	 * @author chenhb
	 * @create_time  2016-3-19 下午4:07:21
	 * @param model
	 * @param picLinkService
	 */
	public static void findOneGG(ModelMap model,PicLinkService picLinkService){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("type", "广告图片");
		Map<String,Object>gg_link=picLinkService.findOne(params);
		model.addAttribute("gg_link", gg_link);//网站广告图片
	}
	/**
	 * 热点排行
	 * @author chenhb
	 * @create_time  2016-3-1 上午10:06:06
	 * @param model
	 * @param articleManagementService
	 */
	public static void findHotArticle(ModelMap model,ArticleManagementService articleManagementService){
		Map<String,Object> params=new HashMap<String, Object>();
		String articleNum=SystemConfigUtil.getInstance().getParameter("articleNum");
		params.put("limit", "limit 0,"+articleNum);
		params.put("distinct", true);
		params.put("front", true);
		List<Map<String,Object>> hotList=articleManagementService.findAll(params);//热点排行列表
		model.addAttribute("hotList", hotList);
	}
	
	/**
	 * 查找最新文章内容
	 * @author zhangjf
	 * @create_time 2016-3-25 下午6:29:28
	 * @param model
	 * @param articleManagementService
	 */
	public static void findNewArticle(ModelMap model,ArticleManagementService articleManagementService){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("limit", "limit 0,"+1);
		params.put("orderRule", "createdate");
		List<Map<String,Object>> newList=articleManagementService.findAll(params);//最新发布文章
		if(newList==null||newList.isEmpty()){
			model.addAttribute("newArticle", "");
		}
		model.addAttribute("newArticle", newList.get(0));
	}
	
	/**
	 * 保存访问记录
	 * @author chenhb
	 * @create_time  2016-1-27 下午1:45:55
	 * @param request
	 */
	public static void visitLog(HttpServletRequest request,VisitLogService visitLogService){
		Map<String,Object> params=new HashMap<String, Object>();
		Map<String,Object> visitMap=null;
		String ip=request.getRemoteAddr();//访问IP
		String visitTime=DateUtil.getCurrentTime();//访问时间
		params.put("ip", ip);
		visitMap=visitLogService.findOne(params);
		if(visitMap==null||visitMap.isEmpty()){//首次访问进行访问记录保存
			visitMap=new HashMap<String, Object>();
			visitMap.put("id", SqlUtil.uuid());
			visitMap.put("ip", ip);
			visitMap.put("visitTime", visitTime);
			visitLogService.add(visitMap);
		}else if(DateUtil.getTimeStamp(visitTime, visitMap.get("visitTime").toString(), "ss")>=Integer.parseInt(SystemConfigUtil.getInstance().getValByKey("visit_save_time"))){
			visitMap=new HashMap<String, Object>();
			visitMap.put("id", SqlUtil.uuid());
			visitMap.put("ip", ip);
			visitMap.put("visitTime", visitTime);
			visitLogService.add(visitMap);
		}
		
	}
}
