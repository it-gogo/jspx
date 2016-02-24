package com.go.service.baseinfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.service.base.BaseService;

/**
 * 老师上传作业逻辑层
 * @author zhangjf
 * @create_time 2015-9-25 上午10:48:12
 */
@Service
public class HomeWorkService extends BaseService {

	/**
	 * 通过条件获得一个数据
	 * @author chenhb
	 * @create_time {date} 上午11:55:59
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("homeWork.load", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("homeWork.add", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("homeWork.update", parameter);
	}
	
	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("homeWork.findCount", "homeWork.findList", parameter);
	}
	
	/**
	 * 学生用户分页查询作业列表
	 * @author zhangjf
	 * @create_time 2015-9-24 下午6:04:49
	 * @param params
	 * @return
	 */
	public JSONObject downloadPageBean(Map<String,Object> params){
		return this.getBaseDao().findListPage("homeWork.downloadCount", "homeWork.downloadList", params);
	}
	
	/**
	 * 根据ID集合查询列表数据
	 * @author zhangjf
	 * @create_time 2015-9-24 下午3:36:35
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> findList(Map<String, Object> params){
		return this.getBaseDao().findList("homeWork.findListById", params);
	}
	
	/**
	 * 根据ID进行数据删除
	 * @author zhangjf
	 * @create_time 2015-9-24 下午3:47:06
	 * @param ids
	 */
	public void delete(List<String> ids){
		 this.getBaseDao().delete("homeWork.delete", ids);
	}
	
	/**
	 * 作业数据统计
	 * @author zhangjf
	 * @create_time 2015-9-29 上午11:19:35
	 * @param params
	 */
	public Map<String,Object> attented(Map<String,Object> params){
		Map<String,Object> rs= this.getBaseDao().loadEntity("homeWork.attented", params);
		return rs;
	}
	
	/**
	 * 审核参考数据汇总及明细
	 * @author zhangjf
	 * @create_time 2015-9-29 上午11:23:16
	 * @param params
	 * @return
	 */
	public Map<String,Object> collect(Map<String,Object> params){
		Map<String,Object> rsMap=new HashMap<String, Object>();
		//第一步：查询个人汇总数据
		rsMap.putAll(attented(params));
		//第二步:获取提交明细
		List<Map<String,Object>> list=this.getBaseDao().findList("uploadLog.loadDetail", params);
		rsMap.put("list", list);
		return rsMap;
	}
	
	
}
