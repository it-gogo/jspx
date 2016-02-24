package com.go.service.baseinfo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.service.base.BaseService;
/**
 * 班级信息Service
 * @author Administrator
 *
 */
@Service
public class ClassInfoService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("classInfo.findCount", "classInfo.findList", parameter);
	}
	/**
	 * 不分页查询
	 * @author chenhb
	 * @create_time {date} 下午1:36:06
	 * @param parameter
	 * @return
	 */
	public List<Map<String,Object>> findAll(Map<String,Object> parameter){
		return this.getBaseDao().findList("classInfo.findAll", parameter);
	}
	
	/**
	 * 根据身份证号查询是否为班主任
	 * @author zhangjf
	 * @create_time 2015-9-30 下午3:16:16
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> isMaster(Map<String,Object> params){
		return this.getBaseDao().findList("classInfo.isMaster", params);
	}
	
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("classInfo.load", parameter);
	}
	/**
	 * 通过条件获得一个数据
	 * @author chenhb
	 * @create_time {date} 上午11:55:59
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  findOne(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("classInfo.findOne", parameter);
	}
	
	/**
	 * 查询班主任管理的班级ID
	 * @author zhangjf
	 * @create_time 2015-9-28 下午4:10:27
	 * @param params
	 * @return
	 */
	public Map<String,Object> managerClasses(Map<String,Object> params){
		return this.getBaseDao().loadEntity("classInfo.managerClasses", params);
	}
	
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
		if(parameter.containsKey("xdList")){
			this.getBaseDao().insert("classXd.add", parameter);
		}
		if(parameter.containsKey("xkList")){
			this.getBaseDao().insert("classXk.add", parameter);
		}
	    this.getBaseDao().insert("classInfo.add", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		List<String> list=new ArrayList<String>();
		list.add(parameter.get("id").toString());
		this.getBaseDao().insert("classXd.delete", list);
		this.getBaseDao().insert("classXk.delete", list);
		
		if(parameter.containsKey("xdList")){
			this.getBaseDao().insert("classXd.add", parameter);
		}
		if(parameter.containsKey("xkList")){
			this.getBaseDao().insert("classXk.add", parameter);
		}
		this.getBaseDao().update("classInfo.update", parameter);
	}
	
	/**
	 * 更新数据状态
	 * @param parameter
	 */
	public void updatestat(Map<String,Object> parameter){
		this.getBaseDao().update("classInfo.changeStat", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("classInfo.delete", parameter);
	}
}
