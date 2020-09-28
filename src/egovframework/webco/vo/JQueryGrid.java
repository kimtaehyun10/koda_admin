package egovframework.webco.vo;

public class JQueryGrid {

	boolean recordsAt;
	int records;
	int startIdx;
	int endIdx;
	String sidx;
	boolean sord;

	
	public JQueryGrid()
	{
		this.recordsAt = false;
		
	}
	
	public boolean isRecordsAt() {
		return recordsAt;
	}

	public void setRecordsAt(boolean recordsAt) {
		this.recordsAt = recordsAt;
	}

	public int getRecords() {
		return records;
	}

	public void setRecords(int records) {
		this.records = records;
	}

	public int getStartIdx() {
		return startIdx;
	}

	public void setStartIdx(int startIdx) {
		this.startIdx = startIdx;
	}

	public int getEndIdx() {
		return endIdx;
	}

	public void setEndIdx(int endIdx) {
		this.endIdx = endIdx;
	}

	public String getSidx() {
		return sidx;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

	public boolean getSord() {
		return sord;
	}

	public void setSord(String sord) {
		
		if(sord.toLowerCase().equals("asc"))
			this.sord = true;
		else
			this.sord = false;
	}

}
