package egovframework.webco.vo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class JQueryGridVO {

    private String iud = "";  // 등록,수정,삭제 구분
    private String errCd = "";  // 에러코드
    private String errMsg = "";  // 에러메시지
    
	int total;
	int page;
	int rowNum;
	int records;

	String sidx;
	String sord;

	List<JQueryGridRowVO> rows;

	private List<Map> dtail;  // 내용
	
	public JQueryGridVO() {

		this.total = 1;
		this.page = 1;
		this.rowNum = 10;
		this.records = 0;

		this.sidx = null;
		this.sord = "asc";

		this.rows = new ArrayList<JQueryGridRowVO>();
	}

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

	public int getRowNum() {
		return rowNum;
	}

	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}

	public int getRecords() {
		return records;
	}

	public void setRecords(int records) {
		this.records = records;
	}

	public String getSidx() {
		return sidx;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

	public String getSord() {
		return sord;
	}

	public void setSord(String sord) {
		this.sord = sord;
	}

	public List<JQueryGridRowVO> getRows() {

		return rows;
	}

	public void setRows(List<JQueryGridRowVO> rows) {
		this.rows = rows;
	}

	public void addRows(JQueryGridRowVO row) {
		this.rows.add(row);
	}
	
	public void addEmptyRow()
	{
		if(this.rows.size()<this.rowNum)
		{
			for(int nIndex = this.rows.size(); nIndex < this.rowNum; nIndex++)
			{
				JQueryGridRowVO row = new JQueryGridRowVO();
				row.setId("8475644"+nIndex);
				this.rows.add(row);
			}
		}
	}
	
	public void calTotalPage()
    {
        this.total = (int)Math.ceil((double)this.records/(double)this.rowNum);
        
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

    public String getIud() {
        return iud;
    }

    public void setIud(String iud) {
        this.iud = iud;
    }

    public List<Map> getDtail() {
        return dtail;
    }

    public void setDtail(List<Map> dtail) {
        this.dtail = dtail;
    }
	
	
}
