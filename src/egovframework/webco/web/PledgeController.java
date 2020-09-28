package egovframework.webco.web;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.JsonParser;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.webco.service.UserService;
import egovframework.webco.service.VisitService;
import egovframework.webco.service.WebcoService;
import egovframework.webco.util.CommonUtil;
import egovframework.webco.util.EnumValue;
import egovframework.webco.util.NameCheck;
import egovframework.webco.vo.PledgeHeaderDataVO;
import egovframework.webco.vo.PledgeReqDataVO;
import net.sf.json.JSONObject;


@Controller
public class PledgeController {

    /** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name = "userService")
    private UserService userService;   
    
    @Resource(name = "webcoService")
    private WebcoService webcoService;
    
    @Resource(name = "visitService")
    private VisitService visitService;
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
        
    
    /**
     * 시럽웰렛 - 서약자 신규 가입 화면
     * @return String
     * @exception Exception
     */
	@RequestMapping("/pledge/joinCardUser.do") 
	public String joinCardUser(ModelMap model, @RequestParam Map<String, Object> commandMap,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{	
		
		int visit_index = visitService.saveVisit();
		EnumValue enumValue = new EnumValue();
		if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("showCard")))) {
			commandMap.put("showCard", "Y");
		}
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("paymentTrNo")))) {
			Map<String, Object> issue_membership_data = webcoService.selectByPk("IssueMembershipDAO.select", commandMap);
			
			if(issue_membership_data != null) {
				issue_membership_data.put("birthday", EgovDateUtil.formatDate(issue_membership_data.get("birthday").toString(), "."));
				if(EgovStringUtil.isNullToString(issue_membership_data.get("gender")).equals("M")) {
					issue_membership_data.put("gender", "남");
				} else if(EgovStringUtil.isNullToString(issue_membership_data.get("gender")).equals("F")) {
					issue_membership_data.put("gender", "여");
				}
				issue_membership_data.put("mdn_0", issue_membership_data.get("mdn").toString().substring(0, 3));
				issue_membership_data.put("mdn_1", issue_membership_data.get("mdn").toString().substring(3, 7));
				issue_membership_data.put("mdn_2", issue_membership_data.get("mdn").toString().substring(7, 11));
				
				model.addAttribute("issue_membership", issue_membership_data);
				model.addAttribute("enum_array", CommonUtil.getObjectToJSONObject(enumValue.getEnumArray()));
				model.addAttribute("param", commandMap);
				model.addAttribute("showCard", EgovStringUtil.isNullToString(commandMap.get("showCard")));
				session.setAttribute("save_pledge", "1");
				return "pledge/joinCardUser";
			}			
		}           
		String error_msg = "잘못된 접근입니다. 다시 접속해주시기 바랍니다.<br /><br />";
		model.addAttribute("error_msg", error_msg);
		return "pledge/errorSaveMemberInfo";
	}  
	/**
     * 시럽웰렛 - 서약자 신규 가입 화면
     * @return String
     * @exception Exception
     */
	@RequestMapping("/pledge/checkCardUser.do") 
	public String checkCardUser(ModelMap model, @RequestParam Map<String, Object> commandMap,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		EnumValue enumValue = new EnumValue();
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("paymentTrNo")))) {
			Map<String, Object> issue_membership_data = webcoService.selectByPk("IssueMembershipDAO.select", commandMap);
			if(issue_membership_data != null) {
				int user_index = userService.checkUserCI(EgovStringUtil.isNullToString(issue_membership_data.get("ipinCi")));		        
		    	if(user_index > 0) {
		    		Map<String, Object> user_detail = userService.selectUserInfo(user_index);
		    		if(user_detail != null) {
						
						String donation_type_string = "";
						if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(user_detail.get("user_donation_type_organ")))) {
							donation_type_string += "뇌사 시 장기 ";
						}
						if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(user_detail.get("user_donation_type_body")))) {
							donation_type_string += "인체조직 ";
						}
						if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(user_detail.get("user_donation_type_comea")))) {
							donation_type_string += "각막 ";
						}
						model.addAttribute("donation_type_string", donation_type_string);
						model.addAttribute("user_detail", user_detail);
						model.addAttribute("enum_array", CommonUtil.getObjectToJSONObject(enumValue.getEnumArray()));
						model.addAttribute("param", commandMap);												
						return "pledge/checkCardUser";
		    		}
		    	}
			}
		} else {
			
		}		
		String error_msg = "잘못된 접근입니다. 다시 접속해주시기 바랍니다.<br /><br />";
		model.addAttribute("error_msg", error_msg);
		return "pledge/errorSaveMemberInfo";
	}
	
	
	
	/**
     * 시럽웰렛 - 서약자 신규 가입처리
     * @return String
     * @exception Exception
     */
	@RequestMapping("/pledge/register.do")
	public String register(ModelMap model, @RequestParam Map<String, Object> commandMap,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		PledgeHeaderDataVO headerData = new PledgeHeaderDataVO();
		PledgeReqDataVO reqData = new PledgeReqDataVO();
		
		headerData.setPartnerId(egovMessageSource.getMessage("SYRUP.partnerId"));
		headerData.setPartnerSiteId(egovMessageSource.getMessage("SYRUP.partnerSiteId"));
		
		String partnerRtnCode = "0000";
		String response_result = "1";
		if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("showCard")))) {
			commandMap.put("showCard", "Y");
		}
		
		String showCard = commandMap.get("showCard").toString();
		String session_save_pledge = EgovStringUtil.isNullToString(session.getAttribute("save_pledge"));
		String status = EgovStringUtil.isNullToString(commandMap.get("status"));
		try {
			if(status.equals("1") && session_save_pledge.equals("1")) {
				log.info("멤버십 가입요청 api 호출시 저장된 내용 조회");
				Map<String, Object> issue_membership_data = webcoService.selectByPk("IssueMembershipDAO.select", commandMap);			
				
		        int user_sex = 1;
		        
		        log.info("DB 저장을 위한 파라미터 셋팅 시작===========");
		        String sex_digit = EgovStringUtil.isNullToString(commandMap.get("user_social_security_num_1")).substring(0, 1);
		        if(sex_digit.equals("1") || sex_digit.equals("3") || sex_digit.equals("5") || sex_digit.equals("7") || sex_digit.equals("9")) {
		        	user_sex = 1;
		        } else {
		        	user_sex = 2;
		        }
		        commandMap.put("user_sex", user_sex);
		        
		        String user_social_security_num = "";
				String user_mobile = "";
				String user_phone = "";
				String user_email = "";
				
				log.info("DB 저장을 위한 파라미터 셋팅 - 주민번호 ===========");
				if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_social_security_num_0")))
					&& !EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_social_security_num_1")))) {
					user_social_security_num = commandMap.get("user_social_security_num_0").toString() + "-" + commandMap.get("user_social_security_num_1").toString();
					// 주민번호 암호화
				}
				commandMap.put("user_social_security_num", user_social_security_num);
				
				log.info("DB 저장을 위한 파라미터 셋팅 - 휴대전화번호 ===========");
				if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_mobile_0")))
					&& !EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_mobile_1")))
					&& !EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_mobile_2")))) {
					user_mobile = commandMap.get("user_mobile_0").toString() + "-" + commandMap.get("user_mobile_1").toString() + "-" + commandMap.get("user_mobile_2").toString();
				}
				commandMap.put("user_mobile", user_mobile);
				
				log.info("DB 저장을 위한 파라미터 셋팅 - 집전화번호 ===========");
				if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_phone_0")))
					&& !EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_phone_1")))
					&& !EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_phone_2")))) {
					user_phone = commandMap.get("user_phone_0").toString() + "-" + commandMap.get("user_phone_1").toString() + "-" + commandMap.get("user_phone_2").toString();
				}
				commandMap.put("user_phone", user_phone);
				
				log.info("DB 저장을 위한 파라미터 셋팅 - 이메일 ===========");
				if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_email_1")))				
					&& !EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_email_2")))) {
					user_email = commandMap.get("user_email_1").toString() + "@" + commandMap.get("user_email_2").toString();
				}
				commandMap.put("user_email", user_email);
				
				log.info("DB 저장을 위한 파라미터 셋팅 - 생년월일 ===========");
				if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_birthday")))) {
					commandMap.put("user_birthday", CommonUtil.DateFormatChg(commandMap.get("user_birthday").toString(), "yyyy.MM.dd", "yyyy-MM-dd"));
				} else {
					commandMap.put("user_birthday", "");
				}
							
				if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_donation_type_body")))) {
					commandMap.put("user_donation_type_body", 0);
				}
				
				if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_donation_type_organ")))) {
					commandMap.put("user_donation_type_organ", 0);
				}
				
				if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_donation_type_comea")))) {
					commandMap.put("user_donation_type_comea", 0);
				}	
				
				log.info("DB 저장을 위한 파라미터 셋팅 - 기부서약일자 ===========");
				if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_pledge_date")))) {
					commandMap.put("user_pledge_date", CommonUtil.DateFormatChg(commandMap.get("user_pledge_date").toString(), "yyyy.MM.dd", "yyyy-MM-dd"));
				} else {
					commandMap.put("user_pledge_date", CommonUtil.currentDate("yyyy-MM-dd"));
				}
				
				log.info("DB 저장을 위한 파라미터 셋팅 - 신청일자 ===========");
				if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_registration_date")))) {
					commandMap.put("user_registration_date", CommonUtil.DateFormatChg(commandMap.get("user_registration_date").toString(), "yyyy.MM.dd", "yyyy-MM-dd"));
				} else {
					commandMap.put("user_registration_date", CommonUtil.currentDate("yyyy-MM-dd"));
				}
				
				if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_konos_registration_date")))) {
					commandMap.put("user_konos_registration_date", CommonUtil.DateFormatChg(commandMap.get("user_konos_registration_date").toString(), "yyyy.MM.dd", "yyyy-MM-dd"));
				} else {
					commandMap.put("user_konos_registration_date", "");
				}
				
				log.info("DB 저장을 위한 파라미터 셋팅 - 탈퇴일자 ===========");
				if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_withdraw_date")))) {
					commandMap.put("user_withdraw_date", CommonUtil.DateFormatChg(commandMap.get("user_withdraw_date").toString(), "yyyy.MM.dd", "yyyy-MM-dd"));
				} else {
					commandMap.put("user_withdraw_date", "");
				}
				
				if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_konos_withdraw_date")))) {
					commandMap.put("user_konos_withdraw_date", CommonUtil.DateFormatChg(commandMap.get("user_konos_withdraw_date").toString(), "yyyy.MM.dd", "yyyy-MM-dd"));
				} else {
					commandMap.put("user_konos_withdraw_date", "");
				}
				
				if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_is_legal_representative_text")))) {
					commandMap.put("user_is_legal_representative_text", 0);
				}
				/*log.info("DB 저장을 위한 파라미터 셋팅 - 나이 ===========");
				if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_age")))) {
					log.info("DB 저장을 위한 파라미터 셋팅 - 나이계산 ===========");
					long ts = CommonUtil.dateToLong(commandMap.get("user_birthday").toString(), "yyyy.MM.dd");
					int user_age = CommonUtil.getKoreaAge(String.valueOf(ts));
					log.info("DB 저장을 위한 파라미터 셋팅 - 나이 "+ts+"/"+user_age+"===========");
					commandMap.put("user_age", user_age);
				}*/
				if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_age")))) {
					commandMap.put("user_age", 0);
				}
				
				log.info("DB 저장을 위한 파라미터 셋팅 - 인증관련 ===========");
				commandMap.put("ipin_vno", "");
				commandMap.put("ipin_ci", "");
				commandMap.put("ipin_dup_info", "");
				commandMap.put("ipin_result_index", 0);
				commandMap.put("checkplus_dupinfo", "");
				commandMap.put("checkplus_conninfo", "");
				commandMap.put("checkplus_result_index", 0);
				
				log.info("DB 저장을 위한 파라미터 셋팅 - 기타 ===========");
				commandMap.put("user_num", "");
				commandMap.put("user_recognize_type", 1);
				commandMap.put("user_register_channel", 3);
				commandMap.put("user_konos_register_state", 0);
				commandMap.put("user_register", "");
				commandMap.put("user_withdraw_reason", 0);
				commandMap.put("user_withdraw_way", 0);
				commandMap.put("user_pledge_card_state", 0);
				commandMap.put("user_legal_representative_info", "");						
				
				log.info("DB 저장을 위한 파라미터 셋팅 - 시럽CI ===========");
				commandMap.put("syrup_ci", EgovStringUtil.isNullToString(issue_membership_data.get("ipinCi")));
				
				log.info("DB 저장을 위한 파라미터 셋팅 종료===========");
				
				log.info("DB처리 시작");
				
				int old_user_index = userService.checkUserCI(EgovStringUtil.isNullToString(issue_membership_data.get("ipinCi")));
				log.info("checkUserCI =>"+old_user_index);
				if(old_user_index > 0) {
					Map<String, Object> userMap = new HashMap<String, Object>();
					userMap.put("user_index", old_user_index);
					userService.delete(userMap);
				}
				
				int user_index = Integer.parseInt(userService.insert(commandMap).toString());	  
				log.info("insert user_index =>"+user_index);
				if(user_index > 0) {
					String user_num = String.format("%08d", user_index);
					commandMap.put("user_num", user_num);
					int result = userService.update(commandMap);
					// 문자 발송
					userService.sendAutoSMS("greet_pledge", user_mobile, commandMap.get("user_is_sms_agree").toString());
									
					headerData.setTrDt(issue_membership_data.get("trDt").toString());
					headerData.setTrNo(issue_membership_data.get("trNo").toString());
					
					reqData.setMdn(issue_membership_data.get("mdn").toString());
					reqData.setTransactionId(issue_membership_data.get("paymentTrNo").toString());
					reqData.setCardMemberId(user_num);
					reqData.setResponseResult(response_result);
					reqData.setCardGradeCode("008");
					reqData.setPartnerRtnCode(partnerRtnCode);
					reqData.setPartnerRtnMessage(egovMessageSource.getMessage("SYRUP.RESULT."+partnerRtnCode));
					/*Map<String, Object> RequestData = new HashMap<String, Object>();
					Map<String, Object> body = new HashMap<String, Object>();
					body.put("header", headerData);
					body.put("body", reqData);*/
					String requestData = this.getMembershipIssueRequestData(headerData, reqData);
					
					log.info("requestData=>"+requestData);
					boolean reqResult = this.sendMembershipIssueRequest(requestData);
					if (reqResult) {
						session.removeAttribute("save_pledge");
						model.addAttribute("showCard", showCard);
						return "pledge/walletFinish";	
					} else {
						String error_msg = "서약은 완료되었지만 정보 처리 중 문제가 발생하였습니다.<br /> 이미 서약되었으므로 다시 서약은 진행하지 마시고 고객센터로 문의 바랍니다.<br /><br />";
						model.addAttribute("error_msg", error_msg);
						return "pledge/errorSaveMemberInfo";
					}
				} else {
					partnerRtnCode = "3007";
		            response_result = "2";
					headerData.setTrDt(issue_membership_data.get("trDt").toString());
					headerData.setTrNo(issue_membership_data.get("trNo").toString());
					
					reqData.setMdn(issue_membership_data.get("mdn").toString());
					reqData.setTransactionId(issue_membership_data.get("paymentTrNo").toString());					
				}
				log.info("DB처리 종료");
				
			} else {
				partnerRtnCode = "3007";
	            response_result = "2";										
			}
		} catch (Exception e) {
			log.error(e.toString());
			partnerRtnCode = "9000";
            response_result = "2";	
		}
		reqData.setResponseResult(response_result);				
		reqData.setPartnerRtnCode(partnerRtnCode);
		reqData.setPartnerRtnMessage(egovMessageSource.getMessage("SYRUP.RESULT."+partnerRtnCode));
		
		String requestData = this.getMembershipIssueRequestData(headerData, reqData);
		boolean reqResult = this.sendMembershipIssueRequest(requestData);
		session.removeAttribute("save_pledge");
		String error_msg = "서약자 등록 중 오류가 발생하였습니다. 관리자에게 문의해주시기 바랍니다.<br /><br />(데이터 유효성 에러)";
		model.addAttribute("error_msg", error_msg);
		return "pledge/errorSaveMemberInfo";
	}
	
	/**
     * 실명확인 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/pledge/getNameCheckResultAjax.do")
	public @ResponseBody JSONObject getNameCheckResultAjax(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{	
	
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		String strName = EgovStringUtil.isNullToString(commandMap.get("str_name"));
		String strJumin = EgovStringUtil.isNullToString(commandMap.get("str_jumin"));
		
        String SiteCode = EgovProperties.getProperty("NAMECHECK.SITECODE");
        String SitePw = EgovProperties.getProperty("NAMECHECK.SITEPW");
		try {
			if(!EgovStringUtil.isEmpty(strName) && !EgovStringUtil.isEmpty(strJumin) && strJumin.length() == 13) {
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
		    					Rtn = "duplicated";
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
	
	/**
     * 주소검색 팝업화면
     * @return String
     * @exception Exception
     */
	@RequestMapping("/pledge/openAddrPopup.do") 
	public String openAddrPopup(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{	    
		model.addAttribute("search_value",     CommonUtil.getObjectToJSONObject(commandMap));	        	        
	    return "pledge/jusoPopup_utf8";
	}
	
	/**
     * 주소 세션 저장 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/pledge/setAddrSessionAjax.do") 
	public @ResponseBody JSONObject setAddrSessionAjax(ModelMap model, @RequestParam Map<String, Object> commandMap,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{	    
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("rtnCode", "");
    	rtnMap.put("rtnMsg", "");
		try {
			session.setAttribute("zipNo", EgovStringUtil.isNullToString(commandMap.get("zipNo")));
			session.setAttribute("roadAddrPart1", EgovStringUtil.isNullToString(commandMap.get("roadAddrPart1")));
			session.setAttribute("addrDetail", EgovStringUtil.isNullToString(commandMap.get("addrDetail")));
		} catch (Exception e) {
			rtnMap.put("rtnCode", "-1");
			rtnMap.put("rtnMsg", e.toString());
		}
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	
	/**
     * 주소 세션 가져오기 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/pledge/getAddrSessionAjax.do") 
	public @ResponseBody JSONObject getAddrSessionAjax(ModelMap model, @RequestParam Map<String, Object> commandMap,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{	    
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("rtnCode", "");
    	rtnMap.put("rtnMsg", "");
		try {
			String zipNo = EgovStringUtil.isNullToString(session.getAttribute("zipNo"));
			String roadAddrPart1 = EgovStringUtil.isNullToString(session.getAttribute("roadAddrPart1"));
			String addrDetail = EgovStringUtil.isNullToString(session.getAttribute("addrDetail"));
			Map<String, Object> data = new HashMap<String, Object>();
			if(!EgovStringUtil.isEmpty(zipNo) && !EgovStringUtil.isEmpty(roadAddrPart1)) {
				data.put("zipNo", zipNo);
				data.put("roadAddrPart1", roadAddrPart1);
				data.put("addrDetail", addrDetail);
			} else {
				data.put("zipNo", "");
				data.put("roadAddrPart1", "");
				data.put("addrDetail", "");
			}
			rtnMap.put("data", data);
			
			/*session.removeAttribute("zipNo");
			session.removeAttribute("roadAddrPart1");
			session.removeAttribute("addrDetail");	*/		
		} catch (Exception e) {
			rtnMap.put("rtnCode", "-1");
			rtnMap.put("rtnMsg", e.toString());
		}
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	
	/**
     * 주소 세션 초기화 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/pledge/unsetAddrSessionAjax.do") 
	public @ResponseBody JSONObject unsetAddrSessionAjax(ModelMap model, @RequestParam Map<String, Object> commandMap,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{	    
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("rtnCode", "");
    	rtnMap.put("rtnMsg", "");
		try {
			session.removeAttribute("zipNo");
			session.removeAttribute("roadAddrPart1");
			session.removeAttribute("addrDetail");
		} catch (Exception e) {
			rtnMap.put("rtnCode", "-1");
			rtnMap.put("rtnMsg", e.toString());
		}
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	
	public boolean checkAdult(String strJumin) {
		
		return true;
	}
	
	public boolean checkPrevSocialSecurity(String strName, String strJumin) {
		
		return true;
	}
	
	public boolean sendMembershipIssueRequest(String requestData) {
		String SyrupMode = egovMessageSource.getMessage("SYRUP.Mode");
		
		//String url = "https://dev-gateway.syrup.co.kr:18080/gw/card/saveMemberInfo"; // Develop
		//String url = "https://stg-gateway.syrup.co.kr:18080/gw/card/saveMemberInfo"; // Staging
		//String url = "https://gateway.syrup.co.kr:18080/gw/card/saveMemberInfo"; // Real
		String url = egovMessageSource.getMessage("SYRUP."+SyrupMode+".ApiUrl");
		log.info("Syrup API url =>" + url);
		try {
			HttpHeaders headers = new HttpHeaders();
		    headers.setContentType(MediaType.APPLICATION_JSON_UTF8);
		    headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON_UTF8));    
		    headers.setCacheControl("no-cache");
		    HttpEntity param= new HttpEntity(requestData, headers);
	
		    RestTemplate restTemplate = new RestTemplate();
		    String result = restTemplate.postForObject(url, param, String.class);
		    log.info("Syrup API Request Result =>" + result);
		    //{"Header":{"partnerId":"","partnerSiteId":"","trDt":"","trNo":"","rtnCode":"9000","rtnMsg":"에러가 발생하였습니다.","partnerRtnCode":"","partnerRtnMsg":""},"Body":{}}
		    
		    JSONObject jsonObject = JSONObject.fromObject(result);		
		    JSONObject headerData = (JSONObject) jsonObject.get("Header");
		    if(!EgovStringUtil.isNullToString(headerData.get("rtnCode")).equals("0000")) {
		    	log.info("Syrup API Request 실패");
		    	return false;
		    }
		} catch (Exception e) {
			log.error(e.toString());
			return false;
		}

		return true;
	}	
	
	public String getMembershipIssueRequestData(PledgeHeaderDataVO header, PledgeReqDataVO reqData) {
		Map<String, Object> RequestData = new LinkedHashMap<String, Object>();
		Map<String, Object> body = new LinkedHashMap<String, Object>();
				
		body.put("reqData", reqData);
		body.put("resData", new ArrayList());
		
		RequestData.put("Header", header);
		RequestData.put("Body", body);
		
		return CommonUtil.getObjectToJSONObject(RequestData).toString();
	}
}

        