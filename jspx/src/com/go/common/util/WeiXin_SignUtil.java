package com.go.common.util;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Hashtable;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

/**
 * 请求校验工具类
 * @author zhangjf
 * @create_time 2015-8-4 上午11:35:44
 */
public class WeiXin_SignUtil {
	/**
	 * 验证签名
	 * @author zhangjf
	 * @create_time 2015-8-4 上午11:37:01
	 * @param signature
	 * @param timestamp
	 * @param nonce
	 * @return
	 */
	public static boolean checkSignature(String signature, String timestamp, String nonce){
		String[] arr=new String[]{WeiXin_ConfigUtil.getInstance().getToken(),timestamp,nonce};
		// 将token、timestamp、nonce三个参数进行字典序排序
		Arrays.sort(arr);
		StringBuilder sb=new StringBuilder();
		for (String str : arr) {
			sb.append(str);
		}
		MessageDigest md=null;
		String tmpStr="";
		try {
			md=MessageDigest.getInstance("SHA-1");
			// 将三个参数字符串拼接成一个字符串进行sha1加密
			 byte[] digest = md.digest(sb.toString().getBytes()); 
			 tmpStr = byteToStr(digest);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		sb = null;
		// 将sha1加密后的字符串可与signature对比，标识该请求来源于微信 
		return tmpStr != null ? tmpStr.equals(signature.toUpperCase()) : false;
	}

	/**
	 * 将字节数组转换为十六进制字符串
	 * @author zhangjf
	 * @create_time 2015-8-4 上午11:42:08
	 * @param digest
	 * @return
	 */
	private static String byteToStr(byte[] byteArray) {
		String digest="";
		for (byte byte_ : byteArray) {
			digest+=byteToHexStr(byte_);
		}
		return digest;
	}

	/**
	 * 将字节转换为十六进制字符串
	 * @author zhangjf
	 * @create_time 2015-8-4 上午11:43:51
	 * @param byte_
	 * @return
	 */
	private static String byteToHexStr(byte byte_) {
		char[] Digit = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
		char[] tempArr = new char[2];
		tempArr[0] = Digit[(byte_ >>> 4) & 0X0F]; 
		tempArr[1] = Digit[byte_ & 0X0F];
		String s = new String(tempArr);
		return s;
	}
	
	 public static String IDCardValidate(String IDStr) throws ParseException {
	        String errorInfo = "";// 记录错误信息
	        String[] ValCodeArr = { "1", "0", "x", "9", "8", "7", "6", "5", "4",
	                "3", "2" };
	        String[] Wi = { "7", "9", "10", "5", "8", "4", "2", "1", "6", "3", "7",
	                "9", "10", "5", "8", "4", "2" };
	        String Ai = "";
	        // ================ 号码的长度 15位或18位 ================
	        if (IDStr.length() != 15 && IDStr.length() != 18) {
	            errorInfo = "身份证号码长度应该为15位或18位。";
	            return errorInfo;
	        }
	        // =======================(end)========================

	        // ================ 数字 除最后以为都为数字 ================
	        if (IDStr.length() == 18) {
	            Ai = IDStr.substring(0, 17);
	        } else if (IDStr.length() == 15) {
	            Ai = IDStr.substring(0, 6) + "19" + IDStr.substring(6, 15);
	        }
	        if (isNumeric(Ai) == false) {
	            errorInfo = "身份证15位号码都应为数字 ; 18位号码除最后一位外，都应为数字。";
	            return errorInfo;
	        }
	        // =======================(end)========================

	        // ================ 出生年月是否有效 ================
	        String strYear = Ai.substring(6, 10);// 年份
	        String strMonth = Ai.substring(10, 12);// 月份
	        String strDay = Ai.substring(12, 14);// 月份
	        if (isDate(strYear + "-" + strMonth + "-" + strDay) == false) {
	            errorInfo = "身份证生日无效。";
	            return errorInfo;
	        }
	        GregorianCalendar gc = new GregorianCalendar();
	        SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd");
	        try {
	            if ((gc.get(Calendar.YEAR) - Integer.parseInt(strYear)) > 150
	                    || (gc.getTime().getTime() - s.parse(
	                            strYear + "-" + strMonth + "-" + strDay).getTime()) < 0) {
	                errorInfo = "身份证生日不在有效范围。";
	                return errorInfo;
	            }
	        } catch (NumberFormatException e) {
	            e.printStackTrace();
	        } catch (java.text.ParseException e) {
	            e.printStackTrace();
	        }
	        if (Integer.parseInt(strMonth) > 12 || Integer.parseInt(strMonth) == 0) {
	            errorInfo = "身份证月份无效";
	            return errorInfo;
	        }
	        if (Integer.parseInt(strDay) > 31 || Integer.parseInt(strDay) == 0) {
	            errorInfo = "身份证日期无效";
	            return errorInfo;
	        }
	        // =====================(end)=====================

	        // ================ 地区码时候有效 ================
	        Hashtable h = GetAreaCode();
	        if (h.get(Ai.substring(0, 2)) == null) {
	            errorInfo = "身份证地区编码错误。";
	            return errorInfo;
	        }
	        // ==============================================

	        // ================ 判断最后一位的值 ================
	        int TotalmulAiWi = 0;
	        for (int i = 0; i < 17; i++) {
	            TotalmulAiWi = TotalmulAiWi
	                    + Integer.parseInt(String.valueOf(Ai.charAt(i)))
	                    * Integer.parseInt(Wi[i]);
	        }
	        int modValue = TotalmulAiWi % 11;
	        String strVerifyCode = ValCodeArr[modValue];
	        Ai = Ai + strVerifyCode;

	        if (IDStr.length() == 18) {
	            if (Ai.equals(IDStr) == false) {
	                errorInfo = "身份证无效，不是合法的身份证号码";
	                return errorInfo;
	            }
	        } else {
	            return "";
	        }
	        // =====================(end)=====================
	        return "";
	    }
	
	 /**
	  * 设置地区编码
	  * @author zhangjf
	  * @create_time 2015-8-8 下午12:26:22
	  * @return
	  */
	 private static Hashtable GetAreaCode() {
	        Hashtable hashtable = new Hashtable();
	        hashtable.put("11", "北京");
	        hashtable.put("12", "天津");
	        hashtable.put("13", "河北");
	        hashtable.put("14", "山西");
	        hashtable.put("15", "内蒙古");
	        hashtable.put("21", "辽宁");
	        hashtable.put("22", "吉林");
	        hashtable.put("23", "黑龙江");
	        hashtable.put("31", "上海");
	        hashtable.put("32", "江苏");
	        hashtable.put("33", "浙江");
	        hashtable.put("34", "安徽");
	        hashtable.put("35", "福建");
	        hashtable.put("36", "江西");
	        hashtable.put("37", "山东");
	        hashtable.put("41", "河南");
	        hashtable.put("42", "湖北");
	        hashtable.put("43", "湖南");
	        hashtable.put("44", "广东");
	        hashtable.put("45", "广西");
	        hashtable.put("46", "海南");
	        hashtable.put("50", "重庆");
	        hashtable.put("51", "四川");
	        hashtable.put("52", "贵州");
	        hashtable.put("53", "云南");
	        hashtable.put("54", "西藏");
	        hashtable.put("61", "陕西");
	        hashtable.put("62", "甘肃");
	        hashtable.put("63", "青海");
	        hashtable.put("64", "宁夏");
	        hashtable.put("65", "新疆");
	        hashtable.put("71", "台湾");
	        hashtable.put("81", "香港");
	        hashtable.put("82", "澳门");
	        hashtable.put("91", "国外");
	        return hashtable;
	    }
	 
	 /**
	     * 功能：判断字符串是否为数字
	     * 
	     * @param str
	     * @return
	     */
	    private static boolean isNumeric(String str) {
	        Pattern pattern = Pattern.compile("[0-9]*");
	        Matcher isNum = pattern.matcher(str);
	        if (isNum.matches()) {
	            return true;
	        } else {
	            return false;
	        }
	    }
	    
	    /**
	     * 功能：判断字符串是否为日期格式
	     * 
	     * @param str
	     * @return
	     */
	    public static boolean isDate(String strDate) {
	        Pattern pattern = Pattern
	                .compile("^((\\d{2}(([02468][048])|([13579][26]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])))))|(\\d{2}(([02468][1235679])|([13579][01345789]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\\s(((0?[0-9])|([1-2][0-3]))\\:([0-5]?[0-9])((\\s)|(\\:([0-5]?[0-9])))))?$");
	        Matcher m = pattern.matcher(strDate);
	        if (m.matches()) {
	            return true;
	        } else {
	            return false;
	        }
	    }
	
}
