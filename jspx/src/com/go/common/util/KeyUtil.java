package com.go.common.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.go.exception.KeyException;

public class KeyUtil {
	private static Properties config=new Properties();
	static{
		try {
			InputStream inputStream =SystemConfigUtil.class.getResourceAsStream("/key.properties");
			config.load(inputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 获取参数
	 * @author chenhb
	 * @create_time  2015-12-2 上午9:51:20
	 * @param key
	 * @return
	 */
	public static String getParameter(String key){
		return config.getProperty(key);
	}
	/**
	 * 获取有权限的菜单Id
	 * @author chenhb
	 * @create_time  2015-12-2 上午9:58:28
	 * @return
	 * @throws Exception
	 */
	public static JSONArray getPowId() throws Exception{
		try {
			String value=getParameter("key");
			DESPlus des;
			des = new DESPlus();
			String res=des.decrypt(value);
			//默认密钥
			JSONArray obj=JSONUtil.strToArray(res);
			return obj;
		} catch (Exception e) {
			e.printStackTrace();
			throw new KeyException();
		}
	}
}
