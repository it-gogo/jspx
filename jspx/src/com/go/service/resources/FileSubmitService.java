package com.go.service.resources;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.po.common.PageBean;
import com.go.service.base.BaseService;
/**
 * 文件提交service
 * @author chenhb
 * @create_time  2016-3-15 上午11:29:42
 */
@Service
public class FileSubmitService extends BaseService {
	/**
	 * 要上传的列表
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findOperate(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("fileSubmit.findOperateCount", "fileSubmit.findOperateList", parameter);
	}
	
	/**
	 * 要上传的列表
	 * @param parameter
	 * @return
	 */
	public  PageBean<Map<String,Object>>  findPBOperate(Map<String,Object> parameter){
		return this.getBaseDao().findPageBean("fileSubmit.findOperateCount", "fileSubmit.findOperateList", parameter);
	}
	
	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("fileSubmit.findCount", "fileSubmit.findList", parameter);
	}
	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  PageBean<Map<String,Object>>  findPB(Map<String,Object> parameter){
		return this.getBaseDao().findPageBean("fileSubmit.findCount", "fileSubmit.findList", parameter);
	}
	public  List<Map<String,Object>>  findAll(Map<String,Object> parameter){
		return this.getBaseDao().findList("fileSubmit.findAll", parameter);
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("fileSubmit.load", parameter);
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  findOne(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("fileSubmit.findOne", parameter);
	}
	
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
		this.getBaseDao().insert("submitTeacher.batchAdd", parameter);
	    this.getBaseDao().insert("fileSubmit.add", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		List<String> dList=new ArrayList<String>();
		dList.add(parameter.get("id").toString());
		this.getBaseDao().delete("submitTeacher.delete", dList);
		 this.getBaseDao().insert("submitTeacher.batchAdd", parameter);
		this.getBaseDao().update("fileSubmit.update", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("submitTeacher.delete", parameter);
		this.getBaseDao().delete("fileSubmit.delete", parameter);
	}
	/**
	 * 更新数据状态
	 * @param parameter
	 */
	public void changeStatus(Map<String,Object> parameter){
		this.getBaseDao().update("fileSubmit.changeStatus", parameter);
	}
}
