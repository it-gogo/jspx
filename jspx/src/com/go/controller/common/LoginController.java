package com.go.controller.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.go.common.util.JSONUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.ClassInfoService;
import com.go.service.platform.LoginService;
import com.go.service.platform.MenuInfoService;
import com.go.service.train.NoticeInfoService;

@Controller
@RequestMapping("/common")
public class LoginController extends BaseController {
	@Resource
	  private  MenuInfoService  menuInfoService;
	
	  @Autowired
	  private LoginService loginService;	
	  @Autowired
	  private NoticeInfoService noticeInfoService;	
	  @Resource
	  private  ClassInfoService  classInfoService;
	 /**
	   * 菜单树
	   * @author chenhb
	   * @create_time {date} 上午10:03:08
	   * @param request
	   * @param response
	   * @param model
	 * @throws Exception 
	   */
	  @RequestMapping("tree.do")
	  public  void tree(HttpServletRequest request,HttpServletResponse response,Model  model) throws Exception{
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> user=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);//当前用户
		  if(user!=null){
			  parameter.put("userId", user.get("id"));
		  }
		  List<Map<String,Object>> list=menuInfoService.findAuthority(parameter);
		  this.ajaxData(response, JSONUtil.listToArrayStr(list));
	  }
	/**
	 * 登陆
	 * @param request
	 * @param response
	 * @param session
	 * @param model
	 * @param attr
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("login.do")
	public String login(HttpServletRequest request,
			                  HttpServletResponse response,
			                  Model model) throws  Exception{
		Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		if(parameter!=null&&!parameter.isEmpty()){
			String username=parameter.containsKey("text")?parameter.get("text").toString():"";
			String password=parameter.containsKey("password")?parameter.get("password").toString():"";
			if(StringUtils.isBlank(username)||StringUtils.isBlank(password)){
				model.addAttribute("msg", "账号或密码错误");
				return "admin/login";
			}
			password=Util.Encryption(password);
			parameter.put("password", password);
			Map<String,Object> userMap=loginService.login(parameter);
			if(userMap==null||userMap.isEmpty()){
				model.addAttribute("msg", "账号或密码错误");
				return "admin/login";
			}else{
				request.getSession().setAttribute(Syscontants.USER_SESSION_KEY, userMap);
				return "redirect:../common/loginSuccess.do";
			}
		}else{
			return "admin/login";
		}
		//return "redirect:../common/loginSuccess.do";
	}
	/**
	 * 登陆成功
	 * @param request
	 * @param response
	 * @param session
	 * @param model
	 * @param attr
	 * @return
	 */
	@RequestMapping("loginSuccess.do")
	public  String  findSalmAndDept(HttpServletRequest request,
								    HttpServletResponse response,
								    HttpSession session,
								    Model model,
								    RedirectAttributes attr){
		Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);
		if(userMap==null){
			return "admin/login";
		}
		return "admin/main";
	}
	
	/**
	 * 登陆页面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("loginPage.do")
    public ModelAndView loginPage(HttpServletRequest request,
    		                       HttpServletResponse response){
		ModelAndView  mv = new ModelAndView("admin/login");
		return  mv;
	}
	
	/**
	 * 退出系统
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("loginOUT.do")
	public String loginOUT(HttpServletRequest request,
                           HttpServletResponse response){
		SysUtil.getSession(request).invalidate();
		return  "redirect:../common/loginPage.do";
	}
	
	/**
	 * 首页
	 * @author chenhb
	 * @create_time  2015-9-2 上午9:38:57
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("index.do")
	public String index(HttpServletRequest request,
                           HttpServletResponse response,Model  model){
		Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);
		if(userMap==null){
			return "redirect:loginOUT.do";
		}
		  Map<String,Object> parameter=new HashMap<String, Object>();
		  parameter.put("classUserId", userMap.get("id"));
		  List<Map<String,Object>> list=classInfoService.findAll(parameter);
		/*  if(list!=null && list.size()>0){
			  String classIds="'";
			  for(Map<String,Object> map:list){
				  classIds+=map.get("id")+"','";
			  }
			  classIds=classIds.substring(0, classIds.length()-2);
			  parameter.put("classIds", classIds);
		  }*/
		  model.addAttribute("vo", parameter);
		  model.addAttribute("classList", list);//跟该账户有关系的班级
		return  "admin/index";
	}
	
	/**
	 * 班级首页
	 * @author chenhb
	 * @create_time  2015-9-28 上午11:48:18
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("classIndex.do")
	public String classIndex(HttpServletRequest request,
                           HttpServletResponse response,Model  model){
		Map<String,Object> userMap=SysUtil.getSessionUsr(request, Syscontants.USER_SESSION_KEY);
		if(userMap==null){
			return "redirect:loginOUT.do";
		}
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  model.addAttribute("vo", parameter);
		return  "admin/classIndex";
	}
}
