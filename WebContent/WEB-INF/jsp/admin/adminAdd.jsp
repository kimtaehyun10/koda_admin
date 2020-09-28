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
            <!-- END PAGE HEADER-->
            <div class="row" style="margin-top: 70px;">
                <div class="col-md-1"></div>
                <div class="col-md-10 ">
                    <!-- BEGIN SAMPLE FORM PORTLET-->
                    <div class="portlet light bordered">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject font-dark sbold uppercase">새 관리자 추가</span>
                            </div>
                        </div>
                        <div class="portlet-body form">
                            <form id="admin_form" class="form-horizontal" role="form" method="post" enctype="multipart/form-data" action="<c:url value='/admin/insert.do'/>">
                                <div class="form-body">
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">아이디</label>
                                        <div class="col-md-9">
                                            <input type="text" name="admin_id" id="admin_id" class="form-control" placeholder="" value="">
                                            <span id="check_admin" class="help-block"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">이름</label>
                                        <div class="col-md-9">
                                            <input type="text" name="admin_nick_name" id="admin_nick_name" class="form-control" placeholder="" value="">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">비밀번호</label>
                                        <div class="col-md-9">
                                            <input type="password" name="admin_pwd" id="admin_pwd" class="form-control" placeholder="" value="">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-md-2 control-label">등급</label>
                                        <div class="col-md-9">
                                            <select class="form-control" name="admin_grade" id="admin_grade">
		<c:if test="${admin_grade == 0}">
                                                <option value="0" data-type="">일반관리자</option>
		</c:if>
		<c:if test="${admin_grade == 1}">
			<option value="0" data-type="">일반관리자</option>
                                                <option value="1" data-type="">고급관리자</option>
		</c:if>
		<c:if test="${admin_grade == 2 || admin_grade == -1}">
			<option value="0" data-type="">일반관리자</option>
			<option value="1" data-type="">고급관리자</option>
			<option value="2" data-type="">마스터관리자</option>
		</c:if>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">휴대폰번호</label>
                                        <div class="col-md-9">
                                            <input type="tel" name="admin_phone" id="admin_phone" class="form-control" placeholder="" value="">
                                        </div>
                                    </div>
                                </div>   
                                <div class="form-actions">
                                    <div class="row">
                                        <div class="col-md-offset-5 col-md-9">
                                            <input type="submit" class="btn green" type="submit" name="submit" id="submit" value="저장">
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- END SAMPLE FORM PORTLET-->   
                </div>
            </div>  
        </div>
        <!-- END CONTENT BODY -->
    </div>
    <!-- END CONTENT -->
<!-- END CONTAINER -->
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
<!-- BEGIN CORE PLUGINS -->       
<script src="${pageContext.request.contextPath}/common/jquery.validate.js"></script>
<script src="${pageContext.request.contextPath}/common/validate.js"></script>
<script>
$(document).ready(function () { 
    $("#admin_id").blur(function() {    	
	    var admin_id = $("#admin_id").val();
	    if(admin_id == '') return;
	    
	    $.ajax({
	        url: "<c:url value='/admin/ajaxCheckAdminId.do'/>",
	        type: "POST",
	        async:false ,
	        dataType: "json",
	        data: {
	               admin_id:admin_id
	        },
	        success: function(data) {            	
                if(data != null && data.rtnCode != "") {	                
                	$("#check_admin").html(data.rtnMsg);
            	}
            },
            error: function(xhr, desc, err) {
                alert('아이디 중복체크 중 오류가 발생하였습니다. 잠시 후 다시 시도해주시기 바랍니다.')
            }
	    });            
    });
});
</script>