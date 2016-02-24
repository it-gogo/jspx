package com.go.common.util;

import java.io.InputStream;
import java.util.Properties;

/**
 * 读取微信配置文件工具类
 * @author zhangjf
 * @create_time 2015-8-7 下午4:56:53
 */
public class WeiXin_ConfigUtil {

	private final static String CONFIG_FILE = "/weixin.properties";
	private static Properties config=new Properties();
	
	/**
	 * 通过结构实例化对象
	 * @author zhangjf
	 * @create_time 2015-8-7 下午4:58:41
	 */
	interface Holder{
		WeiXin_ConfigUtil INSTANCE=new WeiXin_ConfigUtil();
	}
	
	/**
	 * 获取工具类对象
	 * @author zhangjf
	 * @create_time 2015-8-7 下午5:00:23
	 * @return
	 */
	public static WeiXin_ConfigUtil getInstance(){
		return Holder.INSTANCE;
	}
	
	/**
	 * 私有化构造函数
	 * @author zhangjf
	 * @create_time 2015-8-7 下午4:59:21
	 */
	private WeiXin_ConfigUtil(){
		try {
			InputStream inputStream = WeiXin_ConfigUtil.class.getResourceAsStream(CONFIG_FILE);
			config.load(inputStream);
		} catch (Exception e) {
			throw new RuntimeException("failed to load configurations for payment");
		}
	}
	
	/**
	 * 获取微信端绑定APPID
	 * @author zhangjf
	 * @create_time 2015-8-7 下午5:01:33
	 * @return
	 */
	public String getAppId(){
		return config.getProperty("appID");
	}
	
	/**
	 * 获取微信号秘钥
	 * @author zhangjf
	 * @create_time 2015-8-7 下午5:02:08
	 * @return
	 */
	public String getAppsecret(){
		return config.getProperty("appsecret");
	}
	/**
	 * 获取公众号token
	 * @author zhangjf
	 * @create_time 2015-8-7 下午5:02:56
	 * @return
	 */
	public String getToken(){
		return config.getProperty("token");
	}
	/**
	 * 测试
	 * @author zhangjf
	 * @create_time 2015-8-7 下午5:04:41
	 * @param args
	 */
	public static void main(String[] args) {
		WeiXin_ConfigUtil util=WeiXin_ConfigUtil.getInstance();
		System.out.println("appid:"+util.getAppId()+" sercert:"+util.getAppsecret()+" token:"+util.getToken());
	}
}
