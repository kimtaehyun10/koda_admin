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
	<style type="text/css">
		.list-group-item{float: left;}
	</style>
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
       <form role="form" name="updateForm" id="updateForm" class="form-horizontal"> 
        
        <!-- BEGIN PAGE TITLE-->
        <div class="row" style="margin-top: 70px;">
            <div class="col-md-7">            	
                <h1 class="page-title"> 기증자 추모관 수정</h1>                
            </div>
            
        </div>
        <!-- END PAGE TITLE-->
        <!-- END PAGE HEADER-->
        <input type="hidden" name="donate_idx" value="${selectedMember.donate_idx}">
        <input type="hidden" id="donate_contents" name="donate_contents" value="">
        <div class="row">
            <div class="col-md-12">
                <div class="portlet box blue-hoki ">
                    <div class="portlet-title">
                        <div class="caption">기증자 추모관 정보</div>
                    </div>
                    <div class="portlet-body">
                        <div class="row">
                            <div class="col-md-12">
                            	<div class="form-group">
                            		<label class="col-md-1 control-label">제목</label>
                                    <div class="col-md-11">
                                        <input id="donate_title" name="donate_title" type="text" class="form-control input-sm" placeholder="" value="${selectedMember.donate_title}">
                                    </div>
                            	</div>                               
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">기증일</label>
                                    <div class="col-md-2">
                                        <input id="donate_date" name="donate_date" type="text" size="10" id="" class="input-sm form_datetime form-control" value="${fn:substring(selectedMember.donate_date,0,10)}">                                        
                                    </div>
                                    <label class="col-md-1 control-label">기증자명</label>
                                    <div class="col-md-2">
                                        <input id="donate_name" name="donate_name" type="text" class="form-control input-sm" placeholder="" value="${selectedMember.donate_name}">
                                    	<label class="mt-checkbox" >익명                                       	                                       	
                                            <input id="donate_anonymity" name=donate_anonymity type="checkbox" class="input-sm" value="Y" ${selectedMember.donate_anonymity=='Y'?'checked':''}><span></span>
                                        </label>
                                    </div>                                    
                                    <label class="col-md-1 control-label">나이</label>
                                    <div class="col-md-2">
                                        <input id="donate_age" name="donate_age" type="text" class="form-control input-sm" placeholder="" value="${selectedMember.donate_age}">
                                    </div>
                                    <label class="col-md-1 control-label">작성자</label>
                                    <div class="col-md-2">
                                        <input id="donate_writer" name="donate_writer" type="text" class="form-control input-sm" placeholder="" value="${selectedMember.donate_writer}">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-1 control-label">성별</label>
                                    <div class="col-md-11">
                                       <label class="mt-checkbox" >남                                       	                                       	
                                            <input id="donate_gender" name="donate_gender" type="radio" class="input-sm" value="M" ${selectedMember.donate_gender=='M'?'checked':''}><span></span>
                                        </label>
                                        &nbsp;&nbsp;&nbsp;
                                        <label class="mt-checkbox" >여                                      	                                       	
                                            <input id="donate_gender" name="donate_gender" type="radio" class="input-sm" value="F" ${selectedMember.donate_gender=='F'?'checked':''}><span></span>
                                        </label> 
                                    </div>
                                </div>
                                </form>
                                <div class="form-group">
                                    <label class="col-md-1 control-label">내용</label>
                                    <div class="col-md-11">
                                        <textarea class=" ckeditor" id="before_donate_contents" name="before_donate_contents" >${selectedMember.donate_contents}</textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                	<label class="col-md-1 control-label"></label>
                                	<div class="col-md-11">
	                                	<ul class="list-group list-group-horizontal-sm">
										    <li class="list-group-item col-md-3" >헌화(${selectedMember.donate_flower})</li>
										    <li class="list-group-item col-md-3" >사랑해요(${selectedMember.donate_love})</li>
										    <li class="list-group-item col-md-3" >보고싶어요(${selectedMember.donate_see})</li>
										    <li class="list-group-item col-md-3" >그리워요(${selectedMember.donate_pine})</li>
										    <li class="list-group-item col-md-4" >자랑스러워요(${selectedMember.donate_proud})</li>
										    <li class="list-group-item col-md-4" >힘들어요(${selectedMember.donate_hard})</li>
										    <li class="list-group-item col-md-4" >슬퍼요(${selectedMember.donate_sad})</li>
										</ul>
									</div>
                                </div>
                                                                							                                
                            </div>
                            <!-- /.col-md-6 -->
                        </div>
                        <!-- /.row -->
                    </div>
                    <div class="col-md-12 text-center">
                        <br>                                                
                        <input type="button" class="btn green btn-outline btn-circle btn-sm" value="수정하기" onclick="memberUpdateEnd();">
                        <br>&nbsp
                    </div>
                </div>
            </div>
        </div>
      
      <!-- 검색, 페이징 내용 저장해서 list로 보내기 form -->
      <form id="listForm" method="post" action="<c:url value="/remembrance/member.do"/>">
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

	var oEditors = [];

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
	    CKEDITOR.replace('before_donate_contents',{filebrowserUploadUrl:'/admin/ckeditorUpload.do',height:450});
          
    });
    
    function memberUpdateEnd(){
        
   	var donate_contents = CKEDITOR.instances['before_donate_contents'].getData();
   	$('#donate_contents').val(donate_contents);
      	$.ajax({
              url : "/remembrance/memberUpdateEnd.do",
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