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
                              <span class="caption-subject font-dark bold uppercase">이식현황</span>
                              </div>
                              <div class="actions">
                              <div class="btn-group">
                                  <a class="btn dark btn-outline btn-circle btn-sm" onclick="organDonateStatsWriteForm();">이식현황 통계 등록</a>
                              </div>
                          </div>    
                      </div>
                      <div class="portlet-body">
                      	<form name="fileFrm" id="fileFrm">
                      	<input type="hidden" name="brd_no" value="${file.brd_no}">                 
                      	<input type="hidden" name="brd_cont_no" value="${file.brd_cont_no}">                 
                      	<table class="table table-bordered">                     		                     		
                      		<tr>                      			
                      			<th>이식현황 통계자료</th>
                      			<td style="text-align: left;">
                      				${file.brd_file_org_nm}
									<input type="file" id="brd_file_org_nm" name="brd_file_org_nm"/>	                                        
                      			</td>
                      			<td>
                      				<div class="btn-group">
                                  		<a id="fileBtn" class="btn dark btn-outline btn-circle btn-sm" href="#">파일업로드</a>
                             		</div>
                      			</td>
                      		</tr>
                      		
                      	</table>   
                      	</form>                   	
                      </div>
                      <div class="portlet-body">
                          <div class="table-scrollable">
                              <table class="table table-hover">
                                  <thead>
                                      <tr>
                                      	  
									      <th rowspan="2">연도</th>
									      <th rowspan="2">뇌사자(명)</th>
									      <th colspan="9">이식건수</th>
									      <th rowspan="2">관리</th>
								      </tr>
									  <tr>
									      <th>Total</th>
									      <th>신장</th>
									      <th>간장</th>
									      <th>췌장</th>
									      <th>심장</th>
									      <th>폐</th>
									      <th>췌도</th>
									      <th>소장</th>
									      <th>각막</th>
								      </tr>
                                  </thead>
                                  <tbody>
									<c:forEach var="odsList" items="${odsList_list}" varStatus="status">                                      
                                      <tr>
                                      	  
                                          <td style="line-height:60px">${odsList.stats_date}</td>                                                                                  
                                          <td style="line-height:60px">${odsList.stats_brain_total}</td>
                                          <td style="line-height:60px">${odsList.stats_total}</td>
                                          <td style="line-height:60px">${odsList.stats_kidney}</td>
                                          <td style="line-height:60px">${odsList.stats_hepar}</td>
                                          <td style="line-height:60px">${odsList.stats_pancreas}</td>
                                          <td style="line-height:60px">${odsList.stats_heart}</td>
                                          <td style="line-height:60px">${odsList.stats_lung}</td>
                                          <td style="line-height:60px">${odsList.stats_islet}</td>
                                          <td style="line-height:60px">${odsList.stats_intestine}</td>
                                          <td style="line-height:60px">${odsList.stats_cornea}</td>                                                                                                                              
                                          <td style="line-height:60px">
                                          <a style="line-height:60px" onclick="organDonateStatsUpdateForm(${odsList.stats_idx});"><button class="btn btn-default btn-circle mt-sweetalert" type="button"><i class="fa fa-paste"></i> 수정</button></a>
                                          <a style="line-height:60px" onclick="organDonateStatsDeleteEnd(${odsList.stats_idx});"><button class="btn btn-danger btn-circle mt-sweetalert" type="button"><i class="fa fa-times"></i> 삭제</button></a>
                                          </td>
                                          
                                      </tr>
                                      </c:forEach>
                                  </tbody>
                              </table>
                          </div>
                      </div>
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
	location.href = '<c:url value="/statistics/organDonateStats.do"/>?page='+pageNo;
}
function organDonateStatsUpdateForm(idx){
	
	var screenW = screen.availWidth;  
    var screenH = screen.availHeight; 
    var popW = 460; 
    var popH = 450; 
    var posL=( screenW-popW ) / 2;    
    var posT=( screenH-popH ) / 2;    
    var url = "/statistics/organDonateStatsUpdateForm.p?stats_idx="+idx;	
	window.open(url,'_blank','width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=yes,status=no,titlebar=no');
	
}
function organDonateStatsDeleteEnd(idx) {
    if(confirm('정말 삭제하시겠습니까? ')){
    	$.ajax({
            url : "/statistics/organDonateStatsDeleteEnd.do",
            type: "POST",
            data:{
                stats_idx : idx
            },
            dataType:"json", 
            success : function(data, textStatus, jqXHR) {
            	  alert(data);
            	  window.location.reload(true);                             
            }, 
            error : function(jqXHR, textStatus, errorThrown){
             	
            }
        });
    }
}
function organDonateStatsWriteForm(){
	var screenW = screen.availWidth;  
    var screenH = screen.availHeight; 
    var popW = 460; 
    var popH = 450; 
    var posL=( screenW-popW ) / 2;    
    var posT=( screenH-popH ) / 2;    
    var url = "/statistics/organDonateStatsWriteForm.p";	
	window.open(url,'_blank','width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=yes,status=no,titlebar=no');
}

$("#fileBtn").click(function(){
        
        var form = $('#fileFrm')[0];
 
        var data = new FormData(form);

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/admin/fileUpload.do",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
            	var reData = data.replace(/"/gi,"");
            	alert(reData.split(",")[0]);
            	window.location.reload(true);
            },
            error: function (e) {
                
            }
        });
		
		
});

</script>