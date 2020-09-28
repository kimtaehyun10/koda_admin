package egovframework.webco.dao;

import egovframework.webco.controller.bean.defaultGridBean;

import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.jdom.output.XMLOutputter;




public class defaultGridDAO {
	
	/**
	 * getGridResult2 함수 호출 시 사용.
	 * 최 상위 노드 (고정)
	 */
	private String root_node = "rootItems";
	/**
	 * getGridResult2 함수 호출 시 사용.
	 * 중간 노드
	 */
	private String child_node = "";
	
	public String getChild_node() {
		return child_node;
	}

	public void setChild_node(String child_node) {
		this.child_node = child_node;
	}


	/**
	 * 등록, 수정, 삭제 결과
	 * @param response
	 * @param rsCount
	 * 
	 * 사용법 : dao.getCUDResult(response, rsCount);
	 */
	public void getCUDResult(HttpServletResponse response, int rsCount){
		ObjectMapper mapper = new ObjectMapper();
		PrintWriter pwr = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		response.setCharacterEncoding("UTF-8");
		
		if(rsCount > -1)
			map.put("result", "success-"+rsCount);
		else
			map.put("result", "failure");
			
		try {
			pwr = response.getWriter();
			mapper.writeValue(pwr, map);
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	/**
	 * 등록, 수정, 삭제 결과
	 * @param response
	 * @param rsCount
	 * 
	 * 사용법 : dao.getCUDResult2(response, rsCount);
	 */
	public void getCUDResult2(HttpServletResponse response, int rsCount){
		XMLOutputter outputter = new XMLOutputter();
		Document document = null;

		Element root = new Element(root_node);
		Element data = new Element("data");
		
		response.setCharacterEncoding("UTF-8");
				
		if(rsCount > -1)
			addElement(data, "result", String.valueOf(rsCount));
		else
			addElement(data, "result", "failure");

		root.addContent(data);
		
		document = new Document(root);
		
		response.setContentType("application/xml");
		try {
			outputter.output(document, response.getWriter());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 등록, 수정, 삭제 결과 - data.result. String 값
	 * @param response
	 * @param result
	 * 
	 * 사용법 : dao.getCUDResult3(response, strResult);
	 */
	public void getCUDResult3(HttpServletResponse response, String result){
		XMLOutputter outputter = new XMLOutputter();
		Document document = null;

		Element root = new Element(root_node);
		Element data = new Element("data");
		
		response.setCharacterEncoding("UTF-8");
		addElement(data, "result", result);
		
		root.addContent(data);
		
		document = new Document(root);
		
		response.setContentType("application/xml");
		try {
			outputter.output(document, response.getWriter());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	/**
	 * 등록, 수정, 삭제 결과 - data.result. String 값1. String 값2
	 * @param response
	 * @param result
	 * 
	 * 사용법 : dao.getCUDResult4(response, strResult1, strResult2);
	 */
	public void getCUDResult4(HttpServletResponse response, String result1, String result2){
		XMLOutputter outputter = new XMLOutputter();
		Document document = null;

		Element root = new Element(root_node);
		Element data = new Element("data");
		
		response.setCharacterEncoding("UTF-8");
		addElement(data, "result1", result1);
		addElement(data, "result2", result2);
		
		root.addContent(data);
		
		document = new Document(root);
		
		response.setContentType("application/xml");
		try {
			outputter.output(document, response.getWriter());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 등록, 수정, 삭제 결과 - data.result, String 값1, String 값2,  String 값3
	 * @param response
	 * @param result
	 * 
	 * 사용법 : dao.getCUDResult4(response, strResult1, strResult2, strResult3);
	 */
	public void getCUDResult5(HttpServletResponse response, String result1, String result2, String result3){
		XMLOutputter outputter = new XMLOutputter();
		Document document = null;

		Element root = new Element(root_node);
		Element data = new Element("data");
		
		response.setCharacterEncoding("UTF-8");
		addElement(data, "result1", result1);
		addElement(data, "result2", result2);
		addElement(data, "result3", result3);
		
		root.addContent(data);
		
		document = new Document(root);
		
		response.setContentType("application/xml");
		try {
			outputter.output(document, response.getWriter());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	/**
	 * grid 값을 JSON 형태로 반환한다.
	 * @param response
	 * @param result
	 * 		  - List 형태 list() 함수 결과물
	 * 
	 */
	public void getGridResult(HttpServletResponse response, List result){
		defaultGridBean dgb = new defaultGridBean();
		dgb.setData(result);
		dgb.setCount(10);
		ObjectMapper mapper = new ObjectMapper();
		
		response.setCharacterEncoding("UTF-8");
		
		PrintWriter pwr = null;
		
		try {
			pwr = response.getWriter();
			mapper.writeValue(pwr, dgb);
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * grid 값을 XML 형태로 반환한다.
	 * @param response
	 * @param result
	 */
	public void getGridResult2(HttpServletResponse response, List result){
		XMLOutputter outputter = new XMLOutputter();
		Document document = null;
		
		response.setCharacterEncoding("UTF-8");
		
		if(getChild_node().equals(""))		
			setChild_node("data");
				
		document = (Document)iBatisForMake(result,null);
		
		response.setContentType("application/xml");
		try {
			outputter.output(document, response.getWriter());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 그리드 결과 조회 - childNode 포함
	 * @param response
	 * @param result
	 * @param childNodeName
	 * 
	 * 사용법 : dao.getGridResult3(response, resultList, childNodeMap) 
	 */
	public void getGridResult3(HttpServletResponse response, List result, Map childNodeName){
		XMLOutputter outputter = new XMLOutputter();
		Document document = null;
		
		response.setCharacterEncoding("UTF-8");
		
		if(getChild_node().equals(""))		
			setChild_node("data");
				
		document = (Document)iBatisForMake(result,childNodeName);
		
		response.setContentType("application/xml");
		try {
			outputter.output(document, response.getWriter());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getGridResult4(HttpServletResponse response, Map map){
	    XMLOutputter outputter = new XMLOutputter();
		Document document = null;
		
		response.setCharacterEncoding("UTF-8");

		if(getChild_node().equals(""))		
			setChild_node("data");
		
		document = (Document)iBatisForMake2(map);

		response.setContentType("application/xml");
		try {
			outputter.output(document, response.getWriter());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getGridResult5(HttpServletResponse response, Map map){
		ObjectMapper mapper = new ObjectMapper();
		PrintWriter pwr = null;
		
		response.setCharacterEncoding("UTF-8");
		
		response.setContentType("text/json");
			
		try {
			pwr = response.getWriter();
			mapper.writeValue(pwr, map);
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getGridResult6(HttpServletResponse response, List result){
		ObjectMapper mapper = new ObjectMapper();
		PrintWriter pwr = null;
		
		response.setCharacterEncoding("UTF-8");
		
		response.setContentType("text/json");
			
		try {
			pwr = response.getWriter();
			mapper.writeValue(pwr, result);
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public Document iBatisForMake2(Map map){
		Element data = new Element(root_node);
		Element element= new Element(child_node);
		
		Set keySet = map.keySet();
		Object[] keys = keySet.toArray();
		
		for(int i=0;i<keys.length;i++){
			String key = (String)keys[i];
			String value = (String)map.get(key);
			
			addElement(element, key, value);
		}
		data.addContent(element);
		Document document = new Document(data);
		
		return document;
	}
	
	public Document iBatisForMake(List result, Map childNodeName){
		Element data = new Element(root_node);
						
		for(int i=0;i<result.size();i++){
			Element element;
			if(childNodeName == null || childNodeName.get(i)==null)
				element= new Element(child_node);
			else
				element= new Element(childNodeName.get(i).toString());
			
			String xml = (String)result.get(i);
			Document document = null;
			try {
				document = new SAXBuilder().build(new StringReader(xml));
			} catch (JDOMException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			Element root = document.getRootElement();
			List child = root.getChildren();
			Iterator iter = child.iterator();
			while(iter.hasNext()){
				Element node = (Element)iter.next();
				
				String name = (String)node.getName();
				String value = (String)node.getText();
				addElement(element, name, value);
			}
			
			data.addContent(element);
		}
		Document document = new Document(data);
		
		return document;
	}
	
	public Element addElement(Element parent, String name, String value){
		Element element = new Element(name);
		element.setText(value);
		parent.addContent(element);
		return parent;
	}
	
	
	/**
	 * page 처리
	 * (※반드시 request에 page, rows 파라미터가 존재해야한다.)
	 * @param request
	 * @return Map 
	 */
	public Map getPages(HttpServletRequest request){
		Map map = new HashMap();
		
		int page = Integer.parseInt(request.getParameter("page"));
		int rows = Integer.parseInt(request.getParameter("rows"));
		
		map.put("start_row", (page-1)*rows+1);
		map.put("end_row", (page-1)*rows+rows);	//페이징 처리
				
		return map;
	}
	
	@SuppressWarnings("deprecation")
	public Connection getDBConnectionInJSP(HttpServletRequest request){
		//Properties 불러오기
		Properties prop = new Properties();
		String path = request.getRealPath("/WEB-INF/classes/egovframework/egovProps/globals.properties");
		
		Connection conn = null;
		try{
			prop.load(new FileInputStream(path));
	
			/* System.out.println("Driver : "+prop.getProperty("Globals.DriverClassName"));
			System.out.println("URL : "+prop.getProperty("Globals.Url"));
			System.out.println("NAME : "+prop.getProperty("Globals.UserName"));
			System.out.println("PASS : "+prop.getProperty("Globals.Password")); */
			
			//필요한 정보로 DB 컨넥션 만들기.
			Class.forName(prop.getProperty("Globals.DriverClassName"));
			conn = DriverManager.getConnection(prop.getProperty("Globals.Url"),prop.getProperty("Globals.UserName"), prop.getProperty("Globals.Password"));
			conn.setAutoCommit(true);
		}catch (Exception e) {
			
		}
		
		return conn;
	}
	
	
	/**
	 * 엑셀저장
	 * DB 조회 후 가져오는 값에 null 이 포함되면 nullpoint 오류 일어남
	 */
	@SuppressWarnings("deprecation")
	public void saveToExcel(HttpServletResponse response, List result, String[] header, String[] sort, int[] widths, 
			String[] type, String filename, String sheetName){
		
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = null;
	        
		if(sheetName!=null){
			sheet = wb.createSheet(sheetName);
		}else{
			sheet = wb.createSheet(); 
		}
		for(int i=0;i<widths.length;i++){
			sheet.setColumnWidth(i, widths[i]);
		}
		
		int rownum = 0;
		int cellnum = 0;
		
		Iterator iter = result.iterator();
		
		while(iter.hasNext()){
			Map map = (Map)iter.next();
			
			// 컬럼 제목 생성
			if(rownum==0){
				HSSFRow firstRow = sheet.createRow(rownum++);
				for(int j = 0;j<header.length; j++){
					firstRow.createCell(cellnum++, HSSFCell.CELL_TYPE_STRING).setCellValue(header[j]);
				}
			}
			
			// 데이터 생성
			HSSFRow row = sheet.createRow(rownum++);		
			cellnum = 0;
				
			for(int i = 0; i<sort.length;i++){
				HSSFCell cell = row.createCell(cellnum++);
				if(type[i].equals("Number")){
					try{
						cell.setCellValue(Integer.valueOf(map.get(sort[i]).toString()).doubleValue());
					}catch(Exception e){
						cell.setCellValue(0);
					}
				}else{
					cell.setCellValue(map.get(sort[i]).toString());
				}
			}				
		}
		
		try {
			filename = URLEncoder.encode(filename, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		//application/vnd.ms-excel
		response.setHeader("Content-Type", "application/vnd.ms-excel");
		
		response.setHeader("Content-Disposition", "attachment;filename="
				+ filename + ".xls;");
		
		BufferedOutputStream bos = null;
		try {
			bos = new BufferedOutputStream(response.getOutputStream());
			wb.write(bos);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				if(bos != null)bos.close();
			} catch (IOException e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}	
	}
}
