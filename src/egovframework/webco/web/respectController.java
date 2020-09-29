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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.webco.service.AdminService;
import egovframework.webco.service.RespectService;
import egovframework.webco.service.StatisticsService;
import egovframework.webco.service.WebcoService;
import egovframework.webco.util.CommonUtil;
import egovframework.webco.util.EnumValue;
import egovframework.webco.util.SessionUtil;
import egovframework.webco.vo.AdminVO;
import net.sf.json.JSONObject;

@Controller
public class respectController {

    /** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());

    @Resource(name = "webcoService")
    private WebcoService webcoService;  
    
    @Resource(name = "respectService")
    private RespectService respectService;  
    
    @Resource(name = "adminService")
    private AdminService adminService;
    
	
	//기증자 추모 & 유가족 행사
	@RequestMapping("/respect/familyEvent.do")
	public String familyEvent(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	List<Map<String, Object>> feList = respectService.familyEventList(commandMap);
    	int total_count = respectService.familyEventListTotCnt(commandMap);
    	
    	
    	
    	model.addAttribute("feList_list", feList);
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
    	
    	adminService.insertActHist("L", "[기증자추모&유가족행사]목록 조회");
		return "respect/familyEvent";	 	
	}
	
	// 유가족 행사 수정 form
 	@RequestMapping("/respect/familyEventUpdateForm.do")
	public String familyEventUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		
		Map<String, Object> selectedFamilyEvent = respectService.selectedFamilyEvent(commandMap);
		model.addAttribute("selectedFamilyEvent",selectedFamilyEvent);

    	adminService.insertActHist("L", "[유가족 행사]수정 조회");
		
    	return "respect/familyEventUpdateForm";	 	
	}

 	// 유가족 행사 수정 end
 	@RequestMapping("/respect/familyEventUpdateEnd.do")
	@ResponseBody
	public String familyEventUpdateEnd(ModelMap model, @RequestParam Map<String, Object> commandMap, @RequestParam("fam_evnt_file_org_name") MultipartFile multipartFile, HttpServletRequest request) throws Exception{
		
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
			
			commandMap.put("fam_evnt_file_org_name", originFilename);
			commandMap.put("fam_evnt_file_name", saveFileName);
			
			writeFile(multipartFile, saveFileName, request);
									
			}
			
			if("fam_evnt_update".equals(commandMap.get("type"))){
				//family_event 테이블 수정
				respectService.familyEventUpdateEnd(commandMap);
				msg = "수정 완료";
			}else if("fam_evnt_insert".equals(commandMap.get("type"))){
				//schedule 테이블 insert
				endIdx = respectService.familyEventEndIdx();				
				commandMap.put("fam_evnt_idx", endIdx+1);				
				respectService.familyEventInsertEnd(commandMap);
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
 	private boolean writeFile(MultipartFile multipartFile, String saveFileName, HttpServletRequest request)throws IOException{
 		boolean result = false;
 		String path=request.getServletContext().getRealPath("/upFile"); 		
 		byte[] data = multipartFile.getBytes();
 		FileOutputStream fos = new FileOutputStream(path + "/" + saveFileName);
 		fos.write(data);
 		fos.close();
 		
 		return result;
 	}

 	// 유가족 행사 contents 수정 end
 	@RequestMapping("/respect/familyEventContentsUpdateEnd.do")
	public String familyEventContentsUpdateEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{		
 		
 		respectService.familyEventContentsUpdateEnd(commandMap);
		
    	return "redirect:/respect/familyEvent.do";	 	
	}

 	// 유가족 행사 삭제 end
 	@RequestMapping("/respect/familyEventDeleteEnd.do")
	@ResponseBody
	public String familyEventDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
 		respectService.familyEventDeleteEnd(commandMap);
		
		String msg = "삭제 완료";
		adminService.insertActHist("L", "[유가족 행사]삭제 완료");
		
    	return msg;	 	
	}

 	// 유가족 행사 등록 form
 	@RequestMapping("/respect/familyEventWriteForm.do")
	public String familyEventWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{

    	adminService.insertActHist("L", "[유가족 행사]등록 조회");
		
    	return "respect/familyEventWriteForm";	 	
	}

 	// 유가족 행사 등록 end
 	@RequestMapping("/respect/familyEventInsertEnd.do")
	@ResponseBody
	public String familyEventInsertEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int endIdx = respectService.familyEventEndIdx();		
		commandMap.put("fam_evnt_idx", endIdx+1);
 		
 		respectService.familyEventInsertEnd(commandMap);
		
		String msg = "등록 완료";
		adminService.insertActHist("L", "[유가족 행사]등록 완료");
		
    	return msg;	 	
	}
}

        