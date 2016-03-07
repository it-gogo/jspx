package com.go.service.supervise;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.TreeUtil;
import com.go.service.base.BaseService;
/**
 * 督学学校Service
 * @author chenhb
 * @create_time  2016-3-3 上午11:11:07
 */
@Service
public class InspectorUnitService extends BaseService {

	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("inspectorUnit.add", parameter);
	}
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("inspectorUnit.delete", parameter);
	}
}
