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
import egovframework.webco.service.StatisticsService;
import egovframework.webco.service.WebcoService;
import egovframework.webco.util.CommonUtil;
import egovframework.webco.util.EnumValue;
import egovframework.webco.util.SessionUtil;
import egovframework.webco.vo.AdminVO;
import net.sf.json.JSONObject;

@Controller
public class StatisticsController {

    /** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());

    @Resource(name = "webcoService")
    private WebcoService webcoService;  
    
    @Resource(name = "statisticsService")
    private StatisticsService statisticsService;  
    
    @Resource(name = "adminService")
    private AdminService adminService;
    
    @Resource(name = "notificationService")
    private NotificationService notificationService;
    /**
     * 대시보드 화면
     * @return String
     * @exception Exception
     */
	@RequestMapping("/statistics/dashboard.do")
	public String dashboard(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{	    
    	
		Map<String, Object> rtnMap = statisticsService.getDashboard(commandMap);
        
        model.addAttribute("dashboard_column_chart_1_data",     CommonUtil.getArrayListToJSONArray(rtnMap.get("dashboard_column_chart_1_data")));
        model.addAttribute("dashboard_column_chart_2_data",     CommonUtil.getArrayListToJSONArray(rtnMap.get("dashboard_column_chart_2_data")));
        model.addAttribute("today_visit_count",     			rtnMap.get("today_visit_count"));
        model.addAttribute("today_pledge_count",    			rtnMap.get("today_pledge_count"));
        model.addAttribute("week_visit_count",     				rtnMap.get("week_visit_count"));
        model.addAttribute("week_pledge_count",     			rtnMap.get("week_pledge_count"));
        model.addAttribute("week_pledge_visit_rate",     		rtnMap.get("week_pledge_visit_rate"));
        model.addAttribute("month_visit_count",     			rtnMap.get("month_visit_count"));
        model.addAttribute("month_pledge_count",     			rtnMap.get("month_pledge_count"));
        model.addAttribute("month_pledge_visit_rate",     		rtnMap.get("month_pledge_visit_rate"));
        model.addAttribute("total_visit_count",     			rtnMap.get("total_visit_count"));
        model.addAttribute("total_pledge_count",     			rtnMap.get("total_pledge_count"));
        	        
        return "statistics/dashboard";	    
	}     
	
	 /**
     * 상세조회 화면
     * @return String
     * @exception Exception
     */
	@RequestMapping("/statistics/showDetail.do")
	public String showDetail(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		EnumValue enumValue = new EnumValue();    	
    	model.addAttribute("enum_array", CommonUtil.getObjectToJSONObject(enumValue.getEnumArray()));
		return "statistics/showDetail";	 	
	}
	
	/**
     *  기간별 통계분석 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/statistics/getVisitPeriodAjax.do")
	public @ResponseBody JSONObject getVisitPeriodAjax(ModelMap model, 				
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{		
		
		Map<String, Object> rtnMap = statisticsService.getVisitPeriod(commandMap);				
		
		rtnMap.put("search_value", commandMap);
		rtnMap.put("rtnCode", "");
    	rtnMap.put("rtnMsg", "");
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	
	/**
     *  유입채널별 통계분석 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/statistics/getChannelAjax.do")
	public @ResponseBody JSONObject getChannelAjax(ModelMap model, 				
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{		
		
		Map<String, Object> rtnMap = statisticsService.getChannel(commandMap);			
		rtnMap.put("search_value", commandMap);
		rtnMap.put("rtnCode", "");
    	rtnMap.put("rtnMsg", "");    	
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	
	/**
     *  성별/연령별 통계분석 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/statistics/getSexAgeAjax.do")
	public @ResponseBody JSONObject getSexAgeAjax(ModelMap model, 				
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{		
		
		Map<String, Object> rtnMap = statisticsService.getSexAge(commandMap);			
		rtnMap.put("search_value", commandMap);
		rtnMap.put("rtnCode", "");
    	rtnMap.put("rtnMsg", "");
    	
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	/**
     *  등록구분별 통계분석 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/statistics/getRecognizeTypeAjax.do")
	public @ResponseBody JSONObject getRecognizeTypeAjax(ModelMap model, 				
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{		
		// 등록구분별 코딩 시작하자
		Map<String, Object> rtnMap = statisticsService.getRecognizeTypeAjax(commandMap);			
		rtnMap.put("search_value", commandMap);
		rtnMap.put("rtnCode", "");
    	rtnMap.put("rtnMsg", "");
    	
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}

	/**
     *  페이지 뷰 통계분석 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/statistics/getPageViewAjax.do")
	public @ResponseBody JSONObject getPageViewAjax(ModelMap model, 				
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{		
		// 페이지 뷰 코딩 시작하자
		Map<String, Object> rtnMap = statisticsService.getPageView(commandMap);			
		rtnMap.put("search_value", commandMap);
		rtnMap.put("rtnCode", "");
    	rtnMap.put("rtnMsg", "");
    	
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	/**
     *  탈퇴자 통계분석 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/statistics/getWithdrawAjax.do")
	public @ResponseBody JSONObject getWithdrawAjax(ModelMap model, 				
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{		
		
		Map<String, Object> rtnMap = statisticsService.getWithdraw(commandMap);		
		
		rtnMap.put("search_value", commandMap);
		rtnMap.put("rtnCode", "");
    	rtnMap.put("rtnMsg", "");
    	
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	
	/**
     *  기간별 통계분석 엑셀파일 생성 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/statistics/exportExcelVisitPeriodAjax.do")
	public @ResponseBody JSONObject exportExcelVisitPeriodAjax(ModelMap model, 				
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{		
		
		Map<String, Object> rtnMap = new HashMap<String, Object>(); 
				
		try {
			Map<String, Object> dataMap = statisticsService.getVisitPeriod(commandMap);
			
			Map<String, Object> exportMap = new HashMap<String, Object>();
			List<String[]> title_data_list = new ArrayList<String[]>();
			List<Object> data_list = new ArrayList<Object>();
			exportMap.put("title", "기간별 통계분석");		
			String[] title_data = {"날짜", "방문인원", "서약인원"};
			title_data_list.add(title_data);
			data_list.add(dataMap.get("data_list_data_array"));
			exportMap.put("title_data_list", title_data_list);
			exportMap.put("data_list", data_list);
			boolean result = statisticsService.exportExcel(exportMap);
			
			rtnMap.put("search_value", commandMap);
			if(result) {
				rtnMap.put("rtnCode", "");
				rtnMap.put("rtnMsg", "");
			} else {
				rtnMap.put("rtnCode", "-1");
		    	rtnMap.put("rtnMsg", "엑셀파일 생성에 실패하였습니다.");
			}
		} catch (Exception e) {
			rtnMap.put("rtnCode", "-2");
	    	rtnMap.put("rtnMsg", e.toString());
	    	log.error(e.toString());
		}
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	
	/**
     *  유입채널별 통계분석 엑셀파일 생성 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/statistics/exportExcelChannelAjax.do")
	public @ResponseBody JSONObject exportExcelChannelAjax(ModelMap model, 				
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{		
		
		Map<String, Object> rtnMap = new HashMap<String, Object>(); 
		
		try {
			Map<String, Object> dataMap = statisticsService.getChannel(commandMap);
			
			Map<String, Object> exportMap = new HashMap<String, Object>();
			List<String[]> title_data_list = new ArrayList<String[]>();
			List<Object> data_list = new ArrayList<Object>();
			exportMap.put("title", "유입채널별");		
			String[] title_data = {"날짜", "온라인인원", "온라인인원비율", "오프라인인원", "오프라인인원비율", "SYRUP인원", "SYRUP인원비율"};
			title_data_list.add(title_data);
			data_list.add(dataMap.get("data_list_data_array"));
			exportMap.put("title_data_list", title_data_list);
			exportMap.put("data_list", data_list);
			boolean result = statisticsService.exportExcel(exportMap);
			
			rtnMap.put("search_value", commandMap);
			if(result) {
				rtnMap.put("rtnCode", "");
				rtnMap.put("rtnMsg", "");
			} else {
				rtnMap.put("rtnCode", "-1");
		    	rtnMap.put("rtnMsg", "엑셀파일 생성에 실패하였습니다.");
			}
		} catch (Exception e) {
			rtnMap.put("rtnCode", "-2");
	    	rtnMap.put("rtnMsg", e.toString());
	    	log.error(e.toString());
		}		
		rtnMap.put("search_value", commandMap);
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	
	/**
     *  성별/연령별 통계분석 엑셀파일 생성 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/statistics/exportExcelSexAgeAjax.do")
	public @ResponseBody JSONObject exportExcelSexAgeAjax(ModelMap model, 				
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{		
				
		Map<String, Object> rtnMap = new HashMap<String, Object>(); 
		
		try {
			Map<String, Object> dataMap = statisticsService.getSexAge(commandMap);
			
			Map<String, Object> exportMap = new HashMap<String, Object>();
			List<String[]> title_data_list = new ArrayList<String[]>();
			List<Object> data_list = new ArrayList<Object>();
			exportMap.put("title", "성별연령별 분포");		
			String[] title_data = {"날짜", "남성인원", "남성인원비율", "여성인원", "여성인원비율"};
			title_data_list.add(title_data);
			String[] title_data2 = {"연령구간", "남성인원", "여성인원", "총인원", "총인원비율"};
			title_data_list.add(title_data2);
			data_list.add(dataMap.get("data_list_data_array"));
			data_list.add(dataMap.get("chart_data_array"));
			exportMap.put("title_data_list", title_data_list);
			exportMap.put("data_list", data_list);
			boolean result = statisticsService.exportExcel(exportMap);
			
			rtnMap.put("search_value", commandMap);
			if(result) {
				rtnMap.put("rtnCode", "");
				rtnMap.put("rtnMsg", "");
			} else {
				rtnMap.put("rtnCode", "-1");
		    	rtnMap.put("rtnMsg", "엑셀파일 생성에 실패하였습니다.");
			}
		} catch (Exception e) {
			rtnMap.put("rtnCode", "-2");
	    	rtnMap.put("rtnMsg", e.toString());
	    	log.error(e.toString());
		}		
		rtnMap.put("search_value", commandMap);
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	
	/**
     *  탈퇴자 통계분석 엑셀파일 생성 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/statistics/exportExcelWithdrawAjax.do")
	public @ResponseBody JSONObject exportExcelWithdrawAjax(ModelMap model, 				
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{		
				
		Map<String, Object> rtnMap = new HashMap<String, Object>(); 
		
		try {
			Map<String, Object> dataMap = statisticsService.getWithdraw(commandMap);
			
			Map<String, Object> exportMap = new HashMap<String, Object>();
			List<String[]> title_data_list = new ArrayList<String[]>();
			List<Object> data_list = new ArrayList<Object>();
			exportMap.put("title", "탈퇴자 통계분석");		
			String[] title_data = {"날짜", "마음이바뀜인원", "마음이바뀜비율", "가족반대인원", "가족반대비율", "타기관서약인원", "타기관서약비율", "기타인원", "기타비율"};
			title_data_list.add(title_data);
			data_list.add(dataMap.get("data_list_data_array"));
			exportMap.put("title_data_list", title_data_list);
			exportMap.put("data_list", data_list);
			boolean result = statisticsService.exportExcel(exportMap);
			
			rtnMap.put("search_value", commandMap);
			if(result) {
				rtnMap.put("rtnCode", "");
				rtnMap.put("rtnMsg", "");
			} else {
				rtnMap.put("rtnCode", "-1");
		    	rtnMap.put("rtnMsg", "엑셀파일 생성에 실패하였습니다.");
			}
		} catch (Exception e) {
			rtnMap.put("rtnCode", "-2");
	    	rtnMap.put("rtnMsg", e.toString());
	    	log.error(e.toString());
		}		
		rtnMap.put("search_value", commandMap);
		return CommonUtil.getObjectToJSONObject(rtnMap);		
	}
	
	/**
     *  등록구분별 통계분석 엑셀파일 생성 Ajax
     * @return JSONObject
     * @exception Exception
     */
	@RequestMapping("/statistics/exportExcelRecognizeTypeAjax.do")
	public @ResponseBody JSONObject exportExcelRecognizeTypeAjax(ModelMap model, 				
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{		
		
		Map<String, Object> rtnMap = new HashMap<String, Object>(); 
		
		try {
			Map<String, Object> dataMap = statisticsService.getRecognizeTypeAjax(commandMap);
			
			Map<String, Object> exportMap = new HashMap<String, Object>();
			List<String[]> title_data_list = new ArrayList<String[]>();
			List<Object> data_list = new ArrayList<Object>();
			exportMap.put("title", "등록구분별");		
			String[] title_data = {"날짜", "서약자인원", "서약자인원비율", "탈퇴자", "탈퇴자인원비율", "등록보류자", "등록보류자비율", "사망자", "사망자비율", "중복", "중복비율", "타기관", "타기관비율"};
			title_data_list.add(title_data);
			data_list.add(dataMap.get("data_list_data_array"));
			exportMap.put("title_data_list", title_data_list);
			exportMap.put("data_list", data_list);
			boolean result = statisticsService.exportExcel(exportMap);
			
			rtnMap.put("search_value", commandMap);
			if(result) {
				rtnMap.put("rtnCode", "");
				rtnMap.put("rtnMsg", "");
			} else {
				rtnMap.put("rtnCode", "-1");
		    	rtnMap.put("rtnMsg", "엑셀파일 생성에 실패하였습니다.");
			}
		} catch (Exception e) {
			rtnMap.put("rtnCode", "-2");
	    	rtnMap.put("rtnMsg", e.toString());
	    	log.error(e.toString());
		}		
		rtnMap.put("search_value", commandMap);
		return CommonUtil.getObjectToJSONObject(rtnMap);
	}
	
	//기증희망통계  
	@RequestMapping("/statistics/hopeDonateStats.do")
	public String hopeDonateStats(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	List<Map<String, Object>> hdsList = statisticsService.hopeDonateStatsList(commandMap);
    	int total_count = statisticsService.hopeDonateStatsListTotCnt(commandMap);
    	
    	
    	
    	model.addAttribute("hdsList_list", hdsList);
    	model.addAttribute("total_count", total_count);
    	
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
    	
    	adminService.insertActHist("L", "[기증희망]목록 조회");
		
		return "statistics/hopeDonateStats";	 	
	}
	
	//기증자 통계
	@RequestMapping("/statistics/brainDonateStats.do")
	public String brainDonateStats(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	List<Map<String, Object>> bdsList = statisticsService.brainDonateStatsList(commandMap);
    	int total_count = statisticsService.brainDonateStatsListTotCnt(commandMap);
    	
    	
    	
    	model.addAttribute("bdsList_list", bdsList);
    	model.addAttribute("total_count", total_count);
    	
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
    	
    	adminService.insertActHist("L", "[기증자]목록 조회");
		return "statistics/brainDonateStats";	 	
	}
	
	//이식현황
	@RequestMapping("/statistics/organDonateStats.do")
	public String organDonateStats(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	List<Map<String, Object>> odsList = statisticsService.organDonateStatsList(commandMap);
    	int total_count = statisticsService.organDonateStatsListTotCnt(commandMap);
    	
    	
    	
    	model.addAttribute("odsList_list", odsList);
    	model.addAttribute("total_count", total_count);
    	
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
    	
    	//이식현황 통계자료
		String brd_no = "8"; //게시판 번호
		commandMap.put("brd_no", brd_no);
    	Map<String, Object> file = adminService.selectedFile(commandMap);
    	model.addAttribute("file",file);
    	
    	adminService.insertActHist("L", "[이식현황]목록 조회");
		return "statistics/organDonateStats";	 	
	}
	
	//연도별 기증 추이
	@RequestMapping("/statistics/donateStatsTrend.do")
	public String donateStatsTrend(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	List<Map<String, Object>> dstList = statisticsService.donateStatsTrendList(commandMap);
    	int total_count = statisticsService.donateStatsTrendListTotCnt(commandMap);
    	
    	
    	
    	model.addAttribute("dstList_list", dstList);
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
    	
    	adminService.insertActHist("L", "[연도별 기증 추이]목록 조회");
		return "statistics/donateStatsTrend";	 	
	}
	
	//5년간 기증 실적 비교
	@RequestMapping("/statistics/comparison.do")
	public String comparison(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
			
		int limit = 10;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
		int offset = page > 0 ? (page-1) * limit : 0;
				    	
		commandMap.put("offset", offset);
		commandMap.put("limit", limit);
		
		commandMap.put("brd_no", "35"); //5년간 기증 실적 비교 구분
		
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
		
		adminService.insertActHist("L", "[5년간 기증 실적 비교]목록 조회");
		
		return "statistics/comparison";	 	
	}
	
	// 기증자통계 수정 form
	@RequestMapping("/statistics/brainDonateStatsUpdateForm.p")
	public String brainDonateStatsUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
    	
    	Map<String, Object> selectedBrain = statisticsService.selectedBrain(commandMap); 	
    	model.addAttribute("selectedBrain", selectedBrain);
    	    	    	
    	AdminVO adminVO = SessionUtil.getAuthenticatedUser();    	
    	model.addAttribute("admin_grade", adminVO.getAdmin_grade());
    	model.addAttribute("param", commandMap);
    	
    	adminService.insertActHist("L", "[뇌사기증자 통계]수정 조회");
		return "statistics/popup/brainDonateStatsUpdateForm";	 	
	}

	// 기증자통계 수정 end
	@RequestMapping("/statistics/brainDonateStatsUpdateEnd.do")
	@ResponseBody
	public String brainDonateStatsUpdateEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.brainDonateStatsUpdateEnd(commandMap);    	    	
		String msg = "수정 완료";
		adminService.insertActHist("L", "[뇌사기증자 통계]수정 완료");
		
    	return msg;	 	
	}

