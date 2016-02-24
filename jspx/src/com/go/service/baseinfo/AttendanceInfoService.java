package com.go.service.baseinfo;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.go.common.util.ExtendDate;
import com.go.common.util.SqlUtil;
import com.go.service.base.BaseService;
/**
 * 考勤信息Service
 * @author Administrator
 *
 */
@Service
public class AttendanceInfoService extends BaseService {

	@Autowired
	private TeacherInfoService teacherInfoService;
	@Autowired
	private ArtificialAttendanceService artificalAttendanceService;
	
	/**
	 * 分页查找数据
	 * @param parameter
	 * @return
	 * @throws Exception 
	 */
	public  JSONObject  findPageBean(Map<String,Object> parameter) throws Exception{
		if(parameter.containsKey("classId")){
			List<Map<String,Object>> list=this.getBaseDao().findList("classTime.findTimeByClass", parameter);
			for(Map<String,Object> map:list){
				map.put("classDate1", new SimpleDateFormat("yyyy/MM/dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(map.get("classDate").toString())));
			}
			parameter.put("classDateList", list);
		}
		JSONObject res=this.getBaseDao().findListPage("attendanceInfo.findCount", "attendanceInfo.findList", parameter);
		return res;
	}
	/**
	 * 单个上课考勤统计
	 * @author chenhb
	 * @create_time {date} 上午10:41:42
	 * @param parameter
	 * @return
	 * @throws Exception 
	 */
	public List<Map<String,Object>> statistics(Map<String,Object> parameter) throws Exception{
		if(parameter.containsKey("classId")){
			if(parameter.containsKey("classTimeId")){//每次上课考勤
				List<Map<String,Object>> classDateList=this.getBaseDao().findList("classTime.findTimeByClass", parameter);
				parameter.put("classDateList", classDateList);
				List<Map<String,Object>> list=this.getBaseDao().findList("attendanceInfo.statistics", parameter);
				classDateList=this.getBaseDao().findList("classTime.findTimeByClass", parameter);
				if(classDateList==null || classDateList.size()==0){
					return null;
				}
				Map<String,Object> timeSetting=(Map<String, Object>) this.getBaseDao().findOne("timeSetting.findOne");
				if(timeSetting==null){
					return null;
				}
				Map<String,Object> res=new HashMap<String, Object>();
				for(Map<String,Object> map:list){
					String idcard=map.get("idcard").toString();
					List<Map<String,Object>> l=(List<Map<String, Object>>) res.get(idcard);
					if(l==null){
						l=new ArrayList<Map<String,Object>>();
						res.put(idcard, l);
					}else{
						System.out.println(map);
					}
					l.add(map);
				}
				List<Map<String,Object>> resList=new ArrayList<Map<String,Object>>();
				Iterator<String> it=res.keySet().iterator();
				Object isAfterClassPunch=timeSetting.get("isAfterClassPunch");
				if(isAfterClassPunch!=null && "1".equals(isAfterClassPunch)){//下班要打卡
					while(it.hasNext()){
						String idcard=it.next();
						List<Map<String,Object>> l=(List<Map<String, Object>>) res.get(idcard);
						if(l!=null && l.size()>0){
							if( l.size()==1){
								Map<String,Object> m=l.get(0);
								Object attendanceDate=m.get("attendanceDate");
								if(attendanceDate==null || "".equals(attendanceDate)){
									m.put("classStatus", "旷课");
									resList.add(m);
									continue;
								}
								Map<String,Object> classDate=classDateList.get(0);
								String beginD=classDate.get("classDate").toString().replaceAll("-", "/")+" "+(calculateDate(classDate.get("beginTime").toString(), timeSetting.get("afterClass").toString(),"+"))+":00";
								if(compareDate(beginD, attendanceDate.toString())){//准到
									m.put("classStatus", "准到");
								}else{
									beginD=classDate.get("classDate").toString().replaceAll("-", "/")+" "+(calculateDate(classDate.get("beginTime").toString(), timeSetting.get("absenteeism").toString(),"+"))+":00";//超过打卡为旷课
									if(compareDate(attendanceDate.toString(), beginD)){//旷课
										m.put("classStatus", "旷课");
									}else{
										m.put("classStatus", "迟到");
									}
								}
								m.put("classFinishStatus", "早退");
								resList.add(m);
							}else{
								Map<String,Object> classDate=classDateList.get(0);
								Map<String,Object> m1=l.get(0);
								Object attendanceDate=m1.get("attendanceDate");
								String beginD=classDate.get("classDate").toString().replaceAll("-", "/")+" "+(calculateDate(classDate.get("beginTime").toString(), timeSetting.get("afterClass").toString(),"+"))+":00";
								if(compareDate(beginD, attendanceDate.toString())){//准到
									m1.put("classStatus", "准到");
								}else{
									beginD=classDate.get("classDate").toString().replaceAll("-", "/")+" "+(calculateDate(classDate.get("beginTime").toString(), timeSetting.get("absenteeism").toString(),"+"))+":00";//超过打卡为旷课
									if(compareDate(attendanceDate.toString(), beginD)){//旷课
										m1.put("classStatus", "旷课");
									}else{
										m1.put("classStatus", "迟到");
									}
								}
								
								
								Map<String,Object> m2=l.get(l.size()-1);
								attendanceDate=m2.get("attendanceDate");
								beginD=classDate.get("classDate").toString().replaceAll("-", "/")+" "+(calculateDate(classDate.get("endTime").toString(), timeSetting.get("beforeFinishClass").toString(),"-"))+":59";//之后打卡为准退
								if(compareDate(attendanceDate.toString(), beginD)){//准到
									m1.put("classFinishStatus", "准退");
								}else{
									m1.put("classFinishStatus", "早退");
								}
								resList.add(m1);
							}
						}
					}
				}else{//允许下班不打卡
					while(it.hasNext()){
						String idcard=it.next();
						List<Map<String,Object>> l=(List<Map<String, Object>>) res.get(idcard);
						if(l!=null && l.size()>0){
							Map<String,Object> m=l.get(0);
							Object attendanceDate=m.get("attendanceDate");
							if(attendanceDate==null || "".equals(attendanceDate)){
								m.put("classStatus", "旷课");
								resList.add(m);
								continue;
							}
							Map<String,Object> classDate=classDateList.get(0);
							String beginD=classDate.get("classDate").toString().replaceAll("-", "/")+" "+(calculateDate(classDate.get("beginTime").toString(), timeSetting.get("afterClass").toString(),"+"))+":00";//在之前打卡为准到
							if(compareDate(beginD,attendanceDate.toString())){//准到
								m.put("classStatus", "准到");
							}else{
								beginD=classDate.get("classDate").toString().replaceAll("-", "/")+" "+(calculateDate(classDate.get("beginTime").toString(), timeSetting.get("absenteeism").toString(),"+"))+":00";//超过打卡为旷课
								if(compareDate(attendanceDate.toString(), beginD)){//旷课
									m.put("classStatus", "旷课");
								}else{
									m.put("classStatus", "迟到");
								}
							}
							m.put("classFinishStatus", "准退");
							resList.add(m);
						}
					}
				}
				return resList;
			}
		}
		return null;
	}
	
	public List<Map<String,Object>> summaryStatistics(Map<String,Object> parameter) throws Exception{
		if(parameter.containsKey("classId")){
			List<Map<String,Object>> classDateList=this.getBaseDao().findList("classTime.findTimeByClass", parameter);
			List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
			for(Map<String,Object> classDate:classDateList){
				List<Map<String,Object>> l=new ArrayList<Map<String,Object>>();
				l.add(classDate);
				parameter.put("classDateList", l);
				list.addAll(this.getBaseDao().findList("attendanceInfo.statistics", parameter));
			}
			classDateList=this.getBaseDao().findList("classTime.findTimeByClass", parameter);
			if(classDateList==null || classDateList.size()==0){
				return null;
			}
			Map<String,Object> timeSetting=(Map<String, Object>) this.getBaseDao().findOne("timeSetting.findOne");
			if(timeSetting==null){
				return null;
			}
			Map<String,Object> res=new HashMap<String, Object>();
			for(Map<String,Object> map:list){
				String idcard=map.get("idcard").toString();
				Map<String,Object> m=(Map<String, Object>) res.get(idcard);
				if(m==null){
					m=new HashMap<String, Object>(map);
					m.put("map", new HashMap<String,Object>());
					m.put("total", 0);
					m.put("zd", 0);
					m.put("cd", 0);
					m.put("kk", 0);
					m.put("zaot", 0);
					m.put("zt", 0);
					res.put(idcard,m);
				}
				String beginDate=map.get("beginDate").toString();
				Map<String,Object> mmm=(Map<String, Object>) m.get("map");
				List<Map<String,Object>> l=(List<Map<String, Object>>)mmm.get(beginDate);
				if(l==null){
					l=new ArrayList<Map<String,Object>>();
					mmm.put(beginDate, l);
				}else{
					System.out.println(map);
				}
				l.add(map);
			}
			
			List<Map<String,Object>> resList=new ArrayList<Map<String,Object>>();
			Iterator<String> it=res.keySet().iterator();
			Object isAfterClassPunch=timeSetting.get("isAfterClassPunch");
			if(isAfterClassPunch!=null && "1".equals(isAfterClassPunch)){//下班要打卡
				while(it.hasNext()){
					String idcard=it.next();
					Map<String,Object> mm=(Map<String, Object>) res.get(idcard);
					if(mm!=null && mm.size()>0){
						Map<String,Object> mmm=(Map<String, Object>) mm.get("map");
						Iterator<String> itt=mmm.keySet().iterator();
						mm.put("total", mmm.size());
						while(itt.hasNext()){
							String beginDate=itt.next();
							List<Map<String,Object>> l=(List<Map<String, Object>>) mmm.get(beginDate);
							if(l!=null && l.size()>0){
								if(l.size()==1){
									Map<String,Object> m=l.get(0);
									Object attendanceDate=m.get("attendanceDate");
									if(attendanceDate==null || "".equals(attendanceDate)){
										mm=tj(mm, "kk");
										continue;
									}
									
									Map<String,Object> classDate=classDateList.get(0);
									String beginD=classDate.get("classDate").toString().replaceAll("-", "/")+" "+(calculateDate(classDate.get("beginTime").toString(), timeSetting.get("afterClass").toString(),"+"))+":00";//在之前打卡为准到
									if(compareDate(beginD,attendanceDate.toString())){//准到
										mm=tj(mm, "zd");
									}else{
										beginD=classDate.get("classDate").toString().replaceAll("-", "/")+" "+(calculateDate(classDate.get("beginTime").toString(), timeSetting.get("absenteeism").toString(),"+"))+":00";//超过打卡为旷课
										if(compareDate(attendanceDate.toString(), beginD)){//旷课
											mm=tj(mm, "kk");
										}else{
											mm=tj(mm, "cd");
										}
									}
									mm=tj(mm, "zt");
								}else{//多次打卡
									Map<String,Object> m=l.get(0);
									Object attendanceDate=m.get("attendanceDate");
									if(attendanceDate==null || "".equals(attendanceDate)){
										mm=tj(mm, "kk");
										continue;
									}
									
									Map<String,Object> classDate=classDateList.get(0);
									String beginD=classDate.get("classDate").toString().replaceAll("-", "/")+" "+(calculateDate(classDate.get("beginTime").toString(), timeSetting.get("afterClass").toString(),"+"))+":00";//在之前打卡为准到
									if(compareDate(beginD,attendanceDate.toString())){//准到
										mm=tj(mm, "zd");
									}else{
										beginD=classDate.get("classDate").toString().replaceAll("-", "/")+" "+(calculateDate(classDate.get("beginTime").toString(), timeSetting.get("absenteeism").toString(),"+"))+":00";//超过打卡为旷课
										if(compareDate(attendanceDate.toString(), beginD)){//旷课
											mm=tj(mm, "kk");
										}else{
											mm=tj(mm, "cd");
										}
									}
									
									Map<String,Object> m2=l.get(l.size()-1);
									attendanceDate=m2.get("attendanceDate");
									beginD=classDate.get("classDate").toString().replaceAll("-", "/")+" "+(calculateDate(classDate.get("endTime").toString(), timeSetting.get("beforeFinishClass").toString(),"-"))+":59";//之后打卡为准退
									if(compareDate(attendanceDate.toString(), beginD)){//准到
										mm=tj(mm, "zt");
									}else{
										mm=tj(mm, "zaot");
									}
								}
							}else{
								mm=tj(mm, "kk");
							}
						}
					}
					resList.add(mm);
				}
			}else{//允许下班不打卡
				while(it.hasNext()){
					String idcard=it.next();
					Map<String,Object> mm=(Map<String, Object>) res.get(idcard);
					if(mm!=null && mm.size()>0){
						Map<String,Object> mmm=(Map<String, Object>) mm.get("map");
						Iterator<String> itt=mmm.keySet().iterator();
						while(itt.hasNext()){
							String beginDate=itt.next();
							List<Map<String,Object>> l=(List<Map<String, Object>>) mmm.get(beginDate);
							if(l!=null && l.size()>0){
								mm.put("total", mmm.size());
								Map<String,Object> m=l.get(0);
								Object attendanceDate=m.get("attendanceDate");
								if(attendanceDate==null || "".equals(attendanceDate)){
									mm=tj(mm, "kk");
									continue;
								}
								
								Map<String,Object> classDate=classDateList.get(0);
								String beginD=classDate.get("classDate").toString().replaceAll("-", "/")+" "+(calculateDate(classDate.get("beginTime").toString(), timeSetting.get("afterClass").toString(),"+"))+":00";//在之前打卡为准到
								if(compareDate(beginD,attendanceDate.toString())){//准到
									mm=tj(mm, "zd");
								}else{
									beginD=classDate.get("classDate").toString().replaceAll("-", "/")+" "+(calculateDate(classDate.get("beginTime").toString(), timeSetting.get("absenteeism").toString(),"+"))+":00";//超过打卡为旷课
									if(compareDate(attendanceDate.toString(), beginD)){//旷课
										mm=tj(mm, "kk");
									}else{
										mm=tj(mm, "cd");
									}
								}
								mm=tj(mm, "zt");
							}else{
								mm=tj(mm, "kk");
							}
						}
					}
					resList.add(mm);
				}
			}
			return resList;
		}
		return null;
	}
	private Map<String,Object> tj(Map<String,Object> map,String key){
		Integer i=(Integer) map.get(key);
		if(i==null){
			i=0;
		}
		i++;
		map.put(key, i);
		return map;
	}
	/**
	 * yyyy/MM/dd HH:mm:ss 格式日期比较大小
	 * @author chenhb
	 * @create_time  2015-9-25 上午9:08:33
	 * @param d1
	 * @param d2
	 * @return
	 * @throws Exception
	 */
	private boolean compareDate(String d1,String d2) throws Exception{
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Long l1=sdf.parse(d1).getTime();
		Long l2=sdf.parse(d2).getTime();
		return l1>=l2;
	}
	/**
	 * 时分计算
	 * @author chenhb
	 * @create_time  2015-9-25 上午9:07:50
	 * @param d1
	 * @param d2
	 * @param type
	 * @return
	 * @throws Exception
	 */
	private String calculateDate(String d1,String d2,String type) throws Exception{
		SimpleDateFormat sdf=new SimpleDateFormat("HH:mm");
		String res="";
		if("+".equals(type)){
			res=sdf.format(new Date(sdf.parse(d1).getTime()+(Integer.parseInt(d2)*1000*60)));
		}else if("-".equals(type)){
			res=sdf.format(new Date(sdf.parse(d1).getTime()-(Integer.parseInt(d2)*1000*60)));
		}
		return res;
	}
	public Map<String,Object> statisticsDetail(Map<String,Object> parameter) throws Exception{
		List<Map<String,Object>> timeList=timeList(parameter);//要考勤的时间集合  
		parameter.put("timeList", timeList);
		parameter.put("total", timeList.size());
		List<Map<String,Object>> resList=this.getBaseDao().findList("attendanceInfo.statisticsZDY", parameter);
		if(resList!=null && resList.size()>0){
			Map<String,Object> res=resList.get(0);
			List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
			for(Map<String,Object> time:timeList){
				List<Map<String,Object>> ll=new ArrayList<Map<String,Object>>();
				ll.add(time);
				parameter.put("timeList", ll);
				parameter.put("total", ll.size());
				List<Map<String,Object>> l=this.getBaseDao().findList("attendanceInfo.statisticsZDY", parameter);
				if(l!=null && l.size()>0){
					Map<String,Object> m=l.get(0);
					m.put("attendanceTime", time.get("time"));
					list.add(m);
				}
			}
			res.put("list", list);
			return res;
		}
		return null;
	}
	/**
	 * 自定义统计
	 * @author chenhb
	 * @create_time  2015-9-25 上午9:17:17
	 * @param parameter
	 * @return
	 * @throws Exception 
	 */
	public List<Map<String,Object>> statisticsZDY(Map<String,Object> parameter) throws Exception{
		List<Map<String,Object>> timeList=timeList(parameter);//要考勤的时间集合
		parameter.put("timeList", timeList);
		parameter.put("total", timeList.size());
		List<Map<String,Object>> resList=this.getBaseDao().findList("attendanceInfo.statisticsZDY", parameter);
		return resList;
	}
	/**
	 * 考勤的时间集合
	 * @author chenhb
	 * @create_time  2015-9-28 下午4:42:52
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	private List<Map<String,Object>> timeList(Map<String,Object> parameter) throws Exception {
		List<Map<String,Object>> timeList=new ArrayList<Map<String,Object>>();//要考勤的时间集合
		@SuppressWarnings("unchecked")
		Map<String,Object> timeSetting=(Map<String, Object>) this.getBaseDao().findOne("timeSetting.findOne");
		if(parameter.containsKey("classTimeId")){//查询一个上课时间考勤统计
			timeList.addAll(getTimeByClassTimeId(parameter.get("classTimeId"), timeSetting,parameter));//该上课时间需要考勤的时间
		}else if(parameter.containsKey("classId")){//查询一个班级的考勤记录
			List<Map<String,Object>> classTimeList=this.getBaseDao().findList("classTime.findAll", parameter);
			for(Map<String,Object> map:classTimeList){
				timeList.addAll(getTimeByClassTimeId(map.get("id"), timeSetting,parameter));//该上课时间需要考勤的时间
			}
		}else{//查询所有考勤
			List<Map<String,Object>> classTimeList=this.getBaseDao().findList("classTime.findAll", parameter);
			for(Map<String,Object> map:classTimeList){
				timeList.addAll(getTimeByClassTimeId(map.get("id"), timeSetting,parameter));//该上课时间需要考勤的时间
			}
		}
		return timeList;
	}
	
	/**
	 * 通过上课时间查询这堂课要考勤多少次每次时间。
	 * @author chenhb
	 * @create_time  2015-9-25 上午9:35:20
	 * @param classTimeId
	 * @param timeSetting
	 * @return
	 * @throws Exception 
	 */
	private List<Map<String,Object>> getTimeByClassTimeId(Object classTimeId,Map<String,Object> timeSetting,Map<String,Object> n_parameter) throws Exception{
		List<Map<String,Object>> timeList=new ArrayList<Map<String,Object>>();//要考勤的时间集合
		Map<String,Object> parameter=new HashMap<String, Object>();
		parameter.put("classTimeId", classTimeId);
		Map<String,Object> map=new HashMap<String, Object>();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		List<Map<String,Object>> attendanceTimeList=this.getBaseDao().findList("attendanceTime.findAll", parameter);
		if(attendanceTimeList==null || attendanceTimeList.size()==0){
			Map<String,Object> classTime=new HashMap<String, Object>();//上课时间
			classTime.put("id", parameter.get("classTimeId"));
			classTime=this.getBaseDao().loadEntity("classTime.load", classTime);
			Object isAfterClassPunch=timeSetting.get("isAfterClassPunch");
			if(isAfterClassPunch!=null && "1".equals(isAfterClassPunch)){//下班要打卡
				map=new HashMap<String, Object>();
				map.put("time", sdf.format(ExtendDate.getYMD_h_m_s1(classTime.get("classDate")+" "+classTime.get("beginTime")+":00")));
				map.put("beforeAttendance", timeSetting.get("beforeClass"));
				map.put("afterAttendance", timeSetting.get("afterClass"));
				map.put("absenteeism", timeSetting.get("absenteeism"));
				map.put("type", "1");
				timeList.add(map);//上课时间
				
				map=new HashMap<String, Object>();
//				map.put("time", classTime.get("classDate")+" "+classTime.get("endTime")+":59");
				map.put("time", sdf.format(ExtendDate.getYMD_h_m_s1(classTime.get("classDate")+" "+classTime.get("endTime")+":59")));
				map.put("beforeAttendance", timeSetting.get("beforeFinishClass"));
				map.put("afterAttendance", timeSetting.get("afterFinishClass"));
				map.put("absenteeism", timeSetting.get("absenteeism"));
				map.put("type", "2");
				timeList.add(map);//下课时间
			}else{
				map=new HashMap<String, Object>();
//				map.put("time", classTime.get("classDate")+" "+classTime.get("beginTime")+":00");
				map.put("time", sdf.format(ExtendDate.getYMD_h_m_s1(classTime.get("classDate")+" "+classTime.get("beginTime")+":00")));
				map.put("beforeAttendance", timeSetting.get("beforeClass"));
				map.put("afterAttendance", timeSetting.get("afterClass"));
				map.put("absenteeism", timeSetting.get("absenteeism"));
				map.put("type", "1");
				timeList.add(map);//上课时间
			}
		}else{
			for(Map<String,Object> attendanceTime:attendanceTimeList){
				map=new HashMap<String, Object>();
//				map.put("time", attendanceTime.get("attendanceTime"));
				map.put("time", sdf.format(ExtendDate.getYMD_h_m_s1(attendanceTime.get("attendanceTime").toString())));
				map.put("beforeAttendance", attendanceTime.get("beforeAttendance"));
				map.put("afterAttendance", attendanceTime.get("afterAttendance"));
				map.put("absenteeism", attendanceTime.get("absenteeism"));
				map.put("type", attendanceTime.get("type"));
				timeList.add(map);//上课时间
			}
		}
		return timeList;
	}
	/**
	 * 添加数据
	 * @param parameter
	 * @return
	 */
	public  int  add(Map<String,Object> parameter){
	   return this.getBaseDao().insert1("attendanceInfo.add", parameter);
	}
	/**
	 * 添加多条数据
	 * @author chenhb
	 * @create_time {date} 下午4:28:55
	 * @param parameter
	 */
	public  void  addAll(Map<String,Object> parameter){
	    this.getBaseDao().insert("attendanceInfo.addAll", parameter);
	}
	/**
	 * 通过人工考勤添加
	 * @author chenhb
	 * @create_time {date} 上午8:47:07
	 * @param parameter
	 */
	public  void  addByArtificial(Map<String,Object> parameter){
	    this.getBaseDao().insert("attendanceInfo.addByArtificial", parameter);
	}
	
	/**
	 * 更新数据
	 * @param parameter
	 */
	public  void  update(Map<String,Object> parameter){
		this.getBaseDao().update("attendanceInfo.update", parameter);
	}
	
	/**
	 * 删除数据
	 * @param parameter
	 */
	public  void  delete(List<String> parameter){
		this.getBaseDao().delete("attendanceInfo.delete", parameter);
	}
	
	/**
	 * app签到数据保存
	 * @author zhangjf
	 * @create_time 2015-10-14 下午12:01:30
	 * @param mapList 签到数据
	 * @return
	 */
	public String appAttendance(List<Map<String,Object>> mapList){
		List<Map<String,Object>>artificialList=new ArrayList<Map<String,Object>>();//存储手动签到数据
		List<Map<String,Object>> artificalAddList=new ArrayList<Map<String,Object>>();//添加批量手动数据列表
		if(mapList!=null&&mapList.size()>0){
			String currentTime=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date());
			for (Map<String, Object> map : mapList) {
				/**
				 * zhangjf 2015-10-14判断签到类型 start
				 */
					map.put("createdate", currentTime);
					String type=map.containsKey("type")?map.get("type").toString():"";
					if("2".equals(type)){//手动签到数据
						artificialList.add(map);
					}
				/**
				 * zhangjf 2015-10-14判断签到类型end
				 */	
			}
			Map<String,Object> addMap=new HashMap<String, Object>();
			if(artificialList==null||artificialList.isEmpty()){//刷卡签到数据保存
				addMap.put("list", mapList);
				this.addAll(addMap);
				return "";
			}else{//手动签到数据保存及处理
				mapList.removeAll(artificialList);
				//第一步:保存刷卡签到数据
				if(mapList!=null&&!mapList.isEmpty()){
					addMap.put("list", mapList);
					addAll(addMap);
				}
				//第二步:处理手动签到数据
				Integer attendanceId=null;
				for (Map<String, Object> map : artificialList) {
					
					//1.添加手动考勤数据
					Map<String,Object> teacherMap=teacherInfoService.loadByIdCard(map);
					if(teacherMap==null){
						throw new RuntimeException("未找到对应的学生信息");
					}
					String studentId=teacherMap.get("id").toString();
					//2.添加考勤数据
					map.put("studentId", studentId);
					attendanceId=add(map);//添加考勤数据
					//3.添加手动考勤数据
					Map<String,Object> artificialMap=new HashMap<String, Object>();
					String date=map.get("attendanceDate").toString().replaceAll("/", "-");
					artificialMap.put("id", SqlUtil.uuid());
					artificialMap.put("attendanceId", attendanceId);
					artificialMap.put("isDeleted", "0");
					artificialMap.put("categoryId", "2");
					artificialMap.put("studentId",studentId);
					artificialMap.put("date", date);
					artificialMap.put("createdate", ExtendDate.getYMD_h_m_s(new Date()));
					//attendanceInfoService.addByArtificial(artificialMap);
					artificalAddList.add(artificialMap);
				}
				
				if(artificalAddList!=null&&artificalAddList.size()>0){
					addMap=new HashMap<String, Object>();
					addMap.put("list", artificalAddList);
					artificalAttendanceService.addAll(addMap);
				}
				return "";

			}
			
		}else{
			return "签到数据异常！";
		}
			
	}
	
}
