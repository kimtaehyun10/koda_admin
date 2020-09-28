package egovframework.webco.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

public class EnumValue {
	
	private Map<String, Object> enum_array = new HashMap<String, Object>();
	
	public EnumValue() { 
		enum_array.put("user_sex", new ArrayList<String>(){{add(0, ""); add(1, "남"); add(2, "여");}}); // 성별
        enum_array.put("user_recognize_type", new ArrayList<String>(){{add(0, ""); add(1, "서약자"); add(2, "탈퇴자"); add(3, "등록보류자"); add(4, "사망자"); add(5, "중복"); add(6, "타기관");}}); // 서약구분
        enum_array.put("dp1_idx", new ArrayList<String>(){{add(0, ""); add(1, "장기·조직기증"); add(2, "기증자예우"); add(3, "국민소통"); add(4, "정보"); add(5, "KODA"); add(6, "생명나눔우체통"); add(7, "기증희망등록");}}); // 페이지 뷰
        enum_array.put("user_is_driving_license", new ArrayList<String>(){{add(0, ""); add(1, "Y"); add(2, "N");}}); // 운전면허증 표시
        enum_array.put("user_konos_register_state", new ArrayList<String>(){{add(0, ""); add(1, "Y"); add(2, "N"); add(3, "등록대기");}});   // konos 등록상태
        enum_array.put("user_register_channel", new ArrayList<String>(){{add(0, ""); add(1, "온라인"); add(2, "오프라인"); add(3, "SYRUP");}}); // 접수채널
        enum_array.put("user_withdraw_reason", new ArrayList<String>(){{add(0, ""); add(1, "마음이 바뀜"); add(2, "가족반대"); add(3, "타기관서약"); add(4, "기타");}});  // 탈퇴사유
        enum_array.put("user_withdraw_way", new ArrayList<String>(){{add(0, ""); add(1, "상담"); add(2, "교육"); add(3, "코다"); add(4, "기타"); add(5, "캠페인");}});     // 가입경로
        enum_array.put("user_is_email_agree", new ArrayList<String>(){{add(0, ""); add(1, "Y"); add(2, "N");}});       // 이메일동의
        enum_array.put("user_is_sms_agree", new ArrayList<String>(){{add(0, ""); add(1, "Y"); add(2, "N");}});       // 문자동의
        enum_array.put("user_is_mail_agree", new ArrayList<String>(){{add(0, ""); add(1, "Y"); add(2, "N");}});       // 우편동의
        enum_array.put("user_pledge_card_state", new ArrayList<String>(){{add(0, ""); add(1, "발송"); add(2, "재발송");}});       // 서약카드
        // User Consult
        enum_array.put("consult_type", new ArrayList<String>(){{add(0, ""); add(1, "발송요청"); add(2, "변경"); add(3, "안내"); add(4, "기타");}});       // 상담분류
        // User Checkbox
        enum_array.put("user_is_legal_representative_text", new ArrayList<String>(){{add(0, "N"); add(1, "Y");}});       // 법정대리인 증명서류
        enum_array.put("user_donation_type_body", new ArrayList<String>(){{add(0, "N"); add(1, "Y");}});       // 기증형태_조직
        enum_array.put("user_donation_type_organ", new ArrayList<String>(){{add(0, "N"); add(1, "Y");}});       // 기증형태_장기
        enum_array.put("user_donation_type_comea", new ArrayList<String>(){{add(0, "N"); add(1, "Y");}});       // 기증형태_각막
        // email
        enum_array.put("user_email", new ArrayList<String>(){{add(0, "선택하세요"); add(1, "naver.com"); add(2, "hanmail.net"); add(3, "gmail.com"); add(4, "nate.com"); add(5, "hotmail.com"); add(6 , "직접입력"); }});
        // sms sender 
        enum_array.put("sms_send_sender", new ArrayList<String>(){{add(0, ""); add(1, "02-3785-3177");}});       // SMS 발송하는 번호
        // sms send state
        enum_array.put("sms_send_state", new ArrayList<String>(){{add(0, "N"); add(1, "Y");}});       // SMS 발송 상태
	}
	
	public String getValue(String enum_name, String enum_key) {
		String value = ""; 
		/*Map<String, Object> elem = (Map<String, Object>)this.enum_array.get(enum_name);  
		if(elem != null && !elem.isEmpty()) {
			value = elem.get(enum_key).toString();
		}*/
		ArrayList<String> elem = (ArrayList<String>)this.enum_array.get(enum_name);  
		if(elem != null && !elem.isEmpty()) {
			value = elem.get(Integer.parseInt(enum_key)).toString();
		}
		return value;
	}
	
	public String getKey(String enum_name, String enum_value) {
		String key = ""; 
		ArrayList<String> elem = (ArrayList<String>)this.enum_array.get(enum_name);  
		if(elem != null && !elem.isEmpty()) {
			for(int i=0; i<elem.size(); i++) {
				if(elem.get(i).equals(enum_value)) {
					key = String.valueOf(i);
					break;
				}
			}
		}
		return key;
	}
	
	public Map<String, Object> getEnumArray() {
		return enum_array;
	}
}
