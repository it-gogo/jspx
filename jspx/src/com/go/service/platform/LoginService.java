package com.go.service.platform;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.go.service.base.BaseService;

/**
 * 登陆逻辑层
 * @author zhangjf
 * @create_time 2015-8-7 下午3:09:42
 */
@Service
public class LoginService extends BaseService {

	/**
	 * 根据用户名密码进行登陆
	 * @author zhangjf
	 * @create_time 2015-8-7 下午3:10:00
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  login(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("userInfo.login", parameter);
	}
}
