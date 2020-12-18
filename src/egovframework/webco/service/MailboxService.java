package egovframework.webco.service;

import java.util.List;
import java.util.Map;

public interface MailboxService {
	
	Object insert(String queryId, Map param) throws Exception;
	int delete(String queryId, Map param) throws Exception;
	int update(String queryId, Map param) throws Exception;
	
	Map<String, Object> selectKodaMemberList(Map<String, Object> param) throws Exception;
	Map<String, Object> selectRelationKodaMemberList(Map<String, Object> param) throws Exception;
	Map<String, Object> selectMatchKodaMemberList(Map<String, Object> param) throws Exception;
	public boolean exportMemberList(Map<String, Object> commandMap) throws Exception;
	
	Map<String, Object> selectKodaMemberDetail(Map<String, Object> param) throws Exception;
	List<Map<String, Object>> selectBenefiList(Map<String, Object> commandMap) throws Exception;
	Map<String, Object> selectDonorList(Map<String, Object> commandMap) throws Exception;
	
	Map<String, Object> selectDonorRelationList(Map<String, Object> param) throws Exception;
	List<Map<String, Object>> selectBenefiPartList(Map<String, Object> commandMap) throws Exception;
}
  