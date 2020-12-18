<%@ page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="ajax" uri="http://ajaxtags.sourceforge.net/tags/ajaxtags"%>
<%@taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader("Expires",0);
%>
<%
/*
	-우체통 관리
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
		<div class="row" style="margin-top: 70px;">
			<div class="portlet-body">
				<input type="hidden" name="page" id="page" value="">
				<div class="post_searchBox">
					<table class="table table-bordered" style="margin-bottom: 0px;">
						<colgroup>
							<col width="20%">
							<col width="80%">
						</colgroup>
						<tbody>
							<tr>
								<th rowspan="3">검색조건</th>
								<td style="text-align:left;">
									<div>
										<select class="post_select" id="gubn" name="gubn">
											<option value=""> 구분 </option>
											<option value="D"> 기증자가족 </option>
											<option value="B"> 수혜자 </option>
										</select>
										
										<select class="post_select" id="sender" name="sender">
											<option value=""> 보내는사람 </option>
											<option value="id"> 아이디 </option>
											<option value="name"> 이름 </option>
											<option value="phone"> 연락처 </option>
										</select>
										<input type="text" class="post_input300" id="senderText" name="senderText"/>
										
										<select class="post_select" id="recip" name="recip">
											<option value=""> 받는사람 </option>
											<option value="id"> 아이디 </option>
											<option value="name"> 이름 </option>
											<option value="phone"> 연락처 </option>
										</select>
										<input type="text" class="post_input300" id="recipText" name="recipText"/>
									</div>
									
								</td>
							</tr>
							<tr>
								<td>
									발송일 
									<input type="text" class="post_inp_style post_input200 form_datetime" size="20" name="startDate" id="startDate" value="">
									~
									<input type="text" class="post_inp_style post_input200 form_datetime" size="20" name="endDate" id="endDate" value="">
								</td>
							</tr>
							<tr>
								<td>
									전송여부
									<select class="post_select" id="sendFlag" name="sendFlag">
										<option value=""> 전체 </option>
										<option value="1"> 전송 </option>
										<option value="2"> 전송불가 </option>
										<option value="3"> 폐기 </option>
									</select>
									
									승인여부
									<select class="post_select" id="apprFlag" name="apprFlag">
										<option value=""> 전체 </option>
										<option value="Y"> 승인 </option>
										<option value="N"> 미승인</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table> 
				</div>
			</div>
			<div class="table-scrollable">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>No</th>
			    			<th>구분</th>					                      
			    			<th>보내는사람</th>					                      					                      					                      				                      					                      
			    			<th>받는사람</th>
			    			<th>제목</th>
			    			<th>발송일</th>
			    			<th>수신일</th>
			    			<th>승인여부</th>
			    			<th>전송여부</th>
			    			<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>1123</td>
							<td>1123</td>
							<td>1123</td>
							<td>1123</td>
							<td>1123</td>
							<td>1123</td>
							<td>1123</td>
							<td>1123</td>
							<td>1123</td>
							<td>1123</td>
						</tr>
					</tbody>
				</table>
				<input type="hidden" name="page" id="page" value="${param.page}"/>
			</div>
			<!-- END SAMPLE TABLE PORTLET-->
			<nav aria-label="Page navigation" style="margin-top: 50px; text-align: center;">
				<ul class="pagination my_pagetion">
					<c:if test="${not empty paginationInfo}"> 
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="page.fnInit"/>
					</c:if>
				</ul>
			</nav> 
		</div>
	</div>
	<!-- END CONTENT BODY -->
</div>
  
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery_redirect/jquery.redirect.js" type="text/javascript"></script>
 
<script type="text/javascript">
$(document).ready(function(){
	fnObj.fnDatePicker();
});

Date.prototype.addDays = function (n) {
    var time = this.getTime();
    var changedDate = new Date(time + (n * 24 * 60 * 60 * 1000));
    this.setTime(changedDate.getTime());
    return this;
};

var fnObj = {
	fnDatePicker:function() {
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
	}
		
}
</script>