package egovframework.webco.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("webcoDAO")
public class WebcoDefaultDAO extends EgovComAbstractDAO {

	@Override
	public int delete(String queryId, Object parameterObject) {
		// TODO Auto-generated method stub
		return super.delete(queryId, parameterObject);
	}

	@Override
	public Object insert(String queryId, Object parameterObject) {
		// TODO Auto-generated method stub
		return super.insert(queryId, parameterObject);
	}

	@Override
	public List list(String queryId, Object parameterObject) {
		// TODO Auto-generated method stub
		return super.list(queryId, parameterObject);
	}

	@Override
	public List listWithPaging(String queryId, Object parameterObject,
			int pageIndex, int pageSize) {
		// TODO Auto-generated method stub
		return super.listWithPaging(queryId, parameterObject, pageIndex, pageSize);
	}

	@Override
	public int update(String queryId, Object parameterObject) {
		// TODO Auto-generated method stub
		return super.update(queryId, parameterObject);
	}

	@Override
    public Object selectByPk(String queryId, Object parameterObject) {
        // TODO Auto-generated method stub
        return super.select(queryId, parameterObject);
    }
	
	@Override
    public Object select(String queryId, Object parameterObject) {
        // TODO Auto-generated method stub
        return super.select(queryId, parameterObject);
    }

	public List<Map<String, Object>> hopeDonateStatsList(
			String queryId, Map<String, Object> commandMap) {
		
		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}

	public int hopeDonateStatsListTotCnt(String queryId,
			Map<String, Object> commandMap) {
		
		return (int)super.select(queryId,commandMap);
	}

	public List<Map<String, Object>> brainDonateStatsList(String queryId,
			Map<String, Object> commandMap) {
		
		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}

	public int brainDonateStatsListTotCnt(String queryId,
			Map<String, Object> commandMap) {
		 
		return (int)super.select(queryId,commandMap);
	}

	public List<Map<String, Object>> organDonateStatsList(String queryId,
			Map<String, Object> commandMap) {
		
		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}

	public int organDonateStatsListTotCnt(String queryId,
			Map<String, Object> commandMap) {
		
		return (int)super.select(queryId,commandMap);
	}

	public List<Map<String, Object>> donateStatsTrendList(String queryId,
			Map<String, Object> commandMap) {

		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}

	public int donateStatsTrendListTotCnt(String queryId,
			Map<String, Object> commandMap) {

		return (int)super.select(queryId,commandMap);
	}

	public List<Map<String, Object>> familyEventList(String queryId,
			Map<String, Object> commandMap) {
	
		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}

	public int familyEventListTotCnt(String queryId,
			Map<String, Object> commandMap) {
		
		return (int)super.select(queryId,commandMap);
	}

	public List<Map<String, Object>> memberList(String queryId,
			Map<String, Object> commandMap) {
		
		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}

	public int memberListTotCnt(String queryId, Map<String, Object> commandMap) {

		return (int)super.select(queryId,commandMap);
	}

	public List<Map<String, Object>> letterStoryList(String queryId,
			Map<String, Object> commandMap) {
		
		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}

	public int letterStoryListTotCnt(String queryId,
			Map<String, Object> commandMap) {

		return (int)super.select(queryId,commandMap);
	}

	public List<Map<String, Object>> notificationList(String queryId,
			Map<String, Object> commandMap) {
		
		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}

	public int notificationListTotCnt(String queryId,
			Map<String, Object> commandMap) {
		
		return (int)super.select(queryId,commandMap);
	}

	public List<Map<String, Object>> organScheduleList(String queryId,
			Map<String, Object> commandMap) {
		
		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}

	public int organScheduleListTotCnt(String queryId,
			Map<String, Object> commandMap) {

		return (int)super.select(queryId,commandMap);
	}

	public List<Map<String, Object>> hospitalList(String queryId,
			Map<String, Object> commandMap) {

		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}

	public int hospitalListTotCnt(String queryId,
			Map<String, Object> commandMap) {
		
		return (int)super.select(queryId,commandMap);
	}

	public List<Map<String, Object>> popupList(String queryId,
			Map<String, Object> commandMap) {
		
		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}

