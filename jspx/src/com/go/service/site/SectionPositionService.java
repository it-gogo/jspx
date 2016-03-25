package com.go.service.site;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import com.alibaba.fastjson.JSONObject;
import com.go.service.base.BaseService;
/**
 * 门户显示栏目位置逻辑层
 * @author zhangjf
 * @create_time 2016-3-25 下午1:59:47
 */
@Service
public class SectionPositionService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("sectionPosition.findCount", "sectionPosition.findList", parameter);
	}
	/**
	 * 按条件查询
	 * @author chenhb
	 * @create_time  2015-10-9 上午9:29:12
	 * @param parameter
	 * @return
	 */
	public  List<Map<String,Object>>  findAll(Map<String,Object> parameter){
		return this.getBaseDao().findList("sectionPosition.findAll", parameter);
	}
	
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("sectionPosition.load", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
		parameter.put("seq",this.getSeq());
	    this.getBaseDao().insert("sectionPosition.add", parameter);
	}
	/**
	 * 获取序列
	 * @return
	 */
	private  Integer  getSeq(){
		Object  maxSeq = this.getBaseDao().findOne("sectionPosition.findMaxSeq");
		Integer seq = 0;
		if(maxSeq!=null){
			seq = Integer.parseInt(maxSeq.toString());
		}
		return  seq+1;
	}
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("sectionPosition.update", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("sectionPosition.delete", parameter);
	}
	
}

