package egovframework.webco.web;

import java.security.PrivateKey;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovClntInfo;
import egovframework.com.utl.slm.EgovHttpSessionBindingListener;
import egovframework.webco.controller.bean.jqgridJason;
import egovframework.webco.service.WebcoService;
import egovframework.webco.util.CommonUtil;
import egovframework.webco.util.EnumValue;
import egovframework.webco.util.RSAEngine;
import egovframework.webco.util.SMSManager;
import egovframework.webco.util.SessionUtil;
import egovframework.webco.vo.AdminVO;


@Controller
public class HomeController {

    /** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());

    @Resource(name = "webcoService")
    private WebcoService webcoService;    
    
    /**
     * 페이지 화면 상단 Header 메뉴
     * @return String
     * @exception Exception
     */
    @RequestMapping("/webHeader.do")
    public String webHeader(@RequestParam Map<String, Object> commandMap, ModelMap model, HttpServletRequest request) throws Exception {
        
    	AdminVO adminVO = (AdminVO) SessionUtil.getAuthenticatedUser();
    	
        String reUrl = request.getRequestURI();
        log.debug("========reUrl-------- : "+reUrl);
        String[] a = reUrl.split("\\/");
        String subUrl = a[1];
        log.debug(subUrl+"***********************");
        	
        model.addAttribute("admiInfo", adminVO);
        model.addAttribute("subUrl",subUrl);        
        model.addAttribute("parmMap", commandMap); 
        /* 헤더메뉴에 게시판 목록 추가 8월 19일 서지숙*/                
        
        return "/include/webHeader";
    }

	/**
     * 페이지 화면 상단 메뉴
     * @return String
     * @exception Exception
     */
    @RequestMapping("/webMenu.do")
    public String webMenu(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
        
    	AdminVO adminVO = (AdminVO) SessionUtil.getAuthenticatedUser();
        commandMap.put("admin_grade", adminVO.getAdmin_grade());
    	
        List<Map<String, Object>> webMenuList = webcoService.webMenuList(commandMap);
    	
        model.addAttribute("webMenuList",webMenuList);
    	model.addAttribute("adminInfo", adminVO);
    	model.addAttribute("parmMap", commandMap);
                           
        return "/include/webMenu";
    }
    
    /**
     * 관리자 페이지 하단 COPYRIGHT
     * @return String
     * @exception Exception
     */
    @RequestMapping("/webBottom.do")
    public String webBottom(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
               
        return "/include/webBottom";
    }
                
    
    /**
     * Cross Scripting 체크
     * @return Map
     * @exception Exception
     */
    public Map<String, Object> chkCrossScript(@RequestParam Map<String, Object> commandMap) throws Exception {
        
        String menuID = EgovStringUtil.isNullToString(commandMap.get("menuId"));
        if (menuID.toLowerCase().indexOf("script") > 0) {
            menuID = menuID.toLowerCase();
            commandMap.put("menuId", menuID.replaceAll("script", "scriXX"));  // 메뉴ID
        }       
        
        return commandMap;
    }
    
//  로그인 화면 
	@RequestMapping("/login.do")
	public String adminLogin(HttpServletRequest request,
	                          ModelMap model){
	    //log.debug("--------------------------------------intranetLogin=="+SessionUtil.getUserId());
	    if (SessionUtil.isLoginChk() == true ) { // 로그인이 되어 있고 근무자이면 관리자 메인화면 이동	  
	    	if(SessionUtil.getAdminGrade().equals("0")) {	// 일반관리자
	    		return "redirect:/user/userList.do";
	    	} else {
	    		return "redirect:/statistics/dashboard.do";
	    	}
	    } else {
	    	/* ====== 로그인시 ID, PASSWORD 암호화를 위한 처리 Start =========== */        
	        Map<String, Object> publicKeyMap = RSAEngine.getPublicKeyString(request);
	        
	        if (publicKeyMap != null) {
	            
	            model.addAttribute("publicKeyMap",   publicKeyMap);
	        }        
	        /* ====== 로그인시 ID, PASSWORD 암호화를 위한 처리 End =========== */
	        	       	        
	        return "login/login";
	    }
	}
	