	// 기증자통계 삭제 end
	@RequestMapping("/statistics/brainDonateStatsDeleteEnd.do")
	@ResponseBody
	public String brainDonateStatsDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.brainDonateStatsDeleteEnd(commandMap);    	    	
		String msg = "삭제 완료";
		adminService.insertActHist("L", "[뇌사기증자 통계]삭제 완료");
		
    	return msg;	 	
	}

	// 기증자통계 등록 form
	@RequestMapping("/statistics/brainDonateStatsWriteForm.p")
	public String brainDonateStatsWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
    	    	    	
    	AdminVO adminVO = SessionUtil.getAuthenticatedUser();    	
    	model.addAttribute("admin_grade", adminVO.getAdmin_grade());
    	model.addAttribute("param", commandMap);
    	
    	adminService.insertActHist("L", "[뇌사기증자 통계]등록 조회");
		return "statistics/popup/brainDonateStatsWriteForm";	 	
	}

	//기증자통계 등록 end
	@RequestMapping("/statistics/brainDonateStatsWriteEnd.do")
	@ResponseBody
	public String brainDonateStatsWriteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int endIdx = statisticsService.brainDonateStatsEndIdx();		
		commandMap.put("stats_idx", endIdx+1);
		
		statisticsService.brainDonateStatsWriteEnd(commandMap);    	    	
		String msg = "등록 완료";
		adminService.insertActHist("L", "[뇌사기증자 통계]등록 완료");
		
    	return msg;	 	
	}

	// 이식현황 통계 수정 form
	@RequestMapping("/statistics/organDonateStatsUpdateForm.p")
	public String organDonateStatsUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		    	
    	Map<String, Object> selectedOrgan = statisticsService.selectedOrgan(commandMap); 	
    	model.addAttribute("selectedOrgan", selectedOrgan);
    	    	    	
    	AdminVO adminVO = SessionUtil.getAuthenticatedUser();    	
    	model.addAttribute("admin_grade", adminVO.getAdmin_grade());
    	model.addAttribute("param", commandMap);
    	
    	adminService.insertActHist("L", "[이식현황 통계]수정 조회");
		return "statistics/popup/organDonateStatsUpdateForm";	 	
	}

	// 이식현황 통계 수정 end
	@RequestMapping("/statistics/organDonateStatsUpdateEnd.do")
	@ResponseBody
	public String organDonateStatsUpdateEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.organDonateStatsUpdateEnd(commandMap);    	    	
		String msg = "수정 완료";
		adminService.insertActHist("L", "[이식현황 통계]수정 완료");
		
    	return msg;	 	
	}

	// 이식현황 통계 삭제 end
	@RequestMapping("/statistics/organDonateStatsDeleteEnd.do")
	@ResponseBody
	public String organDonateStatsDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.organDonateStatsDeleteEnd(commandMap);    	    	
		String msg = "삭제 완료";
		adminService.insertActHist("L", "[이식현황 통계]삭제 완료");
		
    	return msg;	 	
	}

	// 이식현황 통계 등록 form
	@RequestMapping("/statistics/organDonateStatsWriteForm.p")
	public String organDonateStatsWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
    	    	    	
    	AdminVO adminVO = SessionUtil.getAuthenticatedUser();    	
    	model.addAttribute("admin_grade", adminVO.getAdmin_grade());
    	model.addAttribute("param", commandMap);
    	
    	adminService.insertActHist("L", "[이식현황 통계]등록 조회");
		return "statistics/popup/organDonateStatsWriteForm";	 	
	}

	// 이식현황 통계 등록 end
	@RequestMapping("/statistics/organDonateStatsWriteEnd.do")
	@ResponseBody
	public String organDonateStatsWriteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		int endIdx = statisticsService.organDonateStatsEndIdx(); 		
		commandMap.put("stats_idx", endIdx+1);
		
		statisticsService.organDonateStatsWriteEnd(commandMap);    	    	
		String msg = "등록 완료";
		adminService.insertActHist("L", "[이식현황 통계]등록 완료");
		
    	return msg;	 	
	}

	// 기증희망 통계 수정 form
	@RequestMapping("/statistics/hopeDonateStatsUpdateForm.p")
	public String hopeDonateStatsUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		    	
		Map<String, Object> selectedHope = statisticsService.selectedHope(commandMap); 	
    	model.addAttribute("selectedHope", selectedHope);
    	
    	adminService.insertActHist("L", "[기증희망 통계]수정 조회");
		return "statistics/popup/hopeDonateStatsUpdateForm";	 	
	}

	// 기증희망 통계 수정 end
	@RequestMapping("/statistics/hopeDonateStatsUpdateEnd.do")
	@ResponseBody
	public String hopeDonateStatsUpdateEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.hopeDonateStatsUpdateEnd(commandMap);    	    	
		String msg = "수정 완료";
		adminService.insertActHist("L", "[기증희망 통계]수정 완료");
		
    	return msg;	 	
	}

	// 기증희망 통계 삭제 end
	@RequestMapping("/statistics/hopeDonateStatsDeleteEnd.do")
	@ResponseBody
	public String hopeDonateStatsDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.hopeDonateStatsDeleteEnd(commandMap);    	    	
		String msg = "삭제 완료";
		adminService.insertActHist("L", "[기증희망 통계]삭제 완료");
		
    	return msg;	 	
	}

	// 기증희망 통계 등록 form
	@RequestMapping("/statistics/hopeDonateStatsWriteForm.p")
	public String hopeDonateStatsWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{    	    	    	
    	
    	adminService.insertActHist("L", "[기증희망 통계]등록 조회");
		return "statistics/popup/hopeDonateStatsWriteForm";	 	
	}

	// 기증희망 통계 등록 end
	@RequestMapping("/statistics/hopeDonateStatsWriteEnd.do")
	@ResponseBody
	public String hopeDonateStatsWriteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
				
		int endIdx = statisticsService.hopeDonateStatsEndIdx(); 	
		commandMap.put("stats_idx", endIdx+1);

		statisticsService.hopeDonateStatsWriteEnd(commandMap);    	    	
		String msg = "등록 완료";
		adminService.insertActHist("L", "[기증희망 통계]등록 완료");
		
    	return msg;	 	
	}

	// 5년간 기증 실적 비교 수정 form
	@RequestMapping("/statistics/comparisonUpdateForm.p")
	public String comparisonUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		    	
		Map<String, Object> selectedBoard = statisticsService.selectedBoard(commandMap); 	
    	model.addAttribute("selectedBoard", selectedBoard);
    	
    	adminService.insertActHist("L", "[5년간 기증 실적 비교]수정 조회");
		return "statistics/popup/comparisonUpdateForm";	 	
	}

	// 5년간 기증 실적 비교 삭제 end
	@RequestMapping("/statistics/comparisonDeleteEnd.do")
	@ResponseBody
	public String comparisonDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.boardDeleteEnd(commandMap); //board_cont 삭제
		statisticsService.boardFileDeleteEnd(commandMap); //board_file 삭제
		String msg = "삭제 완료";
		adminService.insertActHist("L", "[5년간 기증 실적 비교]삭제 완료");
		
    	return msg;	 	
	}

	// 5년간 기증 실적 비교 등록 form
	@RequestMapping("/statistics/comparisonWriteForm.p")
	public String comparisonWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{    	    	    	
    	
    	adminService.insertActHist("L", "[5년간 기증 실적 비교]등록 조회");
		return "statistics/popup/comparisonWriteForm";	 	
	}

	// 연도별 기증 추이 수정 form
	@RequestMapping("/statistics/donateStatsTrendUpdateForm.p")
	public String donateStatsTrendUpdateForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		    	
		Map<String, Object> selectedTrend = statisticsService.selectedTrend(commandMap); 	
    	model.addAttribute("selectedTrend", selectedTrend);
    	
    	adminService.insertActHist("L", "[연도별 기증 추이]수정 조회");
		return "statistics/popup/donateStatsTrendUpdateForm";	 	
	}

	// 연도별 기증 추이 수정 end
	@RequestMapping("/statistics/donateStatsTrendUpdateEnd.do")
	@ResponseBody
	public String donateStatsTrendUpdateEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.donateStatsTrendUpdateEnd(commandMap);    	    	
		String msg = "수정 완료";
		adminService.insertActHist("L", "[연도별 기증 추이]수정 완료");
		
    	return msg;	 	
	}

	// 연도별 기증 추이 삭제 end
	@RequestMapping("/statistics/donateStatsTrendDeleteEnd.do")
	@ResponseBody
	public String donateStatsTrendDeleteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{
		
		statisticsService.donateStatsTrendDeleteEnd(commandMap);
		String msg = "삭제 완료";
		adminService.insertActHist("L", "[연도별 기증 추이]삭제 완료");
		
    	return msg;	 	
	}

	// 연도별 기증 추이 등록 form
	@RequestMapping("/statistics/donateStatsTrendWriteForm.p")
	public String donateStatsTrendWriteForm(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{    	    	    	
    	
    	adminService.insertActHist("L", "[연도별 기증 추이]등록 조회");
		return "statistics/popup/donateStatsTrendWriteForm";	 	
	}

	// 연도별 기증 추이 등록 end
	@RequestMapping("/statistics/donateStatsTrendWriteEnd.do")
	@ResponseBody
	public String donateStatsTrendWriteEnd(ModelMap model, @RequestParam Map<String, Object> commandMap) throws Exception{

		int endIdx = statisticsService.donateStatsTrendEndIdx();
		commandMap.put("trend_idx", endIdx+1);
		
		statisticsService.donateStatsTrendWriteEnd(commandMap);    	    	
		String msg = "등록 완료";
		adminService.insertActHist("L", "[연도별 기증 추이]등록 완료");
		
    	return msg;	 	
	}
}

        