	public int popupListTotCnt(String queryId, Map<String, Object> commandMap) {
		
		return (int)super.select(queryId,commandMap);
	}

	public List<Map<String, Object>> bannerList(String queryId,
			Map<String, Object> commandMap) {
		
		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}

	public int bannerListTotCnt(String queryId, Map<String, Object> commandMap) {
		
		return (int)super.select(queryId,commandMap);
	}

	public Map<String, Object> selectedMember(String queryId,
			Map<String, Object> commandMap) {
		
		return (Map<String, Object>)super.select(queryId,commandMap);
	}

	public void memberUpdateEnd(String queryId, Map<String, Object> commandMap) {
		
		super.update(queryId, commandMap);
	}

	public void memberDeleteEnd(String queryId, Map<String, Object> commandMap) {
		super.delete(queryId, commandMap);
		
	}

	public int endIdx(String queryId, Map<String, Object> commandMap) {
		
		return (int)super.select(queryId,commandMap);
	}

	public void memberWriteEnd(String queryId, Map<String, Object> commandMap) {
		
		super.insert(queryId, commandMap);
	}

	public Map<String, Object> selectedLetterStory(String queryId,
			Map<String, Object> commandMap) {
		
		return (Map<String, Object>)super.select(queryId,commandMap);
	}

	public void letterStoryUpdateEnd(String queryId,
			Map<String, Object> commandMap) {
		
		super.update(queryId, commandMap);
	}

	public void letterStoryDeleteEnd(String queryId,
			Map<String, Object> commandMap) {
		
		super.delete(queryId, commandMap);
	}

	public void letterStoryWriteEnd(String queryId,
			Map<String, Object> commandMap) {

		super.insert(queryId, commandMap);
	}

	public Map<String, Object> selectedHospital(String queryId,
			Map<String, Object> commandMap) {
		
		return (Map<String, Object>)super.select(queryId,commandMap);
	}

	public void hospitalUpdateEnd(String queryId, Map<String, Object> commandMap) {
		
		super.update(queryId, commandMap);
	}

	public void hospitalDeleteEnd(String queryId, Map<String, Object> commandMap) {
		
		super.delete(queryId, commandMap);
	}

	public void hospitalWriteEnd(String queryId, Map<String, Object> commandMap) {
		super.insert(queryId, commandMap);
		
	}

	public Map<String, Object> selectedBrain(String queryId,
			Map<String, Object> commandMap) {
		
		return (Map<String, Object>)super.select(queryId,commandMap);
	}

	public void brainDonateStatsUpdateEnd(String queryId,
			Map<String, Object> commandMap) {

		super.update(queryId, commandMap);
	}

	public void brainDonateStatsDeleteEnd(String queryId,
			Map<String, Object> commandMap) {

		super.delete(queryId, commandMap);
	}

	public void brainDonateStatsWriteEnd(String queryId,
			Map<String, Object> commandMap) {

		super.insert(queryId, commandMap);
	}

	public Map<String, Object> selectedOrgan(String queryId,
			Map<String, Object> commandMap) {

		return (Map<String, Object>)super.select(queryId,commandMap);
	}

	public void organDonateStatsUpdateEnd(String queryId,
			Map<String, Object> commandMap) {

		super.update(queryId, commandMap);
	}

	public void organDonateStatsDeleteEnd(String queryId,
			Map<String, Object> commandMap) {

		super.delete(queryId, commandMap);
	}

	public void organDonateStatsWriteEnd(String queryId,
			Map<String, Object> commandMap) {

		super.insert(queryId, commandMap);
	}

	public Map<String, Object> selectedFile(String queryId,
			Map<String, Object> commandMap) {
		
		return (Map<String, Object>)super.select(queryId,commandMap);
	}

	public void fileUpload(String queryId, Map<String, Object> commandMap) {

		super.update(queryId, commandMap);
	}

	public Map<String, Object> selectedHope(String queryId,
			Map<String, Object> commandMap) {

		return (Map<String, Object>)super.select(queryId,commandMap);
	}

	public void hopeDonateStatsUpdateEnd(String queryId,
			Map<String, Object> commandMap) {

		super.update(queryId, commandMap);
	}

