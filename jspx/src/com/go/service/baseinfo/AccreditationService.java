package com.go.service.baseinfo;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.TreeUtil;
import com.go.service.base.BaseService;
/**
 * 资格确认Service
 * @author chenhb
 * @create_time  2015-9-28 下午2:04:04
 */
@Service
public class AccreditationService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("classStudent.findCount", "classStudent.findList", parameter);
	}
	/**
	 * 单个学生考勤记录树
	 * @author chenhb
	 * @create_time  2015-9-28 下午3:42:23
	 * @param parameter
	 * @return
	 */
	public Map<String,Object> findAttendanceCount(Map<String,Object> parameter){
		Map<String,Object> res=this.getBaseDao().loadEntity("attendanceInfo.statisticsZDY", parameter);
		return res;
	}
	
	public void updatePass(Map<String,Object> parameter){
		this.getBaseDao().update("classStudent.updatePass", parameter);
	}
}
