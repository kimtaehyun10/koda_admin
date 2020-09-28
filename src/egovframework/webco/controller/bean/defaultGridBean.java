package egovframework.webco.controller.bean;

import java.util.List;
import java.util.Map;

public class defaultGridBean {
	int count;
	List<Map> data;
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public List<Map> getData() {
		return data;
	}
	public void setData(List<Map> data) {
		this.data = data;
	}
}
