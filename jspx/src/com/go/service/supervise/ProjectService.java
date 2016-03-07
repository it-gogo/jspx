package com.go.service.supervise;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.SqlUtil;
import com.go.common.util.TreeUtil;
import com.go.common.util.Util;
import com.go.service.base.BaseService;
/**
 * 项目管理Service
 * @author chenhb
 * @create_time  2016-3-4 下午5:09:03
 */
@Service
public class ProjectService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 * @throws Exception 
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter) throws Exception{
		return this.getBaseDao().findListPage("project.findCount", "project.findList", parameter);
	}
	/**
	 * 查询菜单树
	 * @author chenhb
	 * @create_time {date} 上午10:56:47
	 * @param parameter
	 * @return
	 * @throws Exception 
	 */
	public List<Map<String,Object>> findTree(Map<String,Object> parameter) throws Exception{
		List<Map<String,Object>> list=this.getBaseDao().findList("project.findTree", parameter);
		return TreeUtil.createTree(list);
	}
	/**
	 * 查询未绑定记录
	 * @author chenhb
	 * @create_time  2016-3-7 下午5:09:26
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> findUnbinding(Map<String,Object> parameter) throws Exception{
		List<Map<String,Object>> list=this.getBaseDao().findList("project.findUnbinding", parameter);
		return list;
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("project.load", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
		Map<String,Object> pvo=new HashMap<String, Object>();
		pvo.put("id", parameter.get("pid"));
		pvo=this.load(pvo); 
		if(pvo!=null){
			parameter.put("parentCode", pvo.get("code"));
		}else{
			parameter.put("parentCode", null);
		}
		Map<String,Object>  n_parameter = this.setInsertParameter(parameter);
	    this.getBaseDao().insert("project.add", n_parameter);
	}
	/**
	 * 设置插入的参数
	 * @param parameter
	 * @return
	 */
	public Map<String,Object>  setInsertParameter(Map<String,Object>  parameter){
		Map<String,Object>  res = new HashMap<String,Object>(parameter);
		Object  parentCode = parameter.get("parentCode");
		Object  seq=res.get("seq");
		if(seq==null || "".equals(seq)){
			res.put("seq",this.getSeq());
		}
		String   code = this.getMcode(parentCode);
		res.put("code", code);
		return  res;
	}
	/**
	 * 获取序列
	 * @return
	 */
	private  Integer  getSeq(){
		Object  maxSeq = this.getBaseDao().findOne("project.findMaxSeq");
		Integer seq = 0;
		if(maxSeq!=null){
			seq = (Integer)maxSeq;
		}
		return  seq+1;
	}
	/**
	 * 获取菜单规则代码
	 * @return
	 */
	private  String getMcode(Object  parentCode){
		String parameter = "";
		Map<String,String> parameMap = new HashMap<String,String>();
		if(parentCode!=null&&!"".equals(parentCode.toString().trim())){
			parameter +=" and parentCode = #{parentCode}";
		}else{
			parameter +=" and parentCode is null";
		}
		parameMap.put("parameter", parameter);
		if(parentCode!=null){
		  parameMap.put("parentCode", parentCode.toString());
		}else{
			parameMap.put("parentCode", "1");
		}
		
		Object maxCode = this.getBaseDao().findOne("project.findCode", parameMap);
		String code = "100";
		if(maxCode!=null&&!"".equals(maxCode.toString().trim())){
			code = String.valueOf((Long.parseLong(maxCode.toString())+1));
		}else{
			if(parentCode==null){
				parentCode="";
			}
			code = parentCode+code;
		}
		return code;
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		Map<String,Object> vo=this.load(parameter);
		Object pid_old=vo.get("pid");
		Map<String,Object> pvo=new HashMap<String, Object>();
		pvo.put("id", parameter.get("pid"));
		pvo=this.load(pvo); 
		Object pid_new=null;
		if(pvo!=null){
			pid_new=pvo.get("id");
			if(!pid_new.equals(pid_old)){
				//code改变操作
				Object parentCode=pvo.get("code");
				String   code = this.getMcode(parentCode);
				parameter.put("code", code);
				parameter.put("parentCode", parentCode);
				
				Map<String,Object> updateFlag=new HashMap<String, Object>();
				updateFlag.put("code",vo.get("code"));
				updateFlag.put("code_new",code);
				this.getBaseDao().update("project.updateCode", updateFlag);
			}
		}else{
			if(pid_old!=null){
				//flag改变操作
				String   code = this.getMcode(null);
				parameter.put("code", code);
				parameter.put("parentCode", null);
				
				Map<String,Object> updateFlag=new HashMap<String, Object>();
				updateFlag.put("code",vo.get("code"));
				updateFlag.put("code_new",code);
				this.getBaseDao().update("project.updateCode", updateFlag);
			}
		}
		
		this.getBaseDao().update("project.update", parameter);
	}
	
	/**
	 * 更新数据状态
	 * @param parameter
	 */
	public void updatestat(Map<String,Object> parameter){
		this.getBaseDao().update("project.changeStat", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("project.delete", parameter);
	}
}
