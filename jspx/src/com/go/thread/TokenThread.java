package com.go.thread;

import com.go.common.util.LogUtil;
import com.go.common.util.WeiXin_Util;
import com.go.po.model.WeiXinToken;

/**
 * 定时获取微信access_token的线程
 * @author zhangjf
 * @create_time 2015-10-8 下午3:46:21
 */
public class TokenThread implements Runnable {  
   
    public static WeiXinToken accessToken = null;  
    public void run() {  
        while (true) {  
            try {  
                accessToken = WeiXin_Util.getAccessToken();
                if (null != accessToken) {  
                    //log.info("获取access_token成功，有效时长{}秒 token:{}", accessToken.getExpiresIn(), accessToken.getToken());  
                	LogUtil.error(TokenThread.class, "获取access_token成功，有效时长"+accessToken.getExpiresIn()+" token:"+accessToken.getToken());
                	// 休眠7000秒  
                    Thread.sleep((accessToken.getExpiresIn() - 200) * 1000);  
                } else {  
                    Thread.sleep(60 * 1000);  
                }  
            } catch (InterruptedException e) {  
                try {  
                    Thread.sleep(60 * 1000);  
                } catch (InterruptedException e1) {  
                    LogUtil.error(TokenThread.class, e1.getMessage());
                }  
                LogUtil.error(TokenThread.class, e.getMessage());
            }  
        }  
    }  
}  
