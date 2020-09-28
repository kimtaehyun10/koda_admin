package egovframework.webco.vo;

import java.io.Serializable;

/**
 * @Class Name : AdminVO.java
 * @Description : 관리자 정보 VO Class
 * @Modification Information
 * 
 *   수정일      수정자    수정내용 
 * ----------  -------- ---------------------------
 * 2019.04.08    novam    최초 생성
 * 
 * @author webco
 * @since 2019.04.08
 * @version 1.0
 * @see
 * 
 */
public class SearchVO extends CommonVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	/* 관리자 일련번호 */
	private int adminIndex;
	
	/* 관리자 아이디 */
    private String adminId;
    
    /* 관리자 비밀번호 */
    private String adminPwd;
    
    /* 관리자 닉네임 */
    private String adminNickName;
    
    /* 관리자 등급 */
    private String adminGrade;
    
    /* 관리자 등록일시 */
    private String adminCreateTime;

	public int getAdminIndex() {
		return adminIndex;
	}

	public void setAdminIndex(int adminIndex) {
		this.adminIndex = adminIndex;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getAdminPwd() {
		return adminPwd;
	}

	public void setAdminPwd(String adminPwd) {
		this.adminPwd = adminPwd;
	}

	public String getAdminNickName() {
		return adminNickName;
	}

	public void setAdminNickName(String adminNickName) {
		this.adminNickName = adminNickName;
	}

	public String getAdminGrade() {
		return adminGrade;
	}

	public void setAdminGrade(String adminGrade) {
		this.adminGrade = adminGrade;
	}

	public String getAdminCreateTime() {
		return adminCreateTime;
	}

	public void setAdminCreateTime(String adminCreateTime) {
		this.adminCreateTime = adminCreateTime;
	}
    
}
