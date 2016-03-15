package com.go.service.resources;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.service.base.BaseService;
/**
 * 文件夹共享
 * @author chenhb
 * @create_time  2015-11-20 下午12:20:32
 */
@Service
public class FolderSharedService extends BaseService {

	
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  findOne(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("folderShared.findOne", parameter);
	}
	
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("folderShared.add", parameter);
	}
	
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("folderShared.update", parameter);
	}
	
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(Map<String,Object> parameter){
		this.getBaseDao().delete("folderShared.delete", parameter);
	}
	
	
}