	@RequestMapping(value = "/actionSmsAuthLogin.do")
    public @ResponseBody jqgridJason actionSmsAuthLogin(@ModelAttribute("adminVO") AdminVO adminVO,
                                                                            HttpSession session, 
                                                                            HttpServletRequest request, 
                                                                            Map<String, Object> commandMap, 
                                                                            ModelMap model) 
                                                                                   throws Exception {
		// 접속IP
        String userIp = EgovClntInfo.getClntIP(request);
        
		jqgridJason resultData = new jqgridJason();
	        
		String ss_auth_num = EgovStringUtil.isNullToString(session.getAttribute("auth_num"));
		String auth_login_index = EgovStringUtil.isNullToString(session.getAttribute("auth_login_index"));
		
		log.debug("SMS 로그인 인증:userIp:"+ userIp);
		log.debug("SMS 로그인 인증:ss_auth_num:"+ ss_auth_num);
		log.debug("SMS 로그인 인증:auth_login_index:"+ auth_login_index);
		log.debug("SMS 로그인 인증:auth_num:"+ commandMap.get("auth_num"));
		try {
			if(ss_auth_num.equals("")) {
				resultData.setErrCd("-99");
                resultData.setErrMsg("로그인 인증번호가 만료되었습니다. 다시 로그인 해주세요."); 
			} else if(!ss_auth_num.equals(EgovStringUtil.isNullToString(commandMap.get("auth_num")))) {
				resultData.setErrCd("-1");
                resultData.setErrMsg("인증번호가 올바르지 않습니다. 다시 입력해주세요.");
			} else {
				commandMap.put("admin_index", auth_login_index);
				List adminList = webcoService.list_map("AdminDAO.selectAdminLoginInfo", commandMap);
	            
	            if (adminList == null || adminList.size() <= 0 ) {                 
	                resultData.setErrCd("-1"); 
	                resultData.setErrMsg("존재하지 않는 사용자입니다.");                 
	            } else {
	            	AdminVO resultvo = (AdminVO) adminList.get(0);
	            	
	            	resultData.setErrCd("0"); //정상 접속	                            
	                session.removeAttribute("auth_num");
	                
	                Map<String, Object> param = new HashMap<String, Object>();
	                param.put("admin_index", resultvo.getAdmin_index());
	                param.put("admin_id", resultvo.getAdmin_id());
	                param.put("login_ip", userIp);
	                param.put("login_fail_cnt", 0);
	                
	                webcoService.insert("AdminDAO.insertAdminLogin", param);                            
	                webcoService.update("AdminDAO.updateLoginFailCnt", param); 	                            	                                                   
	                                            
	                log.debug(resultvo.getAdmin_index()+":로그인 성공::"+ resultvo.getAdmin_id());
	                //session.setAttribute(Captcha.NAME,null); 
	                log.debug(resultvo.getAdmin_index()+": admin_chg_pwd ::"+ resultvo.getAdmin_chg_pwd());
	                
	                session.setMaxInactiveInterval(60*60*1); // 세션 유지시간 1시간
	                request.getSession().setAttribute("adminVO", resultvo); // 사용자정보 세션저장
	                session.setAttribute("smsAuth", "OK");	                
	                EgovHttpSessionBindingListener listener = new EgovHttpSessionBindingListener();
	                request.getSession().setAttribute(resultvo.getAdmin_id(), listener);                
	            }
			}

		} catch (Exception e) {			
				resultData.setErrCd("-2");
				resultData.setErrMsg(e.toString()); 
				log.error(e);
	     }	     
	     return resultData;
	}
        
