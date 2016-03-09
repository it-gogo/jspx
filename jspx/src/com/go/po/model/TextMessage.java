package com.go.po.model;

/*
 * 响应消息--文本消息
 */
public class TextMessage extends BaseMessage {

	private String Content;//文本消息

	public String getContent() {
		return Content;
	}

	public void setContent(String content) {
		this.Content = content;
	}
	
}