	public void hopeDonateStatsDeleteEnd(String queryId,
			Map<String, Object> commandMap) {

		super.delete(queryId, commandMap);
	}

	public void hopeDonateStatsWriteEnd(String queryId,
			Map<String, Object> commandMap) {
		
		super.insert(queryId, commandMap);
	}

	public Map<String, Object> selectedBoard(String queryId,
			Map<String, Object> commandMap) {

		return (Map<String, Object>)super.select(queryId,commandMap);
	}

	public void boardUpdateEnd(String queryId, Map<String, Object> commandMap) {
		
		super.update(queryId, commandMap);
	}

	public void boardDeleteEnd(String queryId, Map<String, Object> commandMap) {
		
		super.delete(queryId, commandMap);
	}

	public void boardFileDeleteEnd(String queryId, Map<String, Object> commandMap) {

		super.delete(queryId, commandMap);
	}

	public void boardFileInsert(String queryId, Map<String, Object> commandMap) {
		
		super.insert(queryId, commandMap);
	}

	public void boardInsert(String queryId, Map<String, Object> commandMap) {

		super.insert(queryId, commandMap);
	}

	public Map<String, Object> selectedTrend(String queryId,
			Map<String, Object> commandMap) {

		return (Map<String, Object>)super.select(queryId,commandMap);
	}

	public void donateStatsTrendUpdateEnd(String queryId,
			Map<String, Object> commandMap) {
		
		super.update(queryId, commandMap);
	}

	public void donateStatsTrendDeleteEnd(String queryId,
			Map<String, Object> commandMap) {

		super.delete(queryId, commandMap);
	}

	public void donateStatsTrendWriteEnd(String queryId,
			Map<String, Object> commandMap) {

		super.insert(queryId, commandMap);
	}

	public void contentsUpdateEnd(String queryId, Map<String, Object> commandMap) {
		
		super.update(queryId, commandMap);
	}

	public Map<String, Object> selectedOrganSchedule(String queryId,
			Map<String, Object> commandMap) {
		
		return (Map<String, Object>)super.select(queryId,commandMap);
	}

	public void organScheduleUpdateEnd(String queryId,
			Map<String, Object> commandMap) {
		
		super.update(queryId, commandMap);
	}

	public void scheduleContentsUpdateEnd(String queryId,
			Map<String, Object> commandMap) {
		super.update(queryId, commandMap);
		
	}

	public void organScheduleDeleteEnd(String queryId,
			Map<String, Object> commandMap) {

		super.delete(queryId, commandMap);
	}

	public void organScheduleInsertEnd(String queryId,
			Map<String, Object> commandMap) {
		
		super.insert(queryId, commandMap);
	}

	public Map<String, Object> selectedFamilyEvent(String queryId,
			Map<String, Object> commandMap) {

		return (Map<String, Object>)super.select(queryId,commandMap);
	}

	public void familyEventUpdateEnd(String queryId,
			Map<String, Object> commandMap) {
		
		super.update(queryId, commandMap);
	}

	public void familyEventContentsUpdateEnd(String queryId,
			Map<String, Object> commandMap) {

		super.update(queryId, commandMap);
	}

	public void familyEventDeleteEnd(String queryId,
			Map<String, Object> commandMap) {
		
		super.delete(queryId, commandMap);
	}

	public void familyEventInsertEnd(String queryId,
			Map<String, Object> commandMap) {

		super.insert(queryId, commandMap);
	}

	public List<Map<String, Object>> letterStoryComment(String queryId,
			Map<String, Object> commandMap) {

		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}

	public void letterStoryCommentUpdateEnd(String queryId,
			Map<String, Object> commandMap) {
		
		super.update(queryId, commandMap);
	}

	public void letterStoryCommentWriteEnd(String queryId,
			Map<String, Object> commandMap) {

		super.insert(queryId, commandMap);
	}

	public void letterStoryCommentDeleteEnd(String queryId,
			Map<String, Object> commandMap) {

		super.delete(queryId, commandMap);
	}

	public int commentEndIdx(String queryId) {
		
		return (int)super.select(queryId);
	}

