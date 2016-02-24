package com.go.common.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

public class SqlUtil {

	public static String  uuid(){
		UUID  uuid = UUID.randomUUID();
		String  uuidcode = uuid.toString();
		String res = uuidcode.replaceAll("-", "");
		return res;
	}
	
	
	
	public  static  void main(String[] arg){
		String res = uuid();
		System.out.println(res);
	}
}
