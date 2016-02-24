package com.go.service.platform;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.go.service.base.BaseService;
/**
 * 角色菜单Service
 * @author Administrator
 *
 */
@Service
public class RoleMenuService extends BaseService {

	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("roleMenu.add", parameter);
	}
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("roleMenu.delete", parameter);
	}
}
