package com.go.common.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;


public class TreeUtil {
	public static List<Map<String,Object>> createTree(List<Map<String,Object>> list){
		List<Map<String,Object>> arraylist = new ArrayList<Map<String,Object>>();
		Map<Object,Map<String,Object>> resMap=new HashMap<Object,Map<String,Object>>();
		Map<Object,Map<String,Object>> m=new HashMap<Object,Map<String,Object>>();
		for(Map<String,Object> map:list){
//			Object pid=map.get("pid");
//			if(pid==null || "".equals(pid.toString())){
//				resMap.put(map.get("id"), map);
//			}
			m.put(map.get("id"), map);
		}
		for(Map<String,Object> map:list){
			Object pid=map.get("pid");
			if(pid==null || "".equals(pid.toString()) || !m.containsKey(pid)){
				resMap.put(map.get("id"), map);
			}
			m.put(map.get("id"), map);
		}
		for(Map<String,Object> map:list){
			Object pid=map.get("pid");
			if(pid!=null){
				Map<String,Object> mm=m.get(pid);
				if(mm!=null){
					List<Map<String,Object>> ll=(List) mm.get("children");
					if(ll==null){
						ll=new ArrayList<Map<String,Object>>();
						mm.put("children",ll);
					}
					ll.add(map);
				}
			}
		}
		arraylist=mapTransitionList(resMap);
		return arraylist;
	}
	
	/**
	 * 构建树形结构数据
	 * @author zhangjf
	 * @create_time 2016-3-25 下午3:28:22
	 * @param list
	 * @return
	 */
	public static List<Map<String,Object>> createTree_(List<Map<String,Object>> list){
		List<Map<String,Object>> arraylist = new ArrayList<Map<String,Object>>();
		Map<Object,Map<String,Object>> resMap=new HashMap<Object,Map<String,Object>>();
		Map<Object,Map<String,Object>> m=new HashMap<Object,Map<String,Object>>();
		for(Map<String,Object> map:list){
//			Object pid=map.get("pid");
//			if(pid==null || "".equals(pid.toString())){
//				resMap.put(map.get("id"), map);
//			}
			m.put(map.get("id"), map);
		}
		for(Map<String,Object> map:list){
			Object parentId=map.get("parentId");
			if(parentId==null || "".equals(parentId.toString()) || !m.containsKey(parentId)){
				resMap.put(map.get("id"), map);
			}
			m.put(map.get("id"), map);
		}
		for(Map<String,Object> map:list){
			Object parentId=map.get("parentId");
			if(parentId!=null){
				Map<String,Object> mm=m.get(parentId);
				if(mm!=null){
					List<Map<String,Object>> ll=(List) mm.get("children");
					if(ll==null){
						ll=new ArrayList<Map<String,Object>>();
						mm.put("children",ll);
					}
					ll.add(map);
				}
			}
		}
		arraylist=mapTransitionList(resMap);
		return arraylist;
	}
	
	
	//map转换成lisy
	private static List<Map<String,Object>>  mapTransitionList(Map<Object,Map<String,Object>> map) {
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Iterator<Object> iter = map.keySet().iterator(); //获得map的Iterator
		while(iter.hasNext()) {
			Object key =iter.next();
			list.add(map.get(key));
		}
		return list;
	}
}
