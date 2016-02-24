package com.go.service.baseinfo;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.service.base.BaseService;
/**
 * 学生上传作业逻辑层
 * @author zhangjf
 * @create_time 2015-9-25 上午10:47:50
 */
@Service
public class UploadLogService extends BaseService {

	/**
	 * 通过条件获得一个数据
	 * @author chenhb
	 * @create_time {date} 上午11:55:59
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("uploadLog.load", parameter);
	}
	
	/**
	 * 根据当前用户ID作业ID查询提交信息
	 * @author zhangjf
	 * @create_time 2015-9-25 上午11:07:09
	 * @param params
	 * @return
	 */
	public Map<String,Object> loadByParams(Map<String,Object> params){
		return this.getBaseDao().loadEntity("uploadLog.loadByParams", params);
	}
	
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("uploadLog.add", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("uploadLog.update", parameter);
	}
	
	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("uploadLog.findCount", "uploadLog.findList", parameter);
	}
	
	/**
	 * 学生用户分页查询作业列表
	 * @author zhangjf
	 * @create_time 2015-9-24 下午6:04:49
	 * @param params
	 * @return
	 */
	public JSONObject downloadPageBean(Map<String,Object> params){
		return this.getBaseDao().findListPage("uploadLog.downloadCount", "uploadLog.downloadList", params);
	}
	
	/**
	 * 根据ID集合查询列表数据
	 * @author zhangjf
	 * @create_time 2015-9-24 下午3:36:35
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> findList(Map<String, Object> params){
		return this.getBaseDao().findList("uploadLog.findListById", params);
	}
	
	/**
	 * 根据作业ID加载所有学生提交作业列表
	 * @author zhangjf
	 * @create_time 2015-9-29 上午9:40:03
	 * @return
	 */
	public List<Map<String,Object>> findAll(Map<String,Object> params){
		return this.getBaseDao().findList("uploadLog.findAll", params);
	}
	
	
	/**
	 * 根据ID进行数据删除
	 * @author zhangjf
	 * @create_time 2015-9-24 下午3:47:06
	 * @param ids
	 */
	public void deleteList(List<String> ids){
		 this.getBaseDao().delete("uploadLog.deleteList", ids);
	}
	
	/**
	 * 根据ID进行数据删除
	 * @author zhangjf
	 * @create_time 2015-9-25 上午11:40:04
	 * @param params
	 */
	public void delete(Map<String,Object> params){
		 this.getBaseDao().delete("uploadLog.delete", params);
	}
	
	
}
