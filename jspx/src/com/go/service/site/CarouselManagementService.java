package com.go.service.site;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.service.base.BaseService;
/**
 * 门户网站轮播管理逻辑层
 * @author zhangjf
 * @create_time 2016-3-25 下午3:03:21
 */
@Service
public class CarouselManagementService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("carouselManagement.findCount", "carouselManagement.findList", parameter);
	}
	public  List<Map<String,Object>>  findAll(Map<String,Object> parameter){
		return this.getBaseDao().findList("carouselManagement.findAll", parameter);
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("carouselManagement.load", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("carouselManagement.add", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("carouselManagement.update", parameter);
	}
	
	
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("carouselManagement.delete", parameter);
	}
	
	
	/**
	 * 更新数据状态
	 * @param parameter
	 */
	public void changeStatus(Map<String,Object> parameter){
		this.getBaseDao().update("carouselManagement.updateStatus", parameter);
	}
}
