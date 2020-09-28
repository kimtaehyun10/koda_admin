package egovframework.webco.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.webco.dao.WebcoDefaultDAO;
import egovframework.webco.service.DefaultSettingService;

@Service("defaultSettingService")
public class DefaultSettingServiceImpl implements DefaultSettingService {

	/** webcoDAO */
    @Resource(name="webcoDAO")
    private WebcoDefaultDAO webcoDAO;    	
	
	/** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());

	@Override
	public List<Map<String, Object>> popupList(Map<String, Object> commandMap) {
		
		return webcoDAO.popupList("DefaultSettingDAO.popupList",commandMap);
	}

	@Override
	public int popupListTotCnt(Map<String, Object> commandMap) {
		
		return webcoDAO.popupListTotCnt("DefaultSettingDAO.popupListTotCnt",commandMap);
	}

	@Override
	public List<Map<String, Object>> bannerList(Map<String, Object> commandMap) {

		return webcoDAO.bannerList("DefaultSettingDAO.bannerList",commandMap);
	}

	@Override
	public int bannerListTotCnt(Map<String, Object> commandMap) {
		
		return webcoDAO.bannerListTotCnt("DefaultSettingDAO.bannerListTotCnt",commandMap);
	}

	@Override
	public Map<String, Object> selectedPopup(Map<String, Object> commandMap) {

		return webcoDAO.selectedPopup("DefaultSettingDAO.selectedPopup",commandMap);
	}

	@Override
	public void popupUpdateEnd(Map<String, Object> commandMap) {

		webcoDAO.popupUpdateEnd("DefaultSettingDAO.popupUpdateEnd",commandMap);
	}

	@Override
	public void popupDeleteEnd(Map<String, Object> commandMap) {
		
		webcoDAO.popupDeleteEnd("DefaultSettingDAO.popupDeleteEnd",commandMap);
	}

	@Override
	public int popupEcmSeq() {
	
		return webcoDAO.popupEcmSeq("DefaultSettingDAO.popupEcmSeq");
	}

	@Override
	public void popupWriteEnd(Map<String, Object> commandMap) {

		webcoDAO.popupWriteEnd("DefaultSettingDAO.popupWriteEnd",commandMap);
	}

	@Override
	public Map<String, Object> selectedBanner(Map<String, Object> commandMap) {

		return webcoDAO.selectedBanner("DefaultSettingDAO.selectedBanner",commandMap);
	}

	@Override
	public void bannerUpdateEnd(Map<String, Object> commandMap) {

		webcoDAO.bannerUpdateEnd("DefaultSettingDAO.bannerUpdateEnd",commandMap);
	}

	@Override
	public void bannerDeleteEnd(Map<String, Object> commandMap) {

		webcoDAO.bannerDeleteEnd("DefaultSettingDAO.bannerDeleteEnd",commandMap);
	}

	@Override
	public int bannerEndIdx(Map<String, Object> commandMap) {

		return webcoDAO.bannerEndIdx("DefaultSettingDAO.bannerEndIdx");
	}

	@Override
	public void bannerWriteEnd(Map<String, Object> commandMap) {

		webcoDAO.bannerWriteEnd("DefaultSettingDAO.bannerWriteEnd",commandMap);
	}

	@Override
	public List<Map<String, Object>> boardManageList(Map<String, Object> commandMap) {

		return webcoDAO.boardManageList("DefaultSettingDAO.boardManageList",commandMap);
	}

	@Override
	public int boardManageListTotalCnt(Map<String, Object> commandMap) {

		return webcoDAO.boardManageListTotalCnt("DefaultSettingDAO.boardManageListTotalCnt",commandMap);
	}

	@Override
	public void boardManageCommentYN(Map<String, Object> commandMap) {
		
		webcoDAO.boardManageCommentYN("DefaultSettingDAO.boardManageCommentYN",commandMap);
	}

	@Override
	public List<Map<String, Object>> visitCountList(Map<String, Object> commandMap) {

		return webcoDAO.visitCountList("DefaultSettingDAO.visitCountList",commandMap);
	}

	@Override
	public List<Map<String, Object>> searchKeywordList(
			Map<String, Object> commandMap) {

		return webcoDAO.searchKeywordList("DefaultSettingDAO.searchKeywordList",commandMap);
	}

	@Override
	public int searchKeywordListTotCnt(Map<String, Object> commandMap) {

		return webcoDAO.searchKeywordListTotCnt("DefaultSettingDAO.searchKeywordListTotCnt",commandMap);
	}
    
}
