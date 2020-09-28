package egovframework.webco.service.impl;

import egovframework.webco.service.RemembranceService;

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

@Service("remembranceService")
public class RemembranceServiceImpl implements RemembranceService {

	/** webcoDAO */
    @Resource(name="webcoDAO")
    private WebcoDefaultDAO webcoDAO;    	
	
	/** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());

	@Override
	public List<Map<String, Object>> memberList(Map<String, Object> commandMap) {
		
		return webcoDAO.memberList("UserDAO.memberList",commandMap);
	}

	@Override
	public int memberListTotCnt(Map<String, Object> commandMap) {
		
		return webcoDAO.memberListTotCnt("UserDAO.memberListTotCnt",commandMap);
	}

	@Override
	public List<Map<String, Object>> letterStoryList(
			Map<String, Object> commandMap) {
		
		return webcoDAO.letterStoryList("UserDAO.letterStoryList",commandMap);
	}

	@Override
	public int letterStoryListTotCnt(Map<String, Object> commandMap) {

		return webcoDAO.letterStoryListTotCnt("UserDAO.letterStoryListTotCnt",commandMap);
	}

	@Override
	public Map<String, Object> selectedMember(Map<String, Object> commandMap) {
		
		return webcoDAO.selectedMember("UserDAO.selectedMember",commandMap);
	}

	@Override
	public void memberUpdateEnd(Map<String, Object> commandMap) {
		
		webcoDAO.memberUpdateEnd("UserDAO.memberUpdateEnd",commandMap);
	}

	@Override
	public void memberDeleteEnd(Map<String, Object> commandMap) {
		
		webcoDAO.memberDeleteEnd("UserDAO.memberDeleteEnd",commandMap);
	}

	@Override
	public void memberWriteEnd(Map<String, Object> commandMap) {
		
		webcoDAO.memberWriteEnd("UserDAO.memberWriteEnd",commandMap);
	}

	@Override
	public Map<String, Object> selectedLetterStory(
			Map<String, Object> commandMap) {
		
		return webcoDAO.selectedLetterStory("UserDAO.selectedLetterStory",commandMap);
	}

	@Override
	public void letterStoryUpdateEnd(Map<String, Object> commandMap) {
		
		webcoDAO.letterStoryUpdateEnd("UserDAO.letterStoryUpdateEnd",commandMap);
	}

	@Override
	public void letterStoryDeleteEnd(Map<String, Object> commandMap) {
		
		webcoDAO.letterStoryDeleteEnd("UserDAO.letterStoryDeleteEnd",commandMap);
	}

	@Override
	public void letterStoryWriteEnd(Map<String, Object> commandMap) {

		webcoDAO.letterStoryWriteEnd("UserDAO.letterStoryWriteEnd",commandMap);
	}

	@Override
	public List<Map<String, Object>> letterStoryComment(
			Map<String, Object> commandMap) {

		return webcoDAO.letterStoryComment("UserDAO.letterStoryComment",commandMap);
	}

	@Override
	public void letterStoryCommentUpdateEnd(Map<String, Object> commandMap) {

		webcoDAO.letterStoryCommentUpdateEnd("UserDAO.letterStoryCommentUpdateEnd",commandMap);
	}

	@Override
	public void letterStoryCommentWriteEnd(Map<String, Object> commandMap) {
		
		webcoDAO.letterStoryCommentWriteEnd("UserDAO.letterStoryCommentWriteEnd",commandMap);
	}

	@Override
	public void letterStoryCommentDeleteEnd(Map<String, Object> commandMap) {
		
		webcoDAO.letterStoryCommentDeleteEnd("UserDAO.letterStoryCommentDeleteEnd",commandMap);
	}

	@Override
	public int commentEndIdx() {
		
		return webcoDAO.commentEndIdx("UserDAO.commentEndIdx");
	}

	@Override
	public int donateEndIdx() {

		return webcoDAO.donateEndIdx("UserDAO.donateEndIdx");
	}
}
