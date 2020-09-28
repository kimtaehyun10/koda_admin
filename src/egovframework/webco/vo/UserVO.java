package egovframework.webco.vo;

import java.io.Serializable;

/**
 * @Class Name : UserVO.java
 * @Description : 사용자 정보 VO Class
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
public class UserVO {	
	
	private int user_index = 0;
	private String user_num = "";
	private String user_name = "";
	private String user_social_security_num = "";
	private String user_social_security_num_0 = "";
	private String user_social_security_num_1 = "";
	private int user_birthday = 0;
	private int user_age = 0;
	private int user_sex = 0;
	private String user_email = "";
	private String user_email_1 = "";
	private String user_email_2 = "";
	private String user_post = "";
	private String user_address = "";
	private String user_address_detail = "";
	private String user_send_post = "";
	private String user_send_address = "";
	private String user_send_address_detail = "";
	private String user_mobile = "";
	private String user_mobile_0 = "";
	private String user_mobile_1 = "";
	private String user_mobile_2 = "";
	private String user_phone = "";
	private String user_phone_0 = "";
	private String user_phone_1 = "";
	private String user_phone_2 = "";
	private int user_recognize_type = 0;
	private int user_donation_type_body = 0;
	private int user_donation_type_organ = 0;
	private int user_donation_type_comea = 0;
	private int user_is_driving_license = 0;
	private int user_konos_register_state = 0;
	private int user_pledge_date = 0;
	private int user_registration_date = 0;
	private int user_konos_registration_date = 0;
	private String user_register = "";
	private int user_register_channel = 0;
	private int user_withdraw_date = 0;
	private int user_withdraw_reason = 0;
	private int user_withdraw_way = 0;
	private int user_konos_withdraw_date = 0;
	private int user_is_email_agree = 0;
	private int user_is_sms_agree = 0;
	private int user_is_mail_agree = 0;
	private int user_pledge_card_state = 0;
	private String user_legal_representative_info = "";
	private int user_is_legal_representative_text = 0;
	private String ipin_vno = "";
	private String ipin_ci = "";
	private String ipin_dup_info = "";
	private int ipin_result_index = 0;
	private String checkplus_dupinfo = "";
	private String checkplus_conninfo = "";
	private int checkplus_result_index = 0;
	private String syrup_ci = "";
	private int create_time = 0;
	private int update_time = 0;

	private String status = "";
	private String showCard = "";
	public int getUser_index() {
		return user_index;
	}
	public void setUser_index(int user_index) {
		this.user_index = user_index;
	}
	public String getUser_num() {
		return user_num;
	}
	public void setUser_num(String user_num) {
		this.user_num = user_num;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_social_security_num() {
		return user_social_security_num;
	}
	public void setUser_social_security_num(String user_social_security_num) {
		this.user_social_security_num = user_social_security_num;
	}
	public String getUser_social_security_num_0() {
		return user_social_security_num_0;
	}
	public void setUser_social_security_num_0(String user_social_security_num_0) {
		this.user_social_security_num_0 = user_social_security_num_0;
	}
	public String getUser_social_security_num_1() {
		return user_social_security_num_1;
	}
	public void setUser_social_security_num_1(String user_social_security_num_1) {
		this.user_social_security_num_1 = user_social_security_num_1;
	}
	public int getUser_birthday() {
		return user_birthday;
	}
	public void setUser_birthday(int user_birthday) {
		this.user_birthday = user_birthday;
	}
	public int getUser_age() {
		return user_age;
	}
	public void setUser_age(int user_age) {
		this.user_age = user_age;
	}
	public int getUser_sex() {
		return user_sex;
	}
	public void setUser_sex(int user_sex) {
		this.user_sex = user_sex;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_email_1() {
		return user_email_1;
	}
	public void setUser_email_1(String user_email_1) {
		this.user_email_1 = user_email_1;
	}
	public String getUser_email_2() {
		return user_email_2;
	}
	public void setUser_email_2(String user_email_2) {
		this.user_email_2 = user_email_2;
	}
	public String getUser_post() {
		return user_post;
	}
	public void setUser_post(String user_post) {
		this.user_post = user_post;
	}
	public String getUser_address() {
		return user_address;
	}
	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}
	public String getUser_address_detail() {
		return user_address_detail;
	}
	public void setUser_address_detail(String user_address_detail) {
		this.user_address_detail = user_address_detail;
	}
	public String getUser_send_post() {
		return user_send_post;
	}
	public void setUser_send_post(String user_send_post) {
		this.user_send_post = user_send_post;
	}
	public String getUser_send_address() {
		return user_send_address;
	}
	public void setUser_send_address(String user_send_address) {
		this.user_send_address = user_send_address;
	}
	public String getUser_send_address_detail() {
		return user_send_address_detail;
	}
	public void setUser_send_address_detail(String user_send_address_detail) {
		this.user_send_address_detail = user_send_address_detail;
	}
	public String getUser_mobile() {
		return user_mobile;
	}
	public void setUser_mobile(String user_mobile) {
		this.user_mobile = user_mobile;
	}
	public String getUser_mobile_0() {
		return user_mobile_0;
	}
	public void setUser_mobile_0(String user_mobile_0) {
		this.user_mobile_0 = user_mobile_0;
	}
	public String getUser_mobile_1() {
		return user_mobile_1;
	}
	public void setUser_mobile_1(String user_mobile_1) {
		this.user_mobile_1 = user_mobile_1;
	}
	public String getUser_mobile_2() {
		return user_mobile_2;
	}
	public void setUser_mobile_2(String user_mobile_2) {
		this.user_mobile_2 = user_mobile_2;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_phone_0() {
		return user_phone_0;
	}
	public void setUser_phone_0(String user_phone_0) {
		this.user_phone_0 = user_phone_0;
	}
	public String getUser_phone_1() {
		return user_phone_1;
	}
	public void setUser_phone_1(String user_phone_1) {
		this.user_phone_1 = user_phone_1;
	}
	public String getUser_phone_2() {
		return user_phone_2;
	}
	public void setUser_phone_2(String user_phone_2) {
		this.user_phone_2 = user_phone_2;
	}
	public int getUser_recognize_type() {
		return user_recognize_type;
	}
	public void setUser_recognize_type(int user_recognize_type) {
		this.user_recognize_type = user_recognize_type;
	}
	public int getUser_donation_type_body() {
		return user_donation_type_body;
	}
	public void setUser_donation_type_body(int user_donation_type_body) {
		this.user_donation_type_body = user_donation_type_body;
	}
	public int getUser_donation_type_organ() {
		return user_donation_type_organ;
	}
	public void setUser_donation_type_organ(int user_donation_type_organ) {
		this.user_donation_type_organ = user_donation_type_organ;
	}
	public int getUser_donation_type_comea() {
		return user_donation_type_comea;
	}
	public void setUser_donation_type_comea(int user_donation_type_comea) {
		this.user_donation_type_comea = user_donation_type_comea;
	}
	public int getUser_is_driving_license() {
		return user_is_driving_license;
	}
	public void setUser_is_driving_license(int user_is_driving_license) {
		this.user_is_driving_license = user_is_driving_license;
	}
	public int getUser_konos_register_state() {
		return user_konos_register_state;
	}
	public void setUser_konos_register_state(int user_konos_register_state) {
		this.user_konos_register_state = user_konos_register_state;
	}
	public int getUser_pledge_date() {
		return user_pledge_date;
	}
	public void setUser_pledge_date(int user_pledge_date) {
		this.user_pledge_date = user_pledge_date;
	}
	public int getUser_registration_date() {
		return user_registration_date;
	}
	public void setUser_registration_date(int user_registration_date) {
		this.user_registration_date = user_registration_date;
	}
	public int getUser_konos_registration_date() {
		return user_konos_registration_date;
	}
	public void setUser_konos_registration_date(int user_konos_registration_date) {
		this.user_konos_registration_date = user_konos_registration_date;
	}
	public String getUser_register() {
		return user_register;
	}
	public void setUser_register(String user_register) {
		this.user_register = user_register;
	}
	public int getUser_register_channel() {
		return user_register_channel;
	}
	public void setUser_register_channel(int user_register_channel) {
		this.user_register_channel = user_register_channel;
	}
	public int getUser_withdraw_date() {
		return user_withdraw_date;
	}
	public void setUser_withdraw_date(int user_withdraw_date) {
		this.user_withdraw_date = user_withdraw_date;
	}
	public int getUser_withdraw_reason() {
		return user_withdraw_reason;
	}
	public void setUser_withdraw_reason(int user_withdraw_reason) {
		this.user_withdraw_reason = user_withdraw_reason;
	}
	public int getUser_withdraw_way() {
		return user_withdraw_way;
	}
	public void setUser_withdraw_way(int user_withdraw_way) {
		this.user_withdraw_way = user_withdraw_way;
	}
	public int getUser_konos_withdraw_date() {
		return user_konos_withdraw_date;
	}
	public void setUser_konos_withdraw_date(int user_konos_withdraw_date) {
		this.user_konos_withdraw_date = user_konos_withdraw_date;
	}
	public int getUser_is_email_agree() {
		return user_is_email_agree;
	}
	public void setUser_is_email_agree(int user_is_email_agree) {
		this.user_is_email_agree = user_is_email_agree;
	}
	public int getUser_is_sms_agree() {
		return user_is_sms_agree;
	}
	public void setUser_is_sms_agree(int user_is_sms_agree) {
		this.user_is_sms_agree = user_is_sms_agree;
	}
	public int getUser_is_mail_agree() {
		return user_is_mail_agree;
	}
	public void setUser_is_mail_agree(int user_is_mail_agree) {
		this.user_is_mail_agree = user_is_mail_agree;
	}
	public int getUser_pledge_card_state() {
		return user_pledge_card_state;
	}
	public void setUser_pledge_card_state(int user_pledge_card_state) {
		this.user_pledge_card_state = user_pledge_card_state;
	}
	public String getUser_legal_representative_info() {
		return user_legal_representative_info;
	}
	public void setUser_legal_representative_info(String user_legal_representative_info) {
		this.user_legal_representative_info = user_legal_representative_info;
	}
	public int getUser_is_legal_representative_text() {
		return user_is_legal_representative_text;
	}
	public void setUser_is_legal_representative_text(int user_is_legal_representative_text) {
		this.user_is_legal_representative_text = user_is_legal_representative_text;
	}
	public String getIpin_vno() {
		return ipin_vno;
	}
	public void setIpin_vno(String ipin_vno) {
		this.ipin_vno = ipin_vno;
	}
	public String getIpin_ci() {
		return ipin_ci;
	}
	public void setIpin_ci(String ipin_ci) {
		this.ipin_ci = ipin_ci;
	}
	public String getIpin_dup_info() {
		return ipin_dup_info;
	}
	public void setIpin_dup_info(String ipin_dup_info) {
		this.ipin_dup_info = ipin_dup_info;
	}
	public int getIpin_result_index() {
		return ipin_result_index;
	}
	public void setIpin_result_index(int ipin_result_index) {
		this.ipin_result_index = ipin_result_index;
	}
	public String getCheckplus_dupinfo() {
		return checkplus_dupinfo;
	}
	public void setCheckplus_dupinfo(String checkplus_dupinfo) {
		this.checkplus_dupinfo = checkplus_dupinfo;
	}
	public String getCheckplus_conninfo() {
		return checkplus_conninfo;
	}
	public void setCheckplus_conninfo(String checkplus_conninfo) {
		this.checkplus_conninfo = checkplus_conninfo;
	}
	public int getCheckplus_result_index() {
		return checkplus_result_index;
	}
	public void setCheckplus_result_index(int checkplus_result_index) {
		this.checkplus_result_index = checkplus_result_index;
	}
	public String getSyrup_ci() {
		return syrup_ci;
	}
	public void setSyrup_ci(String syrup_ci) {
		this.syrup_ci = syrup_ci;
	}
	public int getCreate_time() {
		return create_time;
	}
	public void setCreate_time(int create_time) {
		this.create_time = create_time;
	}
	public int getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(int update_time) {
		this.update_time = update_time;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getShowCard() {
		return showCard;
	}
	public void setShowCard(String showCard) {
		this.showCard = showCard;
	}
	@Override
	public String toString() {
		return "UserVO [user_index=" + user_index + ", " + (user_num != null ? "user_num=" + user_num + ", " : "")
				+ (user_name != null ? "user_name=" + user_name + ", " : "")
				+ (user_social_security_num != null ? "user_social_security_num=" + user_social_security_num + ", "
						: "")
				+ (user_social_security_num_0 != null
						? "user_social_security_num_0=" + user_social_security_num_0 + ", " : "")
				+ (user_social_security_num_1 != null
						? "user_social_security_num_1=" + user_social_security_num_1 + ", " : "")
				+ "user_birthday=" + user_birthday + ", user_age=" + user_age + ", user_sex=" + user_sex + ", "
				+ (user_email != null ? "user_email=" + user_email + ", " : "")
				+ (user_email_1 != null ? "user_email_1=" + user_email_1 + ", " : "")
				+ (user_email_2 != null ? "user_email_2=" + user_email_2 + ", " : "")
				+ (user_post != null ? "user_post=" + user_post + ", " : "")
				+ (user_address != null ? "user_address=" + user_address + ", " : "")
				+ (user_address_detail != null ? "user_address_detail=" + user_address_detail + ", " : "")
				+ (user_send_post != null ? "user_send_post=" + user_send_post + ", " : "")
				+ (user_send_address != null ? "user_send_address=" + user_send_address + ", " : "")
				+ (user_send_address_detail != null ? "user_send_address_detail=" + user_send_address_detail + ", "
						: "")
				+ (user_mobile != null ? "user_mobile=" + user_mobile + ", " : "")
				+ (user_mobile_0 != null ? "user_mobile_0=" + user_mobile_0 + ", " : "")
				+ (user_mobile_1 != null ? "user_mobile_1=" + user_mobile_1 + ", " : "")
				+ (user_mobile_2 != null ? "user_mobile_2=" + user_mobile_2 + ", " : "")
				+ (user_phone != null ? "user_phone=" + user_phone + ", " : "")
				+ (user_phone_0 != null ? "user_phone_0=" + user_phone_0 + ", " : "")
				+ (user_phone_1 != null ? "user_phone_1=" + user_phone_1 + ", " : "")
				+ (user_phone_2 != null ? "user_phone_2=" + user_phone_2 + ", " : "") + "user_recognize_type="
				+ user_recognize_type + ", user_donation_type_body=" + user_donation_type_body
				+ ", user_donation_type_organ=" + user_donation_type_organ + ", user_donation_type_comea="
				+ user_donation_type_comea + ", user_is_driving_license=" + user_is_driving_license
				+ ", user_konos_register_state=" + user_konos_register_state + ", user_pledge_date=" + user_pledge_date
				+ ", user_registration_date=" + user_registration_date + ", user_konos_registration_date="
				+ user_konos_registration_date + ", "
				+ (user_register != null ? "user_register=" + user_register + ", " : "") + "user_register_channel="
				+ user_register_channel + ", user_withdraw_date=" + user_withdraw_date + ", user_withdraw_reason="
				+ user_withdraw_reason + ", user_withdraw_way=" + user_withdraw_way + ", user_konos_withdraw_date="
				+ user_konos_withdraw_date + ", user_is_email_agree=" + user_is_email_agree + ", user_is_sms_agree="
				+ user_is_sms_agree + ", user_is_mail_agree=" + user_is_mail_agree + ", user_pledge_card_state="
				+ user_pledge_card_state + ", "
				+ (user_legal_representative_info != null
						? "user_legal_representative_info=" + user_legal_representative_info + ", " : "")
				+ "user_is_legal_representative_text=" + user_is_legal_representative_text + ", "
				+ (ipin_vno != null ? "ipin_vno=" + ipin_vno + ", " : "")
				+ (ipin_ci != null ? "ipin_ci=" + ipin_ci + ", " : "")
				+ (ipin_dup_info != null ? "ipin_dup_info=" + ipin_dup_info + ", " : "") + "ipin_result_index="
				+ ipin_result_index + ", "
				+ (checkplus_dupinfo != null ? "checkplus_dupinfo=" + checkplus_dupinfo + ", " : "")
				+ (checkplus_conninfo != null ? "checkplus_conninfo=" + checkplus_conninfo + ", " : "")
				+ "checkplus_result_index=" + checkplus_result_index + ", "
				+ (syrup_ci != null ? "syrup_ci=" + syrup_ci + ", " : "") + "create_time=" + create_time
				+ ", update_time=" + update_time + ", " + (status != null ? "status=" + status + ", " : "")
				+ (showCard != null ? "showCard=" + showCard : "") + "]";
	}
	
	
}
