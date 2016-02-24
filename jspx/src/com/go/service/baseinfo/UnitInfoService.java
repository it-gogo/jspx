package com.go.service.baseinfo;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.ExtendDate;
import com.go.common.util.SqlUtil;
import com.go.common.util.TreeUtil;
import com.go.common.util.Util;
import com.go.service.base.BaseService;
/**
 * 单位组织Service
 * @author Administrator
 *
 */
@Service
public class UnitInfoService extends BaseService {

	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("unitInfo.findCount", "unitInfo.findList", parameter);
	}
	/**
	 * 不分页查询
	 * @author chenhb
	 * @create_time {date} 上午11:15:18
	 * @param parameter
	 * @return
	 */
	public  List<Map<String,Object>>  findAll(Map<String,Object> parameter){
		return this.getBaseDao().findList("unitInfo.findAll", parameter);
	}
	/**
	 * 学校树
	 * @author chenhb
	 * @create_time {date} 上午10:56:47
	 * @param parameter
	 * @return
	 * @throws Exception 
	 * @throws  
	 */
	public List<Map<String,Object>> findSchool(Map<String,Object> parameter) throws  Exception{
		List<Map<String,Object>> schoolList=this.getBaseDao().findList("unitInfo.findSchool", parameter);
		Map<String,Object> n_parameter=new HashMap<String, Object>(parameter);
//		n_parameter.put("isEdb", "1");
		List<Map<String,Object>> list=this.getBaseDao().findList("unitInfo.findTree", n_parameter);
		parameter=new HashMap<String, Object>();
		parameter.put("code", "XXLX");
		List<Map<String,Object>> lxList=this.getBaseDao().findList("codeData.findAll", parameter);//学校类型数据
		parameter.put("code", "XXLB");
		List<Map<String,Object>> lbList=this.getBaseDao().findList("codeData.findAll", parameter);//学校类别数据
		for(Map<String,Object> lb:lbList){
			lb.put("children", Util.copyBySerialize(lxList));
		}
		
		Map<Object,List<Map<String,Object>>> resMap=new HashMap<Object, List<Map<String,Object>>>();
		for(Map<String,Object> school:schoolList){
			Object pid=school.get("pid");
			List<Map<String,Object>> res=resMap.get(pid);
			if(res==null){
				res=Util.copyBySerialize(lbList);
				resMap.put(pid, res);
			}
			Object lbid=school.get("categoryId");//类别
			Object lxid=school.get("typeId");//类型
			for(Map<String,Object> lb:res){
				if(lb.get("id").equals(lbid)){
					List<Map<String,Object>> resLxList=(List<Map<String, Object>>) lb.get("children");
					for(Map<String,Object> lx:resLxList){
						if(lx.get("id").equals(lxid)){
							List<Map<String,Object>> resSchoolList=(List<Map<String, Object>>) lx.get("children");
							if(resSchoolList==null){
								resSchoolList=new ArrayList<Map<String,Object>>();
								lx.put("children", resSchoolList);
							}
							resSchoolList.add(school);
						}
					}
					break;
				}
			}
		}
		
		for(Map<String,Object> map:list){
			Object isEdb=map.get("isEdb");//是否为教育局
			if("1".equals(isEdb)){//是教育局
				Object id=map.get("id");
				List<Map<String,Object>> children=resMap.get(id);
				if(children!=null){
					map.put("children", children);
				}else{
					map.put("children", Util.copyBySerialize(lbList));
				}
			}
		}
		List<Map<String,Object>> resList=TreeUtil.createTree(list);
		return resList;
	}
	/**
	 * 查询树(添加时，上级单位)
	 * @author chenhb
	 * @create_time {date} 上午10:56:47
	 * @param parameter
	 * @return
	 */
	public List<Map<String,Object>> findUnitTree(Map<String,Object> parameter){
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("id", "");
		map.put("text", "请选择");
		list.add(map);
		list.addAll(this.getBaseDao().findList("unitInfo.findTree", parameter));
		return TreeUtil.createTree(list);
	}
	/**
	 * 左边树形数据
	 * @author chenhb
	 * @create_time {date} 下午5:11:06
	 * @param parameter
	 * @return
	 * @throws Exception 
	 * @throws  
	 */
	public List<Map<String,Object>> findTree(Map<String,Object> parameter) throws  Exception{
		List<Map<String,Object>> list=this.getBaseDao().findList("unitInfo.findTree", parameter);
		parameter=new HashMap<String, Object>();
		parameter.put("code", "XXLX");
		List<Map<String,Object>> lxList=this.getBaseDao().findList("codeData.findAll", parameter);//学校类型数据
		parameter.put("code", "XXLB");
		List<Map<String,Object>> lbList=this.getBaseDao().findList("codeData.findAll", parameter);//学校类别数据
		for(Map<String,Object> lb:lbList){
			lb.put("children", Util.copyBySerialize(lxList));
		}
		for(Map<String,Object> map:list){
			Object isEdb=map.get("isEdb");//是否为教育局
			if("1".equals(isEdb)){//是教育局
				if(lbList!=null && lbList.size()>0){//学校类别
					map.put("children",Util.copyBySerialize(lbList) );
				} 
			}
		}
		List<Map<String,Object>> resList=TreeUtil.createTree(list);
		return resList;
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("unitInfo.load", parameter);
	}
	/**
	 * 通过条件获得一个数据
	 * @author chenhb
	 * @create_time {date} 上午11:55:59
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  findOne(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("unitInfo.findOne", parameter);
	}
	/**
	 * 导入方式添加
	 * @author chenhb
	 * @create_time {date} 下午4:38:08
	 * @param list
	 * @throws Exception 
	 */
	public String addAll(List<String[]> list,String pid,Object creator) throws Exception{
		StringBuffer sb=new StringBuffer();
		List<Map<String,Object>> res=new ArrayList<Map<String,Object>>();
		String[]  header = new String[]{
				"name","code","typeId","categoryId","pid","text","password"
			};
		Map<String,Object> parameter=new HashMap<String, Object>();
		parameter.put("code", "XXLX");
		List<Map<String,Object>> lxList=this.getBaseDao().findList("codeData.findAll", parameter);//学校类型
		parameter.put("code", "XXLB");
		List<Map<String,Object>> lbList=this.getBaseDao().findList("codeData.findAll", parameter);//学校类别
		
		for(String[] arr:list){
			boolean ok=true;
			Map<String,Object> map=new HashMap<String, Object>();
			map.put("id", SqlUtil.uuid());
			map.put("userId", SqlUtil.uuid());
			map.put("creator", creator);
			map.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			for(int i=0;i<header.length;i++){
				if(i==2){//学校类型
					String lxName=arr[i];
					if(lxName!=null && !"".equals(lxName)){//学校类型
						boolean o=true;
						for(Map<String,Object> m:lxList){
							if(m.get("name").toString().indexOf(lxName.trim())>-1){
								map.put(header[i], m.get("id"));
								o=false;
								break;
							}
						}
						if(o){
							sb.append(map.get("name")+"学校数据中类型不存在，因此未能添加该条数据。");
							ok=false;
							break;
						}
					}else{
						sb.append(map.get("name")+"学校数据中类型不能为空，因此未能添加该条数据。");
						ok=false;
						break;
					}
				}else if(i==3){//学校类别
					String lbName=arr[i];
					if(lbName!=null && !"".equals(lbName)){//学校类别
						boolean o=true;
						for(Map<String,Object> m:lbList){
							if(m.get("name").toString().indexOf(lbName.trim())>-1){
								map.put(header[i], m.get("id"));
								o=false;
								break;
							}
						}
						if(o){
							sb.append(map.get("name")+"学校数据中类别不存在，因此未能添加该条数据。");
							ok=false;
							break;
						}
					}else{
						sb.append(map.get("name")+"学校数据中类别不能为空，因此未能添加该条数据。");
						ok=false;
						break;
					}
				}else if(i==4){//附属单位
					if(pid==null || "".equals(pid)){//
						String pname=arr[i];
						if(pname!=null && !"".equals(pname)){//附属单位名称
							Map<String,Object> info=new HashMap<String, Object>();
							info.put("name", pname.trim());
							info.put("type", "1");
							info= this.getBaseDao().loadEntity("unitInfo.findOne", info);
							if(info!=null){
								map.put("pid", info.get("id"));
							}else{
								sb.append(map.get("name")+"学校数据中附属单位有错，因此未能添加该条数据。");
								ok=false;
								break;
							}
						}else{
							sb.append(map.get("name")+"学校数据中附属单位为空时，只能附属单位的 管理员导入，因此未能添加该条数据。");
							ok=false;
							break;
						}
					}else{
						map.put("pid", pid);
					}
				}else if(i==5){//账号
					String text=arr[i];
					if(text!=null && !"".equals(text)){//账号
						Map<String,Object> info=new HashMap<String, Object>();
						info.put("text", text.trim());
						info= this.getBaseDao().loadEntity("userInfo.findOne", info);
						if(info!=null){
							sb.append(map.get("name")+"学校数据中管理账号已存在，因此未能添加该条数据。");
							ok=false;
							break;
						}
					}else{
						sb.append(map.get("name")+"学校数据中管理账号不能为空，因此未能添加该条数据。");
						ok=false;
						break;
					}
					map.put(header[i], arr[i]);
				}else if(i==6){//密码
					String password=arr[i];
					if(password==null || "".equals(password)){//密码
						password="123456";
					}
					map.put(header[i], Util.Encryption(password));
				}else{
					map.put(header[i], arr[i]);
				}
			}
			if(ok){
				map.put("type", "2");
				Map<String,Object> punitInfo=new HashMap<String, Object>();
				punitInfo.put("id", map.get("pid"));
				punitInfo=this.load(punitInfo); 
				if(punitInfo!=null){
					map.put("pflag", punitInfo.get("flag"));
				}else{
					map.put("pflag", null);
				}
				Map<String,Object>  n_parameter = this.setInsertParameter(map);
				res.add(n_parameter);
			}
		}
		if(res.size()!=0){
			Map m=new HashMap();
			m.put("list", res);
			this.getBaseDao().insert("unitInfo.addAll", m);
		}
		return sb.toString();
	}
	
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
		Map<String,Object> punitInfo=new HashMap<String, Object>();
		punitInfo.put("id", parameter.get("pid"));
		punitInfo=this.load(punitInfo); 
		if(punitInfo!=null){
			parameter.put("pflag", punitInfo.get("flag"));
		}else{
			parameter.put("pflag", null);
		}
		Map<String,Object>  n_parameter = this.setInsertParameter(parameter);
	    this.getBaseDao().insert("unitInfo.add", n_parameter);
	}
	/**
	 * 设置插入的参数
	 * @param parameter
	 * @return
	 */
	public Map<String,Object>  setInsertParameter(Map<String,Object>  parameter){
		Map<String,Object>  res = new HashMap<String,Object>(parameter);
		Object  pflag = parameter.get("pflag");
		String   flag = this.getFlag(pflag);
		res.put("flag", flag);
//		Object  seq=res.get("seq");
//		if(seq==null || "".equals(seq)){
//			res.put("seq",this.getSeq());
//		}
		return  res;
	}
