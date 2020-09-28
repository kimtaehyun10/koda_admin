package egovframework.webco.vo;

import java.util.List;

/**
 * @Class Name : SyrupResponseVO.java
 * @Description : 시럽 Response VO Class
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
public class SyrupResponseVO {
	
	// 요청시 전달 받은 trNo
	private String trNo;
	// 요청시 전달 받은 trDt
	private String trDt;
	// 처리 결과값 "0000" 성공
	private String rCode;
	// rCode가 "0000"이 아닐경우 메시지 처리
	private String rMsg;
	// 멤버쉽번호
	private String cardNo;
	// 멤버십등급코드 - syrupWallet에 선등록한 등급코드
	private String cardGrade;
	// 고객관리번호 - 제휴사에서 관리하는 고객회원번호 or ID	
	private String userMgntNo;
	// 가입구분 (0: 가입 구분 알 수 없음, 1: 기존회원, 2: 신규, 5: 완전 탈퇴회원)
	private String issueType;
	// 유효기간시작일시(YYYYMMDDHH24MISS)
	private String periodStartDate;
	// 유효기간종료일시(YYYYMMDDHH24MISS)
	private String periodEndDate;
	// 유효기간 안내문구
	// 해당 문구가 있는 경우 유효시작일시/종료일시는 무시하고 안내문구만 화면에 보여주게 된다.
	private String periodComment;
	// 쿠폰 수량(존재하지 않을 시 0)
	private String couponCnt;
	
	private String callBackUrl;	
	
	public SyrupResponseVO() {
		super();
	}

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

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getCardGrade() {
		return cardGrade;
	}

	public void setCardGrade(String cardGrade) {
		this.cardGrade = cardGrade;
	}

	public String getUserMgntNo() {
		return userMgntNo;
	}

	public void setUserMgntNo(String userMgntNo) {
		this.userMgntNo = userMgntNo;
	}

	public String getIssueType() {
		return issueType;
	}

	public void setIssueType(String issueType) {
		this.issueType = issueType;
	}

	public String getPeriodStartDate() {
		return periodStartDate;
	}

	public void setPeriodStartDate(String periodStartDate) {
		this.periodStartDate = periodStartDate;
	}

	public String getPeriodEndDate() {
		return periodEndDate;
	}

	public void setPeriodEndDate(String periodEndDate) {
		this.periodEndDate = periodEndDate;
	}

	public String getPeriodComment() {
		return periodComment;
	}

	public void setPeriodComment(String periodComment) {
		this.periodComment = periodComment;
	}

	public String getCouponCnt() {
		return couponCnt;
	}

	public void setCouponCnt(String couponCnt) {
		this.couponCnt = couponCnt;
	}
	
	public String getCallBackUrl() {
		return callBackUrl;
	}

	public void setCallBackUrl(String callBackUrl) {
		this.callBackUrl = callBackUrl;
	}

	@Override 
	public String toString() {
		return "SyrupResponseVO [" + (trNo != null ? "trNo=" + trNo + ", " : "")
				+ (trDt != null ? "trDt=" + trDt + ", " : "") + (rCode != null ? "rCode=" + rCode + ", " : "")
				+ (rMsg != null ? "rMsg=" + rMsg + ", " : "") + (cardNo != null ? "cartNo=" + cardNo + ", " : "")
				+ (cardGrade != null ? "cardGrade=" + cardGrade + ", " : "")
				+ (userMgntNo != null ? "userMgntNo=" + userMgntNo + ", " : "")
				+ (issueType != null ? "issueType=" + issueType + ", " : "")
				+ (periodStartDate != null ? "periodStartDate=" + periodStartDate + ", " : "")
				+ (periodEndDate != null ? "periodEndDate=" + periodEndDate + ", " : "")
				+ (periodComment != null ? "periodComment=" + periodComment + ", " : "")
				+ (couponCnt != null ? "couponCnt=" + couponCnt + ", " : "")
				+ (callBackUrl != null ? "callBackUrl=" + callBackUrl : "") + "]";
	}
	
}
