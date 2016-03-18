package com.go.service.resources;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.go.service.base.BaseService;
/**
 * 共享人员
 * @author chenhb
 * @create_time  2015-11-20 下午1:29:32
 */
@Service
public class SharedRoleService extends BaseService {

	
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  List<Map<String,Object>>  findAll(Map<String,Object> parameter){
		return this.getBaseDao().findList("sharedRole.findAll", parameter);
	}
	
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  addAll(Map<String,Object> parameter){
	    this.getBaseDao().insert("sharedRole.addAll", parameter);
	}
	
	
	
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("sharedRole.delete", parameter);
	}
	
	
}
