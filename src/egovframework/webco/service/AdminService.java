package egovframework.webco.service;

import java.util.List;
import java.util.Map;

import egovframework.webco.vo.AdminActHistVO;

public interface AdminService {
	Object insert(Map<String, Object> commandMap) throws Exception;
	
	int update(Map<String, Object> commandMap) throws Exception;
	
	int delete(Map<String, Object> commandMap) throws Exception;
	
	Map<String, Object> selectAdminList(Map<String, Object> commandMap) throws Exception;

	Map<String, Object> selectAdminInfo(Map<String, Object> commandMap) throws Exception;
	
	Map<String, Object> selectAdminInfo(int admin_index) throws Exception;	
	
	Object insertActHist(AdminActHistVO adminActHistVO) throws Exception;
	
	Object insertActHist(String act_type, String act_detail) throws Exception;

	int endIdx(Map<String, Object> commandMap);

	Map<String, Object> selectedFile(Map<String, Object> commandMap);

	void fileUpload(Map<String, Object> commandMap);

	List<Map<String, Object>> adminMenuList(Map<String, Object> commandMap);

	void adminMenuDelete(Map<String, Object> commandMap);

	void adminMenuChange(Map<String, Object> commandMap);
}
  