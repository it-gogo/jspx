package com.go.service.resources;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.service.base.BaseService;
/**
 * 顶级文件夹
 * @author chenhb
 * @create_time  2015-11-26 下午2:50:15
 */
@Service
public class TopFolderService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("topFolder.findCount", "topFolder.findList", parameter);
	}
	public List<Map<String,Object>> findAll(Map<String,Object> parameter){
		return this.getBaseDao().findList("topFolder.findAll", parameter);
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("topFolder.load", parameter);
	}
	
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  findTopFolder(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("topFolder.findTopFolder", parameter);
	}
	
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("topFolder.add", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("topFolder.update", parameter);
	}
	
	/**
	 * 更新数据状态
	 * @param parameter
	 */
	public void changeStatus(Map<String,Object> parameter){
		this.getBaseDao().update("topFolder.changeStatus", parameter);
	}
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("topFolder.delete", parameter);
	}
}
