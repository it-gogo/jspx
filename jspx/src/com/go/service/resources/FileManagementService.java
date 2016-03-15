package com.go.service.resources;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.service.base.BaseService;
/**
 * 文件管理 service
 * @author chenhb
 * @create_time  2015-11-18 上午11:24:55
 */
@Service
public class FileManagementService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("fileManagement.findCount", "fileManagement.findList", parameter);
	}
	
	/**
	 * 分页查询回收站信息
	 * @author zhangjf
	 * @create_time 2015-11-19 上午9:04:41
	 * @param params
	 * @return
	 */
	public JSONObject recyclePageBean(Map<String,Object> params){
		return this.getBaseDao().findListPage("fileManagement.recycleCount", "fileManagement.recycleList", params);

	}
	/**
	 * 分页查询共享数据
	 * @author zhangjf
	 * @create_time 2015-11-20 下午6:19:05
	 * @param params
	 * @return
	 */
	public JSONObject sharePageBean(Map<String,Object> params){
		return this.getBaseDao().findListPage("fileManagement.shareCount", "fileManagement.shareList", params);

	}
	
	public List<Map<String,Object>> findAll(Map<String,Object> parameter){
		return this.getBaseDao().findList("fileManagement.findAll", parameter);
	}
	public List<Map<String,Object>> findTree(Map<String,Object> parameter){
		return this.getBaseDao().findList("fileManagement.findTree", parameter);
	}
	/**
	 * 查询有共享文件夹的资源文件夹
	 * @author chenhb
	 * @create_time  2015-11-26 下午5:19:14
	 * @param parameter
	 * @return
	 */
	public List<Map<String,Object>> findShareSchoolFolder(Map<String,Object> parameter){
		return this.getBaseDao().findList("fileManagement.findShareSchoolFolder", parameter);
	}
	/**
	 * 查询共享
	 * @author chenhb
	 * @create_time  2015-11-24 下午3:06:01
	 * @param parameter
	 * @return
	 */
	public List<Map<String,Object>> findShared(Map<String,Object> parameter){
		return this.getBaseDao().findList("sharedRole.fineShared", parameter);
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("fileManagement.load", parameter);
	}
	public  Map<String,Object>  findOne(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("fileManagement.findOne", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("fileManagement.add", parameter);
	}
	
	/**
	 * 批量添加数据
	 * @author zhangjf
	 * @create_time 2015-11-19 下午2:22:17
	 * @param parameter
	 */
	public  void  addAll(Map<String,Object> parameter){
	    this.getBaseDao().insert("fileManagement.addAll", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  String  update(Map<String,Object> parameter){
		String msg="";
		 Map<String,Object> vo=this.getBaseDao().loadEntity("absoluteManagement.findOne", parameter);//查询顶级文件绑定绝对地址
		/**修改文件物理名称start**/
			  try {
			File oldFile = new File(vo.get("absoluteUrl")+File.separator+parameter.get("historyRelativeUrl")+"");
			if(!oldFile.exists())
			  {
				oldFile.createNewFile();
			  }
			String rootPath = oldFile.getParent();
			 File newFile = new File(rootPath + File.separator + parameter.get("name"));
			 if (!oldFile.renameTo(newFile)) 
			  {
				 msg="名称已存在,重命名失败";
			  }
			  } catch (IOException e) {
					e.printStackTrace();
					return "修改名称出现异常";
			}
			  
		/**修改文件物理名称end**/
		if(StringUtils.isBlank(msg)){
			this.getBaseDao().update("fileManagement.update", parameter);
		}
		return msg;
	}
	
	public void updateSeq(List<Map<String,Object>> list){
		this.getBaseDao().update("fileManagement.updateSeq", list);
	}
	
	/**
	 * 更新数据状态
	 * @param parameter
	 */
	public void changeStatus(Map<String,Object> parameter){
		this.getBaseDao().update("fileManagement.changeStatus", parameter);
	}
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  deleteStatus(Map<String,Object> parameter){
		this.getBaseDao().delete("fileManagement.deleteStatus", parameter);
	}
	
	/**
	 * 数据物理删除
	 * @author zhangjf
	 * @create_time 2015-11-19 上午10:03:41
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("fileManagement.delete", parameter);
	}
	/**
	 * 加载数据列表
	 * @author zhangjf
	 * @create_time 2015-11-19 上午10:08:06
	 * @param parameter
	 * @return
	 */
	public  List<Map<String,Object>> loadByIds(List<String> parameter){
		return this.getBaseDao().findList("fileManagement.loadByIds", parameter);
	}
	
	/**
	 * 数据还原
	 * @author zhangjf
	 * @create_time 2015-11-19 上午10:25:38
	 * @param parameter
	 */
	public void reduction(List<String> parameter){
		 this.getBaseDao().update("fileManagement.reduction", parameter);
	}
	
	/**
	 * 查看回收站列表
	 * @author zhangjf
	 * @create_time 2015-11-19 上午10:31:23
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> recycleAll(Map<String,Object> params){
		return this.getBaseDao().findList("fileManagement.recycleAll", params);
	}
}
