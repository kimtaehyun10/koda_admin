package egovframework.webco.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.webco.dao.LetterDAO;
import egovframework.webco.service.LetterService;

@Service("letterService")
public class LetterServiceImpl extends EgovAbstractServiceImpl implements LetterService {

	@Resource(name="letterDAO") private LetterDAO letterDAO; 
	private String fileStorePath = EgovProperties.getProperty("globals.fileStorePath");
	
	@Override
	public Map<String, Object> selectTypeLetterFile(Map<String, Object> commandMap) {
		return letterDAO.selectTypeLetterFile(commandMap);
	}
	
	// ----------------------------------------- 스킨 관리 -----------------------------------------------------------------// 
	@Override
	public List<Map<String, Object>> selectLetterSkinList(Map<String, Object> commandMap) {
		return letterDAO.selectLetterSkinList(commandMap);
	}

	@Override
	public int selectLetterSkinListTotCnt(Map<String, Object> commandMap) {
		return letterDAO.selectLetterSkinListTotCnt(commandMap);
	}

	@Override
	public String saveLetterSkin(Map<String, Object> commandMap, MultipartFile multipartFile, HttpServletRequest request) {
		Map<String, Object> resultFileInfo = new HashMap<String, Object>();
		String originFilename = multipartFile.getOriginalFilename();
		if(!"".equals(originFilename) && originFilename!=null){
			resultFileInfo = fileUpload(multipartFile, "letterSkin", "", request);
			commandMap.put("letter_skin_file_nm", resultFileInfo.get("file_nm"));
			commandMap.put("letter_skin_file_org_nm", resultFileInfo.get("file_org_nm"));
		}
		return letterDAO.saveLetterSkin(commandMap);
	}
	
	@Override
	public int selectDuplicateSkinName(Map<String, Object> commandMap) {
		return letterDAO.selectDuplicateSkinName(commandMap);
	}
	
	@Override
	public void updateLetterSkin(Map<String, Object> commandMap, MultipartFile multipartFile, HttpServletRequest request) {
		
		if(commandMap.get("delFile1") != null && commandMap.get("delFile1").equals("on")) {
			commandMap.put("letter_skin_file_nm", "");
			commandMap.put("letter_skin_file_org_nm", "");
			letterDAO.updateLetterSkinFile(commandMap);
		}
		
		String originFilename = multipartFile.getOriginalFilename();
		if(!"".equals(originFilename) && originFilename!=null){
			Map<String, Object> resultFileInfo = new HashMap<String, Object>();
			resultFileInfo = fileUpload(multipartFile, "letterSkin", "", request);
			commandMap.put("letter_skin_file_nm", resultFileInfo.get("file_nm"));
			commandMap.put("letter_skin_file_org_nm", resultFileInfo.get("file_org_nm"));
			letterDAO.updateLetterSkinFile(commandMap);
		}
		
		letterDAO.updateLetterSkin(commandMap);
	}	
	
	@Override
	public void deleteLetterSkin(Map<String, Object> commandMap) {
		letterDAO.deleteLetterSkin(commandMap);
	}
	
	@Override
	public int selectUseSkinLetterId(Map<String, Object> commandMap) {
		return letterDAO.selectUseSkinLetterId(commandMap);
	}
	
	// ----------------------------------------- 우체통 관리 -----------------------------------------------------------------//
	@Override
	public List<Map<String, Object>> selectLetterList(Map<String, Object> commandMap) {
		return letterDAO.selectLetterList(commandMap);
	}
	
	@Override
	public int selectLetterListTotCnt(Map<String, Object> commandMap) {
		return letterDAO.selectLetterListTotCnt(commandMap);
	}
	
