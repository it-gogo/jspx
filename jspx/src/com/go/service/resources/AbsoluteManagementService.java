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
 * 绝对路径管理 service
 * @author chenhb
 * @create_time  2015-11-18 上午10:16:19
 */
@Service
public class AbsoluteManagementService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("absoluteManagement.findCount", "absoluteManagement.findList", parameter);
	}
	/**
	 * 查询顶级文件树
	 * @author chenhb
	 * @create_time  2015-11-18 上午10:37:46
	 * @param parameter
	 * @return
	 */
	public List<Map<String,Object>> topFileTree(Map<String,Object> parameter){
		List<Map<String,Object>> res=new ArrayList<Map<String,Object>>();
		parameter.put("type", "资源文件夹");
		List<Map<String,Object>>  list=this.getBaseDao().findList("topFolder.findAll",parameter);
		 Map<String,Object> map=new HashMap<String, Object>();
		 map.put("text", "资源文件夹");
		 map.put("children", list);
		 res.add(map);
		return res;
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("absoluteManagement.load", parameter);
	}
	public  Map<String,Object>  findOne(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("absoluteManagement.findOne", parameter);
	}
	
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
		this.getBaseDao().update("absoluteManagement.disabled", parameter);
	    this.getBaseDao().insert("absoluteManagement.add", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("absoluteManagement.update", parameter);
	}
	
	/**
	 * 更新数据状态
	 * @param parameter
	 */
	public void changeStatus(Map<String,Object> parameter){
		this.getBaseDao().update("absoluteManagement.changeStatus", parameter);
	}
	/**
	 * 禁用所有
	 * @author chenhb
	 * @create_time  2015-11-18 上午10:58:38
	 * @param parameter
	 */
	public void disabled(Map<String,Object> parameter){
		this.getBaseDao().update("absoluteManagement.disabled", parameter);
	}
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("absoluteManagement.delete", parameter);
	}
}
