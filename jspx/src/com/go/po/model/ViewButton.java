package com.go.po.model;
/**
 * view类型的菜单
 * @author zhangjf
 * @create_time 2015-8-25 上午10:00:32
 */
public class ViewButton extends Button {
	private String type;  
    private String url;
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}  
    
}
