package com.go.service.weixin;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.go.common.util.DateUtil;
import com.go.common.util.MessageParseUtil;
import com.go.common.util.StringOprUtil;
import com.go.common.util.WeiXin_ConfigUtil;
import com.go.common.util.WeiXin_Util;
import com.go.po.model.Button;
import com.go.po.model.Menu;
import com.go.po.model.TemplateData;
import com.go.po.model.TextMessage;
import com.go.po.model.ViewButton;
import com.go.po.model.WeiXinToken;
import com.go.po.model.WxTemplate;
import com.go.service.base.BaseService;
import com.go.thread.TokenThread;

/**
 * 处理微信相关的逻辑层实现类
 * @author zhangjf
 * @create_time 2015-10-8 上午9:39:31
 */
@Service
@SuppressWarnings("all")
public class WeiXinService extends BaseService {

	/**
	 * 设置相应消息
	 * @author zhangjf
	 * @create_time 2015-10-8 上午9:42:24
	 * @param request
	 * @param response
	 */
	public void responseMsg(HttpServletRequest request, HttpServletResponse response){
		String respMessage = processRequest(request);
		print(respMessage, request, response);
    }

	/**
	 * 向请求端发送返回数据
	 * @author zhangjf
	 * @create_time 2015-10-8 上午9:43:16
	 * @param content
	 * @param request
	 * @param response
	 */
	public void print(String content,HttpServletRequest request, HttpServletResponse response){
        try{ 
        	request.setCharacterEncoding("utf8");
    		response.setCharacterEncoding("utf-8");
            response.getWriter().print(content);  
            response.getWriter().flush();  
            response.getWriter().close();  
        }catch(Exception e){  
              
        }  
    }
	
