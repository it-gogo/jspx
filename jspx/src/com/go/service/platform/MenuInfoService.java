package com.go.service.platform;

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
 * 用户Service
 * @author Administrator
 *
 */
@Service
public class MenuInfoService extends BaseService {

	public List<Map<String,Object>> roleMenu(Map<String,Object> parameter) throws Exception{
//		List<Map<String,Object>> list=this.getBaseDao().findList("menuInfo.roleMenu", parameter);
//		return TreeUtil.createTree(list);
		
		parameter=SqlUtil.setPowId(parameter);//通过key控制权限
		List<Map<String,Object>> list=this.getBaseDao().findList("menuInfo.roleMenu", parameter);
		Map<Object,Object> idMap=new HashMap<Object, Object>();
		for(Map<String,Object> map:list){
			idMap.put(map.get("id"), map);
		}
		Set<Object> parentIdSet = new HashSet<Object>();
		for(Map<String,Object> map:list){
			Object parentId=map.get("pid");
			if(parentId!=null){
				if(idMap.get(parentId)==null){
					parentIdSet.add(parentId);
				}
			}
		}
		if(parentIdSet.size()>0){
			parameter.put("list", parentIdSet);
			List<Map<String,Object>> plist=this.getBaseDao().findList("menuInfo.findByListId", parameter);
			list.addAll(plist);
		}
		list=TreeUtil.createTree(list);
		Util.sortListByseq(list, "seq");
		return list;
	}
	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 * @throws Exception 
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter) throws Exception{
		parameter=SqlUtil.setPowId(parameter);//通过key控制权限
		return this.getBaseDao().findListPage("menuInfo.findCount", "menuInfo.findList", parameter);
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
		parameter=SqlUtil.setPowId(parameter);//通过key控制权限
		List<Map<String,Object>> list=this.getBaseDao().findList("menuInfo.findTree", parameter);
		list=TreeUtil.createTree(list);
		Util.sortListByseq(list, "seq");
		return list;
	}
	/**
	 * 查询权限树
	 * @author chenhb
	 * @create_time {date} 上午10:56:47
	 * @param parameter
	 * @return
	 * @throws Exception 
	 */
	public List<Map<String,Object>> findAuthority(Map<String,Object> parameter) throws Exception{
//		List<Map<String,Object>> list=this.getBaseDao().findList("menuInfo.findAuthority", parameter);
//		return TreeUtil.createTree(list);
		
		parameter=SqlUtil.setPowId(parameter);//通过key控制权限
		List<Map<String,Object>> list=this.getBaseDao().findList("menuInfo.findAuthority", parameter);
		Map<Object,Object> idMap=new HashMap<Object, Object>();
		for(Map<String,Object> map:list){
			idMap.put(map.get("id"), map);
		}
		Set<Object> parentIdSet = new HashSet<Object>();
		for(Map<String,Object> map:list){
			Object parentId=map.get("pid");
			if(parentId!=null){
				if(idMap.get(parentId)==null){
					parentIdSet.add(parentId);
				}
			}
		}
		if(parentIdSet.size()>0){
			parameter.put("list", parentIdSet);
			List<Map<String,Object>> plist=this.getBaseDao().findList("menuInfo.findByListId", parameter);
			list.addAll(plist);
		}
		list= TreeUtil.createTree(list);
		Util.sortListByseq(list, "seq");
		return list;
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("menuInfo.load", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
		Map<String,Object>  n_parameter = this.setInsertParameter(parameter);
	    this.getBaseDao().insert("menuInfo.add", n_parameter);
	}
	/**
	 * 设置插入的参数
	 * @param parameter
	 * @return
	 */
	public Map<String,Object>  setInsertParameter(Map<String,Object>  parameter){
		Map<String,Object>  res = new HashMap<String,Object>(parameter);
		Object  pcode = parameter.get("pcode");
		Object  seq=res.get("seq");
		if(seq==null || "".equals(seq)){
			res.put("seq",this.getSeq());
		}
		String   code = this.getMcode(pcode);
		res.put("code", code);
		res.put("series", code.length()/3);
		return  res;
	}
	/**
	 * 获取序列
	 * @return
	 */
	private  Integer  getSeq(){
		Object  maxSeq = this.getBaseDao().findOne("menuInfo.findMaxSeq");
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
	private  String getMcode(Object  pcode){
		String parameter = "";
		Map<String,String> parameMap = new HashMap<String,String>();
		if(pcode!=null&&!"".equals(pcode.toString().trim())){
			parameter +=" and pcode = #{pcode}";
		}else{
			parameter +=" and pcode is null";
		}
		parameMap.put("parameter", parameter);
		if(pcode!=null){
		  parameMap.put("pcode", pcode.toString());
		}else{
			parameMap.put("pcode", "1");
		}
		
		Object maxCode = this.getBaseDao().findOne("menuInfo.findCode", parameMap);
		String code = "100";
		if(maxCode!=null&&!"".equals(maxCode.toString().trim())){
			code = String.valueOf((Long.parseLong(maxCode.toString())+1));
		}else{
			if(pcode==null){
				pcode="";
			}
			code = pcode+code;
		}
		return code;
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("menuInfo.update", parameter);
	}
	
	/**
	 * 更新数据状态
	 * @param parameter
	 */
	public void updatestat(Map<String,Object> parameter){
		this.getBaseDao().update("menuInfo.changeStat", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("menuInfo.delete", parameter);
	}
}
