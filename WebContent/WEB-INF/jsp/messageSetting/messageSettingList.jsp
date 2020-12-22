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

<%
/*
	-자동문자발송
	1. 기능테스트 후 코드 수정해야함
*/
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
        <!-- BEGIN PAGE HEADER-->

        <!-- END PAGE HEADER-->
        <div class="row">
            <div class="col-md-12">
                <!-- BEGIN SAMPLE TABLE PORTLET-->
                <div class="portlet light portlet-fit bordered">
                    <div class="portlet-title">
                        <div class="caption">
                            <span class="caption-subject font-dark bold uppercase">자동 문자발송 설정</span>
                        </div>
                        <div class="actions">
                            <div class="btn-group">
                                <a class="btn dark btn-outline btn-circle btn-sm" href="<c:url value='/messageSetting/showCreate.do'/>">Create New Setting</a>
                            </div>
                        </div>
                    </div>

                    <div class="portlet-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Code</th>
                                        <th>SMS Send Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="message" items="${message_list}" varStatus="status">                                    
                                    <tr>
                                        <td style="line-height:60px">${message.message_setting_name}</td>
                                        <td style="line-height:60px">${message.message_setting_code}</td>
                                        <td style="line-height:60px">${message.sms_send_state}</td>
                                        <td class="center">
                                            <a style="line-height:60px" href="<c:url value='/messageSetting/showDetail.do'/>?message_setting_index=${message.message_setting_index}"><button class="btn btn-default btn-circle mt-sweetalert" type="button"><i class="fa fa-paste"></i> EDIT</button></a>
                                            <a style="line-height:60px" href="<c:url value='/messageSetting/remove.do'/>?message_setting_index=${message.message_setting_index}" onclick="return warning_delete();"><button class="btn btn-danger btn-circle mt-sweetalert" type="button"><i class="fa fa-times"></i> DELETE</button></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- END SAMPLE TABLE PORTLET-->
            </div>
        </div>
    </div>
    <!-- END CONTENT BODY -->
</div>
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
<script type="text/javascript">
    function warning_delete() {
        if(confirm('Are you sure to delete this? ')){
            return true;
        } else {
            return false;
        }
    }
</script>