	/**
	 * 处理微信发来的请求 
	 * @author zhangjf
	 * @create_time 2015-10-8 上午10:03:05
	 * @param request
	 * @return
	 */
	 public static String processRequest(HttpServletRequest request) {  
	        String respMessage = null;  
	        try {  
	            // 默认返回的文本消息内容  
	            String respContent = "请求处理异常，请稍候尝试！";  
	  
	            // xml请求解析  
	            Map<String, String> requestMap = MessageParseUtil.parseXml(request);  
	  
	            // 发送方帐号（open_id）  
	            String fromUserName = requestMap.get("FromUserName");  
	            // 公众帐号  
	            String toUserName = requestMap.get("ToUserName");  
	            // 消息类型  
	            String msgType = requestMap.get("MsgType");  
	            
	            String content=requestMap.get("Content");
	  
	            // 回复文本消息  
	            TextMessage textMessage = new TextMessage();  
	            textMessage.setToUserName(fromUserName);  
	            textMessage.setFromUserName(toUserName);  
	            textMessage.setCreateTime(new Date().getTime());  
	            textMessage.setMsgType(MessageParseUtil.RESP_MESSAGE_TYPE_TEXT);  
	            textMessage.setFuncFlag(0);  
	            
	            // 文本消息  
	            if (msgType.equals(MessageParseUtil.REQ_MESSAGE_TYPE_TEXT)) { 
	            	if("770251508".equals(content)){
	            		ViewButton viewButton=new ViewButton();
	            		viewButton.setName("交");
	            		viewButton.setType("view");
	            		viewButton.setUrl("http://c641484739.xicp.net/nursery/client/wechat/one.do");
	            		Menu menu = new Menu();  
	            		menu.setButton(new Button[]{viewButton});
	            		String token=WeiXin_Util.getToken();
	            		WeiXin_Util.createMenu(null,menu,token );
	            	}
	            	
	                respContent = content;  
	            }  
	            // 图片消息  
	            else if (msgType.equals(MessageParseUtil.REQ_MESSAGE_TYPE_IMAGE)) {  
	                respContent = "您发送的是图片消息！";  
	            }  
	            // 地理位置消息  
	            else if (msgType.equals(MessageParseUtil.REQ_MESSAGE_TYPE_LOCATION)) {  
	                respContent = "您发送的是地理位置消息！";  
	            }  
	            // 链接消息  
	            else if (msgType.equals(MessageParseUtil.REQ_MESSAGE_TYPE_LINK)) {  
	                respContent = "您发送的是链接消息！";  
	            }  
	            // 音频消息  
	            else if (msgType.equals(MessageParseUtil.REQ_MESSAGE_TYPE_VOICE)) {  
	                respContent = "您发送的是音频消息！";  
	            }  
	            // 事件推送  
	            else if (msgType.equals(MessageParseUtil.REQ_MESSAGE_TYPE_EVENT)) {  
	                // 事件类型  
	                String eventType = requestMap.get("Event");  
	                // 订阅  
	                if (eventType.equals(MessageParseUtil.EVENT_TYPE_SUBSCRIBE)) {  
	                    //respContent = "张进发的公众号,谢谢您的关注！";
	                	 StringBuffer buffer = new StringBuffer();  
	                     buffer.append("\ue30d您好，我是robot机器人 \ue204,欢迎关注我的公众号\ue30d").append("\n\n");  
	                    respContent= buffer.toString();  
	                	
	                }  
	                // 取消订阅  
	                else if (eventType.equals(MessageParseUtil.EVENT_TYPE_UNSUBSCRIBE)) {  
	                    // TODO 取消订阅后用户再收不到公众号发送的消息，因此不需要回复消息  
	                }  
	                // 自定义菜单点击事件  
	                else if (eventType.equals(MessageParseUtil.EVENT_TYPE_CLICK)) {  
	                    // TODO 自定义菜单权没有开放，暂不处理该类消息  
	                }  
	            }  
	  
	            textMessage.setContent(respContent);  
	            respMessage = MessageParseUtil.textMessageToXml(textMessage);
	            
	        } catch (Exception e) {  
	            e.printStackTrace();  
	        }  
	  
	        return respMessage;  
	    }
	 
	 
	 /**
	  * 消息发送方法
	  * @author zhangjf
	  * @create_time 2016-3-9 下午1:55:11
	  * @param userName
	  * @param content
	  * @param url
	  * @param weixinCode
	  */
	 public void sendMessage(String userName,String content,String url,String weixinCode){
		 if(StringUtils.isBlank(weixinCode)){
				return;
		 } 
		 String currentDate=DateUtil.getCurrentDate();
		 WxTemplate template = new WxTemplate();
		 template.setUrl(url);  
		 template.setTouser(weixinCode);//消息接受者微信号
		 template.setTopcolor("#459ae9");
		 template.setTemplate_id(WeiXin_ConfigUtil.getInstance().getParameter("messageTmpId"));
		 Map<String,TemplateData> tempMap = new HashMap<String,TemplateData>();//构建内容
		 
		 TemplateData keyword1Data = new TemplateData();
		 keyword1Data.setColor("#459ae8");
		 keyword1Data.setValue(WeiXin_ConfigUtil.getInstance().getParameter("sendSchoolName"));
		 tempMap.put("keyword1",keyword1Data);
		 
		 TemplateData keyword2Data = new TemplateData();
		 keyword2Data.setColor("#459ae8");
		 keyword2Data.setValue(userName);
		 tempMap.put("keyword2", keyword2Data);
		 
		 TemplateData keyword3Data = new TemplateData();
		 keyword3Data.setColor("#459ae8");
		 keyword3Data.setValue(currentDate);
		 tempMap.put("keyword3", keyword3Data);
		 
		 TemplateData keyword4Data = new TemplateData();
		 keyword4Data.setColor("#459ae8");
		 keyword4Data.setValue(content);
		 tempMap.put("keyword4", keyword4Data);
		 
		 template.setData(tempMap);
		 WeiXinToken token=TokenThread.accessToken;
		 //进行消息推送
		 WeiXin_Util.sendNotify(template,token==null?null:token.getToken());
	 }
	 
	
}
