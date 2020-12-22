package egovframework.webco.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.webco.dao.WebcoDefaultDAO;
import egovframework.webco.service.StatisticsService;
import egovframework.webco.util.CommonUtil;
import egovframework.webco.util.EnumValue;

@Service("statisticsService")
public class StatisticsServiceImpl extends EgovAbstractServiceImpl implements StatisticsService{

	/** webcoDAO */
    @Resource(name="webcoDAO")
    private WebcoDefaultDAO webcoDAO;    	
	
	/** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());
    
    @Override
    public Map<String, Object> getDashboard(Map commandMap) throws Exception {
    	// TODO Auto-generated method stub
    	Map<String, Object> rtnMap = new HashMap<String, Object>();
    			
    	int today_visit_count = 0;
        int today_pledge_count = 0;
        int week_visit_count = 0;
        int week_pledge_count = 0;
        int month_visit_count = 0;
        int month_pledge_count = 0;
        int total_visit_count = 0;
        int total_pledge_count = 0;
        int idx;
        ArrayList<Map<String, Object>> dashboard_column_chart_data1 = new ArrayList<Map<String, Object>>();
        ArrayList<Map<String, Object>> dashboard_column_chart_data2 = new ArrayList<Map<String, Object>>();

        for(idx=0; idx<31; idx++) {
        	String curDate = CommonUtil.DateAddDay("yyyy-MM-dd", idx*-1);
        	String curDate2 = CommonUtil.DateAddDay("M.d", idx*-1);
        	//SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        	//System.out.println(curDate);
        	//long ts = dateFormat.parse(curDate).getTime()/1000;
        	
        	//commandMap.put("create_date", Long.toString(ts));  	        	
        	commandMap.put("create_date", curDate);
        	int visit_count = Integer.parseInt(webcoDAO.selectByPk("VisitDAO.selectCount", commandMap).toString());
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(ts)); 	        	
        	commandMap.put("user_pledge_date", curDate);
        	int pledge_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());
        	
        	Map<String, Object> chartMap = new HashMap<String, Object>(); 
        	
        	chartMap.put("day", curDate2);
        	chartMap.put("visit", visit_count);
        	chartMap.put("pledge", pledge_count);	        	
        	
        	dashboard_column_chart_data1.add(chartMap);
        	
        	if(idx<7) {
        		dashboard_column_chart_data2.add(chartMap);
        	}
        	if(idx == 0) {
                today_visit_count = visit_count;
                today_pledge_count = pledge_count;
            }
            if(idx < 7) {
                week_visit_count += visit_count;
                week_pledge_count += pledge_count;
            }
            if(idx < 31) {
                month_visit_count += visit_count;
                month_pledge_count += pledge_count;
            }            
        }
        commandMap.clear();
        //누적 방문,서약 현황
        /*total_visit_count = Integer.parseInt(webcoDAO.selectByPk("VisitDAO.selectCount", commandMap).toString());
        total_pledge_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());*/
        
        total_visit_count = Integer.parseInt(webcoDAO.selectByPk("VisitDAO.selectYearCount", commandMap).toString());
        total_pledge_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectYearCount", commandMap).toString());
        
        Collections.reverse(dashboard_column_chart_data1);
        Collections.reverse(dashboard_column_chart_data2); 
        	                
        rtnMap.put("dashboard_column_chart_1_data",     dashboard_column_chart_data2);
        rtnMap.put("dashboard_column_chart_2_data",     dashboard_column_chart_data1);
        rtnMap.put("today_visit_count",     today_visit_count);
        rtnMap.put("today_pledge_count",     today_pledge_count);
        rtnMap.put("week_visit_count",     week_visit_count);
        rtnMap.put("week_pledge_count",     week_pledge_count);
        rtnMap.put("week_pledge_visit_rate",     CommonUtil.calculatePercentage(week_pledge_count, week_visit_count));
        rtnMap.put("month_visit_count",     month_visit_count);
        rtnMap.put("month_pledge_count",     month_pledge_count);
        rtnMap.put("month_pledge_visit_rate",     CommonUtil.calculatePercentage(month_pledge_count, month_visit_count));
        rtnMap.put("total_visit_count",     total_visit_count);
        rtnMap.put("total_pledge_count",     total_pledge_count);
        
