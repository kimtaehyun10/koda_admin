package egovframework.webco.vo;

import java.util.ArrayList;
import java.util.List;

public class JQueryGridRowVO {

	String id;
	List<Object> cell;

	public JQueryGridRowVO() {
		this.id = null;
		this.cell = new ArrayList<Object>();
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public List<Object> getCell() {
		return cell;
	}

	public void setCell(List<Object> cell) {
		this.cell = cell;
	}
	
	public void addCells(Object cell) {
		this.cell.add(cell);
	}

}
