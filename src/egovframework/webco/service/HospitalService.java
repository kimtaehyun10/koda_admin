package egovframework.webco.service;

import java.util.List;
import java.util.Map;

public interface HospitalService {

	List<Map<String, Object>> hospitalList(
			Map<String, Object> commandMap);

	int hospitalListTotCnt(Map<String, Object> commandMap);

	Map<String, Object> selectedHospital(Map<String, Object> commandMap);

	void hospitalUpdateEnd(Map<String, Object> commandMap);

	void hospitalDeleteEnd(Map<String, Object> commandMap);

	void hospitalWriteEnd(Map<String, Object> commandMap);

}
