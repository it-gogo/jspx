package com.go.service.resources;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.service.base.BaseService;
/**
 * 主题模板
 * @author chenhb
 * @create_time  2015-11-26 下午6:56:24
 */
@Service
public class ThemeTemplateService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("themeTemplate.findCount", "themeTemplate.findList", parameter);
	}
	public List<Map<String,Object>> findAll(Map<String,Object> parameter){
		return this.getBaseDao().findList("themeTemplate.findAll", parameter);
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("themeTemplate.load", parameter);
	}
	
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  findthemeTemplate(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("themeTemplate.findthemeTemplate", parameter);
	}
	
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("themeTemplate.add", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("themeTemplate.update", parameter);
	}
	
	/**
	 * 更新数据状态
	 * @param parameter
	 */
	public void changeStatus(Map<String,Object> parameter){
		this.getBaseDao().update("themeTemplate.changeStatus", parameter);
	}
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("themeTemplate.delete", parameter);
	}
}
