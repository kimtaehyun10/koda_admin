package egovframework.webco.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.webco.service.AdminService;
import egovframework.webco.service.LetterService;
import egovframework.webco.util.CommonUtil;
import egovframework.webco.util.SMSManager;
import egovframework.webco.util.SessionUtil;
import egovframework.webco.vo.AdminVO;
import net.sf.json.JSONObject;

@Controller
public class LetterController {

	@Resource(name = "adminService")
	private AdminService adminService;
	@Resource(name = "letterService")
	private LetterService letterService;
	private String fileStorePath = EgovProperties.getProperty("globals.fileStorePath");
	
	/**
	 * SMS 전송 공통 모듈
	 * 
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/mailbox/ajaxSendSms.do")
	public @ResponseBody JSONObject ajaxSendSms(@RequestParam Map<String, Object> commandMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		// sms_sender_phone_no : 보내는사람
		// sms_receiverr_phone_no : 받는 사람
		// sms_title : 제목
		// sms_content : 내용

		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("rtnCode", "");
		rtnMap.put("rtnMsg", "");

		Map<String, Object> smsMap = new HashMap<String, Object>();

		if (EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("sms_content")))) {
			rtnMap.put("rtnCode", "-1");
			rtnMap.put("rtnMsg", "메세지 내용을 입력해주세요.");
		} else { 
			smsMap.put("msg", EgovStringUtil.isNullToString(commandMap.get("sms_content")));
		}

		if (EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("sms_receiver_phone_no")))) {
			rtnMap.put("rtnCode", "-1");
			rtnMap.put("rtnMsg", "연락처를 선택해주세요.");
		} else {
			smsMap.put("rphone", EgovStringUtil.isNullToString(commandMap.get("sms_receiverr_phone_no")));
		}

		if (EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("sms_sender_phone_no")))) {
			rtnMap.put("rtnCode", "-1");
			rtnMap.put("rtnMsg", "보내는 이의 연락처를 선택해주세요.");
		} else {
			String sms_send_sender = EgovStringUtil.isNullToString(commandMap.get("sms_sender_phone_no"));
			String[] sender = sms_send_sender.split("-");

			smsMap.put("sphone1", sender[0]);
			smsMap.put("sphone2", sender[1]);
			smsMap.put("sphone3", sender[2]);

		}

		if (EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("smsType")))) {
			smsMap.put("smsType", EgovStringUtil.isNullToString(commandMap.get("smsType")));
		}

		SMSManager smsManager = new SMSManager();
		rtnMap = smsManager.sendSmsAsync(smsMap);

		rtnMap.put("search_value", commandMap);
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}

	/**
	 * 파일 다운로드(우체통 공통 파일다운로드 처리)
	 * 
	 * @param commandMap
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/filedown.do")
	public void filedown(@RequestParam Map<String, Object> commandMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map<String, Object> map = null;
		String fileNm = "";
		String fileOrgNm = "";
		if (commandMap.get("type").equals("letter")) {
			map = letterService.selectTypeLetterFile(commandMap);
			fileNm = (String) map.get("letter_file_nm");
			fileOrgNm = (String) map.get("letter_file_org_nm");
		}

		if (map == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>self.close();</script>");
			out.flush();
			return;
		} else {
			
	 		String path = fileStorePath;
			byte fileByte[] = FileUtils.readFileToByteArray(new File(path + "/" + fileNm));

			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition",
					"attachment; fileName=\"" + URLEncoder.encode(fileOrgNm, "UTF-8") + "\";");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
	}

	// -------------------------------- VALIDATION 모듈 정리
	// ----------------------------------------------------------------------//
	/**
	 * 스킨 사용여부 체크
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mailbox/ajaxUseSkinLetterId.do")
	public @ResponseBody JSONObject ajaxUseSkinLetterId(ModelMap model, @RequestParam Map<String, Object> commandMap)
			throws Exception {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		int useSkinLetterId = letterService.selectUseSkinLetterId(commandMap);

		if (useSkinLetterId == 0) {
			rtnMap.put("rtnCode", "0");
		} else {
			rtnMap.put("rtnCode", "-1");
			rtnMap.put("rtnMsg", "게시판에 스킨이 사용중이므로 삭제가 불가능합니다.");
		}
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}

	@RequestMapping("/mailbox/ajaxDuplicateSkinName.do")
	public @ResponseBody JSONObject ajaxDuplicateSkinName(ModelMap model, @RequestParam Map<String, Object> commandMap)
			throws Exception {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		int duplicateSkinName = letterService.selectDuplicateSkinName(commandMap);
		if (duplicateSkinName == 0) {
			rtnMap.put("rtnCode", "0");
		} else {
			rtnMap.put("rtnCode", "-1");
			rtnMap.put("rtnMsg", "중복된 스킨명이 존재합니다.");
		}
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}

	@RequestMapping("/mailbox/ajaxLetterReplyCheck.do")
	public @ResponseBody JSONObject ajaxLetterReplyCheck(ModelMap model, @RequestParam Map<String, Object> commandMap)
			throws Exception {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		int letterReplyCheck = letterService.selectLetterReplyCheck(commandMap);
		if (letterReplyCheck == 0) {
			rtnMap.put("rtnCode", "0");
		} else {
			rtnMap.put("rtnCode", "-1");
			rtnMap.put("rtnMsg", "답글이 존재하므로 삭제가 불가능합니다.");
		}
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}

	// ------------------------------ 우체통 관리를 사용하는데에 있어 공통 모듈 정리
	// ----------------------------------------------------------//
	/**
	 * 우체통 관리, 발신대기함, 미승인대기목록 리스트 엑셀 다운로드
	 * 
	 * @param model
	 * @param commandMap
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mailbox/exportExcelLetterList.do")
	public @ResponseBody JSONObject exportExcelLetterList(ModelMap model, @RequestParam Map<String, Object> commandMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			if (SessionUtil.isLoginChk() == false) {
				rtnMap.put("rtnCode", "-1");
				rtnMap.put("rtnMsg", "로그인 후 이용해주시기 바랍니다.");
			} else {
				boolean result = letterService.exportLetterList(commandMap);
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

	/**
	 * 생명나눔 우체통 > 우체통관리 > 편지쓰기 > 보내는 사람 > 검색
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterSenderSearchPopup.p")
	public String letterSenderSearchPopup(ModelMap model, @RequestParam Map<String, Object> commandMap)
			throws Exception {
		int limit = 10;
		int page = 1;

		if (!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}

		int offset = page > 0 ? (page - 1) * limit : 0;

		commandMap.put("offset", offset);
		commandMap.put("limit", limit);

		List<Map<String, Object>> letterSenderList = letterService.selectLetterSenderSearchList(commandMap);
		int total_count = letterService.selectLetterSenderSearchListTotCnt(commandMap);

		model.addAttribute("letterSenderList", letterSenderList);
		model.addAttribute("total_count", total_count);
		model.addAttribute("currentPage", page); // 현재 페이지 번호

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(limit);
		paginationInfo.setPageSize(10);
		if (paginationInfo != null) {
			paginationInfo.setTotalRecordCount(total_count);
			model.addAttribute("paginationInfo", paginationInfo);
		}

		AdminVO adminVO = SessionUtil.getAuthenticatedUser();
		model.addAttribute("admin_grade", adminVO.getAdmin_grade());
		model.addAttribute("param", commandMap);
		model.addAttribute("displayNum", paginationInfo.getPageSize());
		return "letter/popup/letterSenderSearchPopup";
	}

	/**
	 * 생명나눔 우체통 > 우체통관리, 발신대기함, 미승인대기목록 > 관리자 > 관리자 예시등록 > 관리자 찾기
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterAdminSearchPopup.p")
	public String letterAdminSearchPopup(ModelMap model, @RequestParam Map<String, Object> commandMap)
			throws Exception {
		int limit = 10;
		int page = 1;

		if (!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}

		int offset = page > 0 ? (page - 1) * limit : 0;

		commandMap.put("offset", offset);
		commandMap.put("limit", limit);

		List<Map<String, Object>> letterAdminList = letterService.selectLetterAdminSearchList(commandMap);
		int total_count = letterService.selectLetterAdminSearchListTotCnt(commandMap);

		model.addAttribute("letterAdminList", letterAdminList);
		model.addAttribute("total_count", total_count);
		model.addAttribute("currentPage", page); // 현재 페이지 번호

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(limit);
		paginationInfo.setPageSize(10);
		if (paginationInfo != null) {
			paginationInfo.setTotalRecordCount(total_count);
			model.addAttribute("paginationInfo", paginationInfo);
		}

		AdminVO adminVO = SessionUtil.getAuthenticatedUser();
		model.addAttribute("admin_grade", adminVO.getAdmin_grade());
		model.addAttribute("param", commandMap);
		model.addAttribute("displayNum", paginationInfo.getPageSize());
		return "letter/popup/letterAdminSearchPopup";
	}

	/**
	 * 생명나눔 우체통 > 우체통관리, 발신대기함, 미승인대기목록 > 편지쓰기 > 미리보기
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterPreview.do")
	public @ResponseBody JSONObject letterPreview(ModelMap model, @RequestParam Map<String, Object> commandMap)
			throws Exception {
		List<Map<String, Object>> letterSkinList = letterService.selectLetterSkinList(commandMap);
		Map<String, Object> letterSkin = letterSkinList.get(0);
		return CommonUtil.getJsonStringFromMap(letterSkin);
	}

	// ------------------------------ 우체통 관리
	// ----------------------------------------------------------------------------------//
	/**
	 * 생명나눔 우체통 > 우체통관리 > 리스트
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterList.do")
	public String letterList(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		int limit = 10;
		int page = 1;

		if (!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}

		int offset = page > 0 ? (page - 1) * limit : 0;

		commandMap.put("offset", offset);
		commandMap.put("limit", limit);

		List<Map<String, Object>> letterList = letterService.selectLetterList(commandMap);
		int total_count = letterService.selectLetterListTotCnt(commandMap);

		model.addAttribute("letterList", letterList);
		model.addAttribute("total_count", total_count);
		model.addAttribute("currentPage", page); // 현재 페이지 번호

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(limit);
		paginationInfo.setPageSize(10);
		if (paginationInfo != null) {
			paginationInfo.setTotalRecordCount(total_count);
			model.addAttribute("paginationInfo", paginationInfo);
		}

		AdminVO adminVO = SessionUtil.getAuthenticatedUser();
		model.addAttribute("admin_grade", adminVO.getAdmin_grade());
		model.addAttribute("param", commandMap);
		model.addAttribute("displayNum", paginationInfo.getPageSize());
		return "letter/letterList";
	}

	/**
	 * 생명나눔 우체통 > 우체통관리 > 편지쓰기
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterWriteForm.do")
	public String letterWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		List<Map<String, Object>> letterSkinList = letterService.selectLetterSkinList(commandMap);
		model.addAttribute("letterSkinList", letterSkinList);
		return "letter/write/letterWriteForm";
	}

	/**
	 * 생명나눔 우체통 > 우체통관리 > 편지쓰기 > 저장
	 * 
	 * @param model
	 * @param commandMap
	 * @param multipartFile1
	 * @param multipartFile2
	 * @param multipartFile3
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterSave.do")
	public String letterSave(ModelMap model, @RequestParam Map<String, Object> commandMap,
			@RequestParam(value = "letter_file_org_nm1", required = false) MultipartFile multipartFile1,
			@RequestParam(value = "letter_file_org_nm2", required = false) MultipartFile multipartFile2,
			@RequestParam(value = "letter_file_org_nm3", required = false) MultipartFile multipartFile3,
			HttpServletRequest request) throws Exception {
		commandMap.put("create_id", SessionUtil.getAdminId());
		letterService.saveLetterWrite(commandMap, multipartFile1, multipartFile2, multipartFile3, request);
		return "redirect:/mailbox/letterList.do";
	}

	/**
	 * 생명나눔 우체통 > 우체통관리 > 편지쓰기 > 수정하기 폼
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterUpdateForm.do")
	public String letterUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		Map<String, Object> letter = letterService.selectLetterView(commandMap);
		List<Map<String, Object>> letterFileList = letterService.selectLetterFileList(commandMap);
		List<Map<String, Object>> letterSkinList = letterService.selectLetterSkinList(commandMap);
		model.addAttribute("letter", letter);
		model.addAttribute("letterSkinList", letterSkinList);
		model.addAttribute("letterFileList", letterFileList);
		return "letter/update/letterUpdateForm";
	}

	/**
	 * 생명나눔 우체통 > 우체통관리 > 편지쓰기 > 수정저장
	 * 
	 * @param model
	 * @param commandMap
	 * @param multipartFile1
	 * @param multipartFile2
	 * @param multipartFile3
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterUpdate.do")
	public String letterUpdate(ModelMap model, @RequestParam Map<String, Object> commandMap,
			@RequestParam(value = "letter_file_org_nm1", required = false) MultipartFile multipartFile1,
			@RequestParam(value = "letter_file_org_nm2", required = false) MultipartFile multipartFile2,
			@RequestParam(value = "letter_file_org_nm3", required = false) MultipartFile multipartFile3,
			HttpServletRequest request) throws Exception {
		commandMap.put("create_id", SessionUtil.getAdminId());
		letterService.letterUpdate(commandMap, multipartFile1, multipartFile2, multipartFile3, request);
		return "redirect:/mailbox/letterView.do?letter_id=" + commandMap.get("letter_id");
	}

	/**
	 * 생명나눔 우체통 > 우체통관리 > 편지쓰기 > 수정저장
	 * 
	 * @param model
	 * @param commandMap
	 * @param multipartFile1
	 * @param multipartFile2
	 * @param multipartFile3
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterDelete.do")
	public String letterDelete(ModelMap model, @RequestParam Map<String, Object> commandMap, HttpServletRequest request)
			throws Exception {
		commandMap.put("create_id", SessionUtil.getAdminId());
		letterService.letterDelete(commandMap);
		return "redirect:/mailbox/letterList.do";
	}

	/**
	 * 생명나눔 우체통 > 우체통관리 > 편지보기
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterView.do")
	public String letterView(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		Map<String, Object> letter = letterService.selectLetterView(commandMap);
		List<Map<String, Object>> letterFileList = letterService.selectLetterFileList(commandMap);
		List<Map<String, Object>> letterSkinList = letterService.selectLetterSkinList(commandMap);
		model.addAttribute("letter", letter);
		model.addAttribute("letterSkinList", letterSkinList);
		model.addAttribute("letterFileList", letterFileList);
		return "letter/view/letterViewForm";
	}

	/**
	 * 생명나눔 우체통 > 우체통관리 > 답글쓰기
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterReplyWriteForm.do")
	public String letterReplyWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		Map<String, Object> letter = letterService.selectLetterView(commandMap);
		List<Map<String, Object>> letterSkinList = letterService.selectLetterSkinList(commandMap);
		model.addAttribute("letter", letter);
		model.addAttribute("letterSkinList", letterSkinList);
		return "letter/write/letterReplyWriteForm";
	}

	/**
	 * 생명나눔 우체통 > 우체통관리 > 답글쓰기 > 저장
	 * 
	 * @param model
	 * @param commandMap
	 * @param multipartFile1
	 * @param multipartFile2
	 * @param multipartFile3
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterReplySave.do")
	public String letterReplySave(ModelMap model, @RequestParam Map<String, Object> commandMap,
			@RequestParam(value = "letter_file_org_nm1", required = false) MultipartFile multipartFile1,
			@RequestParam(value = "letter_file_org_nm2", required = false) MultipartFile multipartFile2,
			@RequestParam(value = "letter_file_org_nm3", required = false) MultipartFile multipartFile3,
			HttpServletRequest request) throws Exception {
		commandMap.put("create_id", SessionUtil.getAdminId());
		letterService.saveLetterReplyWrite(commandMap, multipartFile1, multipartFile2, multipartFile3, request);
		return "redirect:/mailbox/letterList.do";
	}

	// ------------------------------ 발신대기함
	// ----------------------------------------------------------------------------------//
	/**
	 * 생명나눔 우체통 > 발신대기함 > 리스트
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterWaitList.do")
	public String letterWaitList(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		commandMap.put("status", "sendStay");
		int limit = 10;
		int page = 1;

		if (!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}

		int offset = page > 0 ? (page - 1) * limit : 0;

		commandMap.put("offset", offset);
		commandMap.put("limit", limit);

		List<Map<String, Object>> letterList = letterService.selectLetterList(commandMap);
		int total_count = letterService.selectLetterListTotCnt(commandMap);

		model.addAttribute("letterList", letterList);
		model.addAttribute("total_count", total_count);
		model.addAttribute("currentPage", page); // 현재 페이지 번호

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(limit);
		paginationInfo.setPageSize(10);
		if (paginationInfo != null) {
			paginationInfo.setTotalRecordCount(total_count);
			model.addAttribute("paginationInfo", paginationInfo);
		}

		AdminVO adminVO = SessionUtil.getAuthenticatedUser();
		model.addAttribute("admin_grade", adminVO.getAdmin_grade());
		model.addAttribute("param", commandMap);
		model.addAttribute("displayNum", paginationInfo.getPageSize());
		return "letter/letterWaitList";
	}

	/**
	 * 생명나눔 우체통 > 발신대기함 > 편지쓰기
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterWaitWriteForm.do")
	public String letterWaitWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		List<Map<String, Object>> letterSkinList = letterService.selectLetterSkinList(commandMap);
		model.addAttribute("letterSkinList", letterSkinList);
		return "letter/write/letterWaitWriteForm";
	}

	/**
	 * 생명나눔 우체통 > 발신대기함 > 편지쓰기 > 저장
	 * 
	 * @param model
	 * @param commandMap
	 * @param multipartFile1
	 * @param multipartFile2
	 * @param multipartFile3
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterWaitSave.do")
	public String letterWaitSave(ModelMap model, @RequestParam Map<String, Object> commandMap,
			@RequestParam(value = "letter_file_org_nm1", required = false) MultipartFile multipartFile1,
			@RequestParam(value = "letter_file_org_nm2", required = false) MultipartFile multipartFile2,
			@RequestParam(value = "letter_file_org_nm3", required = false) MultipartFile multipartFile3,
			HttpServletRequest request) throws Exception {
		commandMap.put("create_id", SessionUtil.getAdminId());
		letterService.saveLetterWrite(commandMap, multipartFile1, multipartFile2, multipartFile3, request);
		return "redirect:/mailbox/letterWaitList.do";
	}

	/**
	 * 생명나눔 우체통 > 발신대기함 > 편지쓰기 > 수정하기 폼
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterWaitUpdateForm.do")
	public String letterWaitUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		Map<String, Object> letter = letterService.selectLetterView(commandMap);
		List<Map<String, Object>> letterFileList = letterService.selectLetterFileList(commandMap);
		List<Map<String, Object>> letterSkinList = letterService.selectLetterSkinList(commandMap);
		model.addAttribute("letter", letter);
		model.addAttribute("letterSkinList", letterSkinList);
		model.addAttribute("letterFileList", letterFileList);
		return "letter/update/letterWaitUpdateForm";
	}

	/**
	 * 생명나눔 우체통 > 발신대기함 > 편지쓰기 > 수정저장
	 * 
	 * @param model
	 * @param commandMap
	 * @param multipartFile1
	 * @param multipartFile2
	 * @param multipartFile3
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterWaitUpdate.do")
	public String letterWaitUpdate(ModelMap model, @RequestParam Map<String, Object> commandMap,
			@RequestParam(value = "letter_file_org_nm1", required = false) MultipartFile multipartFile1,
			@RequestParam(value = "letter_file_org_nm2", required = false) MultipartFile multipartFile2,
			@RequestParam(value = "letter_file_org_nm3", required = false) MultipartFile multipartFile3,
			HttpServletRequest request) throws Exception {
		commandMap.put("create_id", SessionUtil.getAdminId());
		letterService.letterUpdate(commandMap, multipartFile1, multipartFile2, multipartFile3, request);
		return "redirect:/mailbox/letterWaitView.do?letter_id=" + commandMap.get("letter_id");
	}

	/**
	 * 생명나눔 우체통 > 발신대기함 > 편지쓰기 > 수정저장
	 * 
	 * @param model
	 * @param commandMap
	 * @param multipartFile1
	 * @param multipartFile2
	 * @param multipartFile3
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterWaitDelete.do")
	public String letterWaitDelete(ModelMap model, @RequestParam Map<String, Object> commandMap,
			HttpServletRequest request) throws Exception {
		commandMap.put("create_id", SessionUtil.getAdminId());
		letterService.letterDelete(commandMap);
		return "redirect:/mailbox/letterWaitList.do";
	}

	/**
	 * 생명나눔 우체통 > 발신대기함 > 편지보기
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterWaitView.do")
	public String letterWaitView(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		Map<String, Object> letter = letterService.selectLetterView(commandMap);
		List<Map<String, Object>> letterFileList = letterService.selectLetterFileList(commandMap);
		List<Map<String, Object>> letterSkinList = letterService.selectLetterSkinList(commandMap);
		model.addAttribute("letter", letter);
		model.addAttribute("letterSkinList", letterSkinList);
		model.addAttribute("letterFileList", letterFileList);
		return "letter/view/letterWaitViewForm";
	}

	/**
	 * 생명나눔 우체통 > 발신대기함 > 답글쓰기
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterWaitReplyWriteForm.do")
	public String letterWaitReplyWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap)
			throws Exception {
		Map<String, Object> letter = letterService.selectLetterView(commandMap);
		List<Map<String, Object>> letterSkinList = letterService.selectLetterSkinList(commandMap);
		model.addAttribute("letter", letter);
		model.addAttribute("letterSkinList", letterSkinList);
		return "letter/write/letterWaitReplyWriteForm";
	}

	/**
	 * 생명나눔 우체통 > 발신대기함 > 답글쓰기 > 저장
	 * 
	 * @param model
	 * @param commandMap
	 * @param multipartFile1
	 * @param multipartFile2
	 * @param multipartFile3
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterWaitReplySave.do")
	public String letterWaitReplySave(ModelMap model, @RequestParam Map<String, Object> commandMap,
			@RequestParam(value = "letter_file_org_nm1", required = false) MultipartFile multipartFile1,
			@RequestParam(value = "letter_file_org_nm2", required = false) MultipartFile multipartFile2,
			@RequestParam(value = "letter_file_org_nm3", required = false) MultipartFile multipartFile3,
			HttpServletRequest request) throws Exception {
		commandMap.put("create_id", SessionUtil.getAdminId());
		letterService.saveLetterReplyWrite(commandMap, multipartFile1, multipartFile2, multipartFile3, request);
		return "redirect:/mailbox/letterWaitList.do";
	}

	// ------------------------------ 미승인대기목록
	// ----------------------------------------------------------------------------------//
	/**
	 * 생명나눔 우체통 > 미승인대기목록 > 리스트
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterNotApprovalList.do")
	public String letterNotApprovalList(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		commandMap.put("status", "notApproval");
		int limit = 10;
		int page = 1;

		if (!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}

		int offset = page > 0 ? (page - 1) * limit : 0;

		commandMap.put("offset", offset);
		commandMap.put("limit", limit);

		List<Map<String, Object>> letterList = letterService.selectLetterList(commandMap);
		int total_count = letterService.selectLetterListTotCnt(commandMap);

		model.addAttribute("letterList", letterList);
		model.addAttribute("total_count", total_count);
		model.addAttribute("currentPage", page); // 현재 페이지 번호

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(limit);
		paginationInfo.setPageSize(10);
		if (paginationInfo != null) {
			paginationInfo.setTotalRecordCount(total_count);
			model.addAttribute("paginationInfo", paginationInfo);
		}

		AdminVO adminVO = SessionUtil.getAuthenticatedUser();
		model.addAttribute("admin_grade", adminVO.getAdmin_grade());
		model.addAttribute("param", commandMap);
		model.addAttribute("displayNum", paginationInfo.getPageSize());
		return "letter/letterNotApprovalList";
	}

	/**
	 * 생명나눔 우체통 > 미승인대기목록 > 편지쓰기
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterNotApprovalWriteForm.do")
	public String letterNotApprovalWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap)
			throws Exception {
		List<Map<String, Object>> letterSkinList = letterService.selectLetterSkinList(commandMap);
		model.addAttribute("letterSkinList", letterSkinList);
		return "letter/write/letterNotApprovalWriteForm";
	}

	/**
	 * 생명나눔 우체통 > 미승인대기목록 > 편지쓰기 > 저장
	 * 
	 * @param model
	 * @param commandMap
	 * @param multipartFile1
	 * @param multipartFile2
	 * @param multipartFile3
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterNotApprovalSave.do")
	public String letterNotApprovalSave(ModelMap model, @RequestParam Map<String, Object> commandMap,
			@RequestParam(value = "letter_file_org_nm1", required = false) MultipartFile multipartFile1,
			@RequestParam(value = "letter_file_org_nm2", required = false) MultipartFile multipartFile2,
			@RequestParam(value = "letter_file_org_nm3", required = false) MultipartFile multipartFile3,
			HttpServletRequest request) throws Exception {
		commandMap.put("create_id", SessionUtil.getAdminId());
		letterService.saveLetterWrite(commandMap, multipartFile1, multipartFile2, multipartFile3, request);
		return "redirect:/mailbox/letterNotApprovalList.do";
	}

	/**
	 * 생명나눔 우체통 > 미승인 대기목록 > 편지쓰기 > 수정하기 폼
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterNotApprovalUpdateForm.do")
	public String letterNotApprovalUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap)
			throws Exception {
		Map<String, Object> letter = letterService.selectLetterView(commandMap);
		List<Map<String, Object>> letterFileList = letterService.selectLetterFileList(commandMap);
		List<Map<String, Object>> letterSkinList = letterService.selectLetterSkinList(commandMap);
		model.addAttribute("letter", letter);
		model.addAttribute("letterSkinList", letterSkinList);
		model.addAttribute("letterFileList", letterFileList);
		return "letter/update/letterNotApprovalUpdateForm";
	}

	/**
	 * 생명나눔 우체통 > 미승인대기목록 > 편지쓰기 > 수정저장
	 * 
	 * @param model
	 * @param commandMap
	 * @param multipartFile1
	 * @param multipartFile2
	 * @param multipartFile3
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterNotApprovalUpdate.do")
	public String letterNotApprovalUpdate(ModelMap model, @RequestParam Map<String, Object> commandMap,
			@RequestParam(value = "letter_file_org_nm1", required = false) MultipartFile multipartFile1,
			@RequestParam(value = "letter_file_org_nm2", required = false) MultipartFile multipartFile2,
			@RequestParam(value = "letter_file_org_nm3", required = false) MultipartFile multipartFile3,
			HttpServletRequest request) throws Exception {
		commandMap.put("create_id", SessionUtil.getAdminId());
		letterService.letterUpdate(commandMap, multipartFile1, multipartFile2, multipartFile3, request);
		return "redirect:/mailbox/letterNotApprovalView.do?letter_id=" + commandMap.get("letter_id");
	}

	/**
	 * 생명나눔 우체통 > 미승인대기목록 > 편지쓰기 > 수정저장
	 * 
	 * @param model
	 * @param commandMap
	 * @param multipartFile1
	 * @param multipartFile2
	 * @param multipartFile3
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterNotApprovalDelete.do")
	public String letterNotApprovalDelete(ModelMap model, @RequestParam Map<String, Object> commandMap,
			HttpServletRequest request) throws Exception {
		commandMap.put("create_id", SessionUtil.getAdminId());
		letterService.letterDelete(commandMap);
		return "redirect:/mailbox/letterNotApprovalList.do";
	}

	/**
	 * 생명나눔 우체통 > 미승인대기목록 > 편지보기
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterNotApprovalView.do")
	public String letterNotApprovalView(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		Map<String, Object> letter = letterService.selectLetterView(commandMap);
		List<Map<String, Object>> letterFileList = letterService.selectLetterFileList(commandMap);
		List<Map<String, Object>> letterSkinList = letterService.selectLetterSkinList(commandMap);
		model.addAttribute("letter", letter);
		model.addAttribute("letterSkinList", letterSkinList);
		model.addAttribute("letterFileList", letterFileList);
		return "letter/view/letterNotApprovalViewForm";
	}

	/**
	 * 생명나눔 우체통 > 미승인대기목록 > 답글쓰기
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterNotApprovalReplyWriteForm.do")
	public String letterNotApprovalReplyWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap)
			throws Exception {
		Map<String, Object> letter = letterService.selectLetterView(commandMap);
		List<Map<String, Object>> letterSkinList = letterService.selectLetterSkinList(commandMap);
		model.addAttribute("letter", letter);
		model.addAttribute("letterSkinList", letterSkinList);
		return "letter/write/letterNotApprovalReplyWriteForm";
	}

	/**
	 * 생명나눔 우체통 > 미승인대기목록 > 답글쓰기 > 저장
	 * 
	 * @param model
	 * @param commandMap
	 * @param multipartFile1
	 * @param multipartFile2
	 * @param multipartFile3
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterNotApprovalReplySave.do")
	public String letterNotApprovalReplySave(ModelMap model, @RequestParam Map<String, Object> commandMap,
			@RequestParam(value = "letter_file_org_nm1", required = false) MultipartFile multipartFile1,
			@RequestParam(value = "letter_file_org_nm2", required = false) MultipartFile multipartFile2,
			@RequestParam(value = "letter_file_org_nm3", required = false) MultipartFile multipartFile3,
			HttpServletRequest request) throws Exception {
		commandMap.put("create_id", SessionUtil.getAdminId());
		letterService.saveLetterReplyWrite(commandMap, multipartFile1, multipartFile2, multipartFile3, request);
		return "redirect:/mailbox/letterNotApprovalList.do";
	}

	// ------------------------------------------ 관리자
	// ------------------------------------------------------//
	@RequestMapping(value = "/mailbox/letterAdmin.do")
	public String letterAdminList(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		int limit = 10;
		int page = 1;

		if (!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}

		int offset = page > 0 ? (page - 1) * limit : 0;

		commandMap.put("offset", offset);
		commandMap.put("limit", limit);

		List<Map<String, Object>> letterAdminList = letterService.selectLetterAdminList(commandMap);
		int total_count = letterService.selectLetterAdminListTotCnt(commandMap);

		model.addAttribute("letterAdminList", letterAdminList);
		model.addAttribute("total_count", total_count);
		model.addAttribute("currentPage", page);

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(limit);
		paginationInfo.setPageSize(10);
		if (paginationInfo != null) {
			paginationInfo.setTotalRecordCount(total_count);
			model.addAttribute("paginationInfo", paginationInfo);
		}

		AdminVO adminVO = SessionUtil.getAuthenticatedUser();
		model.addAttribute("admin_grade", adminVO.getAdmin_grade());
		model.addAttribute("param", commandMap);
		model.addAttribute("displayNum", paginationInfo.getPageSize()); // 페이지당 게시물 출력 수

		return "letter/letterAdminList";
	}

	/**
	 * 생명나눔 우체통 > 관리자 > 관리자 예시등록
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterAdminWriteForm.do")
	public String letterAdminWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		return "letter/write/letterAdminWriteForm";
	}

	/**
	 * 생명나눔 우체통 > 관리자 > 관리자 예시등록 > 관리자 찾기
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/adminSearchPopup.p")
	public String adminSearchPopup(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		int limit = 10;
		int page = 1;

		if (!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}

		int offset = page > 0 ? (page - 1) * limit : 0;

		commandMap.put("offset", offset);
		commandMap.put("limit", limit);

		List<Map<String, Object>> adminList = letterService.selectAdminSearchList(commandMap);
		int total_count = letterService.selectAdminSearchListTotCnt(commandMap);

		model.addAttribute("adminList", adminList);
		model.addAttribute("total_count", total_count);
		model.addAttribute("currentPage", page); // 현재 페이지 번호

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(limit);
		paginationInfo.setPageSize(10);
		if (paginationInfo != null) {
			paginationInfo.setTotalRecordCount(total_count);
			model.addAttribute("paginationInfo", paginationInfo);
		}

		AdminVO adminVO = SessionUtil.getAuthenticatedUser();
		model.addAttribute("admin_grade", adminVO.getAdmin_grade());
		model.addAttribute("param", commandMap);
		model.addAttribute("displayNum", paginationInfo.getPageSize());
		return "letter/popup/adminSearchPopup";
	}

	/**
	 * 생명나눔 우체통 > 관리자 > 관리자 예시등록 > 저장
	 * 
	 * @param model
	 * @param commandMap
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterAdminSave.do")
	public String letterAdminSave(ModelMap model, @RequestParam Map<String, Object> commandMap,
			HttpServletRequest request) throws Exception {
		commandMap.put("create_id", SessionUtil.getAdminId());
		String letter_admin_id = letterService.saveLetterAdmin(commandMap, request);
		return "redirect:/mailbox/letterAdminView.do?letter_admin_id=" + letter_admin_id;
	}

	/**
	 * 생명나눔 우체통 > 관리자 > 관리자 예시등록 > 수정하기 폼
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterAdminUpdateForm.do")
	public String letterAdminUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		List<Map<String, Object>> letterAdminList = letterService.selectLetterAdminList(commandMap);
		if (letterAdminList.size() != 1) {
		}
		Map<String, Object> letterAdmin = letterAdminList.get(0);
		model.addAttribute("letterAdmin", letterAdmin);
		return "letter/update/letterAdminUpdateForm";
	}

	/**
	 * 생명나눔 우체통 > 관리자 > 관리자 예시등록 > 수정저장
	 * 
	 * @param model
	 * @param commandMap
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterAdminUpdate.do")
	public String letterAdminUpdate(ModelMap model, @RequestParam Map<String, Object> commandMap,
			HttpServletRequest request) throws Exception {
		commandMap.put("create_id", SessionUtil.getAdminId());
		letterService.updateLetterAdmin(commandMap, request);
		return "redirect:/mailbox/letterAdminView.do?letter_admin_id=" + commandMap.get("letter_admin_id");
	}

	/**
	 * 생명나눔 우체통 > 관리자 예시등록 > 보기
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterAdminView.do")
	public String letterAdminView(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		List<Map<String, Object>> letterAdminList = letterService.selectLetterAdminList(commandMap);
		if (letterAdminList.size() != 1) {
		}
		Map<String, Object> letterAdmin = letterAdminList.get(0);
		model.addAttribute("letterAdmin", letterAdmin);
		return "letter/view/letterAdminViewForm";
	}

	/**
	 * 생명나눔 우체통 > 관리자 > 관리자 예시등록 > 삭제
	 * 
	 * @param model
	 * @param commandMap
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterAdminDelete.do")
	public String letterAdminDelete(ModelMap model, @RequestParam Map<String, Object> commandMap,
			HttpServletRequest request) throws Exception {
		commandMap.put("create_id", SessionUtil.getAdminId());
		letterService.deleteLetterAdmin(commandMap, request);
		return "redirect:/mailbox/letterAdmin.do";
	}

	// --------------------------------------스킨관리
	// -------------------------------------------------------//
	/**
	 * 생명나눔 우체통 > 스킨관리
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterSkinList.do")
	public String letterSkinList(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		int limit = 10;
		int page = 1;

		if (!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}

		int offset = page > 0 ? (page - 1) * limit : 0;

		commandMap.put("offset", offset);
		commandMap.put("limit", limit);

		List<Map<String, Object>> letterSkinList = letterService.selectLetterSkinList(commandMap);
		int total_count = letterService.selectLetterSkinListTotCnt(commandMap);

		model.addAttribute("letterSkinList", letterSkinList);
		model.addAttribute("total_count", total_count);
		model.addAttribute("currentPage", page);

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(limit);
		paginationInfo.setPageSize(10);
		if (paginationInfo != null) {
			paginationInfo.setTotalRecordCount(total_count);
			model.addAttribute("paginationInfo", paginationInfo);
		}

		AdminVO adminVO = SessionUtil.getAuthenticatedUser();
		model.addAttribute("admin_grade", adminVO.getAdmin_grade());
		model.addAttribute("param", commandMap);
		model.addAttribute("displayNum", paginationInfo.getPageSize()); // 페이지당 게시물 출력 수

		return "letter/letterSkinList";
	}

	/**
	 * 편지지 스킨 등록
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterSkinWriteForm.do")
	public String letterSkinWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		return "letter/write/letterSkinWriteForm";
	}

	/**
	 * 편지지 스킨 등록 저장
	 * 
	 * @param model
	 * @param commandMap
	 * @param multipartFile
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterSkinSave.do")
	public String letterSkinSave(ModelMap model, @RequestParam Map<String, Object> commandMap,
			@RequestParam(value = "letter_skin_file_org_nm", required = false) MultipartFile multipartFile,
			HttpServletRequest request) throws Exception {
		commandMap.put("create_id", SessionUtil.getAdminId());
		String letterSkinId = letterService.saveLetterSkin(commandMap, multipartFile, request);
		return "redirect:/mailbox/letterSkinUpdateForm.do?letter_skin_id=" + letterSkinId;
	}

	/**
	 * 편지지 스킨 수정
	 * 
	 * @param model
	 * @param commandMap
	 * @param multipartFile
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterSkinUpdate.do")
	public String letterSkinUpdate(ModelMap model, @RequestParam Map<String, Object> commandMap,
			@RequestParam(value = "letter_skin_file_org_nm", required = false) MultipartFile multipartFile,
			HttpServletRequest request) throws Exception {
		commandMap.put("create_id", SessionUtil.getAdminId());
		letterService.updateLetterSkin(commandMap, multipartFile, request);
		return "redirect:/mailbox/letterSkinUpdateForm.do?letter_skin_id=" + commandMap.get("letter_skin_id");
	}

	/**
	 * 편지지 스킨 수정 > 저장
	 * 
	 * @param model
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterSkinUpdateForm.do")
	public String letterSkinUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception {
		List<Map<String, Object>> letterSkinList = letterService.selectLetterSkinList(commandMap);
		if (letterSkinList.size() != 1) {
		}
		Map<String, Object> letterSkin = letterSkinList.get(0);
		model.addAttribute("letterSkin", letterSkin);
		return "letter/update/letterSkinUpdateForm";
	}

	/**
	 * 편지지 스킨 삭제
	 * 
	 * @param model
	 * @param commandMap
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailbox/letterSkinDelete.do")
	public String letterSkinDelete(ModelMap model, @RequestParam Map<String, Object> commandMap,
			HttpServletResponse response) throws Exception {
		letterService.deleteLetterSkin(commandMap);
		return "redirect:/mailbox/letterSkinList.do";
	}
	
	//----------------------------------------------------------------------------------------------
	//----------- 통계 
	// ---------------------------------------------------------------------------------------
	
	@RequestMapping(value = "/mailbox/letterStatistics.do")
	public String letterStatistic(ModelMap model, @RequestParam Map<String, Object> commandMap, HttpServletResponse response) throws Exception {
		// 선택된 탭이 없으면 그냥 화면만 보여주도록 한다.
		if(commandMap.get("typeTabSelected") != null) {
			List<Map<String, Object>> letterStatisticList = letterService.selectLetterStatisticList(commandMap);
			model.addAttribute("list", letterStatisticList);
		}
		model.addAttribute("minYear", letterService.selectCreateLetterMinYearLetter());
		model.addAttribute("param", commandMap);
		return "letter/letterStatistics";
	}
	
	@RequestMapping("/mailbox/exportExcelLetterStatisticsList.do")
	public void exportExcelLetterStatisticsList(ModelMap model, @RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		letterService.exporLetterStatisticList(response, commandMap);
	}

}
