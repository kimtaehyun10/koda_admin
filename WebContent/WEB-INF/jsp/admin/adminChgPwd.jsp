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
                        	<c:choose>
                        	<c:when test="${adminVO.admin_chg_pwd == 1}">
                            <span class="caption-subject font-dark sbold uppercase">관리자 비밀번호 사용기간 만료안내</span>
                            </c:when>
                            <c:otherwise>
                            <span class="caption-subject font-dark sbold uppercase">관리자 비밀번호 변경안내</span>
                            </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="portlet-body">
                    	<h4>비밀번호 작성규칙</h4>
                    	<p>
                    		비밀번호는 숫자, 영문자, 특수문자 등을 혼합하여 9자리 이상<br/>
                    		동일 단어, 숫자 3회이상 반복 금지
                    	</p>
                    </div>
                    <div class="portlet-body form">
                        <form id="admin_chg_pwd" class="form-horizontal" role="form" method="post" enctype="multipart/form-data" action="<c:url value='/admin/chgPwd.do'/>">                             
                            <div class="form-body">
                                <!--<div class="form-group">
                                    <label class="col-md-3 control-label">Admin Old Password</label>
                                    <div class="col-md-9">
                                        <input type="password" name="admin_password" id="admin_password" class="form-control" placeholder="Enter Old Password">
                                        
                                    </div>
                                </div>-->

                                <div class="form-group">
                                    <label class="col-md-2 control-label">새 비밀번호</label>
                                    <div class="col-md-9">
                                        <input type="password" name="admin_new_pwd" id="admin_new_pwd" class="form-control" placeholder="Enter New Password">
                                     
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="col-md-2 control-label">비밀번호 확인</label>
                                    <div class="col-md-9">
                                        <input type="password" name="confirm_admin_new_pwd" id="confirm_admin_new_pwd" class="form-control" placeholder="Enter Confirm New Password">
                                        
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
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>