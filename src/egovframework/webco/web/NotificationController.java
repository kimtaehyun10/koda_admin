package egovframework.webco.web;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.webco.service.AdminService;
import egovframework.webco.service.NotificationService;
import egovframework.webco.service.RemembranceService;
import egovframework.webco.service.RespectService;
import egovframework.webco.service.StatisticsService;
import egovframework.webco.service.WebcoService;
import egovframework.webco.util.CommonUtil;
import egovframework.webco.util.EnumValue;
import egovframework.webco.util.SessionUtil;
import egovframework.webco.vo.AdminVO;
import net.sf.json.JSONObject;

@Controller
public class NotificationController {

    /** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());

    @Resource(name = "webcoService")
    private WebcoService webcoService;  
    
    @Resource(name = "notificationService")
    private NotificationService notificationService;
    
    @Resource(name = "adminService")
    private AdminService adminService;
    
    @Resource(name = "remembranceService")
    private RemembranceService remembranceService;
	
    @Resource(name = "statisticsService")
    private StatisticsService statisticsService; 
    
    private String fileStorePath = EgovProperties.getProperty("globals.fileStorePath");
    
	//영상 자료실
	@RequestMapping("/notification/movie.do")
	public String movie(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	commandMap.put("brd_no", "9"); //동영상 구분
    	
    	List<Map<String, Object>> ntcList = notificationService.notificationList(commandMap);
    	int total_count = notificationService.notificationListTotCnt(commandMap);
    	
    	
    	
    	model.addAttribute("ntcList_list", ntcList);
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
    	
    	adminService.insertActHist("L", "[동영상]목록 조회");
    	
		return "notification/movie";	 	
	}
	
	//연보 및 간행물
	@RequestMapping("/notification/annual.do")
	public String annual(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	commandMap.put("brd_no", "24"); //연보 및 간행물 구분
    	
    	
    	List<Map<String, Object>> ntcList = notificationService.notificationList(commandMap);
    	int total_count = notificationService.notificationListTotCnt(commandMap);
    	
    	
    	
    	model.addAttribute("ntcList_list", ntcList);
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
    	
    	adminService.insertActHist("L", "[연보 및 간행물]목록 조회");
    	
		return "notification/annual";	 	
	}

	//뉴스레터
	@RequestMapping("/notification/newsLetter.do")
	public String newsLetter(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	commandMap.put("brd_no", "23"); //뉴스레터 구분
    	
    	
    	List<Map<String, Object>> ntcList = notificationService.notificationList(commandMap);
    	int total_count = notificationService.notificationListTotCnt(commandMap);
    	
    	
    	
    	model.addAttribute("ntcList_list", ntcList);
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
    	
    	adminService.insertActHist("L", "[뉴스레터]목록 조회");
    	
		return "notification/newsLetter";	 	
	}

	//홍보물
	@RequestMapping("/notification/publication.do")
	public String publication(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	commandMap.put("brd_no", "22"); //홍보물 구분
    	commandMap.put("brd_file_seq", "1"); //메인이미지 seq
    	
    	List<Map<String, Object>> ntcList = notificationService.notificationList(commandMap);
    	int total_count = notificationService.notificationListTotCnt(commandMap);
    	
    	commandMap.put("brd_file_seq", "2"); //첨부파일 seq
    	List<Map<String, Object>> fileList = notificationService.notificationList(commandMap);
    	model.addAttribute("fileList_list", fileList);
    	
    	model.addAttribute("ntcList_list", ntcList);
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
    	
    	adminService.insertActHist("L", "[홍보물]목록 조회");
    	
		return "notification/publication";	 	
	}

	//웹 콘텐츠
	@RequestMapping("/notification/webContents.do")
	public String webContents(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	commandMap.put("brd_no", "36"); //웹콘텐츠 구분
    	commandMap.put("brd_file_seq", "1"); //메인이미지 seq
    	
    	List<Map<String, Object>> ntcList = notificationService.notificationList(commandMap);
    	int total_count = notificationService.notificationListTotCnt(commandMap);
    	
    	commandMap.put("brd_file_seq", "2"); //첨부파일 seq
    	List<Map<String, Object>> fileList = notificationService.notificationList(commandMap);
    	model.addAttribute("fileList_list", fileList);
    	
    	model.addAttribute("ntcList_list", ntcList);
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
    	
    	adminService.insertActHist("L", "[웹 콘텐츠]목록 조회");
    	
		return "notification/webContents";	 	
	}

	//기관일정
	@RequestMapping("/notification/organSchedule.do")
	public String organSchedule(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	
    	List<Map<String, Object>> osdList = notificationService.organScheduleList(commandMap);
    	int total_count = notificationService.organScheduleListTotCnt(commandMap);
    	
    	
    	
    	model.addAttribute("osdList_list", osdList);
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
    	
    	adminService.insertActHist("L", "[기관일정]목록 조회");
    	
		return "notification/organSchedule";	 	
	}

	//기관행사
	@RequestMapping("/notification/organEvent.do")
	public String organEvent(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	commandMap.put("brd_no", "20"); //기관행사 구분
    	commandMap.put("brd_file_seq", "1"); //메인이미지 seq
    	
    	List<Map<String, Object>> ntcList = notificationService.notificationList(commandMap);
    	int total_count = notificationService.notificationListTotCnt(commandMap);
    	
    	commandMap.put("brd_file_seq", "2"); //첨부파일 seq
    	List<Map<String, Object>> fileList = notificationService.notificationList(commandMap);
    	model.addAttribute("fileList_list", fileList);
    	
    	model.addAttribute("ntcList_list", ntcList);
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
    	
    	adminService.insertActHist("L", "[기관행사]목록 조회");
    	
		return "notification/organEvent";	 	
	}

	//보도자료
	@RequestMapping("/notification/pressRelease.do")
	public String pressRelease(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	commandMap.put("brd_no", "31"); //기관행사 구분
    	
    	
    	List<Map<String, Object>> ntcList = notificationService.notificationList(commandMap);
    	int total_count = notificationService.notificationListTotCnt(commandMap);    	
    	
    	model.addAttribute("ntcList_list", ntcList);
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
    	
    	adminService.insertActHist("L", "[보도자료]목록 조회");
    	
		return "notification/pressRelease";	 	
	}

	//생명나눔 스토리
	@RequestMapping("/notification/lifeSharing.do")
	public String lifeSharing(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	commandMap.put("brd_no", "30"); //기관행사 구분
    	commandMap.put("brd_file_seq", "1"); //메인이미지 seq
    	
    	List<Map<String, Object>> ntcList = notificationService.notificationList(commandMap);
    	int total_count = notificationService.notificationListTotCnt(commandMap);
    	
    	commandMap.put("brd_file_seq", "2"); //첨부파일 seq
    	List<Map<String, Object>> fileList = notificationService.notificationList(commandMap);
    	model.addAttribute("fileList_list", fileList);
    	
    	model.addAttribute("ntcList_list", ntcList);
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
    	
    	adminService.insertActHist("L", "[생명나눔 스토리]목록 조회");
    	
		return "notification/lifeSharing";	 	
	}

	//자유게시판
	@RequestMapping("/notification/free.do")
	public String free(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	commandMap.put("story_gubun", "free"); //자유게시판 구분
    	
    	
    	List<Map<String, Object>> letterStoryList = remembranceService.letterStoryList(commandMap);
    	int total_count = remembranceService.letterStoryListTotCnt(commandMap);
    	
    	
    	model.addAttribute("letterStoryList_list", letterStoryList);
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
    	
    	adminService.insertActHist("L", "[자유게시판]목록 조회");
		return "notification/free";	 	
	}

	//공지사항
	@RequestMapping("/notification/notice.do")
	public String notice(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	commandMap.put("brd_no", "7"); //공지사항 구분
    	
    	
    	List<Map<String, Object>> ntcList = notificationService.notificationList(commandMap);
    	int total_count = notificationService.notificationListTotCnt(commandMap);
    	
    	model.addAttribute("ntcList_list", ntcList);
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
    	
    	adminService.insertActHist("L", "[공지사항]목록 조회");
    	
		return "notification/notice";	 	
	}

	//영상 자료실 수정 form
	@RequestMapping("/notification/movieUpdateForm.do")
	public String movieUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		Map<String, Object> selectedBoard = statisticsService.selectedBoard(commandMap);
		model.addAttribute("selectedBoard",selectedBoard);
		
    	adminService.insertActHist("L", "[영상 자료실]수정 조회");
		
    	return "notification/update/movieUpdateForm";	 	
	}

	// brd_contents 수정 end
	@RequestMapping("/notification/contentsUpdateEnd.do")
	public String contentsUpdateEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{

		notificationService.contentsUpdateEnd(commandMap);
		
		if("makePublic".equals(commandMap.get("type"))){
			return "redirect:/infoOpen/makePublic.do";
		}else if("openData".equals(commandMap.get("type"))){
			return "redirect:/infoOpen/openData.do";
		}else if("law".equals(commandMap.get("type"))){
			return "redirect:/infoOpen/law.do";
		}else if("academic".equals(commandMap.get("type"))){
			return "redirect:/infoOpen/academic.do";
		}else{
			return "redirect:/notification/"+commandMap.get("type")+".do";
		}
		
    		 	
	}
   
	// 영상 자료실 삭제 end
	@RequestMapping("/notification/movieDeleteEnd.do")
	@ResponseBody
	public String movieDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.boardDeleteEnd(commandMap); //board_cont 삭제
		statisticsService.boardFileDeleteEnd(commandMap); //board_file 삭제
		String msg = "삭제 완료";
		adminService.insertActHist("L", "[영상 자료실]삭제 완료");
		
    	return msg;	 	
	}

	// 영상 자료실 등록 form
	@RequestMapping("/notification/movieWriteForm.do")
	public String movieWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	adminService.insertActHist("L", "[영상 자료실]등록 조회");
		
    	return "notification/write/movieWriteForm";	 	
	}

	// 연보 및 간행물 수정 form
	@RequestMapping("/notification/annualUpdateForm.p")
	public String annualUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		Map<String, Object> selectedBoard = statisticsService.selectedBoard(commandMap);
		model.addAttribute("selectedBoard",selectedBoard);
		
    	adminService.insertActHist("L", "[연보 및 간행물]수정 조회");
		
    	return "notification/update/annualUpdateForm";	 	
	}

	// 연보 및 간행물 삭제 end
	@RequestMapping("/notification/annualDeleteEnd.do")
	@ResponseBody
	public String annualDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.boardDeleteEnd(commandMap); //board_cont 삭제
		statisticsService.boardFileDeleteEnd(commandMap); //board_file 삭제
		String msg = "삭제 완료";
		adminService.insertActHist("L", "[연보 및 간행물]삭제 완료");
		
    	return msg;	 	
	}

	// 연보 및 간행물 등록 form
	@RequestMapping("/notification/annualWriteForm.p")
	public String annualWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	adminService.insertActHist("L", "[연보 및 간행물]등록 조회");
		
    	return "notification/write/annualWriteForm";	 	
	}

	// 뉴스레터 수정 form
	@RequestMapping("/notification/newsLetterUpdateForm.p")
	public String newsLetterUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		Map<String, Object> selectedBoard = statisticsService.selectedBoard(commandMap);
		model.addAttribute("selectedBoard",selectedBoard);
		
    	adminService.insertActHist("L", "[뉴스레터]수정 조회");
		
    	return "notification/update/newsLetterUpdateForm";	 	
	}

	// 뉴스레터 삭제 end
	@RequestMapping("/notification/newsLetterDeleteEnd.do")
	@ResponseBody
	public String newsLetterDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.boardDeleteEnd(commandMap); //board_cont 삭제
		statisticsService.boardFileDeleteEnd(commandMap); //board_file 삭제
		String msg = "삭제 완료";
		adminService.insertActHist("L", "[뉴스레터]삭제 완료");
		
    	return msg;	 	
	}

	// 뉴스레터 등록 form
	@RequestMapping("/notification/newsLetterWriteForm.p")
	public String newsLetterWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	adminService.insertActHist("L", "[뉴스레터]등록 조회");
		
    	return "notification/write/newsLetterWriteForm";	 	
	}

	// 홍보물 수정 form
	@RequestMapping("/notification/publicationUpdateForm.do")
	public String publicationUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		commandMap.put("brd_file_seq", "1"); //메인이미지 번호
		Map<String, Object> selectedBoard = statisticsService.selectedBoard(commandMap);
		model.addAttribute("selectedBoard",selectedBoard);
		
		commandMap.put("brd_file_seq", "2"); //첨부파일 번호
		Map<String, Object> selectedBoardFile = statisticsService.selectedBoard(commandMap);
		model.addAttribute("selectedBoardFile",selectedBoardFile);
		
    	adminService.insertActHist("L", "[홍보물]수정 조회");
		
    	return "notification/update/publicationUpdateForm";	 	
	}

	// 홍보물 삭제 end
	@RequestMapping("/notification/publicationDeleteEnd.do")
	@ResponseBody
	public String publicationDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.boardDeleteEnd(commandMap); //board_cont 삭제
		statisticsService.boardFileDeleteEnd(commandMap); //board_file 삭제
		String msg = "삭제 완료";
		adminService.insertActHist("L", "[홍보물]삭제 완료");
		
    	return msg;	 	
	}

	// 홍보물 등록 form
	@RequestMapping("/notification/publicationWriteForm.do")
	public String publicationWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	adminService.insertActHist("L", "[홍보물]등록 조회");
		
    	return "notification/write/publicationWriteForm";	 	
	}

	// 웹 콘텐츠 수정 form
	@RequestMapping("/notification/webContentsUpdateForm.do")
	public String webContentsUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		commandMap.put("brd_file_seq", "1"); //메인이미지 번호
		Map<String, Object> selectedBoard = statisticsService.selectedBoard(commandMap);
		model.addAttribute("selectedBoard",selectedBoard);
		
		commandMap.put("brd_file_seq", "2"); //첨부파일 번호
		Map<String, Object> selectedBoardFile = statisticsService.selectedBoard(commandMap);
		model.addAttribute("selectedBoardFile",selectedBoardFile);
		
    	adminService.insertActHist("L", "[웹 콘텐츠]수정 조회");
		
    	return "notification/update/webContentsUpdateForm";	 	
	}

	// 웹 콘텐츠 삭제 end
	@RequestMapping("/notification/webContentsDeleteEnd.do")
	@ResponseBody
	public String webContentsDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.boardDeleteEnd(commandMap); //board_cont 삭제
		statisticsService.boardFileDeleteEnd(commandMap); //board_file 삭제
		String msg = "삭제 완료";
		adminService.insertActHist("L", "[웹 콘텐츠]삭제 완료");
		
    	return msg;	 	
	}
	
	// 웹 콘텐츠 등록 form
	@RequestMapping("/notification/webContentsWriteForm.do")
	public String webContentsWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	adminService.insertActHist("L", "[웹 콘텐츠]등록 조회");
		
    	return "notification/write/webContentsWriteForm";	 	
	}

	// 기관일정 수정 form
	@RequestMapping("/notification/organScheduleUpdateForm.do")
	public String organScheduleUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		
		Map<String, Object> selectedOrganSchedule = notificationService.selectedOrganSchedule(commandMap);
		model.addAttribute("selectedOrganSchedule",selectedOrganSchedule);
		
    	adminService.insertActHist("L", "[기관일정]수정 조회");
		
    	return "notification/update/organScheduleUpdateForm";	 	
	}

	// 관련글 찾기 popup(기관행사)
	@RequestMapping("/notification/organEventPopup.p")
	public String organEventPopup(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	commandMap.put("brd_no", "20"); //기관행사 구분
    	commandMap.put("brd_file_seq", "1"); //메인이미지 seq
    	
    	List<Map<String, Object>> ntcList = notificationService.notificationList(commandMap);
    	int total_count = notificationService.notificationListTotCnt(commandMap);
    	
    	model.addAttribute("ntcList_list", ntcList);
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
		
    	return "notification/popup/organEventPopup";	 	
	}

	// 기관일정 수정 end
	@RequestMapping("/notification/organScheduleUpdateEnd.do")
	@ResponseBody
	public String organScheduleUpdateEnd(ModelMap model, @RequestParam Map<String, Object> commandMap, @RequestParam("sch_file_org_name") MultipartFile multipartFile, HttpServletRequest request) throws Exception{
		
    	String msg = "";
		int endIdx = 0;
		try {
			// 파일 정보
			String originFilename = multipartFile.getOriginalFilename();
			
			if(!"".equals(originFilename) && originFilename!=null){
				String extName
				= originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			Long size = multipartFile.getSize();
			
			// 서버에서 저장 할 파일 이름
			String saveFileName = genSaveFileName(extName);
			
			commandMap.put("sch_file_org_name", originFilename);
			commandMap.put("sch_file_name", saveFileName);
			
			writeFile(multipartFile, saveFileName, request);
									
			}
			
			if("sch_update".equals(commandMap.get("type"))){
				//schedule 테이블 수정
				notificationService.organScheduleUpdateEnd(commandMap);
				msg = "수정 완료";
			}else if("sch_insert".equals(commandMap.get("type"))){
				//schedule 테이블 insert
				endIdx = notificationService.scheduleEndIdx();				
				commandMap.put("sch_no", endIdx+1);				
				notificationService.organScheduleInsertEnd(commandMap);
				msg = "등록 완료";
			}
		}
		catch (IOException e) {
			
			throw new RuntimeException(e);
		}
		
		return msg+","+(endIdx+1);
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

 	// schedule contents 수정 end
 	@RequestMapping("/notification/scheduleContentsUpdateEnd.do")
	public String scheduleContentsUpdateEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{

		notificationService.scheduleContentsUpdateEnd(commandMap);
		
    	return "redirect:/notification/organSchedule.do";	 	
	}

 	// 기관일정 삭제 end
 	@RequestMapping("/notification/organScheduleDeleteEnd.do")
	@ResponseBody
	public String organScheduleDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
 		notificationService.organScheduleDeleteEnd(commandMap);
		
		String msg = "삭제 완료";
		adminService.insertActHist("L", "[기관일정]삭제 완료");
		
    	return msg;	 	
	}

 	// 기관일정 등록 form
 	@RequestMapping("/notification/organScheduleWriteForm.do")
	public String organScheduleWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	adminService.insertActHist("L", "[기관일정]등록 조회");
		
    	return "notification/write/organScheduleWriteForm";	 	
	}

 	// 기관행사 수정 form
 	@RequestMapping("/notification/organEventUpdateForm.do")
	public String organEventUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
				
 		commandMap.put("brd_file_seq", "1"); //메인이미지 번호
		Map<String, Object> selectedBoard = statisticsService.selectedBoard(commandMap);
		model.addAttribute("selectedBoard",selectedBoard);
		
		commandMap.put("brd_file_seq", "2"); //첨부파일 번호
		Map<String, Object> selectedBoardFile = statisticsService.selectedBoard(commandMap);
		model.addAttribute("selectedBoardFile",selectedBoardFile);
		
    	adminService.insertActHist("L", "[기관행사]수정 조회");
		
    	return "notification/update/organEventUpdateForm";	 	
	}

 	// 기관행사 삭제 end
 	@RequestMapping("/notification/organEventDeleteEnd.do")
	@ResponseBody
	public String organEventDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.boardDeleteEnd(commandMap); //board_cont 삭제
		statisticsService.boardFileDeleteEnd(commandMap); //board_file 삭제
		String msg = "삭제 완료";
		adminService.insertActHist("L", "[기관행사]삭제 완료");
		
    	return msg;	 	
	}

 	// 기관행사 등록 form
 	@RequestMapping("/notification/organEventWriteForm.do")
	public String organEventWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	adminService.insertActHist("L", "[기관행사]등록 조회");
		
    	return "notification/write/organEventWriteForm";	 	
	}

 	// 보도자료 수정 form
 	@RequestMapping("/notification/pressReleaseUpdateForm.do")
	public String pressReleaseUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		Map<String, Object> selectedBoard = statisticsService.selectedBoard(commandMap);
		model.addAttribute("selectedBoard",selectedBoard);
		
    	adminService.insertActHist("L", "[보도자료]수정 조회");
		
    	return "notification/update/pressReleaseUpdateForm";	 	
	}

 	// 보도자료 삭제 end
 	@RequestMapping("/notification/pressReleaseDeleteEnd.do")
	@ResponseBody
	public String pressReleaseDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.boardDeleteEnd(commandMap); //board_cont 삭제
		statisticsService.boardFileDeleteEnd(commandMap); //board_file 삭제
		String msg = "삭제 완료";
		adminService.insertActHist("L", "[보도자료]삭제 완료");
		
    	return msg;	 	
	}

 	// 보도자료 등록 form
 	@RequestMapping("/notification/pressReleaseWriteForm.do")
	public String pressReleaseWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	adminService.insertActHist("L", "[보도자료]등록 조회");
		
    	return "notification/write/pressReleaseWriteForm";	 	
	}

 	// 생명나눔 스토리 수정 form
 	@RequestMapping("/notification/lifeSharingUpdateForm.do")
	public String lifeSharingUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		commandMap.put("brd_file_seq", "1"); //메인이미지 번호
		Map<String, Object> selectedBoard = statisticsService.selectedBoard(commandMap);
		model.addAttribute("selectedBoard",selectedBoard);
		
		commandMap.put("brd_file_seq", "2"); //첨부파일 번호
		Map<String, Object> selectedBoardFile = statisticsService.selectedBoard(commandMap);
		model.addAttribute("selectedBoardFile",selectedBoardFile);
		
    	adminService.insertActHist("L", "[생명나눔 스토리]수정 조회");
		
    	return "notification/update/lifeSharingUpdateForm";	 	
	}

 	// 생명나눔 스토리 삭제 end
 	@RequestMapping("/notification/lifeSharingDeleteEnd.do")
	@ResponseBody
	public String lifeSharingDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.boardDeleteEnd(commandMap); //board_cont 삭제
		statisticsService.boardFileDeleteEnd(commandMap); //board_file 삭제
		String msg = "삭제 완료";
		adminService.insertActHist("D", "[생명나눔 스토리]삭제 완료");
		
    	return msg;	 	
	}

 	// 생명나눔 스토리 등록 form
 	@RequestMapping("/notification/lifeSharingWriteForm.do")
	public String lifeSharingWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	adminService.insertActHist("R", "[웹 콘텐츠]등록 조회");
		
    	return "notification/write/lifeSharingWriteForm";	 	
	}

 	// 자유게시판 수정 form
 	@RequestMapping("/notification/freeUpdateForm.do")
	public String freeUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	Map<String, Object> selectedLetterStory= remembranceService.selectedLetterStory(commandMap);
    	model.addAttribute("selectedLetterStory", selectedLetterStory);
    	model.addAttribute("param",commandMap);
    	
    	//댓글
    	commandMap.put("story_gubun", "free"); //자유게시판 댓글 구분
    	List<Map<String, Object>> letterStoryComment = remembranceService.letterStoryComment(commandMap);
    	model.addAttribute("letterStoryComment", letterStoryComment);
    	
    	adminService.insertActHist("R", "[자유게시판]수정 조회");
	
    	return "notification/update/freeUpdateForm";	 	
	}

 	// 자유게시판 등록 form
 	@RequestMapping("/notification/freeWriteForm.do")
	public String freeWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	adminService.insertActHist("R", "[자유게시판]등록 조회");
		
    	return "notification/write/freeWriteForm";	 	
	}

 	// 공지사항 수정 form
 	@RequestMapping("/notification/noticeUpdateForm.do")
	public String noticeUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		Map<String, Object> selectedBoard = statisticsService.selectedBoard(commandMap);
		model.addAttribute("selectedBoard",selectedBoard);
		
    	adminService.insertActHist("R", "[공지사항]수정 조회");
		
    	return "notification/update/noticeUpdateForm";	 	
	}

 	// 공지사항 삭제 end
 	@RequestMapping("/notification/noticeDeleteEnd.do")
	@ResponseBody
	public String noticeDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.boardDeleteEnd(commandMap); //board_cont 삭제
		statisticsService.boardFileDeleteEnd(commandMap); //board_file 삭제
		String msg = "삭제 완료";
		adminService.insertActHist("D", "[공지사항]삭제 완료");
		
    	return msg;	 	
	}

 	// 공지사항 등록 form
 	@RequestMapping("/notification/noticeWriteForm.do")
	public String noticeWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	adminService.insertActHist("R", "[공지사항]등록 조회");
		
    	return "notification/write/noticeWriteForm";	 	
	}
 	
 	// 설문조사
	@RequestMapping("/notification/survey.do")
	public String survey(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);    	    	    	
    	
    	List<Map<String, Object>> surveyList = notificationService.surveyList(commandMap);
    	int total_count = notificationService.surveyListTotalCnt(commandMap);
    	
    	
    	model.addAttribute("surveyList_list", surveyList);
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
    	
    	adminService.insertActHist("R", "[설문조사]목록 조회");
		return "notification/survey";	 	
	}
}

        