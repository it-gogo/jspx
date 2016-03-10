package com.go.service.supervise;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import com.alibaba.fastjson.JSONObject;
import com.go.common.util.ExtendDate;
import com.go.common.util.SqlUtil;
import com.go.common.util.TreeUtil;
import com.go.service.base.BaseService;
/**
 * 学校督导
 * @author chenhb
 * @create_time  2016-3-8 下午3:10:02
 */
@Service
public class SchoolSuperviseService extends BaseService {

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
	 */
	public  void  addMaterial(Map<String,Object> parameter){
		Map<String,Object> parame=new HashMap<String, Object>(parameter);
		if("学校材料".equals(parameter.get("type"))){//上传学校材料，属于督导助手上传为第二步流程
			parame.put("step", 3);
			parame.put("flowStatus", "待校长审批");
			this.getBaseDao().update("superviseUnit.updateFlow", parame);
		}else if("整改材料".equals(parameter.get("type"))){//上传学校整改材料，属于督导助手上传为第六步流程
			parame.put("step", 7);
			parame.put("flowStatus", "待校长审批整改材料");
			this.getBaseDao().update("superviseUnit.updateFlow", parame);
		}else if("检查材料".equals(parameter.get("type"))){//上传检查材料，属于督学上传为第五步流程
			parame.put("step", 6);
			parame.put("flowStatus", "督学提交整改意见");
			this.getBaseDao().update("superviseUnit.updateFlow", parame);
		}
		parameter.put("status", "待审批");
	    this.getBaseDao().insert("material.add", parameter);
	}
	/**
	 * 审批材料
	 * @author chenhb
	 * @create_time  2016-3-9 下午4:07:52
	 * @param pamameter
	 */
	public void approvalMaterial(Map<String,Object> parameter){
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
