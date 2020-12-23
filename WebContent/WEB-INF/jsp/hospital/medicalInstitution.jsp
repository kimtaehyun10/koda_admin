<%@ page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="ajax" uri="http://ajaxtags.sourceforge.net/tags/ajaxtags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader("Expires",0);
%>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="ko">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <meta charset="utf-8" />
    <title>한국장기조직기증원 관리자페이지</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <meta content="한국장기조직기증원 관리자페이지" name="description" />
    <meta content="" name="author" />
	<c:import url="/webHeader.do" charEncoding="UTF-8"></c:import>
</head>
<!-- END HEAD -->
<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">
<c:import url="/webMenu.do" charEncoding="UTF-8"></c:import>

<!-- BEGIN CONTENT -->
  <div class="page-content-wrapper">
      <!-- BEGIN CONTENT BODY -->
      <div class="page-content">
          <!-- BEGIN PAGE HEADER-->                    
          <!-- END PAGE HEADER-->
          <div class="row">
              <div class="col-md-12">
                  <!-- BEGIN SAMPLE TABLE PORTLET-->
                  <div class="portlet light portlet-fit bordered">
                      <div class="portlet-title">
                          <div class="caption">
                              <span class="caption-subject font-dark bold uppercase">뇌사관리 협약병원</span>
                              </div>
                              <div class="actions">
                              <div class="btn-group">
                                  <a class="btn dark btn-outline btn-circle btn-sm" onclick="hospitalWrite('H');">뇌사관리 협약병원 등록</a>
                              </div>
                          </div>    
                      </div>
                      <div class="portlet-body">
                      	<form name="schFrm" id="schFrm" method="post" action="<c:url value="/hospital/medicalInstitution.do"/>">
                      	<input type="hidden" name="page" id="page" value="${param.page}"/>
                      	<table class="table table-bordered">
                      		<colgroup>
                       			<col width="8%"/>
                       			<col width="38%"/>
                       			<col width="8%"/>
                       			<col width="38%"/>
                       			<col width="8%"/>
                       		</colgroup>
                      		<tr>
                      			<th>병원명</th>
                      			<td style="text-align:left;"><input type="text" size=20" name="search_keyword" id="search_keyword" value="${param.search_keyword}"/></td>
                      			<th>지역</th>
                      			<td style="text-align:left;">
                      				<select name="search_area" id="search_area" style="width:200px;">
                      					<option value="">전체</option>
                      					<option value="0" ${param.search_area=='0'?'selected':''}>중부지부</option>
                      					<option value="1" ${param.search_area=='1'?'selected':''}>충청,호남지부</option>                      					                      					                     					
                      					<option value="2" ${param.search_area=='2'?'selected':''}>영남지부</option>                      					                      					                     					
                      				</select>
                      			</td>
                      			
                      			<td>
                      				<div class="btn-group">
                                  		<a id="btnSearch" class="btn dark btn-outline btn-circle btn-sm" href="#">검색</a>
                             		</div>
                      			</td>
                      		</tr>
                      		
                      	</table>   
                      	</form>                   	
                      </div>
                      
                      <form name="Frm" id="Frm" method="post" action="">
                      <input type="hidden" name="hospital_idx" id="hospital_idx" value="">
                      <input type="hidden" name="hospital_type" id="hospital_type" value="">
                      <div class="portlet-body">
                          <div class="table-scrollable">
                              <table class="table table-hover">
                                  <thead>
                                      <tr>
                                      	  <th>No</th>
					                      <th>병원명</th>					                      
					                      <th>지역</th>					                      					                      					                      				                      					                      
					                      <th>위치</th>					                      					                      					                      				                      					                      
					                      <th>전화번호</th>					                      					                      					                      				                      					                      
					                      <th>홈페이지</th>					                      					                      					                      				                      					                      
					                      <th>협약체결일</th>					                      					                      					                      				                      					                      
					                      <th>관리</th>
					                  </tr>
					                  
                                  </thead>
                                  <tbody>
									<c:forEach var="hspList" items="${hspList_list}" varStatus="status">                                      
                                      <tr>
                                      	  <td>${(total_count - status.index) - ( (currentPage - 1)  *  displayNum ) }</td>                    	                                                                                 
                                          <td style="line-height:60px">${hspList.hospital_name}</td>                                                                                   
                                          <td style="line-height:60px">
                                          	<c:if test="${hspList.hospital_area eq '0'}">
                                          		중부지부
                                          	</c:if>
                                          	<c:if test="${hspList.hospital_area eq '1'}">
                                          		충청,호남지부
                                          	</c:if>
                                          	<c:if test="${hspList.hospital_area eq '2'}">
                                          		영남지부
                                          	</c:if>
                                          </td>
                                          <td style="line-height:60px">${hspList.hospital_loc}</td>                                                                                                                                                                
                                          <td style="line-height:60px">${hspList.hospital_tel}</td>                                                                                                                                                                
                                          <td style="line-height:60px">${hspList.hospital_link}</td>                                                                                                                                                                
                                          <td style="line-height:60px">${hspList.hospital_dt}</td>                                                                                                                                                                
                                          <td style="line-height:60px">
                                          <a style="line-height:60px" onclick="hospitalUpdate(${hspList.hospital_idx});"><button class="btn btn-default btn-circle mt-sweetalert" type="button"><i class="fa fa-paste"></i> 수정</button></a>
                                          <a style="line-height:60px" onclick="hospitalDelete(${hspList.hospital_idx},'${hspList.hospital_type}');"><button class="btn btn-danger btn-circle mt-sweetalert" type="button"><i class="fa fa-times"></i> 삭제</button></a>
                                          </td>
                                          
                                      </tr>
                                      </c:forEach>
                                  </tbody>
                              </table>
                          </div>
                      </div>
                      </form>
                  </div>
                  <!-- END SAMPLE TABLE PORTLET-->
				  <nav aria-label="Page navigation" style="margin-top: 50px; text-align: center;">
                      <ul class="pagination my_pagetion">
                          <c:if test="${not empty paginationInfo}"> <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_search"/> </c:if>
                      </ul>
                  </nav>  
              </div>
          </div>
      </div>
      <!-- END CONTENT BODY -->
  </div> 
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery_redirect/jquery.redirect.js" type="text/javascript"></script>
  
