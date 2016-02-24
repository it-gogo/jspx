package com.go.common.util;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

/**
 * 导入信息
 * @author chenhb
 * @create_time {date} 下午3:01:12
 */
public class ImportInfo {
	
	/**
	 * 导入文件信息获取集合
	 * @author chenhb
	 * @create_time {date} 下午3:07:59
	 * @param f
	 * @return
	 * @throws Exception
	 */
	public static  List<String[]>  importFile(InputStream is,String[] header) throws Exception{
		Workbook  workbook = Workbook.getWorkbook(is);   
		Sheet  sheet = workbook.getSheet(0);
		int row = sheet.getRows();
		int col = sheet.getColumns();
        Cell cell = null;
        String[]  rdata = null;
        boolean  isData = false;
        List<String[]>  list = new ArrayList<String[]>();
        for(int i=0;i<row;i++){
        	rdata = new String[col];
        	for(int j=0;j<col;j++){
        		cell = sheet.getCell(j,i);
        		rdata[j] = cell.getContents();
        	}
        	if(isData){
        		//检测数据结构
        	   int  chd = checkData(rdata);
        	   switch(chd){
        	   case 0:
        		   list.add(rdata);
        		   break;
        	   case 2:
        		   return null;
        	   }
        	}
        	if(!isData){
        	  isData = isExcelHeader(rdata,header);
        	}
        }
        if(!isData){
        	return  null;//格式不对
        }
        workbook.close();
        return list;
	}
	
	/**
	 * 检测表头
	 * @return
	 */
	private static  boolean  isExcelHeader(String[]  rdata,String[] header){
		boolean  flag = false;
		int count = 0;
		if(rdata.length!=header.length){
			return false;
		}
		for(int i=0;i<header.length;i++){
			if(header[i].equals(rdata[i].trim())){
				count++;
			}else{
				break;
			}
		}
		if(count==header.length){
			flag = true;
		}
		return flag;
	}
	
	/**
	 * 检测数据的完整性
	 * @param rdata
	 * @return
	 */
	private static  int  checkData(String[]  rdata){
		return 0;
	}
}
