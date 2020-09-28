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
public class AdminVO extends CommonVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	/* 관리자 일련번호 */
	private int admin_index;
	
	/* 관리자 아이디 */
    private String admin_id;
    
    /* 관리자 비밀번호 */
    private String admin_pwd;
    
    /* 관리자 닉네임 */
    private String admin_nick_name;
    
    /* 관리자 등급 */
    private String admin_grade;
    
    /* 관리자 등록일시 */
    private String admin_create_time;
    
    /* 관리자 휴대폰 */
    private String admin_phone;
    
    /* 로그인 실패 횟수 */
    private int login_fail_cnt = 0;
    
    /* 마지막 접속시간 */
    private String last_login_time;
    
    /* 비밀번호 변경일시 */
    private String admin_pwd_chg_time;
    
    private int admin_chg_pwd = 0;

	public int getAdmin_index() {
		return admin_index;
	}

	public void setAdmin_index(int admin_index) {
		this.admin_index = admin_index;
	}

	public String getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}

	public String getAdmin_pwd() {
		return admin_pwd;
	}

	public void setAdmin_pwd(String admin_pwd) {
		this.admin_pwd = admin_pwd;
	}

	public String getAdmin_nick_name() {
		return admin_nick_name;
	}

	public void setAdmin_nick_name(String admin_nick_name) {
		this.admin_nick_name = admin_nick_name;
	}

	public String getAdmin_grade() {
		return admin_grade;
	}

	public void setAdmin_grade(String admin_grade) {
		this.admin_grade = admin_grade;
	}

	public String getAdmin_create_time() {
		return admin_create_time;
	}

	public void setAdmin_create_time(String admin_create_time) {
		this.admin_create_time = admin_create_time;
	}

	public String getAdmin_phone() {
		return admin_phone;
	}

	public void setAdmin_phone(String admin_phone) {
		this.admin_phone = admin_phone;
	}

	public int getLogin_fail_cnt() {
		return login_fail_cnt;
	}

	public void setLogin_fail_cnt(int login_fail_cnt) {
		this.login_fail_cnt = login_fail_cnt;
	}

	public String getLast_login_time() {
		return last_login_time;
	}

	public void setLast_login_time(String last_login_time) {
		this.last_login_time = last_login_time;
	}

	public String getAdmin_pwd_chg_time() {
		return admin_pwd_chg_time;
	}

	public void setAdmin_pwd_chg_time(String admin_pwd_chg_time) {
		this.admin_pwd_chg_time = admin_pwd_chg_time;
	}

	public int getAdmin_chg_pwd() {
		return admin_chg_pwd;
	}

	public void setAdmin_chg_pwd(int admin_chg_pwd) {
		this.admin_chg_pwd = admin_chg_pwd;
	}

	@Override
	public String toString() {
		return "AdminVO [admin_index=" + admin_index + ", " + (admin_id != null ? "admin_id=" + admin_id + ", " : "")
				+ (admin_pwd != null ? "admin_pwd=" + admin_pwd + ", " : "")
				+ (admin_nick_name != null ? "admin_nick_name=" + admin_nick_name + ", " : "")
				+ (admin_grade != null ? "admin_grade=" + admin_grade + ", " : "")
				+ (admin_create_time != null ? "admin_create_time=" + admin_create_time + ", " : "")
				+ (admin_phone != null ? "admin_phone=" + admin_phone + ", " : "") + "login_fail_cnt=" + login_fail_cnt
				+ ", " + (last_login_time != null ? "last_login_time=" + last_login_time + ", " : "")
				+ (admin_pwd_chg_time != null ? "admin_pwd_chg_time=" + admin_pwd_chg_time + ", " : "")
				+ "admin_chg_pwd=" + admin_chg_pwd + "]";
	}
		
}
