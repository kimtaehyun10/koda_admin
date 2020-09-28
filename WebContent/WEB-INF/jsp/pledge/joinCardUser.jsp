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
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>한국장기조직기증원 대국민소통사업단</title>
    <meta name="description" content="대국민소통사업단 소개, 기증과정안내, 문화콘텐츠 안내">
    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/home/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/home/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/home/css/animations.css" rel="stylesheet" >
    <link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css"/>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>

<div class="container">
<div class="row">
<div id="right_content">
<div class="top_title">
    <h2>희망서약 하기</h2>
</div>
<div class="right_content_text" style="position: relative;">
<style>
    .return_content_boder{
        width: 100%;
        height: 100%;
        position: absolute;
        z-index: 99;
        background: #fff;
        padding:15px;
        box-sizing: border-box;
        display:none;
    }
    .return_content{
        width: 100%;
        float: left;
        height: 100%;
        border: 1px solid #000;
    }
    .return_content_title{
        width: 100%;
        float: left;
        font-size: 20px;
        padding: 10px 8px;
        background: #000;
        color: #fff;
        box-sizing: border-box;
    }
    .return_content_title > a{
        float: right;
        color: #fff;
    }
    .return_content_text{
        width: 100%;
        margin: 50px auto;
        overflow: hidden;
        max-width: 600px;
        border: 1px solid #1c1819;
        -moz-border-radius: 15px;
        -webkit-border-radius: 15px;
        -o-border-radius: 15px;
        -ms-border-radius: 15px;
        border-radius: 15px;
    }
    .return_content_text_title{
        width: 100%;
        float:left;
        background: #ec1b30;
        font-size: 34px;
        font-weight: bold;
        box-sizing: border-box;
        color: #fff;
        padding:20px 30px 15px 30px;
    }

    .return_content_text_content{
        width: 100%;
        float: left;
        padding: 30px 0;
    }
    .return_content_text_bottom{
        width: 100%;
        float: left;
        padding:10px 10px;
        background: #c9cacc;
        overflow: hidden;
        box-sizing: border-box;
    }
    @media (max-width:1024px){
        .first_form_group{
            margin-bottom: 15px !important;
        }
        .return_content{
            height: auto !important;
        }

    }
    @media (max-width:768px){
        .return_content_text{
            border-left:none;
            max-width: 100%;
            border-right:none;
        }
    }
    .portlet_inner_group {
        padding-top: 10px;
        border-top: 1px solid #4fc2d5;
    }
</style>

<!--add   return-->

<div class="return_content_boder">
    <div class="return_content">
        <div class="return_content_title">title title title title   <a href="#"><i class="glyphicon glyphicon-remove"></i></a></div>
        <div class="clearfix"></div>
        <div class="return_content_text">
            <div class="return_content_text_title">
                <h2 style="float: left; font-family:'나눔고딕';">기증희망등록증</h2>
                <img src="${pageContext.request.contextPath}/home/images/return_img.jpg" class="return_img" style="float: right;">
            </div>
            <div class="return_content_text_content">
                <form class="form-horizontal">
                    <div class="col-md-6">
                        <div class="form-group first_form_group" style="margin-bottom: 100px;">
                            <label class="col-md-4 control-label" style="font-size: 18px;">성명 :</label>
                            <div class="col-md-8" style="padding:7px 5px 0px 5px; font-size: 18px;">
                                한국장기조직기증원
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label" style="font-size: 18px;">기증형태:</label>
                            <div class="col-md-8" style="padding:7px 5px 0px 5px; font-size: 18px;">
                                한국장기조직기증원
                            </div>
                        </div>



                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-md-4 control-label" style="font-size: 18px;">서약기관: </label>
                            <div class="col-md-8" style="padding:7px 5px 0px 5px; font-size: 18px;">
                                한국장기조직기증원
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label" style="font-size: 18px;">서약번호:</label>
                            <div class="col-md-8" style="padding:7px 5px 0px 5px; font-size: 18px;">
                                한국장기조직기증원
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label" style="font-size: 18px;">서약일자:</label>
                            <div class="col-md-8" style="padding:7px 5px 0px 5px; font-size: 18px;">
                                한국장기조직기증원
                            </div>
                        </div>


                    </div>
                </form>

            </div>
            <div class="return_content_text_bottom">
                <div class="col-md-7" style="padding: 0px 5px;">
                    <p style="font-size: 13px; color: #1c1819; font-weight: bold; letter-spacing: -1px; font-family:'나눔고딕'; padding-top: 15px;">
                        카드는 항상 휴대하시고, 분실시 재발급 받으시기 바랍니다.<br>
                        *본 증을 습득하신 분은 1544-0606으로 연락 주시기 바랍니다.<br>
                    </p>

                </div>
                <div class="col-md-5" style="padding: 0px 10px;">
                    <p style="font-size: 24px; color: #1c1819; font-weight: bold; letter-spacing: -1px; font-family:'나눔고딕';">
                        서약문의:1544-0606<br>
                        기증발생:1577-1458<br>
                    </p>

                </div>
            </div>

        </div>
    </div>
</div>

<!--add   return-->



<form role="form" class="form-horizontal" id="message_form" enctype="multipart/form-data" action="<c:url value="/pledge/register.do"/>" method="post">
<input id="status" name="status" type="hidden" value="1">
<input id="showCard" name="showCard" type="hidden" value="${showCard}">
<c:if test="${!empty issue_membership}">
    <input name="issue_membership_index" type="hidden" value="${issue_membership.issue_membership_index}">
</c:if>
<div class="row">
<style>
    p.has-error-input{
        color:red;
        margin-top: 5px;
    }
    .portlet-body {
        padding: 15px;
    }

    .portlet {
        width: 100%;
        float: left;
        box-sizing: border-box;
        border: 1px solid #4fc2d5;
        margin-bottom: 15px;
    }

    .portlet-title {
        background: #4fc2d5;
        width: 100%;
        float: left;
        font-size: 13px;
        padding: 5px 10px;
        color: #fff;
        margin-bottom: 15px;
        box-sizing: border-box;
    }
    .control-label{
        padding-left: 5px !important;
        padding-right: 5px !important;
    }
    .zero-padding{
        padding-left:0px;
        padding-right: 0px;
        box-sizing: border-box;
    }
    .text-align-center{
        text-align: center;
        vertical-align: middle;
    }
    .col-left{
        padding-left: 0px;
        padding-right: 10px
    }
    .col-center{
        padding-right: 5px;
        padding-left: 5px;
    }
    .col-right{
        padding-left: 10px;
        padding-right: 0px
    }
    @media (max-width:768px){
        .col-left{
            padding-left: 0px;
            margin-bottom: 15px;
            padding-left: 0px;
            padding-right: 0px;
        }
        .col-center{
            margin-bottom: 15px;
            padding-left: 0px;
            padding-right: 0px;
        }
        .col-right{
            margin-bottom: 15px;
            padding-left: 0px;
            padding-right: 0px;
        }
    }