<script>
function fn_search(pageNo) {		
	$('#page').val(pageNo);
	$('#schFrm').submit();
}

$('#btnSearch').on('click', function(e){
	e.preventDefault();
	$('#page').val('1');
	$('#schFrm').submit();
})

function hospitalUpdate(idx){
	/* $("#hospital_idx").val(idx);
	$('#Frm').attr("action","/hospital/hospitalUpdatePopup.p");
	$('#Frm').submit(); */
	//debugger;     javascript 디버그
	var screenW = screen.availWidth;  
    var screenH = screen.availHeight; 
    var popW = 750; 
    var popH = 320; 
    var posL=( screenW-popW ) / 2;    
    var posT=( screenH-popH ) / 2;    
    var url = "/hospital/hospitalUpdatePopup.p?hospital_idx="+idx;	
	window.open(url,'_blank','width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=yes,status=no,titlebar=no');
}
function hospitalDelete(idx,type) {
	$("#hospital_idx").val(idx);
	$("#hospital_type").val(type);
    if(confirm('정말 삭제하시겠습니까? ')){
    	$.ajax({
            url : "/hospital/hospitalDeleteEnd.do",
            type: "POST",
            data:$("#Frm").serialize(),
            dataType:"json", 
            success : function(data, textStatus, jqXHR) {
            	alert(data);
          	  	$("#schFrm").submit();                              
            }, 
            error : function(jqXHR, textStatus, errorThrown){
             	
            }
        });
    }
}
function hospitalWrite(type){
	var screenW = screen.availWidth;  
    var screenH = screen.availHeight; 
    var popW = 750; 
    var popH = 320; 
    var posL=( screenW-popW ) / 2;    
    var posT=( screenH-popH ) / 2;    
    var url = "/hospital/hospitalWritePopup.p?hospital_type="+type;	
	window.open(url,'_blank','width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=yes,status=no,titlebar=no');
}
</script>