        return rtnMap;
    }
    
    @Override
	public Map<String, Object> getVisitPeriod(Map commandMap)
			throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		long search_start_date_time = 0;
		long search_end_date_time = 0;
		if(!EgovStringUtil.isEmpty(commandMap.get("search_start_date").toString())) {		    		
			search_start_date_time = CommonUtil.dateToLong(commandMap.get("search_start_date").toString(), "yyyy.MM.dd");
		}
		
		if(!EgovStringUtil.isEmpty(commandMap.get("search_end_date").toString())) {		    		
			search_end_date_time = CommonUtil.dateToLong(commandMap.get("search_end_date").toString(), "yyyy.MM.dd");
		}
		
		ArrayList<Map<String, Object>> chart_data = new ArrayList<Map<String, Object>>();
        ArrayList<Map<String, Object>> list_data = new ArrayList<Map<String, Object>>();
        
        int today_visit_count = 0;
        int today_pledge_count = 0;
        long day = search_start_date_time;
        
        for(int idx=0; day<(search_end_date_time); idx++) {
        	//CommonUtil.DateFormat(
        	day = CommonUtil.timestampAddDay(search_start_date_time, idx);        	
        	String day_string = CommonUtil.longToDateFormat(Long.toString(day), "MM.dd");
        	String day_string2 = CommonUtil.longToDateFormat(Long.toString(day), "yyyy.MM.dd");
        	//commandMap.put("create_date", Long.toString(day));  	        	
        	commandMap.put("create_date", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	int visit_count = Integer.parseInt(webcoDAO.selectByPk("VisitDAO.selectCount", commandMap).toString());
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day)); 	        	
        	commandMap.put("user_pledge_date", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	int pledge_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());
        	
        	Map<String, Object> chartMap = new LinkedHashMap<String, Object>(); 
        	
        	chartMap.put("day", day_string);
        	chartMap.put("visit", visit_count);
        	chartMap.put("pledge", pledge_count);	        	
        	
        	chart_data.add(chartMap);
        	
        	Map<String, Object> dataMap = new LinkedHashMap<String, Object>();
        	
        	dataMap.put("day", day_string2);
        	dataMap.put("visit", visit_count);
        	dataMap.put("pledge", pledge_count);
        	
        	list_data.add(dataMap);
        	
            today_visit_count += visit_count;
            today_pledge_count += pledge_count;
               
        }
		
		rtnMap.put("total_visit_count", today_visit_count);
		rtnMap.put("total_pledge_count", today_pledge_count);
		rtnMap.put("chart_data_array", chart_data);
		rtnMap.put("data_list_data_array", list_data);
		return rtnMap;
	}
	
    @Override
	public Map<String, Object> getChannel(Map commandMap)
			throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		EnumValue enumValue = new EnumValue();
		long search_start_date_time = 0;
		long search_end_date_time = 0;
		if(!EgovStringUtil.isEmpty(commandMap.get("search_start_date").toString())) {		    		
			search_start_date_time = CommonUtil.dateToLong(commandMap.get("search_start_date").toString(), "yyyy.MM.dd");
		}
		
		if(!EgovStringUtil.isEmpty(commandMap.get("search_end_date").toString())) {		    		
			search_end_date_time = CommonUtil.dateToLong(commandMap.get("search_end_date").toString(), "yyyy.MM.dd");
		}
		
		ArrayList<Map<String, Object>> chart_data = new ArrayList<Map<String, Object>>();
        ArrayList<Map<String, Object>> list_data = new ArrayList<Map<String, Object>>();
        
        int total_online_count = 0;
        int total_offline_count = 0;
        int total_syrup_count = 0;
        long day = search_start_date_time;
        
        for(int idx=0; day<(search_end_date_time); idx++) {
        	//CommonUtil.DateFormat(
        	day = CommonUtil.timestampAddDay(search_start_date_time, idx);        	
        	String day_string = CommonUtil.longToDateFormat(Long.toString(day), "MM.dd");
        	String day_string2 = CommonUtil.longToDateFormat(Long.toString(day), "yyyy.MM.dd");
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day)); 
        	commandMap.put("user_pledge_date", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("user_register_channel", 1);
        	int online_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());
        	total_online_count += online_count;
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day)); 
        	commandMap.put("user_pledge_date", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("user_register_channel", 2);
        	int offline_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());
        	total_offline_count += offline_count;
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day));
        	commandMap.put("user_pledge_date", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("user_register_channel", 3);
        	int syrup_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());
        	total_syrup_count += syrup_count;
        	
        	int total_count = online_count + offline_count + syrup_count;
        	Map<String, Object> dataMap = new LinkedHashMap<String, Object>();
        	
        	dataMap.put("day", day_string2);
        	dataMap.put("online", online_count);
        	dataMap.put("online_percentage", CommonUtil.calculatePercentage(online_count, total_count)+" %");
        	dataMap.put("offline", offline_count);
        	dataMap.put("offline_percentage", CommonUtil.calculatePercentage(offline_count, total_count)+" %");
        	dataMap.put("syrup", syrup_count);
        	dataMap.put("syrup_percentage", CommonUtil.calculatePercentage(syrup_count, total_count)+" %");
        	
        	list_data.add(dataMap);        	                         
        }
        
        Map<String, Object> chartOnlineMap = new LinkedHashMap<String, Object>();        
        chartOnlineMap.put("channel", enumValue.getValue("user_register_channel", "1"));
        chartOnlineMap.put("pledge", total_online_count);        
        chart_data.add(chartOnlineMap);
        
        Map<String, Object> chartOfflineMap = new LinkedHashMap<String, Object>();
        chartOfflineMap.put("channel", enumValue.getValue("user_register_channel", "2"));
        chartOfflineMap.put("pledge", total_offline_count);
        chart_data.add(chartOfflineMap);
        
        Map<String, Object> chartSyrupMap = new LinkedHashMap<String, Object>();
        chartSyrupMap.put("channel", enumValue.getValue("user_register_channel", "3"));
        chartSyrupMap.put("pledge", total_syrup_count);
        chart_data.add(chartSyrupMap);
		
		rtnMap.put("total_online_count", total_online_count);
		rtnMap.put("total_offline_count", total_offline_count);
		rtnMap.put("total_syrup_count", total_syrup_count);
		rtnMap.put("chart_data_array", chart_data);
		rtnMap.put("data_list_data_array", list_data);
		return rtnMap;
	}
    
    @Override
	public Map<String, Object> getSexAge(Map commandMap)
			throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		EnumValue enumValue = new EnumValue();
		long search_start_date_time = 0;
		long search_end_date_time = 0;
		if(!EgovStringUtil.isEmpty(commandMap.get("search_start_date").toString())) {		    		
			search_start_date_time = CommonUtil.dateToLong(commandMap.get("search_start_date").toString(), "yyyy.MM.dd");
		}
		
		if(!EgovStringUtil.isEmpty(commandMap.get("search_end_date").toString())) {		    		
			search_end_date_time = CommonUtil.dateToLong(commandMap.get("search_end_date").toString(), "yyyy.MM.dd");
		}
		
		ArrayList<Map<String, Object>> chart_data = new ArrayList<Map<String, Object>>();
        ArrayList<Map<String, Object>> list_data = new ArrayList<Map<String, Object>>();
                
        long day = search_start_date_time;
        
        for(int idx=0; day<(search_end_date_time); idx++) {
        	//CommonUtil.DateFormat(
        	day = CommonUtil.timestampAddDay(search_start_date_time, idx);        	
        	String day_string = CommonUtil.longToDateFormat(Long.toString(day), "MM.dd");
        	String day_string2 = CommonUtil.longToDateFormat(Long.toString(day), "yyyy.MM.dd");
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day));
        	commandMap.put("user_pledge_date", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("user_sex", enumValue.getKey("user_sex", "남"));
        	int male_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day));
        	commandMap.put("user_pledge_date", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("user_sex", enumValue.getKey("user_sex", "여"));
        	int female_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());        	
        	
        	int total_count = male_count + female_count;
        	Map<String, Object> dataMap = new LinkedHashMap<String, Object>();
        	
        	dataMap.put("day", day_string2);
        	dataMap.put("male", male_count);
        	dataMap.put("male_percentage", CommonUtil.calculatePercentage(male_count, total_count)+" %");
        	dataMap.put("female", female_count);
        	dataMap.put("female_percentage", CommonUtil.calculatePercentage(female_count, total_count)+" %");
        	
        	list_data.add(dataMap);        	                         
        }
        int[] search_start_age_array = {10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60};
        int[] search_end_age_array = {14, 19, 24, 29, 34, 39, 44, 49, 54, 59, 100};
        int user_sex_total_count = 0;
        
        for (int idx=0; idx<search_start_age_array.length; idx++) { 
        	int current_year = Calendar.getInstance().get(Calendar.YEAR);
        	int start_year = current_year - search_end_age_array[idx] + 1;
        	int end_year = current_year - search_start_age_array[idx] + 1;
        	
        	commandMap.clear();
        	//commandMap.put("search_start_birthday", CommonUtil.dateToLong(start_year+"-01-01", "yyyy-MM-dd"));
        	//commandMap.put("search_end_birthday", CommonUtil.dateToLong(end_year+"-01-01", "yyyy-MM-dd")-1);
        	commandMap.put("search_start_birthday", start_year+"-01-01");
        	commandMap.put("search_end_birthday", end_year+"-12-31");  
        	commandMap.put("user_sex", enumValue.getKey("user_sex", "남"));
        	//commandMap.put("search_start_date", search_start_date_time);
        	//commandMap.put("search_end_date", search_end_date_time);
        	commandMap.put("search_start_date", CommonUtil.longToDateFormat(Long.toString(search_start_date_time), "yyyy-MM-dd"));
        	commandMap.put("search_end_date", CommonUtil.longToDateFormat(Long.toString(search_end_date_time), "yyyy-MM-dd"));
        	int emale_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());
        	
        	commandMap.clear();
        	//commandMap.put("search_start_birthday", CommonUtil.dateToLong(start_year+"-01-01", "yyyy-MM-dd"));
        	//commandMap.put("search_end_birthday", CommonUtil.dateToLong(end_year+"-01-01", "yyyy-MM-dd")-1);
        	commandMap.put("search_start_birthday", start_year+"-01-01");
        	commandMap.put("search_end_birthday", end_year+"-12-31");  
        	commandMap.put("user_sex", enumValue.getKey("user_sex", "여"));
        	//commandMap.put("search_start_date", search_start_date_time);
        	//commandMap.put("search_end_date", search_end_date_time);
        	commandMap.put("search_start_date", CommonUtil.longToDateFormat(Long.toString(search_start_date_time), "yyyy-MM-dd"));
        	commandMap.put("search_end_date", CommonUtil.longToDateFormat(Long.toString(search_end_date_time), "yyyy-MM-dd"));
        	int female_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());
        	
	        Map<String, Object> chartMap = new LinkedHashMap<String, Object>();        
	        chartMap.put("age", search_start_age_array[idx]+"-"+search_end_age_array[idx]);
	        chartMap.put("male", emale_count);
	        chartMap.put("female", female_count);
	        chartMap.put("human", emale_count + female_count);
	        chart_data.add(chartMap);   
	        
	        user_sex_total_count += emale_count + female_count;
        }
        
        for( Map<String, Object> chart : chart_data ) {
        	chart.put("rate", CommonUtil.calculatePercentage(Integer.parseInt(chart.get("human").toString()), user_sex_total_count)+" %");
    	}
			
		rtnMap.put("total_count", user_sex_total_count);
		rtnMap.put("chart_data_array", chart_data);
		rtnMap.put("data_list_data_array", list_data);		
		return rtnMap;
	}
    
    @Override
	public Map<String, Object> getWithdraw(Map commandMap)
			throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		EnumValue enumValue = new EnumValue();
		long search_start_date_time = 0;
		long search_end_date_time = 0;
		if(!EgovStringUtil.isEmpty(commandMap.get("search_start_date").toString())) {		    		
			search_start_date_time = CommonUtil.dateToLong(commandMap.get("search_start_date").toString(), "yyyy.MM.dd");
		}
		
		if(!EgovStringUtil.isEmpty(commandMap.get("search_end_date").toString())) {		    		
			search_end_date_time = CommonUtil.dateToLong(commandMap.get("search_end_date").toString(), "yyyy.MM.dd");
		}
		
		ArrayList<Map<String, Object>> chart_data = new ArrayList<Map<String, Object>>();
        ArrayList<Map<String, Object>> list_data = new ArrayList<Map<String, Object>>();
        
        int total_withdraw_1_count = 0;
        int total_withdraw_2_count = 0;
        int total_withdraw_3_count = 0;
        int total_withdraw_4_count = 0;           
        long day = search_start_date_time;
        
        for(int idx=0; day<(search_end_date_time); idx++) {
        	//CommonUtil.DateFormat(
        	day = CommonUtil.timestampAddDay(search_start_date_time, idx);        	
        	String day_string = CommonUtil.longToDateFormat(Long.toString(day), "MM.dd");
        	String day_string2 = CommonUtil.longToDateFormat(Long.toString(day), "yyyy.MM.dd");
        	
        	commandMap.clear();
        	//commandMap.put("user_withdraw_date", Long.toString(day)); 
        	commandMap.put("user_withdraw_date", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("user_withdraw_reason", 1);
        	int withdraw_1_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());
        	total_withdraw_1_count += withdraw_1_count;
        	
        	commandMap.clear();
        	//commandMap.put("user_withdraw_date", Long.toString(day));
        	commandMap.put("user_withdraw_date", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("user_withdraw_reason", 2);
        	int withdraw_2_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());
        	total_withdraw_2_count += withdraw_2_count;
        	
        	commandMap.clear();
        	//commandMap.put("user_withdraw_date", Long.toString(day));
        	commandMap.put("user_withdraw_date", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("user_withdraw_reason", 3);
        	int withdraw_3_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());
        	total_withdraw_3_count += withdraw_3_count;
        	
        	commandMap.clear();
        	//commandMap.put("user_withdraw_date", Long.toString(day));
        	commandMap.put("user_withdraw_date", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("user_withdraw_reason", 4);
        	int withdraw_4_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());
        	total_withdraw_4_count += withdraw_4_count;
        	
        	int day_withdraw_count = withdraw_1_count + withdraw_2_count + withdraw_3_count + withdraw_4_count;
        	Map<String, Object> dataMap = new LinkedHashMap<String, Object>();
        	
        	dataMap.put("day", day_string2);
        	dataMap.put("withdraw1", withdraw_1_count);
        	dataMap.put("withdraw1_percentage", CommonUtil.calculatePercentage(withdraw_1_count, day_withdraw_count)+" %");
        	dataMap.put("withdraw2", withdraw_2_count);
        	dataMap.put("withdraw2_percentage", CommonUtil.calculatePercentage(withdraw_2_count, day_withdraw_count)+" %");
        	dataMap.put("withdraw3", withdraw_3_count);
        	dataMap.put("withdraw3_percentage", CommonUtil.calculatePercentage(withdraw_3_count, day_withdraw_count)+" %");
        	dataMap.put("withdraw4", withdraw_4_count);
        	dataMap.put("withdraw4_percentage", CommonUtil.calculatePercentage(withdraw_4_count, day_withdraw_count)+" %");
        	
        	list_data.add(dataMap);        	                         
        }
        
        Map<String, Object> chartwithdraw1Map = new LinkedHashMap<String, Object>();        
        chartwithdraw1Map.put("withdraw", enumValue.getValue("user_withdraw_reason", "1"));
        chartwithdraw1Map.put("pledge", total_withdraw_1_count);        
        chart_data.add(chartwithdraw1Map);
        
        Map<String, Object> chartwithdraw2Map = new LinkedHashMap<String, Object>();        
        chartwithdraw2Map.put("withdraw", enumValue.getValue("user_withdraw_reason", "2"));
        chartwithdraw2Map.put("pledge", total_withdraw_2_count);        
        chart_data.add(chartwithdraw2Map);
        
        Map<String, Object> chartwithdraw3Map = new LinkedHashMap<String, Object>();        
        chartwithdraw3Map.put("withdraw", enumValue.getValue("user_withdraw_reason", "3"));
        chartwithdraw3Map.put("pledge", total_withdraw_3_count);        
        chart_data.add(chartwithdraw3Map);
        
        Map<String, Object> chartwithdraw4Map = new LinkedHashMap<String, Object>();        
        chartwithdraw4Map.put("withdraw", enumValue.getValue("user_withdraw_reason", "4"));
        chartwithdraw4Map.put("pledge", total_withdraw_4_count);        
        chart_data.add(chartwithdraw4Map);
				
		rtnMap.put("total_withdraw_count", total_withdraw_1_count + total_withdraw_2_count + total_withdraw_3_count + total_withdraw_4_count);
		rtnMap.put("chart_data_array", CommonUtil.getJsonArrayFromList(chart_data));
		rtnMap.put("data_list_data_array", CommonUtil.getJsonArrayFromList(list_data));				
		return rtnMap;
	}
    
    @Override
	public boolean exportExcel(Map commandMap) throws Exception {		
		boolean result = true;
		FileOutputStream outputStream = null; // 파일 쓰기 스트림
		try {
			String title = commandMap.get("title").toString();
			List<String[]> title_data_list = (List<String[]>) commandMap.get("title_data_list");					 
			List<?> data_list = (List<Map<String, Object>>) commandMap.get("data_list"); 
			log.info("엑셀 생성시작==========>");
			HSSFWorkbook objWorkBook = new HSSFWorkbook();
			HSSFSheet objSheet = null;
			HSSFRow objRow = null;
			HSSFCell objCell = null;       //셀 생성
			
			HSSFFont font = objWorkBook.createFont();
			font.setFontHeightInPoints((short)9);
			font.setBoldweight((short)font.BOLDWEIGHT_BOLD);
			font.setFontName("맑은고딕");
			
			//제목 스타일에 폰트 적용, 정렬
			HSSFCellStyle styleHd = objWorkBook.createCellStyle();    //제목 스타일
			styleHd.setFont(font);
			styleHd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			styleHd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);
			
			HSSFFont font2 = objWorkBook.createFont();
			font2.setFontHeightInPoints((short)9);
			font2.setBoldweight((short)font2.BOLDWEIGHT_NORMAL);
			font2.setFontName("맑은고딕");
			
			//본문 스타일에 폰트 적용, 정렬
			HSSFCellStyle styleBd = objWorkBook.createCellStyle();    //제목 스타일
			styleBd.setFont(font2);
			styleBd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			styleBd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);

			objSheet = objWorkBook.createSheet(title);     //워크시트 생성
			objRow = objSheet.createRow(0);
			objRow.setHeight ((short) 0x150);
			
			// 제목
			objCell = objRow.createCell(0);
			objCell.setCellValue(title);
			objCell.setCellStyle(styleHd);		
			
			int idx = 1;			
			int arrIdx = 0;
			for( String[] title_data : title_data_list ) {
				objRow = objSheet.createRow(idx++);
				objRow.setHeight((short) 0x150);
				
				int cur_col = 0;
				for (String data : title_data) {
					objCell = objRow.createCell(cur_col);
					objCell.setCellValue(data);
					objCell.setCellStyle(styleHd);						
					cur_col++;
				}								
				
				List<Map<String, Object>> list = (List<Map<String, Object>>) data_list.get(arrIdx);
				for( Map<String, Object> data : list ) {
					objRow = objSheet.createRow(idx++);
					
					cur_col = 0;
					for( Entry<String, Object> elem : data.entrySet() ){					
						objCell = objRow.createCell(cur_col);
						objCell.setCellValue(EgovStringUtil.isNullToString(elem.getValue()).toString());
						objCell.setCellStyle(styleBd);
						cur_col++;
					 }
				}
				arrIdx++;
				idx++;
			}						
			
			for( String[] title_data : title_data_list ) {
				int cur_col = 0;
				for (String data : title_data) {					
					objSheet.autoSizeColumn(cur_col);
					cur_col++;
				}
			}
			/*for (int i=0; i < idx; i++) {
				objSheet.autoSizeColumn(i);
			}*/
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder .getRequestAttributes()).getRequest();
			
			String realPath = request.getSession().getServletContext().getRealPath("/");				
			String filePath = "/uploads/statistics/statistics.xls"; // 대상 파일			
			outputStream = new FileOutputStream(new File(realPath+filePath));				
			objWorkBook.write(outputStream);
			
			log.info("파일저장경로==========>"+realPath+filePath);
		} catch (IOException  e) {
			result = false;
            log.error(e);                 
		} catch (Exception e) {
			result = false;
            log.error(e);                   
        } 
		finally
		{
			try
			{
				// 파일 닫기. 여기에도 try/catch가 필요하다.
				outputStream.close();
			}
			catch (Exception e)
			{
				result = false;
			}
		}
		return result;
	}

	@Override
	public List<Map<String, Object>> hopeDonateStatsList(
			Map<String, Object> commandMap) {
		
		return webcoDAO.hopeDonateStatsList("UserDAO.hopeDonateStatsList",commandMap);
	}

	@Override
	public int hopeDonateStatsListTotCnt(Map<String, Object> commandMap) {
		
		return webcoDAO.hopeDonateStatsListTotCnt("UserDAO.hopeDonateStatsListTotCnt",commandMap);
	}

	@Override
	public List<Map<String, Object>> brainDonateStatsList(
			Map<String, Object> commandMap) {
		
		return webcoDAO.brainDonateStatsList("UserDAO.brainDonateStatsList",commandMap);
	}

	@Override
	public int brainDonateStatsListTotCnt(Map<String, Object> commandMap) {
		
		return webcoDAO.brainDonateStatsListTotCnt("UserDAO.brainDonateStatsListTotCnt",commandMap);
	}

	@Override
	public List<Map<String, Object>> organDonateStatsList(
			Map<String, Object> commandMap) {
		
		return webcoDAO.organDonateStatsList("UserDAO.organDonateStatsList",commandMap);
	}

	@Override
	public int organDonateStatsListTotCnt(Map<String, Object> commandMap) {
		
		return webcoDAO.organDonateStatsListTotCnt("UserDAO.organDonateStatsListTotCnt",commandMap);
	}

	@Override
	public List<Map<String, Object>> donateStatsTrendList(
			Map<String, Object> commandMap) {

		return webcoDAO.donateStatsTrendList("UserDAO.donateStatsTrendList",commandMap);
	}

	@Override
	public int donateStatsTrendListTotCnt(Map<String, Object> commandMap) {
		
		return webcoDAO.donateStatsTrendListTotCnt("UserDAO.donateStatsTrendListTotCnt",commandMap);
	}

	@Override
	public Map<String, Object> selectedBrain(Map<String, Object> commandMap) {

		return webcoDAO.selectedBrain("UserDAO.selectedBrain",commandMap);
	}

	@Override
	public void brainDonateStatsUpdateEnd(Map<String, Object> commandMap) {

		webcoDAO.brainDonateStatsUpdateEnd("UserDAO.brainDonateStatsUpdateEnd",commandMap);
	}

	@Override
	public void brainDonateStatsDeleteEnd(Map<String, Object> commandMap) {

		webcoDAO.brainDonateStatsDeleteEnd("UserDAO.brainDonateStatsDeleteEnd",commandMap);
	}

	@Override
	public void brainDonateStatsWriteEnd(Map<String, Object> commandMap) {

		webcoDAO.brainDonateStatsWriteEnd("UserDAO.brainDonateStatsWriteEnd",commandMap);
	}

	@Override
	public Map<String, Object> selectedOrgan(Map<String, Object> commandMap) {

		return webcoDAO.selectedOrgan("UserDAO.selectedOrgan",commandMap);
	}

	@Override
	public void organDonateStatsUpdateEnd(Map<String, Object> commandMap) {
		
		webcoDAO.organDonateStatsUpdateEnd("UserDAO.organDonateStatsUpdateEnd",commandMap);
	}

	@Override
	public void organDonateStatsDeleteEnd(Map<String, Object> commandMap) {

		webcoDAO.organDonateStatsDeleteEnd("UserDAO.organDonateStatsDeleteEnd",commandMap);
	}

	@Override
	public void organDonateStatsWriteEnd(Map<String, Object> commandMap) {

		webcoDAO.organDonateStatsWriteEnd("UserDAO.organDonateStatsWriteEnd",commandMap);
	}

	@Override
	public Map<String, Object> selectedHope(Map<String, Object> commandMap) {

		return webcoDAO.selectedHope("UserDAO.selectedHope",commandMap);
	}

	@Override
	public void hopeDonateStatsUpdateEnd(Map<String, Object> commandMap) {

		webcoDAO.hopeDonateStatsUpdateEnd("UserDAO.hopeDonateStatsUpdateEnd",commandMap);
	}

	@Override
	public void hopeDonateStatsDeleteEnd(Map<String, Object> commandMap) {

		webcoDAO.hopeDonateStatsDeleteEnd("UserDAO.hopeDonateStatsDeleteEnd",commandMap);
	}

	@Override
	public void hopeDonateStatsWriteEnd(Map<String, Object> commandMap) {

		webcoDAO.hopeDonateStatsWriteEnd("UserDAO.hopeDonateStatsWriteEnd",commandMap);
	}

	@Override
	public Map<String, Object> selectedBoard(Map<String, Object> commandMap) {
		
		return webcoDAO.selectedBoard("UserDAO.selectedBoard",commandMap);
	}

	@Override
	public void boardUpdateEnd(Map<String, Object> commandMap) {
		
		webcoDAO.boardUpdateEnd("UserDAO.boardUpdateEnd",commandMap);
	}

	@Override
	public void boardDeleteEnd(Map<String, Object> commandMap) {

		webcoDAO.boardDeleteEnd("UserDAO.boardDeleteEnd",commandMap);
	}

	@Override
	public void boardFileDeleteEnd(Map<String, Object> commandMap) {

		webcoDAO.boardFileDeleteEnd("UserDAO.boardFileDeleteEnd",commandMap);
	}

	@Override
	public void boardFileInsert(Map<String, Object> commandMap) {
		
		webcoDAO.boardFileInsert("UserDAO.boardFileInsert",commandMap);
	}

	@Override
	public void boardInsert(Map<String, Object> commandMap) {

		webcoDAO.boardInsert("UserDAO.boardInsert",commandMap);
	}

	@Override
	public Map<String, Object> selectedTrend(Map<String, Object> commandMap) {

		return webcoDAO.selectedTrend("UserDAO.selectedTrend",commandMap);
	}

	@Override
	public void donateStatsTrendUpdateEnd(Map<String, Object> commandMap) {
		
		webcoDAO.donateStatsTrendUpdateEnd("UserDAO.donateStatsTrendUpdateEnd",commandMap);
	}

	@Override
	public void donateStatsTrendDeleteEnd(Map<String, Object> commandMap) {

		webcoDAO.donateStatsTrendDeleteEnd("UserDAO.donateStatsTrendDeleteEnd",commandMap);
	}

	@Override
	public void donateStatsTrendWriteEnd(Map<String, Object> commandMap) {

		webcoDAO.donateStatsTrendWriteEnd("UserDAO.donateStatsTrendWriteEnd",commandMap);
	}

	@Override
	public Map<String, Object> getRecognizeTypeAjax(
			Map<String, Object> commandMap) throws Exception {
		
		// TODO Auto-generated method stub
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		EnumValue enumValue = new EnumValue();
		long search_start_date_time = 0;
		long search_end_date_time = 0;
		if(!EgovStringUtil.isEmpty(commandMap.get("search_start_date").toString())) {		    		
			search_start_date_time = CommonUtil.dateToLong(commandMap.get("search_start_date").toString(), "yyyy.MM.dd");
		}
		
		if(!EgovStringUtil.isEmpty(commandMap.get("search_end_date").toString())) {		    		
			search_end_date_time = CommonUtil.dateToLong(commandMap.get("search_end_date").toString(), "yyyy.MM.dd");
		}

		ArrayList<Map<String, Object>> chart_data = new ArrayList<Map<String, Object>>();
        ArrayList<Map<String, Object>> list_data = new ArrayList<Map<String, Object>>();
        
        int total_pledge_count = 0;
        int total_withdraw_count = 0;
        int total_hold_count = 0;
        int total_dead_count = 0;
        int total_overlap_count = 0;
        int total_other_count = 0;
        long day = search_start_date_time;
        
        for(int idx=0; day<(search_end_date_time); idx++) {
        	//CommonUtil.DateFormat(
        	day = CommonUtil.timestampAddDay(search_start_date_time, idx);        	
        	String day_string = CommonUtil.longToDateFormat(Long.toString(day), "MM.dd");
        	String day_string2 = CommonUtil.longToDateFormat(Long.toString(day), "yyyy.MM.dd");
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day)); 
        	commandMap.put("user_pledge_date", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("user_recognize_type", 1);
        	int pledge_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());
        	total_pledge_count += pledge_count;
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day)); 
        	commandMap.put("user_pledge_date", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("user_recognize_type", 2);
        	int withdraw_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());
        	total_withdraw_count += withdraw_count;
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day));
        	commandMap.put("user_pledge_date", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("user_recognize_type", 3);
        	int hold_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());
        	total_hold_count += hold_count;
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day));
        	commandMap.put("user_pledge_date", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("user_recognize_type", 4);
        	int dead_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());
        	total_dead_count += dead_count;
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day));
        	commandMap.put("user_pledge_date", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("user_recognize_type", 5);
        	int overlap_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());
        	total_overlap_count += overlap_count;
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day));
        	commandMap.put("user_pledge_date", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("user_recognize_type", 6);
        	int other_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.selectCount", commandMap).toString());
        	total_other_count += other_count;
        	
        	int total_count = pledge_count + withdraw_count + hold_count + dead_count + overlap_count + other_count;
        	Map<String, Object> dataMap = new LinkedHashMap<String, Object>();
        	
        	dataMap.put("day", day_string2);
        	dataMap.put("pledge", pledge_count);
        	dataMap.put("pledge_percentage", CommonUtil.calculatePercentage(pledge_count, total_count)+" %");
        	dataMap.put("withdraw", withdraw_count);
        	dataMap.put("withdraw_percentage", CommonUtil.calculatePercentage(withdraw_count, total_count)+" %");
        	dataMap.put("hold", hold_count);
        	dataMap.put("hold_percentage", CommonUtil.calculatePercentage(hold_count, total_count)+" %");
        	dataMap.put("dead", dead_count);
        	dataMap.put("dead_percentage", CommonUtil.calculatePercentage(dead_count, total_count)+" %");
        	dataMap.put("overlap", overlap_count);
        	dataMap.put("overlap_percentage", CommonUtil.calculatePercentage(overlap_count, total_count)+" %");
        	dataMap.put("other", other_count);
        	dataMap.put("other_percentage", CommonUtil.calculatePercentage(other_count, total_count)+" %");
        	
        	list_data.add(dataMap);        	                         
        }
        
        Map<String, Object> chartPledgeMap = new LinkedHashMap<String, Object>();        
        chartPledgeMap.put("gubun", enumValue.getValue("user_recognize_type", "1"));
        chartPledgeMap.put("pledge", total_pledge_count);        
        chart_data.add(chartPledgeMap);
        
        Map<String, Object> chartWithdrawMap = new LinkedHashMap<String, Object>();
        chartWithdrawMap.put("gubun", enumValue.getValue("user_recognize_type", "2"));
        chartWithdrawMap.put("pledge", total_withdraw_count);
        chart_data.add(chartWithdrawMap);
        
        Map<String, Object> chartHoldMap = new LinkedHashMap<String, Object>();
        chartHoldMap.put("gubun", enumValue.getValue("user_recognize_type", "3"));
        chartHoldMap.put("pledge", total_hold_count);
        chart_data.add(chartHoldMap);
        
        Map<String, Object> chartDeadMap = new LinkedHashMap<String, Object>();
        chartDeadMap.put("gubun", enumValue.getValue("user_recognize_type", "4"));
        chartDeadMap.put("pledge", total_dead_count);
        chart_data.add(chartDeadMap);
        
        Map<String, Object> chartOverlapMap = new LinkedHashMap<String, Object>();
        chartOverlapMap.put("gubun", enumValue.getValue("user_recognize_type", "5"));
        chartOverlapMap.put("pledge", total_overlap_count);
        chart_data.add(chartOverlapMap);
        
        Map<String, Object> chartOtherMap = new LinkedHashMap<String, Object>();
        chartOtherMap.put("gubun", enumValue.getValue("user_recognize_type", "6"));
        chartOtherMap.put("pledge", total_other_count);
        chart_data.add(chartOtherMap);
		
		rtnMap.put("total_pledge_count", total_pledge_count);
		rtnMap.put("total_withdraw_count", total_withdraw_count);
		rtnMap.put("total_hold_count", total_hold_count);
		rtnMap.put("total_dead_count", total_dead_count);
		rtnMap.put("total_overlap_count", total_overlap_count);
		rtnMap.put("total_other_count", total_other_count);
		rtnMap.put("chart_data_array", chart_data);
		rtnMap.put("data_list_data_array", list_data);
		return rtnMap;
	}

	@Override
	public int brainDonateStatsEndIdx() {

		return webcoDAO.brainDonateStatsEndIdx("UserDAO.brainDonateStatsEndIdx");
	}

	@Override
	public int organDonateStatsEndIdx() {
		
		return webcoDAO.organDonateStatsEndIdx("UserDAO.organDonateStatsEndIdx");
	}

	@Override
	public int hopeDonateStatsEndIdx() {

		return webcoDAO.hopeDonateStatsEndIdx("UserDAO.hopeDonateStatsEndIdx");
	}

	@Override
	public int donateStatsTrendEndIdx() {

		return webcoDAO.donateStatsTrendEndIdx("UserDAO.donateStatsTrendEndIdx");
	}

	@Override
	public int boardContEndIdx() {

		return webcoDAO.boardContEndIdx("UserDAO.boardContEndIdx");
	}

	@Override
	public Map<String, Object> getPageView(Map<String, Object> commandMap)
			throws Exception {
		
		// TODO Auto-generated method stub
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		EnumValue enumValue = new EnumValue();
		long search_start_date_time = 0;
		long search_end_date_time = 0;
		if(!EgovStringUtil.isEmpty(commandMap.get("search_start_date").toString())) {		    		
			search_start_date_time = CommonUtil.dateToLong(commandMap.get("search_start_date").toString(), "yyyy.MM.dd");
		}
		
		if(!EgovStringUtil.isEmpty(commandMap.get("search_end_date").toString())) {		    		
			search_end_date_time = CommonUtil.dateToLong(commandMap.get("search_end_date").toString(), "yyyy.MM.dd");
		}
		
		ArrayList<Map<String, Object>> chart_data = new ArrayList<Map<String, Object>>();
        ArrayList<Map<String, Object>> list_data = new ArrayList<Map<String, Object>>();
        
        int total_donate_count = 0; //장기조직 기증
        int total_remembrance_count = 0; //기증자예우
        int total_notification_count = 0; //홍보·소식
        int total_info_count = 0; //정보공개
        int total_koda_count = 0; //koda
        int total_mailbox_count = 0; //생명나눔우체통
        int total_hopeDonateStats_count = 0; //기증희망등록
        long day = search_start_date_time;
        
        for(int idx=0; day<(search_end_date_time); idx++) {
        	//CommonUtil.DateFormat(
        	day = CommonUtil.timestampAddDay(search_start_date_time, idx);        	
        	String day_string = CommonUtil.longToDateFormat(Long.toString(day), "MM.dd");
        	String day_string2 = CommonUtil.longToDateFormat(Long.toString(day), "yyyy.MM.dd");
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day)); 
        	commandMap.put("act_time", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("dp1_idx", 1);
        	int donate_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.pageViewSelectCount", commandMap).toString());
        	total_donate_count += donate_count;
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day)); 
        	commandMap.put("act_time", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("dp1_idx", 2);
        	int remembrance_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.pageViewSelectCount", commandMap).toString());
        	total_remembrance_count += remembrance_count;
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day));
        	commandMap.put("act_time", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("dp1_idx", 3);
        	int notification_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.pageViewSelectCount", commandMap).toString());
        	total_notification_count += notification_count;
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day));
        	commandMap.put("act_time", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("dp1_idx", 4);
        	int info_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.pageViewSelectCount", commandMap).toString());
        	total_info_count += info_count;
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day));
        	commandMap.put("act_time", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("dp1_idx", 5);
        	int koda_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.pageViewSelectCount", commandMap).toString());
        	total_koda_count += koda_count;
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day));
        	commandMap.put("act_time", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("dp1_idx", 6);
        	int mailbox_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.pageViewSelectCount", commandMap).toString());
        	total_mailbox_count += mailbox_count;
        	
        	commandMap.clear();
        	//commandMap.put("user_pledge_date", Long.toString(day));
        	commandMap.put("act_time", CommonUtil.longToDateFormat(Long.toString(day), "yyyy-MM-dd"));
        	commandMap.put("dp1_idx", 7);
        	int hopeDonateStats_count = Integer.parseInt(webcoDAO.selectByPk("UserDAO.pageViewSelectCount", commandMap).toString());
        	total_hopeDonateStats_count += hopeDonateStats_count;
        	
        	int total_count = donate_count + remembrance_count + notification_count + info_count + koda_count + mailbox_count + hopeDonateStats_count;
        	Map<String, Object> dataMap = new LinkedHashMap<String, Object>();
        	
        	dataMap.put("day", day_string2);
        	dataMap.put("donate", donate_count);
        	dataMap.put("donate_percentage", CommonUtil.calculatePercentage(donate_count, total_count)+" %");
        	dataMap.put("remembrance", remembrance_count);
        	dataMap.put("remembrance_percentage", CommonUtil.calculatePercentage(remembrance_count, total_count)+" %");
        	dataMap.put("notification", notification_count);
        	dataMap.put("notification_percentage", CommonUtil.calculatePercentage(notification_count, total_count)+" %");
        	dataMap.put("info", info_count);
        	dataMap.put("info_percentage", CommonUtil.calculatePercentage(info_count, total_count)+" %");
        	dataMap.put("koda", koda_count);
        	dataMap.put("koda_percentage", CommonUtil.calculatePercentage(koda_count, total_count)+" %");
        	dataMap.put("mailbox", mailbox_count);
        	dataMap.put("mailbox_percentage", CommonUtil.calculatePercentage(mailbox_count, total_count)+" %");
        	dataMap.put("hopeDonateStats", hopeDonateStats_count);
        	dataMap.put("hopeDonateStats_percentage", CommonUtil.calculatePercentage(hopeDonateStats_count, total_count)+" %");
        	
        	list_data.add(dataMap);        	                         
        }
        
        Map<String, Object> chartDonateMap = new LinkedHashMap<String, Object>();        
        chartDonateMap.put("gubun", enumValue.getValue("dp1_idx", "1"));
        chartDonateMap.put("pledge", total_donate_count);        
        chart_data.add(chartDonateMap);
        
        Map<String, Object> chartRemembranceMap = new LinkedHashMap<String, Object>();
        chartRemembranceMap.put("gubun", enumValue.getValue("dp1_idx", "2"));
        chartRemembranceMap.put("pledge", total_remembrance_count);
        chart_data.add(chartRemembranceMap);
        
        Map<String, Object> chartNotificationMap = new LinkedHashMap<String, Object>();
        chartNotificationMap.put("gubun", enumValue.getValue("dp1_idx", "3"));
        chartNotificationMap.put("pledge", total_notification_count);
        chart_data.add(chartNotificationMap);
        
        Map<String, Object> chartInfoMap = new LinkedHashMap<String, Object>();
        chartInfoMap.put("gubun", enumValue.getValue("dp1_idx", "4"));
        chartInfoMap.put("pledge", total_info_count);
        chart_data.add(chartInfoMap);
        
        Map<String, Object> chartKodaMap = new LinkedHashMap<String, Object>();
        chartKodaMap.put("gubun", enumValue.getValue("dp1_idx", "5"));
        chartKodaMap.put("pledge", total_koda_count);
        chart_data.add(chartKodaMap);
        
        Map<String, Object> chartMailboxMap = new LinkedHashMap<String, Object>();
        chartMailboxMap.put("gubun", enumValue.getValue("dp1_idx", "6"));
        chartMailboxMap.put("pledge", total_mailbox_count);
        chart_data.add(chartMailboxMap);
		
        Map<String, Object> chartHopeDonateStatsMap = new LinkedHashMap<String, Object>();
        chartHopeDonateStatsMap.put("gubun", enumValue.getValue("dp1_idx", "7"));
        chartHopeDonateStatsMap.put("pledge", total_hopeDonateStats_count);
        chart_data.add(chartHopeDonateStatsMap);
        
		rtnMap.put("total_donate_count", total_donate_count);
		rtnMap.put("total_remembrance_count", total_remembrance_count);
		rtnMap.put("total_notification_count", total_notification_count);
		rtnMap.put("total_info_count", total_info_count);
		rtnMap.put("total_koda_count", total_koda_count);
		rtnMap.put("total_mailbox_count", total_mailbox_count);
		rtnMap.put("total_hopeDonateStats_count", total_hopeDonateStats_count);
		rtnMap.put("chart_data_array", chart_data);
		rtnMap.put("data_list_data_array", list_data);
		return rtnMap;
	}

}
