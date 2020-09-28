package egovframework.webco.service;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;
import egovframework.webco.controller.bean.easyuigridJason;
import egovframework.webco.controller.bean.jqgridJason;

public interface WebcoService {
	Object insert(String queryId, Map param) throws Exception;
	
	Object insert(String queryId, Object vo) throws Exception;
	
	int selectCount(String queryId, Map<String, Object> param) throws Exception;
	
	int update(String queryId, Map param) throws Exception;
	
	int delete(String queryId, Map param) throws Exception;
	
	Map<String, Object> selectByPk(String queryId, Map param) throws Exception;
	
	jqgridJason list(String queryId, Map<String, Object> param) throws Exception;  // jqgrid 사용시

	jqgridJason list(String queryId, String queryId2, Map<String, Object> param) throws Exception; // jqgrid 사용시
	
	JSONObject list_json(String queryId, Map<String, Object> param) throws Exception; // winiGrid 사용시
	
	JSONObject list_json(String queryId, String queryId2, Map<String, Object> param) throws Exception; // winiGrid 사용시
	
	easyuigridJason list_easyui(String queryId, Map<String, Object> param) throws Exception; // easyui 사용시
    
	easyuigridJason list_easyui(String queryId, String queryId2, Map<String, Object> param) throws Exception; // easyui 사용시
	
	int mult_save(List<String> queryID, List<String> queryIUD, jqgridJason param) throws Exception;
	
	Map<String, Object> list_map(String queryId, String queryId2, Map<String, Object> param) throws Exception; // map 사용시
	
	List list_map(String queryId, Map<String, Object> param) throws Exception; // list 형으로 return
	
	Map<String, Object> detail_map(String queryId, Map<String, Object> param) throws Exception; // map 사용시(상세조회용)
	
	String list_map_json(String queryId, Map<String, Object> param) throws Exception; // 리스트를 json 형태로 return

	Map<String, Object> callProcedure_map(String queryId, Map<String, Object> param) throws Exception; //procedure 용

	List<Map<String, Object>> webMenuList(Map<String, Object> commandMap);
}
  