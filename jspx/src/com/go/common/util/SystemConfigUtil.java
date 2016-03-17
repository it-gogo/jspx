package com.go.common.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 读取base配置文件信息
 * @author zhangjf
 * @create_time 2015-8-19 下午3:25:46
 */
public class SystemConfigUtil {

	private final static String CONFIG_FILE = "/base.properties";
	private static Properties config=new Properties();
	
	/**
	 * 通过接口实例化对象
	 * @author zhangjf
	 * @create_time 2015-8-19 下午3:29:33
	 */
	interface Holder{
		SystemConfigUtil INSTANSE=new SystemConfigUtil();
	}
	/**
	 * 通过参数获取base.properties 的值
	 * @author chenhb
	 * @create_time  2015-10-21 下午8:17:17
	 * @param parameter
	 * @return
	 */
	public static String getParameter(String parameter){
		return config.getProperty(parameter);
	}
	/**
	 * 开放初始化入口
	 * @author zhangjf
	 * @create_time 2015-8-19 下午3:30:18
	 * @return
	 */
	public static SystemConfigUtil getInstance(){
		return Holder.INSTANSE;
	}
	
	/**
	 * 私有化构造函数
	 * @author zhangjf
	 * @create_time 2015-8-19 下午3:27:16
	 */
	private SystemConfigUtil(){
		try {
			InputStream inputStream =SystemConfigUtil.class.getResourceAsStream(CONFIG_FILE);
			config.load(inputStream);
		} catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException("加载配置文件异常！");
		}
	}
	
	/**
	 * 获取系统网络路径
	 * @author zhangjf
	 * @create_time 2015-8-19 下午3:31:06
	 * @return
	 */
	public  String getServerPath(){
		return config.getProperty("sys_path");
	}

	/**
	 * 根据key获取value值
	 * @author zhangjf
	 * @create_time 2016-3-10 下午3:11:31
	 * @param key
	 * @return
	 */
	public String getValByKey(String key){
		return config.getProperty(key);
	}
	
	/**
	 * 获取图片上传类型
	 * @author zhangjf
	 * @create_time 2015-8-19 下午3:31:50
	 * @return
	 */
	public  String getAllowType(){
		return config.getProperty("allow_type");
	}
	public static void main(String[] args) {
		System.out.println(new SystemConfigUtil().getAllowType());
	}
}
