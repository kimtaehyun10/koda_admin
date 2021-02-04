package egovframework.webco.web;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.webco.service.AdminService;
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
public class RemembranceController {

    /** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());

    @Resource(name = "webcoService")
    private WebcoService webcoService;  
    
    @Resource(name = "remembranceService")
    private RemembranceService remembranceService;  
    
    @Resource(name = "adminService")
    private AdminService adminService;
    
    private String fileStorePath = EgovProperties.getProperty("globals.fileStorePath");
	
	//기증자 추모관
	@RequestMapping("/remembrance/member.do")
	public String member(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	List<Map<String, Object>> memberList = remembranceService.memberList(commandMap);
    	int total_count = remembranceService.memberListTotCnt(commandMap);
    	
    	
    	
    	model.addAttribute("memberList_list", memberList);
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
    	
    	adminService.insertActHist("L", "[기증자 추모관]목록 조회");
		return "remembrance/member";	 	
	}
	
	//하늘나라편지          
	@RequestMapping("/remembrance/letter.do")
	public String letter(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	commandMap.put("story_gubun", "letter"); //하늘나라편지 구분
    	
    	
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
    	
    	adminService.insertActHist("L", "[하늘나라편지]목록 조회");
		return "remembrance/letter";	 	
	}
	
	//기증 後 스토리        
	@RequestMapping("/remembrance/story.do")
	public String story(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	commandMap.put("story_gubun", "story"); //기증 後 스토리 구분
    	
    	
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
    	
    	adminService.insertActHist("L", "[기증 後 스토리]목록 조회");
		return "remembrance/story";	 	
	}
	
	//수혜자 편지           
	@RequestMapping("/remembrance/recipient.do")
	public String recipient(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	commandMap.put("story_gubun", "recipient"); //수혜자 편지 구분
    	
    	
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
    	
    	adminService.insertActHist("L", "[수혜자 편지]목록 조회");
		return "remembrance/recipient";	 	
	}
	
	//기증자 추모관 updateForm
	@RequestMapping("/remembrance/memberUpdateForm.do")
	public String memberUpdate(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	Map<String, Object> selectedMember= remembranceService.selectedMember(commandMap);
    	model.addAttribute("selectedMember", selectedMember);
    	model.addAttribute("param",commandMap);
    	adminService.insertActHist("L", "[기증자 추모관]수정 조회");
		
    	return "remembrance/memberUpdateForm";	 	
	}
	
	//기증자 추모관 updateEnd
	@RequestMapping("/remembrance/memberUpdateEnd.do")
	@ResponseBody
	public String memberUpdateEnd(ModelMap model, @RequestParam Map<String, Object> commandMap, @RequestParam("brd_file_org_nm") MultipartFile multipartFile) throws Exception{
		
		if("".equals(commandMap.get("donate_anonymity")) || commandMap.get("donate_anonymity")==null){
			commandMap.put("donate_anonymity", "N");
		}
		//사진 업데이트 작업하자
    	//remembranceService.memberUpdateEnd(commandMap); 
    	String msg="수정완료";
    	//adminService.insertActHist("L", "[기증자 추모관]수정 완료");
		
    	return msg;	 	
	}
	
	//기증자 추모관 deleteEnd
	@RequestMapping("/remembrance/memberDeleteEnd.do")
	@ResponseBody
	public String memberDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	remembranceService.memberDeleteEnd(commandMap);    	    	
    	String msg="삭제 완료";
    	adminService.insertActHist("L", "[기증자 추모관]삭제 완료");
		
    	return msg;	 	
	}
	
	//기증자 추모관 글쓰기 form
	@RequestMapping("/remembrance/memberWriteForm.do")
	public String memberWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		    	    	
    	adminService.insertActHist("L", "[기증자 추모관]등록 조회");
		
    	return "remembrance/memberWriteForm";	 	
	}
	
	//기증자 추모관 글쓰기 end
	@RequestMapping("/remembrance/memberWriteEnd.do")
	public String memberWriteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap, HttpServletResponse response, HttpServletRequest request, @RequestParam("brd_file_org_nm") MultipartFile multipartFile) throws Exception{
		
		if("".equals(commandMap.get("donate_anonymity")) || commandMap.get("donate_anonymity")==null){
			commandMap.put("donate_anonymity", "N");
		}
		
		try {
			// 파일 정보
			String originFilename = multipartFile.getOriginalFilename();
			
			if(!"".equals(originFilename) && originFilename!=null){
				String extName
				= originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			Long size = multipartFile.getSize();
			
			// 서버에서 저장 할 파일 이름
			String saveFileName = genSaveFileName(extName);
			
			commandMap.put("donate_org_img", originFilename);
			commandMap.put("donate_img", saveFileName);
			
			writeFile(multipartFile, saveFileName, request);
			}
			
			remembranceService.memberWriteEnd(commandMap);    	    	
	    	adminService.insertActHist("L", "[기증자 추모관]글쓰기 완료");
			
	    	response.setContentType("text/html; charset=UTF-8");    	 
	    	PrintWriter out = response.getWriter();    	
	    	out.println("<script>alert('등록 완료'); location.href='"+request.getContextPath()+"/remembrance/member.do';</script>");    	 
	    	out.flush();
	    	
			}catch (IOException e) {
			
			throw new RuntimeException(e);
		}				    	    	    	    	
    	
    	return "remembrance/member";	 	
	}
	
	//하늘나라 편지 수정 form
	@RequestMapping("/remembrance/letterUpdateForm.do")
	public String letterUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	Map<String, Object> selectedLetterStory= remembranceService.selectedLetterStory(commandMap);
    	model.addAttribute("selectedLetterStory", selectedLetterStory);
    	model.addAttribute("param",commandMap);
    	//댓글
    	commandMap.put("story_gubun", "letter"); //자유게시판 댓글 구분
    	List<Map<String, Object>> letterStoryComment = remembranceService.letterStoryComment(commandMap);
    	model.addAttribute("letterStoryComment", letterStoryComment);
    	adminService.insertActHist("L", "[하늘나라 편지]수정 조회");
	
    	return "remembrance/letterUpdateForm";	 	
	}
	
	//하늘나라,수혜자,기증후 스토리,자유게시판 수정 End
	@RequestMapping("/remembrance/letterStoryUpdateEnd.do")
	@ResponseBody
	public String letterStoryUpdateEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		if("".equals(commandMap.get("story_anonymity")) || commandMap.get("story_anonymity")==null){
			commandMap.put("story_anonymity", "N");
		}
		
		if("recipient".equals(commandMap.get("story_gubun"))){
			String title = (String)commandMap.get("story_title");
			String year = (String)commandMap.get("year");
			commandMap.put("story_title", title+"|"+year);
		}
		
		if("free".equals(commandMap.get("story_gubun"))){
			commandMap.put("story_area", 0);
		}
    	remembranceService.letterStoryUpdateEnd(commandMap);    	    	
    	
    	if("letter".equals(commandMap.get("story_gubun"))){
    		
    		adminService.insertActHist("U", "[하늘나라 편지]수정 완료");
    		
    	}else if("recipient".equals(commandMap.get("story_gubun"))){
    		adminService.insertActHist("U", "[수혜자 편지]수정 완료");
    	}else if("story".equals(commandMap.get("story_gubun"))){
    		adminService.insertActHist("U", "[기증 後 스토리]수정 완료");
    	}else if("free".equals(commandMap.get("story_gubun"))){
    		    		    		
    		adminService.insertActHist("U", "[자유게시판]수정 완료");
    	
    	}
		String msg = "수정완료";
		
		return msg;
	}
	
	//기증자명 찾기 popup
	@RequestMapping("/remembrance/donateMemberPopup.p")
	public String searchDonateMember(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	commandMap.put("search_gubun", "N");
    	
    	List<Map<String, Object>> memberList = remembranceService.memberList(commandMap);
    	int total_count = remembranceService.memberListTotCnt(commandMap);
    	
    	
    	
    	model.addAttribute("memberList_list", memberList);
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
		
    	return "remembrance/popup/donateMemberPopup";	 	
	}
	
	//하늘나라,수혜자,기증후 스토리,자유게시판 삭제 End
	@RequestMapping("/remembrance/letterStoryDeleteEnd.do")
	@ResponseBody
	public String letterStoryDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	remembranceService.letterStoryDeleteEnd(commandMap);    	    	
    	String msg = "삭제 완료";
    	
    	// 관련 댓글 삭제
    	commandMap.put("deleteType", "ALL");
		commandMap.put("bod_idx", commandMap.get("story_idx"));
		commandMap.put("com_div", commandMap.get("story_gubun"));
		remembranceService.letterStoryCommentDeleteEnd(commandMap);
    	
    	if("letter".equals(commandMap.get("story_gubun"))){
    		
    		adminService.insertActHist("D", "[하늘나라 편지]삭제 완료");
    	
    	}else if("recipient".equals(commandMap.get("story_gubun"))){
    		
    		adminService.insertActHist("D", "[수혜자 편지]삭제 완료");
    	
    	}else if("story".equals(commandMap.get("story_gubun"))){
    		
    		adminService.insertActHist("D", "[기증 後 스토리]삭제 완료");
    	
    	}else if("free".equals(commandMap.get("story_gubun"))){

    		adminService.insertActHist("D", "[자유게시판]삭제 완료");
    	}
		
    	return msg;	 	
	}
	
	//하늘나라 편지 글쓰기 form
	@RequestMapping("/remembrance/letterWriteForm.do")
	public String letterWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		    	    	
    	adminService.insertActHist("L", "[하늘나라 편지]등록 조회");
		
    	return "remembrance/letterWriteForm";	 	
	}
	
	//하늘나라,수혜자,기증후 스토리 글쓰기 end
	@RequestMapping("/remembrance/letterStoryWriteEnd.do")
	public String letterStoryWriteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap, HttpServletResponse response, HttpServletRequest request) throws Exception{
		
		if("".equals(commandMap.get("story_anonymity")) || commandMap.get("story_anonymity")==null){
			commandMap.put("story_anonymity", "N");
		}
		
		if("recipient".equals(commandMap.get("story_gubun"))){
			String title = (String)commandMap.get("story_title");
			String year = (String)commandMap.get("year");
			commandMap.put("story_title", title+"|"+year);
		}
		
		if("free".equals(commandMap.get("story_gubun"))){
			commandMap.put("story_area", 0);
		}			
		
    	remembranceService.letterStoryWriteEnd(commandMap);    	    	
    	
    	if("letter".equals(commandMap.get("story_gubun"))){
    		adminService.insertActHist("C", "[하늘나라 편지]등록 완료");
    	}else if("recipient".equals(commandMap.get("story_gubun"))){
    		adminService.insertActHist("C", "[수혜자 편지]등록 완료");
    	}else if("story".equals(commandMap.get("story_gubun"))){
    		adminService.insertActHist("C", "[기증 後 스토리]등록 완료");
    	}else if("free".equals(commandMap.get("story_gubun"))){
    		adminService.insertActHist("C", "[자유게시판]등록 완료");
    	}
		
    	response.setContentType("text/html; charset=UTF-8");    	 
    	PrintWriter out = response.getWriter();
    	
    	if("free".equals(commandMap.get("story_gubun"))){
    		    		    	
        	out.println("<script>alert('등록 완료'); location.href='"+request.getContextPath()+"/notification/free.do';</script>");    	 
        	out.flush();
    		
    		return "notification/free";
    	}else{
    		
    		out.println("<script>alert('등록 완료'); location.href='"+request.getContextPath()+"/remembrance/"+commandMap.get("story_gubun")+".do';</script>");    	 
        	out.flush();
        	
    		return "remembrance/"+commandMap.get("story_gubun")+"";
    	}
    	
    		 	
	}
	
	//수혜자 편지 수정 form
	@RequestMapping("/remembrance/recipientUpdateForm.do")
	public String recipientUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	Map<String, Object> selectedLetterStory= remembranceService.selectedLetterStory(commandMap);
    	model.addAttribute("selectedLetterStory", selectedLetterStory);
    	model.addAttribute("param",commandMap);
    	
    	//댓글
    	commandMap.put("story_gubun", "recipient"); //자유게시판 댓글 구분
    	List<Map<String, Object>> letterStoryComment = remembranceService.letterStoryComment(commandMap);
    	model.addAttribute("letterStoryComment", letterStoryComment);
    	
    	adminService.insertActHist("L", "[수혜자 편지]수정 조회");
	
    	return "remembrance/recipientUpdateForm";	 	
	}
	
	//수혜자 편지 글쓰기 form
	@RequestMapping("/remembrance/recipientWriteForm.do")
	public String recipientWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		    	    	
    	adminService.insertActHist("L", "[수혜자 편지]등록 조회");
		
    	return "remembrance/recipientWriteForm";	 	
	}
	
	//기증후 스토리 수정 form
	@RequestMapping("/remembrance/storyUpdateForm.do")
	public String storyUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	Map<String, Object> selectedLetterStory= remembranceService.selectedLetterStory(commandMap);
    	model.addAttribute("selectedLetterStory", selectedLetterStory);
    	model.addAttribute("param",commandMap);
    	
    	//댓글
    	commandMap.put("story_gubun", "story"); //자유게시판 댓글 구분
    	List<Map<String, Object>> letterStoryComment = remembranceService.letterStoryComment(commandMap);
    	model.addAttribute("letterStoryComment", letterStoryComment);
    	
    	adminService.insertActHist("L", "[기증 後 스토리]수정 조회");
	
    	return "remembrance/storyUpdateForm";	 	
	}
	
	//기증후 스토리 글쓰기 form
	@RequestMapping("/remembrance/storyWriteForm.do")
	public String storyWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		    	    	
    	adminService.insertActHist("L", "[기증 後 스토리]등록 조회");
		
    	return "remembrance/storyWriteForm";	 	
	}

	// 댓글 등록 form
	@RequestMapping("/remembrance/letterStoryCommentWriteForm.p")
	public String letterStoryCommentWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		model.addAttribute("bod_idx",commandMap.get("bod_idx"));
		model.addAttribute("com_div",commandMap.get("com_div"));
    	
		return "remembrance/popup/letterStoryCommentWriteForm";	 	
	}

	// 댓글 등록 end
	@RequestMapping("/remembrance/letterStoryCommentWriteEnd.do")
	@ResponseBody
	public String letterStoryCommentWriteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		// 댓글 테이블 마지막 idx
		int com_idx = remembranceService.commentEndIdx(); // 해당 테이블 마지막 idx
		commandMap.put("com_idx", com_idx+1);
		
		remembranceService.letterStoryCommentWriteEnd(commandMap);
		String msg = "등록 완료";
		
		if("free".equals(commandMap.get("com_div"))){
			adminService.insertActHist("C", "[자유게시판 댓글]등록 완료");
		}else if("recipient".equals(commandMap.get("com_div"))){
			adminService.insertActHist("C", "[수혜자편지 댓글]등록 완료");
		}else if("letter".equals(commandMap.get("com_div"))){
			adminService.insertActHist("C", "[하늘나라편지 댓글]등록 완료");
		}else if("story".equals(commandMap.get("com_div"))){
			adminService.insertActHist("C", "[기증 後 스토리 댓글]등록 완료");
		}
    	return msg;	 	
	}

	// 댓글 삭제 end
	@RequestMapping("/remembrance/letterStoryCommentDeleteEnd.do")
	@ResponseBody
	public String letterStoryCommentDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{

		
		remembranceService.letterStoryCommentDeleteEnd(commandMap);
		String msg = "삭제 완료";
		
		if("free".equals(commandMap.get("com_div"))){
			adminService.insertActHist("D", "[자유게시판 댓글]삭제 완료");
		}else if("recipient".equals(commandMap.get("com_div"))){
			adminService.insertActHist("D", "[수혜자편지 댓글]삭제 완료");
		}else if("letter".equals(commandMap.get("com_div"))){
			adminService.insertActHist("D", "[하늘나라편지 댓글]삭제 완료");
		}else if("story".equals(commandMap.get("com_div"))){
			adminService.insertActHist("D", "[기증 後 스토리 댓글]삭제 완료");
		}
    	return msg;	 	
	}

	//댓글 수정 end
	@RequestMapping("/remembrance/letterStoryCommentUpdateEnd.do")
	@ResponseBody
	public String letterStoryCommentUpdateEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{

		
		remembranceService.letterStoryCommentUpdateEnd(commandMap);
		String msg = "수정 완료";
		
		if("free".equals(commandMap.get("com_div"))){
			adminService.insertActHist("U", "[자유게시판 댓글]수정 완료");
		}else if("recipient".equals(commandMap.get("com_div"))){
			adminService.insertActHist("U", "[수혜자편지 댓글]수정 완료");
		}else if("letter".equals(commandMap.get("com_div"))){
			adminService.insertActHist("U", "[하늘나라편지 댓글]수정 완료");
		}else if("story".equals(commandMap.get("com_div"))){
			adminService.insertActHist("U", "[기증 後 스토리 댓글]수정 완료");
		}
		
    	return msg;	 	
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
}

        