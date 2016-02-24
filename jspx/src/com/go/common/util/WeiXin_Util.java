package com.go.common.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;

import com.go.po.common.MyX509TrustManager;

import net.sf.json.JSONObject;

/**
 * 微信相关的工具类
 * @author zhangjf
 * @create_time 2015-8-8 上午9:36:15
 */
public class WeiXin_Util {
		//创建自定义菜单
		private static final String MENU_CREATE_URL="https://api.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN";
		//根据APPID和秘钥获取当前token
		private static final String GET_TOKEN_URL="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";
		
		private static final String GET_CODE_URL="https://open.weixin.qq.com/connect/oauth2/authorize?appid=APPID&redirect_uri=REDIRECT_URI&response_type=code&scope=SCOPE&state=STATE&connect_redirect=1#wechat_redirect";
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
}
