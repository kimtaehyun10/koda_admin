package egovframework.webco.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("mailboxDAO")
public class MailboxDAO extends EgovComAbstractDAO {

	@Override
	public Object insert(String queryId, Object parameterObject) {
		// TODO Auto-generated method stub
		return super.insert(queryId, parameterObject);
	}
	
	@Override
	public int delete(String queryId, Object parameterObject) {
		// TODO Auto-generated method stub
		return super.delete(queryId, parameterObject);
	}
	
	public List<Map<String, Object>> selectKodaMemberList(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>)super.list("MailboxDAO.selectKodaMemberList", param);
	}
	
	public int selectKodaMemberListCnt(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return (int)super.select("MailboxDAO.selectKodaMemberListCnt", param);
	}
	
	public List<Map<String, Object>> selectRelationKodaMemberList(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>)super.list("MailboxDAO.selectRelationKodaMemberList", param);
	}
	
	public int selectRelationKodaMemberListCnt(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return (int)super.select("MailboxDAO.selectRelationKodaMemberListCnt", param);
	}
	
	public List<Map<String, Object>> selectMatchKodaMemberList(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>)super.list("MailboxDAO.selectMatchKodaMemberList", param);
	}
	
	public List<Map<String, Object>> selectBenefiPartList(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>)super.list("MailboxDAO.selectBenefiPartList", param);
	}
	
	public List<Map<String, Object>> selectBenefiList(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>)super.list("MailboxDAO.selectBenefiList", param);
	}
	
	public Map<String, Object> selectDonorList(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return (Map<String, Object>)super.select("MailboxDAO.selectDonorList", param);
	}
	
	public List<Map<String, Object>> selectDonorRelationList(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>)super.list("MailboxDAO.selectDonorRelationList", param);
	}
	
	public Map<String, Object> selectKodaMemberDetail(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return (Map<String, Object>)super.select("MailboxDAO.selectKodaMemberDetail", param);
	}
	
	
	
}
