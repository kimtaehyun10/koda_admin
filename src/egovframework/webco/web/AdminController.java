package egovframework.webco.web;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.util.StringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.webco.service.AdminService;
import egovframework.webco.service.StatisticsService;
import egovframework.webco.service.WebcoService;
import egovframework.webco.util.CommonUtil;
import egovframework.webco.util.SessionUtil;
import egovframework.webco.vo.AdminVO;
import egovframework.webco.vo.SmarteditorVO;
import net.sf.json.JSONObject;

@Controller
public class AdminController {

    /** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());

    @Resource(name = "webcoService")
    private WebcoService webcoService; 
    
    @Resource(name = "adminService")
    private AdminService adminService;
    
    @Resource(name = "statisticsService")
    private StatisticsService statisticsService;
    /**
     * 관리자 목록 조회
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/admin/adminList.do")
    public String adminList(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
    	
    	int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	List<Map<String, Object>> adminList = webcoService.list_map("AdminDAO.selectList", commandMap);
    	int total_count = (Integer)webcoService.selectCount("AdminDAO.selectCount", commandMap);
    	
    	for( Map<String, Object> adminInfo : adminList ) {
    		adminInfo.put("admin_create_time", CommonUtil.DateFormat(adminInfo.get("admin_create_time").toString(), "yyyy.MM.dd"));
    		adminInfo.put("last_login_time", CommonUtil.DateFormat(adminInfo.get("last_login_time").toString(), "yyyy.MM.dd"));
    		adminInfo.put("admin_pwd_chg_time", CommonUtil.DateFormat(adminInfo.get("admin_pwd_chg_time").toString(), "yyyy.MM.dd"));
    	}
    	
    	model.addAttribute("admin_list", adminList);
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
    	
    	adminService.insertActHist("L", "[관리자]목록 조회");
    	
        return "/admin/adminList";
    }
    
    /**
     * 관리자 신규등록 화면
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/admin/adminAdd.do")
    public String adminAdd(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
    	AdminVO adminVO = SessionUtil.getAuthenticatedUser();
    	
    	model.addAttribute("admin_grade", adminVO.getAdmin_grade());
        return "/admin/adminAdd";
    }
    
    /**
     * 관리자 수정 화면
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/admin/adminEdit.do")
    public String adminEdit(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
    	AdminVO adminVO = SessionUtil.getAuthenticatedUser();
    	if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("admin_index")))) { 
    		commandMap.put("admin_index", adminVO.getAdmin_index());
    		//return "redirect:/admin/adminList.do";
    	} else {
    		if(!adminVO.getAdmin_grade().equals("2") && !adminVO.getAdmin_grade().equals("-1")) {	//마스터 관리자가 아니면 팅겨낸다.
    			return "redirect:/admin/adminList.do";
    		}
    	}
    	Map<String, Object> adminInfo = webcoService.selectByPk("AdminDAO.select", commandMap);    	
    	model.addAttribute("admin", adminInfo);
                
        adminService.insertActHist("R", "[관리자]상세 조회 admin_index : "+EgovStringUtil.isNullToString(commandMap.get("admin_index")));
        return "/admin/adminEdit";
    }
    
    /**
     * 관리자 비밀번호 변경화면
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/admin/adminEditPwd.do")
    public String adminEditPwd(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
    	
    	AdminVO adminVO = SessionUtil.getAuthenticatedUser();
    	if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("admin_index")))) { 
    		commandMap.put("admin_index", adminVO.getAdmin_index());
    		//return "redirect:/admin/adminList.do";
    	} else {
    		if(!adminVO.getAdmin_grade().equals("2") && !adminVO.getAdmin_grade().equals("-1")) {	//마스터 관리자가 아니면 팅겨낸다.
    			return "redirect:/admin/adminList.do";
    		}
    	}
    	/*if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("admin_index")))) {
    		return "redirect:/admin/adminList.do";
    	}*/
    	Map<String, Object> adminInfo = webcoService.selectByPk("AdminDAO.select", commandMap);    	
    	model.addAttribute("admin", adminInfo);
    	    	
