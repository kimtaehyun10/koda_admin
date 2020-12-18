package egovframework.webco.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.webco.dao.MailboxDAO;
import egovframework.webco.service.MailboxService;

@Service("mailboxService")
public class MailboxServiceImpl extends EgovAbstractServiceImpl implements MailboxService{
	
	@Autowired(required=true) 
	private HttpServletRequest request;	
	
    /** mailboxDAO */
    @Resource(name="mailboxDAO")
    private MailboxDAO mailboxDAO;
    
    /** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());  
    
    @Override
	public Object insert(String queryId, Map param) throws Exception {
		// TODO Auto-generated method stub
		return mailboxDAO.insert(queryId, param);
	}
    
    @Override
   	public int delete(String queryId, Map param) throws Exception {
   		// TODO Auto-generated method stub
   		return mailboxDAO.delete(queryId, param);
   	}
       
    
    @Override
	public int update(String queryId, Map param) throws Exception {
		// TODO Auto-generated method stub
		return mailboxDAO.update(queryId, param);
	}
    
    /**
     * 회원정보 리스트
     * @param param Map     
     * @return Map
     * @exception Exception
     */
    @Override
    public Map<String, Object> selectKodaMemberList(Map<String, Object> param) throws Exception {
    	
    	List<Map<String, Object>> result = mailboxDAO.selectKodaMemberList(param);
    	int resultCnt = mailboxDAO.selectKodaMemberListCnt(param);
    	
    	Map<String, Object> returnMap = new HashMap<String, Object>();	
    	
    	returnMap.put("kodaMemberList", result);
    	returnMap.put("totCnt", resultCnt);
    	
        return returnMap;
    }
    
    /**
     * 연계회원 팝업 회원 리스트
     * @param param Map     
     * @return Map
     * @exception Exception
     */
    @Override
    public Map<String, Object> selectRelationKodaMemberList(Map<String, Object> param) throws Exception {
    	
    	List<Map<String, Object>> result = mailboxDAO.selectRelationKodaMemberList(param);
    	int resultCnt = mailboxDAO.selectRelationKodaMemberListCnt(param);
    	
    	Map<String, Object> returnMap = new HashMap<String, Object>();	
    	
    	returnMap.put("relaKodaMemberList", result);
    	returnMap.put("totCnt", resultCnt);
    	
    	return returnMap;
    }
    
    @SuppressWarnings({ "resource", "static-access" })
	@Override
	public boolean exportMemberList(Map<String, Object> commandMap) throws Exception {
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
	
			objSheet = objWorkBook.createSheet("회원관리 현황");     //워크시트 생성
			objRow = objSheet.createRow(0);
			objRow.setHeight ((short) 0x150);
			
			String[] title_data = {"NO", "구분", "아이디", "이름", "연락처", "이메일", "매칭", "승인여부"};
			for (int i=0; i < title_data.length; i++) {
				objCell = objRow.createCell(i);
				objCell.setCellValue(title_data[i]);
				objCell.setCellStyle(styleHd);					
			}
			int idx = 1;		
			
			List<Map<String, Object>> memberList = mailboxDAO.selectKodaMemberList(commandMap);
			for(Map<String, Object> member : memberList) {
				objRow = objSheet.createRow(idx);
				objRow.setHeight((short) 0x150);
				
				int no = idx;

				String gubn = "";
				if(member.get("gubn") != null) {
					if(member.get("gubn").toString().equals("D")) {
						gubn = "기증자가족";
					} else if(member.get("gubn").toString().equals("B")){
						gubn = "수혜자";
					}
				}
				
				String id = member.get("id").toString();
				String name = member.get("name").toString();
				String phone = member.get("phone").toString();
				String email = member.get("email").toString();
				String matchNameList = "";
				if(member.get("matchNameList") != null) {
					matchNameList = member.get("matchNameList").toString();
				}
				String apprFlag = member.get("apprFlag").toString();
				
				String[] row_data = {Integer.toString(idx), gubn, id, name, phone, email, matchNameList, apprFlag };
				 
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
			String filePath = "/uploads/mailbox/member_list.xls"; // 대상 파일
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
    
    /**
     * 매칭회원 팝업 회원 리스트
     * @param param Map     
     * @return Map
     * @exception Exception
     */
    @Override
    public Map<String, Object> selectMatchKodaMemberList(Map<String, Object> param) throws Exception {
    	
   		Map<String, Object> paramMap = new HashMap<String, Object>();
   		Map<String, Object> returnMap = new HashMap<String, Object>();	
    	
    	if("B".equals(param.get("gubn"))) {
    		List<Map<String, Object>> result = mailboxDAO.selectRelationKodaMemberList(param);
    		returnMap.put("resultList", result);
    	} else {
    		int idx = Integer.parseInt(param.get("selIdx").toString());
    		String[] benefiName = param.get("benefiNameArr").toString().split(",");
    		String[] benefiBirth = param.get("benefiBirthArr").toString().split(",");
    		String[] benefiHospitalIdxs = param.get("benefiHospitalIdxsArr").toString().split(",");
    		String[] benefiPartsIdxs = param.get("benefiPartsIdxsArr").toString().split(",");
    		paramMap.put("benefiName", benefiName[idx]);
    		paramMap.put("benefiBirth", benefiBirth[idx]);
    		paramMap.put("benefiHospitalIdx", benefiHospitalIdxs[idx]);
    		paramMap.put("benefiParts", benefiPartsIdxs[idx]);
    		List<Map<String, Object>> result = mailboxDAO.selectMatchKodaMemberList(paramMap);
    		
    		returnMap.put("resultList", result);
    	}
    	
    	return returnMap;
    }
    
    
    /** 
	* 장기 정보
	* @param param Map     
    * @return Map
    * @exception Exception
    */
    @Override
	public List<Map<String, Object>> selectBenefiPartList(Map<String, Object> commandMap) {
		return mailboxDAO.selectBenefiPartList(commandMap);
	}
    /** 
     * 장기 정보
     * @param param Map     
     * @return Map
     * @exception Exception
     */
    @Override
    public List<Map<String, Object>> selectBenefiList(Map<String, Object> commandMap) {
    	return mailboxDAO.selectBenefiList(commandMap);
    }
    
    /** 
     * 장기 정보
     * @param param Map     
     * @return Map
     * @exception Exception
     */
    @Override
    public Map<String, Object> selectDonorList(Map<String, Object> commandMap) {
    	return mailboxDAO.selectDonorList(commandMap);
    }
    
    /**
     * 회원정보 상세
     * @param param Map     
     * @return Map
     * @exception Exception
     */
    @Override
    public Map<String, Object> selectKodaMemberDetail(Map<String, Object> param) throws Exception {
        return mailboxDAO.selectKodaMemberDetail(param);
    }
    
    /**
     * 기증자 관계 목록
     * @param param Map     
     * @return Map
     * @exception Exception
     */
    @Override
    public Map<String, Object> selectDonorRelationList(Map<String, Object> param) throws Exception {
    	List<Map<String, Object>> result = mailboxDAO.selectDonorRelationList(param);
    	Map<String, Object> returnMap = new HashMap<String, Object>();	
    	returnMap.put("donorRelationList", result);
        return returnMap;
    }
    
}
