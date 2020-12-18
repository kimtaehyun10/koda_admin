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
<%
/*
	-관리자활동내역
	1.활동내용 추가사항 : 등록,수정,삭제,조회시 해당하는 주체 표시 
	ex)[생명나눔우체통] '홍길동' 회원정보 수정
*/
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
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/common/global/plugins/amcharts/amcharts/plugins/export/export.css" rel="stylesheet" type="text/css" media="all"/>
<!-- END HEAD -->
<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">
<c:import url="/webMenu.do" charEncoding="UTF-8"></c:import>

<!-- BEGIN CONTENT -->
  <div class="page-content-wrapper">
      <!-- BEGIN CONTENT BODY -->
      <div class="page-content">
          <!-- BEGIN PAGE HEADER-->                    
          <!-- END PAGE HEADER-->
          <div class="row" style="margin-top: 70px;">
              <div class="col-md-11" style="float: none; margin: 0 auto;">
                  <!-- BEGIN SAMPLE TABLE PORTLET-->
                  <div class="portlet light portlet-fit bordered">
                      <div class="portlet-title">
                          <div class="caption">
                              <span class="caption-subject font-dark bold uppercase">관리자 활동 내역</span>
                          </div>
                          <div class="actions">
                              <div class="btn-group">                                  
                              </div>
                          </div>    
                      </div>
                      <div class="portlet-body">
                      	<form name="schFrm" id="schFrm" method="post" action="<c:url value="/admin/adminActHistList.do"/>">
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
                      			<th>아이디 검색</th>
                      			<td style="text-align:left;"><input type="text" size=20" name="admin_id" id="admn_id" value="${param.admin_id}"/></td>
                      			<th>활동별 검색</th>
                      			<td style="text-align:left;">
                      				<select name="act_type" id="act_type" style="width:200px;">
                      					<option value="">전체</option>
                      					<option value="R"<c:if test="${param.act_type == 'R'}"> selected</c:if>>열람</option>
                      					<option value="C"<c:if test="${param.act_type == 'C'}"> selected</c:if>>등록</option>                      					
                      					<option value="U"<c:if test="${param.act_type == 'U'}"> selected</c:if>>수정</option>
                      					<option value="D"<c:if test="${param.act_type == 'D'}"> selected</c:if>>삭제</option>                      					
                      				</select>
                      			</td>
                      			
                      			<td rowspan="2">
                      				<div class="btn-group">
                                  		<a id="btnSearch" class="btn dark btn-outline btn-circle btn-sm" href="#">검색</a>
                             		</div>
                      			</td>
                      		</tr>
                      		<tr>                      			
                      			<th>검색기간</th>
                      			<td style="text-align:left;" colspan="3">
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
                      		</tr>
                      	</table>   
                      	</form>                   	
                      </div>
                      <div class="portlet-body">
                          <div class="table-scrollable">
                              <table class="table table-striped table-bordered table-hover table-checkable order-column table-clickable">
                              		<colgroup>
                              			<col width="150px"/>
                              			<col width="130px"/>
                              			<col width="150px"/>
                              			<col width="400px"/>
                              			<col width="130px"/>
                              			<col width=""/>
                              			<col width="80px;"/>
                              		</colgroup>
                                  <thead>
                                      <tr>
                                          <th>접속일시</th>
                                          <th>접속IP</th>
                                          <th>관리자명(아이디)</th>
                                          <th>접속페이지</th>
                                          <th>정보주체</th>
                                          <th>활동내용</th>
                                          <th>구분</th>
                                      </tr>
                                  </thead>
                                  <tbody>
									<c:forEach var="data" items="${dataList}" varStatus="status">  
										<c:set var="act_type_nm" value="열람"/>
										<c:choose>
											<c:when test="${data.act_type == 'C'}">
												<c:set var="act_type_nm" value="등록"/>
											</c:when>
											<c:when test="${data.act_type == 'U'}">
												<c:set var="act_type_nm" value="수정"/>
											</c:when>
											<c:when test="${data.act_type == 'D'}">
												<c:set var="act_type_nm" value="삭제"/>
											</c:when>
										</c:choose>               
                                      <tr>
                                          <td>${data.act_time}</td>
                                          <td>${data.act_ip}</td>
                                          <td>${data.admin_nick_name}(${data.admin_id})</td>
                                          <td style="text-align:left;">${data.act_url}</td>
                                          <td>${data.act_subject}</td>
                                          <td style="text-align:left;">${data.act_detail}</td>
                                          <td>${act_type_nm}</td>
                                      </tr>
                                      </c:forEach>
                                      <c:if test="${fn:length(dataList) < 1}">
                                      <tr>
                                      	<td colspan="6">활동내역이 없습니다.</td>
                                      </tr>
									  </c:if>
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
                  <!-- <li class="page_prev" style="display: none;"><a href="javascript:showUserListAjax(1)" aria-label="Previous"><span aria-hidden="true">«</span></a></li><li class="active"><a href="javascript:showUserListAjax(1)">1</a></li><li><a href="javascript:showUserListAjax(2)">2</a></li><li><a href="javascript:showUserListAjax(3)">3</a></li><li class="page_next"><a href="javascript:showUserListAjax(3)" aria-label="Next"><span aria-hidden="true">»</span></a></li> -->
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
Date.prototype.addDays = function (n) {
    var time = this.getTime();
    var changedDate = new Date(time + (n * 24 * 60 * 60 * 1000));
    this.setTime(changedDate.getTime());
    return this;
};
function setSearchStartDateByOption(period) {	
	if($("#search_end_date").val() == '') initValue();
    var search_end_date = $("#search_end_date").val();        
    var date_arr = search_end_date.split('.');
    var search_end_date_obj = new Date(date_arr[0], date_arr[1]-1, date_arr[2]);
    var search_start_date_obj = search_end_date_obj;
    var search_start_date_string = "";
    if(period == 30) {
        search_start_date_string = search_start_date_obj.getFullYear() + "." + ((search_start_date_obj.getMonth()+1) < 10 ? "0"+(search_start_date_obj.getMonth()+1) : (search_start_date_obj.getMonth()+1)) + "." + "01";
    } else if(period == 365){
        search_start_date_string = search_start_date_obj.getFullYear() + "." + "01" + "." + "01";
    } else {
        search_start_date_obj = search_start_date_obj.addDays(-period);
        search_start_date_string = search_start_date_obj.getFullYear() + "." + ((search_start_date_obj.getMonth()+1) < 10 ? "0"+(search_start_date_obj.getMonth()+1) : (search_start_date_obj.getMonth()+1)) + "."
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
    var today_string = today.getFullYear() + "." + ((today.getMonth()+1 < 10) ? "0"+(today.getMonth()+1) : (today.getMonth()+1)) + "." 
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
        format: "yyyy.mm.dd",
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
</script>  