.btn_submit_form{
    border: 1px solid transparent;
    border-radius: 4px;
    cursor: pointer;
    display: inline-block;
    font-size: 14px;
    margin-bottom: 0;
    padding: 6px 12px;
    text-align: center;
	background:#ccc;
	margin-top:10px;

}
</style>
<div class="col-md-12">
    <div class="portlet">
        <div class="portlet-title">
            인적사항
        </div>
        <div class="portlet-body">
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-md-3 control-label">성명</label>
                            <div class="col-md-9">
                                <input readonly id="user_name" name="user_name" type="text" class="form-control input-sm" placeholder=""
                                       value="${issue_membership.korName}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">주민등록번호 *</label>
                            <div class="col-md-9">
							<div class="row">
                                <div class="col-md-6 col-xs-6" style="padding-right:5px;">
                                    <input id="user_social_security_num_0" name="user_social_security_num_0" type="text" class="form-control input-sm number_only1" size="6" maxlength="6" title="" value="" oninput="if(value.length>6)value=value.slice(0,6)" >
                                </div>
                                <div class="col-md-6 col-xs-6" style="padding-left:5px;">
                                    <input id="user_social_security_num_1" name="user_social_security_num_1" type="text" class="form-control input-sm number_only2" size="7" maxlength="7" title="" value="" oninput="if(value.length>7)value=value.slice(0,7)">
                                </div>
								</div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-offset-3 col-md-9">
							<div style="clear:both;"></div>
                                <button id="btn_name_check" type="button" class="btn blue btn_submit_form">실명확인</button>
								<div style="clear:both;"></div>
                               <label id="name_check_true" class="sr-only" style="margin-top: 6px;">확인됨</label>
							   <div style="clear:both;"></div>
                                <input id="name_checked" name="name_checked" type="text" class="form-control input-sm" size="1" style="height:0;width:0;margin:0;padding:0;" >
								<div style="clear:both;"></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">생년월일</label>
                            <div class="col-md-9">
                                <input readonly id="user_birthday" name="user_birthday" type="text" size="10" id="" class="input-sm form-control"
                                       value="${issue_membership.birthday}">
                            </div>
                        </div>
                        <div class="form-group phone-number">
                            <label class="col-md-3 control-label">휴대전화 *</label>
                            <div class="col-md-9">
						
							
                                <div class="col-md-4 col-xs-4" style="padding-left:0px; padding-right:8px;">
                                    <input id="user_mobile_0" name="user_mobile_0" type="tel" class="form-control input-sm" size="3" maxlength="3" title=""
                                           value="${issue_membership.mdn_0}">
                                </div>

                                <div class="col-md-4 col-xs-4" style="padding-right:4px; padding-left:4px;">
                                    <input id="user_mobile_1" name="user_mobile_1" type="tel" class="form-control input-sm" size="4" maxlength="4" title=""
                                           value="${issue_membership.mdn_1}">
                                </div>

                                <div class="col-md-4 col-xs-4" style="padding-left:8px; padding-right:0px;">
                                    <input id="user_mobile_2" name="user_mobile_2" type="tel" class="form-control input-sm" size="4" maxlength="4" title=""
                                           value="${issue_membership.mdn_2}">
                                </div>
						
                            </div>
                        </div>
                    </div>
                    <!-- /.col-md-6 -->
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-md-3 control-label">성별</label>
                            <div class="col-md-9">
                                <input readonly id="user_sex" name="user_sex" type="text" class="form-control input-sm" placeholder=""
                                       value="${issue_membership.gender}">
                            </div>
                        </div>
                        <div class="form-group phone-number">
                            <label class="col-md-3 control-label">집전화</label>
                            <div class="col-md-9">
				
                                <div class="col-md-4 col-xs-4" style="padding-right:8px; padding-left:0px;">
                                    <input id="user_phone_0" name="user_phone_0" type="tel" class="form-control input-sm" size="4" maxlength="4" title="" value="">
                                </div>

                                <div class="col-md-4 col-xs-4" style="padding-right:4px; padding-left:4px;">
                                    <input id="user_phone_1" name="user_phone_1" type="tel" class="form-control input-sm" size="4" maxlength="4" title="" value="">
                                </div>

                                <div class="col-md-4 col-xs-4" style="padding-left:8px; padding-right:0px;">
                                    <input id="user_phone_2" name="user_phone_2" type="tel" class="form-control input-sm" size="4" maxlength="4" title="" value="">
                                </div>
					
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">이메일 *</label>
                            <div class="col-md-9">
                            	<c:set var="user_email" value="${fn:split(issue_membership.user_email, '@')}"/>
                                <div class="col-md-3 col zero-padding">
                                    <input id="user_email_1" name="user_email_1" type="text" class="form-control input-sm" placeholder=""
                                            value="${user_email[0]}">
                                </div>
                                <div class="col-md-1 col zero-padding text-center" style="height:28px; margin-top:5px;">
                                    @
                                </div>                                
                                <div class="col-md-4 col zero-padding">
                                    <select id="user_email_3" name="user_email_3" class="form-control input-sm">
                                        <c:forEach var="value" items="${enum_array.user_email}" varStatus="status">
	                                   		<c:choose>
	                                   		<c:when test="${status.index == 0}">                                                    
												<option value="" selected="selected">${value}</option>
                                           	</c:when>
                                           	<c:otherwise>
                                               	<option value="${value}">${value}</option>
                                           	</c:otherwise>
                                           	</c:choose>
                                       	</c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-4 col zero-padding" hidden>
                                    <input id="user_email_2" name="user_email_2" type="text" class="form-control input-sm" placeholder=""
                                           value="${user_email[1]}">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="form-group" style="margin-bottom: 5px;margin-top:0px;">
                            <h5 class="col-md-3 ">기본주소</h5>
                        </div>
                        <div class="portlet_inner_group">
                            <div class="form-group">
                                <label class="col-md-3 control-label">우편번호 *</label>
                                <div class="col-md-9">
                                    <input readonly id="user_post" name="user_post" type="text" class="form-control input-sm search_addr_popup input_post" placeholder=""
                                           value="${issue_membership.zipCode}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">주소 *</label>
                                <div class="col-md-9">
                                    <input readonly id="user_address" name="user_address" type="text" class="form-control input-sm input_address" placeholder=""
                                           value="${issue_membership.basicAddr}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">상세주소 *</label>
                                <div class="col-md-6">
                                    <input readonly id="user_address_detail" name="user_address_detail" type="text" class="form-control input-sm input_address_detail" placeholder=""
                                           value="${issue_membership.detailAddr}">
                                </div>
                                <div class="col-md-3">
                                    <button type="button" class="btn btn-circle green hidden-print search_addr_popup btn_submit_form">주소검색</button>
                                </div>
                            </div>
                        </div>
                    </div><!-- /.col-md-6 -->
                    <div class="col-md-6">
                        <div class="form-group" style="margin-bottom: 0px;">
                            <h5 class="col-md-3 col-xs-6">송달주소</h5>
                            <div class="col-md-1 col-xs-6">
                                <label class="mt-checkbox" style="padding-top: 4px;">
                                    <input readonly id="same_address_btn" name="same_address_btn" type="checkbox" class="input-sm" value="1" style="height: 23px;"><span></span>
                                </label>
                            </div>
                        </div>
                        <div class="portlet_inner_group">
                            <label class="col-md-12 control-label text-align-left" style="padding-bottom: 5px; text-align: left;">기본주소와 같은 경우 버튼을 눌러주세요</label>
                            <div class="form-group">
                                <label class="col-md-3 control-label">송달우편번호 *</label>
                                <div class="col-md-9">
                                    <input readonly id="user_send_post" name="user_send_post" type="text" class="form-control input-sm search_addr_popup input_post" placeholder="" value="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">송달주소 *</label>
                                <div class="col-md-9">
                                    <input readonly id="user_send_address" name="user_send_address" type="text" class="form-control input-sm input_address" placeholder="" value="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">송달상세주소 *</label>
                                <div class="col-md-6">
                                    <input readonly id="user_send_address_detail" name="user_send_address_detail" type="text" class="form-control input-sm input_address_detail" placeholder="" value="">
                                </div>
                                <div class="col-md-3">
                                    <button type="button" class="btn btn-circle green hidden-print search_addr_popup btn_submit_form">주소검색</button>
                                </div>
                            </div>
                        </div>
                    </div><!-- /.col-md-6 -->
                </div><!-- /.col-md-12 -->
            </div>
            <!-- /.row -->
        </div>
    </div>
