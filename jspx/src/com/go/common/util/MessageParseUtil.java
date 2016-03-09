package com.go.common.util;

import java.io.InputStream;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.go.po.model.TextMessage;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.core.util.QuickWriter;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
import com.thoughtworks.xstream.io.xml.PrettyPrintWriter;
import com.thoughtworks.xstream.io.xml.XppDriver;


/**
 * 消息格式转换工具类
 * @author zhangjf
 * @create_time 2015-8-4 下午3:03:23
 */
public class MessageParseUtil {
	/** 
     * 返回消息类型：文本 
     */  
    public static final String RESP_MESSAGE_TYPE_TEXT = "text";  
  
    /** 
     * 返回消息类型：音乐 
     */  
    public static final String RESP_MESSAGE_TYPE_MUSIC = "music";  
  
    /** 
     * 返回消息类型：图文 
     */  
    public static final String RESP_MESSAGE_TYPE_NEWS = "news";  
  
    /** 
     * 请求消息类型：文本 
     */  
    public static final String REQ_MESSAGE_TYPE_TEXT = "text";  
  
    /** 
     * 请求消息类型：图片 
     */  
    public static final String REQ_MESSAGE_TYPE_IMAGE = "image";  
  
    /** 
     * 请求消息类型：链接 
     */  
    public static final String REQ_MESSAGE_TYPE_LINK = "link";  
  
    /** 
     * 请求消息类型：地理位置 
     */  
    public static final String REQ_MESSAGE_TYPE_LOCATION = "location";  
  
    /** 
     * 请求消息类型：音频 
     */  
    public static final String REQ_MESSAGE_TYPE_VOICE = "voice";  
  
    /** 
     * 请求消息类型：推送 
     */  
    public static final String REQ_MESSAGE_TYPE_EVENT = "event";  
  
    /** 
     * 事件类型：subscribe(订阅) 
     */  
    public static final String EVENT_TYPE_SUBSCRIBE = "subscribe";  
  
    /** 
     * 事件类型：unsubscribe(取消订阅) 
     */  
    public static final String EVENT_TYPE_UNSUBSCRIBE = "unsubscribe";  
  
    /** 
     * 事件类型：CLICK(自定义菜单点击事件) 
     */  
    public static final String EVENT_TYPE_CLICK = "CLICK";  
	
	/**
	 * 解析微信发来的请求（XML）
	 * @author zhangjf
	 * @create_time 2015-8-4 下午3:04:50
	 * @param request
	 * @return
	 * @throws Exception 
	 */
	public static Map<String,String> parseXml(HttpServletRequest request) throws Exception{
		//将解析结果放置集合中
		Map<String,String> msg=new HashMap<String, String>();
		//1.从request中获取输入留
		InputStream input=request.getInputStream();
		SAXReader reader=new SAXReader();
		Document document=reader.read(input);
		//2.获取xml根元素
		Element root=document.getRootElement();
		//3.获取根元素的所有子节点
		List<Element> elements=root.elements();
		for (Element element_ : elements) {
			 msg.put(element_.getName(), element_.getText());
		}
		input.close();
		return msg;
	}
	
	/**
	 * 文本消息对象转换成xml 
	 * @author zhangjf
	 * @create_time 2015-8-4 下午3:14:33
	 * @param textMessage
	 * @return
	 */
	public static String textMessageToXml(TextMessage textMessage){
		xstream.alias("xml", textMessage.getClass());
		return xstream.toXML(textMessage);
	}
	
	/**
	 * 音乐消息对象转换成xml
	 * @author zhangjf
	 * @create_time 2015-8-4 下午3:20:40
	 * @param musicMessage
	 * @return
	 */
/*	public static String musicMessageToXml(MusicMessage musicMessage) {  
		xstream.alias("xml", musicMessage.getClass());  
	    return xstream.toXML(musicMessage);  
	} */
	
/*	public static String newsMessageToXml(NewsMessage newsMessage) {  
		xstream.alias("xml", newsMessage.getClass());  
		xstream.alias("item", new Article().getClass());  
	    return xstream.toXML(newsMessage);  
	}  */
	
	/**
	 * 扩展xstream，使其支持CDATA块 
	 */
	private static XStream xstream = new XStream(new XppDriver() {  
	    public HierarchicalStreamWriter createWriter(Writer out) {  
	        return new PrettyPrintWriter(out) {  
	            // 对所有xml节点的转换都增加CDATA标记  
	            boolean cdata = true;  
	            @SuppressWarnings("unchecked")  
	            public void startNode(String name, Class clazz) {  
	                super.startNode(name, clazz);  
	            }  
	  
	            protected void writeText(QuickWriter writer, String text) {  
	                if (cdata) {  
	                    writer.write("<![CDATA[");  
	                    writer.write(text);  
	                    writer.write("]]>");  
	                } else {  
	                    writer.write(text);  
	                }  
	            }  
	        };  
	    }  
	});  
	
	
	
}

