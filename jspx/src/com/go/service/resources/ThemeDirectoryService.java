package com.go.service.resources;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.TreeUtil;
import com.go.service.base.BaseService;
/**
 * 主题目录
 * @author chenhb
 * @create_time  2015-11-26 下午7:23:28
 */
@Service
public class ThemeDirectoryService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("themeDirectory.findCount", "themeDirectory.findList", parameter);
	}
	public List<Map<String,Object>> findAll(Map<String,Object> parameter){
		return this.getBaseDao().findList("themeDirectory.findAll", parameter);
	}
	public List<Map<String,Object>> findTree(Map<String,Object> parameter){
		List<Map<String,Object>> list= this.getBaseDao().findList("themeDirectory.findAll", parameter);
		list=TreeUtil.createTree(list);
		List<Map<String,Object>> res=new ArrayList<Map<String,Object>>();
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("id",parameter.get("templateId"));
		map=this.getBaseDao().loadEntity("themeTemplate.load", map);
		map.put("children", list);
		map.put("text", map.get("title"));
		res.add(map);
		return res;
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("themeDirectory.load", parameter);
	}
	
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  findthemeDirectory(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("themeDirectory.findthemeDirectory", parameter);
	}
	
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("themeDirectory.add", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("themeDirectory.update", parameter);
	}
	
	/**
	 * 更新数据状态
	 * @param parameter
	 */
	public void changeStatus(Map<String,Object> parameter){
		this.getBaseDao().update("themeDirectory.changeStatus", parameter);
	}
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("themeDirectory.delete", parameter);
	}
}