</div>
</div>
<div class="row">
    <div class="col-md-6">
        <div class="portlet box blue-hoki " id="left_message_form">
            <div class="portlet-title">
                서약 및 등록정보
            </div>
            <div class="portlet-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="col-md-3 control-label mt-checkbox">기증형태 *</label>
                            <div class="col-md-9">
                                <div class="checkbox">
                                    <label>
                                        <input id="user_donation_type_organ" name="user_donation_type_organ" class="donation_checkbox" type="checkbox" value="1" checked>
                                        기증형태_장기
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input id="user_donation_type_body" name="user_donation_type_body" class="donation_checkbox" type="checkbox" value="1" checked>
                                        기증형태_조직
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label >
                                        <input id="user_donation_type_comea" name="user_donation_type_comea" class="donation_checkbox" type="checkbox" value="1" checked>
                                        기증형태_각막
                                    </label>

                                </div>


                            </div>
                        </div>
                        <input id="user_donation_type_checked" name="user_donation_type_checked" type="text" class="form-control input-sm" size="1" style="height:0;width:0;margin:0;padding:0;" >

                        <div class="form-group">
                            <label class="col-md-3 control-label">운전면허증 표시 *</label>
                            <div class="col-md-9">
                                <select id="user_is_driving_license" name="user_is_driving_license" class="form-control input-sm">
                                	<c:forEach var="value" items="${enum_array.user_is_driving_license}" varStatus="status">
                                   	<c:set var="selected" value=""/>                                    	
                                    	<c:if test="${status.index == 1}">
                                       	<c:set var="selected" value="selected"/>
                                       	</c:if>                             
                                       	<c:if test="${status.index > 0}">          	
                                       	<option value="${status.index}" ${selected}>${value}</option>
                                       	</c:if>
                                    </c:forEach>                                   
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label important-form-mark">서약일 *</label>
                            <div class="col-md-9">
                                <input readonly id="user_pledge_date" name="user_pledge_date" type="text" size="10" id="" class="input-sm form_datetime form-control" value="">
                            </div>
                        </div>
                    </div>
                    <!-- /.col-md-6 -->
                </div>
                <!-- /.row -->
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="portlet box blue-hoki " id="right_message_form">
            <div class="portlet-title">
                정보수신동의 및 발송현황
            </div>
            <div class="portlet-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="col-md-3 control-label">이메일동의 *</label>
                            <div class="col-md-9">
                                <select id="user_is_email_agree" name="user_is_email_agree" class="form-control input-sm">
                                	<c:forEach var="value" items="${enum_array.user_is_email_agree}" varStatus="status">
                                   	<c:set var="selected" value=""/>                                    	
                                    	<c:if test="${status.index == 1}">
                                       	<c:set var="selected" value="selected"/>
                                       	</c:if>                             
                                       	<c:if test="${status.index > 0}">          	
                                       	<option value="${status.index}" ${selected}>${value}</option>
                                       	</c:if>
                                    </c:forEach>                                   
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">문자동의 *</label>
                            <div class="col-md-9">
                                <select id="user_is_sms_agree" name="user_is_sms_agree" class="form-control input-sm">
                                	<c:forEach var="value" items="${enum_array.user_is_sms_agree}" varStatus="status">
                                   	<c:set var="selected" value=""/>                                    	
                                    	<c:if test="${status.index == 1}">
                                       	<c:set var="selected" value="selected"/>
                                       	</c:if>                             
                                       	<c:if test="${status.index > 0}">          	
                                       	<option value="${status.index}" ${selected}>${value}</option>
                                       	</c:if>
                                    </c:forEach>                                    
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">우편동의 *</label>
                            <div class="col-md-9">
                                <select id="user_is_mail_agree" name="user_is_mail_agree" class="form-control input-sm">
                                	<c:forEach var="value" items="${enum_array.user_is_mail_agree}" varStatus="status">
                                   	<c:set var="selected" value=""/>                                    	
                                    	<c:if test="${status.index == 1}">
                                       	<c:set var="selected" value="selected"/>
                                       	</c:if>                             
                                       	<c:if test="${status.index > 0}">          	
                                       	<option value="${status.index}" ${selected}>${value}</option>
                                       	</c:if>
                                    </c:forEach>                                    
                                </select>
                            </div>
                        </div>
                    </div>
                    <!-- /.col-md-6 -->
                </div>
                <!-- /.row -->
            </div>
        </div>
    </div>
