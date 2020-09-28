package egovframework.webco.vo;

import java.util.List;

/**
 * @Class Name : PledgeRequestVO.java
 * @Description : 멤버십정보 저장 Request VO Class
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
public class PledgeReqDataVO {
	private String mdn = "";
	private String transactionId = "";
	private String mainStoreCd = "";
	private String cardMemberId = "";
	private String responseResult = "";
	private String cardGradeCode = "";
	private String startValidDt = "";
	private String endValidDt = "";
	private String customerNumber = "";
	private String partnerRtnCode = "";
	private String partnerRtnMessage = "";
	public String getMdn() {
		return mdn;
	}
	public void setMdn(String mdn) {
		this.mdn = mdn;
	}
	public String getTransactionId() {
		return transactionId;
	}
	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}
	public String getMainStoreCd() {
		return mainStoreCd;
	}
	public void setMainStoreCd(String mainStoreCd) {
		this.mainStoreCd = mainStoreCd;
	}
	public String getCardMemberId() {
		return cardMemberId;
	}
	public void setCardMemberId(String cardMemberId) {
		this.cardMemberId = cardMemberId;
	}
	public String getResponseResult() {
		return responseResult;
	}
	public void setResponseResult(String responseResult) {
		this.responseResult = responseResult;
	}
	public String getCardGradeCode() {
		return cardGradeCode;
	}
	public void setCardGradeCode(String cardGradeCode) {
		this.cardGradeCode = cardGradeCode;
	}
	public String getStartValidDt() {
		return startValidDt;
	}
	public void setStartValidDt(String startValidDt) {
		this.startValidDt = startValidDt;
	}
	public String getEndValidDt() {
		return endValidDt;
	}
	public void setEndValidDt(String endValidDt) {
		this.endValidDt = endValidDt;
	}
	public String getCustomerNumber() {
		return customerNumber;
	}
	public void setCustomerNumber(String customerNumber) {
		this.customerNumber = customerNumber;
	}
	public String getPartnerRtnCode() {
		return partnerRtnCode;
	}
	public void setPartnerRtnCode(String partnerRtnCode) {
		this.partnerRtnCode = partnerRtnCode;
	}
	public String getPartnerRtnMessage() {
		return partnerRtnMessage;
	}
	public void setPartnerRtnMessage(String partnerRtnMessage) {
		this.partnerRtnMessage = partnerRtnMessage;
	}			
}
