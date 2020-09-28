package egovframework.webco.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import egovframework.webco.vo.JQueryGridRowVO;
import egovframework.webco.vo.JQueryGridVO;
import net.sf.json.JSONObject;


public class winigridJasonDAO implements Serializable{			
  
public JSONObject makeWiniGridList(JQueryGridVO gridVO, List list) {
		
          if (gridVO.getRowNum() == 0) {
              gridVO.setRowNum(list.size());
              gridVO.setRecords(list.size()); // 총 레코드수
          } 
                      
          for(int i=0; i< list.size();i++){
              
              JQueryGridRowVO row = new JQueryGridRowVO();
              
              row.setId(""+i);
              
              //m_vo  = (DraftingPaperVO) list.get(i);
              Map<String, Object> map_r = (Map) (list.get(i));
              
              for (Map.Entry<String, Object> entry: map_r.entrySet()) {
            	  
            	  
                //System.out.println("key : " + entry.getKey() + " / value : " +  (String)entry.getValue());
                  String val = "";
                  if (entry.getValue() != null)
                      val = String.valueOf(entry.getValue());
                  
                  row.addCells(val);
              }
      
              gridVO.addRows(row);
          }
          
          gridVO.calTotalPage(); // 총페이지수 계산
          gridVO.addEmptyRow(); // 빈공백 라인
          JSONObject jsonGrid = JSONObject.fromObject(gridVO);
    		
          return jsonGrid;
	}
  
    public JSONObject makeWiniGridList(Map params, List list, int totalCount) {
    
        JQueryGridVO gridVO = new JQueryGridVO();
       
        int rowNum = 0; 
        int page = 1; 
                
        if (params.get("rowNum") != null)
            rowNum = Integer.parseInt(""+params.get("rowNum"));
        
        if (params.get("page") != null)
            page = Integer.parseInt(""+params.get("page"));
        
        gridVO.setPage(page);
        
        if (rowNum == 0) {
            gridVO.setRowNum(list.size());
            gridVO.setRecords(list.size()); // 총 레코드수
        } else {
            gridVO.setRowNum(rowNum);
            gridVO.setRecords(totalCount); // 총 레코드수
        }
                    
        for(int i=0; i< list.size();i++){
            
            JQueryGridRowVO row = new JQueryGridRowVO();
            
            row.setId(""+i);
            
            //m_vo  = (DraftingPaperVO) list.get(i);
            Map<String, Object> map_r = (Map) (list.get(i));
            
            for (Map.Entry<String, Object> entry: map_r.entrySet()) {
                
                //System.out.println("key : " + entry.getKey() + " / value : " +  (String)entry.getValue());
                String val = "";
                if (entry.getValue() != null)
                    val = String.valueOf(entry.getValue());
                
                row.addCells(val);
            }
    
            gridVO.addRows(row);
        }
        
        gridVO.calTotalPage(); // 총페이지수 계산
        gridVO.addEmptyRow(); // 빈공백 라인
        JSONObject jsonGrid = JSONObject.fromObject(gridVO);
    
        return jsonGrid;
    }
    
    // WiniGird 사용 (// WiniGrid 1.5 버전에서 colModel 의 index 로 컬럼명과 매치하여 데이터 매핑이 가능하도록 하기 위하 추가함)
    public JSONObject makeWiniGrid15List(Map params, List list, int totalCount) {
        
        JQueryGridVO gridVO = new JQueryGridVO();
       
        int rowNum = 0; 
        int page = 1; 
                
        if (params.get("rowNum") != null)
            rowNum = Integer.parseInt(""+params.get("rowNum"));
        
        if (params.get("page") != null)
            page = Integer.parseInt(""+params.get("page"));
        
        gridVO.setPage(page);
        
        if (rowNum == 0) {
            gridVO.setRowNum(list.size());
            gridVO.setRecords(list.size()); // 총 레코드수
        } else {
            gridVO.setRowNum(rowNum);
            gridVO.setRecords(totalCount); // 총 레코드수
        }
                    
        for(int i=0; i< list.size();i++){
            
            if (i == 0) { 
                // WiniGrid 1.5 버전에서 colModel 의 index 로 컬럼명과 매치하여 데이터 매핑이 가능하도록 하기 위하 추가함
                JQueryGridRowVO row = new JQueryGridRowVO();
                row.setId("-1");
                
                Map<String, Object> map_r = (Map) (list.get(0));
                
                for (Map.Entry<String, Object> entry: map_r.entrySet()) {
                  //System.out.println("key : " + entry.getKey() + " / value : " +  (String)entry.getValue());
                    String val = "";
                    if (entry.getKey() != null)
                        val = String.valueOf(entry.getKey());
                    
                    row.addCells(val);
                }
        
                gridVO.addRows(row);
                
            }
            
            JQueryGridRowVO row = new JQueryGridRowVO();
            
            row.setId(""+i);
            
            //m_vo  = (DraftingPaperVO) list.get(i);
            Map<String, Object> map_r = (Map) (list.get(i));
            
            for (Map.Entry<String, Object> entry: map_r.entrySet()) {
                
                //System.out.println("key : " + entry.getKey() + " / value : " +  (String)entry.getValue());
                String val = "";
                if (entry.getValue() != null)
                    val = String.valueOf(entry.getValue());
                
                row.addCells(val);
            }
    
            gridVO.addRows(row);
        }
        
        gridVO.calTotalPage(); // 총페이지수 계산
        //gridVO.addEmptyRow(); // 빈공백 라인
        JSONObject jsonGrid = JSONObject.fromObject(gridVO);
    
        return jsonGrid;
    }    

  public JQueryGridVO makeWiniGridDetail(List list) {

      //JSONObject jsonGrid = new JSONObject();
      
      JQueryGridVO jq = new JQueryGridVO();
      jq.setRows(list);
      jq.setPage(1);
      jq.setRecords(list.size());
      jq.setTotal(1);
      
      return jq;
      
}


  public JSONObject makeErrMsg(String errCode, String ErrMsg) {
      
      JQueryGridVO gridVO = new JQueryGridVO();
      
      gridVO.setErrCd(errCode);
      gridVO.setErrMsg(ErrMsg);
      
      JSONObject jsonGrid = JSONObject.fromObject(gridVO);
        
      return jsonGrid;
}

public JSONObject makeWiniGridList2XX(JQueryGridVO gridVO, List list) {
	// TODO Auto-generated method stub
    if (gridVO.getRowNum() == 0) {
        gridVO.setRowNum(list.size());
        gridVO.setRecords(list.size()); // 총 레코드수
    } 
                
    for(int i=0; i< list.size();i++){
        
        JQueryGridRowVO row = new JQueryGridRowVO();
        
        row.setId(""+i);
        
        //m_vo  = (DraftingPaperVO) list.get(i);
        Map<String, Object> map_r = (Map) list.get(i);
        
        for (Map.Entry<String, Object> entry: map_r.entrySet()) {

            //System.out.println("key : " + entry.getKey() + " / value : " + (String) entry.getValue());
            String val = "";
            if (entry.getValue() != null)
                val = String.valueOf(entry.getValue());
            
            row.addCells(val);
        }

        gridVO.addRows(row);
    }
    
    gridVO.calTotalPage(); // 총페이지수 계산
    gridVO.addEmptyRow(); // 빈공백 라인
    JSONObject jsonGrid = JSONObject.fromObject(gridVO);
		
    return jsonGrid;
}
}
