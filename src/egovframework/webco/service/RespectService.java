package egovframework.webco.service;

import java.util.List;
import java.util.Map;

public interface RespectService {

	List<Map<String, Object>> familyEventList(Map<String, Object> commandMap);

	int familyEventListTotCnt(Map<String, Object> commandMap);
	
	Map<String, Object> selectedFamilyEvent(Map<String, Object> commandMap);

	void familyEventUpdateEnd(Map<String, Object> commandMap);

	void familyEventContentsUpdateEnd(Map<String, Object> commandMap);

	void familyEventDeleteEnd(Map<String, Object> commandMap);

	void familyEventInsertEnd(Map<String, Object> commandMap);

	int familyEventEndIdx();
}
