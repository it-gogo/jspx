package com.go.service.platform;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.service.base.BaseService;
/**
 * 用户Service
 * @author Administrator
 *
 */
@Service
public class UserInfoService extends BaseService {

	public List<Map<String,Object>> roleUser(Map<String,Object> parameter){
		return this.getBaseDao().findList("userInfo.roleUser", parameter);
	}
	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("userInfo.findCount", "userInfo.findList", parameter);
	}
	
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("userInfo.load", parameter);
	}
	/**
	 * 通过条件获得一个数据
	 * @author chenhb
	 * @create_time {date} 上午11:55:59
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  findOne(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("userInfo.findOne", parameter);
	}
	
	/**
	 * app登陆
	 * @author zhangjf
	 * @create_time 2015-9-30 上午10:45:32
	 * @param params
	 * @return
	 */
	public Map<String,Object> appLogin(Map<String,Object> params){
		return this.getBaseDao().loadEntity("userInfo.appLogin", params);
	}
	
	/**
	 * 加载app端登陆用户信息列表
	 * @author zhangjf
	 * @create_time 2015-10-14 下午1:57:22
	 * @return
	 */
	public List<Map<String,Object>> listLoginInfo(){
		return this.getBaseDao().findList("userInfo.listLoginInfo");
	}
	
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("userInfo.add", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("userInfo.update", parameter);
	}
	/**
	 * 修改密码
	 * @author chenhb
	 * @create_time {date} 下午2:33:24
	 * @param parameter
	 */
	public  void  modifyPassword(Map<String,Object> parameter){
		this.getBaseDao().update("userInfo.modifyPassword", parameter);
	}
	
	/**
	 * 更新数据状态
	 * @param parameter
	 */
	public void updatestat(Map<String,Object> parameter){
		this.getBaseDao().update("userInfo.changeStat", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("userInfo.delete", parameter);
	}
}
