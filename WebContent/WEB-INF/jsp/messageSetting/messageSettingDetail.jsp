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
            <div class="row" style="margin-top:70px;">
                <div class="col-md-1"></div>
                <div class="col-md-10 ">
                    <!-- BEGIN SAMPLE FORM PORTLET-->
                    <div class="portlet light bordered">
                        <div class="portlet-title">
                            <div class="caption">
                                <c:if test="${ !empty message_setting_detail }">
                                <span class="caption-subject font-dark sbold uppercase">Edit Message Setting</span>
                                </c:if>
                                <c:if test="${ empty message_setting_detail }">
                                <span class="caption-subject font-dark sbold uppercase">New Message Setting</span>
                                </c:if>
                            </div>
                        </div>
                        <div class="portlet-body form">
                            <c:if test="${ !empty message_setting_detail }">
                            <form id="message_setting_form" class="form-horizontal" role="form" method="post" enctype="multipart/form-data" action="<c:url value='/messageSetting/update.do'/>">
                            </c:if>
                            <c:if test="${ empty message_setting_detail }">
                            <form id="message_setting_form" class="form-horizontal" role="form" method="post" enctype="multipart/form-data" action="<c:url value='/messageSetting/create.do'/>">
                            </c:if>
                                <input type="hidden" name="message_setting_index" id="message_setting_index" value="${message_setting_detail.message_setting_index}">
                                <div class="form-body">
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">Name</label>
                                        <div class="col-md-9">
                                            <input type="text" name="message_setting_name" value="${message_setting_detail.message_setting_name}" id="message_setting_name" class="form-control" placeholder="Enter Message Setting Name">
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">Code</label>
                                        <div class="col-md-9">
                                            <input type="text" name="message_setting_code" value="${message_setting_detail.message_setting_code}" id="message_setting_code" class="form-control" placeholder="Enter Message Setting Code">
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">SMS Send State</label>
                                        <div class="col-md-9">
                                            <select class="form-control" name="sms_send_state" id="sms_send_state">
                                            <c:forEach var="value" items="${enum_array.sms_send_state}" varStatus="status">
                                           		<c:set var="selected" value=""/>
                                           			<c:if test="${message_setting_detail.sms_send_state == status.index}">                                                            
                                                    	<c:set var="selected" value="selected"/>
                                                    </c:if>
                                                <option value="${status.index}" ${selected}>${value}</option>
                                            </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">SMS Title</label>
                                        <div class="col-md-9">
                                            <input type="text" name="sms_subject" value="${message_setting_detail.sms_subject}" id="sms_subject" class="form-control" placeholder="Enter Message Title" maxlength="28">
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">SMS Message</label>
                                        <div class="col-md-9">
                                            <textarea name="sms_send_msg" id="sms_send_msg" class="form-control col-md-12 input-sm" rows="14">${message_setting_detail.sms_send_msg}</textarea>
                                            <span id="notice_sms_balance"></span>
                                            <c:set var="sms_type" value="${message_setting_detail.sms_type}"/>
                                            <c:if test="${message_setting_detail.sms_type==''}">
                                            	<c:set var="sms_type" value="S"/>
                                            </c:if>
                                            <input type="hidden" name="sms_type" id="sms_type" value="${sms_type}">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">SMS Sender</label>
                                        <div class="col-md-9">
                                            <select id="sms_send_sender" name="sms_send_sender" class="col-md-12 form-control">
                                            <c:forEach var="value" items="${enum_array.sms_send_sender}" varStatus="status">
                                           		<c:set var="selected" value=""/>
                                           			<c:if test="${message_setting_detail.sms_send_sender == status.index}">                                                            
                                                    	<c:set var="selected" value="selected"/>
                                                    </c:if>
                                                <option value="${status.index}" ${selected}>${value}</option>
                                            </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">Arrange Priority</label>
                                        <div class="col-md-9">
                                            <input type="number" name="arrange_priority" value="${message_setting_detail.arrange_priority}" id="arrange_priority" class="form-control" placeholder="Enter Arrange Priority Number">
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <div class="row">
                                        <div class="col-md-offset-5 col-md-9">
                                            <input type="submit" class="btn green" type="submit" name="submit" id="submit" value="Submit">
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
<script type="text/javascript">
    function isLMSMax() {
        var count_num = countUtf8Bytes($("#sms_send_msg").val());
        if (count_num >= 2000) {
            return true;
        } else {
            return false;
        }
    }
    function getSMSType() {
        var count_num = countUtf8Bytes($("#sms_send_msg").val());
        if (count_num >= 90) {
            return 'L';
        } else {
            return 'S';
        }
    }
    function countUtf8Bytes(s){
        var length = s.length;
        var charLength = 0;
        for (var i=0; i < length; i++) {
            charLength += s.charCodeAt(i) > 0x00ff ? 2 : 1;
        }
        return charLength;
        /*
         var b = 0, i = 0, c;
         for(;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
         return b
         */
    }
    function initValue() {

    }
    $(document).ready(function() {
        initValue();
        $("#sms_send_msg").unbind('keydown keyup mouseup');
        $("#sms_send_msg").bind('keydown keyup mouseup', function() {
            var smsType = getSMSType();
            if (smsType == 'L') {
                $("#notice_sms_balance").html("<i class='fa fa-check'></i>LMS로 보내기 : 한 번호당 3건 차감.");
            } else {
                $("#notice_sms_balance").html("<i class='fa fa-check'></i>SMS로 보내기 : 한 번호당 1건 차감.");
            }
            $("#sms_type").val(smsType);
            var is_lms_max = isLMSMax();
            if(is_lms_max){
                if(!window.is_over_max_lms) {
                    window.max_lms_length = $(this).val().length;
                    window.is_over_max_lms = 1;
                }
                $(this).val($(this).val().substring(0, window.max_lms_length));
            } else {
                window.is_over_max_lms = 0;
            }
        });
        
        $("#sms_send_msg").trigger('keydown');
    });
</script>