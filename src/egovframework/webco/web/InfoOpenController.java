package egovframework.webco.web;

import java.util.ArrayList;
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
public class InfoOpenController {

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
	//사전정보 공개
	@RequestMapping("/infoOpen/makePublic.do")
	public String makePublic(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	commandMap.put("brd_no", "32"); //사전정보 공개 구분
    	
    	
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
    	
    	adminService.insertActHist("L", "[사전정보 공개]목록 조회");
    	
		return "infoOpen/makePublic";	 	
	}

	//공공데이터 개방
	@RequestMapping("/infoOpen/openData.do")
	public String openData(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	commandMap.put("brd_no", "33"); //공공데이터 개방 구분
    	
    	
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
    	
    	adminService.insertActHist("L", "[공공데이터 개방]목록 조회");
    	
		return "infoOpen/openData";	 	
	}

	//법률자료
	@RequestMapping("/infoOpen/law.do")
	public String law(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	commandMap.put("brd_no", "21"); //법률자료 구분
    	commandMap.put("brd_file_seq", "1"); //첨부파일 seq
    	
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
    	
    	adminService.insertActHist("L", "[법률자료]목록 조회");
    	
		return "infoOpen/law";	 	
	}

	//학술자료
	@RequestMapping("/infoOpen/academic.do")
	public String academic(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	commandMap.put("brd_no", "13"); //학술자료 구분
    	
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
    	
    	adminService.insertActHist("L", "[학술자료]목록 조회");
    	
		return "infoOpen/academic";	 	
	}

	// 사전정보 공개 등록 form
	@RequestMapping("/infoOpen/makePublicWriteForm.do")
	public String makePublicWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{				
		
    	adminService.insertActHist("R", "[사전정보 공개]등록 조회");
		
    	return "infoOpen/write/makePublicWriteForm";	 	
	}

	// 사전정보 공개 수정 form
	@RequestMapping("/infoOpen/makePublicUpdateForm.do")
	public String makePublicUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		Map<String, Object> selectedBoard = statisticsService.selectedBoard(commandMap);
		model.addAttribute("selectedBoard",selectedBoard);
		model.addAttribute("param",commandMap);
		
    	adminService.insertActHist("R", "[사전정보 공개]수정 조회");
		
    	return "infoOpen/update/makePublicUpdateForm";	 	
	}

	// 사전정보 공개 삭제 end
	@RequestMapping("/infoOpen/makePublicDeleteEnd.do")
	@ResponseBody
	public String makePublicDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.boardDeleteEnd(commandMap); //board_cont 삭제
		statisticsService.boardFileDeleteEnd(commandMap); //board_file 삭제
		String msg = "삭제 완료";
		adminService.insertActHist("D", "[사전정보 공개]삭제 완료");
		
    	return msg;	 	
	}

	// 공공데이터 개방 등록 form
	@RequestMapping("/infoOpen/openDataWriteForm.do")
	public String openDataWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{				
		
    	adminService.insertActHist("R", "[공공데이터 개방]등록 조회");
		
    	return "infoOpen/write/openDataWriteForm";	 	
	}

	// 공공데이터 개방 수정 form
	@RequestMapping("/infoOpen/openDataUpdateForm.do")
	public String openDataUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		Map<String, Object> selectedBoard = statisticsService.selectedBoard(commandMap);
		model.addAttribute("selectedBoard",selectedBoard);
		model.addAttribute("param",commandMap);
		
    	adminService.insertActHist("R", "[공공데이터 개방]수정 조회");
		
    	return "infoOpen/update/openDataUpdateForm";	 	
	}

	// 공공데이터 개방 삭제 end
	@RequestMapping("/infoOpen/openDataDeleteEnd.do")
	@ResponseBody
	public String openDataDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.boardDeleteEnd(commandMap); //board_cont 삭제
		statisticsService.boardFileDeleteEnd(commandMap); //board_file 삭제
		String msg = "삭제 완료";
		adminService.insertActHist("D", "[공공데이터 개방]삭제 완료");
		
    	return msg;	 	
	}

	// 법률자료실 수정 form
	@RequestMapping("/infoOpen/lawUpdateForm.do")
	public String lawUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		commandMap.put("brd_file_seq", "1"); //첨부파일1 번호
		Map<String, Object> selectedBoard = statisticsService.selectedBoard(commandMap);
		model.addAttribute("selectedBoard",selectedBoard);
		
		commandMap.put("brd_file_seq", "2"); //첨부파일2 번호
		Map<String, Object> selectedBoardFile = statisticsService.selectedBoard(commandMap);
		model.addAttribute("selectedBoardFile",selectedBoardFile);
		
		model.addAttribute("param",commandMap);
		
    	adminService.insertActHist("R", "[법률자료실]수정 조회");
		
    	return "infoOpen/update/lawUpdateForm";	 	
	}

	// 법률자료실 삭제 end
	@RequestMapping("/infoOpen/lawDeleteEnd.do")
	@ResponseBody
	public String lawDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.boardDeleteEnd(commandMap); //board_cont 삭제
		statisticsService.boardFileDeleteEnd(commandMap); //board_file 삭제
		String msg = "삭제 완료";
		adminService.insertActHist("D", "[법률자료실]삭제 완료");
		
    	return msg;	 	
	}

	// 법률자료실 등록 form
	@RequestMapping("/infoOpen/lawWriteForm.do")
	public String lawWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{				
		
    	adminService.insertActHist("R", "[법률자료실]등록 조회");
		
    	return "infoOpen/write/lawWriteForm";	 	
	}

	// 학술자료실 수정 form
	@RequestMapping("/infoOpen/academicUpdateForm.do")
	public String academicUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		Map<String, Object> selectedBoard = statisticsService.selectedBoard(commandMap);
		model.addAttribute("selectedBoard",selectedBoard);
		model.addAttribute("param",commandMap);
		
    	adminService.insertActHist("R", "[학술자료실]수정 조회");
		
    	return "infoOpen/update/academicUpdateForm";	 	
	}

	// 학술자료실 삭제 end
	@RequestMapping("/infoOpen/academicDeleteEnd.do")
	@ResponseBody
	public String academicDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.boardDeleteEnd(commandMap); //board_cont 삭제
		statisticsService.boardFileDeleteEnd(commandMap); //board_file 삭제
		String msg = "삭제 완료";
		adminService.insertActHist("D", "[학술자료실]삭제 완료");
		
    	return msg;	 	
	}

	// 학술자료실 등록 form
	@RequestMapping("/infoOpen/academicWriteForm.do")
	public String academicWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{				
		
    	adminService.insertActHist("R", "[학술자료실]등록 조회");
		
    	return "infoOpen/write/academicWriteForm";	 	
	}
}

        