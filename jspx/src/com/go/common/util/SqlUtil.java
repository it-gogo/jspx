package com.go.common.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONArray;

public class SqlUtil {

	public static String  uuid(){
		UUID  uuid = UUID.randomUUID();
		String  uuidcode = uuid.toString();
		String res = uuidcode.replaceAll("-", "");
		return res;
	}
	
	
	
	/**
	 * 获取菜单Ids
	 * @author chenhb
	 * @create_time  2016-3-3 下午2:04:51
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public  static Map<String,Object>  setPowId(Map<String,Object> parameter) throws Exception{
		JSONArray obj=KeyUtil.getPowId();
		parameter.put("menuIds", obj);
		return parameter;
	}
}
