package com.go.service.baseinfo;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.go.service.base.BaseService;
/**
 * 课程管理service
 * @author chenhb
 * @create_time  2015-9-24 上午12:19:52
 */
@Service
public class CourseManagementService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("courseManagement.findCount", "courseManagement.findList", parameter);
	}
	/**
	 * 不分页查询
	 * @author chenhb
	 * @create_time {date} 下午1:36:06
	 * @param parameter
	 * @return
	 */
	public List<Map<String,Object>> findAll(Map<String,Object> parameter){
		return this.getBaseDao().findList("courseManagement.findAll", parameter);
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("courseManagement.load", parameter);
	}
	/**
	 * 通过条件获得一个数据
	 * @author chenhb
	 * @create_time {date} 上午11:55:59
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  findOne(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("courseManagement.findOne", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
		if(parameter.containsKey("data")){
			Object data=parameter.get("data");
			JSONObject jsonObj=JSON.parseObject(data.toString());
			JSONArray jsonArr=JSONArray.parseArray(jsonObj.get("rows").toString());
			if(jsonArr!=null && jsonArr.size()>0){
				parameter.put("list", jsonArr);
				this.getBaseDao().insert("lessonManagement.batchAdd", parameter);
			}
		}
	    this.getBaseDao().insert("courseManagement.add", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("courseManagement.update", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("courseManagement.delete", parameter);
	}
}