</div>

<div class="col-md-12 text-left">
    * 표시 항목을 모두 입력해야 제출이 완료됩니다.
</div>
<div class="col-md-12 text-center">
    <button type="submit" class="btn btn-circle green hidden-print btn_submit_form">서약서 제출</button>
</div>
</div>
</form>
</div>
</div>
</div> </div>

<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="footer_logo"> <a href="#"><img src="${pageContext.request.contextPath}/home/images/footer_logo.png" style="max-width: 100%;"></a> </div>
            <div class="footer_content">
                <div class="footer_top">
                    <div class="footer_content_nav"> <a href="#" data-toggle="modal" data-target="#footer_Modal_text">개인정보처리방침</a> </div>
                    <div class="modal fade" id="footer_Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                </div>
                                <div class="modal-body" style="text-align:center;">
                                    <a href="${pageContext.request.contextPath}/home/images/web-map-popup-images.jpg"><img src="${pageContext.request.contextPath}/home/images/web-map-popup-images.jpg" style="max-width: 100%;"></a>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal fade" id="footer_Modal_text" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title" style="float:left; font-weight:bold;">개인정보 보호정책</h4>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                </div>
                                <div class="modal-body" style="text-align:left;padding:15px 25px;">
                                    <p style="font-size:14px; line-height:25px;">
                                        한국장기조직기증원이 취급하는 모든 개인정보는 관련법령에 근거하거나<br>정보주체의 동의에 의하여
                                        수집ㆍ보유 및 처리되고 있습니다.<br>「개인정보보호법」은 개인정보의 취급에 대한 일반적 규범을 제시하고 있으며, <br>
                                        한국장기조직기증원은 이러한 법령의 규정에 따라 수집ㆍ보유 및 처리하는 개인정보를 공공업무의 <br>
                                        적절한 수행과 국민의 권익을 보호하기 위해 적법하고 적정하게 취급할 것입니다. 또한, <br>
                                        기증원은 관련법령에서 규정한 바에 따라 보유하고 있는 개인저옵에 대한 열람청구권 및 정정청구권 등 여러분의 권익을 존중합니다.
                                        <br><br>
                                        ■ 개인정보의 처리 목적, 처리 및 보유기간, 처리하는 개인정보의 항목
                                        <br>
                                        한국장기조직기증원은 개인정보를 다음의 목적을 위해 처리합니다. <br>
                                        처리한 개인정보는 다음의 목적이외의 용도로는 사용되지 않으며 이용 목적이 변경되는 경우에는 개인정보 보호법에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.<br>
                                        1. 한국장기조직기증원에서 법령의 규정에 근거하여 수집ㆍ보유하고 있는 주요 개인 정보항목<br>

                                        개인정보파일 운용 주체	한국장기조직기증원 대국민소통사업단<br>
                                        개인정보파일의 명칭	장기기증 관련 정보<br>
                                        개인정보파일의 보유근거	장기등 이식에 관한 법률<br>
                                        개인정보파일의 보유목적	뇌사 장기기증 관련 정보 관리<br>
                                        개인정보파일 항목	인적정보(이름, 주민번호, 주소, 전화번호, 보호자정보) 개인정보동의정보,서약정보
                                        보유기간	반영구<br>


                                        개인정보파일 운용 주체	한국장기조직기증원 대국민소통사업단<br>
                                        개인정보파일의 명칭	서약정보<br>
                                        개인정보파일 항목	서약직접입력정보<br>
                                        보유기간	반영구<br>

                                        <br>
                                        2. 개인정보의 제3자 제공<br>
                                        <br>
                                        한국장기조직기증원은 원칙적으로 정보주체의 개인정보를 수집ㆍ이용 목적으로 명시한 범위 내에서 처리하며, 다음의 경우를 제외하고는 정보주체의 사전 동의 없이는 본래의 목적 범위를 초과하여 처리하거나 제3자에게 제공하지 않습니다.<br>
                                        - 정보주체로부터 별도의 동의를 받는 경우<br>
                                        - 법률에 특별한 규정이 있는 경우<br>
                                        - 정보주체 또는 법정대리인이 의사표시를 할 수 없는 상태에 있거나 주소불명 등으로 사전 동의를 받을 수 없는 경우로서 명백히 정보주체 또는 제3자의 급박한 생명, 신체, 재산의 이익을 위하여 필요하다고 인정되는 경우<br>
                                        - 통계작성 및 학술연구 등의 목적을 위하여 필요한 경우로서 특정 개인을 알아 볼 수 없는 형태로 개인정보를 제공하는 경우<br>
                                        - 개인정보를 목적 외의 용도로 이용하거나 이를 제3자에게 제공하지 아니하면 다른 법률에서 정하는 소관 업무를 수행할 수 없는 경우로서 보호위원회의 심의ㆍ의결을 거친 경우<br>
                                        - 조약, 그 밖의 국제협정의 이행을 위하여 외국정부 또는 국제기구에 제공하기 위하여 필요한 경우<br>
                                        - 범죄의 수사와 공소의 제기 및 유지를 위하여 필요한 경우<br>
                                        - 형 및 감호, 보호처분의 집행을 위하여 필요한 경우<br>
                                        - 한국장기조직기증원은 다음과 같이 개인정보를 제3자에게 제공하고 있습니다.<br>
                                        ㆍ 개인정보를 제공받는 자 : 국립장기이식관리기관의 장<br>
                                        ㆍ 제공받는 자의 개인정보 이용목적 : 뇌사 장기기증 관련 업무<br>
                                        ㆍ 제공하는 개인정보 항목 : 뇌사 추정 통보자 정보(의료기관의 명칭, 성명), 뇌사 추정자(성명, 생년월일, 주소, 의식수준, 발생원인)<br>
                                        ㆍ 제공받는 자의 보유ㆍ이용기간 : 반영구<br>
                                        3. 개인정보의 파기절차 및 방법<br>

                                        한국장기조직기증원은 원칙적으로 개인정보의 수집 및 이용목적이 달성된 후에는 개인정보를 지체 없이 파기합니다. 기증원의 개인정보 파기절차 및 방법은 다음과 같습니다.<br>
                                        1) 파기절차 : 입력한 정보는 목적이 달성된 후 별도의 DB로 옮겨져(종이의 경우 별도의 서류함 보관) 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(보유 및 이용기간 참조) 일정 기간 저장된 후 파기됩니다.<br>
                                        별도 DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 보유되는 이외의 다른 목적으로 이용되지 않습니다.<br>
                                        2) 파기방법 : 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제됩니다. 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기됩니다.<br>
                                        4. 이용자의 개인정보 관리 (열람, 정정, 삭제 등)에 관한 사항<br>

                                        정보주체는 언제든지 등록되어 있는 자신의 개인정보를 조회하거나 수정할 수 있으며 열람, 정정, 삭제, 처리정지 등의 요구는 아래와 같습니다.<br>
                                        ① 정보주체는「개인정보 보호법」제35조 내지 제37조에 따라 개인정보의 열람, 정정·삭제, 처리정지 등의 요구(이하 “열람등요구”)를 할 수 있습니다. 또한 만 14세 미만 아동의 법정대리인은 그 아동의 개인정보에 대하여 열람등요구를 할 수 있습니다.<br>
                                        ② 제1항에 따른 권리 행사는[개인정보 보호법]시행규칙 별지 제8호 서식에 따라 작성 후 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며, 이에 대해 지체 없이 조치하겠습니다.<br>
                                        ③ 정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.<br>
                                        ④ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우[개인정보 보호법]시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.<br>
                                        ⑤ 개인정보 열람 및 처리정지 요구는[개인정보 보호법]제35조제5항, 제37조제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.<br>
                                        ⑥ 개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.<br>
                                        ⑦ 정보주체 권리에 따른 열람의 요구, 정정·삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.<br>
                                        ⑧ 정보주체는 열람등 요구를 개인정보보호 담당자를 통하여 할 수 있습니다.<br>
                                        ⑨ 정보주체는 제8항의 열람청구 접수ㆍ처리부서 이외에, 행정자치부의 '개인정보보호 종합포털'웹사이트(www.privacy.go.kr)에서도 개인정보 열람청구를 하실 수 있습니다.<br>
                                        ☞ 행정자치부 개인정보보호 종합포털 → 개인정보 민원 → 개인정보 열람 등 요구(본인 확인을 위하여 아이핀(I-PIN)이 있어야 함)<br>
                                        <br>
                                        개인정보보호 종합포털 바로가기<br>
                                        5. 14세 미만 아동개인정보 보호<br>
                                        <br>
                                        '개인정보 보호법'상 만 14세 미만의 아동은 온라인으로 타인에게 개인정보를 보내기 전에 반드시 개인정보의 수집 및 이용목적에 대하여 충분히 숙지하고 법정대리인(부모)의 동의를 받아야 합니다. 이에 기증원은 홈페이지 회원가입 절차에서 위 사항을 설명하고 있으며 회원 가입 시에는 반드시 법정대리인(부모)의 동의를 받는 확인절차를 거치고 있습니다.<br>
                                        법정대리인의 성명, 생년월일, 이메일주소(전자우편을 통한 동의 선택시)는 아동의 개인정보 수집에 대한 동의여부 확인의 목적으로 사용되며, 해당 정보는 아동의 회원 탈퇴 시까지 보유합니다.<br>
                                        만 14세 미만 아동의 법정 대리인(부모)은 아동의 개인정보 열람, 정정, 동의 철회를 요청할 수 있으며, 이러한 요청이 있을 경우 기증원은 지체 없이 필요한 조치를 취합니다.<br>
                                        6. 개인정보 자동수집 장치의 설치, 운영 및 그 거부에 관한 사항<br><br>

                                        기증원은 후원자 혹은 법정 대리인의 요청에 의해 해지 또는 삭제된 개인정보를 “기증원이 수집하는 개인정보의 보유 및 이용기간”에 명시된 바에 따라 처리하고, 그 외의 용도로 열람 또는 이용할 수 없도록 처리합니다.<br>
                                        기증원은 후원자 및 방문자의 정보를 수시로 저장하고 찾아내는 '쿠키(cookie)' 등을 운용합니다. 쿠키란 기증원의 홈페이지 운영을 위해 사용하는 서버가 사용자의 브라우저에 보내는 아주 작은 텍스트 파일로서 사용자의 컴퓨터 하드디스크에 저장됩니다. 기증원은 다음과 같은 목적을 위해 쿠키를 사용합니다.<br>
                                        쿠키 등 사용 목적 : 회원과 비회원의 접속 빈도나 방문 시간 등을 분석, 후원자의 취향과 관심분야 파악 및 자취 추적, 각종 이벤트 참여 정도 및 방문 횟수 파악<br>
                                        7. 개인정보의 기술적, 관리적 보호대책<br>
                                        <br>
                                        정보주체는 쿠키 설치에 대한 선택권을 가지고 있습니다. 따라서 후원자는 웹브라우저에서 옵션을 설정함으로써 모든 쿠키를 허용하거나, 쿠키가 저장될 때마다 확인을 거치거나, 아니면 모든 쿠키의 저장을 거부할 수도 있습니다.<br>
                                        기증원은 정보주체의 개인정보를 취급함에 있어 개인정보가 분실, 도난, 누출, 변조 또는 훼손되지 않도록 안전성 확보를 위하여 다음과 같은 기술적, 관리적 대책을 강구합니다.<br>
                                        1) 개인정보의 기술적/관리적 운영 : 기증원의 개인정보보호담당자는 내부관리계획을 바탕으로 한 철저한 관리감독과 교육을 통해 개인정보가 분실, 도난, 누출, 변조 또는 훼손되지 않도록 최선을 다하고 있습니다.<br>
                                        2) 해킹 등에 대한 대비책 : 개인정보의 훼손에 대비해서 자료를 수시로 백업하고 있고, 최신 백신프로그램을 이용하여 후원자들의 개인정보나 자료가 누출되거나 손상되지 않도록 방지하고 있으며, 암호화 통신 등을 통하여 네트워크상에서 개인정보를 안전하게 전송하도록 의무화합니다.<br>
                                        3) 개인정보 취급 직원의 교육 : 기증원은 개인정보보호법의 지침에 따라 내부관리계획을 수립하여 시행하며, 개인정보보호와 관련된 문제가 발생되지 않도록 노력하고, 문제가 발생할 경우 즉시 수정하고 바로잡을 수 있도록 최선을 다하고 있습니다.<br><br>
                                        8. 개인정보에 관한 민원서비스<br>
                                        <br>
                                        한국장기조직기증원은 후원자의 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 아래와 같이 관련 부서 및 개인정보 관리 책임자와 관리담당자를 지정하고 있습니다.<br>
                                        개인정보보호 책임자<br>
                                        성명 : 동복희<br>
                                        직책 : 서약운영팀 과장<br>
                                        연락처 : 02-3785-3177, 이메일 : bh.dong@koda1458.kr<br>

                                        <br>
                                        한국장기조직기증원의 후원자로 등록된 분들은 기관의 서비스를 이용하시며 발생하는 모든 개인정보보호 관련 민원을 개인정보관리 책임자 혹은 담당부서로 신고하실 수 있습니다. 한국장기조직기증원은 접수되는 신고사항에 대해 신속하게 충분한 답변을 드릴 것입니다.<br>
                                        기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.<br>
                                        1. 개인정보침해신고센터 (www.1336.or.kr/ 국번 없이 118)<br>
                                        2. 정보보호마크인증위원회 (www.eprivacy.or.kr / 02-550-9531~2)<br>
                                        3. 대검찰청 인터넷범죄수사센터 (http://www.spo.go.k / 02-3480-2000)<br>
                                        4. 경찰청 사이버테러대응센터 (www.ctrc.go.kr / 1566-0112)<br>
                                        9. 부칙<br>
                                        <br><br>
                                        이 방침은 2017년 7월 1일부터 시행합니다.<br></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="footer_bottom">
                    <p style=" font-size: 12px; color: #999999; font-family:'dotum'; line-height: 20px;"> 서울시 강남구 언주로 133길 29, 한국장기조직기증원 (우)06053  / tel: 02 - 542 - 5635 / fax: 02 - 794 - 2641 / EMail: jy.park@koda1458.kr<br/>
                        희망서약 상담번호 1544-0606   Copyright (c) 2015 All Rights Reserved. </p>
                    <p style=" font-size: 12px; color: #666666; font-family:'dotum'; line-height: 20px;"> <img src="${pageContext.request.contextPath}/home/images/footer_bottom_bg.png" class="footer_img" style="max-width: 100%; float:right; margin-right: 10px;"></p>
                </div>
            </div>
        </div>
    </div>
</footer>
<script src="${pageContext.request.contextPath}/home/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/home/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/home/js/bootstrap-hover-dropdown.js"></script>

<script src="${pageContext.request.contextPath}/home/js/index.js"></script>

<script src="${pageContext.request.contextPath}/home/js/page.js"></script>

<script src="${pageContext.request.contextPath}/home/js/order.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $(".footer_select").bind("change",function(){
            var firend_url = $("option:selected",this).attr("data-firend-url");
            if(firend_url!=""){
                /*
                 $("#friend_link").attr("href",firend_url).trigger('click');
                 */
                window.location.href=firend_url;
                /*window.open(firend_url);*/
            }else{

            }
        });
        $(".footer_select").on('change', function(e) {

        });

    });
