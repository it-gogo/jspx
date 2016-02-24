package com.go.service.baseinfo;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.service.base.BaseService;
/**
 * 人工考勤Service
 * @author Administrator
 *
 */
@Service
public class ArtificialAttendanceService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("artificialAttendance.findCount", "artificialAttendance.findList", parameter);
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
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("artificialAttendance.update", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("artificialAttendance.delete", parameter);
	}
}
