package egovframework.webco.service;

import java.util.List;
import java.util.Map;

public interface NotificationService {

	List<Map<String, Object>> notificationList(Map<String, Object> commandMap);

	int notificationListTotCnt(Map<String, Object> commandMap);

	List<Map<String, Object>> organScheduleList(Map<String, Object> commandMap);

	int organScheduleListTotCnt(Map<String, Object> commandMap);

	void contentsUpdateEnd(Map<String, Object> commandMap);

	Map<String, Object> selectedOrganSchedule(Map<String, Object> commandMap);

	void organScheduleUpdateEnd(Map<String, Object> commandMap);

	void scheduleContentsUpdateEnd(Map<String, Object> commandMap);

	void organScheduleDeleteEnd(Map<String, Object> commandMap);

	void organScheduleInsertEnd(Map<String, Object> commandMap);

	int scheduleEndIdx();

	List<Map<String, Object>> surveyList(Map<String, Object> commandMap);

	int surveyListTotalCnt(Map<String, Object> commandMap);

	

}