	public Map<String, Object> selectedPopup(String queryId,
			Map<String, Object> commandMap) {
		
		return (Map<String, Object>)super.select(queryId,commandMap);
	}

	public void popupUpdateEnd(String queryId, Map<String, Object> commandMap) {
		
		super.update(queryId, commandMap);
		
	}

	public void popupDeleteEnd(String queryId, Map<String, Object> commandMap) {

		super.delete(queryId, commandMap);
	}

	public int popupEcmSeq(String queryId) {
		
		return (int)super.select(queryId);
	}

	public void popupWriteEnd(String queryId, Map<String, Object> commandMap) {

		super.insert(queryId, commandMap);
	}

	public Map<String, Object> selectedBanner(String queryId,
			Map<String, Object> commandMap) {
		
		return (Map<String, Object>)super.select(queryId,commandMap);
	}

	public void bannerUpdateEnd(String queryId, Map<String, Object> commandMap) {

		super.update(queryId, commandMap);
	}

	public void bannerDeleteEnd(String queryId, Map<String, Object> commandMap) {

		super.delete(queryId, commandMap);
	}

	public int bannerEndIdx(String queryId) {
		
		return (int)super.select(queryId);
	}

	public void bannerWriteEnd(String queryId, Map<String, Object> commandMap) {

		super.insert(queryId, commandMap);
	}

	public List<Map<String, Object>> boardManageList(String queryId, Map<String, Object> commandMap) {

		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}

	public int boardManageListTotalCnt(String queryId, Map<String, Object> commandMap) {

		return (int)super.select(queryId, commandMap);
	}

	public void boardManageCommentYN(String queryId, Map<String, Object> commandMap) {

		super.update(queryId, commandMap);
	}

	public List<Map<String, Object>> adminMenuList(String queryId, Map<String, Object> commandMap) {

		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}

	public void adminMenuDelete(String queryId, Map<String, Object> commandMap) {

		super.delete(queryId, commandMap);
	}

	public void adminMenuChange(String queryId, Map<String, Object> commandMap) {
		
		super.insert(queryId, commandMap);
	}

	public List<Map<String, Object>> webMenuList(String queryId, Map<String, Object> commandMap) {
		
		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}

	public List<Map<String, Object>> visitCountList(String queryId, Map<String, Object> commandMap) {

		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}

	public int brainDonateStatsEndIdx(String queryId) {
		
		return (int)super.select(queryId);
	}

	public int organDonateStatsEndIdx(String queryId) {

		return (int)super.select(queryId);
	}

	public int hopeDonateStatsEndIdx(String queryId) {

		return (int)super.select(queryId);
	}

	public int donateStatsTrendEndIdx(String queryId) {

		return (int)super.select(queryId);
	}

	public int familyEventEndIdx(String queryId) {

		return (int)super.select(queryId);
	}

	public int donateEndIdx(String queryId) {
		
		return (int)super.select(queryId);
	}

	public int scheduleEndIdx(String queryId) {

		return (int)super.select(queryId);
	}

	public int boardContEndIdx(String queryId) {

		return (int)super.select(queryId);
	}

	public List<Map<String, Object>> searchKeywordList(String queryId,
			Map<String, Object> commandMap) {
		
		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}

	public int searchKeywordListTotCnt(String queryId,
			Map<String, Object> commandMap) {

		return (int)super.select(queryId,commandMap);
	}

	public void attachSave(String queryId, Map<String, Object> commandMap) {
		super.insert(queryId, commandMap);
		
	}

	public Map<String, Object> userAttach(String queryId, Map<String, Object> commandMap) {		
		return (Map<String, Object>)super.select(queryId,commandMap);
	}
	
	public List<Map<String, Object>> mainBannerList(String queryId,
			Map<String, Object> commandMap) {
		
		return (List<Map<String, Object>>)super.list(queryId,commandMap);
	}
	public int mainBannerListTotCnt(String queryId, Map<String, Object> commandMap) {
		
		return (int)super.select(queryId,commandMap);
	}

	public void mainBannerInsert(String queryId, Map<String, Object> commandMap) {
		super.insert(queryId, commandMap);
		
	}
}
