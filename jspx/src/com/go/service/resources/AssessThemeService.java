package com.go.service.resources;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.SqlUtil;
import com.go.common.util.TreeUtil;
import com.go.service.base.BaseService;
/**
 * 评估主题
 * @author chenhb
 * @create_time  2015-11-27 下午1:36:03
 */
@Service
public class AssessThemeService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("assessTheme.findCount", "assessTheme.findList", parameter);
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("assessTheme.load", parameter);
	}
	
	
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
		Map<String,Object> parame=new HashMap<String, Object>();
		parame.put("templateId", parameter.get("templateId"));//获取模板Id
		List<Map<String,Object>> list =this.getBaseDao().findList("themeDirectory.findAll",parame);//获取目录
		if(list!=null && list.size()>0){
			list=TreeUtil.createTree(list);
			parameter.put("children", list);
			List<Map<String,Object>> res=new ArrayList<Map<String,Object>>();
			getFile(parameter, res, parameter.get("title").toString(), parameter.get("topFileId").toString());
			parameter.put("fileList", res);
			if(res!=null && res.size()>0){
				this.getBaseDao().insert("assessTheme.addFile", parameter);
			}
		}
		this.getBaseDao().insert("assessPic.add", parameter);
	    this.getBaseDao().insert("assessTheme.add", parameter);
	}
	private void getFile(Map<String,Object> map,List<Map<String,Object>> list,String parentUrl,String parentId){
		@SuppressWarnings("unchecked")
		List<Map<String,Object>> children=(List<Map<String, Object>>) map.get("children");
		if(children!=null && children.size()>0){
			for(Map<String,Object> m:children){
				Map<String,Object> file=new HashMap<String, Object>();
				String id=SqlUtil.uuid();
				Object name=m.get("name");
				String relativeUrl=parentUrl+"/"+name;
				file.put("id", id);
				file.put("name", name);
				file.put("type", "文件夹");
				file.put("parentId", parentId);
				file.put("relativeUrl", relativeUrl);
				list.add(file);
				getFile(m, list, relativeUrl, id);
			}
		}
	}
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		Map<String,Object> vo=this.getBaseDao().loadEntity("assessTheme.load", parameter);
		if(!vo.get("templateId").equals(parameter.get("templateId"))){
			this.getBaseDao().delete("fileManagement.deleteByTopFileId", parameter);//删除之前目录文件
			Map<String,Object> parame=new HashMap<String, Object>();
			parame.put("templateId", parameter.get("templateId"));//获取模板Id
			List<Map<String,Object>> list =this.getBaseDao().findList("themeDirectory.findAll",parame);//获取目录
			if(list!=null && list.size()>0){
				list=TreeUtil.createTree(list);
				parameter.put("children", list);
				List<Map<String,Object>> res=new ArrayList<Map<String,Object>>();
				getFile(parameter, res, parameter.get("title").toString(), parameter.get("topFileId").toString());
				parameter.put("fileList", res);
				if(res!=null && res.size()>0){
					this.getBaseDao().insert("assessTheme.addFile", parameter);
				}
			}
		}
		
		
		List<String> ids=new ArrayList<String>();
		ids.add(parameter.get("id").toString());
		this.getBaseDao().delete("assessPic.delete", ids);//删除之前的关联数据
		this.getBaseDao().insert("assessPic.add", parameter);
		this.getBaseDao().update("assessTheme.update", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("assessTheme.delete", parameter);
	}
}
