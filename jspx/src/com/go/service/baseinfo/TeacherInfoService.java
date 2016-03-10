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
 * 老师信息Service
 * @author Administrator
 *
 */
@Service
public class TeacherInfoService extends BaseService {
	
	/**
	 * 老师树
	 * @author chenhb
	 * @create_time {date} 上午10:56:47
	 * @param parameter
	 * @return
	 */
	public List<Map<String,Object>> findTeacherTree(Map<String,Object> parameter){
		List<Map<String,Object>> teacherList=this.getBaseDao().findList("teacherInfo.findTree", parameter);
		List<Map<String,Object>> schoolList=this.getBaseDao().findList("unitInfo.findSchool", parameter);
		teacherList.addAll(schoolList);
		List<Map<String,Object>> res=TreeUtil.createTree(teacherList);
//		for(Map<String,Object> m:res){
//			if(m.containsKey("children")){
//				m.put("state", "closed");
//			}
//		}
		return res;
	}
	
	/**
	 * 根据班级ID查找班级学生信息
	 * @author zhangjf
	 * @create_time 2015-9-30 下午3:34:23
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> listByParams(Map<String,Object> params){
		return this.getBaseDao().findList("teacherInfo.listByParams",params);
	}
	
	/**
	 * app加载同步学生列表数据
	 * @author zhangjf
	 * @create_time 2015-10-14 下午2:18:32
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>>synStudents(){
		return this.getBaseDao().findList("teacherInfo.synStudents");
	}
	
	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter){
		return this.getBaseDao().findListPage("teacherInfo.findCount", "teacherInfo.findList", parameter);
	}
	/**
	 * 加载信息
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  load(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("teacherInfo.load", parameter);
	}
	/**
	 * 根据身份证号加载信息
	 * @author zhangjf
	 * @create_time 2015-10-14 上午11:19:15
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  loadByIdCard(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("teacherInfo.loadByIdCard", parameter);
	}
	
	/**
	 * 根据身份证号加载老师/督学信息
	 * @author zhangjf
	 * @create_time 2016-3-10 下午5:36:53
	 * @param parameter
	 * @return
	 */
	public List<Map<String,Object>>loadInfoByIdCard(Map<String,Object> parameter){
		return this.getBaseDao().findList("teacherInfo.loadInfoByIdCard", parameter);
	}
	
