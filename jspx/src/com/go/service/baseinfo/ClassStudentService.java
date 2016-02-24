package com.go.service.baseinfo;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.ExtendDate;
import com.go.common.util.SqlUtil;
import com.go.common.util.Util;
import com.go.service.base.BaseService;
/**
 * 班级学员Service
 * @author Administrator
 *
 */
@Service
public class ClassStudentService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("classStudent.findCount", "classStudent.findList", parameter);
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("classStudent.load", parameter);
	}
	public  Map<String,Object>  findOne(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("classStudent.findOne", parameter);
	}
	/**
	 * 获得学校数量
	 * @author chenhb
	 * @create_time {date} 上午10:16:11
	 * @param parameter
	 * @return
	 */
	public List<Map<String,Object>> getSchoolNum(List<String> parameter){
		return this.getBaseDao().findList("teacherInfo.getSchoolNum", parameter);
	}
	
	public List<Map<String,Object>> findNum(Map<String,Object> parameter){
		return this.getBaseDao().findList("classStudent.findNum", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("classStudent.add", parameter);
	}
	/**
	 * 批量添加
	 * @author chenhb
	 * @create_time {date} 下午4:57:13
	 * @param parameter
	 */
	public  void  batchAdd(Map<String,Object> parameter){
	    this.getBaseDao().insert("classStudent.batchAdd", parameter);
	}
	public  void  accepted(Map<String,Object> parameter){
	    this.getBaseDao().insert("classStudent.acceptedAdd", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("classStudent.update", parameter);
	}
	
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("classStudent.delete", parameter);
	}
	/**
	 * 填写分数
	 * @author chenhb
	 * @create_time  2015-9-25 下午3:18:25
	 * @param parameter
	 */
	public  void  scores(Map<String,Object> parameter){
		this.getBaseDao().update("classStudent.scores", parameter);
	}
	
	/**
	 * 根据学生ID查询对应的班级列表
	 * @author zhangjf
	 * @create_time 2015-9-24 下午6:17:40
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> findClasses(Map<String,Object> params){
		return this.getBaseDao().findList("classStudent.findClasses", params);
	}
	
	/**
	 * 导入方式分数
	 * @author chenhb
	 * @create_time {date} 下午4:38:08
	 * @param list
	 * @throws Exception 
	 */
	public String addScores(List<String[]> list) throws Exception{
		StringBuffer sb=new StringBuffer();
		List<Map<String,Object>> res=new ArrayList<Map<String,Object>>();
		String[]  header = new String[]{
				"studentName","studentSex","schoolName","className","scores"
			};
		List<Map<String,Object>> addList=new ArrayList<Map<String,Object>>();
		for(String[] arr:list){
			Map<String,Object> parameter=new HashMap<String, Object>();
			parameter.put(header[0], arr[0]);
			parameter.put(header[2], arr[2]);
			parameter.put(header[3], arr[3]);
			Map<String,Object> classStudent= this.getBaseDao().loadEntity("classStudent.findOne", parameter);
			if(classStudent==null){
				sb.append(arr[0]+"数据中类型不存在，因此未能添加该条数据。");
				break;
			}
			classStudent.put("scores", arr[4]);
			addList.add(classStudent);
		}
		if(addList.size()!=0){
			Map m=new HashMap();
			m.put("list", addList);
			this.getBaseDao().insert("classStudent.batchScores", m);
		}
		return sb.toString();
	}
}
