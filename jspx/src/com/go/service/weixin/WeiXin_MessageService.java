package com.go.service.weixin;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.stereotype.Service;

import com.go.service.base.BaseService;
/**
 * 微信端消息回复逻辑层
 * @author zhangjf
 * @create_time 2015-8-7 下午5:32:33
 */
@Service
public class WeiXin_MessageService extends BaseService {

	/**
	 * 设置响应消息
	 * @author zhangjf
	 * @create_time 2015-8-7 下午5:35:20
	 * @param request
	 * @param response
	 */
	public void responseMsg(HttpServletRequest request, HttpServletResponse response){  
        String postStr=null;  
        try{  
            postStr=readStreamParameter(request.getInputStream());  
        }catch(Exception e){  
            e.printStackTrace();  
        }  
        if (null!=postStr&&!postStr.isEmpty()){  
            Document document=null;  
            try{  
                document = DocumentHelper.parseText(postStr);  
            }catch(Exception e){  
                e.printStackTrace();  
            }  
            if(null==document){  
                print("",request,response);  
                return;  
            }  
            Element root=document.getRootElement();    
            String msg_type=root.elementText("MsgType");
            String custevent=root.elementText("Event");   
            if(msg_type.equals("event")&&custevent.equals("subscribe")){ //关注事件
                print(focusOnReply(root),request,response); 
            }else if(msg_type.equals("event")&&custevent.equals("CLICK")){//菜单单击响应事件
            	print(menuTextReply(root),request,response); 
            }else{  
                print("Input something...",request,response);  
            }  
  
        }else {  
            print("",request,response);  
        }  
    }
	
	
	/**
	 * 向请求端发送返回数据
	 * @author zhangjf
	 * @create_time 2015-8-7 下午5:34:10
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
	 * 从输入流读取post参数
	 * @author zhangjf
	 * @create_time 2015-8-7 下午5:33:15
	 * @param in
	 * @return
	 */
	public String readStreamParameter(ServletInputStream in){  
        StringBuilder buffer = new StringBuilder();  
        BufferedReader reader=null;  
        try{  
            reader = new BufferedReader(new InputStreamReader(in));  
            String line=null;  
            while((line = reader.readLine())!=null){  
                buffer.append(line);  
            }  
        }catch(Exception e){  
            e.printStackTrace();  
        }finally{  
            if(null!=reader){  
                try {  
                    reader.close();  
                } catch (IOException e) {  
                    e.printStackTrace();  
                }  
            }  
        }  
        return buffer.toString();  
    }  
	
	/**
	 * 关注自动回复
	 * @author zhangjf
	 * @create_time 2015-8-7 下午5:37:00
	 * @param root
	 * @return
	 */
	public String focusOnReply(Element root){
	    String textTpl = "<xml>"+  
    "<ToUserName><![CDATA[%1$s]]></ToUserName>"+  
    "<FromUserName><![CDATA[%2$s]]></FromUserName>"+  
    "<CreateTime>%3$s</CreateTime>"+  
    "<MsgType><![CDATA[%4$s]]></MsgType>"+  
    "<Content><![CDATA[%5$s]]></Content>"+  
    "<FuncFlag>0</FuncFlag>"+  
    "</xml>"; 
	    Map<String,Object> maps=new HashMap<String, Object>();
	    maps.put("original_id", root.elementText("ToUserName"));
	    String msgType = "text";
        String contentStr = "欢迎关注我的公众号"; //自动回复内容构建 
        String resultStr = textTpl.format(textTpl, root.elementText("FromUserName"), root.elementText("ToUserName"), new Date().getTime(), msgType, contentStr);  
        return resultStr;
	}
	
	/**
	 * 菜单响应事件,响应文本信息
	 * @author zhangjf
	 * @create_time 2015-8-7 下午5:38:31
	 * @param root
	 * @return
	 */
	public String menuTextReply(Element root){
	    String textTpl = "<xml>"+  
	    "<ToUserName><![CDATA[%1$s]]></ToUserName>"+  
	    "<FromUserName><![CDATA[%2$s]]></FromUserName>"+  
	    "<CreateTime>%3$s</CreateTime>"+  
	    "<MsgType><![CDATA[%4$s]]></MsgType>"+  
	    "<Content><![CDATA[%5$s]]></Content>"+  
	    "<FuncFlag>0</FuncFlag>"+  
	    "</xml>"; 
	    Map<String,Object> maps=new HashMap<String, Object>();
	    maps.put("original_id", root.elementText("ToUserName"));
		    String msgType = "text";
	    String contentStr = "哦也你点击了按钮";  
        String resultStr = textTpl.format(textTpl, root.elementText("FromUserName"), root.elementText("ToUserName"), new Date().getTime(), msgType, contentStr);  
        return resultStr;
	}
	
	/**
	 * 添加绑定数据
	 * @author zhangjf
	 * @create_time 2015-8-8 下午12:11:43
	 * @param parameter
	 */
	public  void  add(Map<String,Object> parameter){
		 this.getBaseDao().insert("weixin.add", parameter);
	}
	
	/**
	 * 更新绑定数据
	 * @author zhangjf
	 * @create_time 2015-8-8 下午12:11:35
	 * @param parameter
	 */
	public void update(Map<String,Object> parameter){
		this.getBaseDao().update("weixin.update", parameter);
	}
	
	/**
	 * 根据身份证查询微信账号信息
	 * @author zhangjf
	 * @create_time 2015-8-8 上午11:45:50
	 * @param parameter
	 * @return
	 */
	public Map<String,Object> load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("weixin.load", parameter);
	}
}
