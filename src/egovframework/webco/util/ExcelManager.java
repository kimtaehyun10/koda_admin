package egovframework.webco.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class ExcelManager {
	/** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());
    
	public boolean createXlsUserList(List<Map<String, Object>> userList) {
		boolean result = true;
		FileOutputStream outputStream = null; // 파일 쓰기 스트림
		try {
			System.out.println("엑셀 생성시작==========>");
			HSSFWorkbook objWorkBook = new HSSFWorkbook();
			HSSFSheet objSheet = null;
			HSSFRow objRow = null;
			HSSFCell objCell = null;       //셀 생성
			
			HSSFFont font = objWorkBook.createFont();
			font.setFontHeightInPoints((short)9);
			font.setBoldweight((short)font.BOLDWEIGHT_BOLD);
			font.setFontName("맑은고딕");
			
			//제목 스타일에 폰트 적용, 정렬
			HSSFCellStyle styleHd = objWorkBook.createCellStyle();    //제목 스타일
			styleHd.setFont(font);
			styleHd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			styleHd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);
			
			HSSFFont font2 = objWorkBook.createFont();
			font2.setFontHeightInPoints((short)9);
			font2.setBoldweight((short)font2.BOLDWEIGHT_NORMAL);
			font2.setFontName("맑은고딕");
			
			//본문 스타일에 폰트 적용, 정렬
			HSSFCellStyle styleBd = objWorkBook.createCellStyle();    //제목 스타일
			styleBd.setFont(font2);
			styleBd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			styleBd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);
	
			objSheet = objWorkBook.createSheet("서약자 현황");     //워크시트 생성
			objRow = objSheet.createRow(0);
			objRow.setHeight ((short) 0x150);
			
			String[] title_data = {
			            "회원번호", "성명", "주민등록번호", "생년월일", "나이", "성별", "이메일", "우편번호", "주소", "상세주소", "송달우편번호", "송달주소", "송달상세주소", "휴대전화", "집전화", "서약구분",
			            "기증형태_장기", "기증형태_조직", "기증형태_각막", "운전면허증 표시", "Konos 등록상태", "서약일", "등록일", "Konos 등록일",
			            "등록자", "접수채널", "탈퇴일", "탈퇴사유", "가입경로", "Konos 탈퇴일", "이메일동의", "문자동의", "우편동의", "서약카드",
			            "법정대리인정보", "법정대리인 첨부서류"
			};
			for (int i=0; i < title_data.length; i++) {
				objCell = objRow.createCell(i);
				objCell.setCellValue(title_data[i]);
				objCell.setCellStyle(styleHd);					
			}
			int idx = 1;		
			
			for( Map<String, Object> userInfo : userList ) {
				 objRow = objSheet.createRow(idx);
				 objRow.setHeight((short) 0x150);
				 
				 String[] row_data = {
			                userInfo.get("user_num").toString(), userInfo.get("user_name").toString(), userInfo.get("user_social_security_num").toString(), userInfo.get("user_birthday").toString(), userInfo.get("user_age").toString(), userInfo.get("user_sex").toString(), userInfo.get("user_email").toString(),
			                userInfo.get("user_post").toString(), userInfo.get("user_address").toString(), userInfo.get("user_address_detail").toString(), userInfo.get("user_send_post").toString(), userInfo.get("user_send_address").toString(), userInfo.get("user_send_address_detail").toString(), userInfo.get("user_mobile").toString(), userInfo.get("user_phone").toString(), userInfo.get("user_recognize_type").toString(),
			                userInfo.get("user_donation_type_organ").toString(), userInfo.get("user_donation_type_body").toString(), userInfo.get("user_donation_type_comea").toString(), userInfo.get("user_is_driving_license").toString(), userInfo.get("user_konos_register_state").toString(), userInfo.get("user_pledge_date").toString(),
			                userInfo.get("user_registration_date").toString(), userInfo.get("user_konos_registration_date").toString(), userInfo.get("user_register").toString(), userInfo.get("user_register_channel").toString(), userInfo.get("user_withdraw_date").toString(), userInfo.get("user_withdraw_reason").toString(),
			                userInfo.get("user_withdraw_way").toString(), userInfo.get("user_konos_withdraw_date").toString(), userInfo.get("user_is_email_agree").toString(), userInfo.get("user_is_sms_agree").toString(), userInfo.get("user_is_mail_agree").toString(), userInfo.get("user_pledge_card_state").toString(),
			                userInfo.get("user_legal_representative_info").toString(), userInfo.get("user_is_legal_representative_text").toString()
				 };
				 
				 for (int i=0; i < row_data.length; i++) {
					objCell = objRow.createCell(i);
					objCell.setCellValue(row_data[i]);
					objCell.setCellStyle(styleBd);					
				 }
				 idx++;
			}
			for (int i=0; i < idx; i++) {
				objSheet.autoSizeColumn(i);
			}
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder .getRequestAttributes()).getRequest();
			
			String realPath = request.getSession().getServletContext().getRealPath("/");				
			String filePath = "/uploads/user_list/user_list.xls"; // 대상 파일
			System.out.println("파일저장경로==========>"+realPath+filePath);
			outputStream = new FileOutputStream(new File(realPath+filePath));				
			objWorkBook.write(outputStream);
		} catch (IOException  e) {
			result = false;
            log.error(e);                 
		} catch (Exception e) {
			result = false;
            log.error(e);                   
        } 
		finally
		{
			try
			{
				// 파일 닫기. 여기에도 try/catch가 필요하다.
				outputStream.close();
			}
			catch (Exception e)
			{
				result = false;
			}
		}
		return result;
	}
	
	public boolean createLabelforSelectedUser(List<Map<String, Object>> userList) {
		boolean result = true;
		FileOutputStream outputStream = null; // 파일 쓰기 스트림
		try {
			log.info("엑셀 생성시작==========>");
			HSSFWorkbook objWorkBook = new HSSFWorkbook();
			HSSFSheet objSheet = null;
			HSSFRow objRow = null;
			HSSFCell objCell = null;       //셀 생성
			
			HSSFFont font = objWorkBook.createFont();
			font.setFontHeightInPoints((short)9);
			font.setBoldweight((short)font.BOLDWEIGHT_BOLD);
			font.setFontName("맑은고딕");
			
			//제목 스타일에 폰트 적용, 정렬
			HSSFCellStyle styleHd = objWorkBook.createCellStyle();    //제목 스타일
			styleHd.setFont(font);
			styleHd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			styleHd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);
			
			HSSFFont font2 = objWorkBook.createFont();
			font2.setFontHeightInPoints((short)9);
			font2.setBoldweight((short)font2.BOLDWEIGHT_NORMAL);
			font2.setFontName("맑은고딕");
			
			//본문 스타일에 폰트 적용, 정렬
			HSSFCellStyle styleBd = objWorkBook.createCellStyle();    //제목 스타일
			styleBd.setFont(font2);
			styleBd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			styleBd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);

			objSheet = objWorkBook.createSheet("서약자 라벨 현황");     //워크시트 생성
			objRow = objSheet.createRow(0);
			objRow.setHeight ((short) 0x150);
			
			String[] title_data = {
					 "회원번호", "성명", "우편번호", "주소+상세주소", "송달우편번호", "송달주소", "연락처"
			};
			for (int i=0; i < title_data.length; i++) {
				objCell = objRow.createCell(i);
				objCell.setCellValue(title_data[i]);
				objCell.setCellStyle(styleHd);					
			}
			int idx = 1;	
			
			for( Map<String, Object> userInfo : userList ) {
				objRow = objSheet.createRow(idx);
				objRow.setHeight((short) 0x150);
				// get user phone : "user_mobile, user_phone"
				String user_phone = "";
				if(userInfo.get("user_mobile") != null && !("").equals(userInfo.get("user_mobile").toString()))
					user_phone = userInfo.get("user_mobile").toString();
				if(userInfo.get("user_phone") != null && !("").equals(userInfo.get("user_phone").toString())) {
					if(!("").equals(user_phone))
						user_phone = user_phone+", "+userInfo.get("user_phone").toString();
					else
						user_phone = userInfo.get("user_phone").toString();
				}
				String[] row_data = {
						userInfo.get("user_num").toString(), userInfo.get("user_name").toString(), userInfo.get("user_post").toString(), userInfo.get("user_address").toString()+ " "+userInfo.get("user_address_detail").toString(), userInfo.get("user_send_post").toString(),
			            userInfo.get("user_send_address").toString()+ " " +userInfo.get("user_send_address_detail").toString(), user_phone				                
				};
				 
				 for (int i=0; i < row_data.length; i++) {
					objCell = objRow.createCell(i);
					objCell.setCellValue(row_data[i]);
					objCell.setCellStyle(styleBd);					
				 }
				 idx++;
			}
			for (int i=0; i < idx; i++) {
				objSheet.autoSizeColumn(i);
			}
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder .getRequestAttributes()).getRequest();
			
			String realPath = request.getSession().getServletContext().getRealPath("/");				
			String filePath = "/uploads/user_list/label_list.xls"; // 대상 파일			
			outputStream = new FileOutputStream(new File(realPath+filePath));				
			objWorkBook.write(outputStream);
			
			log.info("파일저장경로==========>"+realPath+filePath);
		} catch (IOException  e) {
			result = false;
            log.error(e);                 
		} catch (Exception e) {
			result = false;
            log.error(e);                   
        } 
		finally
		{
			try
			{
				// 파일 닫기. 여기에도 try/catch가 필요하다.
				outputStream.close();
			}
			catch (Exception e)
			{
				result = false;
			}
		}
		return result;
	}	
}
