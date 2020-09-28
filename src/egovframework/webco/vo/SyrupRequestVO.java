package egovframework.webco.vo;

import java.util.List;

/**
 * @Class Name : SyrupRequestVO.java
 * @Description : 시럽 Request VO Class
 * @Modification Information
 * 
 *   수정일      수정자    수정내용 
 * ----------  -------- ---------------------------
 * 2019.05.07    novam    최초 생성
 * 
 * @author webco
 * @since 2019.05.07
 * @version 1.0
 * @see
 * 
 */
public class SyrupRequestVO {
	
	// 전문추적번호(YYYYMMDDHH24MISS + random 3자리 )
	private String trNo = "";
	// 요청일시(YYYYMMDDHH24MISS)
	private String trDt = "";
	// 고객명
	private String korName = "";	
	// 핸드폰번호( - 제거 )
	private String mdn = "";
	
	private String birthdayType = "";
	// 생년월일 (yyyyMMdd)
	private String birthday = "";
	// 성별 M:남성, F:여성
	private String gender = "";
	// 내외국인코드 K:한국, A:외국
	private String nationality = "";
	// i-PIN CI (카드 발급 Key)
	private String ipinCi = "";
	// Y:신주소(도로명), N:구주소
	private String newAddrYN = "";	 
	private String addrType = "";
	// 우편번호(- 제거된 5자리 숫자)
	private String zipCode = "";
	// 기본주소
	private String basicAddr = "";
	// 상세주소
	private String detailAddr = "";
	// E-Mail
	private String email = "";
	// 통신사 0:SKT, 1:KT, 2:LGT
	private String telco = "";
	// 보호자 이름
	private String guardianName = "";
	// 보호자 생일
	private String guardianBirthday = "";
	// 보호자 성별
	private String guardianGender = "";
	// 보호자 휴대폰번호
	private String guardianMdn = "";
	// 보호자 통신사 코드 0:SKT, 1:KT, 2:LGT
	private String guardianTelco = "";
	// 보호자 내외국인코드 K:한국, A:외국
	private String guardianNationality = "";
	// 보호자와의 관계 (부모 : 0, 조부모 : 1, 기타 : 9)
	private String guardianType = "";	
	// Transaction No (신규가입일 경우 Call Back URL에 파라미터로 전달 되어야 하는 값. 96Byte 이상의 길이)
	private String paymentTrNo = "";
	// 약관수(존재하지 않을시 0)
	private String agreementCnt = "";
	
	private String rCode = "";
	private String rMsg = "";
	private int user_index = 0;
	private String cardNo = "";
	private String issueType = "";
	private int issue_membership_index = 0;
	
	private List<SyrupAgreement> Agreement;

	public String getTrNo() {
		return trNo;
	}

	public void setTrNo(String trNo) {
		this.trNo = trNo;
	}

	public String getTrDt() {
		return trDt;
	}

	public void setTrDt(String trDt) {
		this.trDt = trDt;
	}

	public String getKorName() {
		return korName;
	}

	public void setKorName(String korName) {
		this.korName = korName;
	}

	public String getMdn() {
		return mdn;
	}

	public void setMdn(String mdn) {
		this.mdn = mdn;
	}

	public String getBirthdayType() {
		return birthdayType;
	}

