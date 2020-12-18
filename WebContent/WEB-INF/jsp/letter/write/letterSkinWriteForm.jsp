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
                <h1 class="page-title">스킨 등록</h1>                
            </div>
        </div>
        <!-- END PAGE TITLE-->
        <!-- END PAGE HEADER-->
        <div class="row">
            <div class="col-md-12">
                <div class="portlet box blue-hoki ">
                    <div class="portlet-title">
                        <div class="caption">스킨 정보</div>
                    </div>
                    <div class="portlet-body">
                    	<form name="fileFrm" id="fileFrm" role="form" class="form-horizontal" enctype="multipart/form-data" action="<c:url value='/mailbox/letterSkinSave.do'/>" method="post">
                    	<div class="row">
                            <div class="col-md-12">
                            	<div class="form-group">
                                    <label class="col-md-1 control-label">스킨명</label>
                                    <div class="col-md-11">
                                    	<input type="text" id="letter_skin_name" name="letter_skin_name" class="form-control input-sm" placeholder="" value=""/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-1 control-label"></label>
                                    <div class="col-md-11">
                                    	<b>※ 내용에는 반드시 {내용} 이라는 말이 들어가야 스킨이 적용됩니다.</b> 
                                    </div>
                                </div>
                               	<div class="form-group">
                                    <label class="col-md-1 control-label">스킨 내용</label>
                                    <div class="col-md-11">
                                    	<textarea class="ckeditor" id="letter_content" name="letter_content"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">작은 이미지</label>
                                    <div class="col-md-5">                                        
										<input type="file" id="letter_skin_file_org_nm" name="letter_skin_file_org_nm" size="34"/>
                                    </div>                                                                                                          
                                </div>
                            </div>
	                    	<div class="col-md-12 text-center">
	                        	<input type="button" class="btn green" onclick="javascript:fnSubmit();" value="저장" />
	                        	<input type="button" class="btn green" onClick="javascript:fnList();" value="목록으로" />
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
    CKEDITOR.replace('letter_content', {filebrowserUploadUrl:'/admin/ckeditorUpload.do',height:300});
});

function fnList() {
	location.href='<c:url value="/mailbox/letterSkinList.do"/>';
}

function fnSubmit() {
	if($('#letter_skin_name').val().trim() === '') {
		alert('스킨명을 입력하여 주시기 바랍니다.');
		return;
	}
	
	var skinContent = CKEDITOR.instances.letter_content.getData().trim();
	if(skinContent === '') {
		alert('편지지 스킨 내용을 입력하여 주시기 바랍니다.');
		return;
	}
	
	if(!skinContent.includes('{내용}')) {
		alert('스킨 내용 중에 {내용} 이 존재하지 않습니다.');
		return;
	}
	
	var cnt = (skinContent.match(/{내용}/g) || []).length;
	if(cnt !== 1) {
		alert('스킨 내용 중에 {내용} 이 2개 이상 입력되어 있습니다.');
		return;
	}
	
	$.ajax({
        url : '<c:url value="/mailbox/ajaxDuplicateSkinName.do"/>',
        type: "POST",
        data: {letter_skin_name : $('#letter_skin_name').val().trim()},
        dataType:"json", 
        success : function(data, textStatus, jqXHR) {
       		if(data.rtnCode === '-1') {
       			alert(data.rtnMsg);
       			return;
       		}
       		document.fileFrm.submit();       		
        },
        error : function(jqXHR, textStatus, errorThrown){
         	
        }
    }); 
}
</script>