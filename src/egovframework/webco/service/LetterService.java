package egovframework.webco.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

public interface LetterService {
	
	/**
	 * 파일 다운로드 정보(유형이 우체통일시)
	 * @param commandMap
	 * @return
	 */
	Map<String, Object> selectTypeLetterFile(Map<String, Object> commandMap);
	
	/**
	 * 생명나눔 우체통 > 스킨관리 > 리스트
	 * @param commandMap
	 * @return
	 */
	List<Map<String, Object>> selectLetterSkinList(Map<String, Object> commandMap);

	/**
	 * 생명나눔 우체통 > 스킨관리 > 리스트 건수
	 * @param commandMap
	 * @return
	 */
	int selectLetterSkinListTotCnt(Map<String, Object> commandMap);

	/**
	 * 생명나눔 우체통 > 스킨관리 > 저장
	 * @param commandMap
	 * @param multipartFile
	 * @param HttpServletRequest
	 * @return
	 */
	String saveLetterSkin(Map<String, Object> commandMap, MultipartFile multipartFile, HttpServletRequest request);
	
	/**
	 * 생명나눔 우체통 > 스킨관리 > 저장 (스킨명 중복여부 확인)
	 * @param commandMap
	 * @return
	 */
	int selectDuplicateSkinName(Map<String, Object> commandMap);
	
	/**
	 * 생명나눔 우체통 > 스킨관리 > 수정
	 * @param commandMap
	 * @param multipartFile
	 * @param HttpServletRequest
	 * @return
	 */
	void updateLetterSkin(Map<String, Object> commandMap, MultipartFile multipartFile,HttpServletRequest request);

	/**
	 * 생명나눔 우체통 > 스킨관리 > 삭제
	 * @param commandMap
	 */
	void deleteLetterSkin(Map<String, Object> commandMap);

	/**
	 * 생명나눔 우체통 > 스킨관리 > 삭제 (스킨 사용 여부 확인)
	 * @param commandMap
	 * @return
	 */
	int selectUseSkinLetterId(Map<String, Object> commandMap);
	
	
	
	
	
	
	
	
	//----------------------------------------------------------------------------------------------------------------//	
	
	/**
	 * 생명나눔 우체통 > 우체통 관리 > 리스트
	 * @param commandMap
	 * @return
	 */
	List<Map<String, Object>> selectLetterList(Map<String, Object> commandMap);

	/**
	 * 생명나눔 우체통 > 우체통 관리 > 엑셀 다운로드
	 * @param commandMap
	 * @return
	 */
	boolean exportLetterList(Map<String, Object> commandMap);
	
	/**
	 * 생명나눔 우체통 > 우체통 관리 > 리스트 건수
	 * @param commandMap
	 * @return
	 */
	int selectLetterListTotCnt(Map<String, Object> commandMap);
	
	/**
	 * 생명나눔 우체통 > 우체통 관리 > 내용보기
	 * @param commandMap
	 * @return
	 */
	Map<String, Object> selectLetterView(Map<String, Object> commandMap);
	
	/**
	 * 생명나눔 우체통 > 우체통 관리 > 파일 목록
	 * @param commandMap
	 * @return
	 */
	List<Map<String, Object>> selectLetterFileList(Map<String, Object> commandMap);

	/**
	 * 생명나눔 우체통 > 우체통관리 > 편지쓰기 > 보내는 사람  > 검색(리스트)
	 * @param commandMap
	 * @return
	 */
	List<Map<String, Object>> selectLetterSenderSearchList(Map<String, Object> commandMap);

	/**
	 * 생명나눔 우체통 > 우체통관리 > 편지쓰기 > 보내는 사람  > 검색(총건수)
	 * @param commandMap
	 * @return
	 */
	int selectLetterSenderSearchListTotCnt(Map<String, Object> commandMap);

