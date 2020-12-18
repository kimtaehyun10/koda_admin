package egovframework.webco.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("letterDAO")
public class LetterDAO extends EgovComAbstractDAO {

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectTypeLetterFile(Map<String, Object> commandMap) {
		return (Map<String, Object>) super.select("LetterDao.selectTypeLetterFile", commandMap);
	}
	
	//----------------------------- 스킨관리 -------------------------------------------------------//
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectLetterSkinList(Map<String, Object> commandMap) {
		return (List<Map<String, Object>>) super.list("LetterDao.selectLetterSkinList", commandMap);
	}

	public int selectLetterSkinListTotCnt(Map<String, Object> commandMap) {
		return (int) super.select("LetterDao.selectLetterSkinListTotCnt", commandMap);
	}

	public String saveLetterSkin(Map<String, Object> commandMap) {
		super.insert("LetterDao.saveLetterSkin", commandMap);
		return (String) commandMap.get("letter_skin_id");
	}
	
	public int selectDuplicateSkinName(Map<String, Object> commandMap) {
		return (int) super.select("LetterDao.selectDuplicateSkinName", commandMap);
	}
	
	public void updateLetterSkin(Map<String, Object> commandMap) {
		super.update("LetterDao.updateLetterSkin", commandMap);
	} 
	
	public void updateLetterSkinFile(Map<String, Object> commandMap) {
		super.update("LetterDao.updateLetterSkinFile", commandMap);
	}

	public void deleteLetterSkin(Map<String, Object> commandMap) {
		super.delete("LetterDao.deleteLetterSkin", commandMap);
		
	}
	
	public int selectUseSkinLetterId(Map<String, Object> commandMap) {
		return (int) super.select("LetterDao.selectUseSkinLetterId", commandMap);
	}

	//----------------------------- 우체통관리 -------------------------------------------------------//
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectLetterList(Map<String, Object> commandMap) {
		return (List<Map<String, Object>>) super.list("LetterDao.selectLetterList", commandMap);
	}

	public int selectLetterListTotCnt(Map<String, Object> commandMap) {
		return (int) super.select("LetterDao.selectLetterListTotCnt", commandMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectLetterFileList(Map<String, Object> commandMap) {
		return (List<Map<String, Object>>) super.list("LetterDao.selectLetterFileList", commandMap);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectLetterView(Map<String, Object> commandMap) {
		return (Map<String, Object>) super.select("LetterDao.selectLetterView", commandMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectLetterSenderSearchList(Map<String, Object> commandMap) {
		return (List<Map<String, Object>>) super.list("LetterDao.selectLetterSenderSearchList", commandMap);
	}

	public int selectLetterSenderSearchListTotCnt(Map<String, Object> commandMap) {
		return (int) super.select("LetterDao.selectLetterSenderSearchListTotCnt", commandMap);
	}
	
	public String saveLetterWrite(Map<String, Object> commandMap) {
		super.insert("LetterDao.saveLetterWrite", commandMap);
		return (String) commandMap.get("letter_id");
	}

	public void updateLetterGroupKeyAndDepth(Map<String, Object> commandMap) {
		super.update("LetterDao.updateLetterGroupKeyAndDepth", commandMap);
	}

	public void saveLetterFile(Map<String, Object> commandMap) {
		super.insert("LetterDao.saveLetterFile", commandMap);
	}
	
	public void saveLetterReceiver(Map<String, Object> commandMap) {
		super.insert("LetterDao.saveLetterReceiver", commandMap);
	}

	public void deleteLetterFile(Map<String, Object> commandMap) {
		super.delete("LetterDao.deleteLetterFile", commandMap);
	}

	public void letterWriteUpdate(Map<String, Object> commandMap) {
		super.update("LetterDao.updateLetterWrite", commandMap);
	}

	public void deleteLetter(Map<String, Object> commandMap) {
		super.delete("LetterDao.deleteLetter", commandMap);
	}
	
	public void deleteLetterReceiver(Map<String, Object> commandMap) {
		super.delete("LetterDao.deleteLetterReceiver", commandMap);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectLetterAdminSearchList(Map<String, Object> commandMap) {
		return (List<Map<String, Object>>) super.list("LetterDao.selectLetterAdminSearchList", commandMap);
	}

	public int selectLetterAdminSearchListTotCnt(Map<String, Object> commandMap) {
		return (int) super.select("LetterDao.selectLetterAdminSearchListTotCnt", commandMap);
	}
	
	public void updateReplyShape(Map<String, Object> commandMap) {
		super.delete("LetterDao.updateReplyShape", commandMap);
	}

	//----------------------------- 관리자 예시글 -------------------------------------------------------//
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectLetterAdminList(Map<String, Object> commandMap) {
		return (List<Map<String, Object>>) super.list("LetterDao.selectLetterAdminList", commandMap);
	}

	public int selectLetterAdminListTotCnt(Map<String, Object> commandMap) {
		return (int) super.select("LetterDao.selectLetterAdminListTotCnt", commandMap);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAdminSearchList(Map<String, Object> commandMap) {
		return (List<Map<String, Object>>) super.list("LetterDao.selectAdminSearchList", commandMap);
	}

	public int selectAdminSearchListTotCnt(Map<String, Object> commandMap) {
		return (int) super.select("LetterDao.selectAdminSearchListTotCnt", commandMap);
	}

	public String saveLetterAdmin(Map<String, Object> commandMap) {
		super.insert("LetterDao.saveLetterAdmin", commandMap);
		return (String) commandMap.get("letter_admin_id");
	}

	public void updateLetterAdmin(Map<String, Object> commandMap) {
		super.update("LetterDao.updateLetterAdmin", commandMap);
	}

	public void deleteLetterAdmin(Map<String, Object> commandMap) {
		super.delete("LetterDao.deleteLetterAdmin", commandMap);
	}

	public int selectLetterReplyCheck(Map<String, Object> commandMap) {
		return (int) super.select("LetterDao.selectLetterReplyCheck", commandMap);
	}

	



	

	

	

	

	

	

	
	

	
	
}