</script>

</body>
</html>



<script src="${pageContext.request.contextPath}/common/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery_redirect/jquery.redirect.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/printThis/printThis.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/home/js/SWJSObjectSrc.min.js" type="text/javascript"></script>

<script language="JavaScript" type="text/javascript">
    // Conversion Data from PHP to Javascript
    <c:choose><c:when test="${ !empty enum_array}">
	var enum_array = ${enum_array};
	</c:when><c:otherwise>
	var enum_array = null;
	</c:otherwise></c:choose>
    var selected_post;

    function getCookie(cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for(var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }

    function jusoCallBack() {

        //var zipNo = getCookie('zipNo');
        //var roadAddrPart1 = getCookie('roadAddrPart1');
        //var addrDetail = getCookie('addrDetail');

        $.ajax({
            url: "<c:url value='/pledge/getAddrSessionAjax.do'/>",
            type: 'post',
            dataType: "json",
            data: {
            },
            success: function(data) {
                //var parsedData = $.parseJSON(data);
                if(data != null && data.rtnCode == "") {
	                var parsedData = data.data;
	
	                var zipNo = parsedData.zipNo;
	                var roadAddrPart1 = parsedData.roadAddrPart1;
	                var addrDetail = parsedData.addrDetail;
	
	                var user_post_input = selected_post.parent().parent().parent().find(".input_post");
	                var user_address_input = selected_post.parent().parent().parent().find(".input_address");
	                var user_address_detail_input = selected_post.parent().parent().parent().find(".input_address_detail");
	
	                if(roadAddrPart1 != "") {
	                    if(zipNo!=""){
	                        user_post_input.val( zipNo );
	                        user_post_input.removeClass("has-error-input");
	                        user_post_input.next().html(" ");
	                    }
	                    user_address_input.val( roadAddrPart1 );
	                    if(roadAddrPart1!=""){
	                        user_address_input.removeClass("has-error-input");
	                        user_address_input.next().html(" ");
	                    }
	                    user_address_detail_input.val( addrDetail );
	                    if(addrDetail!=""){
	                        user_address_detail_input.removeClass("has-error-input");
	                        user_address_detail_input.next().html(" ");
	                    }
	                }
	                deleteAddrSession();
                } else {
                	//alert(data.rtnMsg);
                }
            },
            error: function(xhr, desc, err) {

            }
        });
    }

    function deleteAddrSession() {
        $.ajax({
            url: "<c:url value='/pledge/unsetAddrSessionAjax.do'/>",
            dataType: "json",
            type: 'post',
            data: {
            },
            success: function(data) {
            	if(data != null && data.rtnCode == "") {
            	} else {
            		alert(data.rtnMsg);
            	}
            },
            error: function(xhr, desc, err) {
            }
        });
    }

    // delete 0
    function pad( n, width ) {
        n = n + '';
        return n.length >= width ? n : new Array( width - n.length + 1 ).join( '0' ) + n;
    }

    function goAddrPopup() {
        // 주소검색을 수행할 팝업 페이지를 호출합니다.
        window.wallet.goFullWebView("{\"url\":\"http://175.193.254.45:8080/koda/pledge/openAddrPopup.do\",\"closeCallbackJS\":\"jusoCallBack\"}");

        // 호출된 페이지(jusoPopup_utf8.php)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
        //var pop = window.open( "https://www.koda15440606.kr/index.php/Pledge/openAddrPopup", "pop", "width=570,height=420, scrollbars=yes, resizable=yes" );
        //var pop = window.open( "http://175.193.254.45:8080/koda/pledge/openAddrPopup.do", "pop", "width=570,height=420, scrollbars=yes, resizable=yes" );
        // 모바일 웹인 경우, 호출된 페이지(jusoPopup_utf8.php)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
        //var pop = window.open("/jusoPopup_utf8.php","pop","scrollbars=yes, resizable=yes");
    }

    function initValue() {
        var today = new Date();
        var today_string = today.getFullYear() + "." + pad( ( today.getMonth() + 1 ), 2 ) + "." + pad( today.getDate(), 2);
        $( "#user_pledge_date" ).val( today_string );
    }
    $(document).ready( function () {
        var form_height =	$("#left_message_form").outerHeight();
        $("#right_message_form").css("min-height",$("#left_message_form").outerHeight());
        initValue();
        $( ".btn-print" ).click( function ( e ) {

            $( "#page_content" ).printThis( {
                debug: false,
                importCSS: true,
                importStyle: true,
                printContainer: true,
                loadCSS: {},
                pageTitle: "서약자관리 - 상세정보",
                removeInline: false,
                printDelay: 333,
                header: null,
                formValues: true
            } );
        } );
        $( ".search_addr_popup" ).click( function ( e ) {
            selected_post = $(this);
            goAddrPopup();
        });

    });

</script>

<script src="${pageContext.request.contextPath}/home/js/jquery.validate.js"></script>
<script src="${pageContext.request.contextPath}/home/js/additional-methods.js"></script>
<script src="${pageContext.request.contextPath}/home/js/register_form_check.js"></script>
<script>
    function getEnumKey(enum_name, enum_value) {
        var enum_object = enum_array[enum_name];
        var enum_key= 0;
        jQuery.each(enum_object, function(key, val) {
            if(val==enum_value){
                enum_key = key;
                return false;
            }
        });
        return enum_key;
    }
    function check_security_num() {
        if($("#user_social_security_num_1").val().length > 6) {
            var security_num_0 = $("#user_social_security_num_0").val();
            var security_num_1 = $("#user_social_security_num_1").val();
            // Set Birth
            var birth = "";
            var year = "";
            var sex_string = security_num_1.substring(0,1);
            if (sex_string == 3 || sex_string == 4 || sex_string == 7 || sex_string == 8) {
                birth = "20" + security_num_0.substring(0,2);
            } else if (sex_string == 9 || sex_string == 0) {
                birth = "18" + security_num_0.substring(0,2);
            } else {
                birth = "19" + security_num_0.substring(0,2);
            }
            year = birth;
            birth += "." + security_num_0.substring(2,4);
            birth += "." + security_num_0.substring(4,6);
            $("#user_birthday").val(birth);
            // Set Sex
            if(sex_string == 1 || sex_string == 3 || sex_string == 5 || sex_string == 7 || sex_string == 9) {
                $("#user_sex").val("남");
            } else {
                $("#user_sex").val("여");
            }
        }
    }
    $(function(){
        $("#message_form").validate({
            /* focusCleanup:true,*/
            errorClass:"has-error-input",
            errorElement:"p",
            onfocusout: function(element){
                $(element).valid();
            },
            //debug:true,
            rules:{
                user_social_security_num_0:{
                    required:true
                },
                user_social_security_num_1:{
                    required:true
                },
                name_checked:{
                    required:true
                },
                user_mobile_0:{
                    required:true
                },
                user_mobile_1:{
                    required:true,
                    minlength:4
                },
                user_mobile_2:{
                    required:true,
                    minlength:4
                },
                user_post:{
                    required:true
                },
                user_address:{
                    required:true
                },
                user_address_detail:{
                    required:true
                },
                user_send_post:{
                    required:true
                },
                user_send_address:{
                    required:true
                },
                user_send_address_detail:{
                    required:true
                },
                user_email_1:{
                    required:true
                },
                user_email_2:{
                    required:true
                },
                user_email_3:{
                    required:true
                },
                user_donation_type_checked:{
                    required:true
                }
            },
            messages: {
                user_social_security_num_0: {
                    required: "주민등록번호 입력해주세요"
                },
                user_social_security_num_1: {
                    required: "주민등록번호 입력해주세요"
                },
                name_checked: {
                    required: "실명확인해주세요"
                },
                user_mobile_0: {
                    required: "핸드폰 전화번호 입력해주세요"
                },
                user_mobile_1: {
                    required: "핸드폰 전화번호 입력해주세요",
                    minlength : "최소 {0}글자이상이어야 합니다"                    
                },
                user_mobile_2: {
                    required: "핸드폰 전화번호 입력해주세요",
                    	minlength : "최소 {0}글자이상이어야 합니다"
                },
                user_post: {
                    required: "우편번호를 입력해주세요"
                },
                user_address: {
                    required: "주소를 입력해주세요"
                },
                user_address_detail: {
                    required: "상세주소를 입력해주세요"
                },
                user_send_post: {
                    required: "송달우편번호를 입력해주세요"
                },
                user_send_address: {
                    required: "송달주소를 입력해주세요"
                },
                user_send_address_detail: {
                    required: "송달상세주소를 입력해주세요"
                },
                user_email_1: {
                    required: "이메일을 입력해주세요"
                },
                user_email_2: {
                    required: "이메일을 입력해주세요"
                },
                user_email_3: {
                    required: "이메일을 입력해주세요"
                },
                user_donation_type_checked: {
                    required: "기증형태 중 최소 1개를 선택바랍니다."
                }
            }

        });
    });
    function checkUserDonationType() {
        var is_organ_checked =  $("#user_donation_type_organ").prop('checked');
        var is_body_checked = $("#user_donation_type_body").prop('checked');
        var is_comea_checked = $("#user_donation_type_comea").prop('checked');
        if (!is_organ_checked && !is_body_checked && !is_comea_checked) {
            $("#user_donation_type_checked").val("");
            $("#user_donation_type_checked-error").css('display', 'block');
        } else {
            $("#user_donation_type_checked").val("1");
            $("#user_donation_type_checked-error").css('display', 'none');
        }
    }
    function checkAdult(jumin1, jumin2) {
        if(jumin1.length == 6) {
            var today = new Date();
            var toyear = parseInt(today.getFullYear());
            var tomonth = parseInt(today.getMonth()) + 1;
            var todate = parseInt(today.getDate());   
            var ntyear = jumin2.substring(0,1);
            var bhyear = 0;

            if (ntyear == 1 || ntyear == 2 || ntyear == 5 || ntyear == 6) {
                bhyear = parseInt('19' + jumin1.substring(0,2));
            } else if (ntyear == 3 || ntyear == 4 || ntyear == 7 || ntyear == 8){
                bhyear = parseInt('20' + jumin1.substring(0,2));
            }

            var bhmonth = parseInt(jumin1.substring(2,4));  
            var bhdate = parseInt(jumin1.substring(4,6));    
            var birthyear = toyear - bhyear;

            if(birthyear < 19) {
                return false;
            } else if (birthyear == 19) {
                if(tomonth < bhmonth) {
                    return false;
                } else if ((tomonth == bhmonth) && (todate < bhdate)) {
                    return false;
                }
            }
            return true;
        }
    }

    $(document).ready(function() {
        $("#user_donation_type_organ").prop('checked', true);
        $("#user_donation_type_body").prop('checked', true);
        $("#user_donation_type_comea").prop('checked', true);

        $("#user_is_driving_license option[value=1]").attr('selected', 'selected');
        $("#user_is_email_agree option[value=1]").attr('selected', 'selected');
        $("#user_is_sms_agree option[value=1]").attr('selected', 'selected');
        $("#user_is_mail_agree option[value=1]").attr('selected', 'selected');

        $("#user_donation_type_checked").val("1");

        $("#same_address_btn").click(function(e) {
            var check_state = $(this).is(":checked");
            if(check_state == true) {
                $("#user_send_post").val($("#user_post").val());
                $("#user_send_address").val($("#user_address").val());
                $("#user_send_address_detail").val($("#user_address_detail").val());
            }else{
				 $("#user_send_post").val("");
				 $("#user_send_address").val("");
				 $("#user_send_address_detail").val("");
			}
        });
        $("#user_email_3").on('change', function () {
            if ($(this).val() == '직접입력') {
                $("#user_email_2").val("");
                $("#user_email_2").parent().removeAttr("hidden");
            } else if ($(this).val() == '') {
                $("#user_email_2").val("");
                $("#user_email_2").parent().attr("hidden", "hidden");
            } else {
                $("#user_email_2").val($(this).val());
                $("#user_email_2").parent().attr("hidden", "hidden");
            }
        });
        var user_email_2 = $("#user_email_2").val();
        var user_email_key = getEnumKey('user_email', user_email_2);
        if(user_email_2 != "") {
            if(user_email_key == 0) {
                $("#user_email_3").val("직접입력").change();
                $("#user_email_2").val(user_email_2);
            } else {
                $("#user_email_3").val(user_email_2).change();
            }
        }

        // on Security2 Input Changed
        $("#user_social_security_num_0").unbind('keydown keyup');
        $("#user_social_security_num_0").bind('keydown keyup', function() {
            check_security_num();
        });
        $("#user_social_security_num_1").unbind('keydown keyup');
        $("#user_social_security_num_1").bind('keydown keyup', function() {
            check_security_num();
        });

        // prevent enter
        $(window).keydown(function(event){
            if(event.keyCode == 13) {
                event.preventDefault();
                return false;
            }
        });

        // on donation checkbox clicked
        $(".donation_checkbox").change(function() {
            checkUserDonationType();
        });


        $(".number_only1").keyup(function(){  

            $(this).val($(this).val().replace(/\D|^/g,''));  

            }).bind("paste",function(){  

            $(this).val($(this).val().replace(/\D|^/g,''));  

        }).css("number_only1", "disabled");

        $(".number_only2").keyup(function(){  

            $(this).val($(this).val().replace(/\D|^0/g,''));  

        }).bind("paste",function(){  

            $(this).val($(this).val().replace(/\D|^0/g,''));  

        }).css("number_only2", "disabled");



        $("#btn_name_check").click(function(e) {
        	if($.trim($("#user_social_security_num_0").val()) == "" || $.trim($("#user_social_security_num_0").val()).length == 0) {
        		alert("주민등록번호를 입력해주세요.");
        		return false;        		
        	} else if($.trim($("#user_social_security_num_0").val()).length < 6) {
        		alert("주민등록번호를 정확히 입력해주세요.");
        		return flase;
        	}
        	if($.trim($("#user_social_security_num_1").val()) == "" || $.trim($("#user_social_security_num_1").val()).length == 0) {
        		alert("주민등록번호를 입력해주세요.");
        		return false;        		
        	} else if($.trim($("#user_social_security_num_1").val()).length < 7) {
        		alert("주민등록번호를 정확히 입력해주세요.");
        		return flase;
        	}
            var isAdult = checkAdult($("#user_social_security_num_0").val(), $("#user_social_security_num_1").val());
            if(isAdult == false) {
                alert('성인이 아닙니다. 온라인상으로는 성인만 서약하기가 가능합니다.');
                return false;
            }
            var str_name = $("#user_name").val();
            var str_jumin = $("#user_social_security_num_0").val() + $("#user_social_security_num_1").val();
            $.ajax({
                url: "<c:url value='/pledge/getNameCheckResultAjax.do'/>",
                dataType: "json",
                type: 'post',
                data: {
                    'str_name': str_name,
                    'str_jumin': str_jumin
                },
                success: function(data) {
                	//var parsedData = $.parseJSON(data);
                    if(data != null && data.rtnCode == "") {
	                    var parsedData = data.checkResult;
	                    if(parsedData == '1'){
	                        // 주민번호 일치
	                        $("#btn_name_check").hide();
	                        $("#name_check_true").removeClass('sr-only');
	                        $("#name_checked").val("1");
	                        $("#user_social_security_num_0").prop('readonly', true);
	                        $("#user_social_security_num_1").prop('readonly', true);
	                        $("#name_checked-error").css('display', 'none');
	                    } else if(parsedData == '2') {
	                        // 본인 아님
	                        // 이동 : http://www.namecheck.co.kr/per_callcenter.asp
	                        alert('본인 아님. http://www.namecheck.co.kr/per_callcenter.asp');
	                    } else if(parsedData == '3') {
	                        //  자료 없음
	                        // 이동 : http://www.namecheck.co.kr/per_callcenter.asp
	                        alert('시스템에 등록된 주민번호 없음. http://www.namecheck.co.kr/per_callcenter.asp');
	                    } else if(parsedData == '4') {
	                        // 시스템 장애
	                        alert('시스템 장애 Code:4. 잠시 후 다시 해주시기 바랍니다.');
	                    } else if(parsedData == '5') {
	                        // 주민번호 오류
	                    	alert('주민번호가 올바르게 입력되지 않았습니다.');
	                    } else if(parsedData == '6') {
	                        // 미성년자
	                        alert('미성년자입니다. 상담번호로 문의바랍니다.');
	                    } else if(parsedData == '9') {
	                        // 데이터 오류
	                        alert('주민번호가 올바르게 입력되지 않았습니다.');
	                    } else if(parsedData == 'duplicated') {
	                        // 기존 회원과 주민번호 일치
	                        alert('이미 서약되어 있습니다. 상담번호로 문의바랍니다.');
	                    } else {
	                        // 시스템 장애
	                        alert('시스템 장애 Code:'+parsedData+' 잠시 후 다시 해주시기 바랍니다.');
	                    }
                    } else {
                    	//alert(data.rtnMsg);
                    	alert('주민번호가 올바르게 입력되지 않았습니다.');
                    }
                },
                error: function(xhr, desc, err) {
                    alert('실명체크중 오류가 발생했습니다. 잠시후에 다시 해주시기 바랍니다.')
                }
            });
        });
    });
</script>
