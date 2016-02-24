package com.go.service.baseinfo;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.po.common.PageBean;
import com.go.service.base.BaseService;
/**
 * 使用课时service
 * @author chenhb
 * @create_time  2015-9-24 上午12:19:52
 */
@Service
public class UseLessonService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("useLesson.findCount", "useLesson.findList", parameter);
	}
	/**
	 * 选择课时列表
	 * @author chenhb
	 * @create_time  2015-9-24 上午11:14:10
	 * @param parameter
	 * @return
	 */
	public  JSONObject  selectLesson(Map<String,Object> parameter){
		JSONObject  jsonobj = new JSONObject();
		//查找记录数量
		List<Map<String,Object>>  rows = this.getBaseDao().findList("useLesson.selectLesson", parameter);
		jsonobj.put("rows", rows);
		return  jsonobj;
	}
	/**
	 * 不分页查询
	 * @author chenhb
	 * @create_time {date} 下午1:36:06
	 * @param parameter
	 * @return
	 */
	public List<Map<String,Object>> findAll(Map<String,Object> parameter){
		return this.getBaseDao().findList("useLesson.findAll", parameter);
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("useLesson.load", parameter);
	}
	/**
	 * 通过条件获得一个数据
	 * @author chenhb
	 * @create_time {date} 上午11:55:59
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  findOne(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("useLesson.findOne", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("useLesson.add", parameter);
	}
	/**
	 * 批量添加
	 * @author chenhb
	 * @create_time  2015-9-24 下午2:22:09
	 * @param parameter
	 */
	public  void  batchAdd(Map<String,Object> parameter){
	    this.getBaseDao().insert("useLesson.batchAdd", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("useLesson.update", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("useLesson.delete", parameter);
	}
	/**
	 * 通过条件删除
	 * @author chenhb
	 * @create_time  2015-9-24 下午2:21:49
	 * @param parameter
	 */
	public  void  deleteByMap(Map<String,Object> parameter){
		this.getBaseDao().delete("useLesson.deleteByMap", parameter);
	}
}
