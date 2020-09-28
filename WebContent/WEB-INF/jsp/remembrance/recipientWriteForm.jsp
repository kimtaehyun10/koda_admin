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
       <form role="form" name="updateForm" id="updateForm" class="form-horizontal" enctype="multipart/form-data" action="<c:url value='/remembrance/letterStoryWriteEnd.do'/>" method="post"> 

        <!-- BEGIN PAGE TITLE-->
        <div class="row">
            <div class="col-md-7">            	
                <h1 class="page-title"> 수혜자 편지 글 등록</h1>                
            </div>
            
        </div>
        <!-- END PAGE TITLE-->
        <!-- END PAGE HEADER-->
        <input type="hidden" name="story_idx" value="">
		<input type="hidden" name="story_gubun" value="recipient">
		        
        <div class="row">
            <div class="col-md-12">
                <div class="portlet box blue-hoki ">
                    <div class="portlet-title">
                        <div class="caption">수혜자 편지 정보</div>
                    </div>
                    <div class="portlet-body">
                        <div class="row">
                            <div class="col-md-12">
                            	<div class="form-group">
                            		<label class="col-md-1 control-label">제목</label>
                                    <div class="col-md-11">
                                        <input id="donate_title" name="story_title" type="text" class="form-control input-sm" placeholder="" value="">  
                                    </div>
                            	</div>                               
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">수혜자</label>
                                    <div class="col-md-2">
                                        <input id="donate_age" name="story_writer" type="text" class="form-control input-sm" placeholder="" value="">
                                    	<label class="mt-checkbox" >익명                                       	                                       	
                                            <input id="story_area" name=story_anonymity type="checkbox" class="input-sm" value="Y" ><span></span>
                                        </label>
                                    </div>
                                    <label class="col-md-1 control-label">비밀번호</label>
                                    <div class="col-md-2">
                                        <input id="donate_age" name="story_password" type="text" class="form-control input-sm" placeholder="" value="">
                                    </div>                                   
                                    <label class="col-md-1 control-label">기증받은 장기</label>
                                    <div class="col-md-2">
                                        <select class="form-control input-sm" name="story_area" id="story_area" style="width:200px;">
	                      					<option value="">전체</option>
	                      					<option value="1" >신장</option>
	                      					<option value="2" >간장</option>
	                      					<option value="3" >췌장</option>
	                      					<option value="4" >심장</option>
	                      					<option value="5" >폐</option>
	                      					<option value="6" >췌도</option>
	                      					<option value="7" >소장</option>
	                      					<option value="8" >대장</option>
	                      					<option value="9" >위장</option>
	                      					<option value="10" >십이지장</option>
	                      					<option value="11" >비장</option>
	                      					<option value="12" >손,팔</option>
	                      					<option value="13" >안구</option>
	                      					<option value="14" >인체조직</option>                     					                    					                      					                     					                   					                      					                      					                     					
	                      				</select>                                 	
                                    </div>                                                                                                        
                                    <label class="col-md-1 control-label">기증받은 년도</label>
                                    <div class="col-md-2">
                                        <input id="year" name="year" type="text" class="form-control input-sm" placeholder="" value="">
                                    </div>                                                                                                          
                                </div>
                                                              
                                <div class="form-group">
                                    <label class="col-md-1 control-label">내용</label>
                                    <div class="col-md-11">
                                        <textarea class=" ckeditor" id="story_contents" name="story_contents" msg="내용을 " ></textarea>
                                    </div>
                                </div>
                                
                            </div>
                            <!-- /.col-md-6 -->
                        </div>
                        <!-- /.row -->
                    </div>
                    <div class="col-md-12 text-center">
                        <br>
                        <button type="submit" class="btn green btn-outline btn-circle btn-sm">등록하기</button>
                        <br>&nbsp
                    </div>
                </div>
            </div>
        </div>
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

    function initDateForm() {
        $(".form_datetime").datetimepicker({
            autoclose: true,
            isRTL: App.isRTL(),
            format: "yyyy-mm-dd",
            minView: 2,
            maxView: 5,
            fontAwesome: true,
            initialDate: new Date(),
            pickerPosition: (App.isRTL() ? "bottom-right" : "bottom-left")
        });
    }
    
    $(document).ready(function() {
        initDateForm();
        
	    //ckeditor
	    CKEDITOR.replace('story_contents',{filebrowserUploadUrl:'/admin/ckeditorUpload.do'});
    });
    
</script>