	public void setBirthdayType(String birthdayType) {
		this.birthdayType = birthdayType;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public String getIpinCi() {
		return ipinCi;
	}

	public void setIpinCi(String ipinCi) {
		this.ipinCi = ipinCi;
	}

	public String getNewAddrYN() {
		return newAddrYN;
	}

	public void setNewAddrYN(String newAddrYN) {
		this.newAddrYN = newAddrYN;
	}

	public String getAddrType() {
		return addrType;
	}

	public void setAddrType(String addrType) {
		this.addrType = addrType;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getBasicAddr() {
		return basicAddr;
	}

	public void setBasicAddr(String basicAddr) {
		this.basicAddr = basicAddr;
	}

	public String getDetailAddr() {
		return detailAddr;
	}

	public void setDetailAddr(String detailAddr) {
		this.detailAddr = detailAddr;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTelco() {
		return telco;
	}

	public void setTelco(String telco) {
		this.telco = telco;
	}

	public String getGuardianName() {
		return guardianName;
	}

	public void setGuardianName(String guardianName) {
		this.guardianName = guardianName;
	}

	public String getGuardianBirthday() {
		return guardianBirthday;
	}

	public void setGuardianBirthday(String guardianBirthday) {
		this.guardianBirthday = guardianBirthday;
	}

	public String getGuardianGender() {
		return guardianGender;
	}

	public void setGuardianGender(String guardianGender) {
		this.guardianGender = guardianGender;
	}

	public String getGuardianMdn() {
		return guardianMdn;
	}

	public void setGuardianMdn(String guardianMdn) {
		this.guardianMdn = guardianMdn;
	}

	public String getGuardianTelco() {
		return guardianTelco;
	}

	public void setGuardianTelco(String guardianTelco) {
		this.guardianTelco = guardianTelco;
	}

	public String getGuardianNationality() {
		return guardianNationality;
	}

	public void setGuardianNationality(String guardianNationality) {
		this.guardianNationality = guardianNationality;
	}

	public String getGuardianType() {
		return guardianType;
	}

	public void setGuardianType(String guardianType) {
		this.guardianType = guardianType;
	}

	public String getPaymentTrNo() {
		return paymentTrNo;
	}

	public void setPaymentTrNo(String paymentTrNo) {
		this.paymentTrNo = paymentTrNo;
	}

	public String getAgreementCnt() {
		return agreementCnt;
	}

	public void setAgreementCnt(String agreementCnt) {
		this.agreementCnt = agreementCnt;
	}

	public List<SyrupAgreement> getAgreement() {
		return Agreement;
	}

	public void setAgreement(List<SyrupAgreement> agreement) {
		Agreement = agreement;
	}

	public int getUser_index() {
		return user_index;
	}

	public void setUser_index(int user_index) {
		this.user_index = user_index;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getIssueType() {
		return issueType;
	}

	public void setIssueType(String issueType) {
		this.issueType = issueType;
	}

	public String getrCode() {
		return rCode;
	}

	public void setrCode(String rCode) {
		this.rCode = rCode;
	}

	public String getrMsg() {
		return rMsg;
	}

	public void setrMsg(String rMsg) {
		this.rMsg = rMsg;
	}

	public int getIssue_membership_index() {
		return issue_membership_index;
	}

	public void setIssue_membership_index(int issue_membership_index) {
		this.issue_membership_index = issue_membership_index;
	}

	@Override
	public String toString() {
		return "SyrupRequestVO [" + (trNo != null ? "trNo=" + trNo + ", " : "")
				+ (trDt != null ? "trDt=" + trDt + ", " : "") + (korName != null ? "korName=" + korName + ", " : "")
				+ (mdn != null ? "mdn=" + mdn + ", " : "") + (birthday != null ? "birthday=" + birthday + ", " : "")
				+ (gender != null ? "gender=" + gender + ", " : "")
				+ (nationality != null ? "nationality=" + nationality + ", " : "")
				+ (ipinCi != null ? "ipinCi=" + ipinCi + ", " : "")
				+ (newAddrYN != null ? "newAddrYN=" + newAddrYN + ", " : "")
				+ (zipCode != null ? "zipCode=" + zipCode + ", " : "")
				+ (basicAddr != null ? "basicAddr=" + basicAddr + ", " : "")
				+ (detailAddr != null ? "detailAddr=" + detailAddr + ", " : "")
				+ (email != null ? "email=" + email + ", " : "") + (telco != null ? "telco=" + telco + ", " : "")
				+ (guardianName != null ? "guardianName=" + guardianName + ", " : "")
				+ (guardianBirthday != null ? "guardianBirthday=" + guardianBirthday + ", " : "")
				+ (guardianGender != null ? "guardianGender=" + guardianGender + ", " : "")
				+ (guardianMdn != null ? "guardianMdn=" + guardianMdn + ", " : "")
				+ (guardianTelco != null ? "guardianTelco=" + guardianTelco + ", " : "")
				+ (guardianNationality != null ? "guardianNationality=" + guardianNationality + ", " : "")
				+ (guardianType != null ? "guardianType=" + guardianType + ", " : "")
				+ (paymentTrNo != null ? "paymentTrNo=" + paymentTrNo + ", " : "")
				+ (agreementCnt != null ? "agreementCnt=" + agreementCnt + ", " : "") + "user_index=" + user_index
				+ ", " + (cardNo != null ? "cardNo=" + cardNo + ", " : "")
				+ (issueType != null ? "issueType=" + issueType : "") + "]";
	}		
}
