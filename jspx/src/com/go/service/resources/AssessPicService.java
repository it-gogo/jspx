package com.go.service.resources;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.TreeUtil;
import com.go.service.base.BaseService;
/**
 * 评估负责人
 * @author chenhb
 * @create_time  2015-11-27 下午1:41:56
 */
@Service
public class AssessPicService extends BaseService {

	public List<Map<String,Object>> findAll(Map<String,Object> parameter){
		return this.getBaseDao().findList("assessPic.findAll", parameter);
	}
	
	public Map<String,Object> findOne(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("assessPic.findOne", parameter);
	}
	
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("assessPic.add", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("assessPic.delete", parameter);
	}
}