	/**
	 * 생명나눔 우체통 > 우체통관리 > 편지쓰기  > 저장
	 * @param commandMap
	 * @param multipartFile1 파일1
	 * @param multipartFile2 파일2
	 * @param multipartFile3 파일3
	 * @param request
	 * @return
	 */
	String saveLetterWrite(Map<String, Object> commandMap, MultipartFile multipartFile1, MultipartFile multipartFile2, MultipartFile multipartFile3, HttpServletRequest request);

	/**
	 * 생명나눔 우체통 > 우체통관리 > 편지쓰기  > 수정저장
	 * @param commandMap
	 * @param multipartFile1
	 * @param multipartFile2
	 * @param multipartFile3
	 * @param request
	 */
	void letterUpdate(Map<String, Object> commandMap, MultipartFile multipartFile1, MultipartFile multipartFile2, MultipartFile multipartFile3, HttpServletRequest request);

	/**
	 * 생명나눔 우체통 > 우체통관리 > 삭제
	 * @param commandMap
	 */
	void letterDelete(Map<String, Object> commandMap);
	
	/**
	 * 생명나눔 우체통 > 우체통관리 > 답글쓰기 > 관리자 예시글 > 검색(리스트)
	 * @param commandMap
	 * @return
	 */
	List<Map<String, Object>> selectLetterAdminSearchList(Map<String, Object> commandMap);
	
	/**
	 * 생명나눔 우체통 > 우체통관리 > 답글쓰기 > 관리자 예시글 > 검색(총건수)
	 * @param commandMap
	 * @return
	 */
	int selectLetterAdminSearchListTotCnt(Map<String, Object> commandMap);

	/**
	 * 생명나눔 우체통 > 우체통관리 > 답글쓰기 > 저장
	 * @param commandMap
	 * @param multipartFile1
	 * @param multipartFile2
	 * @param multipartFile3
	 * @param request
	 */
	String saveLetterReplyWrite(Map<String, Object> commandMap, MultipartFile multipartFile1, MultipartFile multipartFile2, MultipartFile multipartFile3, HttpServletRequest request);
	
	//----------------------------------------------------
	/**
	 * 생명나눔 우체통 > 관리자 예시관리 > 리스트
	 * @param commandMap
	 * @return
	 */
	List<Map<String, Object>> selectLetterAdminList(Map<String, Object> commandMap);

	/**
	 * 생명나눔 우체통 > 관리자 예시관리 > 리스트 (총 건수)
	 * @param commandMap
	 * @return
	 */
	int selectLetterAdminListTotCnt(Map<String, Object> commandMap);

	/**
	 * 생명나눔 우체통 > 관리자 예시관리 > 관리자 검색 > 리스트
	 * @param commandMap
	 * @return
	 */
	List<Map<String, Object>> selectAdminSearchList(Map<String, Object> commandMap);
	
	/**
	 * 생명나눔 우체통 > 관리자 예시관리 > 관리자 검색 > 리스트(총 건수)
	 * @param commandMap
	 * @return
	 */
	int selectAdminSearchListTotCnt(Map<String, Object> commandMap);
	
	/**
	 * 생명나눔 우체통 > 관리자 예시관리 > 저장
	 * @param commandMap
	 * @return
	 */
	String saveLetterAdmin(Map<String, Object> commandMap, HttpServletRequest request);

	/**
	 * 생명나눔 우체통 > 관리자 예시관리 > 수정저장
	 * @param commandMap
	 * @param request
	 */
	void updateLetterAdmin(Map<String, Object> commandMap, HttpServletRequest request);

	/**
	 * 생명나눔 우체통 > 관리자 예시관리 > 삭제
	 * @param commandMap
	 * @param request
	 */
	void deleteLetterAdmin(Map<String, Object> commandMap, HttpServletRequest request);

	/**
	 * 생명나눔 우체통 > 우체통관리, 발신대기함, 미승인대기목록 > 삭제할 시에 답글 여부 확인
	 * @param commandMap
	 * @return
	 */
	int selectLetterReplyCheck(Map<String, Object> commandMap);

	

	

	

	

	

	

	

	

	

	

	

	

	
	
}
  