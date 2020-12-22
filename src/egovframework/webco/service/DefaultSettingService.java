package egovframework.webco.service;

import java.util.List;
import java.util.Map;

public interface DefaultSettingService {

	List<Map<String, Object>> popupList(Map<String, Object> commandMap);

	int popupListTotCnt(Map<String, Object> commandMap);

	List<Map<String, Object>> bannerList(Map<String, Object> commandMap);

	int bannerListTotCnt(Map<String, Object> commandMap);

	Map<String, Object> selectedPopup(Map<String, Object> commandMap);

	void popupUpdateEnd(Map<String, Object> commandMap);

	void popupDeleteEnd(Map<String, Object> commandMap);

	int popupEcmSeq();

	void popupWriteEnd(Map<String, Object> commandMap);

	Map<String, Object> selectedBanner(Map<String, Object> commandMap);

	void bannerUpdateEnd(Map<String, Object> commandMap);

	void bannerDeleteEnd(Map<String, Object> commandMap);

	int bannerEndIdx(Map<String, Object> commandMap);

	void bannerWriteEnd(Map<String, Object> commandMap);

	List<Map<String, Object>> boardManageList(Map<String, Object> commandMap);

	int boardManageListTotalCnt(Map<String, Object> commandMap);

	void boardManageCommentYN(Map<String, Object> commandMap);

	List<Map<String, Object>> visitCountList(Map<String, Object> commandMap);

	List<Map<String, Object>> searchKeywordList(Map<String, Object> commandMap);

	int searchKeywordListTotCnt(Map<String, Object> commandMap);

	List<Map<String, Object>> mainBannerList(Map<String, Object> commandMap);
	
	int mainBannerListTotCnt(Map<String, Object> commandMap);

	void mainBannerInsert(Map<String, Object> commandMap);

	void mainBannerUpdate(Map<String, Object> commandMap);

	void mainBannerDeleteEnd(Map<String, Object> commandMap);
}
