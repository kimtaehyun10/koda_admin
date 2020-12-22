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
                              <span class="caption-subject font-dark bold uppercase">기증자</span>
                              </div>
                              <div class="actions">
                              <div class="btn-group">
                                  <a class="btn dark btn-outline btn-circle btn-sm" onclick="brainDonateStatsWriteForm();">기증자 통계 등록</a>
                              </div>
                          </div>    
                      </div>
                      <div class="portlet-body">
                      	<form name="schFrm" id="schFrm" method="post" action="<c:url value="/statistics/brainDonateStats.do"/>">
                      	<input type="hidden" name="page" id="page" value="${param.page}"/>
                      	<table class="table table-bordered">
                      		                     		
                      		<tr>                      			
                      			<th>일자</th>
                      			<td style="text-align:left;">
									<input type="text" size="20" name="search_start_date" id="search_start_date" class="form_datetime" value="${param.search_start_date}">	                                                           
	                                ~	                                        
									<input type="text" size="20" name="search_end_date"  id="search_end_date" class="form_datetime" value="${param.search_end_date}">
									<div class="btn-group">
									<a id="user_period_search_day" class="btn dark btn-outline btn-circle btn-sm" href="#" style="margin-right:5px;">일간</a>
                               		<a id="user_period_search_week" class="btn dark btn-outline btn-circle btn-sm" href="#" style="margin-right:5px;">주간</a>
                                	<a id="user_period_search_month" class="btn dark btn-outline btn-circle btn-sm" href="#" style="margin-right:5px;">월간</a>
                                	<a id="user_period_search_year" class="btn dark btn-outline btn-circle btn-sm" href="#" style="margin-right:5px;">연간</a>
                                	</div>	                                        
                      			</td>
                      			<td >
                      				<div class="btn-group">
                                  		<a id="btnSearch" class="btn dark btn-outline btn-circle btn-sm" href="#">검색</a>
                             		</div>
                      			</td>
                      		</tr>
                      		
                      	</table>   
                      	</form>                   	
                      </div>
                      <form name="Frm" id="Frm" method="post" action="">
                      <input type="hidden" name="donate_idx" id="donate_idx" value="">
                      <div class="portlet-body">
                          <div class="table-scrollable">
                              <table class="table table-hover">
                                  <thead>
                                      <tr>
                                      	  
					                      <th rowspan="2">일자</th>
					                      <th colspan="2">합계</th>
					                      <th colspan="2">서울권역</th>
					                      <th colspan="2">충청·호남권역</th>
					                      <th colspan="2">영남권역</th>
					                      <th rowspan="2">관리</th>
					                  </tr>
					                  <tr>
				                    	  <th>장기기증</th>
					                      <th>조직기증</th>
					                      <th>장기기증</th>
					                      <th>조직기증</th>
					                      <th>장기기증</th>
					                      <th>조직기증</th>
					                      <th>장기기증</th>
					                      <th>조직기증</th>	                    
					                  </tr>
                                  </thead>
                                  <tbody>
									<c:forEach var="bdsList" items="${bdsList_list}" varStatus="status">                                      
                                      <tr>
                                      	  
                                          <td style="line-height:60px">${bdsList.stats_date}</td>
                                          <td style="line-height:60px">${bdsList.stats_sphere_tdonor1+bdsList.stats_sphere_tdonor2+bdsList.stats_sphere_tdonor3}</td>
                                          <td style="line-height:60px">${bdsList.stats_sphere_edonor1+bdsList.stats_sphere_edonor2+bdsList.stats_sphere_edonor3}</td>                                          
                                          <td style="line-height:60px">${bdsList.stats_sphere_tdonor1}</td>
                                          <td style="line-height:60px">${bdsList.stats_sphere_edonor1}</td>
                                          <td style="line-height:60px">${bdsList.stats_sphere_tdonor2}</td>
                                          <td style="line-height:60px">${bdsList.stats_sphere_edonor2}</td>
                                          <td style="line-height:60px">${bdsList.stats_sphere_tdonor3}</td>
                                          <td style="line-height:60px">${bdsList.stats_sphere_edonor3}</td>                                          
                                          <td style="line-height:60px">
                                          <a style="line-height:60px" onclick="brainDonateStatsUpdateForm(${bdsList.stats_idx});"><button class="btn btn-default btn-circle mt-sweetalert" type="button"><i class="fa fa-paste"></i> 수정</button></a>
                                          <a style="line-height:60px" onclick="brainDonateStatsDeleteEnd(${bdsList.stats_idx});"><button class="btn btn-danger btn-circle mt-sweetalert" type="button"><i class="fa fa-times"></i> 삭제</button></a>
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
<!-- <script>
function fn_search(pageNo) {
	location.href = '<c:url value="/statistics/brainDonateStats.do"/>?page='+pageNo;
}
</script> -->  
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
Date.prototype.addDays = function (n) {
    var time = this.getTime();
    var changedDate = new Date(time + (n * 24 * 60 * 60 * 1000));
    this.setTime(changedDate.getTime());
    return this;
};
function setSearchStartDateByOption(period) {	
	if($("#search_end_date").val() == '') initValue();
    var search_end_date = $("#search_end_date").val();        
    var date_arr = search_end_date.split('-');
    var search_end_date_obj = new Date(date_arr[0], date_arr[1]-1, date_arr[2]);
    var search_start_date_obj = search_end_date_obj;
    var search_start_date_string = "";
    if(period == 30) {
        search_start_date_string = search_start_date_obj.getFullYear() + "-" + ((search_start_date_obj.getMonth()+1) < 10 ? "0"+(search_start_date_obj.getMonth()+1) : (search_start_date_obj.getMonth()+1)) + "-" + "01";
    } else if(period == 365){
        search_start_date_string = search_start_date_obj.getFullYear() + "-" + "01" + "-" + "01";
    } else {
        search_start_date_obj = search_start_date_obj.addDays(-period);
        search_start_date_string = search_start_date_obj.getFullYear() + "-" + ((search_start_date_obj.getMonth()+1) < 10 ? "0"+(search_start_date_obj.getMonth()+1) : (search_start_date_obj.getMonth()+1)) + "-"
        						+ (search_start_date_obj.getDate() < 10 ? "0"+search_start_date_obj.getDate() : search_start_date_obj.getDate());
    }
    $("#search_start_date").val(search_start_date_string);
}
function initValue() {
    // Search Init
    $("#detail_search_visit_period").addClass("active");
    $("#user_period_search_day").addClass("active");
    var today = new Date();
    today.setDate(today.getDate());
    var today_string = today.getFullYear() + "-" + ((today.getMonth()+1 < 10) ? "0"+(today.getMonth()+1) : (today.getMonth()+1)) + "-" 
    					+ (today.getDate() < 10 ? "0"+today.getDate() : today.getDate());
    $("#search_start_date").val(today_string);
    $("#search_end_date").val(today_string);
}
$(function() {	
	$("#user_period_search_day").click(function(e) {
		e.preventDefault();
        setSearchStartDateByOption(0);        
    });
    $("#user_period_search_week").click(function(e) {
    	e.preventDefault();
        setSearchStartDateByOption(7);
    });
    $("#user_period_search_month").click(function(e) {
    	e.preventDefault();
        setSearchStartDateByOption(30);
    });
    $("#user_period_search_year").click(function(e) {
    	e.preventDefault();
        setSearchStartDateByOption(365);
    });
    
	$(".form_datetime").datetimepicker({
        autoclose: true,
        isRTL: App.isRTL(),
        format: "yyyy-mm-dd",
        minView: 2,
        maxView: 3,
        fontAwesome: true,
        initialDate: new Date(),
        pickerPosition: (App.isRTL() ? "bottom-right" : "bottom-left")
    }).on('changeDate', function(ev){        
    });
	
	$('#btnSearch').on('click', function(e){
		e.preventDefault();
		$('#page').val('1');
		$('#schFrm').submit();
	})
});
function brainDonateStatsUpdateForm(idx){
	
	var screenW = screen.availWidth;  
    var screenH = screen.availHeight; 
    var popW = 550; 
    var popH = 450; 
    var posL=( screenW-popW ) / 2;    
    var posT=( screenH-popH ) / 2;    
    var url = "/statistics/brainDonateStatsUpdateForm.p?stats_idx="+idx;	
	window.open(url,'_blank','width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=yes,status=no,titlebar=no');
}
function brainDonateStatsDeleteEnd(idx) {
    if(confirm('정말 삭제하시겠습니까? ')){
    	$.ajax({
            url : "/statistics/brainDonateStatsDeleteEnd.do",
            type: "POST",
            data:{
                stats_idx : idx
            },
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
function brainDonateStatsWriteForm(){
	var screenW = screen.availWidth;  
    var screenH = screen.availHeight; 
    var popW = 550; 
    var popH = 450; 
    var posL=( screenW-popW ) / 2;    
    var posT=( screenH-popH ) / 2;    
    var url = "/statistics/brainDonateStatsWriteForm.p";	
	window.open(url,'_blank','width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=yes,status=no,titlebar=no');
}
</script>