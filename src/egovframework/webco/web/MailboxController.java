package egovframework.webco.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.webco.service.AdminService;
import egovframework.webco.service.HospitalService;
import egovframework.webco.service.MailboxService;
import egovframework.webco.service.WebcoService;
import egovframework.webco.util.CommonUtil;
import egovframework.webco.util.SessionUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class MailboxController {
	
	/** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());

    @Resource(name = "webcoService")
    private WebcoService webcoService;  
    
    @Resource(name = "hospitalService")
    private HospitalService hospitalService;  
    
    @Resource(name = "adminService")
    private AdminService adminService;
    
    @Resource(name = "mailboxService")
    private MailboxService mailboxService;
    
    
    //우체통 전체회원관리
  	@RequestMapping(value="/mailbox/memberMgmtList.do")
  	public String memberMgmtList(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
  		return "mailbox/memberMgmtList";	 	
  	}
  	
  	//우체통 관리
  	@RequestMapping(value="/mailbox/mailboxMgmt.do")
  	public String mailboxMgmtList(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
  		return "mailbox/mailboxMgmtList";	 	
  	}
  	
  	 //우체통 전체회원관리
  	@RequestMapping(value="/mailbox/memberMgmtListAjax.do")
  	public String getMemberMgmtListAjax(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
  		
  		int limit = 5;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
		int offset = page > 0 ? (page-1) * limit : 0;
    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	Map<String, Object> kodaMemberList = mailboxService.selectKodaMemberList(commandMap);
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	paginationInfo.setCurrentPageNo(page);
    	paginationInfo.setRecordCountPerPage(limit);    	
    	paginationInfo.setPageSize(5);    	
    	if(paginationInfo != null){ 
    		paginationInfo.setTotalRecordCount((int)kodaMemberList.get ("totCnt")); 
    		model.addAttribute("paginationInfo", paginationInfo); 
    	}
    	
    	adminService.insertActHist("L", "[생명나눔 우체통]전체 회원 조회");
    	model.addAttribute("total_count", (int)kodaMemberList.get("totCnt"));
    	model.addAttribute("currentPage",page); //현재 페이지 번호
    	model.addAttribute("displayNum",paginationInfo.getPageSize()); //페이지당 게시물 출력 수
    	model.addAttribute("param", commandMap);
    	model.addAttribute("kodaMemberList", kodaMemberList.get("kodaMemberList"));
    	
  		return "mailbox/memberMgmtListAjax";	 	
  	}
  	
  	/**
  	 * 우체통 관리, 발신대기함, 미승인대기목록 리스트 엑셀 다운로드
  	 * @param model
  	 * @param commandMap
  	 * @param request
  	 * @param response
  	 * @return
  	 * @throws Exception
  	 */
	@RequestMapping("/mailbox/exportExcelMemberList.do")
	public @ResponseBody JSONObject exportExcelMemberList(ModelMap model, @RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {			
		    if (SessionUtil.isLoginChk() == false ) {
		    	rtnMap.put("rtnCode", "-1");
		    	rtnMap.put("rtnMsg", "로그인 후 이용해주시기 바랍니다.");
		    } else {
		    	boolean result = mailboxService.exportMemberList(commandMap);
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
        }
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
  	
	//우체통 회원등록 및 수정 페이지
  	@RequestMapping(value="/mailbox/memberRegister.do")
  	public String memberRegister(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
  		
  		Map<String, Object> kodaMemberInfo = mailboxService.selectKodaMemberDetail(commandMap);
  		List<Map<String, Object>> hospitalList = hospitalService.hospitalList(commandMap);
  		List<Map<String, Object>> benefiPartList = mailboxService.selectBenefiPartList(commandMap);
  		
  		Map<String, Object> donorList = mailboxService.selectDonorList(commandMap);
  		List<Map<String, Object>> benefiList = mailboxService.selectBenefiList(commandMap);
  		Map<String, Object> donorRelationList = mailboxService.selectDonorRelationList(commandMap);
  		
  		adminService.insertActHist("L", "[생명나눔 우체통] 회원 등록 페이지 이동");
  		model.addAttribute("kodaMemberInfo", kodaMemberInfo);
  		model.addAttribute("hospitalList", hospitalList);
  		model.addAttribute("benefiPartList", benefiPartList);
  		model.addAttribute("donorList", donorList);
  		model.addAttribute("benefiList", benefiList);
  		model.addAttribute("donorRelationList", donorRelationList.get("donorRelationList"));
  		return "mailbox/memberRegister";	 	
  	}
  	
    /**
     * 관리자 등록
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/mailbox/memberSave.do")
    @ResponseBody
    public JSONObject kodaMemberSave(ModelMap model, @RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	Cookie[] cookies = request.getCookies();
    	int result = 0;
    	Map<String, Object> returnMap = new HashMap<String, Object>();
    	String msg = "";
    	Boolean flag = false;
    	String inpType = commandMap.get("inpType").toString();
    	
    	for(Cookie cookie : cookies) {
    		if("websaveUsrId".equals(cookie.getName())) {
    			commandMap.put("inpId", cookie.getValue());
    			commandMap.put("modId", cookie.getValue());
    		}
    	}
    	
    	// 기본정보 I/U/D
    	if("I".equals(inpType)) {
    		result = Integer.parseInt(mailboxService.insert("MailboxDAO.insertKodaMember", commandMap).toString());
    		adminService.insertActHist("C", "[생명나눔 우체통] 회원 등록 ID : " + EgovStringUtil.isNullToString(commandMap.get("userId")));
    	} else if("U".equals(inpType)) {
    		result = (int)mailboxService.update("MailboxDAO.updateKodaMember", commandMap);
    		adminService.insertActHist("U", "[생명나눔 우체통] 회원 수정 ID : " + EgovStringUtil.isNullToString(commandMap.get("userId")));
    	} else if("D".equals(inpType)) {
    		result = (int)mailboxService.update("MailboxDAO.deleteKodaMember", commandMap);
    		adminService.insertActHist("D", "[생명나눔 우체통] 회원 삭제 ID : " + EgovStringUtil.isNullToString(commandMap.get("userId")));
    	}
    	
    	
    	
    	// 기증자 정보 및 수혜자 정보, 연계회원, 매칭회원 삭제 후 삽입
     	if("I".equals(inpType) || "U".equals(inpType)) {
     		String gubn = commandMap.get("gubn").toString();

     		// 기증자 정보 및 수혜자 정보 삭제 후 재 삽입
    		result += mailboxService.delete("MailboxDAO.deleteDonorList", commandMap);
    		result += mailboxService.delete("MailboxDAO.deleteBenefiList", commandMap);
    		result += mailboxService.delete("MailboxDAO.deleteRelaMatchList", commandMap);
    		
    		// 구분 값이 기증자 가족일 경우
    		if("D".equals(gubn)) {
    			// 기증자 정보 필수
    			result += Integer.parseInt(mailboxService.insert("MailboxDAO.insertDonorListD", commandMap).toString());
    			
    			// 수혜자 정보 선택
    			if(!"".equals(commandMap.get("arrDBenefiName"))) {
    				String[] arrBenefiName = commandMap.get("arrDBenefiName").toString().split(",");
        	    	String[] arrBenefiParts = commandMap.get("arrDBenefiParts").toString().split(",");
        	    	String[] arrBenefiHospital = commandMap.get("arrDBenefiHospital").toString().split(",");
        	    	String[] arrBenefiBirthday = commandMap.get("arrDBenefiBirthday").toString().split(",");
        	    	
        	    	int benefiCnt = arrBenefiName.length;
        			
        			if(benefiCnt != 0) {
        				for(int i=0; i<benefiCnt; i++) {
        					Map<String, Object> benefiParam = new HashMap<String, Object>();
        					benefiParam.put("userId", commandMap.get("userId"));
        					benefiParam.put("benefiName", arrBenefiName[i]);
        					benefiParam.put("benefiParts", arrBenefiParts[i]);
        					benefiParam.put("benefiHospital", arrBenefiHospital[i]);
        					benefiParam.put("benefiBirthday", arrBenefiBirthday[i]);
        					result += Integer.parseInt(mailboxService.insert("MailboxDAO.insertBenefiListD", benefiParam).toString());	
        				}
        			}
    			}
    			
    		} else if("B".equals(gubn)){
    			// 구분 값이 수혜자 일 경우
    			
    			// 수혜자 정보 필수
    			result += Integer.parseInt(mailboxService.insert("MailboxDAO.insertBenefiListB", commandMap).toString());

    			// 기증자 정보 선택
    			if(!"".equals(commandMap.get("bDonorName"))) {
    				result += Integer.parseInt(mailboxService.insert("MailboxDAO.insertDonorListB", commandMap).toString());
    			}
    			
    		}
    		
    		// 연계회원 삽입
    		if(!"".equals(commandMap.get("arrRelationId"))) {
				String[] arrRelationId = commandMap.get("arrRelationId").toString().split(",");
				
				int arrRelationIdCnt = arrRelationId.length;
				
				if(arrRelationIdCnt != 0) {
					for(int i=0; i<arrRelationIdCnt; i++) {
						Map<String, Object> relaMatchParam = new HashMap<String, Object>();
						relaMatchParam.put("id", commandMap.get("userId"));
						relaMatchParam.put("childId", arrRelationId[i]);
						relaMatchParam.put("gubn", "R");
						result += Integer.parseInt(mailboxService.insert("MailboxDAO.insertRelaMatchList", relaMatchParam).toString());	
					}
				}
			}
			
    		// 매칭회원 삽입
			if(!"".equals(commandMap.get("arrMatchId"))) {
				String[] arrMatchId = commandMap.get("arrMatchId").toString().split(",");
				
				int arrMatchIdCnt = arrMatchId.length;
				
				if(arrMatchIdCnt != 0) {
					for(int i=0; i<arrMatchIdCnt; i++) {
						Map<String, Object> relaMatchParam = new HashMap<String, Object>();
						relaMatchParam.put("id", commandMap.get("userId"));
						relaMatchParam.put("childId", arrMatchId[i]);
						relaMatchParam.put("gubn", "M");
						result += Integer.parseInt(mailboxService.insert("MailboxDAO.insertRelaMatchList", relaMatchParam).toString());	
					}
				}
			}
    	} else {
    		// 기증자 정보 및 수혜자 정보 삭제 후 재 삽입
    		result += mailboxService.delete("MailboxDAO.deleteRelaMatchList", commandMap);
    		result += mailboxService.delete("MailboxDAO.deleteRelaMatchSubList", commandMap);
    	}
    	
		if(result > 0) {
			if("I".equals(inpType)) {
				msg = "회원 등록 되었습니다.";
	    	} else if("U".equals(inpType)) { 
	    		msg = "회원 수정 되었습니다.";
	    	} else if("D".equals(inpType)) {
	    		msg = "회원 탈퇴 되었습니다.";
	    	}
			flag = true;
   		} else {
   			if("I".equals(inpType)) {
   				msg = "회원 등록 중 오류가 발생하였습니다. 관리자에게 문의하여 주시기 바랍니다.";
	    	} else if("U".equals(inpType)) { 
   				msg = "회원 수정 중 오류가 발생하였습니다. 관리자에게 문의하여 주시기 바랍니다.";
	    	} else if("D".equals(inpType)) {
   				msg = "회원 탈퇴 중 오류가 발생하였습니다. 관리자에게 문의하여 주시기 바랍니다.";
	    	}
   			flag = false;
   		}
		
		returnMap.put("msg", msg);
		returnMap.put("flag", flag);
   		
//		adminService.insertActHist("C", "[관리자]신규 등록 admin_index : "+EgovStringUtil.isNullToString(commandMap.get("admin_index")));
    	return CommonUtil.getObjectToJSONObject(returnMap);	
    }
    
    /**
     * 회원 상세 -> 승인여부 변경
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/mailbox/updateApprFlag.do")
    @ResponseBody
    public JSONObject updateApprFlag(ModelMap model, @RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	Cookie[] cookies = request.getCookies();
    	
    	int result = 0;
    	Map<String, Object> returnMap = new HashMap<String, Object>();
    	String msg = "";
    	Boolean flag = false;
    	
    	for(Cookie cookie : cookies) {
    		if("websaveUsrId".equals(cookie.getName())) {
    			commandMap.put("inpId", cookie.getValue());
    			commandMap.put("modId", cookie.getValue());
    		}
    	}
    	
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	
    	paramMap.put("modId", commandMap.get("inpId"));
    	paramMap.put("arrId", commandMap.get("id"));
    	paramMap.put("arrAppr", commandMap.get("apprFlag"));
    	
    	result += mailboxService.update("MailboxDAO.updateApprFlag", paramMap);
    	adminService.insertActHist("U", "[생명나눔 우체통] 회원 승인여부 변경 ID : " + EgovStringUtil.isNullToString(commandMap.get("arrId")) + " 값 : " + EgovStringUtil.isNullToString(commandMap.get("arrAppr")));
		if(result > 0) {
			msg = "승인여부가 변경되었습니다.";
			flag = true;
   		} else {
			msg = "승인여부 변경이 실패하였습니다. 관리자에게 문의해 주시기 바랍니다.";
   			flag = false;
   		}
		
		returnMap.put("msg", msg);
		returnMap.put("flag", flag);
   		
//		adminService.insertActHist("C", "[관리자]신규 등록 admin_index : "+EgovStringUtil.isNullToString(commandMap.get("admin_index")));
    	return CommonUtil.getObjectToJSONObject(returnMap);	
    }

    /**
     * 회원 상세 -> 승인여부 변경
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/mailbox/insertMatchList.do")
    @ResponseBody
    public JSONObject insertMatchList(ModelMap model, @RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	Cookie[] cookies = request.getCookies();
    	
    	int result = 0;
    	Map<String, Object> returnMap = new HashMap<String, Object>();
    	String msg = "";
    	Boolean flag = false;
    	
    	for(Cookie cookie : cookies) {
    		if("websaveUsrId".equals(cookie.getName())) {
    			commandMap.put("inpId", cookie.getValue());
    			commandMap.put("modId", cookie.getValue());
    		}
    	}
    	
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	
    	paramMap.put("modId", commandMap.get("inpId"));
    	paramMap.put("arrId", commandMap.get("id"));
    	paramMap.put("arrAppr", commandMap.get("apprFlag"));
    	
    	
    	result += mailboxService.delete("MailboxDAO.deleteRelaMatchList", commandMap);
    	
    	// 매칭회원 삽입
		if(!"".equals(commandMap.get("arrMatchId"))) {
			String[] arrMatchId = commandMap.get("arrMatchId").toString().split(",");
			
			int arrMatchIdCnt = arrMatchId.length;
			
			if(arrMatchIdCnt != 0) {
				for(int i=0; i<arrMatchIdCnt; i++) {
					Map<String, Object> relaMatchParam = new HashMap<String, Object>();
					relaMatchParam.put("id", commandMap.get("userId"));
					relaMatchParam.put("childId", arrMatchId[i]);
					relaMatchParam.put("gubn", "M");
					result += Integer.parseInt(mailboxService.insert("MailboxDAO.insertRelaMatchList", relaMatchParam).toString());	
					adminService.insertActHist("U", "[생명나눔 우체통] 매칭회원 수정 ID : " + EgovStringUtil.isNullToString(commandMap.get("id")));
				}
			}
		}

		if(result > 0) {
    		msg = "매칭회원이 수정 되었습니다.";
    		flag = true;
    	} else {
    		msg = "매칭회원 수정이 실패하였습니다. 관리자에게 문의하시기 바랍니다.";
    		flag = false;
    	}
    	
    	returnMap.put("msg", msg);
    	returnMap.put("flag", flag);
    	
//		adminService.insertActHist("C", "[관리자]신규 등록 admin_index : "+EgovStringUtil.isNullToString(commandMap.get("admin_index")));
    	return CommonUtil.getObjectToJSONObject(returnMap);	
    }
    
	// 회원 등록/수정 -> 연계회원 팝업
  	@RequestMapping(value="/mailbox/relationPop.p")
  	public String relationPop(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
  		model.addAttribute("donorInfo", commandMap);
  		adminService.insertActHist("L", "[생명나눔 우체통] 연계회원 팝업 호출");
  		return "mailbox/relationPop";	 	
  	}
  	
  	// 회원 등록/수정 -> 연계회원 검색
   	@RequestMapping(value="/mailbox/selectRelationPopList.do")
   	public String selectRelationPopList(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
   		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
		int offset = page > 0 ? (page-1) * limit : 0;
    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	Map<String, Object> relaKodaMemberList = mailboxService.selectRelationKodaMemberList(commandMap);
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	paginationInfo.setCurrentPageNo(page);
    	paginationInfo.setRecordCountPerPage(limit);    	
    	paginationInfo.setPageSize(10);    	
    	if(paginationInfo != null){ 
    		paginationInfo.setTotalRecordCount((int)relaKodaMemberList.get ("totCnt")); 
    		model.addAttribute("paginationInfo", paginationInfo); 
    	}
    	adminService.insertActHist("L", "[생명나눔 우체통] 연계회원 리스트 조회");
    	model.addAttribute("total_count", (int)relaKodaMemberList.get("totCnt"));
    	model.addAttribute("currentPage",page); //현재 페이지 번호
    	model.addAttribute("displayNum",paginationInfo.getPageSize()); //페이지당 게시물 출력 수
    	model.addAttribute("param", commandMap);
    	model.addAttribute("relaKodaMemberList", relaKodaMemberList.get("relaKodaMemberList"));
    	model.addAttribute("donorInfo", commandMap);
    	
   		return "mailbox/relationPop";	 	
   	}
    
  	// 회원 등록/수정 -> 매칭회원 팝업
  	@RequestMapping(value="/mailbox/matchingPop.p")
  	public String matchingPop(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
  		model.addAttribute("param", commandMap);
  		adminService.insertActHist("L", "[생명나눔 우체통] 매칭회원 팝업 호출");
  		return "mailbox/matchingPop";	 	
  	}
  	
 // 회원 등록/수정 -> 매칭회원 검색
   	@RequestMapping(value="/mailbox/selectMatchPopList.do")
   	@ResponseBody
   	public JSONObject selectMatchPopList(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
    	
   		Map<String, Object> matchKodaMemberList = mailboxService.selectMatchKodaMemberList(commandMap);
   		JSONObject rtnJson = JSONObject.fromObject(matchKodaMemberList);
   		adminService.insertActHist("L", "[생명나눔 우체통] 매칭회원 리스트 조회");
//    		adminService.insertActHist("C", "[관리자]신규 등록 admin_index : "+EgovStringUtil.isNullToString(commandMap.get("admin_index")));
    	return rtnJson;
   	}
  	
	//우체통 전체회원관리
  	@RequestMapping(value="/mailbox/memberDetail.do")
  	public String memberDetail(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
  		
  		Map<String, Object> kodaMemberInfo = mailboxService.selectKodaMemberDetail(commandMap);
  		
  		model.addAttribute("kodaMemberInfo", kodaMemberInfo);
  		adminService.insertActHist("R", "[우체통]회원 상세 조회 ID : " + EgovStringUtil.isNullToString(commandMap.get("userId")));
  		return "mailbox/memberDetail";	 	
  	}
      	
    
	/**
     * 관리자 등록
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/mailbox/apprFlagUpdate.do")
    @ResponseBody
    public JSONObject apprFlagUpdate(ModelMap model, @RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	Cookie[] cookies = request.getCookies();
    	int result = 0;
    	Map<String, Object> rtnMap = new HashMap<String, Object>();
    	
    	for(Cookie cookie : cookies) {
    		if("websaveUsrId".equals(cookie.getName())) {
    			commandMap.put("inpId", cookie.getValue());
    		}
    		
    	}
    	
    	List<Map<String, Object>> resultMap = new ArrayList<Map<String, Object>>();
    	resultMap = JSONArray.fromObject(commandMap.get("arrData"));
    	
    	for(Map<String, Object> map : resultMap) {
    		map.put("modId", commandMap.get("inpId"));
    		result += mailboxService.update("MailboxDAO.updateApprFlag", map);
    		adminService.insertActHist("U", "[생명나눔 우체통] 회원 승인여부 변경 ID : " + EgovStringUtil.isNullToString(commandMap.get("arrId")) + " 값 : " + EgovStringUtil.isNullToString(commandMap.get("arrAppr")));
    		// 승인상태일 경우 SMS 문자
//    		if("Y".equals(map.get("arrAppr"))) {
//    			SMSManager smsManager = new SMSManager();
//    			rtnMap = smsManager.sendSmsAsync(map);
//    			
//    		}
    	}
    	
    	rtnMap.put("result", result);
    	
//    		adminService.insertActHist("C", "[관리자]신규 등록 admin_index : "+EgovStringUtil.isNullToString(commandMap.get("admin_index")));
    	return CommonUtil.getObjectToJSONObject(rtnMap);	
    }
}
