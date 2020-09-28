package egovframework.webco.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class CommonUtil {
	
	public static String currentDate(String format) {
		Calendar cal = new GregorianCalendar(Locale.KOREA);
	    cal.setTime(new Date());
	    
	    SimpleDateFormat fm = new SimpleDateFormat(format);
	    String strDate = fm.format(cal.getTime());

		return strDate;
	}
	
	public static String DateAddDay(String format, int day) {
		Calendar cal = new GregorianCalendar(Locale.KOREA);
	    cal.setTime(new Date());
	    cal.add(Calendar.DAY_OF_YEAR, day); // day를 더한다.
	     
	    SimpleDateFormat fm = new SimpleDateFormat(format);
	    String strDate = fm.format(cal.getTime());
	    return strDate;
	}
	
	public static long timestampAddDay(long timestamp, int day) {
		Date date = new Date(timestamp * 1000);
		Calendar cal = new GregorianCalendar(Locale.KOREA);
	    cal.setTime(date);
	    cal.add(Calendar.DAY_OF_YEAR, day); // day를 더한다.
	    
	    long ts = cal.getTime().getTime()/1000;    
	    return ts;
	}
	
	public static String longToDateFormat(String timestamp, String format) {
		String dateText = "";
		if(timestamp != null && !("").equals(timestamp) && !("0").equals(timestamp)) { 
			Date date = new Date(Long.parseLong(timestamp) * 1000);
	        SimpleDateFormat df2 = new SimpleDateFormat(format);
	        dateText = df2.format(date);
		}
        return dateText;
	}
	
	public static String DateFormat(String Date, String format) throws ParseException {
		String dateText = "";
		Date sdate;
		if(Date != null && !("").equals(Date) && !("0000-00-00").equals(Date)) {
			if(Date.length() == 10) {
				sdate = new SimpleDateFormat("yyyy-MM-dd").parse(Date);
			} else {
				sdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(Date);
			}
			SimpleDateFormat dateFormat = new SimpleDateFormat(format);
			dateText = dateFormat.format(sdate);
		}		
		return dateText;
	}
	
	public static String DateFormatChg(String Date, String format, String format2) throws ParseException {
		String dateText = "";
		Date sdate;
		if(Date != null && !("").equals(Date) && !("0000-00-00").equals(Date) && !("0000-00-00 00:00:00").equals(Date)) {
			sdate = new SimpleDateFormat(format).parse(Date);
			SimpleDateFormat dateFormat = new SimpleDateFormat(format2);
			dateText = dateFormat.format(sdate);
		}		
		return dateText;
	}
	
	public static long dateToLong(String Date, String format) throws ParseException {
		SimpleDateFormat dateFormat = new SimpleDateFormat(format);
		
		long ts = dateFormat.parse(Date).getTime()/1000;
        return ts;
	}
	
	public static int getKoreaAge(String timestamp) {
		int age = 0;
		if(timestamp != null && !("").equals(timestamp)) { 
			Date date = new Date(Long.parseLong(timestamp) * 1000);
			Calendar today = Calendar.getInstance();
			Calendar brith = Calendar.getInstance();
			brith.setTime(date);
			age = today.get(Calendar.YEAR) - brith.get(Calendar.YEAR) + 1;
		}		
		
		return age;
	}
	
	public static String calculatePercentage(double obtained, double total) {
		double percentage = 0;
		if(total > 0) {
			percentage = Double.parseDouble(String.format("%.2f", obtained * 100 / total));
		}
        return String.format("%.2f", percentage);
    }
	
	public static JSONArray getArrayListToJSONArray(Object obj) 
	{
		return JSONArray.fromObject(obj);
	}
	
	public static JSONObject getObjectToJSONObject(Object obj) 
	{
		return JSONObject.fromObject(obj);
	}
	
	public static JSONObject getJsonStringFromMap( Map<String, Object> map )
    {
        JSONObject jsonObject = new JSONObject();
        for( Map.Entry<String, Object> entry : map.entrySet() ) {
            String key = entry.getKey();
            Object value = entry.getValue();
            jsonObject.put(key, value);
        }
        
        return jsonObject;
    }
    
    /**
     * List<Map>을 jsonArray로 변환한다.
     *
     * @param list List<Map<String, Object>>.
     * @return JSONArray.
     */
    public static JSONArray getJsonArrayFromList( List<Map<String, Object>> list )
    {
        JSONArray jsonArray = new JSONArray();
        for( Map<String, Object> map : list ) {
            jsonArray.add( getJsonStringFromMap( map ) );
        }
        
        return jsonArray;
    }       
    
    /**
     * 전달된 파라미터에 맞게 난수를 생성한다
     * @param len : 생성할 난수의 길이
     * @param dupCd : 중복 허용 여부 (1: 중복허용, 2:중복제거)
     * 
     * Created by 닢향
     * http://niphyang.tistory.com
     */
    public static String numberGen(int len, int dupCd ) {
        
        Random rand = new Random();
        String numStr = ""; //난수가 저장될 변수
        
        for(int i=0;i<len;i++) {
            
            //0~9 까지 난수 생성
            String ran = Integer.toString(rand.nextInt(10));
            
            if(dupCd==1) {
                //중복 허용시 numStr에 append
                numStr += ran;
            }else if(dupCd==2) {
                //중복을 허용하지 않을시 중복된 값이 있는지 검사한다
                if(!numStr.contains(ran)) {
                    //중복된 값이 없으면 numStr에 append
                    numStr += ran;
                }else {
                    //생성된 난수가 중복되면 루틴을 다시 실행한다
                    i-=1;
                }
            }
        }
        return numStr;
    }

}
