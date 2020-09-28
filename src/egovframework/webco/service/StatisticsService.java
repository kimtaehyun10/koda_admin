package egovframework.webco.service;

import java.util.List;
import java.util.Map;

public interface StatisticsService {
	Map<String, Object> getDashboard(Map commandMap) throws Exception;
	
	Map<String, Object> getVisitPeriod(Map commandMap) throws Exception;

	Map<String, Object> getChannel(Map commandMap) throws Exception;
	
	Map<String, Object> getSexAge(Map commandMap) throws Exception;
	
	Map<String, Object> getWithdraw(Map commandMap) throws Exception;
	
	boolean exportExcel(Map commandMap) throws Exception;

	List<Map<String, Object>> hopeDonateStatsList(Map<String, Object> commandMap);

	int hopeDonateStatsListTotCnt(Map<String, Object> commandMap);

	List<Map<String, Object>> brainDonateStatsList(
			Map<String, Object> commandMap);

	int brainDonateStatsListTotCnt(Map<String, Object> commandMap);

	List<Map<String, Object>> organDonateStatsList(
			Map<String, Object> commandMap);

	int organDonateStatsListTotCnt(Map<String, Object> commandMap);

	List<Map<String, Object>> donateStatsTrendList(
			Map<String, Object> commandMap);

	int donateStatsTrendListTotCnt(Map<String, Object> commandMap);

	Map<String, Object> selectedBrain(Map<String, Object> commandMap);

	void brainDonateStatsUpdateEnd(Map<String, Object> commandMap);

	void brainDonateStatsDeleteEnd(Map<String, Object> commandMap);

	void brainDonateStatsWriteEnd(Map<String, Object> commandMap);

	Map<String, Object> selectedOrgan(Map<String, Object> commandMap);

	void organDonateStatsUpdateEnd(Map<String, Object> commandMap);

	void organDonateStatsDeleteEnd(Map<String, Object> commandMap);

	void organDonateStatsWriteEnd(Map<String, Object> commandMap);

	Map<String, Object> selectedHope(Map<String, Object> commandMap);

	void hopeDonateStatsUpdateEnd(Map<String, Object> commandMap);

	void hopeDonateStatsDeleteEnd(Map<String, Object> commandMap);

	void hopeDonateStatsWriteEnd(Map<String, Object> commandMap);

	Map<String, Object> selectedBoard(Map<String, Object> commandMap);

	void boardUpdateEnd(Map<String, Object> commandMap);

	void boardDeleteEnd(Map<String, Object> commandMap);

	void boardFileDeleteEnd(Map<String, Object> commandMap);

	void boardFileInsert(Map<String, Object> commandMap);

	void boardInsert(Map<String, Object> commandMap);

	Map<String, Object> selectedTrend(Map<String, Object> commandMap);

	void donateStatsTrendUpdateEnd(Map<String, Object> commandMap);

	void donateStatsTrendDeleteEnd(Map<String, Object> commandMap);

	void donateStatsTrendWriteEnd(Map<String, Object> commandMap);

	Map<String, Object> getRecognizeTypeAjax(Map<String, Object> commandMap) throws Exception;

	int brainDonateStatsEndIdx();

	int organDonateStatsEndIdx();

	int hopeDonateStatsEndIdx();

	int donateStatsTrendEndIdx();

	int boardContEndIdx();

	Map<String, Object> getPageView(Map<String, Object> commandMap) throws Exception;
	
	/*boolean exportExcelVisitPeriod(Map commandMap) throws Exception;
	
	boolean exportExcelChannel(Map commandMap) throws Exception;
	
	boolean exportExcelSexAge(Map commandMap) throws Exception;
	
	boolean exportExcelWithdraw(Map commandMap) throws Exception;*/
}
  