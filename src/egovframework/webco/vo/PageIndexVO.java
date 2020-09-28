package egovframework.webco.vo;

import java.io.Serializable;

/**
 * @Class Name : pageindexVO.java
 * @Description : 게시물에 대한 데이터 처리 모델
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
@SuppressWarnings("serial")
public class PageIndexVO implements Serializable {
	
	
	private int page = 1; // 리스트 페이지
	private int rowNum = 10; // 목록 개수
	private int pageSize = 10; // 페이지사이즈
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRowNum() {
		return rowNum;
	}
	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}
    public int getPageSize() {
        return pageSize;
    }
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
		
	
	
	

}
