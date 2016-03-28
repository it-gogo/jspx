package com.go.service.platform;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.go.service.base.BaseService;
/**
 * 网站管理逻辑层
 * @author zhangjf
 * @create_time 2016-3-25 下午4:01:08
 */
@Service
public class WebManagementService extends BaseService {

	/**
	 * 查询单个数据
	 * @author zhangjf
	 * @create_time 2016-3-25 下午4:01:20
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  findOne(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("webManagement.findOne", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("webManagement.add", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("webManagement.update", parameter);
	}
	
}