    @RequestMapping(value = "/actionLogin.do")
    public @ResponseBody jqgridJason actionLogin(@ModelAttribute("adminVO") AdminVO adminVO,
                                                                            HttpSession session, 
                                                                            HttpServletRequest request, 
                                                                            Map<String, Object> commandMap, 
                                                                            ModelMap model) 
                                                                                   throws Exception {
        // 접속IP
        String userIp = EgovClntInfo.getClntIP(request);

        log.debug("로그인 시도::"+ userIp);
        
        String securedUserId = EgovStringUtil.isNullToString(commandMap.get("securedUserId"));
        String securedPwd    = EgovStringUtil.isNullToString(commandMap.get("securedPwd"));
        
        jqgridJason resultData = new jqgridJason();
        
        try {
            
            if (securedUserId == null || securedUserId.equals("") ||   
                    securedPwd == null || securedPwd.equals("")) {
                
                resultData.setErrCd("-1");
                resultData.setErrMsg("아이디 또는 비밀번호가 입력되지 않았습니다."); 
                
            } else {
                
                /**
                 * 암호화된 비밀번호를 복호화 한다.
                 */
                PrivateKey privateKey = (PrivateKey) session.getAttribute("rsaPrivateKey");
                //session.removeAttribute("__rsaPrivateKey__"); // 키의 재사용을 막는다. 항상 새로운 키를 받도록 강제.
                
                if (privateKey == null) {
                    resultData.setErrCd("-2"); 
                    resultData.setErrMsg("암호화 비밀키 정보를 찾을 수 없습니다."); 
                } else {
                    
                    String deUserId = RSAEngine.decryptRsa(privateKey, securedUserId); // ID 복호화
                    String dePwd = RSAEngine.decryptRsa(privateKey, securedPwd); // password 복호화
                    
                    Map<String, Object> paramMap = new HashMap<String, Object>(); 
                    paramMap.put("userId", EgovWebUtil.clearXSSMinimum(deUserId));
                    paramMap.put("userPw", EgovWebUtil.clearXSSMinimum(dePwd));

                    log.debug(deUserId.length()+"======================"+deUserId);
                    log.debug(deUserId.length()+"======================"+EgovWebUtil.clearXSSMinimum(deUserId));
                    log.debug(deUserId.length()+"======================"+dePwd);
                    log.debug(deUserId.length()+"======================"+EgovWebUtil.clearXSSMinimum(dePwd));
                    
                    List adminList = webcoService.list_map("AdminDAO.selectAdminLogin", paramMap);
                    
                    if (adminList == null || adminList.size() <= 0 ) { 
                        
                        resultData.setErrCd("-1"); 
                        resultData.setErrMsg("존재하지 않는 사용자입니다."); 
                        
                    } else {
                        
                    	AdminVO resultvo = (AdminVO) adminList.get(0);
                        String adminId       = resultvo.getAdmin_id();    
                        String pwdChk       = resultvo.getAdmin_pwd();    // 비밀번호 체크
                        int loginFailCnt   = resultvo.getLogin_fail_cnt(); // 로그인 실패 횟수
                        String captchaInputYn = (String) EgovStringUtil.isNullToString(commandMap.get("captchaInputYn")); // 자동방지 사용 유무
                        
//                        log.debug("============captchaInput=========="+captchaInput);                       
//                        log.debug("============captchaInputYn=========="+captchaInputYn);
//                        log.debug("============captcha.getAnswer()=========="+captcha.getAnswer());
                        
                        log.debug("============adminId=========="+adminId);
                        log.debug("============deUserId=========="+deUserId);
                        log.debug("============loginFailCnt=========="+loginFailCnt);
                        
                        Map<String, Object> param = new HashMap<String, Object>();
                        param.put("admin_index", resultvo.getAdmin_index());
                        param.put("admin_id", resultvo.getAdmin_id());
                        param.put("login_ip", userIp);                                               
                        
                        if (adminId == null || !adminId.equals(deUserId)) {
                            
                            resultData.setErrCd("-1"); 
                            resultData.setErrMsg("해당 ID가 없습니다. 다시 입력해 주십시오."); 
                        } else if(!resultvo.getAdmin_grade().equals("-1") && loginFailCnt > 2) {
                    		resultData.setErrCd("-1"); 
                            resultData.setErrMsg("계정이 잠금상태입니다. 관리자에게 문의 해 주십시오.");
                            log.debug(resultvo.getAdmin_index()+":계정 잠김상태::"+ adminId);  
                        } else  if (pwdChk != null && pwdChk.equals("O")) {  
                        	/*if(resultvo.getAdmin_phone() == null || resultvo.getAdmin_phone().equals("")) {
                        		resultData.setErrCd("1"); //휴대폰 오류
                        		resultData.setErrMsg("휴대폰번호가 등록되어 있지 않아 회원 수정화면으로 이동합니다.");*/
                        	//} else {
                        		if(resultvo.getAdmin_phone() == null || resultvo.getAdmin_phone().equals("")) {
                            		resultData.setErrCd("1"); //휴대폰 오류
                            		resultData.setErrMsg("휴대폰번호가 등록되어 있지 않아 회원 수정화면으로 이동합니다.");
                            		
                            		param.put("login_fail_cnt", 0);
                            		
                            		webcoService.insert("AdminDAO.insertAdminLogin", param);                            
    	                            webcoService.update("AdminDAO.updateLoginFailCnt", param); 	                            	                                                   
    	                                                        
    	                            log.debug(resultvo.getAdmin_index()+":로그인 성공::"+ adminId);
    	                            //session.setAttribute(Captcha.NAME,null); 
    	                            log.debug(resultvo.getAdmin_index()+": admin_chg_pwd ::"+ resultvo.getAdmin_chg_pwd());
    	                            
    	                            session.setMaxInactiveInterval(60*60*1); // 세션 유지시간 1시간
    	                            request.getSession().setAttribute("adminVO", resultvo); // 사용자정보 세션저장
    	                            EgovHttpSessionBindingListener listener = new EgovHttpSessionBindingListener();
    	                            request.getSession().setAttribute(resultvo.getAdmin_id(), listener);
                        		} else if(resultvo.getAdmin_grade().equals("-1"))  {
                        			resultData.setErrCd("00"); //정상 접속
                        			param.put("login_fail_cnt", 0);
                        			
                        			webcoService.insert("AdminDAO.insertAdminLogin", param);                            
    	                            webcoService.update("AdminDAO.updateLoginFailCnt", param); 	                            	                                                   
    	                                                        
    	                            log.debug(resultvo.getAdmin_index()+":로그인 성공::"+ adminId);
    	                            //session.setAttribute(Captcha.NAME,null); 
    	                            log.debug(resultvo.getAdmin_index()+": admin_chg_pwd ::"+ resultvo.getAdmin_chg_pwd());
    	                            
    	                            session.setMaxInactiveInterval(60*60*1); // 세션 유지시간 1시간
    	                            request.getSession().setAttribute("adminVO", resultvo); // 사용자정보 세션저장
    	                            EgovHttpSessionBindingListener listener = new EgovHttpSessionBindingListener();
    	                            request.getSession().setAttribute(resultvo.getAdmin_id(), listener);
    	                            
                        		} else {
                        			resultData.setErrCd("000"); //정상 접속
	                				param.put("login_fail_cnt", 0);
                        			
                        			webcoService.insert("AdminDAO.insertAdminLogin", param);                            
    	                            webcoService.update("AdminDAO.updateLoginFailCnt", param); 	                            	                                                   
    	                                                        
    	                            log.debug(resultvo.getAdmin_index()+":로그인 성공::"+ adminId);
    	                            //session.setAttribute(Captcha.NAME,null); 
    	                            log.debug(resultvo.getAdmin_index()+": admin_chg_pwd ::"+ resultvo.getAdmin_chg_pwd());
    	                            
    	                            session.setMaxInactiveInterval(60*60*1); // 세션 유지시간 1시간
    	                            request.getSession().setAttribute("adminVO", resultvo); // 사용자정보 세션저장
    	                            EgovHttpSessionBindingListener listener = new EgovHttpSessionBindingListener();
    	                            request.getSession().setAttribute(resultvo.getAdmin_id(), listener);
                        			
                        			//sms인증처리 코드
		                            /*session.removeAttribute("auth_num");	                            
		                            EnumValue enumValue = new EnumValue();
		                            
		                            String auth_num = CommonUtil.numberGen(6, 2);	                           
		                            
		                            Map<String, Object> smsMap = new LinkedHashMap<String, Object>();
		                			String sms_send_sender = enumValue.getValue("sms_send_sender", "1");
		                			String[] sender = sms_send_sender.split("-");
		                			smsMap.put("sphone1", sender[0]);
		                			smsMap.put("sphone2", sender[1]);
		                			smsMap.put("sphone3", sender[2]);
		                			
		                			smsMap.put("msg", "[희망서약]로그인 인증번호["+auth_num+"] 인증번호를 입력하세요.");
		                			smsMap.put("rphone", resultvo.getAdmin_phone());						
		                			smsMap.put("smsType", "S");
		                				
		                			log.debug("============auth_num=========="+auth_num);
		                			log.debug("============SMS Msg=========="+smsMap.get("msg"));
		                			SMSManager smsManager = new SMSManager();			
		                			smsMap = smsManager.sendSmsAsync(smsMap);
		                			
		                			if(smsMap.get("rtnCode").toString().equals("success") || smsMap.get("rtnCode").toString().equals("Test Success!")) {
		                				resultData.setErrCd("0"); //정상 접속
		                				//resultData.setErrMsg("로그인 인증번호 : "+auth_num);
			                            param.put("login_fail_cnt", 0);
			                            session.setMaxInactiveInterval(60*3); // 세션 유지시간 3분
			                            session.setAttribute("auth_num", auth_num);
			                            session.setAttribute("auth_login_index", resultvo.getAdmin_index());
		                			} else if (smsMap.get("rtnCode").toString().equals("-102") || smsMap.get("rtnCode").toString().equals("-201")) {
		                				resultData.setErrCd("000"); //정상 접속
		                				param.put("login_fail_cnt", 0);
	                        			
	                        			webcoService.insert("AdminDAO.insertAdminLogin", param);                            
	    	                            webcoService.update("AdminDAO.updateLoginFailCnt", param); 	                            	                                                   
	    	                                                        
	    	                            log.debug(resultvo.getAdmin_index()+":로그인 성공::"+ adminId);
	    	                            //session.setAttribute(Captcha.NAME,null); 
	    	                            log.debug(resultvo.getAdmin_index()+": admin_chg_pwd ::"+ resultvo.getAdmin_chg_pwd());
	    	                            
	    	                            session.setMaxInactiveInterval(60*60*1); // 세션 유지시간 1시간
	    	                            request.getSession().setAttribute("adminVO", resultvo); // 사용자정보 세션저장
	    	                            EgovHttpSessionBindingListener listener = new EgovHttpSessionBindingListener();
	    	                            request.getSession().setAttribute(resultvo.getAdmin_id(), listener);
		                			} else {
		                				resultData.setErrCd("2"); //인증번호 발송 실패
		                				resultData.setErrMsg("로그인 인증번호 발송 중 오류가 발생하였습니다. 다시 로그인 해주세요.");
		                			}*/
	                                                                                    
	                            /*webcoService.insert("AdminDAO.insertAdminLogin", param);                            
	                            webcoService.update("AdminDAO.updateLoginFailCnt", param); 	                            	                                                   
	                                                        
	                            log.debug(resultvo.getAdmin_index()+":로그인 성공::"+ adminId);
	                            //session.setAttribute(Captcha.NAME,null); 
	                            log.debug(resultvo.getAdmin_index()+": admin_chg_pwd ::"+ resultvo.getAdmin_chg_pwd());
	                            
	                            session.setMaxInactiveInterval(60*60*1); // 세션 유지시간 1시간
	                            request.getSession().setAttribute("adminVO", resultvo); // 사용자정보 세션저장
	                            EgovHttpSessionBindingListener listener = new EgovHttpSessionBindingListener();
	                            request.getSession().setAttribute(resultvo.getAdmin_id(), listener);*/ 
                        		}
                        	//}
                        } else {
                            resultData.setErrCd("-1");                                                         
                            resultData.setErrMsg("비밀번호가 일치하지 않습니다."); 
                            param.put("login_fail_cnt", loginFailCnt+1);
                            webcoService.update("AdminDAO.updateLoginFailCnt", param); 
                        }
                    }
                }
            } 
            
        } catch (Exception e) {
            resultData.setErrCd("-2");
            resultData.setErrMsg(e.toString()); 
            log.error(e);
        }
        
        return resultData;

    }
    
	/**
     * 로그아웃한다.
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/actionLogout.do")
    public String actionLogout(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        AdminVO adminVO = new AdminVO();
        adminVO.setAdmin_id(SessionUtil.getAdminId());
//        intranetIndexService.updateUserConectlog(userVO); // 로그아웃 접속로그 저장
                        
        RequestContextHolder.getRequestAttributes().removeAttribute("adminVO", RequestAttributes.SCOPE_SESSION);
        request.getSession().invalidate();
                
        return "redirect:/index.jsp";
    }
}

        