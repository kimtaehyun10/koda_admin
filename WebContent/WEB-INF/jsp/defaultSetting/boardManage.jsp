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
              <div class="col-md-12">
                  <!-- BEGIN SAMPLE TABLE PORTLET-->
                  <div class="portlet light portlet-fit bordered">
                      <div class="portlet-title">
                          <div class="caption">
                              <span class="caption-subject font-dark bold uppercase">게시판 관리</span>
                              </div>
                              <div class="actions">
                              
                          </div>    
                      </div>
                      <div class="portlet-body">
                      	<form name="schFrm" id="schFrm" method="post" action="<c:url value="/defaultSetting/boardManage.do"/>">
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
                      			<th>이름</th>
                      			<td style="text-align:left;"><input type="text" size=20" name="search_keyword" id="search_keyword" value="${param.search_keyword}"/></td>
                      			<th>유형</th>
                      			<td style="text-align:left;">
                      				<select name="search_gubun" id="search_gubun" style="width:200px;">
                      					<option value="">전체</option>
                      					<option value="5" ${param.search_gubun=='5'?'selected':''}>국민소통 게시판</option>
                      					<option value="6" ${param.search_gubun=='6'?'selected':''}>정보공개 게시판</option>                      					                      					                     					
                      					<option value="7" ${param.search_gubun=='7'?'selected':''}>추모공간</option>                      					                      					                     					
                      				</select>
                      			</td>
                      			
                      			<td rowspan="2">
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
                                      	  <th>No</th>
					                      <th>이름</th>
					                      <th>첨부파일 수</th>
					                      <th>유형</th>					                      
					                      <th>덧글</th>					                      					                      					                      
					                      <th>관리</th>
					                  </tr>
					                  
                                  </thead>
                                  <tbody>
									<c:forEach var="boardManageList" items="${boardManageList_list}" varStatus="status">                                      
                                      <tr>
                                      	  <td>${(total_count - status.index) - ( (currentPage - 1)  *  displayNum ) }</td>                    	                                                                                 
                                          <td style="line-height:60px">${boardManageList.brd_nm}</td>
                                          <td style="line-height:60px">${boardManageList.brd_file_cnt}</td>                                          
                                          <td style="line-height:60px">
                                          	<c:if test="${boardManageList.brd_type=='5'}">
                                          		국민소통 게시판
                                          	</c:if>
                                          	<c:if test="${boardManageList.brd_type=='6'}">
                                          		정보공개 게시판
                                          	</c:if>
                                          	<c:if test="${boardManageList.brd_type=='7'}">
                                          		추모공간
                                          	</c:if>
                                          </td>
                                          <td style="line-height:60px">${boardManageList.brd_comment_yn == 'Y'?'허용함':'허용안함'}</td>                                                                                                                         
                                          <td style="line-height:60px">
                                          <a style="line-height:60px" onclick="boardManageCommentYes(${boardManageList.brd_no});"><button class="btn btn-default btn-circle mt-sweetalert" type="button"><i class="fa fa-paste"></i> 덧글허용</button></a>
                                          <a style="line-height:60px" onclick="boardManageCommentNo(${boardManageList.brd_no});"><button class="btn btn-danger btn-circle mt-sweetalert" type="button"><i class="fa fa-times"></i> 덧글비허용</button></a>
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
function boardManageCommentYes(no){
	if(confirm('덧글 허용 하시겠습니까? ')){
    	$.ajax({
            url : "/defaultSetting/boardManageCommentYN.do",
            type: "POST",
            data:{
            	brd_comment_yn : "Y",
                brd_no : no
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
function boardManageCommentNo(no) {
    if(confirm('덧글 비허용 하시겠습니까? ')){
    	$.ajax({
            url : "/defaultSetting/boardManageCommentYN.do",
            type: "POST",
            data:{
            	brd_comment_yn : "N",
                brd_no : no
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