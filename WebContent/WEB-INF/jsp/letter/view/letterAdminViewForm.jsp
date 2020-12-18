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
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css" />
<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">
<c:import url="/webMenu.do" charEncoding="UTF-8"></c:import>
<!-- BEGIN CONTENT -->
<div id="page_content" class="page-content-wrapper">
    <!-- BEGIN CONTENT BODY -->
    <div class="page-content">    	 
        <!-- BEGIN PAGE TITLE-->
        <div class="row" style="margin-top: 70px;">
            <div class="col-md-7">            	
                <h1 class="page-title">관리자 예시 등록</h1>                
            </div>
        </div>
        <!-- END PAGE TITLE-->
        <!-- END PAGE HEADER-->
        <div class="row">
            <div class="col-md-12">
                <div class="portlet box blue-hoki ">
                    <div class="portlet-title">
                        <div class="caption">관리자 예시 상세보기</div>
                    </div>
                    <div class="portlet-body">
                    	<form name="fileFrm" id="fileFrm" class="form-horizontal" method="post" enctype="multipart/form-data" action="<c:url value='/mailbox/letterAdminUpdate.do'/>">
                    	<input type="hidden" name="letter_admin_id" value="${letterAdmin.letter_admin_id }" />
                    	<div class="row">
                           	<div class="col-md-12">
                           		<div class="form-group">
                           			<label class="col-md-1 control-label">보내는 아이디</label>
                                   	<div class="col-md-11">${letterAdmin.sender_id }</div>
                           		</div>                               
                           		<div class="form-group">
                           			<label class="col-md-1 control-label">보내는 사람</label>
                                   	<div class="col-md-11">${letterAdmin.sender_name }</div>
                           		</div>
                               	<div class="form-group">
                           			<label class="col-md-1 control-label">제목</label>
                                   	<div class="col-md-11">${letterAdmin.title }</div>
                           		</div>
                           	
                           		<div class="form-group">
		                        	<label class="col-md-1 control-label">내용</label>
	                           		<div class="col-md-11">${letterAdmin.content }</div>
                      			</div>
                               
                                <div class="form-group">
                            		<label class="col-md-1 control-label">사용여부</label>
                                    <div class="col-md-11">
                                    	<c:if test="${letterAdmin.use_yn eq 'Y' }">사용</c:if>
                                    	<c:if test="${letterAdmin.use_yn eq 'N' }">미사용</c:if>
                                    </div>
                            	</div>
                           	</div>
                            <div class="col-md-12">
                            	<div class="col-md-3">
                            		<input type="button" class="btn green" onClick="javascript:fnList();" value="목록">
                            	</div>
                            	<div class="col-md-9" style="text-align: right;">
                            		<input type="button" class="btn green" onClick="javascript:fnUpdate('${letterAdmin.letter_admin_id }');" value="수정" />
                            		<input type="button" class="btn green" onClick="javascript:fnDelete('${letterAdmin.letter_admin_id }');" value="삭제" />
                            		<input type="button" class="btn green" onClick="javascript:fnLetterAdminWriteForm();" value="예시등록" />
                            	</div>
							</div>
						</div>
						</form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END CONTENT BODY -->
</div>
<!-- END CONTENT -->
<!-- END CONTAINER -->
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery_redirect/jquery.redirect.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/printThis/printThis.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="/common/ckeditor/ckeditor.js"></script>

<script>
$(document).ready(function() {
    CKEDITOR.replace('content', {filebrowserUploadUrl:'/admin/ckeditorUpload.do',height:200});
});

function fnList() {
	location.href='<c:url value="/mailbox/letterAdmin.do"/>';
}

function fnLetterAdminWriteForm() {
	location.href="<c:url value='/mailbox/letterAdminWriteForm.do'/>";
}

function fnUpdate(letter_admin_id) {
	$("#letter_admin_id").val(letter_admin_id);
	$('#fileFrm').attr("action","/mailbox/letterAdminUpdateForm.do");
	$('#fileFrm').submit();
}

function fnDelete(letter_admin_id) {
	if(del()){
		$("#letter_admin_id").val(letter_admin_id);
		$('#fileFrm').attr("action","/mailbox/letterAdminDelete.do");
		$('#fileFrm').submit();
	}
}
</script>