	@SuppressWarnings({ "resource", "static-access" })
	@Override
	public boolean exportLetterList(Map<String, Object> commandMap) {
		boolean result = true;
		FileOutputStream outputStream = null; // 파일 쓰기 스트림
		try {
			HSSFWorkbook objWorkBook = new HSSFWorkbook();
			HSSFSheet objSheet = null;
			HSSFRow objRow = null;
			HSSFCell objCell = null;
			
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
			
			//본문 스타일에 폰트 적용, 정렬
			HSSFCellStyle styleLeft = objWorkBook.createCellStyle();    //제목 스타일
			styleLeft.setFont(font2);
			styleLeft.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			styleLeft.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);
	
			objSheet = objWorkBook.createSheet("우체통 현황");     //워크시트 생성
			objRow = objSheet.createRow(0);
			objRow.setHeight ((short) 0x150);
			
			String[] title_data = {"구분", "보내는 사람", "받는 사람", "제목", "발송일", "수신일", "상태"};
			for (int i=0; i < title_data.length; i++) {
				objCell = objRow.createCell(i);
				objCell.setCellValue(title_data[i]);
				objCell.setCellStyle(styleHd);					
			}
			int idx = 1;		
			
			List<Map<String, Object>> letterList = this.selectLetterList(commandMap);
			for(Map<String, Object> letter : letterList) {
				objRow = objSheet.createRow(idx);
				objRow.setHeight((short) 0x150);
				
				String status = "";
				if(letter.get("status").toString().equals("notApproval")) {
				  status = "미승인";
				} else if(letter.get("status").toString().equals("approval")) {
				  status = "승인";
				} else if(letter.get("status").toString().equals("return")) {
				  status = "반송";
				} else if(letter.get("status").toString().equals("sendStay")) {
				  status = "발송대기";
				}
				
				String gubn = "";
				if(letter.get("gubn") != null) {
					if(letter.get("gubn").toString().equals("D")) {
						gubn = "기증자가족";
					} else if(letter.get("gubn").toString().equals("B")){
						gubn = "수혜자";
					}
				}
				
				String sender_date = "";
				if(letter.get("sender_date") != null) {
					sender_date = letter.get("sender_date").toString();
				}
				
				String receiver_date = "";
				if(letter.get("receiver_date") != null) {
					receiver_date = letter.get("receiver_date").toString();
				}
				
				String sender = "";
				if(letter.get("sender_id") != null) {
					sender = letter.get("sender_name").toString() + "(" + letter.get("sender_id").toString() + ")";
				}
				
				String receiver = "";
				if(letter.get("receiver_id") != null) {
					receiver = letter.get("receiver_name").toString() + "(" + letter.get("receiver_id").toString() + ")";
				}
				
				String title = "";
				if(letter.get("title") != null) {
					int depth = (int) letter.get("depth");
					for(int i=0; i < depth; i++) {
						title += " ";
					}
					title = title + letter.get("title").toString();
				}
				 
				String[] row_data = {gubn, sender, receiver, title, sender_date, receiver_date, status };
				 
				for (int i=0; i < row_data.length; i++) {
					objCell = objRow.createCell(i);
					objCell.setCellValue(row_data[i]);
					if(i == 3) {
						objCell.setCellStyle(styleLeft);
					} else {
						objCell.setCellStyle(styleBd);
					}
				}
				idx++;
			}
			for (int i=0; i < title_data.length; i++) {
				objSheet.autoSizeColumn(i);
			}
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder .getRequestAttributes()).getRequest();
			
