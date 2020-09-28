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
public class PledgeHeaderDataVO {
	private String partnerId = "";
	private String partnerSiteId = "";
	private String trDt = "";
	private String trNo = "";
	private String rtnCode = "";
	private String rtnMsg = "";
	
	public String getPartnerId() {
		return partnerId;
	}
	public void setPartnerId(String partnerId) {
		this.partnerId = partnerId;
	}
	public String getPartnerSiteId() {
		return partnerSiteId;
	}
	public void setPartnerSiteId(String partnerSiteId) {
		this.partnerSiteId = partnerSiteId;
	}
	public String getTrDt() {
		return trDt;
	}
	public void setTrDt(String trDt) {
		this.trDt = trDt;
	}
	public String getTrNo() {
		return trNo;
	}
	public void setTrNo(String trNo) {
		this.trNo = trNo;
	}
	public String getRtnCode() {
		return rtnCode;
	}
	public void setRtnCode(String rtnCode) {
		this.rtnCode = rtnCode;
	}
	public String getRtnMsg() {
		return rtnMsg;
	}
	public void setRtnMsg(String rtnMsg) {
		this.rtnMsg = rtnMsg;
	}
	
}
	


