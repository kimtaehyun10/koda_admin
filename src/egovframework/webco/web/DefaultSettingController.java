package egovframework.webco.web;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.webco.service.AdminService;
import egovframework.webco.service.DefaultSettingService;
import egovframework.webco.service.RespectService;
import egovframework.webco.service.StatisticsService;
import egovframework.webco.service.WebcoService;
import egovframework.webco.util.CommonUtil;
import egovframework.webco.util.EnumValue;
import egovframework.webco.util.SessionUtil;
import egovframework.webco.vo.AdminVO;
import net.sf.json.JSONObject;

@Controller
public class DefaultSettingController {

    /** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());

    @Resource(name = "webcoService")
    private WebcoService webcoService;  
    
    @Resource(name = "defaultSettingService")
    private DefaultSettingService defaultSettingService;  
    
    @Resource(name = "adminService")
    private AdminService adminService;
    
    private String menuId = "user";
	
	//팝업관리
	@RequestMapping("/defaultSetting/popup.do")
	public String popup(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	List<Map<String, Object>> popupList = defaultSettingService.popupList(commandMap);
    	int total_count = defaultSettingService.popupListTotCnt(commandMap);
    	
    	model.addAttribute("popupList_list", popupList);
    	model.addAttribute("total_count", total_count);
    	model.addAttribute("currentPage",page); //현재 페이지 번호
    	
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	paginationInfo.setCurrentPageNo(page);
    	paginationInfo.setRecordCountPerPage(limit);    	
    	paginationInfo.setPageSize(10);    	
    	if(paginationInfo != null){ 
    		paginationInfo.setTotalRecordCount(total_count); 
    		model.addAttribute("paginationInfo", paginationInfo); 
    	}    	    	
    	
    	AdminVO adminVO = SessionUtil.getAuthenticatedUser();    	
    	model.addAttribute("admin_grade", adminVO.getAdmin_grade());
    	model.addAttribute("param", commandMap);
    	model.addAttribute("displayNum",paginationInfo.getPageSize()); //페이지당 게시물 출력 수
    	
    	adminService.insertActHist("L", "[팝업관리]목록 조회");
		return "defaultSetting/popup";	 	
	}
	
	//배너관리
	@RequestMapping("/defaultSetting/banner.do")
	public String banner(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	List<Map<String, Object>> bannerList = defaultSettingService.bannerList(commandMap);
    	int total_count = defaultSettingService.bannerListTotCnt(commandMap);
    	
    	model.addAttribute("bannerList_list", bannerList);
    	model.addAttribute("total_count", total_count);
    	model.addAttribute("currentPage",page); //현재 페이지 번호
    	
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	paginationInfo.setCurrentPageNo(page);
    	paginationInfo.setRecordCountPerPage(limit);    	
    	paginationInfo.setPageSize(10);    	
    	if(paginationInfo != null){ 
    		paginationInfo.setTotalRecordCount(total_count); 
    		model.addAttribute("paginationInfo", paginationInfo); 
    	}    	    	
    	
    	AdminVO adminVO = SessionUtil.getAuthenticatedUser();    	
    	model.addAttribute("admin_grade", adminVO.getAdmin_grade());
    	model.addAttribute("param", commandMap);
    	model.addAttribute("displayNum",paginationInfo.getPageSize()); //페이지당 게시물 출력 수
    	
    	adminService.insertActHist("L", "[배너관리]목록 조회");
		return "defaultSetting/banner";	 	
	}

	// 팝업관리 수정 form
	@RequestMapping("/defaultSetting/popupUpdateForm.do")
	public String popupUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		Map<String, Object> selectedPopup = defaultSettingService.selectedPopup(commandMap);
		model.addAttribute("selectedPopup",selectedPopup);
		model.addAttribute("param",commandMap);
		
    	adminService.insertActHist("R", "[팝업관리]수정 조회");
		
    	return "defaultSetting/update/popupUpdateForm";	 	
	}

	// 팝업관리 수정 end
	@RequestMapping("/defaultSetting/popupUpdateEnd.do")
	@ResponseBody
	public String popupUpdateEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		defaultSettingService.popupUpdateEnd(commandMap);		
		String msg="수정완료";
    	adminService.insertActHist("U", "[팝업관리]수정 완료");
		
    	return msg;	 	
	}

	// 팝업관리 삭제 end
	@RequestMapping("/defaultSetting/popupDeleteEnd.do")
	@ResponseBody
	public String popupDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		defaultSettingService.popupDeleteEnd(commandMap);		
		String msg="삭제완료";
    	adminService.insertActHist("D", "[팝업관리]삭제 완료");
		
    	return msg;	 	
	}

	// 팝업관리 등록 form
	@RequestMapping("/defaultSetting/popupWriteForm.do")
	public String popupWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{				
		
    	adminService.insertActHist("R", "[팝업관리]등록 조회");
		
    	return "defaultSetting/write/popupWriteForm";	 	
	}

	// 팝업관리 등록 end
	@RequestMapping("/defaultSetting/popupWriteEnd.do")
	@ResponseBody
	public String popupWriteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int ecm_seq = defaultSettingService.popupEcmSeq();
		commandMap.put("ecm_seq", ecm_seq+1);
		defaultSettingService.popupWriteEnd(commandMap);		
		String msg="등록완료";
    	adminService.insertActHist("C", "[팝업관리]등록 완료");
		
    	return msg;	 	
	}

	// 배너관리 수정 form
	@RequestMapping("/defaultSetting/bannerUpdateForm.p")
	public String bannerUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		Map<String, Object> selectedBanner = defaultSettingService.selectedBanner(commandMap);
		model.addAttribute("selectedBanner",selectedBanner);
		model.addAttribute("param",commandMap);
		
    	adminService.insertActHist("R", "[배너관리]수정 조회");
		
    	return "defaultSetting/update/bannerUpdateForm";	 	
	}
	
	// 배너관리 수정 end
	@RequestMapping("/defaultSetting/bannerUpdateEnd.do")
	@ResponseBody
	public String bannerUpdateEnd(ModelMap model, @RequestParam Map<String, Object> commandMap, @RequestParam("banner_org_img") MultipartFile multipartFile) throws Exception{
		
    	String msg = "";
		int banner_idx = 0;
		try {
			// 파일 정보
			String originFilename = multipartFile.getOriginalFilename();
			
			if(!"".equals(originFilename) && originFilename!=null){
				String extName
				= originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			Long size = multipartFile.getSize();
			
			// 서버에서 저장 할 파일 이름
			String saveFileName = genSaveFileName(extName);
			
			commandMap.put("banner_org_img", originFilename);
			commandMap.put("banner_img", saveFileName);
			
			writeFile(multipartFile, saveFileName);
									
			}
			
			if("banner_update".equals(commandMap.get("type"))){
				//banner 테이블 수정
				defaultSettingService.bannerUpdateEnd(commandMap);
				msg = "수정 완료";
			}else if("banner_insert".equals(commandMap.get("type"))){
				//banner 테이블 insert				
				banner_idx = defaultSettingService.bannerEndIdx(commandMap); // 해당 테이블 마지막 idx
				commandMap.put("banner_idx", banner_idx+1);				
				defaultSettingService.bannerWriteEnd(commandMap);
				
				msg = "등록 완료";
			}
		}
		catch (IOException e) {
			
			throw new RuntimeException(e);
		}
		
		return msg+","+(banner_idx+1);
	}
	
	// 현재 시간을 기준으로 파일 이름 생성
    private String genSaveFileName(String extName) {
		String fileName = "";
		
		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);
		fileName += extName;
		
		return fileName;
	}
    
    // 파일을 실제로 write 하는 메서드
 	private boolean writeFile(MultipartFile multipartFile, String saveFileName)throws IOException{
 		boolean result = false;

 		byte[] data = multipartFile.getBytes();
 		FileOutputStream fos = new FileOutputStream("C:/work/koda/workspace/koda_admin/WebContent/upFile" + "/" + saveFileName);
 		fos.write(data);
 		fos.close();
 		
 		return result;
 	}

 	// 배너관리 삭제 end
 	@RequestMapping("/defaultSetting/bannerDeleteEnd.do")
	@ResponseBody
	public String bannerDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		defaultSettingService.bannerDeleteEnd(commandMap);		
		String msg="삭제완료";
    	adminService.insertActHist("D", "[배너관리]삭제 완료");
		
    	return msg;	 	
	}

 	// 배너관리 등록 form
 	@RequestMapping("/defaultSetting/bannerWriteForm.p")
	public String bannerWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	adminService.insertActHist("R", "[배너관리]등록 조회");
		
    	return "defaultSetting/write/bannerWriteForm";	 	
	}

 	// 게시판관리
 	@RequestMapping("/defaultSetting/boardManage.do")
	public String boardManage(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);    	
    	
    	List<Map<String, Object>> boardManageList = defaultSettingService.boardManageList(commandMap);
    	int total_count = defaultSettingService.boardManageListTotalCnt(commandMap);
    	
    	model.addAttribute("boardManageList_list", boardManageList);
    	model.addAttribute("total_count", total_count);
    	model.addAttribute("currentPage",page); //현재 페이지 번호
    	
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	paginationInfo.setCurrentPageNo(page);
    	paginationInfo.setRecordCountPerPage(limit);    	
    	paginationInfo.setPageSize(10);    	
    	if(paginationInfo != null){ 
    		paginationInfo.setTotalRecordCount(total_count); 
    		model.addAttribute("paginationInfo", paginationInfo); 
    	}    	    	
    	
    	AdminVO adminVO = SessionUtil.getAuthenticatedUser();    	
    	model.addAttribute("admin_grade", adminVO.getAdmin_grade());
    	model.addAttribute("param", commandMap);
    	model.addAttribute("displayNum",paginationInfo.getPageSize()); //페이지당 게시물 출력 수
    	
    	adminService.insertActHist("L", "[팝업관리]목록 조회");
		return "defaultSetting/boardManage";	 	
	}

 	// 게시판 관리 덧글 허용/비허용
 	@RequestMapping("/defaultSetting/boardManageCommentYN.do")
	@ResponseBody
	public String boardManageCommentYN(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		defaultSettingService.boardManageCommentYN(commandMap);
		
		String msg = "";
		if("Y".equals(commandMap.get("brd_comment_yn"))){
			msg="덧글허용";
		}else if("N".equals(commandMap.get("brd_comment_yn"))){
			msg="덧글비허용";
		}
		
    	adminService.insertActHist("U", "[게시판관리 덧글]수정 완료");
		
    	return msg;	 	
	}

 	//접속자집계
 	@RequestMapping("/defaultSetting/visitCount.do")
	public String visitCount(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
 		if("".equals(commandMap.get("search_year")) || commandMap.get("search_year") == null){
 			//현재년도 구하기
 			Calendar cal = Calendar.getInstance();
 			int year = cal.get(Calendar.YEAR);
 			
 			commandMap.put("search_year", year);
 		}
 		
 		List<Map<String, Object>> visitCountList = defaultSettingService.visitCountList(commandMap); 
 		
 		//총 합계
 		int totalSum = 0;
 		//총 접속자수
 		for(int i=0;i<visitCountList.size();i++){
 			totalSum += Integer.parseInt(String.valueOf(visitCountList.get(i).get("sum")));
 		}
 		
 		model.addAttribute("visitCountList",visitCountList);
 		model.addAttribute("year",commandMap.get("search_year"));
 		model.addAttribute("totalSum",totalSum);
 		
    	adminService.insertActHist("R", "[접속자집계]목록 조회");
		
    	return "defaultSetting/visitCount";	 	
	}

 	//인기검색어
 	@RequestMapping("/defaultSetting/searchKeyword.do")
	public String searchKeyword(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	List<Map<String, Object>> searchKeywordList = defaultSettingService.searchKeywordList(commandMap);
    	int total_count = defaultSettingService.searchKeywordListTotCnt(commandMap);
    	
    	model.addAttribute("searchKeywordList_list", searchKeywordList);
    	model.addAttribute("total_count", total_count);
    	model.addAttribute("currentPage",page); //현재 페이지 번호
    	
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	paginationInfo.setCurrentPageNo(page);
    	paginationInfo.setRecordCountPerPage(limit);    	
    	paginationInfo.setPageSize(10);    	
    	if(paginationInfo != null){ 
    		paginationInfo.setTotalRecordCount(total_count); 
    		model.addAttribute("paginationInfo", paginationInfo); 
    	}    	    	
    	
    	AdminVO adminVO = SessionUtil.getAuthenticatedUser();    	
    	model.addAttribute("admin_grade", adminVO.getAdmin_grade());
    	model.addAttribute("param", commandMap);
    	model.addAttribute("displayNum",paginationInfo.getPageSize()); //페이지당 게시물 출력 수
    	
    	adminService.insertActHist("R", "[인기검색어]목록 조회");
		return "defaultSetting/searchKeyword";	 	
	}

 	// 문자발송
 	@RequestMapping("/defaultSetting/basicMessage.do")
	public String basicMessage(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{				
    	
 		List<Map<String, Object>> smsFormList = webcoService.list_map("SmsFormDAO.selectList", commandMap);			
    	EnumValue enumValue = new EnumValue();    	
    	model.addAttribute("enum_array", CommonUtil.getObjectToJSONObject(enumValue.getEnumArray()));
        model.addAttribute("sms_form_list",     CommonUtil.getJsonArrayFromList(smsFormList));
        model.addAttribute("data_get",     CommonUtil.getObjectToJSONObject(commandMap));
        model.addAttribute("menu",     menuId);
 		
    	adminService.insertActHist("R", "[문자발송]목록 조회");
		return "defaultSetting/basicMessage";	 	
	}
}

        