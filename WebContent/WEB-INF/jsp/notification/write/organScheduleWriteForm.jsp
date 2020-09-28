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
                <h1 class="page-title"> 기관일정 등록</h1>                
            </div>
            
        </div>
        <!-- END PAGE TITLE-->
        <!-- END PAGE HEADER-->
        <form name="fileFrm" id="fileFrm" class="form-horizontal">
        <input type="hidden" name="sch_no" value="">
        <input type="hidden" name="type" value="sch_insert">
        
        <div class="row">
            <div class="col-md-12">
                <div class="portlet box blue-hoki ">
                    <div class="portlet-title">
                        <div class="caption">기관일정 정보</div>
                    </div>
                    <div class="portlet-body">
                        <div class="row">
                            <div class="col-md-12">
                            	<div class="form-group">
                            		<label class="col-md-1 control-label">제목</label>
                                    <div class="col-md-5">
                                        <input id="sch_title" name="sch_title" type="text" class="form-control input-sm" placeholder="" value="">
                                    </div>
                            	</div>                               
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">시작일</label>
                                    <div class="col-md-3">
                                        <input type="text" size="20" name="sch_start_dt" id="sch_start_dt" class="form-control input-sm form_datetime" value="">
                                    </div>
                                                                                                          
                                </div>
                                
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">종료일</label>
                                    <div class="col-md-3">                                        
										<input type="text" size="20" name="sch_end_dt" id="sch_end_dt" class="form-control input-sm form_datetime" value="">
                                    </div>                                                                                                          
                                </div>
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">첨부파일</label>
                                    <div class="col-md-5">                                        
										<input type="file" id="sch_file_org_name" name="sch_file_org_name" size="34"/>
                                    </div>                                                                                                          
                                </div>
                                <div class="form-group">
                            		<label class="col-md-1 control-label">관련글</label>
                                    <div class="col-md-5">
                                        <input id="sch_link_title" name="sch_link_title" type="text" class="form-control input-sm" placeholder="" value="" readonly>
                                        <input type="hidden" name="sch_link_no" id="sch_link_no" value="">                                 	
                                    </div>                                   
                                    <div class="col-md-1">                                      
                                        <input type="button" onclick="organEventPopup();" class="btn gray btn-circle hidden-print" value="검색">                                 	
                                    </div>
                            	</div> 
                                
                                </form>
                                <form role="form" name="contentsUpdate" id="contentsUpdate" class="form-horizontal" enctype="multipart/form-data" action="<c:url value='/notification/scheduleContentsUpdateEnd.do'/>" method="post">
	                                <div class="form-group">
	                                    <label class="col-md-1 control-label">내용</label>
	                                    <div class="col-md-11">
	                                    	<input type="hidden" id="sch_no" name="sch_no" value="">        									        										                                                          
	                                    	<textarea class="ckeditor" id="sch_contents" name="sch_contents" ></textarea>
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
    CKEDITOR.replace('sch_contents',{filebrowserUploadUrl:'/admin/ckeditorUpload.do',height:450});
    
    //날짜
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
});

$("#fileBtn").click(function(){
	
var form = $('#fileFrm')[0];
	
var data = new FormData(form);

$.ajax({
    type: "POST",
    enctype: 'multipart/form-data',
    url: "/notification/organScheduleUpdateEnd.do",
    data: data,
    processData: false,
    contentType: false,
    cache: false,
    timeout: 600000,
    success: function (data) {
    	var reData = data.replace(/"/gi,"");
    	alert(reData.split(",")[0]);
    	$("#sch_no").val(reData.split(",")[1]);
    	//window.location.reload(true);
    	
    	$("#contentsUpdate").submit();
    },
    error: function (e) {
        
    }
});
    
	
});

//관련글 찾기 popup
function organEventPopup(){
    
	var screenW = screen.availWidth;  
	    var screenH = screen.availHeight; 
	    var popW = 800; 
	    var popH = 500; 
	    var posL=( screenW-popW ) / 2;    
	    var posT=( screenH-popH ) / 2;    
	    var url = "/notification/organEventPopup.p";	
	window.open(url,'_blank','width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=yes,status=no,titlebar=no');

}
</script>