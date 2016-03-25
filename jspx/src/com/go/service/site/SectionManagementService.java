package com.go.service.site;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.TreeUtil;
import com.go.common.util.Util;
import com.go.service.base.BaseService;

/**
 * 文章栏目管理逻辑层
 * @author zhangjf
 * @create_time 2016-3-24 下午5:50:06
 */
@Service
public class SectionManagementService extends BaseService {

	/**
	 * 查询权限
	 * @author chenhb
	 * @create_time  2015-8-18 上午8:48:30
	
	 * @param parameter
	 * @return
	 */
	public List<Map<String,Object>> roleSection(Map<String,Object> parameter){
		List<Map<String,Object>> list=this.getBaseDao().findList("sectionManagement.roleSection", parameter);
		
		Map<Object,Object> idMap=new HashMap<Object, Object>();
		for(Map<String,Object> map:list){
			idMap.put(map.get("id"), map);
		}
		Set<Object> parentIdSet = new HashSet<Object>();
		for(Map<String,Object> map:list){
			Object parentId=map.get("parentId");
			if(parentId!=null){
				if(idMap.get(parentId)==null){
					parentIdSet.add(parentId);
				}
			}
		}
		if(parentIdSet.size()>0){
			parameter.put("list", parentIdSet);
			List<Map<String,Object>> plist=this.getBaseDao().findList("sectionManagement.findByListId", parameter);
			list.addAll(plist);
		}
		List<Map<String,Object>> resList=new ArrayList<Map<String,Object>>();
		Map<String,List<Map<String, Object>>> resMap=new HashMap<String, List<Map<String, Object>>>();
		list=TreeUtil.createTree(list);
		for(Map<String,Object> map:list){
			Object type=map.get("type");
			List<Map<String,Object>> children= resMap.get(type);
			if(children==null){
				children=new ArrayList<Map<String,Object>>();
				resMap.put(type+"", children);
			}
			children.add(map);
		}
		if(resMap.size()>0){
			Iterator<String> it=resMap.keySet().iterator();
			while(it.hasNext()){
				String key=it.next();
				Map<String,Object> m=new HashMap<String, Object>();
				m.put("text", key);
				m.put("children", resMap.get(key));
				resList.add(m);
			}
		}
		return resList;
	}
	
	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("sectionManagement.findCount", "sectionManagement.findList", parameter);
	}
	/**
	 * 按条件查询
	 * @author chenhb
	 * @create_time  2015-10-9 上午9:29:12
	 * @param parameter
	 * @return
	 */
	public  List<Map<String,Object>>  findAll(Map<String,Object> parameter){
		return this.getBaseDao().findList("sectionManagement.findAll", parameter);
	}
	/**
	 * 栏目树
	 * @author chenhb
	 * @create_time  2015-10-9 上午9:42:15
	 * @param parameter
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public  List<Map<String,Object>>  tree(Map<String,Object> parameter){
		List<Map<String,Object>> list=this.getBaseDao().findList("sectionManagement.findAll", parameter);
		list=TreeUtil.createTree_(list);
	    /*Collections.sort(list, new Comparator<Object>() {
	     @Override
	      public int compare(Object o1, Object o2) {
	    	  Map<String,Object> m1=(Map<String, Object>) o1;
	    	  Map<String,Object> m2=(Map<String, Object>) o2;
	    	  int seq1=Integer.parseInt(m1.get("seq")==null ?"-1":m1.get("seq").toString());
	    	  int seq2=Integer.parseInt(m2.get("seq")==null ?"-1":m2.get("seq").toString());
	        return seq1-seq2;
	      }
	    });*/
		Util.sortListByseq(list, "seq");
		return list;
	}
	
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("sectionManagement.load", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
		Map<String,Object> pvo=new HashMap<String, Object>();
		pvo.put("id", parameter.get("parentId"));
		pvo=this.load(pvo); 
		if(pvo!=null){
			parameter.put("parentCode", pvo.get("code"));
		}else{
			parameter.put("parentCode", null);
		}
		Map<String,Object>  n_parameter = this.setInsertParameter(parameter);
	    this.getBaseDao().insert("sectionManagement.add", n_parameter);
	}
	/**
	 * 设置插入的参数
	 * @param parameter
	 * @return
	 */
	public Map<String,Object>  setInsertParameter(Map<String,Object>  parameter){
		Map<String,Object>  res = new HashMap<String,Object>(parameter);
		Object  parentCode = parameter.get("parentCode");
		String   code = this.getCode(parentCode);
		res.put("code", code);
		return  res;
	}
	/**
	 * 获取规则代码
	 * @return
	 */
	private  String getCode(Object  parentCode){
		String parameter = "";
		Map<String,String> parameMap = new HashMap<String,String>();
		if(parentCode!=null&&!"".equals(parentCode.toString().trim())){
			parameter +=" and parentCode = #{parentCode}";
			parameMap.put("parentCode", parentCode.toString());
		}else{
			parameter +=" and parentCode is null";
		}
		parameMap.put("parameter", parameter);
		
		Object maxCode = this.getBaseDao().findOne("sectionManagement.findCode", parameMap);
		if(parentCode==null){
			parentCode="";
		}
		String code="100";
		if(maxCode!=null&&!"".equals(maxCode.toString().trim())){
			code = String.valueOf((Long.parseLong(maxCode.toString())+1));
		}else{
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
		Object parentId_old=vo.get("parentId");
		Map<String,Object> pvo=new HashMap<String, Object>();
		pvo.put("id", parameter.get("parentId"));
		pvo=this.load(pvo); 
		Object parentId_new=null;
		if(pvo!=null){
			parentId_new=pvo.get("id");
			if(!parentId_new.equals(parentId_new)){
				//flag改变操作
				Object parentCode=pvo.get("code");
				String   code = this.getCode(parentCode);
				parameter.put("code", code);
				parameter.put("parentCode", parentCode);
				
				Map<String,Object> updateCode=new HashMap<String, Object>();
				updateCode.put("code",vo.get("code"));
				updateCode.put("code_new",code);
				this.getBaseDao().update("sectionManagement.updateCode", updateCode);
			}
		}else{
			if(parentId_old!=null){
				//flag改变操作
				String   code = this.getCode(null);
				parameter.put("code", code);
				parameter.put("parentCode", null);
				
				Map<String,Object> updateFlag=new HashMap<String, Object>();
				updateFlag.put("code",vo.get("code"));
				updateFlag.put("code_new",code);
				this.getBaseDao().update("sectionManagement.updateCode", updateFlag);
			}
		}
		this.getBaseDao().update("sectionManagement.update", parameter);
	}
	
	
	/**
	 * 更新数据状态
	 * @param parameter
	 */
	public void changeStatus(Map<String,Object> parameter){
		this.getBaseDao().update("sectionManagement.updateStatus", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("sectionManagement.delete", parameter);
	}
	
}

