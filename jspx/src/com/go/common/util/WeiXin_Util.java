package com.go.common.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONException;
import com.go.po.common.MyX509TrustManager;
import com.go.po.model.Menu;
import com.go.po.model.RT_Weixin_MenuButton;
import com.go.po.model.WeiXinToken;
import com.go.po.model.WxTemplate;

import net.sf.json.JSONObject;

/**
 * 微信相关的工具类
 * @author zhangjf
 * @create_time 2015-8-8 上午9:36:15
 */
public class WeiXin_Util {
	private static Logger log = LoggerFactory.getLogger(WeiXin_Util.class);
	//创建自定义菜单
		private static final String MENU_CREATE_URL="https://api.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN";
		//根据APPID和秘钥获取当前token
		private static final String GET_TOKEN_URL="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";
		
		private static final String GET_CODE_URL="https://open.weixin.qq.com/connect/oauth2/authorize?appid=APPID&redirect_uri=REDIRECT_URI&response_type=code&scope=SCOPE&state=STATE&connect_redirect=1#wechat_redirect";
	
		//根据模板发送通知URL
		private static final String SEND_MSG_URL="https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=ACCESS_TOKEN";
		/**无差别群发URL**/
		private static final String SEND_ALL_URL="https://api.weixin.qq.com/cgi-bin/message/mass/sendall?access_token=ACCESS_TOKEN";
		/**获取模板ID**/
		public static final String GET_TEMPID_URL="https://api.weixin.qq.com/cgi-bin/template/api_add_template?access_token=ACCESS_TOKEN";
		
