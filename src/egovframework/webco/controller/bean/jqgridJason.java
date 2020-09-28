package egovframework.webco.controller.bean;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class jqgridJason implements Serializable{
	
	private int total;       // 페이지 갯수
	private int page;        // 현재 페이지 번호
	private int records;     // 한페이지당 출력 갯수
	private int totalRecords;     // 한페이지당 출력 갯수
	private List<Map> rows;  // 내용
	
	private String succYn  = "";  // 서비스 성공여부
	private String errCd = "";  // 에러코드
	private String errMsg = "";  // 에러메시지
	private Map<String, Object> param;
	
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRecords() {
		return records;
	}
	public void setRecords(int records) {
		this.records = records;
	}
	public List<Map> getRows() {
		return rows;
	}
	public void setRows(List<Map> rows) {
		this.rows = rows;
	}
	public String getErrCd() {
		return errCd;
	}
	public void setErrCd(String errCd) {
		this.errCd = errCd;
	}
	public String getErrMsg() {
		return errMsg;
	}
	public void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}
	public String getSuccYn() {
		return succYn;
	}
	public void setSuccYn(String succYn) {
		this.succYn = succYn;
	}
    public int getTotalRecords() {
        return totalRecords;
    }
    public void setTotalRecords(int totalRecords) {
        this.totalRecords = totalRecords;
    }
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	} 
	
	
}
