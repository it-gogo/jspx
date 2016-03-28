package com.go.controller.client;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.go.common.util.ExtendDate;
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.SystemConfigUtil;
import com.go.common.util.Util;
import com.go.common.util.ValidateCode;
import com.go.common.util.WebBase;
import com.go.controller.base.BaseController;
import com.go.po.common.PageBean;
import com.go.po.common.Syscontants;
import com.go.service.platform.LoginService;
import com.go.service.site.ArticleManagementService;
import com.go.service.site.CarouselManagementService;
import com.go.service.site.PicLinkService;
import com.go.service.site.SectionManagementService;
import com.go.service.site.SectionPositionService;
import com.go.service.site.VisitLogService;
import com.go.service.train.NoticeManagementService;

/**
 * 翔安进修学校门户控制器
 * @author zhangjf
 * @create_time 2016-3-25 下午5:44:34
 */
@Controller
@RequestMapping("client/portal")
public class PortalController extends BaseController {

	@Autowired
	private VisitLogService visitLogService;
	@Autowired
	private SectionManagementService sectionManagementService;
	@Autowired
	private SectionPositionService sectionPositionService;
	@Autowired
	private ArticleManagementService articleManagementService;
	@Autowired
	private PicLinkService picLinkService;
	@Autowired
	private NoticeManagementService noticeManagementService;
	@Autowired
	private CarouselManagementService carouselManagementService;
	@Autowired
	private LoginService loginService;
	/**
	 * 初始化左边数据
	 * @author zhangjf
	 * @create_time 2016-3-24 上午11:56:31
	 * @param model
	 */
	private void initLeft(ModelMap model){
		WebBase.notice(model, noticeManagementService);//查询通知公告
		WebBase.findLinks(model, picLinkService);//查询友情链接
		List<Map<String,Object>> xzbg_list=WebBase.findLinks(picLinkService, "行政办公");//查询行政办公链接集合
		model.addAttribute("xzbg_list", xzbg_list);
		List<Map<String,Object>> ztwz_list=WebBase.findLinks(picLinkService, "专题网站");//查询专题网站链接集合
		model.addAttribute("ztwz_list", ztwz_list);
	}
	
	/**
	 * 翔安进修学校门户首页
	 * @author zhangjf
	 * @create_time 2016-3-25 下午5:46:11
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("index.do")
	public String index(HttpServletRequest request,HttpServletResponse response,ModelMap model){
		WebBase.visitLog(request, visitLogService);//保存访问记录
		WebBase.findNewArticle(model, articleManagementService);//查找最新发布文章
		WebBase.carousel(model, carouselManagementService);
		WebBase.nav(model, sectionManagementService);//导航初始化
		WebBase.contentSection(model, sectionPositionService, articleManagementService, sectionManagementService);//内容栏目初始化
		initLeft(model);//左边初始化
		return "client/portal/index";
	}
	
	/**
	 * 栏目文章列表
	 * @author zhangjf
	 * @create_time 2016-3-24 上午11:56:02
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("list.do")
	public String list(HttpServletRequest request, HttpServletResponse response,ModelMap model){
		WebBase.nav(model, sectionManagementService);//导航初始化
		initLeft(model);//左边初始化
		Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);//获取请求参数
		model.addAttribute("vo", parameter);
		WebBase.listContent(model, parameter, sectionManagementService, articleManagementService);//列表内容初始化
		return "client/portal/list";
	}
	
	
	
	/**
	 * 查询文章列表页面
	 * @author zhangjf
	 * @create_time 2016-3-24 上午11:57:21
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("search_list.do")
	public String searchList(HttpServletRequest request,HttpServletResponse response,ModelMap model){
		WebBase.nav(model, sectionManagementService);//导航初始化
		initLeft(model);//左边初始化
		Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);//获取请求参数
//		WebBase.listContent(model, parameter, sectionManagementService, articleManagementService);//列表内容初始化
		
		
		if(parameter.containsKey("type")){
			parameter.put(parameter.get("type").toString(), parameter.get("content"));
		}
		PageBean<Map<String,Object>>  pageBean = this.articleManagementService.pageBean(parameter);
		model.addAttribute("pageBean", pageBean);
		model.addAttribute("vo", parameter);
		return "client/portal/search_list";
	}
	
	/**
	 * 文章内容页面
	 * @author zhangjf
	 * @create_time 2016-3-24 上午11:57:30
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("detail.do")
	public String detail(HttpServletRequest request, HttpServletResponse response,ModelMap model){
		WebBase.nav(model, sectionManagementService);//导航初始化
		initLeft(model);//左边初始化
		Map<String,Object> parameter = sqlUtil.queryParameter(request);
		model.addAttribute("vo", parameter);
		WebBase.detailContent(model, parameter, sectionManagementService, articleManagementService);//内容页面内容初始化	
		return "client/portal/detail";
	}
	
	/**
	 * 查看通知公告列表
	 * @author zhangjf
	 * @create_time 2016-3-24 上午11:57:41
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("notify_list.do")
	public String notify_list(HttpServletRequest request, HttpServletResponse response,ModelMap model){
		WebBase.nav(model, sectionManagementService);//导航初始化
		initLeft(model);//左边初始化
		 Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);//获取请求参数 
		 parameter.put("isInstation", "oa通知");
		 PageBean<Map<String,Object>>  pageBean= this.noticeManagementService.pageBean(parameter);
		 model.addAttribute("pageBean", pageBean);
		 return "client/portal/notify_list";
	}
	
	/**
	 * 通知公告内容页
	 * @author zhangjf
	 * @create_time 2016-3-24 上午11:57:49
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("notify_detail.do")
	public String notify_detail(HttpServletRequest request, HttpServletResponse response,ModelMap model){
		WebBase.nav(model, sectionManagementService);//导航初始化
		 Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		 Map<String,Object> noticeMap=noticeManagementService.load(parameter);
		 model.addAttribute("notice", noticeMap);
		 return "client/portal/notify_detail";
	}
	
	 /**
	  * 退出系统
	  * @author zhangjf
	  * @create_time 2016-3-24 上午11:58:22
	  * @param request
	  * @param response
	  * @return
	  */
	@RequestMapping("logout.do")
	public String logout(HttpServletRequest request,HttpServletResponse response){
		SysUtil.getSession(request).invalidate();
		return  "redirect:index.do";
	}
	
