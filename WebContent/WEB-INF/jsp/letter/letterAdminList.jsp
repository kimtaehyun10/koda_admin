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
        <div class="row" style="margin-top: 70px;">
        	<div class="col-md-12">
            	<!-- BEGIN SAMPLE TABLE PORTLET-->
                <div class="portlet light portlet-fit bordered">
                	<div class="portlet-title">
                    	<div class="caption">
                        	<span class="caption-subject font-dark bold uppercase">관리자 예시관리</span>
                        </div>
                        <div class="actions"></div>
                    </div>    
                </div>
				<div class="portlet-body">
                	<form name="schFrm" id="schFrm" method="post" action="<c:url value="/mailbox/letterAdmin.do"/>">
                		<input type="hidden" name="page" id="page" value="${param.page}"/>
                    </form>                   	
                </div>
                      
                <form name="Frm" id="Frm" method="post" action="">
                	<input type="hidden" id="letter_admin_id" name="letter_admin_id" value="" />
                	<div class="portlet-body">
                        <div class="table-scrollable">
                        	<table class="table table-hover">
                            	<thead>
                                	<tr>
                                    	<th>No</th>
					                    <th>글쓴이</th>					                      
					                    <th>제목</th>
					                    <th>등록일</th>
					                    <th>사용여부</th>
					                    <th>관리</th>
					                </tr>
					            </thead>
                                <tbody>
								<c:forEach var="item" items="${letterAdminList}" varStatus="status">                                      
                                	<tr>
                                    	<td>${(total_count - status.index) - ( (currentPage - 1)  *  displayNum ) }</td>                    	                                                                                 
                                        <td>${item.sender_name}(${item.sender_id })</td>                                                                                   
                                        <td style="text-align: left;">
                                        	<a href="javascript:fnLetterAdminViewForm('${item.letter_admin_id}')">${item.title}</a>
                                        </td>
                                        <td>
                                        	<fmt:formatDate value="${item.create_time }" pattern="yyyy-MM-dd" var="create_time_fmt"/>
                                          	${create_time_fmt}
                                        </td>
                                        <td>
                                        	<c:if test="${item.use_yn eq 'Y'}">사용</c:if>
                                        	<c:if test="${item.use_yn eq 'N'}">미사용</c:if>
                                        </td>
                                        <td>
                                          	<a onclick="fnUpdate('${item.letter_admin_id}');"><button class="btn btn-default btn-circle mt-sweetalert" type="button"><i class="fa fa-paste"></i>수정</button></a>
	                                        <a onclick="fnDelete('${item.letter_admin_id}')"><button class="btn btn-danger btn-circle mt-sweetalert" type="button"><i class="fa fa-times"></i>삭제</button></a>
                                          </td>                                                                                                                                                                
                                    </tr>
                                    
                                </c:forEach>
                                <c:if test="${fn:length(letterAdminList) eq 0 }">
                                	<tr>
                                    	<td colspan="6">등록된 데이터가 없습니다.</td>
                                    </tr>
                                </c:if>
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
                <div class="col-md-12 text-right">
                	<input type="button" class="btn green" name="btnWrite" id="btnWrite" onClick="javascript:fnLetterAdminWriteForm();" value="예시등록">
                </div> 
            </div>
        </div>
    </div>
    <!-- END CONTENT BODY -->
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery_redirect/jquery.redirect.js" type="text/javascript"></script>
  
<script>
function fn_search(pageNo) {		
	$('#page').val(pageNo);
	$('#schFrm').submit();
};

$('#btnSearch').on('click', function(e){
	e.preventDefault();
	$('#page').val('1');
	$('#schFrm').submit();
});

function fnLetterAdminWriteForm() {
	location.href="<c:url value='/mailbox/letterAdminWriteForm.do'/>";
}

function fnLetterAdminViewForm(letter_admin_id) {
	$("#letter_admin_id").val(letter_admin_id);
	$('#Frm').attr("action","/mailbox/letterAdminView.do");
	$('#Frm').submit();
}

function fnUpdate(letter_admin_id) {
	$("#letter_admin_id").val(letter_admin_id);
	$('#Frm').attr("action","/mailbox/letterAdminUpdateForm.do");
	$('#Frm').submit();
}

function fnDelete(letter_admin_id) {
	if(del()){
		$("#letter_admin_id").val(letter_admin_id);
		$('#Frm').attr("action","/mailbox/letterAdminDelete.do");
		$('#Frm').submit();
	}
}
</script>