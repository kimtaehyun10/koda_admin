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
<div id="page_content" class="page-content-wrapper form-horizontal" >
    <!-- BEGIN CONTENT BODY -->
    <div class="page-content">    	
        

        <!-- BEGIN PAGE TITLE-->
        <div class="row" style="margin-top: 70px;">
            <div class="col-md-7">            	
                <h1 class="page-title"> 팝업관리 수정</h1>                
            </div>            
        </div>
        <!-- END PAGE TITLE-->
        <!-- END PAGE HEADER-->		
		        
        <div class="row">
            <div class="col-md-12">
                <div class="portlet box blue-hoki ">
                    <div class="portlet-title">
                        <div class="caption">팝업관리 정보</div>
                    </div>
                    <div class="portlet-body">
                        <div class="row">
                            <div class="col-md-12">
                            	<form role="form" name="updateForm" id="updateForm">
                            	<input type="hidden" name="ecm_seq" value="${selectedPopup.ecm_seq}">
                            	<input type="hidden" id="ecm_contents" name="ecm_contents" value="">
                            	<div class="form-group">
                            		<label class="col-md-1 control-label">컨텐츠명</label>
                                    <div class="col-md-11">
                                        <input id="ecm_nm" name="ecm_nm" type="text" class="form-control input-sm" placeholder="" value="${selectedPopup.ecm_nm}">
                                    </div>
                            	</div>                               
                                <%-- <div class="form-group">                                                                                                                                   
                                    <label class="col-md-1 control-label">팝업가로크기</label>
                                    <div class="col-md-2">
                                        <input id="ecm_width" name="ecm_width" type="text" class="form-control input-sm" placeholder="" value="${selectedPopup.ecm_width}">
                                    </div>
                                    <label class="col-md-1 control-label">팝업세로크기</label>
                                    <div class="col-md-2">
                                        <input id="ecm_height" name="ecm_height" type="text" class="form-control input-sm" placeholder="" value="${selectedPopup.ecm_height}">                                    	
                                    </div>                                   
                                    <label class="col-md-1 control-label">팝업가로위치</label>
                                    <div class="col-md-2">
                                        <input id="ecm_top" name="ecm_top" type="text" class="form-control input-sm" placeholder="" value="${selectedPopup.ecm_top}">
                                    </div>
                                    <label class="col-md-1 control-label">팝업세로위치</label>
                                    <div class="col-md-2">
                                        <input id="ecm_left" name="ecm_left" type="text" class="form-control input-sm" placeholder="" value="${selectedPopup.ecm_left}">                                    	
                                    </div>
                                </div> --%>
                                <div class="form-group">
                                    <label class="col-md-1 control-label">사용여부</label>
                                    <div class="col-md-11">
                                       <label class="mt-checkbox" >사용                                       	                                       	
                                            <input id="use_yn" name="use_yn" type="radio" class="input-sm" value="Y" ${selectedPopup.use_yn=='Y'?'checked':''}><span></span>
                                        </label>
                                        &nbsp;&nbsp;&nbsp;
                                        <label class="mt-checkbox" >미사용                                   	                                       	
                                            <input id="use_yn" name="use_yn" type="radio" class="input-sm" value="N" ${selectedPopup.use_yn=='N'?'checked':''}><span></span>
                                        </label>                                         
                                    </div>
                                </div>
                                </form>             
                                                   
                                <div class="form-group">
                                    <label class="col-md-1 control-label">내용</label>
                                    <div class="col-md-11">
                                        <textarea class=" ckeditor" id="before_ecm_contents" name="before_ecm_contents" msg="내용을 " >${selectedPopup.ecm_contents}</textarea>
                                    </div>
                                </div>
                                
                            </div>
                            <!-- /.col-md-6 -->
                        </div>
                        <!-- /.row -->
                    </div>              
                    
                    <div class="col-md-12 text-center">
                        <br>
                        <input type="button" class="btn green btn-outline btn-circle btn-sm" value="수정하기" onclick="popupUpdateEnd();">
                        <br>&nbsp
                    </div>
                </div>
            </div>
        </div>
        <!-- 검색, 페이징 내용 저장해서 list로 보내기 form -->
        <form id="listForm" method="post" action="<c:url value="/defaultSetting/popup.do"/>">
        	<input type="hidden" name="search_keyword" value="${param.search_keyword}">
        	<input type="hidden" name="search_gubun" value="${param.search_gubun}">
        	<input type="hidden" name="search_end_date" value="${param.search_end_date}">
        	<input type="hidden" name="search_start_date" value="${param.search_start_date}">
        	<input type="hidden" name="page" value="${param.page}">
        </form>    
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
    CKEDITOR.replace('before_ecm_contents',{filebrowserUploadUrl:'/admin/ckeditorUpload.do',height:450});
    
});
    
function popupUpdateEnd(){
    
	var ecm_contents = CKEDITOR.instances['before_ecm_contents'].getData();
	$('#ecm_contents').val(ecm_contents);
   	$.ajax({
           url : "/defaultSetting/popupUpdateEnd.do",
           type: "POST",
           data:$("#updateForm").serialize(),
           dataType:"json", 
           success : function(data, textStatus, jqXHR) {
           	  alert(data);          
           	  $("#listForm").submit();
           }, 
           error : function(jqXHR, textStatus, errorThrown){
            	
           }
       });    	
   }
</script>