package egovframework.webco.service.impl;

import egovframework.webco.service.NotificationService;

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

@Service("notificationService")
public class NotificationServiceImpl implements NotificationService {

	/** webcoDAO */
    @Resource(name="webcoDAO")
    private WebcoDefaultDAO webcoDAO;    	
	
	/** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());

	@Override
	public List<Map<String, Object>> notificationList(
			Map<String, Object> commandMap) {

		return webcoDAO.notificationList("NotificationDAO.notificationList",commandMap);
	}

	@Override
	public int notificationListTotCnt(Map<String, Object> commandMap) {

		return webcoDAO.notificationListTotCnt("NotificationDAO.notificationListTotCnt",commandMap);
	}

	@Override
	public List<Map<String, Object>> organScheduleList(
			Map<String, Object> commandMap) {
		
		return webcoDAO.organScheduleList("NotificationDAO.organScheduleList",commandMap);
	}

	@Override
	public int organScheduleListTotCnt(Map<String, Object> commandMap) {

		return webcoDAO.organScheduleListTotCnt("NotificationDAO.organScheduleListTotCnt",commandMap);
	}

	@Override
	public void contentsUpdateEnd(Map<String, Object> commandMap) {
		
		webcoDAO.contentsUpdateEnd("NotificationDAO.contentsUpdateEnd",commandMap);
	}

	@Override
	public Map<String, Object> selectedOrganSchedule(
			Map<String, Object> commandMap) {

		return webcoDAO.selectedOrganSchedule("NotificationDAO.selectedOrganSchedule",commandMap);
	}

	@Override
	public void organScheduleUpdateEnd(Map<String, Object> commandMap) {
		
		webcoDAO.organScheduleUpdateEnd("NotificationDAO.organScheduleUpdateEnd",commandMap);
	}

	@Override
	public void scheduleContentsUpdateEnd(Map<String, Object> commandMap) {
		
		webcoDAO.scheduleContentsUpdateEnd("NotificationDAO.scheduleContentsUpdateEnd",commandMap);
	}

	@Override
	public void organScheduleDeleteEnd(Map<String, Object> commandMap) {

		webcoDAO.organScheduleDeleteEnd("NotificationDAO.organScheduleDeleteEnd",commandMap);
	}

	@Override
	public void organScheduleInsertEnd(Map<String, Object> commandMap) {

		webcoDAO.organScheduleInsertEnd("NotificationDAO.organScheduleInsertEnd",commandMap);
	}

	@Override
	public int scheduleEndIdx() {

		return webcoDAO.scheduleEndIdx("NotificationDAO.scheduleEndIdx");
	}

	@Override
	public List<Map<String, Object>> surveyList(Map<String, Object> commandMap) {
		
		return webcoDAO.surveyList("NotificationDAO.surveyList",commandMap);
	}

	@Override
	public int surveyListTotalCnt(Map<String, Object> commandMap) {

		return webcoDAO.surveyListTotalCnt("NotificationDAO.surveyListTotalCnt", commandMap);
	}


}