	/**
	 * 获取验证码
	 * @author zhangjf
	 * @create_time 2016-3-26 下午2:50:14
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("validateCode.do")
	public void validateCode(HttpServletRequest request,HttpServletResponse response) throws IOException{
		Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		Map<String,BufferedImage> codeMap=new HashMap<String, BufferedImage>();
		if(parameter.containsKey("WIDTH") && parameter.containsKey("HEIGHT")){
			codeMap=ValidateCode.CreateValidateCode(Integer.parseInt(parameter.get("WIDTH").toString()),Integer.parseInt(parameter.get("HEIGHT").toString()),0,0);
		}else{
			codeMap=ValidateCode.CreateValidateCode();
		}
		String key=codeMap.keySet().iterator().next();
		request.getSession().setAttribute("validateCode", key);
		response.setContentType("image/jpeg");//等同于response.setHeader("Content-Type", "image/jpeg");
		response.setDateHeader("expries", -1);
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");
		ImageIO.write(codeMap.get(key), "jpg", response.getOutputStream());
		
	}
	
	/**
	 * 用户登陆
	 * @author zhangjf
	 * @create_time 2016-3-26 下午3:13:45
	 * @param request
	 * @param response
	 * @throws NoSuchAlgorithmException 
	 */
	@RequestMapping("login.do")
	public void login(HttpServletRequest request,HttpServletResponse response) throws NoSuchAlgorithmException{
		Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		Object code=parameter.get("code");
		if(code==null){
			this.ajaxMessage(response, Syscontants.ERROE, "验证码错误");
			return;
		}
		String clientCode=code.toString();
		
		Object serverCode=request.getSession().getAttribute("validateCode");
		if(clientCode.toLowerCase().equals(serverCode.toString().toLowerCase())){
			String username=parameter.containsKey("text")?parameter.get("text").toString():"";
			String password=parameter.containsKey("password")?parameter.get("password").toString():"";
			if(StringUtils.isBlank(username)||StringUtils.isBlank(password)){
				this.ajaxMessage(response, Syscontants.ERROE, "账号或密码错误");
				return;
			}
			
			password=Util.Encryption(password);
			parameter.put("password", password);
			Map<String,Object> userMap=loginService.login(parameter);
			if(userMap==null||userMap.isEmpty()){
				this.ajaxMessage(response, Syscontants.ERROE, "账号或密码错误");
				return;
			}else{
				request.getSession().setAttribute(Syscontants.USER_SESSION_KEY, userMap);
				this.ajaxMessage(response, Syscontants.MESSAGE, "200");
				return;
			}
			
		}else{
			this.ajaxMessage(response, Syscontants.ERROE, "验证码错误");
			return;
		}
		
	}
	
}
