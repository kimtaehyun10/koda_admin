package egovframework.webco.service.impl;

import egovframework.webco.service.RespectService;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.webco.dao.WebcoDefaultDAO;
import egovframework.webco.service.StatisticsService;
import egovframework.webco.util.CommonUtil;
import egovframework.webco.util.EnumValue;

@Service("respectService")
public class RespectServiceImpl implements RespectService {

	/** webcoDAO */
    @Resource(name="webcoDAO")
    private WebcoDefaultDAO webcoDAO;    	
	
	/** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());

	@Override
	public List<Map<String, Object>> familyEventList(
			Map<String, Object> commandMap) {
		
		return webcoDAO.familyEventList("UserDAO.familyEventList",commandMap);
	}

	@Override
	public int familyEventListTotCnt(Map<String, Object> commandMap) {

		return webcoDAO.familyEventListTotCnt("UserDAO.familyEventListTotCnt",commandMap);
	}
	
	@Override
	public Map<String, Object> selectedFamilyEvent(
			Map<String, Object> commandMap) {

		return webcoDAO.selectedFamilyEvent("UserDAO.selectedFamilyEvent",commandMap);
	}

	@Override
	public void familyEventUpdateEnd(Map<String, Object> commandMap) {

		webcoDAO.familyEventUpdateEnd("UserDAO.familyEventUpdateEnd",commandMap);
	}

	@Override
	public void familyEventContentsUpdateEnd(Map<String, Object> commandMap) {
		
		webcoDAO.familyEventContentsUpdateEnd("UserDAO.familyEventContentsUpdateEnd",commandMap);
	}

	@Override
	public void familyEventDeleteEnd(Map<String, Object> commandMap) {

		webcoDAO.familyEventDeleteEnd("UserDAO.familyEventDeleteEnd",commandMap);
	}

	@Override
	public void familyEventInsertEnd(Map<String, Object> commandMap) {
		
		webcoDAO.familyEventInsertEnd("UserDAO.familyEventInsertEnd",commandMap);
	}

	@Override
	public int familyEventEndIdx() {

		return webcoDAO.familyEventEndIdx("UserDAO.familyEventEndIdx");
	}
}