			String realPath = request.getSession().getServletContext().getRealPath("/");
			String filePath = "/uploads/letter_list/letter_list.xls"; // 대상 파일
			outputStream = new FileOutputStream(new File(realPath+filePath));				
			objWorkBook.write(outputStream);
		} catch (IOException  e) {
			result = false;               
		} catch (Exception e) {
			result = false;                 
        } finally {
			try {
				outputStream.close();
			} catch (Exception e) {
				result = false;
			}
		}
		return result;
	}
	
	@Override
	public Map<String, Object> selectLetterView(Map<String, Object> commandMap) {
		return letterDAO.selectLetterView(commandMap);
	}
	
	@Override
	public List<Map<String, Object>> selectLetterFileList(Map<String, Object> commandMap) {
		return letterDAO.selectLetterFileList(commandMap);
	}
	
	@Override
	public List<Map<String, Object>> selectLetterSenderSearchList(Map<String, Object> commandMap) {
		return letterDAO.selectLetterSenderSearchList(commandMap);
	}

	@Override
	public int selectLetterSenderSearchListTotCnt(Map<String, Object> commandMap) {
		return letterDAO.selectLetterSenderSearchListTotCnt(commandMap);
	}
	
	@Override
	public String saveLetterWrite(Map<String, Object> commandMap, MultipartFile multipartFile1,	MultipartFile multipartFile2, MultipartFile multipartFile3, HttpServletRequest request) {
		
		String letterId = letterDAO.saveLetterWrite(commandMap);
		commandMap.put("letter_id", letterId);
		letterDAO.updateLetterGroupKeyAndDepth(commandMap);
		
		// 파일 1
		String originFilename1 = multipartFile1.getOriginalFilename();
		if(!"".equals(originFilename1) && originFilename1 != null){
			Map<String, Object> resultFileInfo = new HashMap<String, Object>();
			resultFileInfo = fileUpload(multipartFile1, "letter", letterId, request);
			resultFileInfo.put("letter_id", letterId);
			resultFileInfo.put("letter_file_seq", "1");
			resultFileInfo.put("create_id", commandMap.get("create_id"));
			letterDAO.saveLetterFile(resultFileInfo);
		}
		
		// 파일 2
		String originFilename2 = multipartFile2.getOriginalFilename();
		if(!"".equals(originFilename2) && originFilename2 != null){
			Map<String, Object> resultFileInfo = new HashMap<String, Object>();
			resultFileInfo = fileUpload(multipartFile2, "letter", letterId, request);
			resultFileInfo.put("letter_id", letterId);
			resultFileInfo.put("letter_file_seq", "2");
			resultFileInfo.put("create_id", commandMap.get("create_id"));
			letterDAO.saveLetterFile(resultFileInfo);
		}
		
		// 파일 3
		String originFilename3 = multipartFile3.getOriginalFilename();
		if(!"".equals(originFilename3) && originFilename3 != null){
			Map<String, Object> resultFileInfo = new HashMap<String, Object>();
			resultFileInfo = fileUpload(multipartFile3, "letter", letterId, request);
			resultFileInfo.put("letter_id", letterId);
			resultFileInfo.put("letter_file_seq", "3");
			resultFileInfo.put("create_id", commandMap.get("create_id"));
			letterDAO.saveLetterFile(resultFileInfo);
		}
		
		String letterReceiverId = (String) commandMap.get("letter_receiver_id");
		String[] letterRecevierIdList = letterReceiverId.split(",");
		
		for(int i=0; i<letterRecevierIdList.length; i++) {
			if(!letterRecevierIdList[i].equals("")) {
				Map<String, Object> clone = new HashMap<String, Object>(commandMap);
				clone.put("receiver_id", letterRecevierIdList[i]);
				clone.put("letter_id", letterId);
				letterDAO.saveLetterReceiver(clone);
			}
		}
		return null;
	}
	
	@Override
	public void letterUpdate(Map<String, Object> commandMap, MultipartFile multipartFile1, MultipartFile multipartFile2, MultipartFile multipartFile3, HttpServletRequest request) {
		if(commandMap.get("delFile1") != null && commandMap.get("delFile1").equals("on")) {
			commandMap.put("letter_file_seq", "1");
			letterDAO.deleteLetterFile(commandMap);
		}
		
		if(commandMap.get("delFile2") != null && commandMap.get("delFile2").equals("on")) {
			commandMap.put("letter_file_seq", "2");
			letterDAO.deleteLetterFile(commandMap);
		}
		
		if(commandMap.get("delFile3") != null && commandMap.get("delFile3").equals("on")) {
			commandMap.put("letter_file_seq", "3");
			letterDAO.deleteLetterFile(commandMap);
		}
		
		String letterId = (String) commandMap.get("letter_id");
		String originFilename1 = multipartFile1.getOriginalFilename();
		if(!"".equals(originFilename1) && originFilename1 != null){
			Map<String, Object> resultFileInfo = new HashMap<String, Object>();
			resultFileInfo = fileUpload(multipartFile1, "letter", letterId, request);
			resultFileInfo.put("letter_id", letterId);
			resultFileInfo.put("letter_file_seq", "1");
			letterDAO.deleteLetterFile(resultFileInfo);
			letterDAO.saveLetterFile(resultFileInfo);
		}
		
		// 파일 2
		String originFilename2 = multipartFile2.getOriginalFilename();
		if(!"".equals(originFilename2) && originFilename2 != null){
			Map<String, Object> resultFileInfo = new HashMap<String, Object>();
			resultFileInfo = fileUpload(multipartFile2, "letter", letterId, request);
			resultFileInfo.put("letter_id", letterId);
			resultFileInfo.put("letter_file_seq", "2");
			letterDAO.deleteLetterFile(resultFileInfo);
			letterDAO.saveLetterFile(resultFileInfo);
		}
		
		// 파일 3
		String originFilename3 = multipartFile3.getOriginalFilename();
		if(!"".equals(originFilename3) && originFilename3 != null){
			Map<String, Object> resultFileInfo = new HashMap<String, Object>();
			resultFileInfo = fileUpload(multipartFile3, "letter", letterId, request);
			resultFileInfo.put("letter_id", letterId);
			resultFileInfo.put("letter_file_seq", "3");
			letterDAO.deleteLetterFile(resultFileInfo);
			letterDAO.saveLetterFile(resultFileInfo);
		}
		
		letterDAO.letterWriteUpdate(commandMap);			// 내용 업데이트
		
		letterDAO.deleteLetterReceiver(commandMap);
		
		String letterReceiverId = (String) commandMap.get("letter_receiver_id");
		String[] letterRecevierIdList = letterReceiverId.split(",");
		for(int i=0; i<letterRecevierIdList.length; i++) {
			if(!letterRecevierIdList[i].equals("")) {
				Map<String, Object> clone = new HashMap<String, Object>(commandMap);
				clone.put("receiver_id", letterRecevierIdList[i]);
				clone.put("letter_id", commandMap.get("letter_id"));
				letterDAO.saveLetterReceiver(clone);
			}
		}
		
	}
	
	@Override
	public void letterDelete(Map<String, Object> commandMap) {
		letterDAO.deleteLetter(commandMap);
		letterDAO.deleteLetterFile(commandMap);
		letterDAO.deleteLetterReceiver(commandMap);
	}
	
	@Override
	public List<Map<String, Object>> selectLetterAdminSearchList(Map<String, Object> commandMap) {
		return letterDAO.selectLetterAdminSearchList(commandMap);
	}

	@Override
	public int selectLetterAdminSearchListTotCnt(Map<String, Object> commandMap) {
		return letterDAO.selectLetterAdminSearchListTotCnt(commandMap);
	}
	
	@Override
	public String saveLetterReplyWrite(Map<String, Object> commandMap, MultipartFile multipartFile1, MultipartFile multipartFile2, MultipartFile multipartFile3, HttpServletRequest request) {
		letterDAO.updateReplyShape(commandMap);				// 답글을 위한 보정
		commandMap.put("group_order", String.valueOf(Integer.parseInt((String) commandMap.get("group_order")) + 1));
		commandMap.put("depth", String.valueOf(Integer.parseInt((String) commandMap.get("depth")) + 1));
		String letterId = letterDAO.saveLetterWrite(commandMap);
		
		// 파일 1
		String originFilename1 = multipartFile1.getOriginalFilename();
		if(!"".equals(originFilename1) && originFilename1 != null){
			Map<String, Object> resultFileInfo = new HashMap<String, Object>();
			resultFileInfo = fileUpload(multipartFile1, "letter", letterId, request);
			resultFileInfo.put("letter_id", letterId);
			resultFileInfo.put("letter_file_seq", "1");
			letterDAO.saveLetterFile(resultFileInfo);
		}
		
		// 파일 2
		String originFilename2 = multipartFile2.getOriginalFilename();
		if(!"".equals(originFilename2) && originFilename2 != null){
			Map<String, Object> resultFileInfo = new HashMap<String, Object>();
			resultFileInfo = fileUpload(multipartFile2, "letter", letterId, request);
			resultFileInfo.put("letter_id", letterId);
			resultFileInfo.put("letter_file_seq", "2");
			letterDAO.saveLetterFile(resultFileInfo);
		}
		
		// 파일 3
		String originFilename3 = multipartFile3.getOriginalFilename();
		if(!"".equals(originFilename3) && originFilename3 != null){
			Map<String, Object> resultFileInfo = new HashMap<String, Object>();
			resultFileInfo = fileUpload(multipartFile3, "letter", letterId, request);
			resultFileInfo.put("letter_id", letterId);
			resultFileInfo.put("letter_file_seq", "3");
			letterDAO.saveLetterFile(resultFileInfo);
		}
		
		String letterReceiverId = (String) commandMap.get("letter_receiver_id");
		String[] letterRecevierIdList = letterReceiverId.split(",");
		
		for(int i=0; i<letterRecevierIdList.length; i++) {
			if(!letterRecevierIdList[i].equals("")) {
				Map<String, Object> clone = new HashMap<String, Object>(commandMap);
				clone.put("receiver_id", letterRecevierIdList[i]);
				clone.put("letter_id", letterId);
				letterDAO.saveLetterReceiver(clone);
			}
		}
		
		return letterId;
	}
	
	@Override
	public int selectLetterReplyCheck(Map<String, Object> commandMap) {
		return letterDAO.selectLetterReplyCheck(commandMap);
	}
	

	// ----------------------------------------- 관리자 예시글 -----------------------------------------------------------------//
	@Override
	public List<Map<String, Object>> selectLetterAdminList(Map<String, Object> commandMap) {
		return letterDAO.selectLetterAdminList(commandMap);
	}
	
	@Override
	public int selectLetterAdminListTotCnt(Map<String, Object> commandMap) {
		return letterDAO.selectLetterAdminListTotCnt(commandMap);
	}
	
	@Override
	public List<Map<String, Object>> selectAdminSearchList(Map<String, Object> commandMap) {
		return letterDAO.selectAdminSearchList(commandMap);
	}

	@Override
	public int selectAdminSearchListTotCnt(Map<String, Object> commandMap) {
		return letterDAO.selectAdminSearchListTotCnt(commandMap);
	}
	
	@Override
	public String saveLetterAdmin(Map<String, Object> commandMap, HttpServletRequest request) {
		return letterDAO.saveLetterAdmin(commandMap);
	}
	
	@Override
	public void updateLetterAdmin(Map<String, Object> commandMap, HttpServletRequest request) {
		letterDAO.updateLetterAdmin(commandMap);
	}

	@Override
	public void deleteLetterAdmin(Map<String, Object> commandMap, HttpServletRequest request) {
		letterDAO.deleteLetterAdmin(commandMap);
	}
	
	
	//------------------------------------------------------------------------------------------------------------------------------------
	/**
	 * 파일을 업로드 한다.
	 * @param multipartFile
	 * @param prefix
	 * @param request
	 * @return
	 */
	private Map<String, Object> fileUpload(MultipartFile multipartFile, String prefix, String id, HttpServletRequest request) {
		Map<String, Object> fileInfo = new HashMap<String, Object>();
		try {
			String originFilename = multipartFile.getOriginalFilename();
			String extName = originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			String saveFileName = genSaveFileName(prefix, id, extName);				// 서버에서 저장 할 파일 이름
			fileInfo.put("file_org_nm", originFilename);
			fileInfo.put("file_nm", saveFileName);
			writeFile(multipartFile, saveFileName, request);
		} catch (Exception e) {

		}
		return fileInfo;
	}
		
	/**
	 * 파일명을 생성한다.
	 * @param prefix
	 * @param extName
	 * @return
	 */
    private String genSaveFileName(String prefix, String id, String extName) {
		String fileName = "";
		fileName += prefix;
		fileName += id;
		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);
		fileName += extName;
		return fileName;
	}
    
    /**
     * 파일을 서버에 업로드 한다.
     * @param multipartFile
     * @param saveFileName
     * @param request
     * @return
     * @throws IOException
     */
 	private boolean writeFile(MultipartFile multipartFile, String saveFileName, HttpServletRequest request)throws IOException{
 		boolean result = false;
 		String path = fileStorePath;
 		byte[] data = multipartFile.getBytes();
 		FileOutputStream fos = new FileOutputStream(path + "/" + saveFileName);
 		fos.write(data);
 		fos.close();
 		return result;
 	}
 	
 	@Override
 	public int selectCreateLetterMinYearLetter() {
 		return letterDAO.selectCreateLetterMinYearLetter();
 	}

	@Override
	public List<Map<String, Object>> selectLetterStatisticList(Map<String, Object> commandMap) {
		
		// 우체통 외를 클릭하였을 시에
		if(commandMap.get("typeTabSelected").equals("#other")) {
			String year = (String) commandMap.get("schYear");
			String month = (String) commandMap.get("schMonth");
			String day = (String) commandMap.get("schDay");
			StringBuffer str = new StringBuffer();
			str.append(year);
			
			if(month.equals("") && day.equals("")){
				commandMap.put("type", "year");	
			} else if(day.equals("")) {
				str.append(String.format("%02d", Integer.parseInt(month)));
				commandMap.put("type", "month");
			} else {
				str.append(String.format("%02d", Integer.parseInt(month)));
				str.append(String.format("%02d", Integer.parseInt(day)));
				commandMap.put("type", "day");
			}
			
			commandMap.put("searchDate", str.toString());
			
			if(commandMap.get("target").equals("mail")) {
				return this.getStatisticMail(commandMap);
			} else if(commandMap.get("target").equals("gender")) {
				return this.getStatisticGender(commandMap);
			} else if(commandMap.get("target").equals("age")) {
				return this.getStatisticAge(commandMap);
			} else if(commandMap.get("target").equals("memberType")) {
				return this.getStatisticMemberType(commandMap);
			} else if(commandMap.get("target").equals("donorRelation")) {
				return this.getStatisticDonorRelation(commandMap);
			}  else if(commandMap.get("target").equals("benefitOrgan")) {
				return this.getStatisticBenefitOrgan(commandMap);
			} else {
				return null;
			}
			// 우체통 을 클릭하였을 시에
		} else {
			return this.getStatisticMail(commandMap);
		}
	}
	
	/**
	 * 우체통 통계 쿼리
		/**
	 * 우체통 통계 쿼리
	 * @param commandMap
	 * @return
	 */
	private List<Map<String, Object>> getStatisticMail(Map<String, Object> commandMap) {
		List<Map<String, Object>> result = new ArrayList<>();
		if(commandMap.get("mailDateCondition").equals("year")) {
			int minYear = letterDAO.selectCreateLetterMinYearLetter();				// 1. 최소년도를 구한다.
			int currentYear = Calendar.getInstance().get(Calendar.YEAR);		// 2. 현재년도를 구한다.
			for(int year=currentYear-1; year > minYear-1; year--) {				// 3. 최소년도부터 현재년도 까지 For Loop를 돌려서 데이터를 확인하여 result에 넣는다.
				commandMap.put("format", "%Y");
				commandMap.put("basic", year);
				Map<String, Object> yearMap = letterDAO.selectStatisticMailList(commandMap);
				int receiverCnt = Integer.parseInt(String.valueOf(yearMap.get("RECEIVER_CNT")));
				int returnCnt = Integer.parseInt(String.valueOf(yearMap.get("RETURN_CNT")));
				int senderCnt = Integer.parseInt(String.valueOf(yearMap.get("SENDER_CNT")));
				int senderStayCnt = Integer.parseInt(String.valueOf(yearMap.get("SENDER_STAY_CNT")));
				int sumCnt = receiverCnt + returnCnt + senderCnt + senderStayCnt;
				yearMap.put("SUM_CNT", sumCnt);
				result.add(yearMap);
			}
		} else if(commandMap.get("mailDateCondition").equals("month")) {
			for(int i=12; i > 0; i--) {
				String basic = ((String)commandMap.get("schMailYear")).substring(0, 4) + String.format("%2s", i).replace(" ", "0");
				commandMap.put("format", "%Y%m");
				commandMap.put("basic", basic);
				Map<String, Object> yearMap = letterDAO.selectStatisticMailList(commandMap);
				int receiverCnt = Integer.parseInt(String.valueOf(yearMap.get("RECEIVER_CNT")));
				int returnCnt = Integer.parseInt(String.valueOf(yearMap.get("RETURN_CNT")));
				int senderCnt = Integer.parseInt(String.valueOf(yearMap.get("SENDER_CNT")));
				int senderStayCnt = Integer.parseInt(String.valueOf(yearMap.get("SENDER_STAY_CNT")));
				int sumCnt = receiverCnt + returnCnt + senderCnt + senderStayCnt;
				yearMap.put("SUM_CNT", sumCnt);
				result.add(yearMap);
			}
		} else if(commandMap.get("mailDateCondition").equals("day")) {
			if(commandMap.get("schMailMonth") == null || commandMap.get("schMailMonth").equals("")) {
				return null;
			}
			StringBuffer str = new StringBuffer();
			str.append(((String)commandMap.get("schMailYear")).substring(0, 4));
			str.append((String.format("%2s", (String)commandMap.get("schMailMonth"))).replace(" ", "0"));
			commandMap.put("basicDate", str.toString());
			
			int maxLastDay = letterDAO.selectMonthSelectedLastDay(commandMap);	// 1. 선택한 달의 마지막을 구한다.
			for(int i=maxLastDay; i > 0; i--) {									// 2. 마지막 날부터 1일가지 내려서 보낸다.
				String basic = (String.valueOf(commandMap.get("basicDate"))).replace("-", "").substring(0, 6) + String.format("%2s", i).replace(" ", "0");
				commandMap.put("format", "%Y%m%d");
				commandMap.put("basic", basic);
				Map<String, Object> yearMap = letterDAO.selectStatisticMailList(commandMap);
				int receiverCnt = Integer.parseInt(String.valueOf(yearMap.get("RECEIVER_CNT")));
				int returnCnt = Integer.parseInt(String.valueOf(yearMap.get("RETURN_CNT")));
				int senderCnt = Integer.parseInt(String.valueOf(yearMap.get("SENDER_CNT")));
				int senderStayCnt = Integer.parseInt(String.valueOf(yearMap.get("SENDER_STAY_CNT")));
				int sumCnt = receiverCnt + returnCnt + senderCnt + senderStayCnt;
				yearMap.put("SUM_CNT", sumCnt);
				result.add(yearMap);
			}
		} else {
			return null;
		}
		
		result.add(totalSum(result));
		return result;
	}

	/**
	 * 성별
	 * @param commandMap
	 * @return
	 */
	private List<Map<String, Object>> getStatisticGender(Map<String, Object> commandMap) {
		List<Map<String, Object>> result = new ArrayList<>();
		String[] gender = {"M", "F"};
		
		if(commandMap.get("type").equals("year")) {
			commandMap.put("format", "%Y");
		} else if(commandMap.get("type").equals("month")) {
			commandMap.put("format", "%Y%m");
		} else if(commandMap.get("type").equals("day")) {
			commandMap.put("format", "%Y%m%d");
		}
		
		commandMap.put("basic", commandMap.get("searchDate"));
		for (int genderIdx = 0; genderIdx < gender.length; genderIdx++) {
			commandMap.put("gender", gender[genderIdx]);
			Map<String, Object> yearMap = letterDAO.selectStatisticGenderList(commandMap);
			int receiverCnt = Integer.parseInt(String.valueOf(yearMap.get("RECEIVER_CNT")));
			int returnCnt = Integer.parseInt(String.valueOf(yearMap.get("RETURN_CNT")));
			int senderCnt = Integer.parseInt(String.valueOf(yearMap.get("SENDER_CNT")));
			int senderStayCnt = Integer.parseInt(String.valueOf(yearMap.get("SENDER_STAY_CNT")));
			int sumCnt = receiverCnt + returnCnt + senderCnt + senderStayCnt;
			yearMap.put("SUM_CNT", sumCnt);
			result.add(yearMap);
		}
		result.add(totalSum(result));
		return result;
	}
	
	/**
	 * 나이
	 * @param commandMap
	 * @return
	 */
	private List<Map<String, Object>> getStatisticAge(Map<String, Object> commandMap) {
		List<Map<String, Object>> result = new ArrayList<>();
		String[] age = {"10", "20", "30", "40", "50", "60"};
		
		if(commandMap.get("type").equals("year")) {
			commandMap.put("format", "%Y");
		} else if(commandMap.get("type").equals("month")) {
			commandMap.put("format", "%Y%m");
		} else if(commandMap.get("type").equals("day")) {
			commandMap.put("format", "%Y%m%d");
		}
		
		commandMap.put("basic", commandMap.get("searchDate"));
		for (int ageIdx = 0; ageIdx < age.length; ageIdx++) {
			commandMap.put("age", age[ageIdx]);
			Map<String, Object> yearMap = letterDAO.selectStatisticAgeList(commandMap);
			int receiverCnt = Integer.parseInt(String.valueOf(yearMap.get("RECEIVER_CNT")));
			int returnCnt = Integer.parseInt(String.valueOf(yearMap.get("RETURN_CNT")));
			int senderCnt = Integer.parseInt(String.valueOf(yearMap.get("SENDER_CNT")));
			int senderStayCnt = Integer.parseInt(String.valueOf(yearMap.get("SENDER_STAY_CNT")));
			int sumCnt = receiverCnt + returnCnt + senderCnt + senderStayCnt;
			yearMap.put("SUM_CNT", sumCnt);
			result.add(yearMap);
		}
		result.add(totalSum(result));
		return result;
	}
	
	/**
	 * 멤버유형
	 * @param commandMap
	 * @return
	 */
	private List<Map<String, Object>> getStatisticMemberType(Map<String, Object> commandMap) {
		List<Map<String, Object>> result = new ArrayList<>();
		String[] memberType = {"B", "D"};
		
		if(commandMap.get("type").equals("year")) {
			commandMap.put("format", "%Y");
		} else if(commandMap.get("type").equals("month")) {
			commandMap.put("format", "%Y%m");
		} else if(commandMap.get("type").equals("day")) {
			commandMap.put("format", "%Y%m%d");
		}
		
		commandMap.put("basic", commandMap.get("searchDate"));
		for (int memberTypeIdx = 0; memberTypeIdx < memberType.length; memberTypeIdx++) {
			commandMap.put("memberType", memberType[memberTypeIdx]);
			Map<String, Object> yearMap = letterDAO.selectStatisticMemberTypeList(commandMap);
			int receiverCnt = Integer.parseInt(String.valueOf(yearMap.get("RECEIVER_CNT")));
			int returnCnt = Integer.parseInt(String.valueOf(yearMap.get("RETURN_CNT")));
			int senderCnt = Integer.parseInt(String.valueOf(yearMap.get("SENDER_CNT")));
			int senderStayCnt = Integer.parseInt(String.valueOf(yearMap.get("SENDER_STAY_CNT")));
			int sumCnt = receiverCnt + returnCnt + senderCnt + senderStayCnt;
			yearMap.put("SUM_CNT", sumCnt);
			result.add(yearMap);
		}
		result.add(totalSum(result));
		return result;
	}
	
	/**
	 * 기증자와의 관계별
	 * @param commandMap
	 * @return
	 */
	private List<Map<String, Object>> getStatisticDonorRelation(Map<String, Object> commandMap) {
		List<Map<String, Object>> result = new ArrayList<>();
		List<Map<String, Object>> donorType = letterDAO.selectCode("01");
		
		if(commandMap.get("type").equals("year")) {
			commandMap.put("format", "%Y");
		} else if(commandMap.get("type").equals("month")) {
			commandMap.put("format", "%Y%m");
		} else if(commandMap.get("type").equals("day")) {
			commandMap.put("format", "%Y%m%d");
		}
		
		commandMap.put("basic", commandMap.get("searchDate"));
		for (Map<String, Object> map : donorType) {
			commandMap.put("donorType", map.get("code"));
			Map<String, Object> yearMap = letterDAO.selectStatisticDonorRelationList(commandMap);
			int receiverCnt = Integer.parseInt(String.valueOf(yearMap.get("RECEIVER_CNT")));
			int returnCnt = Integer.parseInt(String.valueOf(yearMap.get("RETURN_CNT")));
			int senderCnt = Integer.parseInt(String.valueOf(yearMap.get("SENDER_CNT")));
			int senderStayCnt = Integer.parseInt(String.valueOf(yearMap.get("SENDER_STAY_CNT")));
			int sumCnt = receiverCnt + returnCnt + senderCnt + senderStayCnt;
			yearMap.put("SUM_CNT", sumCnt);
			result.add(yearMap);
		}
		
		result.add(totalSum(result));
		return result;
	}
	
	/**
	 * 수혜장기별
	 * @param commandMap
	 * @return
	 */
	private List<Map<String, Object>> getStatisticBenefitOrgan(Map<String, Object> commandMap) {
		List<Map<String, Object>> result = new ArrayList<>();
		List<Map<String, Object>> benefitOrgan = letterDAO.selectCode("02");
		
		if(commandMap.get("type").equals("year")) {
			commandMap.put("format", "%Y");
		} else if(commandMap.get("type").equals("month")) {
			commandMap.put("format", "%Y%m");
		} else if(commandMap.get("type").equals("day")) {
			commandMap.put("format", "%Y%m%d");
		}
		
		commandMap.put("basic", commandMap.get("searchDate"));
		for (Map<String, Object> map : benefitOrgan) {
			commandMap.put("benefitOrganType", map.get("code"));
			Map<String, Object> yearMap = letterDAO.selectStatisticBenefitOrganList(commandMap);
			int receiverCnt = Integer.parseInt(String.valueOf(yearMap.get("RECEIVER_CNT")));
			int returnCnt = Integer.parseInt(String.valueOf(yearMap.get("RETURN_CNT")));
			int senderCnt = Integer.parseInt(String.valueOf(yearMap.get("SENDER_CNT")));
			int senderStayCnt = Integer.parseInt(String.valueOf(yearMap.get("SENDER_STAY_CNT")));
			int sumCnt = receiverCnt + returnCnt + senderCnt + senderStayCnt;
			yearMap.put("SUM_CNT", sumCnt);
			result.add(yearMap);
		}
		
		result.add(totalSum(result));
		return result;
	}
	
	private Map<String, Object> totalSum(List<Map<String, Object>> data) {
		Map<String, Object> sumMap = new HashMap<>();
		sumMap.put("type", "합계");
		sumMap.put("RECEIVER_CNT", "0");
		sumMap.put("RETURN_CNT", "0");
		sumMap.put("SENDER_CNT", "0");
		sumMap.put("SENDER_STAY_CNT", "0");
		sumMap.put("SUM_CNT", "0");
		
		for (Map<String, Object> map : data) {
			sumMap.put("RECEIVER_CNT",  Integer.parseInt(String.valueOf(sumMap.get("RECEIVER_CNT"))) + Integer.parseInt(String.valueOf(map.get("RECEIVER_CNT"))));
			sumMap.put("RETURN_CNT",  Integer.parseInt(String.valueOf(sumMap.get("RETURN_CNT"))) + Integer.parseInt(String.valueOf(map.get("RETURN_CNT"))));
			sumMap.put("SENDER_CNT",  Integer.parseInt(String.valueOf(sumMap.get("SENDER_CNT"))) + Integer.parseInt(String.valueOf(map.get("SENDER_CNT"))));
			sumMap.put("SENDER_STAY_CNT",  Integer.parseInt(String.valueOf(sumMap.get("SENDER_STAY_CNT"))) + Integer.parseInt(String.valueOf(map.get("SENDER_STAY_CNT"))));
			sumMap.put("SUM_CNT",  Integer.parseInt(String.valueOf(sumMap.get("SUM_CNT"))) + Integer.parseInt(String.valueOf(map.get("SUM_CNT"))));
		}
		return sumMap;
	}
	
	@Override
	public void exporLetterStatisticList(HttpServletResponse response, Map<String, Object> commandMap) throws Exception {
		HSSFWorkbook objWorkBook = new HSSFWorkbook();
		HSSFSheet objSheet = null;
		HSSFRow objRow = null;
		HSSFCell objCell = null;
		
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
		
		//본문 스타일에 폰트 적용, 정렬
		HSSFCellStyle styleLeft = objWorkBook.createCellStyle();    //제목 스타일
		styleLeft.setFont(font2);
		styleLeft.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		styleLeft.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);
		
		HSSFCellStyle styleRight = objWorkBook.createCellStyle();    //제목 스타일
		styleRight.setFont(font2);
		styleRight.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		styleRight.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);
		
		objSheet = objWorkBook.createSheet("우체통 현황");     //워크시트 생성
		objRow = objSheet.createRow(0);
		objRow.setHeight ((short) 0x150);
		
		String[] title_data = {"구분", "발송건수", "반송건수", "수신건수", "발송대기건수", "총편지수"};
		for (int i=0; i < title_data.length; i++) {
			objCell = objRow.createCell(i);
			objCell.setCellValue(title_data[i]);
			objCell.setCellStyle(styleHd);					
		}
		int idx = 1;		
		
		List<Map<String, Object>> list = this.selectLetterStatisticList(commandMap);
		
		for(int list_idx=0; list_idx < list.size(); list_idx++) {
			Map<String, Object> item = list.get(list_idx);
			objRow = objSheet.createRow(idx);
			objRow.setHeight((short) 0x150);
			String[] row_data = {String.valueOf(item.get("type")), 
					String.valueOf(item.get("SENDER_CNT")), 
					String.valueOf(item.get("RETURN_CNT")),
					String.valueOf(item.get("RECEIVER_CNT")),
					String.valueOf(item.get("SENDER_STAY_CNT")), 
					String.valueOf(item.get("SUM_CNT")) };
			 
			for (int i=0; i < row_data.length; i++) {
				objCell = objRow.createCell(i);
				objCell.setCellValue(row_data[i]);
				if(list_idx != list.size()-1) {
					if(i == 0) {						
						objCell.setCellStyle(styleHd);
					} else {
						objCell.setCellStyle(styleRight);
					}
				} else {
					objCell.setCellStyle(styleHd);
				}
				
			}
			
			idx++;
		}
		
		for (int i=0; i < title_data.length; i++) {
			objSheet.autoSizeColumn(i);
		}
		
		StringBuffer fileName = new StringBuffer();
		fileName.append("발신통계");
		if(commandMap.get("typeTabSelected").equals("#mail")) {
			fileName.append("-우체통");
			if(commandMap.get("mailDateCondition").equals("year")) {
				fileName.append("-년도별");
			} else if(commandMap.get("mailDateCondition").equals("month")) {
				fileName.append("-월별");
			} else if(commandMap.get("mailDateCondition").equals("day")) {
				StringBuffer str = new StringBuffer();
				str.append(((String)commandMap.get("schMailYear")).substring(0, 4));
				str.append((String.format("%2s", (String)commandMap.get("schMailMonth"))).replace(" ", "0"));
				fileName.append("-일별").append("(").append(str.toString()).append(")");
			}
		} else {
			if(commandMap.get("target").equals("gender")) {
				fileName.append("-성별");
			} else if(commandMap.get("target").equals("age")) {
				fileName.append("-나이");
			} else if(commandMap.get("target").equals("memberType")) {
				fileName.append("-회원유형별");
			} else if(commandMap.get("target").equals("donorRelation")) {
				fileName.append("-기증자별");
			} else if(commandMap.get("target").equals("benefitOrgan")) {
				fileName.append("-수혜장기별");
			} 
			
			String year = (String) commandMap.get("schYear");
			String month = (String) commandMap.get("schMonth");
			String day = (String) commandMap.get("schDay");
			StringBuffer str = new StringBuffer();
			str.append(year);
			
			if(month.equals("") && day.equals("")){
				
			} else if(day.equals("")) {
				str.append(String.format("%02d", Integer.parseInt(month)));
			} else {
				str.append(String.format("%02d", Integer.parseInt(month)));
				str.append(String.format("%02d", Integer.parseInt(day)));
			}
			
			fileName.append("(").append(str.toString()).append(")");
		}
		
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename="+ new String(fileName.toString().getBytes("KSC5601"), "8859_1") +".xls");
	    objWorkBook.write(response.getOutputStream());
	    objWorkBook.close();
	}

}
