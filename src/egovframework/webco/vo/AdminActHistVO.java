package egovframework.webco.vo;

import java.io.Serializable;

/**
 * @Class Name : AdminActHistVO.java
 * @Description : 관리자 활동내역 정보 VO Class
 * @Modification Information
 * 
 *   수정일      수정자    수정내용 
 * ----------  -------- ---------------------------
 * 2019.12.12    novam    최초 생성
 * 
 * @author webco
 * @since 2019.12.12
 * @version 1.0
 * @see
 * 
 */
public class AdminActHistVO extends CommonVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	/* 활동내역 일련번호 */
	private int act_index;
	
	/* 관리자 일련번호 */
	private int admin_index;
	
	/* 활동구분 */
    private String act_type;
    
    /* 활동URL */
    private String act_url;
    
    /* 활동내역 */
    private String act_detail;
    
    /* 접속IP */
    private String act_ip;
    
    /* 활동일시 */
    private String act_time;

	public int getAct_index() {
		return act_index;
	}

	public void setAct_index(int act_index) {
		this.act_index = act_index;
	}

	public int getAdmin_index() {
		return admin_index;
	}

	public void setAdmin_index(int admin_index) {
		this.admin_index = admin_index;
	}

	public String getAct_type() {
		return act_type;
	}

	public void setAct_type(String act_type) {
		this.act_type = act_type;
	}

	public String getAct_url() {
		return act_url;
	}

	public void setAct_url(String act_url) {
		this.act_url = act_url;
	}

	public String getAct_detail() {
		return act_detail;
	}

	public void setAct_detail(String act_detail) {
		this.act_detail = act_detail;
	}

	public String getAct_ip() {
		return act_ip;
	}

	public void setAct_ip(String act_ip) {
		this.act_ip = act_ip;
	}

	public String getAct_time() {
		return act_time;
	}

	public void setAct_time(String act_time) {
		this.act_time = act_time;
	}

	@Override
	public String toString() {
		return "AdminActHistVO [act_index=" + act_index + ", admin_index=" + admin_index + ", "
				+ (act_type != null ? "act_type=" + act_type + ", " : "")
				+ (act_url != null ? "act_url=" + act_url + ", " : "")
				+ (act_detail != null ? "act_detail=" + act_detail + ", " : "")
				+ (act_ip != null ? "act_ip=" + act_ip + ", " : "") + (act_time != null ? "act_time=" + act_time : "")
				+ "]";
	}   
}
