package egovframework.webco.vo;

public class SyrupAgreement {
	// 약관코드 - 숫자 Sequence 증가 (1,2,3,…)
	private String agreementCode;
	// 제휴사 약관코드
	private String storeTermsCode;
	// 제휴사 약관버전
	private String storeTermsVersion;
	// 필수약관여부 - Y:필수, N:옵션 	
	private String mandatoryYN;
	// 약관동의여부 - Y:동의, N:비동의
	private String agreeYN;
	// 약관버젼 - 세부 약관별 버전 (존재할 경우)
	private String agreementVer;
	public String getAgreementCode() {
		return agreementCode;
	}
	public void setAgreementCode(String agreementCode) {
		this.agreementCode = agreementCode;
	}
	public String getStoreTermsCode() {
		return storeTermsCode;
	}
	public void setStoreTermsCode(String storeTermsCode) {
		this.storeTermsCode = storeTermsCode;
	}
	public String getStoreTermsVersion() {
		return storeTermsVersion;
	}
	public void setStoreTermsVersion(String storeTermsVersion) {
		this.storeTermsVersion = storeTermsVersion;
	}
	public String getMandatoryYN() {
		return mandatoryYN;
	}
	public void setMandatoryYN(String mandatoryYN) {
		this.mandatoryYN = mandatoryYN;
	}
	public String getAgreeYN() {
		return agreeYN;
	}
	public void setAgreeYN(String agreeYN) {
		this.agreeYN = agreeYN;
	}
	public String getAgreementVer() {
		return agreementVer;
	}
	public void setAgreementVer(String agreementVer) {
		this.agreementVer = agreementVer;
	}
		
}
