package com.go.service.supervise;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.alibaba.fastjson.JSONObject;
import com.go.common.util.DateUtil;
import com.go.common.util.ExtendDate;
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.common.util.SystemConfigUtil;
import com.go.common.util.TreeUtil;
import com.go.service.base.BaseService;
import com.go.service.weixin.WeiXinService;
/**
 * 督导统一项目设置逻辑层
 * @author zhangjf
 * @create_time 2016-3-7 上午10:52:01
 */
@Service
public class SuperviseService extends BaseService {

	@Autowired
	private WeiXinService weixinService;
	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("supervise.findCount", "supervise.findList", parameter);
	}

	/**
	 * 查询树形结构数据列表
	 * @author zhangjf
	 * @create_time 2016-3-7 上午11:10:44
	 * @param parameter
	 * @return
	 */
	public  List<Map<String,Object>>  findTree(Map<String,Object> parameter){
		List<Map<String,Object>> list=this.getBaseDao().findList("supervise.findAll", parameter);
		return TreeUtil.createTree(list);
	}
	
	
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("supervise.load", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("supervise.add", parameter);
	}
	
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("supervise.update", parameter);
	}
	
	/**
	 * 更新数据状态
	 * @param parameter
	 * @throws Exception 
	 */
	public void changeStatus(Map<String,Object> parameter,Map<String,Object> userMap) throws Exception{
		Object status=parameter.get("status");
		Object superviseId=parameter.get("id");
		try {
			if("启用".equals(status)){
				//进行提交材料消息发送
				Map<String,Object> params=new HashMap<String, Object>();
				params.put("superviseId", superviseId);
				params.put("roleType", "督学助手");
				params.put("content", "您有一个督导项目需要进行资料上传");
				sendMsg(params,userMap);
			}
			this.getBaseDao().update("supervise.changeStatus", parameter);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 发送提交材料信息(对象为督学助手)
	 * @author zhangjf
	 * @create_time 2016-3-10 下午2:00:16
	 * @param superviseId
	 * @throws Exception 
	 */
	public void sendMsg(Map<String,Object> parameter,Map<String,Object> userMap) throws Exception {
	
		if(parameter==null||parameter.isEmpty()){
			return;
		}
		try {
			List<Map<String,Object>> noticeTeacherList=this.getBaseDao().findList("supervise.listInspectorById", parameter);//查询通知对象
			List<Map<String,Object>> notices=new ArrayList<Map<String,Object>>();//保存消息老师关系集合
			String content="您有一个督导项目需要资料上传,请及时处理！";
			//构建消息推送内容
			Map<String,Object> noticeMap=new HashMap<String, Object>();
			String noticeId=SqlUtil.uuid();
			noticeMap.put("id", noticeId);
			noticeMap.put("isInStation", "站内短信");
			noticeMap.put("title", "提交材料消息");
			noticeMap.put("content", content);
			noticeMap.put("creator", userMap.get("id"));
			noticeMap.put("createdate", DateUtil.getCurrentTime());
			this.getBaseDao().insert("noticeManagement.add", noticeMap);//保存消息
			/**
			 * 遍历通知老师发送消息start
			 */
			Map<String,Object> params=null;
			for(Map<String, Object> noticeTeacher : noticeTeacherList) {
				params=new HashMap<String, Object>();
				params.put("noticeTeacherId", SqlUtil.uuid());
				params.put("teacherId", noticeTeacher.get("teacherId"));
				notices.add(noticeMap);
				/**
				 * 微端消息发送start
				 */
				if("true".equals(SystemConfigUtil.getInstance().getValByKey("sendMsg"))){
					Object wechat=noticeTeacher.get("wechat");
					if(wechat!=null){
						weixinService.sendMessage(noticeTeacher.get("teacherName")+"", content, "", wechat.toString());
					}
				}
				/**
				 * 微端消息发送end
				 */
			}
			/**
			 * 遍历通知老师发送消息end
			 */
			
			if(notices!=null&&!notices.isEmpty()){
				params=new HashMap<String, Object>();
				params.put("id", noticeId);
				params.put("list", notices);
				this.getBaseDao().insert("noticeTeacher.batchAdd", params);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("supervise.delete", parameter);
	}

	/**
	 * 统一项目数据保存
	 * @author zhangjf
	 * @create_time 2016-3-7 下午3:03:13
	 * @param parameter 督导内容
	 * @param projectId 项目ID集合
	 * @param remark 
	 * @param unitId 绑定学校
	 * @throws Exception 
	 */
	public synchronized String addData(Map<String, Object> parameter, String[] projectId,String[] projectName,
			String[] remark, String[] unitId) throws Exception {
		
		try {
			/**
			 * 第一步：保存督导信息
			 */
			Object superviseId=parameter.get("id");//获取督导ID
			if(superviseId==null){
				return "数据异常,请稍后重试!";
			}
			
			if(projectId==null||projectName==null){
				return "请至少选择一个督导项目";	
			}
			this.add(parameter);
			
			/**
			 * 第二步:创建项目及督导项目关联数据
			 */
			List<Map<String,Object>> projectList=new ArrayList<Map<String,Object>>();//保存项目集合
			List<Map<String,Object>> superviseProjectList=new ArrayList<Map<String,Object>>();//保存督导项目关联集合
			Map<String,Object> projectMap=null;
			Map<String,Object> supervisePro=null;
			Map<String,Object> params=null;
			for (int i = 0,len=projectId.length; i < len; i++) {
				String pid=projectId[i];
				if(StringUtils.isBlank(pid)){
					continue;
				}
				//校验项目是否存在
				params=new HashMap<String, Object>();
				params.put("id", pid);
				Map<String,Object> proMap=this.getBaseDao().loadEntity("project.load", params);
				if(proMap==null||proMap.isEmpty()){//若不存在则进行创建操作
					projectMap=new HashMap<String, Object>();
					pid=SqlUtil.uuid();//获取ID 
					projectMap.put("id", pid);
					projectMap.put("name", projectName[i]);
					projectMap.put("remark", remark[i]);
					projectMap.put("type", "游离");
					projectMap.put("creator", parameter.get("creator"));
					projectMap.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
					projectList.add(projectMap);
				}
				//创建关联信息
				supervisePro=new HashMap<String, Object>();
				supervisePro.put("id", SqlUtil.uuid());
				supervisePro.put("superviseId", superviseId);
				supervisePro.put("projectId", pid);
				superviseProjectList.add(supervisePro);
			}
			
			//批量保存新增项目
			if(projectList!=null && !projectList.isEmpty()){
				params=new HashMap<String, Object>();
				params.put("list", projectList);
				this.getBaseDao().insert("project.addAll", params);
			}
			//批量保存中间关联表数据
			if(superviseProjectList!=null&&!superviseProjectList.isEmpty()){
				params=new HashMap<String, Object>();
				params.put("list", superviseProjectList);
				this.getBaseDao().insert("superviseProject.add", params);
			}
			
			/**
			 * 校验是否有设置督导学校 若没有则进行所有学校绑定
			 */
			List<Map<String,Object>>superviseUnitList=new ArrayList<Map<String,Object>>();
			Map<String,Object>superviseUnit=null;
			if(unitId==null){
				//加载全部学校数据
				params=new HashMap<String, Object>();
				List<Map<String,Object>> schoolList=this.getBaseDao().findList("unitInfo.findSchool", params);
				for (Map<String, Object> school : schoolList) {
					superviseUnit=new HashMap<String, Object>();
					superviseUnit.put("id", SqlUtil.uuid());
					superviseUnit.put("superviseId", superviseId);
					superviseUnit.put("unitId", school.get("id"));
					superviseUnit.put("step", "2");
					superviseUnit.put("flowStatus", "待学校上传材料");
					superviseUnitList.add(superviseUnit);
				}
			}else{
				for (int j = 0,len=unitId.length; j <len ; j++) {
					if(StringUtils.isBlank(unitId[j])){
						continue;
					}
					superviseUnit=new HashMap<String, Object>();
					superviseUnit.put("id", SqlUtil.uuid());
					superviseUnit.put("superviseId", superviseId);
					superviseUnit.put("unitId", unitId[j]);
					superviseUnit.put("step", "2");
					superviseUnit.put("flowStatus", "待学校上传材料");
					superviseUnitList.add(superviseUnit);
				}
			}
			
			//批量保存数据
			if(superviseUnitList!=null && !superviseUnitList.isEmpty()){
				params=new HashMap<String, Object>();
				params.put("list", superviseUnitList);
				this.getBaseDao().insert("superviseUnit.add", params);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return "";	
		
	}

	/**
	 * 更新修改督导项目信息
	 * @author zhangjf
	 * @create_time 2016-3-7 下午5:26:54
	 * @param parameter
	 * @param projectId
	 * @param projectName
	 * @param remark
	 * @param unitId
	 * @return
	 * @throws Exception 
	 */
	public synchronized String  updateData(Map<String, Object> parameter, String[] projectId,String[] projectName, String[] remark, String[] unitId) throws Exception {
		Object superviseId=parameter.get("id");//获取督导ID
		if(superviseId==null){
			return "数据异常,请稍后重试!";
		}
		
		if(projectId==null||projectName==null){
			return "请至少选择一个督导项目";	
		}
		try {
			Map<String,Object> params=new HashMap<String, Object>();
			/**
			 * 第一步:先删除督导关联的项目数据
			 */
			List<String> superviseIds=new ArrayList<String>();
			superviseIds.add(superviseId.toString());
			//params.put("superviseId", superviseId);
			this.getBaseDao().delete("superviseProject.delete", superviseIds);
			/**
			 * 第二步:删除督导设置单位信息
			 */
			this.getBaseDao().delete("superviseUnit.delete", superviseIds);
			/**
			 * 第三步：更新督导信息
			 */
			this.update(parameter);
			
			/**
			 * 第四步：创建督导相关数据
			 */
			List<Map<String,Object>> projectList=new ArrayList<Map<String,Object>>();//保存项目集合
			List<Map<String,Object>> superviseProjectList=new ArrayList<Map<String,Object>>();//保存督导项目关联集合
			Map<String,Object> projectMap=null;
			Map<String,Object> supervisePro=null;
			for (int i = 0,len=projectId.length; i < len; i++) {
				String pid=projectId[i];
				if(StringUtils.isBlank(pid)){
					continue;
				}
				//校验项目是否存在
				params=new HashMap<String, Object>();
				params.put("id", pid);
				Map<String,Object> proMap=this.getBaseDao().loadEntity("project.load", params);
				if(proMap==null||proMap.isEmpty()){//若不存在则进行创建操作
					projectMap=new HashMap<String, Object>();
					pid=SqlUtil.uuid();//获取ID 
					projectMap.put("id", pid);
					projectMap.put("name", projectName[i]);
					projectMap.put("remark", remark[i]);
					projectMap.put("type", "游离");
					projectMap.put("creator", parameter.get("creator"));
					projectMap.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
					projectList.add(projectMap);
				}
				//创建关联信息
				supervisePro=new HashMap<String, Object>();
				supervisePro.put("id", SqlUtil.uuid());
				supervisePro.put("superviseId", superviseId);
				supervisePro.put("projectId", pid);
				superviseProjectList.add(supervisePro);
			}
			
			//批量保存新增项目
			if(projectList!=null && !projectList.isEmpty()){
				params=new HashMap<String, Object>();
				params.put("list", projectList);
				this.getBaseDao().insert("project.addAll", params);
			}
			//批量保存中间关联表数据
			if(superviseProjectList!=null&&!superviseProjectList.isEmpty()){
				params=new HashMap<String, Object>();
				params.put("list", superviseProjectList);
				this.getBaseDao().insert("superviseProject.add", params);
			}
			
			/**
			 * 校验是否有设置督导学校 若没有则进行所有学校绑定
			 */
			List<Map<String,Object>>superviseUnitList=new ArrayList<Map<String,Object>>();
			Map<String,Object>superviseUnit=null;
			if(unitId==null){
				//加载全部学校数据
				params=new HashMap<String, Object>();
				List<Map<String,Object>> schoolList=this.getBaseDao().findList("unitInfo.findSchool", params);
				for (Map<String, Object> school : schoolList) {
					superviseUnit=new HashMap<String, Object>();
					superviseUnit.put("id", SqlUtil.uuid());
					superviseUnit.put("superviseId", superviseId);
					superviseUnit.put("unitId", school.get("id"));
					superviseUnit.put("step", "2");
					superviseUnit.put("flowStatus", "待学校上传材料");
					superviseUnitList.add(superviseUnit);
				}
			}else{
				for (int j = 0,len=unitId.length; j <len ; j++) {
					if(StringUtils.isBlank(unitId[j])){
						continue;
					}
					superviseUnit=new HashMap<String, Object>();
					superviseUnit.put("id", SqlUtil.uuid());
					superviseUnit.put("superviseId", superviseId);
					superviseUnit.put("unitId", unitId[j]);
					superviseUnit.put("step", "2");
					superviseUnit.put("flowStatus", "待学校上传材料");
					superviseUnitList.add(superviseUnit);
				}
			}
			
			//批量保存数据
			if(superviseUnitList!=null && !superviseUnitList.isEmpty()){
				params=new HashMap<String, Object>();
				params.put("list", superviseUnitList);
				this.getBaseDao().insert("superviseUnit.add", params);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return "";
	}
}
