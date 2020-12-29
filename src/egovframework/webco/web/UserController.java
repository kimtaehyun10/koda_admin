package egovframework.webco.web;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.webco.service.AdminService;
import egovframework.webco.service.UserService;
import egovframework.webco.service.WebcoService;
import egovframework.webco.util.CommonUtil;
import egovframework.webco.util.EnumValue;
import egovframework.webco.util.NameCheck;
import egovframework.webco.util.SMSManager;
import egovframework.webco.util.SessionUtil;
import egovframework.webco.vo.AdminVO;
import net.sf.json.JSONObject;

@Controller
public class UserController {

    /** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name = "userService")
    private UserService userService;   
    
    @Resource(name = "webcoService")
    private WebcoService webcoService; 
    
    @Resource(name = "adminService")
    private AdminService adminService;
    
    private String menuId = "user";
    
    private String fileStorePath = EgovProperties.getProperty("globals.fileStorePath");
    
    /**
     * 서약자관리 화면
     * @return String
     * @exception Exception
     */
	@RequestMapping("/user/userList.do") 
	public String userList(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{	    
	    	
    	List<Map<String, Object>> smsFormList = webcoService.list_map("SmsFormDAO.selectList", commandMap);			
    	EnumValue enumValue = new EnumValue();    	
    	model.addAttribute("enum_array", CommonUtil.getObjectToJSONObject(enumValue.getEnumArray()));
        model.addAttribute("sms_form_list",     CommonUtil.getJsonArrayFromList(smsFormList));
        model.addAttribute("data_get",     CommonUtil.getObjectToJSONObject(commandMap));
        model.addAttribute("menu",     menuId);
        
        adminService.insertActHist("L", "[등록자]목록 조회");
        return "user/userList";   
	}  
	
	/**
     * 서약자 상세조회 화면
     * @return String
     * @exception Exception
     */
	@RequestMapping("/user/detail.do")
	public String userDetail(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{	    
		String user_name = "";
    	EnumValue enumValue = new EnumValue();
    	if(commandMap.get("user_index") != null && !("").equals(commandMap.get("user_index").toString())) {
    		Map<String, Object> userInfo = userService.selectUserInfo(commandMap);		    		    	
    		model.addAttribute("user_detail",     CommonUtil.getObjectToJSONObject(userInfo));
    		user_name=(String)userInfo.get("user_name"); 
    		List<Map<String, Object>> consultList =  webcoService.list_map("ConsultDAO.selectUserConsultList", commandMap);
	    	for( Map<String, Object> consult : consultList ) {
	    		consult.put("consult_date", CommonUtil.DateFormat(consult.get("consult_date").toString(), "yyyy.MM.dd"));
	    	}
	        model.addAttribute("consult_list",     CommonUtil.getJsonArrayFromList(consultList));
	        //첨부파일
	        commandMap.put("attach_type", "USR");
	        Map<String, Object> userAttach = userService.userAttach(commandMap);
	        model.addAttribute("userAttach",userAttach);
	        //
    	} else {
    		Map<String, Object> userInfo = new HashMap<String, Object>();
    		userInfo.put("user_register", SessionUtil.getAdminNickName());
    		userInfo.put("user_pledge_card_state", 1);
    		model.addAttribute("user_detail",     CommonUtil.getObjectToJSONObject(userInfo));
    	}
    	
    	
        model.addAttribute("enum_array", CommonUtil.getObjectToJSONObject(enumValue.getEnumArray()));
        model.addAttribute("menu",     menuId); 
        
        adminService.insertActHist("R", "[등록자]상세 조회 user_index : "+EgovStringUtil.isNullToString(commandMap.get("user_index")), user_name);
        return "user/userDetail"; 
	}  
	
	/**
     * 서약자정보 수정
     * @return String
     * @exception Exception
     */
	@RequestMapping("/user/addUser.do")
	public String addUser(ModelMap model, @RequestParam Map<String, Object> commandMap
			,HttpServletRequest request, HttpServletResponse response) throws Exception{
		String status = EgovStringUtil.isNullToString(commandMap.get("status"));
		
		if(!status.equals("1")) {
			return "redirect:/user/detail.do";
		}
		int result = (int) userService.saveUserInfo(commandMap);
		String msg = "서약자 정보가 저장되었습니다.";
		if(result <= 0) {    		
    		msg = "서약자 정보 저장 중 오류가 발생하였습니다. 잠시 후 다시 시도해주시기 바랍니다.";
    	}
    	response.setContentType("text/html; charset=UTF-8");    	 
    	PrintWriter out = response.getWriter();    	
    	//out.println("<script>alert('"+msg+"'); location.href='./detail.do?user_index="+result+"';</script>");    	 
    	out.println("<script>alert('"+msg+"'); location.href='./userList.do';</script>");
    	out.flush(); 
		
		return "user/userList";
	}
	
	/**
     * 서약자정보 수정
     * @return String
     * @exception Exception
     */
	@RequestMapping("/user/update.do")
	public String update(ModelMap model, @RequestParam Map<String, Object> commandMap
			,HttpServletRequest request, HttpServletResponse response, @RequestParam("org_file_name") MultipartFile multipartFile) throws Exception{
		String status = EgovStringUtil.isNullToString(commandMap.get("status"));
		
		if(!status.equals("1")) {
			return "redirect:/user/userList.do";
		}
		int result = (int) userService.saveUserInfo(commandMap);
		String msg = "서약자 정보가 저장되었습니다.";
		
		////////////첨부파일
    	try {
			// 파일 정보
			String originFilename = multipartFile.getOriginalFilename();
			
			if(!"".equals(originFilename) && originFilename!=null){
				String extName
				= originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			Long size = multipartFile.getSize();
			
			// 서버에서 저장 할 파일 이름
			String saveFileName = genSaveFileName(extName);
			
			commandMap.put("org_file_name", originFilename);
			commandMap.put("re_file_name", saveFileName);
			commandMap.put("attach_no", commandMap.get("user_index"));
			commandMap.put("attach_type", "USR");
			
			writeFile(multipartFile, saveFileName, request);
			
			//첨부파일존재 여부	        
	        Map<String, Object> userAttach = userService.userAttach(commandMap);
	        if(!"".equals(userAttach) && userAttach!=null){
				//attach 테이블 수정
	        	adminService.attachUpdate(commandMap);
	        }else{
				//attach 테이블 등록
				adminService.attachSave(commandMap);
	        }	     
			
			}										

		}
		catch (IOException e) {
			
			throw new RuntimeException(e);
		}
		//////////////
		
		if(result <= 0) {    		
    		msg = "서약자 정보 저장 중 오류가 발생하였습니다. 잠시 후 다시 시도해주시기 바랍니다.";
    	} else {
    		if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_index")))) {
    			adminService.insertActHist("I", "[등록자]신규 등록 user_index : "+result);
    		} else {
    			adminService.insertActHist("U", "[등록자]정보 수정 user_index : "+result);
    		}
    	}
    	response.setContentType("text/html; charset=UTF-8");    	 
    	PrintWriter out = response.getWriter();    	
    	//out.println("<script>alert('"+msg+"'); location.href='./detail.do?user_index="+result+"';</script>");    	 
    	out.println("<script>alert('"+msg+"'); location.href='./userList.do';</script>");    	 
    	out.flush(); 		    	    	    	
    	
		return "user/userList";
	}
	
	/**
     * 서약자 목록조회 Ajax
     * @return JSONObject
     * @exception Exception
     */  
	@RequestMapping("/user/getUserListAjax.do")
	public @ResponseBody JSONObject getUserListAjax(ModelMap model, 	
			@RequestParam(value="search_keyword_type_array[]", required = false) String[] search_keyword_type_array, 
			@RequestParam(value="search_keyword_array[]", required = false) String[] search_keyword_array,
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{
					
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {			
		    
		    	int limit = 300;
		    	
				int page = Integer.parseInt(commandMap.get("page").toString());		    	
		    	int offset = page > 0 ? (page-1) * limit : 0;
		    			    	
		    	commandMap.put("offset", offset);
		    	commandMap.put("limit", limit);
		    	
		    	long ts;
		    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		    	
				for(int i=0; i < search_keyword_type_array.length; i++) {
					String search_keyword_type = search_keyword_type_array[i].toString();
					String search_keyword = search_keyword_array[i].toString();
					if(search_keyword != null && !search_keyword.equals("") && (search_keyword_type == "user_birthday" || search_keyword_type == "user_pledge_date" || search_keyword_type == "user_registration_date" 
							|| search_keyword_type == "user_konos_registration_date" || search_keyword_type == "user_withdraw_date" || search_keyword_type == "user_konos_withdraw_date")) {
						
			        	//System.out.println(curDate);
			        	//ts = dateFormat.parse(search_keyword.replaceAll("-", "")).getTime()/1000;
			        	//search_keyword = Long.toString(ts);
			        	//search_keyword_array[i] = search_keyword;
					}
					commandMap.put("search_keyword_type"+(i+1), search_keyword_type);
					commandMap.put("search_keyword"+(i+1), search_keyword);
				}		
						
				if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("search_between_type")))) {
					commandMap.put("search_between_type", "user.user_pledge_date");
				}
				
				if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("search_start_date")))) {		    		
		    		commandMap.put("search_start_date", CommonUtil.DateFormatChg(commandMap.get("search_start_date").toString(), "yyyy.MM.dd", "yyyy-MM-dd"));
				}
				if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("search_end_date")))) {
					commandMap.put("search_end_date", CommonUtil.DateFormatChg(commandMap.get("search_end_date").toString(), "yyyy.MM.dd", "yyyy-MM-dd"));					
				}		
				
		    	rtnMap = userService.selectUserList(commandMap);							
		    	rtnMap.put("rtnCode", "");
		    	rtnMap.put("rtnMsg", "");		 			
		    
		} catch (Exception e) { 
			rtnMap.put("rtnCode", "-2");
	    	rtnMap.put("rtnMsg", e.toString());
            log.error(e);
        }
		rtnMap.put("search_value", commandMap);
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	
	/**
     * 서약자 엑셀내보내기 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/user/exportExcelAjax.do")
	public @ResponseBody JSONObject exportExcelAjax(ModelMap model, 	
			@RequestParam(value="search_keyword_type_array[]", required = false) String[] search_keyword_type_array, 
			@RequestParam(value="search_keyword_array[]", required = false) String[] search_keyword_array,
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{		
				
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {			
		    if (SessionUtil.isLoginChk() == false ) { // 로그인이 되어 있지 않다면 로그인 화면으로 이동
		    	rtnMap.put("rtnCode", "-1");
		    	rtnMap.put("rtnMsg", "로그인 후 이용해주시기 바랍니다.");
		    } else {
		    			    			    			    	
				for(int i=0; i < search_keyword_type_array.length; i++) {
					String search_keyword_type = search_keyword_type_array[i].toString();
					String search_keyword = search_keyword_array[i].toString();
					if(search_keyword != null && !search_keyword.equals("") && (search_keyword_type == "user_birthday" || search_keyword_type == "user_pledge_date" || search_keyword_type == "user_registration_date" 
							|| search_keyword_type == "user_konos_registration_date" || search_keyword_type == "user_withdraw_date" || search_keyword_type == "user_konos_withdraw_date")) {
						
			        	//System.out.println(curDate);
			        	//long ts = CommonUtil.dateToLong(search_keyword, "yyyy-MM-dd");
			        	//search_keyword = Long.toString(ts);
			        	//search_keyword_array[i] = search_keyword;
					}
					commandMap.put("search_keyword_type"+(i+1), search_keyword_type);
					commandMap.put("search_keyword"+(i+1), search_keyword);
				}		
						
				if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("search_between_type")))) {
					commandMap.put("search_between_type", "user.user_pledge_date");
				}
				
				if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("search_start_date")))) {		    		
		    		commandMap.put("search_start_date", CommonUtil.DateFormatChg(commandMap.get("search_start_date").toString(), "yyyy.MM.dd", "yyyy-MM-dd"));
				}
				if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("search_end_date")))) {
					commandMap.put("search_end_date", CommonUtil.DateFormatChg(commandMap.get("search_end_date").toString(), "yyyy.MM.dd", "yyyy-MM-dd"));					
				}
																		
				boolean result = userService.exportExcel(commandMap);
				
				if (result) {
					rtnMap.put("rtnCode", "");
					rtnMap.put("rtnMsg", "");
				} else {
					rtnMap.put("rtnCode", "-1");
			    	rtnMap.put("rtnMsg", "엑셀파일 생성에 실패하였습니다.");
				}
		    }               
		} catch (Exception e) {
			rtnMap.put("rtnCode", "-2");
	    	rtnMap.put("rtnMsg", e.toString());
            log.error(e);                   
        }
		
		rtnMap.put("search_value", commandMap);
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	 
	/**
     * 서약자 삭제 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/user/deleteUserAjax.do")
	public @ResponseBody JSONObject deleteUserAjax(ModelMap model, 				
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{		
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		int result =  webcoService.delete("UserDAO.delete", commandMap);		
		rtnMap.put("search_value", commandMap);
		rtnMap.put("rtnCode", result);
    	rtnMap.put("rtnMsg", "");
    	adminService.insertActHist("D", "[등록자]정보 삭제 user_index : "+EgovStringUtil.isNullToString(commandMap.get("user_index")));
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}	
	
	/**
     * SMS전체건수조회 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/user/getSMSTotalCountAjax.do")
	public @ResponseBody JSONObject getSMSTotalCountAjax(ModelMap model, 				
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{	
				
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		SMSManager smsManager = new SMSManager();		
		int sms_total_count = smsManager.getSmsCount();
		
		rtnMap.put("sms_total_count", sms_total_count);
		rtnMap.put("search_value", commandMap);
		rtnMap.put("rtnCode", "");		
    	rtnMap.put("rtnMsg", "");
    	
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}	
	
	/**
     * SMS발송 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/user/sendSMSAjax.do")
	public @ResponseBody JSONObject sendSMSAjax(ModelMap model, 				
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{	
				
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("rtnCode", "");		
    	rtnMap.put("rtnMsg", "");
    	
		Map<String, Object> smsMap = new HashMap<String, Object>();
		
		if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("sms_send_msg")))) {
			rtnMap.put("rtnCode", "-1");		
	    	rtnMap.put("rtnMsg", "메세지 내용을 입력해주세요.");
		} else {
			smsMap.put("msg", EgovStringUtil.isNullToString(commandMap.get("sms_send_msg")));
		}
		
		if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("sms_send_mobile_list_sentence")))) {
			rtnMap.put("rtnCode", "-1");		
	    	rtnMap.put("rtnMsg", "연락처를 선택해주세요.");
		} else {
			smsMap.put("rphone", EgovStringUtil.isNullToString(commandMap.get("sms_send_mobile_list_sentence")));
		}
		
		if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("sms_send_sender")))) {
			rtnMap.put("rtnCode", "-1");		
	    	rtnMap.put("rtnMsg", "보내는 이의 연락처를 선택해주세요.");
		} else {
			String sms_send_sender = EgovStringUtil.isNullToString(commandMap.get("sms_send_sender"));
			
			String[] sender = sms_send_sender.split("-");
			smsMap.put("sphone1", sender[0]);
			smsMap.put("sphone2", sender[1]);
			smsMap.put("sphone3", sender[2]);
		}
		
		if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("smsType")))) {
			smsMap.put("smsType", EgovStringUtil.isNullToString(commandMap.get("smsType")));
		}
				
		SMSManager smsManager = new SMSManager();	
		/*'sms_send_user_list': window.sms_send_user_list,
        'sms_send_mobile_list': window.sms_send_mobile_list,
        'sms_send_msg': $("#sms_send_msg").val(),
        'sms_send_sender': $("#sms_send_sender").val(),
        'sms_send_mobile_list_sentence':window.sms_send_mobile_list_sentence,
        'smsType': getSMSType()*/
		rtnMap = smsManager.sendSmsAsync(smsMap);
				
		rtnMap.put("search_value", commandMap);		    
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}	
	
	/**
     * 서약자 라벨내보내기 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/user/exportLabelforSelectedUser.do")
	public @ResponseBody JSONObject exportLabelforSelectedUser(ModelMap model, 	
			@RequestParam(value="user_export_array[]", required = false) int[] user_export_array, 			
			@RequestParam(value="user_export_col_array[]", required = false) String[] user_export_col_array,
			@RequestParam(value="user_export_col_name_array[]", required = false) String[] user_export_col_name_array,
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{		
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {			
		    if (SessionUtil.isLoginChk() == false ) { // 로그인이 되어 있지 않다면 로그인 화면으로 이동
		    	rtnMap.put("rtnCode", "-1");
		    	rtnMap.put("rtnMsg", "로그인 후 이용해주시기 바랍니다.");
		    } else {
				
		    	/*List<String> user_export_list = new ArrayList<String>();
		    	for(String user_index : user_export_array) {
		    		user_export_list.add(user_index);
		    	}*/
				commandMap.put("user_index_array", user_export_array);	
				commandMap.put("user_export_col_array", user_export_col_array);
				commandMap.put("user_export_col_name_array", user_export_col_name_array);
				
				boolean result = userService.exportLabelforSelectedUser(commandMap);
				
				if (result) {
					rtnMap.put("rtnCode", "");
					rtnMap.put("rtnMsg", "");
				} else {
					rtnMap.put("rtnCode", "-1");
			    	rtnMap.put("rtnMsg", "엑셀파일 생성에 실패하였습니다.");
				}
				
				rtnMap.put("rtnCode", "");
		    	rtnMap.put("rtnMsg", "");
		    }                
		} catch (Exception e) {
			rtnMap.put("rtnCode", "-2");
	    	rtnMap.put("rtnMsg", e.toString());
            log.error(e);                   
        }		
		rtnMap.put("search_value", commandMap);
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	
	/**
     * 주소검색 팝업화면
     * @return String
     * @exception Exception
     */
	@RequestMapping("/user/openAddrPopup.do") 
	public String openAddrPopup(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{	    
	   
		model.addAttribute("search_value",     CommonUtil.getObjectToJSONObject(commandMap));	        	        
        return "user/jusoPopup_utf8";
		/*if (SessionUtil.isLoginChk() == false ) { // 로그인이 되어 있지 않다면 로그인 화면으로 이동
	        return "redirect:/login.do";
	    } else { 
	    		    	
	        
	    }*/	    
	}
	
	/**
     * 서약자 상담내역 저장 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/user/saveConsultAjax.do")
	public @ResponseBody JSONObject saveConsultAjax(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{		
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		int result = 0;
		try {
		
	    	if(!EgovStringUtil.isEmpty(commandMap.get("consult_date").toString())) {
	    		//commandMap.put("consult_date", CommonUtil.dateToLong(commandMap.get("consult_date").toString(), "yyyy.MM.dd"));
	    	}
	    	
	    	if(!EgovStringUtil.isEmpty(commandMap.get("consult_memo").toString()) 
	    			|| !EgovStringUtil.isEmpty(commandMap.get("consult_result").toString())) {
	    		//commandMap.put("consult_date", CommonUtil.dateToLong(CommonUtil.currentDate("yyyy.MM.dd"), "yyyy.MM.dd"));
	    		commandMap.put("consult_date", CommonUtil.currentDate("yyyy-MM-dd"));
	    		SimpleDateFormat format1 = new SimpleDateFormat ("HH:mm");
	    		Date time = new Date();
	    		commandMap.put("consult_time", format1.format(time));
	    	
	    			
				// 서약자 index가 존재하는 경우에만 insert/update 실행
				if(!EgovStringUtil.isEmpty(commandMap.get("user_index").toString())) {
					// consult_index가 있는 경우 업데이트 수행
					
					if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("consult_index")))) {					
						result =  webcoService.update("ConsultDAO.update", commandMap);								
					} else {
						result =  Integer.parseInt(webcoService.insert("ConsultDAO.insert", commandMap).toString());					
						commandMap.put("consult_index", result);
					}
					if(result > 0) {
						rtnMap.put("rtnCode", "");
				    	rtnMap.put("rtnMsg", "상담정보가 저장되었습니다.");			    	
				    	
				    	Map<String, Object> consult = webcoService.selectByPk("ConsultDAO.select", commandMap);
				    	if(!EgovStringUtil.isEmpty(consult.get("consult_date").toString())) {
				    		consult.put("consult_date", CommonUtil.DateFormatChg(consult.get("consult_date").toString(), "yyyy-MM-dd", "yyyy.MM.dd"));
				    	}
				    	rtnMap.put("consult", consult);
				    	
					} else {
						rtnMap.put("rtnCode", "-1");
				    	rtnMap.put("rtnMsg", "저장 중 오류가 발생하였습니다.");
					}
				} else {
					rtnMap.put("rtnCode", "-1");
			    	rtnMap.put("rtnMsg", "서약자 정보가 누락되었습니다.");
				}
	    	}
		} catch (Exception e) {
			rtnMap.put("rtnCode", "-2");
	    	rtnMap.put("rtnMsg", e.toString());
		}
		rtnMap.put("search_value", commandMap);
		
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	
	/**
     * 서약자 상담내역 삭제 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/user/deleteConsultAjax.do")
	public @ResponseBody JSONObject deleteConsultAjax(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{	
	 
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		int result = 0;
		try {
			if(!EgovStringUtil.isEmpty(commandMap.get("consult_index").toString())) {
				result =  webcoService.delete("ConsultDAO.delete", commandMap);
				rtnMap.put("rtnCode", "");
		    	rtnMap.put("rtnMsg", "상담정보가 삭제되었습니다.");
			} else {
				rtnMap.put("rtnCode", "-1");
		    	rtnMap.put("rtnMsg", "잘못된 접근입니다.");
			}
		} catch (Exception e) {
			rtnMap.put("rtnCode", "-2");
	    	rtnMap.put("rtnMsg", e.toString());
		}
		rtnMap.put("search_value", commandMap);
		
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	
	/**
     * SMS양식 저장 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/user/saveSMSFormAjax.do")
	public @ResponseBody JSONObject saveSMSFormAjax(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{		
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		int result = 0;
		try {			
	    		    			
			// sms_form_index가 있는 경우 업데이트 수행			
			if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("sms_form_index"))) 
					&& Integer.parseInt(commandMap.get("sms_form_index").toString()) > 0) {					
				result =  webcoService.update("SmsFormDAO.update", commandMap);								
			} else {
				result =  Integer.parseInt(webcoService.insert("SmsFormDAO.insert", commandMap).toString());					
				commandMap.put("sms_form_index", result);
			}
			if(result > 0) {
				rtnMap.put("rtnCode", "");
		    	rtnMap.put("rtnMsg", "SMS양식이 저장되었습니다.");			    			    			    			    
			} else {
				rtnMap.put("rtnCode", "-1");
		    	rtnMap.put("rtnMsg", "저장 중 오류가 발생하였습니다.");
			}			
		} catch (Exception e) { 
			rtnMap.put("rtnCode", "-2");
	    	rtnMap.put("rtnMsg", e.toString());
		}
		rtnMap.put("search_value", commandMap);
		
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	
	/**
     * SMS양식 삭제 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/user/deleteSMSFormAjax.do")
	public @ResponseBody JSONObject deleteSMSFormAjax(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{	
	
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		int result = 0;
		try {
			if(!EgovStringUtil.isEmpty(commandMap.get("sms_form_index").toString())) {
				result =  webcoService.delete("SmsFormDAO.delete", commandMap);
				if(result > 0) {
					rtnMap.put("rtnCode", "");
					rtnMap.put("rtnMsg", "SMS양식이 삭제되었습니다.");
				} else {
					rtnMap.put("rtnCode", "-1");
			    	rtnMap.put("rtnMsg", "삭제 중 오류가 발생하였습니다.");
				}
			} else {
				rtnMap.put("rtnCode", "-1");
		    	rtnMap.put("rtnMsg", "잘못된 접근입니다.");
			}
		} catch (Exception e) {
			rtnMap.put("rtnCode", "-2");
	    	rtnMap.put("rtnMsg", e.toString());
		}
		rtnMap.put("search_value", commandMap);
		
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	
	/**
     * 실명확인 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/user/getNameCheckResultAjax.do")
	public @ResponseBody JSONObject getNameCheckResultAjax(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{	
	
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		String strName = EgovStringUtil.isNullToString(commandMap.get("str_name"));
		String strJumin = EgovStringUtil.isNullToString(commandMap.get("str_jumin"));
		
        String SiteCode = EgovProperties.getProperty("NAMECHECK.SITECODE");
        String SitePw = EgovProperties.getProperty("NAMECHECK.SITEPW");
		try {
			if(!EgovStringUtil.isEmpty(strName) && !EgovStringUtil.isEmpty(strJumin)) {
				int stralien = Integer.parseInt(strJumin.substring(6, 7));
		        if( stralien == 1 || stralien == 2 || stralien == 3 || stralien == 4 || stralien == 9 || stralien == 0){
		            //내국인 인증
		        } else if(stralien == 5 || stralien == 6 || stralien == 7 || stralien == 8){
		            //외국인 인증
		        	SiteCode = EgovProperties.getProperty("NAMECHECK.SITECODE_F"); //NICE평가정보에서 부여받은 외국인 사이트코드를 수정한다.
		        	SitePw = EgovProperties.getProperty("NAMECHECK.SITEPW_F"); //NICE평가정보에서 부여받은 외국인 사이트패스워드를 수정한다.
		        }
		        
		        NameCheck nameCheck = new NameCheck();
				nameCheck.setChkName(strName);
				String Rtn = nameCheck.setJumin(strJumin+SitePw);
				
				//정상처리인 경우
				if(Rtn.equals("0")) 
				{
					nameCheck.setSiteCode(SiteCode);
					nameCheck.setTimeOut(30000);
					Rtn = nameCheck.getRtn().trim(); 
					
					log.info("실명인증결과 : ========================="+Rtn);					
				}			
			    
			    commandMap.put("search_keyword_type", "user_name");
			    commandMap.put("search_keyword", strName);
			    
			    rtnMap = userService.selectUserList(commandMap);
			    List<Map<String, Object>> userList = (List<Map<String, Object>>) rtnMap.get("user_list");
			    if(!userList.isEmpty()) {
				    for( Map<String, Object> userInfo : userList ) {
				    	if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(userInfo.get("user_social_security_num")))) {
				    		String[] user_social_security_num_arr = EgovStringUtil.isNullToString(userInfo.get("user_social_security_num")).split("-");
				    		String user_social_security_num = EgovStringUtil.isNullToString(user_social_security_num_arr[0]) + EgovStringUtil.isNullToString(user_social_security_num_arr[1]);
		    				if(strJumin.equals(user_social_security_num)) {
		    					Rtn = "901";
		    				}				    				
				    	}
				    }
			    }
			    rtnMap.put("rtnCode", "");
		    	rtnMap.put("rtnMsg", "실명인증에 성공하였습니다.");
		    	rtnMap.put("checkResult", Rtn);
		    	
			} else {
				rtnMap.put("rtnCode", "-1");
		    	rtnMap.put("rtnMsg", "잘못된 접근입니다.");
			}
		} catch (Exception e) {
			rtnMap.put("rtnCode", "-2");
	    	rtnMap.put("rtnMsg", e.toString());
		}
		rtnMap.put("search_value", commandMap);
		
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	
	// 현재 시간을 기준으로 파일 이름 생성
    private String genSaveFileName(String extName) {
		String fileName = "";
		
		fileName += UUID.randomUUID().toString().replaceAll("-", "");
		fileName += extName;
		
		return fileName;
	}
	
    // 파일을 실제로 write 하는 메서드
 	private boolean writeFile(MultipartFile multipartFile, String saveFileName, HttpServletRequest request)throws IOException{
 		boolean result = false;
 		//String path=request.getServletContext().getRealPath("/upFile");
 		String path = fileStorePath;
 		byte[] data = multipartFile.getBytes();
 		FileOutputStream fos = new FileOutputStream(path + "/" + saveFileName);
 		fos.write(data);
 		fos.close();
 		
 		return result;
 	}
 	
 	//파일 다운로드
 	@RequestMapping("/user/fileDownload.do")
 	public void fileDownload(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, HttpServletResponse response){
 		requestMap.put("fileStorePath", fileStorePath);
 		userService.fileDownload(requestMap, request, response);
 	}
}

        