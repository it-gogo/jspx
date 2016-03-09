package com.go.common.util;

import java.math.RoundingMode;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

/**
 * 字符串运算操作相关工具类
 * @author zhangjf
 * @create_time 2015-12-7 下午7:44:17
 */
public class StringOprUtil {

	/**
	 * 根据格式进行数据的四舍五入
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:44:51
	 * @param num
	 * @param format
	 * @return
	 */
	public static String format(String num,String format){
		if(StringUtils.isBlank(num))return "0";
		java.text.DecimalFormat df = new java.text.DecimalFormat(format);
		df.setRoundingMode(RoundingMode.HALF_UP);
		return df.format(Double.parseDouble(num));
	}
	
	/**
	 * 字符串数字进行求和运算
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:45:14
	 * @param num1
	 * @param num2
	 * @param format
	 * @return
	 */
	public static String sum(String num1,String num2,String format){
		if(StringUtils.isBlank(num1))num1 = "0";
		if(StringUtils.isBlank(num2))num2 = "0";
		DecimalFormat df = new DecimalFormat(format);
		df.setRoundingMode(RoundingMode.HALF_UP);
		Double d1 = new Double(num1);
		Double d2 = new Double(num2);
		return df.format(d1 + d2).toString();
	}
	
	/**
	 * 数字减法运算
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:45:32
	 * @param num1
	 * @param num2
	 * @param format
	 * @return
	 */
	public static String subtraction(String num1,String num2,String format){
		if(StringUtils.isBlank(num1))num1 = "0";
		if(StringUtils.isBlank(num2))num2 = "0";
		DecimalFormat df = new DecimalFormat(format);
		df.setRoundingMode(RoundingMode.HALF_UP);
		Double d1 = new Double(num1);
		Double d2 = new Double(num2);
		return df.format(d1 - d2).toString();
	}
	
	/**
	 * 字符串数字进行乘法运算
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:46:47
	 * @param num1
	 * @param num2
	 * @param format
	 * @return
	 */
	public static String multiplication(String num1,String num2,String format){
		if(StringUtils.isBlank(num1))num1 = "0";
		if(StringUtils.isBlank(num2))num2 = "0";
		DecimalFormat df = new DecimalFormat(format);
		df.setRoundingMode(RoundingMode.HALF_UP);
		Double d1 = new Double(num1);
		Double d2 = new Double(num2);
		return df.format(d1 * d2).toString();
	}
	
	/**
	 * 字符串数字进行除法运算
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:47:09
	 * @param num1
	 * @param num2
	 * @param format
	 * @return
	 */
	public static String division(String num1,String num2,String format){
		if(StringUtils.isBlank(num1))num1 = "0";
		if(StringUtils.isBlank(num2))num2 = "0";
		if(Double.valueOf(num2) == 0d){
			return "0";
		}
		DecimalFormat df = new DecimalFormat(format);
		df.setRoundingMode(RoundingMode.HALF_UP);
		Double d1 = new Double(num1);
		Double d2 = new Double(num2);
		return df.format(d1 / d2).toString();
	}
	
	/**
	 * 大于
	 * @author zhangjf
	 * @create_time 2015-12-7 下午8:14:29
	 * @param num1
	 * @param num2
	 * @return
	 */
	public static boolean greateThan(String num1,String num2){
		if(StringUtils.isBlank(num1))num1 = "0";
		if(StringUtils.isBlank(num2))num2 = "0";
		Double d1 = new Double(num1);
		Double d2 = new Double(num2);
		return d1>d2;
	}
	
	/**
	 * 大于等于
	 * @author zhangjf
	 * @create_time 2015-12-7 下午8:14:17
	 * @param num1
	 * @param num2
	 * @return
	 */
	public static boolean greateEqual(String num1,String num2){
		if(StringUtils.isBlank(num1))num1 = "0";
		if(StringUtils.isBlank(num2))num2 = "0";
		Double d1 = new Double(num1);
		Double d2 = new Double(num2);
		return d1>=d2;
	}
	
	/**
	 * 两个数字是否相等
	 * @author zhangjf
	 * @create_time 2016-1-26 下午4:43:48
	 * @param num1
	 * @param num2
	 * @return
	 */
	public static boolean isEqual(String num1,String num2){
		if(StringUtils.isBlank(num1))num1 = "0";
		if(StringUtils.isBlank(num2))num2 = "0";
		Double d1 = new Double(num1);
		Double d2 = new Double(num2);
		return d1.equals(d2);
	}
	
	/**
	 * 字符串加密
	 * @author zhangjf
	 * @create_time 2015-12-7 下午7:47:38
	 * @param password
	 * @return
	 */
	public static String encrypt(String password) {

		MessageDigest md;
		try {

			md = MessageDigest.getInstance("MD5");
			
			int size = password.length()/2;
			md.update((password+(size!=0?password.substring(size-1,size):"")).getBytes());

			return Base64.encode(md.digest());

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (Exception e){
			e.printStackTrace();
		}

		return null;
	}
	
	/**
	 * 判断是否为数字
	 * @author zhangjf
	 * @create_time 2015-12-14 下午5:43:11
	 * @param str
	 * @return
	 */
	public static boolean isNumeric(String str){ 
		   Pattern pattern = Pattern.compile("[0-9]*"); 
		   Matcher isNum = pattern.matcher(str);
		   if( !isNum.matches() ){
		       return false; 
		   } 
		   return true; 
		}
	
	public static void main(String[] args) {
		System.out.println(isNumeric("a"));
	}
}
