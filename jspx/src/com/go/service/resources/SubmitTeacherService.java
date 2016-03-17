package com.go.service.resources;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.service.base.BaseService;
/**
 * 提交老师Service
 * @author Administrator
 *
 */
@Service
public class SubmitTeacherService extends BaseService {
	
	public List<Map<String, Object>> findAll(Map<String,Object> parameter){
		return this.getBaseDao().findList("submitTeacher.findAll", parameter);
	}
	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("submitTeacher.findCount", "submitTeacher.findList", parameter);
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("submitTeacher.load", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("submitTeacher.add", parameter);
	}
	/**
	 * 更新阅读
	 * @author chenhb
	 * @create_time  2015-10-20 下午4:30:31
	 * @param parameter
	 */
	public void updateSubmit(Map<String,Object> parameter){
		if(parameter.containsKey("fileMap")){
			Map<String,Object> vo=this.getBaseDao().loadEntity("submitTeacher.findOne", parameter);
			List<String> dList=new ArrayList<String>();
			dList.add(vo.get("fileId").toString());
			this.getBaseDao().delete("fileManagement.delete", dList);//删除旧数据
			this.getBaseDao().insert("fileManagement.add", parameter.get("fileMap"));
		}
		this.getBaseDao().update("submitTeacher.updateSubmit", parameter);
	}
	
	/**
	 * 批量添加数据
	 * @param parameter
	 * @return
	 */
	public  void  batchAdd(Map<String,Object> parameter){
	    this.getBaseDao().insert("submitTeacher.batchAdd", parameter);
	}
	
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("submitTeacher.delete", parameter);
	}
	
}
