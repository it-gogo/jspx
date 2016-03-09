package com.go.common.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;
import org.apache.commons.lang3.StringUtils;

/**
 * 日期辅助类
 * @author zhangjf
 * @create_time 2015-8-12 上午9:48:27
 */
public class DateUtil {
	/**格式化 年 月 日 时 分 秒 */
	public static String FORMATE_TIME="yyyy-MM-dd HH:mm:ss";
	/**格式化  年 月 日**/
	public static String FORMATE_DATE="yyyy-MM-dd";
	
	public static String FORMATE_DATE_HM="yyyy-MM-dd HH:mm";
	
	public static String AREA_MONTH = "MM";
	
	public static String YEAR="yyyy";
	
	/**
	 * 获取当前时间
	 * @author zhangjf
	 * @create_time 2015-8-12 上午9:50:03
	 * @return
	 */
	public static String getCurrentTime(){
		return new SimpleDateFormat(FORMATE_TIME).format(new Date());
	}
	
	/**
	 * 获取当前时间
	 * @author zhangjf
	 * @create_time 2016-1-4 上午10:26:52
	 * @return
	 */
	public static String getCurrentTimeing(){
		return new SimpleDateFormat("HH:mm").format(new Date());
	}
	
	/**
	 * 获取当前年份
	 * @author zhangjf
	 * @create_time 2015-11-10 上午10:49:56
	 * @return
	 */
	public static String getCurrentYear(){
		return new SimpleDateFormat(YEAR).format(new Date());
	}
	
	/**
	 * 根据日期格式进行格式
	 * @author zhangjf
	 * @create_time 2015-12-10 下午2:24:20
	 * @param date
	 * @param format
	 * @return
	 */
	public static String formatDate(Date date,String format){
		return new SimpleDateFormat(format).format(date);
	}
	
	/**
	 * 比较日期字符串
	 * @author zhangjf
	 * @create_time 2015-9-8 下午5:07:04
	 * @param beginDate
	 * @param endDate
	 * @param format
	 * @return
	 */
	public static boolean compareDate(String beginDate,String endDate,String format){
		Date d1=getDateByString(beginDate, format);
		Date d2=getDateByString(endDate, format);
		return compareDate(d1, d2);
	}
	
