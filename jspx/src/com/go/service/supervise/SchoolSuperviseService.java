package com.go.service.supervise;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.alibaba.fastjson.JSONObject;
import com.go.common.util.DateUtil;
import com.go.common.util.ExtendDate;
import com.go.common.util.SqlUtil;
import com.go.common.util.SystemConfigUtil;
import com.go.common.util.TreeUtil;
import com.go.service.base.BaseService;
import com.go.service.weixin.WeiXinService;
/**
 * 学校督导
 * @author chenhb
 * @create_time  2016-3-8 下午3:10:02
 */
@Service
public class SchoolSuperviseService extends BaseService {

	@Autowired
	private WeiXinService weixinService;
	@Autowired
	private SuperviseService superviseService;
	
	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("superviseUnit.findCount", "superviseUnit.findList", parameter);
	}

	/**
	 * 查询关联项目
	 * @author chenhb
	 * @create_time  2016-3-8 下午4:24:38
	 * @param parameter
	 * @return
	 */
	public  List<Map<String,Object>>  findProject(Map<String,Object> parameter){
		List<Map<String,Object>> list=this.getBaseDao().findList("superviseProject.findAll", parameter);
		return list;
	}
	/**
	 * 查询材料信息
	 * @author chenhb
	 * @create_time  2016-3-8 下午4:41:51
	 * @param parameter
	 * @return
	 */
	public  List<Map<String,Object>>  findMaterial(Map<String,Object> parameter){
		List<Map<String,Object>> list=this.getBaseDao().findList("material.findAll", parameter);
		return list;
	}
	/**
	 * 查询一个督导单位
	 * @author chenhb
	 * @create_time  2016-3-9 下午3:22:12
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  findOneSU(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("superviseUnit.findOne", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 * @throws Exception 
	 */
	public  void  addMaterial(Map<String,Object> parameter,Map<String,Object> userMap) throws Exception{
		Map<String,Object> parame=new HashMap<String, Object>(parameter);
   	    Object superviseId=parameter.get("superviseId");
		if("学校材料".equals(parameter.get("type"))){//上传学校材料，属于督导助手上传为第二步流程
			parame.put("step", 3);
			parame.put("flowStatus", "待校长审批");
			this.getBaseDao().update("superviseUnit.updateFlow", parame);
			
		 	/**
	   	     * zhangjf 2016-03-11组装发送校长审批消息start
	   	     */
	   	    Map<String,Object> params=new HashMap<String, Object>();
	   	    params.put("superviseId", superviseId);
	   	    params.put("roleType", "校长室");
	   		params.put("title", "审核消息提醒");
	   		params.put("content", "您有一个督导项目上传资料"+parameter.get("name")+" 需要审核,请及时处理");
	   		superviseService.sendMsg(params, userMap);
	   	    /**
	   	     * zhangjf 2016-03-11组装发送校长审批消息end
	   	     */
			
			
		}else if("整改材料".equals(parameter.get("type"))){//上传学校整改材料，属于督导助手上传为第六步流程
			parame.put("step", 7);
			parame.put("flowStatus", "待校长审批整改材料");
			this.getBaseDao().update("superviseUnit.updateFlow", parame);
			
			/**
			 * zhangjf 2016-03-11 发送提交整改材料消息start
			 */
			 	Map<String,Object> params=new HashMap<String, Object>();
		   	    params.put("superviseId", superviseId);
		   	    params.put("roleType", "校长室");
		   		params.put("title", "提交整改材料消息提醒");
		   		params.put("content", "您有一个督导项目提交整改材料名称为:"+parameter.get("name")+" 需要审批,请及时处理");
		   		superviseService.sendMsg(params, userMap);
			
			/**
			 * zhangjf 2016-03-11 发送提交整改材料消息end
			 */
			
			
		}else if("检查材料".equals(parameter.get("type"))){//上传检查材料，属于督学上传为第五步流程
			parame.put("step", 6);
			parame.put("flowStatus", "督学提交整改意见");
			this.getBaseDao().update("superviseUnit.updateFlow", parame);
			
			/**
			 * zhangjf 2016-03-11 发送需整改消息提醒start
			 */
		   	    Map<String,Object> params=new HashMap<String, Object>();
		   	    params.put("superviseId", superviseId);
		   	    params.put("roleType", "督学助手");
		   		params.put("title", "需整改消息提醒");
		   		params.put("content", "您当前有一个督导项目需进行整改,请及时处理");
		   		superviseService.sendMsg(params, userMap);
			
			/**
			 * zhangjf 2016-03-11 发送需整改消息提醒end
			 */
			
		}
		parameter.put("status", "待审批");
	    this.getBaseDao().insert("material.add", parameter);
	}
	/**
	 * 审批材料
	 * @author chenhb
	 * @create_time  2016-3-9 下午4:07:52
	 * @param pamameter
	 * @throws Exception 
	 */
	public void approvalMaterial(Map<String,Object> parameter,Map<String,Object> userMap) throws Exception{
		Map<String,Object> parame=new HashMap<String, Object>();
		Map<String,Object> vo=this.getBaseDao().loadEntity("material.load", parameter);
		parame.put("superviseId", vo.get("superviseId"));
		parame.put("unitId", vo.get("unitId"));
		String status=parameter.get("status").toString();
		String step=parameter.get("step").toString();
		if(status.indexOf("不通过")>-1){
			if("3".equals(step) || "4".equals(step)){//3为校长审批上传材料，4为督学审批上传材料
				parame.put("step", 2);
			}else if("7".equals(step) || "8".equals(step)){//7为校长审批整改材料，8为督学审批整改材料
				parame.put("step", 6);
			}
			parame.put("flowStatus", status.replace("不通过", "")+"审批不通过");
			this.getBaseDao().update("superviseUnit.updateFlow", parame);
		}else{
			Map<String,Object> statusNum=new HashMap<String, Object>();
			statusNum.put("superviseId", vo.get("superviseId"));
			statusNum.put("unitId", vo.get("unitId"));
			statusNum.put("status", status);
			if("3".equals(step) || "4".equals(step)){
				statusNum.put("type", "学校材料");
			}else if("7".equals(step) || "8".equals(step)){
				statusNum.put("type", "整改材料");
			}
			statusNum=this.getBaseDao().loadEntity("material.findNumber", statusNum);
			int total=Integer.parseInt(statusNum.get("total").toString());
			int passNum=Integer.parseInt(statusNum.get("passNum").toString());
			int unpassNum=Integer.parseInt(statusNum.get("unpassNum").toString());
			if(unpassNum==0){
				if(passNum+1==total){//通过等于总数
					if("3".equals(step)){//校长审批上传材料通过
						parame.put("step", 4);
						parame.put("flowStatus", "待督学审批材料");
						/**
						 * zhangjf 2016-03-11 发送材料已提交消息start
						 */
							Map<String,Object> params=new HashMap<String,Object>();
							params.put("unitId", parame.get("unitId"));
							params.put("title", "已提交材料消息提醒");
							params.put("content", "您当前有一个督学项目,学校已提交相关资料,请及时处理。谢谢！");
							sendMsg(params,userMap);
						/**
						 * zhangjf 2016-03-11 发送材料已提交消息end
						 */
					}else if("4".equals(step)){//督学审批上传材料通过
						parame.put("step", 5);
						parame.put("flowStatus", "督学下校检查");
					}else if("7".equals(step)){//校长审批整改材料通过
						parame.put("step", 8);
						parame.put("flowStatus", "待督学审批整改材料");
					}else if("8".equals(step)){//督学审批整改材料通过
						parame.put("step", 9);
						parame.put("flowStatus", "督学填写督导报告");
					}
					this.getBaseDao().update("superviseUnit.updateFlow", parame);
				}
			}
		}
		this.getBaseDao().update("material.approval", parameter);
	}
	
	/**
	 * 发送督学消息
	 * @author zhangjf
	 * @create_time 2016-3-11 上午10:33:11
	 * @param params
	 * @throws Exception 
	 */
	public void sendMsg(Map<String, Object> parameter,Map<String,Object> userMap) throws Exception {
		/**
		 * 根据当前单位查询督学账号信息
		 */
		
		List<Map<String,Object>> inspectors=this.getBaseDao().findList("inspector.listInspectors", parameter);
		if(inspectors==null||inspectors.isEmpty()){
			return;
		}
		try {
			List<Map<String,Object>> notices=new ArrayList<Map<String,Object>>();//保存消息老师关系集合
			String content=parameter.get("content").toString();
			/**
			 * 构建消息信息
			 */
			Map<String,Object> noticeMap=new HashMap<String, Object>();
			String noticeId=SqlUtil.uuid();
			noticeMap.put("id", noticeId);
			noticeMap.put("isInStation", "站内短信");
			noticeMap.put("title", parameter.get("title"));
			noticeMap.put("content", content);
			noticeMap.put("creator", userMap.get("id"));
			noticeMap.put("createdate", DateUtil.getCurrentTime());
			this.getBaseDao().insert("noticeManagement.add", noticeMap);//保存消息
			/**
			 * 遍历督学账号进行消息发送start
			 */
			Map<String,Object> params=null;
			for (Map<String, Object> inspector : inspectors) {
				params=new HashMap<String, Object>();
				params.put("noticeTeacherId", SqlUtil.uuid());
				params.put("teacherId", inspector.get("userId"));
				notices.add(params);
				
				/**
				 * 微端消息发送start
				 */
				if("true".equals(SystemConfigUtil.getInstance().getValByKey("sendMsg"))){
					Object wechat=inspector.get("wechat");
					if(wechat!=null){
						weixinService.sendMessage(inspector.get("name")+"", content, "", wechat.toString());
					}
				}
				/**
				 * 微端消息发送end
				 */
				
			}
			/**
			 * 遍历督学账号进行消息发送end
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
	 * 是否督学助手
	 * @author chenhb
	 * @create_time  2016-3-10 下午5:01:01
	 * @param parameter
	 * @return
	 */
	public boolean isDXZS(Map<String,Object> parameter){
		Map<String,Object> parame=new HashMap<String, Object>(parameter);
		parame.put("roleType", "督学助手");
		Map<String,Object> vo=this.getBaseDao().loadEntity("role.findOne", parame);
		if(vo==null || vo.size()==0){
			return false;
		}
		return true;
	}
	/**
	 * 是否校长室
	 * @author chenhb
	 * @create_time  2016-3-10 下午5:01:01
	 * @param parameter
	 * @return
	 */
	public boolean isXZS(Map<String,Object> parameter){
		Map<String,Object> parame=new HashMap<String, Object>(parameter);
		parame.put("roleType", "校长室");
		Map<String,Object> vo=this.getBaseDao().loadEntity("role.findOne", parame);
		if(vo==null || vo.size()==0){
			return false;
		}
		return true;
	}
	/**
	 * 导出材料
	 * @author chenhb
	 * @create_time  2016-3-9 下午4:09:21
	 * @param parameter
	 * @return
	 */
	public Map<String,Object> loadMaterial(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("material.load", parameter);
	}
	/**
	 * 获取最大名称
	 * @author chenhb
	 * @create_time  2016-3-9 上午11:51:55
	 * @param parameter
	 * @return
	 */
	public String findMaxName(Map<String,Object> parameter){
		String name=parameter.get("name").toString();
		Object maxName= this.getBaseDao().findOne("material.findMaxName",parameter);
		if(maxName==null){
			return name+"100";
		}
		String index=maxName.toString().replace(name, "");
		if("".equals(index)){
			return name+"100";
		}
		int i=Integer.parseInt(index);
		return name+(i+1);
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
	 */
	public void changeStatus(Map<String,Object> parameter){
		this.getBaseDao().update("supervise.changeStatus", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("supervise.delete", parameter);
	}
	/**
	 * 删除材料
	 * @author chenhb
	 * @create_time  2016-3-9 下午2:24:49
	 * @param parameter
	 */
	public  void  deleteMaterial(Map<String,Object> parameter){
		this.getBaseDao().delete("material.delete", parameter);
	}

}
