package com.go.controller.weixin;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.go.common.util.ExtendDate;
import com.go.common.util.WeiXin_ConfigUtil;
import com.go.common.util.WeiXin_SignUtil;
import com.go.common.util.WeiXin_Util;
import com.go.controller.base.BaseController;
import com.go.po.common.Syscontants;
import com.go.service.weixin.WeiXin_MessageService;
/**
 * 微信客户端控制器类
 * @author zhangjf
 * @create_time 2015-8-7 下午5:06:20
 */
@Controller
@RequestMapping("/weixin/*")
public class WeiXinController extends BaseController {

	@Autowired
	private WeiXin_MessageService weixin_messageService;
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
					weixin_messageService.responseMsg(request,response);  
		        }else{
		        	//通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
					if(WeiXin_SignUtil.checkSignature(signature, timestamp, nonce)){
						weixin_messageService.print(echostr, request, response);
					}else{
						weixin_messageService.print("error", request, response);
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
		 String url="http://"+request.getServerName()+request.getContextPath();
		 String rendUrl=url+"/weixin/getOpenId.do";
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
	public String  getOpenId(HttpServletRequest request,HttpServletResponse response,ModelMap model){
		String code=request.getParameter("code");
		if(StringUtils.isNotBlank(code)){
			String getOpenIdUrl="https://api.weixin.qq.com/sns/oauth2/access_token?appid="+WeiXin_ConfigUtil.getInstance().getAppId()+"&secret="+WeiXin_ConfigUtil.getInstance().getAppsecret()+"&code="+code+"&grant_type=authorization_code";
			JSONObject json=WeiXin_Util.httpRequest(getOpenIdUrl, "GET", null);
			if(json.containsKey("openid")){
				model.addAttribute("openid", json.getString("openid"));
				return "weixin/bind";
			}
		}
		return "admin/login";
	}
			
	/**
	 * 绑定数据保存
	 * @author zhangjf
	 * @create_time 2015-8-8 上午10:26:35
	 * @param request
	 * @param response
	 * @param info
	 * @return
	 */
	@RequestMapping("save.do")
	public void save(HttpServletRequest request,HttpServletResponse response){
		//获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  if(parameter.containsKey("weixin_code")&&parameter.containsKey("id_card_no")){
			  String weixin_code=parameter.get("weixin_code").toString();
			  if(StringUtils.isBlank(weixin_code)){
				  this.ajaxMessage(response, Syscontants.MESSAGE,"绑定失败");
			  } 
			  String id_card_no=parameter.get("id_card_no").toString();
			  if(StringUtils.isBlank(id_card_no)){
				  this.ajaxMessage(response, Syscontants.MESSAGE,"身份证号不能为空");
				  return ;
			  }
			  String validate_msg=WeiXin_SignUtil.IDCardValidate(id_card_no);
			  if(StringUtils.isNotBlank(validate_msg)){
				  this.ajaxMessage(response, Syscontants.MESSAGE,validate_msg);
				  return;
			  }
			  /**
			   * 根据身份证号查询是否存在
			   */
			  Map<String,Object> params=new HashMap<String, Object>();
			  params.put("weixin_code", weixin_code);
			  Map<String,Object> bind_info=weixin_messageService.load(parameter);
			  if(bind_info!=null&&!bind_info.isEmpty()){//修改操作
				  String old_id_no=bind_info.get("id_card_no").toString();
				if(!id_card_no.equals(old_id_no)){
					bind_info.put("id_card_no", id_card_no);
					weixin_messageService.update(bind_info);
					this.ajaxMessage(response, Syscontants.MESSAGE, "修改成功");
					return;
				}
			  }else{
				  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
				  String current_time=ExtendDate.getYMD_h_m_s(new Date());
				  n_parameter.put("bind_time", current_time);
				  n_parameter.put("update_time", current_time);
				  weixin_messageService.add(n_parameter);
				  this.ajaxMessage(response, Syscontants.MESSAGE,"绑定成功");
				  return;
			  }
			 
		  }else{
			  this.ajaxMessage(response, Syscontants.MESSAGE,"绑定失败,绑定信息不完整");
			  return;
		  }
		//  boolean  isIDNull = sqlUtil.isIDNull(parameter,"id");
		  /*if(isIDNull){
			  //设置ID
			  Map<String,Object> n_parameter = sqlUtil.setTableID(parameter);
			  //添加菜单
			  weixin_messageService.add(n_parameter);
			  this.ajaxMessage(response, Syscontants.MESSAGE,"绑定成功");
		  }else{
			  this.ajaxMessage(response, Syscontants.MESSAGE,"绑定失败");
		  }*/
		 
	}
	
}
