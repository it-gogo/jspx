package com.go.service.site;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.TreeUtil;
import com.go.service.base.BaseService;

/**
 * 访问记录
 * @author zhangjf
 * @create_time 2015-10-19 下午3:53:30
 */
@Service
public class VisitLogService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("visitLog.findCount", "visitLog.findList", parameter);
	}
	/**
	 * 查询树
	 * @author chenhb
	 * @create_time {date} 上午10:56:47
	 * @param parameter
	 * @return
	 */
	public List<Map<String,Object>> findTree(Map<String,Object> parameter){
		List<Map<String,Object>> list=this.getBaseDao().findList("visitLog.findTree", parameter);
		return TreeUtil.createTree(list);
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("visitLog.load", parameter);
	}
	
	/**
	 * 获取网站统计数据
	 * @author zhangjf
	 * @create_time 2015-10-20 下午2:38:43
	 * @param params
	 * @return
	 */
	public Map<String,Object> countMap(Map<String,Object> params){
		return this.getBaseDao().loadEntity("visitLog.countMap", params);
	}
	
	/**
	 * 查询单条数据
	 * @author chenhb
	 * @create_time  2015-8-17 下午6:14:04
	
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  findOne(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("visitLog.findOne", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("visitLog.add", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("visitLog.update", parameter);
	}
	

	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("visitLog.delete", parameter);
	}
}
