package com.go.exception;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.dao.DataAccessException;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.ContextUtil;
import com.go.common.util.LogUtil;
import com.go.common.util.SysUtil;
import com.go.po.common.Syscontants;

public class MyException implements HandlerExceptionResolver{

	@Override
	public ModelAndView resolveException(HttpServletRequest arg0,
			HttpServletResponse response, Object arg2, Exception arg3) {
		 Map<String, Object> model = new HashMap<String, Object>();  
	        model.put("msg", arg3);  
	        // 根据不同错误转向不同页面  
	        if(arg3 instanceof DataAccessException) {  
	        	 model.put("msg", "数据库异常");  
	        }else if(arg3 instanceof NullPointerException) {  
	        	model.put("msg", "空指针异常");  
	        }else if(arg3 instanceof KeyException) {  
	        	model.put("msg", "授权异常");  
	        	
	        	String requestType = arg0.getHeader("X-Requested-With"); 
				if(requestType!=null&&requestType.indexOf("XMLHttpRequest")>-1){//异步异常
					PrintWriter out = null;
					try{
						response.setContentType("text/html;charset=UTF-8");
						response.setCharacterEncoding("UTF-8");
				        out = response.getWriter();
				        JSONObject  jsonobj = new JSONObject();
				        jsonobj.put("error", "授权异常");
					    out.print(jsonobj);
					}catch(IOException e){
						e.printStackTrace();
						LogUtil.error(this.getClass(),e, e.fillInStackTrace());
					}finally{
					   if(out!=null){
						  out.flush();
						  out.close();
					   }
					}
					
				}
				
	        } else {  
	        	model.put("msg", "其他异常");  
	        }  
	        LogUtil.error(arg2.getClass(),arg3.getMessage(), arg3);
	        return new ModelAndView("error", model);  
	}

}
