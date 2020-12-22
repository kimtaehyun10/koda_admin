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
        <div class="row">
            <div class="col-md-7">            	
                <h1 class="page-title"> 웹 콘텐츠 등록</h1>                
            </div>
            
        </div>
        <!-- END PAGE TITLE-->
        <!-- END PAGE HEADER-->
        <form name="fileFrm" id="fileFrm" class="form-horizontal">
        <input type="hidden" name="brd_no" value="36">
        <input type="hidden" name="brd_cont_no" value="">
        <input type="hidden" name="type" value="board_insert">
        
        <div class="row">
            <div class="col-md-12">
                <div class="portlet box blue-hoki ">
                    <div class="portlet-title">
                        <div class="caption">웹 콘텐츠 정보</div>
                    </div>
                    <div class="portlet-body">
                        <div class="row">
                            <div class="col-md-12">
                            	<div class="form-group">
                            		<label class="col-md-1 control-label">제목</label>
                                    <div class="col-md-5">
                                        <input id="brd_title" name="brd_title" type="text" class="form-control input-sm" placeholder="" value="">
                                    </div>
                            	</div>                               
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">작성자</label>
                                    <div class="col-md-5">
                                        <input id="brd_mkr_nm" name="brd_mkr_nm" type="text" class="form-control input-sm" placeholder="" value="">
                                    </div>
                                                                                                          
                                </div>
                                
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">메인이미지</label>
                                    <div class="col-md-5">                                        
										<input type="file" id="brd_file_org_nm" name="brd_file_org_nm" size="34"/>
                                    </div>                                                                                                          
                                </div>
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">첨부파일</label>
                                    <div class="col-md-5">                                        
										<input type="file" id="brd_file_org_nm1" name="brd_file_org_nm1" size="34"/>
                                    </div>                                                                                                          
                                </div>
                                </form>
                                <form role="form" name="contentsUpdate" id="contentsUpdate" class="form-horizontal" enctype="multipart/form-data" action="<c:url value='/notification/contentsUpdateEnd.do'/>" method="post">
	                                <div class="form-group">
	                                    <label class="col-md-1 control-label">내용</label>
	                                    <div class="col-md-11">
	                                    	<input type="hidden" name="brd_no" value="36">
        									<input type="hidden" name="brd_cont_no" id="brd_cont_no" value="">
        									<input type="hidden" name="type" value="webContents">	                                                          
	                                    	<textarea class="ckeditor" id="brd_contents" name="brd_contents" ></textarea>
	                                    </div>
	                                </div>
                                </form>
                            </div>
                            <!-- /.col-md-6 -->
                        </div>
                        <!-- /.row -->
                    </div>
                    <div class="col-md-12 text-center">
                        <br>
                        <a id="fileBtn" class="btn green btn-outline btn-circle btn-sm" href="#">등록하기</a>
                        <br>&nbsp
                    </div>
                </div>
            </div>
        </div>
      
    </div>
    <!-- END CONTENT BODY -->
    
</div>
<!-- END CONTENT -->
</div>
<!-- END CONTAINER -->
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery_redirect/jquery.redirect.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/printThis/printThis.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="/common/ckeditor/ckeditor.js"></script>

<script language="JavaScript" type="text/javascript">



$(document).ready(function() {
    //ckeditor
    CKEDITOR.replace('brd_contents',{filebrowserUploadUrl:'/admin/ckeditorUpload.do',height:450});
});

$("#fileBtn").click(function(){
	
    var form = $('#fileFrm')[0];
	
    var data = new FormData(form);
    
    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: "/admin/multiFileUpload.do",
        data: data,
        processData: false,
        contentType: false,
        cache: false,
        timeout: 600000,
        success: function (data) {
        	var reData = data.replace(/"/gi,"");
        	alert(reData.split(",")[0]);    
        	$("#brd_cont_no").val(reData.split(",")[1]);
        	//window.location.reload(true);
        	
        	$("#contentsUpdate").submit();
        },
        error: function (e) {
            
        }
    });
    
	
});


</script>