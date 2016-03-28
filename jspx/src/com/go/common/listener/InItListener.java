package com.go.common.listener;

import java.util.Map;
import javax.servlet.ServletContextEvent;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.ContextLoaderListener;
import com.go.service.platform.WebManagementService;
/**
 * 自定义spring监听器
 * @author zhangjf
 * @create_time 2016-3-25 下午4:20:55
 */
public class InItListener extends ContextLoaderListener {
	private ContextLoader contextLoader;
	
	
	private WebManagementService webManagementService;
	
	
	@Override
	public void contextInitialized(ServletContextEvent event) {
		this.contextLoader = createContextLoader();
		this.contextLoader.initWebApplicationContext(event.getServletContext());
		/**
		 *zhangjf获取网站管理数据
		 */
		this.webManagementService=this.contextLoader.getCurrentWebApplicationContext().getBean(WebManagementService.class);
		Map<String,Object> webManagement=webManagementService.findOne(null);
		if(webManagement!=null){
			event.getServletContext().setAttribute("webManagement", webManagement);
		}
		
		System.out.println("用户中心监听器启动.....");
		
	}
	
	protected ContextLoader createContextLoader() {
		// TODO Auto-generated method stub
		return new ContextLoader();
	}
	
	@Override
	public void contextDestroyed(ServletContextEvent event) {
		System.out.println("用户中心监听器停止.....");
		super.contextDestroyed(event);
	}
}
