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
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/common/global/plugins/amcharts/amcharts/plugins/export/export.css" rel="stylesheet" type="text/css" media="all"/>
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
                              <span class="caption-subject font-dark bold uppercase">자유게시판</span>
                              </div>
                              <div class="actions">
                              <div class="btn-group">
                                  <a class="btn dark btn-outline btn-circle btn-sm" href="/notification/freeWriteForm.do">자유게시판 등록</a>                                  
                              </div>
                          </div>    
                      </div>
                      <div class="portlet-body">
                      	<form name="schFrm" id="schFrm" method="post" action="<c:url value="/notification/free.do"/>">
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
                      			<th>검색어</th>
                      			<td style="text-align:left;"><input type="text" size=20" name="search_keyword" id="search_keyword" value="${param.search_keyword}"/></td>
                      			<th>구분</th>
                      			<td style="text-align:left;">
                      				<select name="search_gubun" id="search_gubun" style="width:200px;">
                      					<option value="">전체</option>
                      					<option value="T" ${param.search_gubun=='T'?'selected':''}>제목</option>
                      					<option value="W" ${param.search_gubun=='W'?'selected':''}>작성자</option>                      					                      					                     					
                      				</select>
                      			</td>
                      			
                      			<td rowspan="2">
                      				<div class="btn-group">
                                  		<a id="btnSearch" class="btn dark btn-outline btn-circle btn-sm" href="#">검색</a>
                             		</div>
                      			</td>
                      		</tr>
                      		<tr>                      			
                      			<th>기증일</th>
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
                      <form name="Frm" id="Frm" method="post" action="">
                      <input type="hidden" name="story_idx" id="story_idx" value="">
                      <input type="hidden" name="search_keyword" id="search_keyword" value="${param.search_keyword}">                                            
                      <input type="hidden" name="search_gubun" id="search_gubun" value="${param.search_gubun}">                                            
                      <input type="hidden" name="search_end_date" id="search_end_date" value="${param.search_end_date}">                                            
                      <input type="hidden" name="search_start_date" id="search_start_date" value="${param.search_start_date}">                                            
                      <input type="hidden" name="page" id="page" value="${param.page}">                      
                      <div class="portlet-body">
                          <div class="table-scrollable">
                              <table class="table table-hover">
                                  <thead>
                                      <tr>
                                      	  <th>No</th>
					                      <th>제목</th>					                      
					                      <th>작성자</th>					                      					                      					                      
					                      <th>등록일</th>					                      
					                      <th>조회수</th>					                      
					                      <th>관리</th>
					                  </tr>
					                  
                                  </thead>
                                  <tbody>
									<c:forEach var="letterStoryList" items="${letterStoryList_list}" varStatus="status">                                      
                                      <tr>
                                      	  <td>${(total_count - status.index) - ( (currentPage - 1)  *  displayNum ) }</td>                    	                                                                                 
                                          <td style="line-height:60px; text-align: left;">${letterStoryList.story_title} <font style="color: red;">(${letterStoryList.comment_num})</font> </td>                                                                                   
                                          <td style="line-height:60px">${letterStoryList.story_writer}</td>
                                          <td style="line-height:60px"><fmt:formatDate value="${letterStoryList.story_regdate}" pattern="yyyy-MM-dd" /></td>                                        
                                          <td style="line-height:60px">${letterStoryList.story_hits}</td>                                                                               
                                          <td style="line-height:60px">
                                          <a style="line-height:60px" onclick="freeUpdateForm(${letterStoryList.story_idx});"><button class="btn btn-default btn-circle mt-sweetalert" type="button"><i class="fa fa-paste"></i> 수정</button></a>
                                          <a style="line-height:60px" onclick="freeDeleteEnd(${letterStoryList.story_idx},'${letterStoryList.story_gubun}');"><button class="btn btn-danger btn-circle mt-sweetalert" type="button"><i class="fa fa-times"></i> 삭제</button></a>
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
function freeUpdateForm(idx){
	$("#story_idx").val(idx);
	$('#Frm').attr("action","/notification/freeUpdateForm.do");
	$('#Frm').submit();
}
function freeDeleteEnd(idx,gubun) {
    if(confirm('정말 삭제하시겠습니까? ')){
    	$.ajax({
            url : "/remembrance/letterStoryDeleteEnd.do",
            type: "POST",
            data:{
            	story_idx : idx,
            	story_gubun : gubun
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
</script>