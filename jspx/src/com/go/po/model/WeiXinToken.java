package com.go.po.model;

/**
 * 调用微信服务端所需的动态token
 * @author zhangjf
 * @create_time 2015-10-8 下午2:25:32
 */
public class WeiXinToken {
	private String token;//调用接口服务端生成凭证
	private Integer expiresIn;//凭证有效时间单位:秒
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public Integer getExpiresIn() {
		return expiresIn;
	}
	public void setExpiresIn(Integer expiresIn) {
		this.expiresIn = expiresIn;
	}
	
	
	
}