	/**
	 * 获取日期
	 * @author zhangjf
	 * @create_time 2015-9-8 下午5:07:23
	 * @param str
	 * @param format
	 * @return
	 */
	public static Date getDateByString(String str,String format){
		SimpleDateFormat sf=new SimpleDateFormat(format);
		Date date=null;
		try {
			date=sf.parse(str);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return date;
	}
	
	/**
	 * 比较日期
	 * @author zhangjf
	 * @create_time 2015-9-8 下午5:07:46
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public static boolean compareDate(Date beginDate,Date endDate){
		return beginDate.getTime()<endDate.getTime();
	}
	
	/**
	 * 获取当前日期
	 * @author zhangjf
	 * @create_time 2015-8-12 上午9:51:12
	 * @return
	 */
	public static String getCurrentDate(){
		return new SimpleDateFormat(FORMATE_DATE).format(new Date());
	}
	
	/**
	 * 计算指定时间加上指定时间区域数量后的结果
	 * @author zhangjf
	 * @create_time 2015-8-12 上午9:52:03
	 * @param date 指定时间
	 * @param part 计算部分
	 * @param num 计算数量
	 * @param ret_format 返回结果格式
	 * @return 计算后的时间
	 */
	public static String getDateStamp(String date,String part,int num,String ret_format){
		Calendar cld = Calendar.getInstance();
		try {
			cld.setTime(new SimpleDateFormat(FORMATE_TIME).parse(date));
			if(StringUtils.isNotBlank(part)){
				if(part.equals("date") || part.equals("dd"))
					cld.add(Calendar.DATE, num);
				else if(part.equals("year") || part.equals("yyyy"))
					cld.add(Calendar.YEAR, num);
				else if(part.equals("month") || part.equals("MM"))
					cld.add(Calendar.MONTH, num);
				else if(part.equals("hour") || part.equals("HH"))
					cld.add(Calendar.HOUR, num);
				else if(part.equals("minute") || part.equals("mm"))
					cld.add(Calendar.MINUTE, num);
				else if(part.equals("second") || part.equals("ss"))
					cld.add(Calendar.SECOND, num);
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if(StringUtils.isNotBlank(ret_format)){
			return new SimpleDateFormat(ret_format).format(cld.getTime());
		}else{
			return new SimpleDateFormat(FORMATE_TIME).format(cld.getTime());
		}
	}
	
	/**
	 * 获取时间相减差距
	 * @author zhangjf
	 * @create_time 2015-8-12 上午10:10:39
	 * @param time1
	 * @param time2
	 * @param part
	 * @return
	 */
	public static int getTimeStamp(String time1,String time2,String part){
		TimeZone.setDefault(TimeZone.getTimeZone("GMT+8"));
		Calendar cal1 = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();
		try {
			cal1.setTime(new SimpleDateFormat(FORMATE_TIME).parse(time1));
			cal2.setTime(new SimpleDateFormat(FORMATE_TIME).parse(time2));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		long s_times = cal1.getTimeInMillis() - cal2.getTimeInMillis();
		if(StringUtils.isNotBlank(part)){
			if(part.equals("date") || part.equals("dd"))
				return (int)(s_times / 1000 / 60 / 60 / 24);
			else if(part.equals("hour") || part.equals("HH"))
				return (int)(s_times / 1000 / 60 / 60);
			else if(part.equals("minute") || part.equals("mm"))
				return (int)(s_times / 1000 / 60);
			else if(part.equals("second") || part.equals("ss"))
				return (int)(s_times / 1000);
			else if(part.equals(AREA_MONTH)){
				return ((Integer.parseInt(time1.substring(0, 4)) - Integer.parseInt(time2.substring(0, 4))) * 12 + (Integer.parseInt(time1.substring(5, 7)) - Integer.parseInt(time2.substring(5, 7))));
			}
		}else{
			throw new RuntimeException("获取时间差部分异常");
		}
		return 0;
	}
	
	/**
	 * 获取当前月最后一天
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:49:10
	 * @param date_time
	 * @param rs_format
	 * @return
	 */
	public static String getLastDayOfMonth(String date_time,String rs_format){
		if(StringUtils.isBlank(rs_format)){
			rs_format = FORMATE_TIME;
		}
		Calendar cld = Calendar.getInstance();
		try {
		cld.setTime(new SimpleDateFormat(FORMATE_TIME).parse(date_time));
		cld.set(Calendar.DAY_OF_MONTH, cld.getActualMaximum(Calendar.DAY_OF_MONTH));
		cld.set(Calendar.HOUR_OF_DAY, 23);
		cld.set(Calendar.MINUTE, 59);
		cld.set(Calendar.SECOND, 59);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return new SimpleDateFormat(rs_format).format(cld.getTime());
	}
	
	/**
	 * 获取该月的第一天
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:50:24
	 * @param date_time
	 * @param rs_format
	 * @return
	 */
	public static String getFirstDayOfMonth(String date_time,String rs_format){
		if(StringUtils.isBlank(rs_format)){
			rs_format = FORMATE_TIME;
		}
		Calendar cld = Calendar.getInstance();
		try {
			cld.setTime(new SimpleDateFormat(FORMATE_TIME).parse(date_time));
			cld.set(Calendar.DAY_OF_MONTH, cld.getActualMinimum(Calendar.DAY_OF_MONTH));
			cld.set(Calendar.HOUR_OF_DAY, 0);
			cld.set(Calendar.MINUTE, 0);
			cld.set(Calendar.SECOND, 0);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return new SimpleDateFormat(rs_format).format(cld.getTime());
	}
	
	/**
	 * 获得指定日期的前一天
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:51:35
	 * @param specifiedDay
	 * @return
	 */
	public static String getSpecifiedDayBefore(String specifiedDay) {
		String dayBefore = "";
		try {
			if(StringUtils.isNotBlank(specifiedDay)){
				SimpleDateFormat dateFormat = new SimpleDateFormat(FORMATE_DATE);
				Calendar c = Calendar.getInstance();
				Date date = dateFormat.parse(specifiedDay);
	
				c.setTime(date);
				int day = c.get(Calendar.DATE);
				c.set(Calendar.DATE, day - 1);
				int hour = c.get(Calendar.HOUR);
				c.set(Calendar.HOUR, hour);
				dayBefore = dateFormat.format(c.getTime());
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return dayBefore;
	}
	
	/**
	 * 获得指定日期的前n天
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:52:01
	 * @param specifiedDay
	 * @param n
	 * @return
	 */
	public static String getSpecifiedDayBefore(String specifiedDay, int n) {
		String dayBefore = "";
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat(FORMATE_DATE);
			Calendar c = Calendar.getInstance();
			Date date = dateFormat.parse(specifiedDay);

			c.setTime(date);
			int day = c.get(Calendar.DATE);
			c.set(Calendar.DATE, day - n);
			int hour = c.get(Calendar.HOUR);
			c.set(Calendar.HOUR, hour);

			dayBefore = dateFormat.format(c.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return dayBefore;
	}
	
	/**
	 * 获得指定日期的后一天
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:52:25
	 * @param specifiedDay
	 * @return
	 */
	public static String getSpecifiedDayAfter(String specifiedDay) {
		String dayAfter = "";
		try {
			Calendar c = Calendar.getInstance();
			Date date = null;
			date = new SimpleDateFormat("yy-MM-dd").parse(specifiedDay);

			c.setTime(date);
			int day = c.get(Calendar.DATE);
			c.set(Calendar.DATE, day + 1);
			dayAfter = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return dayAfter;
	}
	
	/**
	 * 获得指定日期的后n天
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:52:48
	 * @param specifiedDay
	 * @param n
	 * @return
	 */
	public static String getSpecifiedDayAfter(String specifiedDay, int n) {
		String dayAfter = "";
		try {
			Calendar c = Calendar.getInstance();
			Date date = null;

			date = new SimpleDateFormat("yy-MM-dd").parse(specifiedDay);

			c.setTime(date);
			int day = c.get(Calendar.DATE);
			c.set(Calendar.DATE, day + n);

			dayAfter = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return dayAfter;
	}
	
	/**
	 * 获得某年某月的第几天
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:54:06
	 * @param year
	 * @param month
	 * @param day
	 * @return
	 */
	public static String getMonthDay(int year, int month, int day) {
		Calendar c = Calendar.getInstance();
		c.set(Calendar.YEAR, year);
		c.set(Calendar.MONTH, month - 1);
		c.set(Calendar.DAY_OF_MONTH, day);
		SimpleDateFormat dateFormat = new SimpleDateFormat(FORMATE_DATE);
		return dateFormat.format(c.getTime());
	}
	/**
	 * 获得年份
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:54:47
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static int getYear(String date) throws ParseException {
		date = parseDate(date);
		SimpleDateFormat dateFormat = new SimpleDateFormat(FORMATE_DATE);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dateFormat.parse(date));
		return calendar.get(Calendar.YEAR);
	}
	/**
	 * 获取月份
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:55:40
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static int getMonth(String date) throws ParseException {
		date = parseDate(date);
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat(FORMATE_DATE);
		calendar.setTime(dateFormat.parse(date));
		return (calendar.get(Calendar.MONTH) + 1);
	}
	
	/**
	 * 获取日期
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:56:12
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static int getDay(String date) throws ParseException {
		date = parseDate(date);
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat(FORMATE_DATE);
		calendar.setTime(dateFormat.parse(date));
		return calendar.get(Calendar.DAY_OF_MONTH);
	}
	
	/**
	 * 获取月份的开始日期
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:56:32
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static String getMinMonthDate(String date) throws ParseException {
		date = parseDate(date);
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat(FORMATE_DATE);
		calendar.setTime(dateFormat.parse(date));
		calendar.set(Calendar.DAY_OF_MONTH,
				calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
		return dateFormat.format(calendar.getTime()) + " 00:00:00";
	}
	
	/**
	 * 获取月份最后日期
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:57:00
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static String getMaxMonthDate(String date) throws ParseException {
		date = parseDate(date);
		SimpleDateFormat dateFormat = new SimpleDateFormat(FORMATE_DATE);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dateFormat.parse(date));
		calendar.set(Calendar.DAY_OF_MONTH,
				calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
		return dateFormat.format(calendar.getTime()) + " 23:59:59";
	}
	
	/**
	 * 获取指定月份开始日期
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:57:50
	 * @param date
	 * @param month
	 * @return
	 * @throws ParseException
	 */
	public static String getMinMonthDateByMonth(String date, Integer month)
			throws ParseException {
		SimpleDateFormat dateFormat = new SimpleDateFormat(FORMATE_DATE);
		date = parseDate(date);
		String m = date.substring(4, 7);
		date = date.replaceFirst(m, "-" + month);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dateFormat.parse(date));
		calendar.set(Calendar.DAY_OF_MONTH,
				calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
		return dateFormat.format(calendar.getTime());
	}
	
	/**
	 * 获取指定月份结束日期
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:58:10
	 * @param date
	 * @param month
	 * @return
	 * @throws ParseException
	 */
	public static String getMaxMonthDateByMonth(String date, Integer month)
			throws ParseException {
		date = parseDate(date);
		SimpleDateFormat dateFormat = new SimpleDateFormat(FORMATE_DATE);
		String m = date.substring(4, 7);
		date = date.replaceFirst(m, "-" + month);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dateFormat.parse(date));
		calendar.set(Calendar.DAY_OF_MONTH,
				calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
		return dateFormat.format(calendar.getTime());
	}
	
	/**
	 * 获取下个月的开始日期
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:58:44
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static String getNextMinMonthDate(String date) throws ParseException {
		date = parseDate(date);
		String m = date.substring(5, 7);
		date = date.replaceFirst("-" + m, "-" + (Integer.valueOf(m) + 1));
		SimpleDateFormat dateFormat = new SimpleDateFormat(FORMATE_DATE);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dateFormat.parse(date));
		calendar.set(Calendar.DAY_OF_MONTH,
				calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
		return dateFormat.format(calendar.getTime());
	}
	
	/**
	 * 获取下个月最后日期
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:59:09
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static String getNextMaxMonthDate(String date) throws ParseException {
		date = parseDate(date);
		SimpleDateFormat dateFormat = new SimpleDateFormat(FORMATE_DATE);
		String m = date.substring(5, 7);
		date = date.replaceFirst("-" + m, "-" + (Integer.valueOf(m) + 1));
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dateFormat.parse(date));
		calendar.set(Calendar.DAY_OF_MONTH,
				calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
		return dateFormat.format(calendar.getTime());
	}
	
	/**
	 * 转换不同格式的日期
	 * @author zhangjf
	 * @create_time 2015-12-7 下午8:01:24
	 * @param oldDate
	 * @param oldFormat
	 * @param newFormat
	 * @return
	 */
	public static String translateFormat(String oldDate,String oldFormat,String newFormat){
		SimpleDateFormat sdf = new SimpleDateFormat(oldFormat);
        Date date;
        String newDate;
		try {
			date = sdf.parse(oldDate);
			newDate = new SimpleDateFormat(newFormat).format(date);
		} catch (ParseException e) {
			newDate = oldDate;
		}
        
        return newDate;
	}
	/**
	 * 获取时间段内的月份列表
	 * @author zhangjf
	 * @create_time 2015-12-7 下午8:01:51
	 * @param fromDate
	 * @param toDate
	 * @return 时间间隔内的月份列表格式例如：2013-09
	 */
	public static List<String> getMonthsFromTo(String fromDate,String toDate){
		List<String> listStr = null;
		try {
			int fromYear = Integer.parseInt(fromDate.split("-")[0]);
			int toYear = Integer.parseInt(toDate.split("-")[0]);
			int fromMonth = Integer.parseInt(fromDate.split("-")[1]);
			int toMonth = Integer.parseInt(toDate.split("-")[1]);
			//如果开始日期小于结束日期
			if(fromYear == toYear && fromMonth <= toMonth || fromYear < toYear){
				int months = (toYear - fromYear) * 12 + (toMonth - fromMonth);
				listStr = new ArrayList<String>();
				for(int i = fromMonth; i <= (fromMonth + months); i++){
					listStr.add((fromYear + i / 13) + "-" + (((i - 1) % 12 + 1) < 10 ? ("0" + ((i - 1) % 12 + 1)) : ((i - 1) % 12 + 1)));
				}
			}else{
				throw new RuntimeException("结束日期不能小于开始日期");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return listStr;
	}
	
	/**
	 * 根据开始时间结束时间获取该段时间列表集合
	 * @author zhangjf
	 * @create_time 2015-12-10 下午2:15:32
	 * @param startDate
	 * @param toDate
	 * @return
	 */
	public static List<String> getDatesFromTo(String startDate,String toDate){
		 List<String> dateList=new ArrayList<String>();
		 Date beginDate=getDateByString(startDate,FORMATE_DATE);
		 Date endDate=getDateByString(toDate,FORMATE_DATE);
		 if (compareDate(beginDate, endDate)) {
			dateList.add(startDate);  
	        Calendar calBegin = Calendar.getInstance();  
	        // 使用给定的 Date 设置此 Calendar 的时间    
	        calBegin.setTime(beginDate);  
	        Calendar calEnd = Calendar.getInstance();  
	        // 使用给定的 Date 设置此 Calendar 的时间    
	        calEnd.setTime(endDate);  
	        // 测试此日期是否在指定日期之后    
	        while (endDate.after(calBegin.getTime())) {  
	            // 根据日历的规则，为给定的日历字段添加或减去指定的时间量    
	            calBegin.add(Calendar.DAY_OF_MONTH, 1);  
	            dateList.add(formatDate(calBegin.getTime(), FORMATE_DATE));  
	        }  
	        return dateList;  
		 }else{
			 throw new RuntimeException("结束日期不能小于开始日期");
		 }
	    }  
	
	private static String parseDate(String date) throws ParseException {
		if (StringUtils.isNotBlank(date)) {
			if (date.length() < 8) {
				SimpleDateFormat dateFormat = new SimpleDateFormat(FORMATE_DATE);
				SimpleDateFormat f = new SimpleDateFormat(
						"yyyy-MM");
				date = dateFormat.format(f.parse(date));
			}
		}
		return date;
	}
	
	/**
	 * 获取星期几
	 * @author zhangjf
	 * @create_time 2015-12-8 上午9:55:03
	 * @param date
	 * @return
	 */
	public static String getWeekOfDate(String dateStr) {
		Date date=getDateByString(dateStr, FORMATE_DATE);
	    String[] weekOfDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};        
	    Calendar calendar = Calendar.getInstance();      
	    if(date != null){        
	         calendar.setTime(date);      
	    }        
	    int w = calendar.get(Calendar.DAY_OF_WEEK) - 1;      
	    if (w < 0){        
	        w = 0;      
	    }      
	    return weekOfDays[w];    
	}
	/**
	 * 根据日期获取周几
	 * @author zhangjf
	 * @create_time 2015-12-8 上午9:56:36
	 * @param date
	 * @return
	 */
	public static String getWeekOfDate_(String dateStr) {   
		Date date=getDateByString(dateStr, FORMATE_DATE);
	    String[] weekOfDays = {"周日", "周一", "周二", "周三", "周四", "周五", "周六"};        
	    Calendar calendar = Calendar.getInstance();      
	    if(date != null){        
	         calendar.setTime(date);      
	    }        
	    int w = calendar.get(Calendar.DAY_OF_WEEK) - 1;      
	    if (w < 0){        
	        w = 0;      
	    }      
	    return weekOfDays[w];    
	}
	/**
	 * 获取星期几
	 * @author chenhb
	 * @create_time  2015-9-8 下午2:53:29
	 * @param dt
	 * @return
	 */
	public static String getWeekOfDate(Date dt) {
        String[] weekDays = {"周日", "周一", "周二", "周三", "周四", "周五", "周六"};
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
        if (w < 0)
            w = 0;
        return weekDays[w];
    }
	/**
	 * 获取星期几
	 * @author chenhb
	 * @create_time  2015-9-8 下午2:53:29
	 * @param dt
	 * @return
	 */
	public static String getWeekOfDate_(Date date) {
		String[] weekOfDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};        
	    Calendar calendar = Calendar.getInstance();      
	    if(date != null){        
	         calendar.setTime(date);      
	    }        
	    int w = calendar.get(Calendar.DAY_OF_WEEK) - 1;      
	    if (w < 0){        
	        w = 0;      
	    }      
	    return weekOfDays[w];    
    }
	public static void main(String[] args) {
		//System.out.println(getWeekOfDate_("2015-12-08"));
		/*List<String> dates=getDatesFromTo("2015-11-01", "2015-10-02");
		for (String date : dates) {
			System.out.println(date);
		}*/
		System.out.println(formatDate(new Date(), "HH:30"));
	}
	
	public static boolean isValidDate(String str,String formatStr) {
		boolean convertSuccess = true;
		// 指定日期格式为四位年/两位月份/两位日期，注意yyyy/MM/dd区分大小写；
		SimpleDateFormat format = new SimpleDateFormat(formatStr);
		try {
			// 设置lenient为false.
			// 否则SimpleDateFormat会比较宽松地验证日期，比如2007/02/29会被接受，并转换成2007/03/01
			format.setLenient(false);
			format.parse(str);
		} catch (ParseException e) {
			// e.printStackTrace();
			// 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
			convertSuccess = false;
		}
		return convertSuccess;
	}
	
}
