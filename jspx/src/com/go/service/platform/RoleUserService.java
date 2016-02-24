package com.go.service.platform;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.go.service.base.BaseService;
/**
 * 角色登陆Service
 * @author Administrator
 *
 */
@Service
public class RoleUserService extends BaseService {

	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("roleUser.add", parameter);
	}
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("roleUser.delete", parameter);
	}
}
