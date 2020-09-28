package egovframework.webco.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.InetAddress;
import java.net.Socket;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import java.util.Random;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import sun.misc.BASE64Encoder;


public class SMSManager {
	
	/** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());
    
	private final static String apiUrl = EgovProperties.getProperty("SMS.apiUrl");
	private final static String smsReMainUrl = EgovProperties.getProperty("SMS.smsReMainUrl");
	private final static String userAgent = EgovProperties.getProperty("SMS.userAgent");
	private final static String charsetType = EgovProperties.getProperty("SMS.charsetType");
	private final static String testflag = EgovProperties.getProperty("SMS.testflag");
	private final static String userId = EgovProperties.getProperty("SMS.userId"); //SMS 아이디.
	private final static String secure = EgovProperties.getProperty("SMS.secure");   //인증키
	 
    public Map sendSmsAsync(Map<String, Object> param) {
    	
    	Map<String, Object> rtnMap = new HashMap<String, Object>();
    	rtnMap.put("rtnCode", "");
    	
    	if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(param.get("smsType")))) {    		
			param.put("smsType", "S");
		}

    	if(EgovStringUtil.isNullToString(param.get("smsType")).equals(("S")) &&
    			EgovStringUtil.isNullToString(param.get("msg")).getBytes().length > 90) {
    		param.put("smsType", "L");
    	}
    	
    	log.info("==============smsType"+param.get("smsType").toString());
    		   
	    	
    	if(testflag.equals("Y")) {
    		param.put("testflag", testflag);			  
			log.info("==============Test Mode 발송");
		} 
    	
    	try {
    		log.info("==============SMS 발송 시작");
    		
    		String[] host_info = apiUrl.split("/");
    		String host = host_info[2];
    		String path = "/" + host_info[3];
    		int port = 80;
    		
    		String boundary = "";
    		Random rnd = new Random();
    		String rndKey = Integer.toString(rnd.nextInt(32000));
    		MessageDigest md = MessageDigest.getInstance("MD5");
    		byte[] byteData = rndKey.getBytes();
    		md.update(byteData);
    		byte[] digest = md.digest();
    		for(int i=0; i<digest.length; i++) {
    			boundary = boundary + Integer.toHexString(digest[i] & 0xFF);
    		}	    		
    		boundary = "---------------------" + boundary.substring(0, 11);    		
    		
    		param.put("user_id", userId);
    		param.put("secure", secure);
    		param.put("mode", "1"); // base64사용시 반드시 1로 셋팅
    		param.put("rdate", "");			// 예약날짜 - 예) 20190420
    		param.put("rtime", "");			// 예약시간 - 예) 173000
    		param.put("destination", "");	// 이름삽입번호 
    		param.put("repeatFlag", "");	// 반복설정 - 반복설정을 원하는 경우 Y
    		param.put("repeatNum", "");		// 반복횟수 - 1~10회 가능
    		param.put("repeatTime", "");	// 반복시간 - 15분 이상부터 가능
    		param.put("returnurl", "");		// 리턴 URL - 메시지 전송 후 이동할 페이지
    		param.put("nointeractive", ""); // 사용할 경우 1   		
    		
    		// 본문생성
    		String data = "";
    		for( Entry<String, Object> elem : param.entrySet() ){
    			data +="--"+boundary+"\r\n";
    			data += "Content-Disposition: form-data; name=\""+elem.getKey()+"\"\r\n";
    			data += "\r\n"+base64endcode(elem.getValue().toString())+"\r\n";
    			data +="--"+boundary+"\r\n";
    		}
    		
    		InetAddress addr = InetAddress.getByName(host);
    		Socket socket = new Socket(host, port);
    		
    		// Header 전송
    		BufferedWriter wr = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), charsetType));
    		wr.write("POST "+path+" HTTP/1.0\r\n");
    		wr.write("Content-Length: "+data.length()+"\r\n");
    		wr.write("Content-type: multipart/form-data, boundary="+boundary+"\r\n");
    		wr.write("\r\n");
    		
    		// 데이터 전송
    		wr.write(data);
    		wr.flush();
    		log.info("==============요청정보 : "+data);
    		BufferedReader rd = new BufferedReader(new InputStreamReader(socket.getInputStream(), charsetType));
    		
    		String line;	    		
    		ArrayList responseData = new ArrayList();
    		while((line = rd.readLine()) != null) {
    			responseData.add(line);
    		}
    		wr.close();
    		rd.close();
    		
    		log.info("==============전송결과 : "+responseData);
    		
    		String tmpMsg = (String)responseData.get(responseData.size()-1);
    		String[] rMsg = tmpMsg.split(",");
    		String result = rMsg[0]; //발송결과
    		String Count = ""; // 잔여건수
    		if(rMsg.length > 1) {
    			Count = rMsg[1];
    		}
    		
    		rtnMap.put("rtnCode", result);
    		
    		if(result.equals("success")) {
    			rtnMap.put("rtnMsg", "성공적으로 발송하였습니다. 잔여건수는 "+Count+"입니다.");
    		} else if(result.equals("reserved")) {
    			rtnMap.put("rtnMsg", "성공적으로 예약하였습니다. 잔여건수는 "+Count+"입니다.");
    		} else if(result.equals("3205")) {
    			rtnMap.put("rtnMsg", "잘못된 번호형식입니다.");
    		} else if(result.equals("0044")) {
    			rtnMap.put("rtnMsg", "스팸문자는 발송되지 않습니다.");
    		} else if(result.equals("Test Success!")) {
    			rtnMap.put("rtnMsg", "TEST 정상");
    		} else {
    			rtnMap.put("rtnMsg", "[Error]"+result);	    		
    		}
    		
    		/*
    		URL url = new URL(apiUrl);
    		HttpURLConnection con = (HttpURLConnection) url.openConnection();
    		con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
    		con.setRequestProperty("Accept-charsetType", charsetType);
    		con.setRequestProperty("User-Agent", userAgent);
    		con.setRequestMethod("POST");
    		
    		if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(param.get("smsType")))) {
    			param.put("smsType", "S");
    		}
    		String postParams = "user_id=" + base64endcode(userId) + 
    							"&secure=" + base64endcode(secure) +
    							"&msg=" + base64endcode(param.get("msg").toString()) +
    							"&rphone=" + base64endcode(param.get("rphone").toString()) +
    							"&sphone1=" + base64endcode(param.get("sphone1").toString()) +
    							"&sphone2=" + base64endcode(param.get("sphone2").toString()) +
    							"&sphone3=" + base64endcode(param.get("sphone3").toString()) +
    							"&mode=" + base64endcode("1") +
    							"&smsType=" + base64endcode(param.get("smsType").toString());
    		if(isTest) {
    			postParams += "&testflag=" + base64endcode("Y");   
    			log.info("==============Test Mode 발송");
    		} 
    		log.info("==============파리미터 : "+postParams);
    		con.setDoOutput(true);
    		OutputStream out = con.getOutputStream();
    		out.write(postParams.getBytes());
    		out.flush();
    		out.close();
    		
    		int responseCode = con.getResponseCode();
    		log.info("==============전송결과 : "+responseCode);
    		
    		if(responseCode == HttpURLConnection.HTTP_OK) {
    			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
    			String inputLine;
    			StringBuffer buf = new StringBuffer();
    			
    			while((inputLine = in.readLine()) != null) {
    				buf.append(inputLine);
    			}
    			in.close();
    			
    			log.info("==============SMS Content : "+buf.toString());
    		} else {
    			log.error("==============POST request not worked");
    		}*/
    		log.info("==============SMS 발송 완료");	    	
    	} catch (IOException e) {
    		log.error("==============IOException : "+e.toString());
    	} catch (Exception e) {
    		log.error("==============Exception : "+e.toString());
    	}      	
    	
    	return rtnMap;
    }
    
    // 잔여건수 조회
    public int getSmsCount() {    	
    	int count = 0;
    	
    	Map<String, Object> param = new HashMap<String, Object>();
    	
    	if(testflag.equals("Y")) {
    		param.put("testflag", testflag);			  
			log.info("==============Test Mode 발송");
		} 
	    	
    	try {
    		log.info("==============잔여건수 조회 시작");
    		
    		String[] host_info = smsReMainUrl.split("/");
    		String host = host_info[2];
    		String path = "/" + host_info[3];
    		int port = 80;
    		
    		String boundary = "";
    		Random rnd = new Random();
    		String rndKey = Integer.toString(rnd.nextInt(32000));
    		MessageDigest md = MessageDigest.getInstance("MD5");
    		byte[] byteData = rndKey.getBytes();
    		md.update(byteData);
    		byte[] digest = md.digest();
    		for(int i=0; i<digest.length; i++) {
    			boundary = boundary + Integer.toHexString(digest[i] & 0xFF);
    		}	    		
    		boundary = "---------------------" + boundary.substring(0, 11);
    		
    		param.put("user_id", userId);
    		param.put("secure", secure);
    		param.put("mode", "1"); // base64사용시 반드시 1로 셋팅
    		// 본문생성
    		String data = "";
    		for( Entry<String, Object> elem : param.entrySet() ){
    			data +="--"+boundary+"\r\n";
    			data += "Content-Disposition: form-data; name=\""+elem.getKey()+"\"\r\n";
    			data += "\r\n"+base64endcode(elem.getValue().toString())+"\r\n";
    			data +="--"+boundary+"\r\n";
    		}
    		
    		InetAddress addr = InetAddress.getByName(host);
    		Socket socket = new Socket(host, port);
    		
    		// Header 전송
    		BufferedWriter wr = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), charsetType));
    		wr.write("POST "+path+" HTTP/1.0\r\n");
    		wr.write("Content-Length: "+data.length()+"\r\n");
    		wr.write("Content-type: multipart/form-data, boundary="+boundary+"\r\n");
    		wr.write("\r\n");
    		
    		// 데이터 전송
    		wr.write(data);
    		wr.flush();
    		
    		BufferedReader rd = new BufferedReader(new InputStreamReader(socket.getInputStream(), charsetType));
    		
    		String line;
    		String alert;
    		ArrayList responseData = new ArrayList();
    		while((line = rd.readLine()) != null) {
    			responseData.add(line);
    		}
    		wr.close();
    		rd.close();
    		
    		log.info("==============전송결과 : "+responseData);
    		
    		String tmpMsg = (String)responseData.get(responseData.size()-1);    		
    		count = Integer.parseInt(tmpMsg);
    		log.info("==============잔여건수 : "+count);    		    	
    		log.info("==============잔여건수 조회 종료");    	
    	} catch (IOException e) {
    		log.error("==============IOException : "+e.toString());
    	} catch (Exception e) {
    		log.error("==============Exception : "+e.toString());
    	}      	
    	
    	return count;
    }
    
    public static String base64endcode(String str) {
    	BASE64Encoder encoder = new BASE64Encoder();
    	byte[] strByte = str.getBytes();
    	String result = encoder.encode(strByte);
    	return result;
    }
}