//	/**
//	 * 获取序列
//	 * @return
//	 */
//	private  Integer  getSeq(){
//		Object  maxSeq = this.getBaseDao().findOne("unitInfo.findMaxSeq");
//		Integer seq = 0;
//		if(maxSeq!=null){
//			seq = (Integer)maxSeq;
//		}
//		return  seq+1;
//	}
	/**
	 * 获取菜单规则代码
	 * @return
	 */
	private  String getFlag(Object  pflag){
		String parameter = "";
		Map<String,String> parameMap = new HashMap<String,String>();
		if(pflag!=null&&!"".equals(pflag.toString().trim())){
			parameter +=" and pflag = #{pflag}";
		}else{
			parameter +=" and pflag is null";
		}
		parameMap.put("parameter", parameter);
		if(pflag!=null){
		  parameMap.put("pflag", pflag.toString());
		}else{
			parameMap.put("pflag", "1");
		}
		
		Object maxFlag = this.getBaseDao().findOne("unitInfo.findFlag", parameMap);
		if(pflag==null){
			pflag="";
		}
//		int index=(pflag.toString().length()/4)+1;
//		if(index==0){
//			index=1;
//		}
//		String flag = (index*1000)+"";
		String flag="100";
		if(maxFlag!=null&&!"".equals(maxFlag.toString().trim())){
			flag = String.valueOf((Long.parseLong(maxFlag.toString())+1));
		}else{
			flag = pflag+flag;
		}
		return flag;
	}
	/**
	 * 批量修改密码
	 * @author chenhb
	 * @create_time {date} 下午1:39:53
	 * @param list
	 */
	public void batchPassword(List<Map<String,Object>> list){
		Map<String,Object> parameter=new HashMap<String, Object>();
		parameter.put("list", list);
		this.getBaseDao().update("userInfo.batchPassword", parameter);
	}
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		Map<String,Object> unitInfo=this.load(parameter);
		Object pid_old=unitInfo.get("pid");
		Map<String,Object> punitInfo=new HashMap<String, Object>();
		punitInfo.put("id", parameter.get("pid"));
		punitInfo=this.load(punitInfo); 
		Object pid_new=null;
		if(punitInfo!=null){
			pid_new=punitInfo.get("id");
			if(!pid_new.equals(pid_old)){
				//flag改变操作
				Object pflag=punitInfo.get("flag");
				String   flag = this.getFlag(pflag);
				parameter.put("flag", flag);
				parameter.put("pflag", pflag);
				
				Map<String,Object> updateFlag=new HashMap<String, Object>();
				updateFlag.put("flag",unitInfo.get("flag"));
				updateFlag.put("flag_new",flag);
				this.getBaseDao().update("unitInfo.updateFlag", updateFlag);
			}
		}else{
			if(pid_old!=null){
				//flag改变操作
				String   flag = this.getFlag(null);
				parameter.put("flag", flag);
				parameter.put("pflag", null);
				
				Map<String,Object> updateFlag=new HashMap<String, Object>();
				updateFlag.put("flag",unitInfo.get("flag"));
				updateFlag.put("flag_new",flag);
				this.getBaseDao().update("unitInfo.updateFlag", updateFlag);
			}
		}
		this.getBaseDao().update("unitInfo.update", parameter);
	}
	
	/**
	 * 更新数据状态
	 * @param parameter
	 */
	public void updatestat(Map<String,Object> parameter){
		this.getBaseDao().update("unitInfo.changeStat", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("unitInfo.delete", parameter);
	}
}
