package com.go.service.site;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import com.alibaba.fastjson.JSONObject;
import com.go.service.base.BaseService;
/**
 * 图片链接逻辑层
 * @author zhangjf
 * @create_time 2016-3-25 上午11:52:03
 */
@Service
public class PicLinkService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("picLink.findCount", "picLink.findList", parameter);
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("picLink.load", parameter);
	}
	/**
	 * 查询单条数据
	 * @author chenhb
	 * @create_time  2015-8-17 下午6:14:04
	
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  findOne(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("picLink.findOne", parameter);
	}
	
	/**
	 * 根据条件获取数据
	 * @author zhangjf
	 * @create_time 2015-10-19 下午6:27:51
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> findAll(Map<String,Object> params){
		return this.getBaseDao().findList("picLink.findAll", params);
	}
	
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
		Object type=parameter.get("type");
		if("广告图片".equals(type)){//如果为广告图片则禁用掉其他广告图片
			Map<String,Object> params=new HashMap<String, Object>();
			params.put("type", type);
			this.getBaseDao().update("picLink.cancel", params);
		}
	    this.getBaseDao().insert("picLink.add", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		Object type=parameter.get("type");
		if("广告图片".equals(type)){//如果为广告图片则禁用掉其他广告图片
			Map<String,Object> params=new HashMap<String, Object>();
			params.put("type", type);
			params.put("id", parameter.get("id"));
			this.getBaseDao().update("picLink.cancel", params);
		}
		
		this.getBaseDao().update("picLink.update", parameter);
	}
	
	/**
	 * 更新数据状态
	 * @param parameter
	 */
	public void changeStatus(Map<String,Object> parameter){
		Object obj=parameter.get("status");
		if("启用".equals(obj)){
			  Map<String,Object>  res = this.load(parameter);
			  Object type=res.get("type");
			  if("广告图片".equals(type)){//如果为广告图片则禁用掉其他广告图片
					Map<String,Object> params=new HashMap<String, Object>();
					params.put("type", type);
					params.put("id", parameter.get("id"));
					this.getBaseDao().update("picLink.cancel", params);
				}  			  
		}
		this.getBaseDao().update("picLink.changeStatus", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("picLink.delete", parameter);
	}
}
