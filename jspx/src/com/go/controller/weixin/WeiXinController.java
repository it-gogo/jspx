package com.go.controller.weixin;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import com.go.common.util.WeiXin_ConfigUtil;
import com.go.common.util.WeiXin_SignUtil;
import com.go.common.util.WeiXin_Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.baseinfo.TeacherInfoService;
import com.go.service.weixin.WeiXinService;
/**
 * 微信客户端控制器类
 * @author zhangjf
 * @create_time 2015-8-7 下午5:06:20
 */
@Controller
@RequestMapping("/weixin/*")
public class WeiXinController extends BaseController {

	@Autowired
	private WeiXinService weixinService;
	@Autowired
	private TeacherInfoService teacherInfoService;
	
	/**
	 * 确认请求来自微信服务器 
	 * @author zhangjf
	 * @create_time 2015-8-7 下午5:11:00
	 * @param request
	 * @param response
	 */
	@RequestMapping("confirm.do")
	public void confirm(HttpServletRequest request,HttpServletResponse response){
				//获取微信加密签名
				String signature=request.getParameter("signature");
				//获取时间戳
				String timestamp=request.getParameter("timestamp");
				//获取随机数
				String nonce=request.getParameter("nonce");
				//获取随机字符串
				String echostr=request.getParameter("echostr");
				if(null==echostr||echostr.isEmpty()){  
					weixinService.responseMsg(request,response);  
		        }else{
		        	//通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
					if(WeiXin_SignUtil.checkSignature(signature, timestamp, nonce)){
						weixinService.print(echostr, request, response);
					}else{
						weixinService.print("error", request, response);
					}
		        }
	}
	
	/**
	 * 获取用户授权
	 * @author zhangjf
	 * @create_time 2015-8-8 上午9:15:01
	 * @param request
	 * @param response
	 */
	@RequestMapping("getOauth.do")
	public void getOauth(HttpServletRequest request,HttpServletResponse response){
		// String url="http://"+request.getServerName()+request.getContextPath();
		 String rendUrl=getRequestUrlSubBeforeDo(request)+"/getOpenId.do";
			try {
				String codeUrl="https://open.weixin.qq.com/connect/oauth2/authorize?appid="
						+WeiXin_ConfigUtil.getInstance().getAppId()
						+"&redirect_uri="
						+URLEncoder.encode(rendUrl, "UTF-8")
						+"&response_type=code&scope=snsapi_base&state=STATE#wechat_redirect";
				response.sendRedirect(codeUrl);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
	
	/**
	 * 获取openid并跳转至绑定页面
	 * @author zhangjf
	 * @create_time 2015-8-8 上午9:22:20
	 * @param request
	 * @param response
	 */
	@RequestMapping("getOpenId.do")
	public void  getOpenId(HttpServletRequest request,HttpServletResponse response){
		String code=request.getParameter("code");
		if(StringUtils.isNotBlank(code)){
			String getOpenIdUrl="https://api.weixin.qq.com/sns/oauth2/access_token?appid="+WeiXin_ConfigUtil.getInstance().getAppId()+"&secret="+WeiXin_ConfigUtil.getInstance().getAppsecret()+"&code="+code+"&grant_type=authorization_code";
			JSONObject json=WeiXin_Util.httpRequest(getOpenIdUrl, "GET", null);
			if(json.containsKey("openid")){
				//String url="http://"+request.getServerName()+request.getContextPath();
				String rendUrl=getRequestUrlSubBeforeDo(request)+"/main.do?openid="+json.getString("openid");
				try {
					response.sendRedirect(rendUrl);
				} catch (IOException e) {
					e.printStackTrace();
				}
			
			}
		}
	}
	
	/**
	 * 微网站首页
	 * @author zhangjf
	 * @create_time 2015-10-8 上午10:22:54
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("main.do")
	public String main(HttpServletRequest request,HttpServletResponse response,ModelMap model){
		String openid=request.getParameter("openid");
		if(StringUtils.isNotBlank(openid)){
			model.addAttribute("openid", openid);
			return "weixin/main";
		}else{
			model.addAttribute("msg", "哎哟喂！非法操作！");
			return "error";
		}
	}
	
	/**
	 * 微信端绑定操作页面
	 * @author zhangjf
	 * @create_time 2016-3-9 上午11:25:15
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("bindPage.do")
	public String bindPage(HttpServletRequest request,HttpServletResponse response,ModelMap model){
		String openid=request.getParameter("openid");//获取操作的微信号
		model.addAttribute("openid", openid);
		if(StringUtils.isBlank(openid)){
			model.addAttribute("msg", "哎哟喂！非法操作！");
			return "error";
		}
	//	String url="http://"+request.getServerName()+request.getContextPath();
		String rendUrl=getRequestUrlSubBeforeDo(request)+"/main.do?openid="+openid;
		model.put("rendUrl", rendUrl);
		return "weixin/bind_info";
	}
	
	
	/**
	 * 保存绑定信息
	 * @author zhangjf
	 * @create_time 2016-3-9 上午11:28:02
	 * @param request
	 * @param response
	 */
	@RequestMapping("addBindInfo.do")
	public void addBindInfo(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);//获取提交过来的参数
		String idcard=parameter.containsKey("idcard")?parameter.get("idcard").toString():"";
		String openid=parameter.containsKey("openid")?parameter.get("openid").toString():"";
		if(StringUtils.isBlank(idcard)||StringUtils.isBlank(openid)){
			this.ajaxMessage(response, Syscontants.ERROE,"哎哟喂！非法操作！");
			return;
		}
		 try {
			 String msg=teacherInfoService.bindWeChat(parameter);
			if(StringUtils.isBlank(msg)){
				 this.ajaxMessage(response, Syscontants.MESSAGE,"绑定成功");
			}else{
				this.ajaxMessage(response, Syscontants.ERROE,msg);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			this.ajaxMessage(response, Syscontants.ERROE,"绑定失败,稍后重试");
		}	
	}
	
}
