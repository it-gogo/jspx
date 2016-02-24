package com.go.service.baseinfo;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.po.common.PageBean;
import com.go.service.base.BaseService;
/**
 *学生申请Service
 * @author Administrator
 *
 */
@Service
public class ApplicationService extends BaseService {
	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  lookStudent(Map<String,Object> parameter){
		JSONObject  jsonobj = new JSONObject();
		//查找记录数量
		List<Map<String,Object>>  rows =this.getBaseDao().findList("applicationClassStudent.findAll", parameter);
		jsonobj.put("rows", rows);
		return  jsonobj;
	}
	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("classInfo.applicationCount", "classInfo.applicationList", parameter);
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("artificialAttendance.load", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("artificialAttendance.add", parameter);
	}
	/**
	 * 添加多条数据
	 * @author chenhb
	 * @create_time {date} 下午4:28:55
	 * @param parameter
	 */
	public  void  addAll(Map<String,Object> parameter){
	    this.getBaseDao().insert("artificialAttendance.addAll", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("applicationClassStudent.delete", parameter);
	}
	
	/**
	 * 批量通过方法
	 * @author zhangjf
	 * @create_time 2015-8-31 下午5:59:47
	 * @param params
	 */
	public void accepteList(Map<String,Object> params){
		this.getBaseDao().update("applicationClassStudent.accepteList", params);
	}
}
