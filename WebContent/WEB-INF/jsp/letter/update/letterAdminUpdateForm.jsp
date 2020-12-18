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
                        <div class="caption">관리자 예시 등록(수정)</div>
                    </div>
                    <div class="portlet-body">
                    	<form name="fileFrm" id="fileFrm" class="form-horizontal" method="post" enctype="multipart/form-data" action="<c:url value='/mailbox/letterAdminUpdate.do'/>">
                    	<input type="hidden" name="letter_admin_id" value="${letterAdmin.letter_admin_id }" />
				        <div class="row">
                           	<div class="col-md-12">
                           		<div class="form-group">
                           			<label class="col-md-1 control-label">보내는 아이디</label>
                                   	<div class="col-md-11">
                                    	<input id="sender_id" name="sender_id" type="text" class="form-control input-sm" placeholder="" value="${letterAdmin.sender_id }" readonly="readonly">
                                    </div>
                           		</div>                               
                           		<div class="form-group">
                           			<label class="col-md-1 control-label">보내는 사람</label>
                                   	<div class="col-md-11">
                                    	<input id="sender_name" name="sender_name" type="text" class="form-control input-sm" placeholder="" value="${letterAdmin.sender_name }" readonly="readonly">
                                    </div>
                           		</div>
                               	<div class="form-group">
                           			<label class="col-md-1 control-label">제목</label>
                                   	<div class="col-md-11">
                                       	<input id="title" name="title" type="text" class="form-control input-sm" placeholder="" value="${letterAdmin.title }">
                                   	</div>
                           		</div>
                           	
                           		<div class="form-group">
		                        	<label class="col-md-1 control-label">내용</label>
	                           		<div class="col-md-11">
			                        	<textarea class="ckeditor" id="content" name="content" >${letterAdmin.content }</textarea>
                          			</div>
                      			</div>
                               
                                <div class="form-group">
                            		<label class="col-md-1 control-label">사용여부</label>
                                    <div class="col-md-11">
                                       	<label class="mt-checkbox">사용<input name="use_yn" type="radio" class="input-sm" value="Y" <c:if test="${letterAdmin.use_yn eq 'Y' }"> checked</c:if>><span></span></label>
                                        &nbsp;&nbsp;&nbsp;
                                        <label class="mt-checkbox">미사용<input name="use_yn" type="radio" class="input-sm" value="N" <c:if test="${letterAdmin.use_yn eq 'N' }"> checked</c:if>><span></span></label>
                                    </div>
                            	</div>
                           	</div>
                            <div class="col-md-offset-5 col-md-7">
								<input type="button" class="btn green" onClick="javascript:fnSubmit();" value="수정" />
								<input type="button" class="btn green" onClick="javascript:fnList();" value="목록">
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

function fnSubmit() {
	if($('#sender_id').val() === '' || $('#sender_name').val() === '') {
		alert('보내는 사람을 선택하여 주시기 바랍니다.');
		return;
	}
	
	if($('#title').val() === '') {
		alert('제목을 입력하여 주시기 바랍니다.');
		return;
	}
	
	if(CKEDITOR.instances.content.getData() === '') {
		alert('내용을 입력하여 주시기 바랍니다.');
		return;
	}
	
	document.fileFrm.submit();
}

</script>