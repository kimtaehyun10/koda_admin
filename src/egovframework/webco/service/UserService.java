package egovframework.webco.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface UserService {	
	Object insert(Map<String, Object> commandMap) throws Exception;
	
	int update(Map param) throws Exception;
	
	int saveUserInfo(Map<String, Object> commandMap) throws Exception;
	
	int delete(Map<String, Object> commandMap) throws Exception;		
	
	Map<String, Object> selectUserList(Map<String, Object> commandMap) throws Exception;

	Map<String, Object> selectUserInfo(Map<String, Object> commandMap) throws Exception;
	
	Map<String, Object> selectUserInfo(int user_index) throws Exception;
	
	boolean exportExcel(Map<String, Object> commandMap) throws Exception;
	
	boolean exportLabelforSelectedUser(Map<String, Object> commandMap) throws Exception;
	
	boolean exportLabelforSelectedUserOrg(Map<String, Object> commandMap) throws Exception;
	
	int checkUserCI(String ipinCi) throws Exception;		
	
	public String sendAutoSMS(String messageCode, String user_mobile, String user_is_sms_agree) throws Exception;

	Map<String, Object> userAttach(Map<String, Object> commandMap);

	void fileDownload(Map<String, Object> requestMap, HttpServletRequest request, HttpServletResponse response);
}
  