		/**
		 * 发起https请求并获取结果
		 * @author zhangjf
		 * @create_time 2015-8-5 上午10:08:44
		 * @param requestUrl
		 * @param requestMethod
		 * @param outputStr
		 * @return
		 */
		public static JSONObject httpRequest(String requestUrl, String requestMethod, String outputStr) {
			JSONObject rsObject=null;
			StringBuffer sb=new StringBuffer();
			try {
			TrustManager[] tm = { new MyX509TrustManager() };
			SSLContext sslContext = SSLContext.getInstance("TLSv1");
			sslContext.init(null, tm, new java.security.SecureRandom());
			// 从上述SSLContext对象中得到SSLSocketFactory对象
			SSLSocketFactory ssf = sslContext.getSocketFactory();
			URL url = new URL(requestUrl);
			HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();
			httpUrlConn.setSSLSocketFactory(ssf);

			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod(requestMethod);

			if ("GET".equalsIgnoreCase(requestMethod)){
				httpUrlConn.connect();
			}
			// 当有数据需要提交时
			if (null != outputStr) {
				OutputStream outputStream = httpUrlConn.getOutputStream();
				// 注意编码格式，防止中文乱码
				outputStream.write(outputStr.getBytes("utf-8"));
				outputStream.close();
			}

			// 将返回的输入流转换成字符串
			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				sb.append(str);
				System.out.println();
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			rsObject = JSONObject.fromObject(sb.toString());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return rsObject;
		}
		
		public static int createMenu(RT_Weixin_MenuButton menu,Menu menus,String accessToken){
			int relust=0;
			String menuUrl=MENU_CREATE_URL.replace("ACCESS_TOKEN", accessToken);  //拼接创建菜单的url
			String jsonMenu="";
			if(menu!=null){
				jsonMenu=JSONObject.fromObject(menu).toString();  //将菜单转换成json
			}else{
				jsonMenu=JSONObject.fromObject(menus).toString();  //将菜单转换成json
			}
			 System.out.println(jsonMenu);
			JSONObject jsonObject=httpRequest(menuUrl, "POST", jsonMenu);  //调用接口创建菜单
			
			if(jsonObject!=null){
				if(jsonObject.getInt("errcode")!=0){
					relust=jsonObject.getInt("errcode");
				}
			}
			System.out.println("返回的状态："+relust);
			return relust;
		}
		/**
		 * 获取token
		 * @author zhangjf
		 * @create_time 2015-8-5 下午2:20:52
		 * @return
		 */
		public static String getToken(){
			String token="";
			String appId=WeiXin_ConfigUtil.getInstance().getAppId();
			String appsecret=WeiXin_ConfigUtil.getInstance().getAppsecret();
			String tokenUrl=GET_TOKEN_URL.replace("APPID", appId).replace("APPSECRET", appsecret);
			JSONObject json=httpRequest(tokenUrl, "POST", null);
			if(json!=null&&!json.isEmpty()){
				token=json.getString("access_token");
			}
			return token;
		}
		
		/**
		 * 获取请求接口动态token
		 * @author zhangjf
		 * @create_time 2015-10-8 下午3:31:21
		 * @return
		 */
		public static WeiXinToken getAccessToken(){
			WeiXinToken accessToken = null;
			String appId=WeiXin_ConfigUtil.getInstance().getAppId();
			String appsecret=WeiXin_ConfigUtil.getInstance().getAppsecret();
			String tokenUrl=GET_TOKEN_URL.replace("APPID", appId).replace("APPSECRET", appsecret);
			JSONObject json=httpRequest(tokenUrl, "POST", null);
			// 如果请求成功
			if (null != json) {
				try {
					accessToken = new WeiXinToken();
					accessToken.setToken(json.getString("access_token"));
					accessToken.setExpiresIn(json.getInt("expires_in"));
				} catch (JSONException e) {
					accessToken = null;
					// 获取token失败
					log.error("获取token失败 errcode:{} errmsg:{}", json.getInt("errcode"), json.getString("errmsg"));
				}
			}
			return accessToken;
		}
		
		
		
		/**
		 * emoj表情转换
		 * @author zhangjf
		 * @create_time 2015-8-5 上午11:27:59
		 * @param hexEmoji
		 * @return
		 */
		 public static String emoji(int hexEmoji) {  
		        return String.valueOf(Character.toChars(hexEmoji));  
		    } 
		 
			/**
			 * 根据推送的模板进行微信服务端消息推送
			 * @author zhangjf
			 * @create_time 2015-8-11 下午5:34:20
			 * @param template
			 */
			public static void sendNotify(WxTemplate template,String token){
				if(StringUtils.isBlank(token)){
					LogUtil.error(WeiXin_Util.class, "未启动获取token定时任务！");
				}
				 String send_url=SEND_MSG_URL.replace("ACCESS_TOKEN", token);//获取token方法临时,后期将token保存到数据库防止超出频率限制
				 JSONObject json=httpRequest(send_url, "POST", JSONObject.fromObject(template).toString());
				 LogUtil.error(WeiXin_Util.class, "返回消息:"+json.getString("errmsg"));
			}
			
			/**
			 * 获取模板ID
			 * @author zhangjf
			 * @create_time 2015-12-8 上午8:55:51
			 * @param code
			 * @param token
			 */
			public static String getTempId(String code,String token){
				 String getTempIdUrl=GET_TEMPID_URL.replace("ACCESS_TOKEN", token);
				 Map<String,Object> params=new HashMap<String, Object>();
				 params.put("template_id_short", code);
				 JSONObject json=httpRequest(getTempIdUrl, "POST", JSONObject.fromObject(params).toString());
				if(json!=null&&!json.isEmpty()&&"0".equals(json.getString("errcode"))){
					return json.getString("template_id");
				}else{
					return "";
				}
			}
		 
		 
		 
		 /**
			 * 根据文本内容进行群发 通知
			 * @author zhangjf
			 * @create_time 2015-8-12 上午11:48:15
			 * @param content 群发内容
			 */
			public static void sendAll(String content,String token)
			{
				Map<String,Object> sendMap=new HashMap<String, Object>();
				 Map<String,Object> childMap=new HashMap<String, Object>();
				 childMap.put("is_to_all", true);
				 sendMap.put("filter", childMap);
				 childMap=new HashMap<String, Object>();
				 childMap.put("content", content);
				 sendMap.put("text", childMap);
				 sendMap.put("msgtype", "text");
				 String send_url=SEND_ALL_URL.replace("ACCESS_TOKEN", token);
				 String jsonStr=JSONObject.fromObject(sendMap).toString();
				 System.out.println(jsonStr);
				 JSONObject json=httpRequest(send_url, "POST", jsonStr);
				 System.out.println("群发结果:"+json.getString("errmsg"));
			}
			 
		public static void main(String[] args) {
			getTempId("TM00188", "SyPbJ-Gvck2SG7867uAaTIHPsOGIyhACz2nXd4w7coi1qdTF780_5TU-0FRwBanBp_zRR4f9UCknd3lCV66NODgrpHLU0j5FXzNAnNA260wEBPgAFAOLZ");
		} 
}
