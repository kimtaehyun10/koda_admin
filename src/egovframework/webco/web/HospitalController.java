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
import egovframework.webco.service.HospitalService;
import egovframework.webco.service.RespectService;
import egovframework.webco.service.StatisticsService;
import egovframework.webco.service.WebcoService;
import egovframework.webco.util.CommonUtil;
import egovframework.webco.util.EnumValue;
import egovframework.webco.util.SessionUtil;
import egovframework.webco.vo.AdminVO;
import net.sf.json.JSONObject;

@Controller
public class HospitalController {

    /** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());

    @Resource(name = "webcoService")
    private WebcoService webcoService;  
    
    @Resource(name = "hospitalService")
    private HospitalService hospitalService;  
    
    @Resource(name = "adminService")
    private AdminService adminService;
    
	
	//뇌사관리 협약병원
	@RequestMapping("/hospital/medicalInstitution.do")
	public String medicalInstitution(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	commandMap.put("hospital_type", "H"); //뇌사관리 협약병원 구분
    	
    	List<Map<String, Object>> hspList = hospitalService.hospitalList(commandMap);
    	int total_count = hospitalService.hospitalListTotCnt(commandMap);
    	
    	model.addAttribute("hspList_list", hspList);
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
    	
    	adminService.insertActHist("L", "[뇌사관리 협약병원]목록 조회");
		return "hospital/medicalInstitution";	 	
	}

	//DIP 협약병원
	@RequestMapping("/hospital/dipConvention.do")
	public String dipConvention(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	commandMap.put("hospital_type", "D"); //DIP 협약병원 구분
    	
    	List<Map<String, Object>> hspList = hospitalService.hospitalList(commandMap);
    	int total_count = hospitalService.hospitalListTotCnt(commandMap);
    	
    	model.addAttribute("hspList_list", hspList);
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
    	
    	adminService.insertActHist("L", "[DIP 협약병원]목록 조회");
		return "hospital/dipConvention";	 	
	}

	//병원전체목록
	@RequestMapping("/hospital/allHospital.do")
	public String allHospital(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	List<Map<String, Object>> hspList = hospitalService.hospitalList(commandMap);
    	int total_count = hospitalService.hospitalListTotCnt(commandMap);
    	
    	model.addAttribute("hspList_list", hspList);
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
    	
    	adminService.insertActHist("L", "[병원전체목록]목록 조회");
		return "hospital/allHospital";	 	
	}

	//검사실 협약병원
	@RequestMapping("/hospital/examination.do")
	public String examination(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	commandMap.put("hospital_type", "E"); //DIP 협약병원 구분
    	
    	List<Map<String, Object>> hspList = hospitalService.hospitalList(commandMap);
    	int total_count = hospitalService.hospitalListTotCnt(commandMap);
    	
    	model.addAttribute("hspList_list", hspList);
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
    	
    	adminService.insertActHist("R", "[검사실 협약병원]목록 조회");
		return "hospital/examination";	 	
	}
	// 병원 수정 popup
	@RequestMapping("/hospital/hospitalUpdatePopup.p")
	public String hospitalUpdatePopup(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
	
		Map<String, Object> selectedHospital = hospitalService.selectedHospital(commandMap);
    	model.addAttribute("selectedHospital",selectedHospital);
    	model.addAttribute("param",commandMap);
    	
    	if("H".equals(selectedHospital.get("hospital_type"))){
    		adminService.insertActHist("L", "[뇌사관리 협약병원]수정 조회");
    	}else if("D".equals(selectedHospital.get("hospital_type"))){
    		adminService.insertActHist("L", "[DIP 협약병원]수정 조회");
    	}
		
    	return "hospital/popup/hospitalUpdatePopup";	 	
	}
	
	// 병원 수정 end
	@RequestMapping("/hospital/hospitalUpdateEnd.do")
	@ResponseBody
	public String hospitalUpdateEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		hospitalService.hospitalUpdateEnd(commandMap);    	    	
    	String msg = "수정 완료";
    	
    	if("H".equals(commandMap.get("hospital_type"))){
    		adminService.insertActHist("L", "[뇌사관리 협약병원]수정 완료");
    	}else if("D".equals(commandMap.get("hospital_type"))){
    		adminService.insertActHist("L", "[DIP협약병원]수정 완료");
    	}
		
    	return msg;	 	
	}

	// 병원 삭제 end
	@RequestMapping("/hospital/hospitalDeleteEnd.do")
	@ResponseBody
	public String hospitalDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		hospitalService.hospitalDeleteEnd(commandMap);    	    	
    	String msg = "삭제 완료";
    	
    	if("H".equals(commandMap.get("hospital_type"))){
    		adminService.insertActHist("L", "[뇌사관리 협약병원]삭제 완료");
    	}else if("D".equals(commandMap.get("hospital_type"))){
    		adminService.insertActHist("L", "[DIP협약병원]삭제 완료");
    	}
		
    	return msg;	 	
	}

	// 병원 등록 popup
	@RequestMapping("/hospital/hospitalWritePopup.p")
	public String hospitalWritePopup(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
    	
    	if("H".equals(commandMap.get("hospital_type"))){
    		adminService.insertActHist("L", "[뇌사관리 협약병원]등록 조회");
    	}else if("D".equals(commandMap.get("hospital_type"))){
    		adminService.insertActHist("L", "[DIP 협약병원]등록 조회");
    	}
		model.addAttribute("hospital_type",commandMap.get("hospital_type"));
    	return "hospital/popup/hospitalWritePopup";	 	
	}
	
	// 병원 등록 end
	@RequestMapping("/hospital/hospitalWriteEnd.do")
	@ResponseBody
	public String hospitalWriteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{				
		
		hospitalService.hospitalWriteEnd(commandMap);    	    	
    	
		String msg = "등록 완료";
    	
    	if("H".equals(commandMap.get("hospital_type"))){
    		adminService.insertActHist("L", "[뇌사관리 협약병원]등록 완료");
    	}else if("D".equals(commandMap.get("hospital_type"))){
    		adminService.insertActHist("L", "[DIP협약병원]등록 완료");
    	}
		
    	return msg;	 	
	}
}

        