	/**
	 * 通过条件获得一个数据
	 * @author chenhb
	 * @create_time {date} 上午11:55:59
	 * @param parameter
	 * @return
	 */
	public  Map<String,Object>  findOne(Map<String,Object> parameter){
		return this.getBaseDao().loadEntity("teacherInfo.findOne", parameter);
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  void  add(Map<String,Object> parameter){
	    this.getBaseDao().insert("teacherInfo.add", parameter);
	}
	/**
	 * 导入方式添加
	 * @author chenhb
	 * @create_time {date} 下午4:38:08
	 * @param list
	 * @throws Exception 
	 */
	public String addAll(List<String[]> list,String schoolId,Object creator) throws Exception{
//		List<String> resList=new ArrayList<String>();
		StringBuffer sb=new StringBuffer();
		List<Map<String,Object>> res=new ArrayList<Map<String,Object>>();
		String[]  header = new String[]{
				"name","sex","raceId","partisanId","idcard","telephone","address","qq",
				"zkxdId","zkxkId","fkxdId","fkxkId","schoolId","text","password"
			};
		Map<String,Object> parameter=new HashMap<String, Object>();
		parameter.put("code", "XD");
		List<Map<String,Object>> xdList=this.getBaseDao().findList("codeData.findAll", parameter);//学段
		parameter.put("code", "XK");
		List<Map<String,Object>> xkList=this.getBaseDao().findList("codeData.findAll", parameter);//学科
		
		for(String[] arr:list){
			boolean ok=true;
			Map<String,Object> map=new HashMap<String, Object>();
			map.put("id", SqlUtil.uuid());
			map.put("userId", SqlUtil.uuid());
			map.put("creator", creator);
			map.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
			for(int i=0;i<header.length;i++){
				if(i==0){//姓名
					String name=arr[i];
					if(name==null || "".equals(name)){//
						sb.append("老师数据中姓名不能为空，因此未能添加该条数据。");
						ok=false;
						break;
					}else{
						map.put(header[i], arr[i]);
					}
				}else if(i==4){//身份证
					String idcard=arr[i];
					if(idcard==null || "".equals(idcard)){//
						sb.append(map.get("name")+"老师数据中身份证不能为空，因此未能添加该条数据。");
						ok=false;
						break;
					}else{
						map.put(header[i], arr[i]);
					}
				}else if(i==1){//性别
					String sex=arr[i];
					if("男".equals(sex)){//性别
						map.put("sex", "1");
					}else{
						map.put("sex", "0");
					}
				}else if(i==2){//民族
					String raceName=arr[i];
					if(raceName!=null && !"".equals(raceName)){//民族
						Map<String,Object> data=new HashMap<String, Object>();
						data.put("name", raceName.trim());
						data.put("code", "MZ");
						data= this.getBaseDao().loadEntity("codeData.findOne", data);
						if(data!=null){
							map.put("raceId", data.get("id"));
						}
					}
				}else if(i==3){//党派
					String partisanName=arr[i];
					if(partisanName!=null && !"".equals(partisanName)){//党派
						Map<String,Object> data=new HashMap<String, Object>();
						data.put("name", partisanName.trim());
						data.put("code", "DP");
						data= this.getBaseDao().loadEntity("codeData.findOne", data);
						if(data!=null){
							map.put("partisanId", data.get("id"));
						}
					}
				}else if(i==8){//主科学段
					String zkxdName=arr[i];
					if(zkxdName!=null && !"".equals(zkxdName)){//主科学段
						for(Map<String,Object> m:xdList){
							if(m.get("name").toString().indexOf(zkxdName.trim())>-1){
								map.put("zkxdId", m.get("id"));
								break;
							}
						}
					}
				}else if(i==9){//主科学科
					String zkxkName=arr[i];
					if(zkxkName!=null && !"".equals(zkxkName)){//主科学科
						for(Map<String,Object> m:xkList){
							if(m.get("name").toString().indexOf(zkxkName.trim())>-1){
								map.put("zkxkId", m.get("id"));
								break;
							}
						}
					}
				}else if(i==10){//副科学段
					String fkxdName=arr[i];
					if(fkxdName!=null && !"".equals(fkxdName)){//副科学段
						for(Map<String,Object> m:xdList){
							if(m.get("name").toString().indexOf(fkxdName.trim())>-1){
								map.put("fkxdId", m.get("id"));
								break;
							}
						}
					}
				}else if(i==11){//副科学科
					String fkxkName=arr[i];
					if(fkxkName!=null && !"".equals(fkxkName)){//副科学科
						for(Map<String,Object> m:xkList){
							if(m.get("name").toString().indexOf(fkxkName.trim())>-1){
								map.put("fkxkId", m.get("id"));
								break;
							}
						}
					}
				}else if(i==12){//学校
					if(schoolId==null || "".equals(schoolId)){//
						String schoolName=arr[i];
						if(schoolName!=null && !"".equals(schoolName)){//学校
							Map<String,Object> info=new HashMap<String, Object>();
							info.put("name", schoolName.trim());
//							info.put("type", "2");
							info= this.getBaseDao().loadEntity("unitInfo.findOne", info);
							if(info!=null){
								map.put("schoolId", info.get("id"));
							}else{
								sb.append(map.get("name")+"老师数据中附属学校有错，因此未能添加该条数据。");
								ok=false;
								break;
							}
						}else{
							sb.append(map.get("name")+"老师数据中附属为空时，只能学校管理员导入，因此未能添加该条数据。");
							ok=false;
							break;
						}
					}else{
						map.put("schoolId", schoolId);
					}
				}else if(i==13){//账号
					String text=arr[i];
					if(text!=null && !"".equals(text)){//账号
						Map<String,Object> info=new HashMap<String, Object>();
						info.put("text", text.trim());
						info= this.getBaseDao().loadEntity("userInfo.findOne", info);
						if(info!=null){
							sb.append(map.get("name")+"老师数据中管理账号已存在，因此未能添加该条数据。");
							ok=false;
							break;
						}
					}else{
						sb.append(map.get("name")+"老师数据中管理账号不能为空，因此未能添加该条数据。");
						ok=false;
						break;
					}
					map.put(header[i], arr[i]);
				}else if(i==14){//密码
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
				res.add(map);
			}
		}
		if(res.size()!=0){
			Map m=new HashMap();
			m.put("list", res);
			this.getBaseDao().insert("teacherInfo.addAll", m);
		}
		return sb.toString();
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("teacherInfo.update", parameter);
	}
	
	/**
	 * 更新数据状态
	 * @param parameter
	 */
	public void updatestat(Map<String,Object> parameter){
		this.getBaseDao().update("teacherInfo.changeStat", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("teacherInfo.delete", parameter);
	}
	
	
	/**
	 * 微信绑定操作
	 * @author zhangjf
	 * @create_time 2016-3-9 上午11:35:42
	 * @param parameter
	 * @return
	 * @throws Exception 
	 */
	public synchronized String bindWeChat(Map<String,Object> parameter) throws Exception{
		
	/*	try {
			Map<String,Object> teacherInfo=this.loadByIdCard(parameter);
			if(teacherInfo==null||teacherInfo.isEmpty()){
				return "未找到对应的用户信息";
			}else{
				//进行绑定操作
				this.getBaseDao().update("teacherInfo.bindWeChat", parameter);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}*/
		
		List<Map<String,Object>> infos=this.loadInfoByIdCard(parameter);
		if(infos==null||infos.isEmpty()){
			return "未找到对应的用户信息";
		}else{
			Map<String,Object> params=null;
			for (Map<String, Object> info : infos) {
				params=new HashMap<String, Object>();
				params.put("openid", parameter.get("openid"));
				params.put("idcard", parameter.get("idcard"));
				params.put("type", info.get("type"));
				this.getBaseDao().update("teacherInfo.bindWeChat", params);
			}
		}
		
		return "";
	}
	
	
}
