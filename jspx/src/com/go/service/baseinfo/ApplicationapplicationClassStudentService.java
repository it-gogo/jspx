package com.go.service.baseinfo;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.service.base.BaseService;
/**
 * 申请班级学员Service
 * @author Administrator
 *
 */
@Service
public class ApplicationapplicationClassStudentService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("applicationClassStudent.findCount", "applicationClassStudent.findList", parameter);
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("applicationClassStudent.load", parameter);
	}
	/**
	 * 获得学校数量
	 * @author chenhb
	 * @create_time {date} 上午10:16:11
	 * @param parameter
	 * @return
	 */
	public List<Map<String,Object>> getSchoolNum(List<String> parameter){
		return this.getBaseDao().findList("teacherInfo.getSchoolNum", parameter);
	}
	
	public List<Map<String,Object>> findNum(Map<String,Object> parameter){
		return this.getBaseDao().findList("applicationClassStudent.findNum", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("applicationClassStudent.add", parameter);
	}
	/**
	 * 批量添加
	 * @author chenhb
	 * @create_time {date} 下午4:57:13
	 * @param parameter
	 */
	public  void  batchAdd(Map<String,Object> parameter){
	    this.getBaseDao().insert("applicationClassStudent.batchAdd", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("applicationClassStudent.update", parameter);
	}
	
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("applicationClassStudent.delete", parameter);
	}
}