        return "/admin/adminEditPwd";
    }
    
    /**
     * 관리자 비밀번호 변경화면
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/admin/adminChgPwd.do")
    public String adminChgPwd(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
    	AdminVO adminVO = SessionUtil.getAuthenticatedUser();
    	commandMap.put("admin_index", adminVO.getAdmin_index());
    	
    	Map<String, Object> adminInfo = webcoService.selectByPk("AdminDAO.select", commandMap);    	
    	model.addAttribute("admin", adminInfo);
    	model.addAttribute("adminVO", adminVO);
    	    	
        return "/admin/adminChgPwd";
    }
    
    /**
     * 관리자 등록
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/admin/insert.do")
    public void insert(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
    	// admin_id, admin_pwd, admin_nick_name, admin_grade, 
    	
    	String msg = "";
    	int result = Integer.parseInt(webcoService.insert("AdminDAO.insert", commandMap).toString());
		if(result > 0) {
    		msg = "관리자 계정이 등록되었습니다";
    	} else {
    		msg = "계정 등록 중 오류가 발생하였습니다. 잠시 후 다시 시도해주시기 바랍니다.";
    	}
		adminService.insertActHist("C", "[관리자]신규 등록 admin_index : "+EgovStringUtil.isNullToString(commandMap.get("admin_index")));
    	response.setContentType("text/html; charset=UTF-8");    	 
    	PrintWriter out = response.getWriter();    	
    	out.println("<script>alert('"+msg+"'); location.href='./adminList.do';</script>");    	 
    	out.flush(); 
    }
    
    /**
     * 관리자 수정
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/admin/update.do")
    public void update(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap,			
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
    	// admin_id, admin_pwd, admin_nick_name, admin_grade, 
    	
    	String msg = "";
    	int result = (int) webcoService.update("AdminDAO.update", commandMap);
		if(result > 0) {
    		msg = "관리자 계정이 수정되었습니다";
    		adminService.insertActHist("U", "[관리자]정보 수정 admin_index : "+EgovStringUtil.isNullToString(commandMap.get("admin_index")));
    	} else {
    		msg = "계정 등록 중 오류가 발생하였습니다. 잠시 후 다시 시도해주시기 바랍니다.";
    	}
		if(EgovStringUtil.isNullToString(request.getSession().getAttribute("smsAuth")).equals("") && 
			!EgovStringUtil.isNullToString(commandMap.get("admin_index")).equals("")) {

			msg = "계정이 수정되었습니다. 다시 로그인 해주시기 바랍니다.";
			
			response.setContentType("text/html; charset=UTF-8");    	 
	    	PrintWriter out = response.getWriter();    	
	    	out.println("<script>alert('"+msg+"'); location.href='../index.jsp';</script>");    	 
	    	out.flush(); 
			
			AdminVO adminVO = new AdminVO();
	        adminVO.setAdmin_id(SessionUtil.getAdminId());
	        //intranetIndexService.updateUserConectlog(userVO); // 로그아웃 접속로그 저장
	                        
	        RequestContextHolder.getRequestAttributes().removeAttribute("adminVO", RequestAttributes.SCOPE_SESSION);
	        request.getSession().invalidate();
	        					    
		} else {
	    	response.setContentType("text/html; charset=UTF-8");    	 
	    	PrintWriter out = response.getWriter();    	
	    	out.println("<script>alert('"+msg+"'); location.href='./adminList.do';</script>");    	 
	    	out.flush();
		}
    }
    
    /**
     * 관리자 비밀번호 변경
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/admin/updatePwd.do")
    public void updatePwd(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
    	// admin_id, admin_pwd, admin_nick_name, admin_grade, 
    	
    	String msg = "";
    	String return_url = "./adminList.do";
    	
    	String admin_new_pwd = EgovStringUtil.isNullToString(commandMap.get("admin_new_pwd"));
    	String confirm_admin_new_pwd = EgovStringUtil.isNullToString(commandMap.get("confirm_admin_new_pwd"));
    	
    	if(admin_new_pwd.equals(confirm_admin_new_pwd)) {
	    	int result = (int) webcoService.update("AdminDAO.updatePwd", commandMap);
			if(result > 0) {
	    		msg = "비밀번호가 변경되었습니다";
	    		adminService.insertActHist("U", "[관리자]비밀번호 변경 admin_index : "+EgovStringUtil.isNullToString(commandMap.get("admin_index")));
	    	} else {
	    		msg = "비밀번호 변경 중 오류가 발생하였습니다. 잠시 후 다시 시도해주시기 바랍니다.";
	    	}    	
    	} else {
    		msg = "비밀번호가 일치하지 않습니다.";
    		return_url = "./adminEditPwd.do?admin_index="+commandMap.get("confirm_admin_new_pwd").toString();
    	}
    	response.setContentType("text/html; charset=UTF-8");    	 
    	PrintWriter out = response.getWriter();    	
    	out.println("<script>alert('"+msg+"'); location.href='"+return_url+"';</script>");    	 
    	out.flush(); 
    }
    
    /**
     * 관리자 비밀번호 변경
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/admin/chgPwd.do")
    public void chgPwd(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
    	// admin_id, admin_pwd, admin_nick_name, admin_grade, 
    	
    	String msg = "";
    	String return_url = "../statistics/dashboard.do";
    	
    	AdminVO adminVO = SessionUtil.getAuthenticatedUser();
    	commandMap.put("admin_index", adminVO.getAdmin_index());
    	
    	String admin_new_pwd = EgovStringUtil.isNullToString(commandMap.get("admin_new_pwd"));
    	String confirm_admin_new_pwd = EgovStringUtil.isNullToString(commandMap.get("confirm_admin_new_pwd"));
    	
    	if(admin_new_pwd.equals(confirm_admin_new_pwd)) {
	    	int result = (int) webcoService.update("AdminDAO.updatePwd", commandMap);
			if(result > 0) {
	    		msg = "비밀번호가 변경되었습니다";
	    		adminVO.setAdmin_chg_pwd(0);
	    		request.getSession().setAttribute("adminVO", adminVO); // 사용자정보 세션저장
	    		//request.getSession().removeAttribute("admin_pwd_chg");
	    		adminService.insertActHist("U", "[관리자]본인 비밀번호 변경 admin_index : "+EgovStringUtil.isNullToString(commandMap.get("admin_index")));
	    	} else {
	    		msg = "비밀번호 변경 중 오류가 발생하였습니다. 잠시 후 다시 시도해주시기 바랍니다.";
	    	}    	
    	} else {
    		msg = "비밀번호가 일치하지 않습니다.";
    		return_url = "./adminChgPwd.do?admin_index="+commandMap.get("confirm_admin_new_pwd").toString();
    	}
    	response.setContentType("text/html; charset=UTF-8");    	 
    	PrintWriter out = response.getWriter();    	
    	out.println("<script>alert('"+msg+"'); location.href='"+return_url+"';</script>");    	 
    	out.flush(); 
    }
    
    /**
     * 관리자 삭제
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/admin/delete.do")
    public void delete(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
    	
    	int result = 0;
    	String msg = "";
    	if(!EgovStringUtil.isEmpty(commandMap.get("admin_index").toString())) {
			result =  webcoService.delete("AdminDAO.delete", commandMap);
    	}
    	if(result > 0) {
    		msg = "관리자 계정이 삭제되었습니다";
    		adminService.insertActHist("D", "[관리자]정보 삭제 admin_index : "+EgovStringUtil.isNullToString(commandMap.get("admin_index")));
    	} else {
    		msg = "계정 삭제 중 오류가 발생하였습니다. 잠시 후 다시 시도해주시기 바랍니다.";
    	}
    	response.setContentType("text/html; charset=UTF-8");    	 
    	PrintWriter out = response.getWriter();    	
    	out.println("<script>alert('"+msg+"'); location.href='./adminList.do';</script>");    	 
    	out.flush();    	    
    }
    
    /**
     * 관리자 아이디 사용유무 체크
     * @return JSONObject
     * @exception Exception
     */
 	@RequestMapping("/admin/ajaxCheckAdminId.do")
 	public @ResponseBody JSONObject ajaxCheckAdminId(ModelMap model, 	
 			@RequestParam Map<String, Object> commandMap, 
 			HttpServletRequest request, HttpServletResponse response) throws Exception{
 		Map<String, Object> rtnMap = new HashMap<String, Object>();		
		
 		Map<String, Object> adminInfo = webcoService.selectByPk("AdminDAO.select", commandMap);
 		
 		if(adminInfo == null) {
 			rtnMap.put("rtnCode", "");
	    	rtnMap.put("rtnMsg", "사용가능한 아이디입니다.");
 		} else {
 			rtnMap.put("rtnCode", "-1");
	    	rtnMap.put("rtnMsg", "Admin ID Already Exists!");
 		}
		rtnMap.put("search_value", commandMap);		
		return CommonUtil.getObjectToJSONObject(rtnMap);
 	}
 	
 	/**
     * 관리자 잠금해제
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/admin/unlock.do")
    public void unlock(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
    	
    	int result = 0;
    	String msg = "";
    	if(!EgovStringUtil.isEmpty(commandMap.get("admin_index").toString())) {
    		
			result =  webcoService.delete("AdminDAO.unlock", commandMap);    	
	    	if(result > 0) {
	    		adminService.insertActHist("U", "[관리자]계정 잠금해제 admin_index : "+EgovStringUtil.isNullToString(commandMap.get("admin_index")));
	    		msg = "계정이 잠금해제 되었습니다.";
	    	} else {
	    		msg = "계정 해제 중 오류가 발생하였습니다. 잠시 후 다시 시도해주시기 바랍니다.";
	    	}
    	} else {
    		msg = "정상적인 접근이 아닙니다. 잠시 후 다시 시도해주시기 바랍니다.";
    	}
    	response.setContentType("text/html; charset=UTF-8");    	 
    	PrintWriter out = response.getWriter();    	
    	out.println("<script>alert('"+msg+"'); location.href='./adminList.do';</script>");    	 
    	out.flush();    	    
    }
    
    /**
     * 관리자 잠금
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/admin/lock.do")
    public void lock(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
    	
    	int result = 0;
    	String msg = "";
    	if(!EgovStringUtil.isEmpty(commandMap.get("admin_index").toString())) {
			result =  webcoService.delete("AdminDAO.lock", commandMap);
	    	
	    	if(result > 0) {
	    		adminService.insertActHist("U", "[관리자]계정 잠금 admin_index : "+EgovStringUtil.isNullToString(commandMap.get("admin_index")));
	    		msg = "계정이 잠금 되었습니다";
	    	} else {
	    		msg = "계정 잠금 중 오류가 발생하였습니다. 잠시 후 다시 시도해주시기 바랍니다.";
	    	}
    	} else {
    		msg = "정상적인 접근이 아닙니다. 잠시 후 다시 시도해주시기 바랍니다.";
    	}
    	response.setContentType("text/html; charset=UTF-8");    	 
    	PrintWriter out = response.getWriter();    	
    	out.println("<script>alert('"+msg+"'); location.href='./adminList.do';</script>");    	 
    	out.flush();    	    
    }
    
    /**
     * 관리자 목록 조회
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/admin/adminActHistList.do")
    public String adminActHistList(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
    	
    	int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	long search_start_date_time = 0;
		long search_end_date_time = 0;
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("search_start_date")))) {		    		
			search_start_date_time = CommonUtil.dateToLong(commandMap.get("search_start_date").toString(), "yyyy.MM.dd");
			commandMap.put("begin_act_time", Long.toString(search_start_date_time));
		}
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("search_end_date")))) {		    		
			search_end_date_time = CommonUtil.dateToLong(commandMap.get("search_end_date").toString(), "yyyy.MM.dd");
			commandMap.put("end_act_time", Long.toString(search_end_date_time));
		}
				
    	
    	List<Map<String, Object>> adminActHistList = webcoService.list_map("AdminDAO.selectActList", commandMap);
    	int total_count = (Integer)webcoService.selectCount("AdminDAO.selectActHistCount", commandMap);
    	
    	for( Map<String, Object> adminActHistInfo : adminActHistList ) {
    		adminActHistInfo.put("act_time", CommonUtil.DateFormat(adminActHistInfo.get("act_time").toString(), "yyyy-MM-dd HH:mm:ss"));    		
    	}
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	paginationInfo.setCurrentPageNo(page);
    	paginationInfo.setRecordCountPerPage(limit);    	
    	paginationInfo.setPageSize(10);    	
    	if(paginationInfo != null){ 
    		paginationInfo.setTotalRecordCount(total_count); 
    		model.addAttribute("paginationInfo", paginationInfo); 
    	}
    	
    	model.addAttribute("dataList", adminActHistList);
    	model.addAttribute("total_count", total_count);
    	model.addAttribute("param", commandMap);
    	
    	AdminVO adminVO = SessionUtil.getAuthenticatedUser();    	
    	
        return "/admin/adminActHistList";
    }

    // 파일 업로드
    @RequestMapping("/admin/fileUpload.do")
	@ResponseBody
	public String fileUpload(ModelMap model, @RequestParam Map<String, Object> commandMap, @RequestParam("brd_file_org_nm") MultipartFile multipartFile) throws Exception{
		
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
			
			commandMap.put("brd_file_org_nm", originFilename);
			commandMap.put("brd_file_nm", saveFileName);
			
			writeFile(multipartFile, saveFileName);
			
			//board_file 테이블 수정
			if(!"".equals(commandMap.get("brd_cont_no")) && commandMap.get("brd_cont_no") != null){
				adminService.fileUpload(commandMap);
			}
			
			}
										
			if("board_insert".equals(commandMap.get("type"))){
				//board_file 테이블 insert				
				endIdx = statisticsService.boardContEndIdx();				
				commandMap.put("brd_cont_no", endIdx+1);
				
				statisticsService.boardFileInsert(commandMap);
			}	

			msg = "업로드 완료";
			
			
			if("board_update".equals(commandMap.get("type"))){
				//board 테이블 수정
				statisticsService.boardUpdateEnd(commandMap);
				msg = "수정 완료";
			}else if("board_insert".equals(commandMap.get("type"))){
				//board 테이블 insert
				statisticsService.boardInsert(commandMap);
				msg = "등록 완료";
			}
		}
		catch (IOException e) {
			
			throw new RuntimeException(e);
		}
		
		return msg+","+(endIdx+1);
	}

    // 멀티파일 업로드
    @RequestMapping("/admin/multiFileUpload.do")
	@ResponseBody
	public String multiFileUpload(ModelMap model, @RequestParam Map<String, Object> commandMap, 
								 @RequestParam("brd_file_org_nm") MultipartFile multipartFile,
								 @RequestParam("brd_file_org_nm1") MultipartFile multipartFile1) throws Exception{
		
    	String msg = "";
		int endIdx = 0;
		//첫번째 파일
		try {
			// 파일 정보
			String originFilename = multipartFile.getOriginalFilename();
			
			if(!"".equals(originFilename) && originFilename!=null){
				String extName
				= originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			Long size = multipartFile.getSize();
			
			// 서버에서 저장 할 파일 이름
			String saveFileName = genSaveFileName(extName);
			
			commandMap.put("brd_file_org_nm", originFilename);
			commandMap.put("brd_file_nm", saveFileName);
			
			writeFile(multipartFile, saveFileName);
			
			//board_file 테이블 수정
			if("board_update".equals(commandMap.get("type"))){
				commandMap.put("brd_file_seq", "1");
				adminService.fileUpload(commandMap);
			}
			
			}
										
			if("board_insert".equals(commandMap.get("type"))){
				//board_file 테이블 insert
				endIdx = statisticsService.boardContEndIdx();												
				commandMap.put("brd_cont_no", endIdx+1);
				
				statisticsService.boardFileInsert(commandMap);
			}	

			msg = "업로드 완료";
			
			
			if("board_update".equals(commandMap.get("type"))){
				//board 테이블 수정
				statisticsService.boardUpdateEnd(commandMap);
				msg = "수정 완료";
			}else if("board_insert".equals(commandMap.get("type"))){
				//board 테이블 insert
				statisticsService.boardInsert(commandMap);
				msg = "등록 완료";
			}
		}
		catch (IOException e) {
			
			throw new RuntimeException(e);
		}
		
		//두번째 파일
		try {
			// 파일 정보
			String originFilename = multipartFile1.getOriginalFilename();
			
			Map<String, Object> commandMap2 = new HashMap<String, Object>();
			commandMap2.put("brd_no", commandMap.get("brd_no"));
			commandMap2.put("brd_cont_no", commandMap.get("brd_cont_no"));
			
			if(!"".equals(originFilename) && originFilename!=null){
				String extName
				= originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			Long size = multipartFile.getSize();
			
			// 서버에서 저장 할 파일 이름
			String saveFileName = genSaveFileName(extName);
			
			commandMap2.put("brd_file_org_nm", originFilename);
			commandMap2.put("brd_file_nm", saveFileName);
			
			writeFile(multipartFile, saveFileName);
			
			//board_file 테이블 수정
			if("board_update".equals(commandMap.get("type"))){
				commandMap2.put("brd_file_seq", "2");
				adminService.fileUpload(commandMap2);
			}
			
			}
										
			if("board_insert".equals(commandMap.get("type"))){
				//board_file 테이블 insert

				commandMap2.put("brd_file_seq", "2");
				statisticsService.boardFileInsert(commandMap2);
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

 	
 	// ckeditor 파일업로드	
 	@RequestMapping(value="/admin/ckeditorUpload.do", method = RequestMethod.POST)
	 public void imageUpload(HttpServletRequest request,
	         HttpServletResponse response, MultipartHttpServletRequest multiFile
	         , @RequestParam MultipartFile upload) throws Exception{
	     // 랜덤 문자 생성
	     UUID uid = UUID.randomUUID();
	     
	     OutputStream out = null;
	     PrintWriter printWriter = null;
	     
	     //인코딩
	     response.setCharacterEncoding("utf-8");
	     response.setContentType("text/html;charset=utf-8");
	     
	     try{
	         
	         //파일 이름 가져오기
	         String fileName = upload.getOriginalFilename();
	         byte[] bytes = upload.getBytes();
	         
	         //이미지 경로 생성
	         String path = "C:/work/koda/workspace/koda_admin/WebContent/common/ckeditor/ckupload/";// fileDir는 전역 변수라 그냥 이미지 경로 설정해주면 된다.
	         String ckUploadPath = path + uid + "_" + fileName;
	         File folder = new File(path);
	         
	         //해당 디렉토리 확인
	         if(!folder.exists()){
	             try{
	                 folder.mkdirs(); // 폴더 생성
	             }catch(Exception e){
	                 e.getStackTrace();
	             }
	         }
	         
	         out = new FileOutputStream(new File(ckUploadPath));
	         out.write(bytes);
	         out.flush(); // outputStram에 저장된 데이터를 전송하고 초기화
	         
	         String callback = request.getParameter("CKEditorFuncNum");
	         printWriter = response.getWriter();
	         String fileUrl = "/mine/ckImgSubmit.do?uid=" + uid + "&fileName=" + fileName;  // 작성화면
	         
	     // 업로드시 메시지 출력
	       printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
	       printWriter.flush();
	         
	     }catch(IOException e){
	         e.printStackTrace();
	     } finally {
	       try {
	        if(out != null) { out.close(); }
	        if(printWriter != null) { printWriter.close(); }
	       } catch(IOException e) { e.printStackTrace(); }
	      }
	     
	     return;
	 } 
 	// ckeditor 파일 본문 적용
 	@RequestMapping(value="/mine/ckImgSubmit.do")
    public void ckSubmit(@RequestParam(value="uid") String uid
                            , @RequestParam(value="fileName") String fileName
                            , HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        
        //서버에 저장된 이미지 경로
        String path = "C:/work/koda/workspace/koda_admin/WebContent/common/ckeditor/ckupload/";
    
        String sDirPath = path + uid + "_" + fileName;
    
        File imgFile = new File(sDirPath);
        
        //사진 이미지 찾지 못하는 경우 예외처리로 빈 이미지 파일을 설정한다.
        if(imgFile.isFile()){
            byte[] buf = new byte[1024];
            int readByte = 0;
            int length = 0;
            byte[] imgBuf = null;
            
            FileInputStream fileInputStream = null;
            ByteArrayOutputStream outputStream = null;
            ServletOutputStream out = null;
            
            try{
                fileInputStream = new FileInputStream(imgFile);
                outputStream = new ByteArrayOutputStream();
                out = response.getOutputStream();
                
                while((readByte = fileInputStream.read(buf)) != -1){
                    outputStream.write(buf, 0, readByte);
                }
                
                imgBuf = outputStream.toByteArray();
                length = imgBuf.length;
                out.write(imgBuf, 0, length);
                out.flush();
                
            }catch(IOException e){
                //logger.info(e);
            }finally {
            	outputStream.close();
                fileInputStream.close();
                out.close();
            }
        }
    }

 	// 권한메뉴관리
 	@RequestMapping("/admin/adminMenu.do")
	public String adminMenu(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
 		
 		if("".equals(commandMap.get("search_auth")) || commandMap.get("search_auth") == null){
 			commandMap.put("search_auth", "0");
 		}
        
 		List<Map<String, Object>> adminMenuList = adminService.adminMenuList(commandMap);
 		model.addAttribute("adminMenuList",adminMenuList);
 		
    	adminService.insertActHist("R", "[권한메뉴관리]목록 조회");
		return "admin/adminMenu";	 	
	}

 	// 권한메뉴변경 
 	@RequestMapping("/admin/adminMenuChange.do")
	@ResponseBody
	public String adminMenuChange(ModelMap model, @RequestParam Map<String, Object> commandMap, HttpServletRequest request) throws Exception{
		
 		//해당권한메뉴 삭제
 		adminService.adminMenuDelete(commandMap);
 		
 		String[] menu1 = request.getParameterValues("menu1");
 		
 		if(menu1 != null && !"".equals(menu1)){ 			
 			commandMap.put("menu_cd", 1);
 			for(int i=0;i<menu1.length;i++){
 				commandMap.put("seq_cd", menu1[i]);
 				adminService.adminMenuChange(commandMap);
 			}
 		}
 		
 		String[] menu2 = request.getParameterValues("menu2");
 		if(menu2 != null && !"".equals(menu2)){
 			commandMap.put("menu_cd", 2);
 			for(int i=0;i<menu2.length;i++){
 				commandMap.put("seq_cd", menu2[i]);
 				adminService.adminMenuChange(commandMap);
 			}
 		}
 		
 		String[] menu3 = request.getParameterValues("menu3");
 		if(menu3 != null && !"".equals(menu3)){
 			commandMap.put("menu_cd", 3);
 			for(int i=0;i<menu3.length;i++){
 				commandMap.put("seq_cd", menu3[i]);
 				adminService.adminMenuChange(commandMap);
 			}
 		}
 		
 		String[] menu4 = request.getParameterValues("menu4");
 		if(menu4 != null && !"".equals(menu4)){
 			commandMap.put("menu_cd", 4);
 			for(int i=0;i<menu4.length;i++){
 				commandMap.put("seq_cd", menu4[i]);
 				adminService.adminMenuChange(commandMap);
 			}
 		}
 		
 		String[] menu5 = request.getParameterValues("menu5");
 		if(menu5 != null && !"".equals(menu5)){
 			commandMap.put("menu_cd", 5);
 			for(int i=0;i<menu5.length;i++){
 				commandMap.put("seq_cd", menu5[i]);
 				adminService.adminMenuChange(commandMap);
 			}
 		}
 		
 		String[] menu6 = request.getParameterValues("menu6");
 		if(menu6 != null && !"".equals(menu6)){
 			commandMap.put("menu_cd", 6);
 			for(int i=0;i<menu6.length;i++){
 				commandMap.put("seq_cd", menu6[i]);
 				adminService.adminMenuChange(commandMap);
 			}
 		}
 		
 		String[] menu7 = request.getParameterValues("menu7");
 		if(menu7 != null && !"".equals(menu7)){
 			commandMap.put("menu_cd", 7);
 			for(int i=0;i<menu7.length;i++){
 				commandMap.put("seq_cd", menu7[i]);
 				adminService.adminMenuChange(commandMap);
 			}
 		}
 		
 		String[] menu8 = request.getParameterValues("menu8");
 		if(menu8 != null && !"".equals(menu8)){
 			commandMap.put("menu_cd", 8);
 			for(int i=0;i<menu8.length;i++){
 				commandMap.put("seq_cd", menu8[i]);
 				adminService.adminMenuChange(commandMap);
 			}
 		}
 		
 		String[] menu9 = request.getParameterValues("menu9");
 		if(menu9 != null && !"".equals(menu9)){
 			commandMap.put("menu_cd", 9);
 			for(int i=0;i<menu9.length;i++){
 				commandMap.put("seq_cd", menu9[i]);
 				adminService.adminMenuChange(commandMap);
 			}
 		}
 		
 		String[] menu10 = request.getParameterValues("menu10");
 		if(menu10 != null && !"".equals(menu10)){
 			commandMap.put("menu_cd", 10);
 			for(int i=0;i<menu10.length;i++){
 				commandMap.put("seq_cd", menu10[i]);
 				adminService.adminMenuChange(commandMap);
 			}
 		}
 		
 		
		String msg = "메뉴저장 완료";
		adminService.insertActHist("U", "[권한메뉴관리]저장 완료");
		

		return msg;	 	
	}
}

        