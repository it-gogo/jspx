package com.go.controller.weixin;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import com.go.thread.TokenThread;

/**
 * 用于初始化定时获取token
 * @author zhangjf
 * @create_time 2015-10-8 下午3:21:53
 */
public class InitServlet extends HttpServlet {
	 private static final long serialVersionUID = 1L;  
	 	/**
	 	 * 初始化调用线程进行token获取
	 	 */
	    public void init() throws ServletException {
	    	String model=getInitParameter("model");
	         // 启动定时获取access_token的线程
	    	if(!"debug".equals(model)){
	    		 new Thread(new TokenThread()).start();  
	    	}
	        

	    }  
}
