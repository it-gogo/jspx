package com.go.service.train;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.po.common.PageBean;
import com.go.service.base.BaseService;


/**
 * 站内消息逻辑层
 * @author zhangjf
 * @create_time 2016-3-10 上午10:12:14
 */
@Service
public class NoticeManagementService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("noticeManagement.findCount", "noticeManagement.findList", parameter);
	}
	
	public  PageBean<Map<String,Object>>  pageBean(Map<String,Object> parameter){
		return this.getBaseDao().findPageBean("noticeManagement.findCount", "noticeManagement.findList", parameter);
	}
	
	public  List<Map<String,Object>>  findAll(Map<String,Object> parameter){
		return this.getBaseDao().findList("noticeManagement.findAll", parameter);
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("noticeManagement.load", parameter);
	}
	public  Map<String,Object>  findNewOne(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("noticeManagement.findNewOne", parameter);
	}
	
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("noticeManagement.add", parameter);
	    this.getBaseDao().insert("noticeTeacher.batchAdd", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		List<String> delList=new ArrayList<String>();
		 delList.add(parameter.get("id").toString());
		 this.getBaseDao().delete("noticeTeacher.delete", delList);
		this.getBaseDao().update("noticeManagement.update", parameter);
		this.getBaseDao().insert("noticeTeacher.batchAdd", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("noticeTeacher.delete", parameter);
		this.getBaseDao().delete("noticeManagement.delete", parameter);
	}
	
}
