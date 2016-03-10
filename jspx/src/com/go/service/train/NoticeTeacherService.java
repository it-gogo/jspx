package com.go.service.train;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.po.common.PageBean;
import com.go.service.base.BaseService;


/**
 * 站内消息逻辑层
 * @author zhangjf
 * @create_time 2016-3-10 上午10:12:29
 */
@Service
public class NoticeTeacherService extends BaseService {
	
	public List<Map<String, Object>> findAll(Map<String,Object> parameter){
		return this.getBaseDao().findList("noticeTeacher.findAll", parameter);
	}
	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("noticeTeacher.findCount", "noticeTeacher.findList", parameter);
	}
	public  PageBean<Map<String,Object>>  findPB(Map<String,Object> parameter){
		return this.getBaseDao().findPageBean("noticeTeacher.findCount", "noticeTeacher.findList", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("noticeTeacher.add", parameter);
	}
	/**
	 * 更新阅读
	 * @author chenhb
	 * @create_time  2015-10-20 下午4:30:31
	 * @param parameter
	 */
	public void updateRead(Map<String,Object> parameter){
		this.getBaseDao().update("noticeTeacher.updateRead", parameter);
	}
	
	/**
	 * 批量添加数据
	 * @param parameter
	 * @return
	 */
	public  void  batchAdd(Map<String,Object> parameter){
	    this.getBaseDao().insert("noticeTeacher.batchAdd", parameter);
	}
	
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("noticeTeacher.delete", parameter);
	}
	
}
