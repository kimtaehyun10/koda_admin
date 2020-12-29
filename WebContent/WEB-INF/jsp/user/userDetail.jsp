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
<div id="page_content" class="page-content-wrapper" >
    <!-- BEGIN CONTENT BODY -->
    <div class="page-content">    	
        <c:if test="${ !empty user_detail }">
        <form role="form" name="user_form" id="user_form" class="form-horizontal" enctype="multipart/form-data" action="<c:url value='/user/update.do'/>" method="post">
        <input id="user_index" name="user_index" type="hidden" value="${user_detail.user_index}">
        </c:if>
        <c:if test="${ empty user_detail }">
        <form role="form" name="user_form" id="user_form" class="form-horizontal" enctype="multipart/form-data" action="<c:url value='/user/addUser.do'/>" method="post">
        </c:if>
        <c:if test="${ !empty ipin_result_data }">
            <input name="ipin_result_index" type="hidden" value="${ipin_result_data.ipin_result_index}">
            <input name="ipin_vno" type="hidden" value="${ipin_result_data.strVno}">
            <input name="ipin_dup_info" type="hidden" value="${ipin_result_data.strDupInfo}">
        </c:if>
        <c:if test="${ !empty checkplus_result_data }">        
            <input name="checkplus_result_index" type="hidden" value="${checkplus_result_data.checkplus_result_index}">
            <input name="checkplus_dupinfo" type="hidden" value="${checkplus_result_data.dupinfo}">
            <input name="checkplus_conninfo" type="hidden" value="${checkplus_result_data.conninfo}">
        </c:if>
            <input id="is_here_after_save" name="is_here_after_save" type="hidden" value="0"/>
        <!-- BEGIN PAGE HEADER-->
        <!-- BEGIN PAGE TITLE-->
        <div class="row">
            <div class="col-md-7">            	
            	<c:choose>
	            	<c:when test="${ !empty user_detail.user_num}">
	                <h1 class="page-title"> 등록자관리 - 상세정보</h1>
	                </c:when>
                <c:otherwise>
                	<h1 class="page-title"> 등록자 직접추가</h1>
                </c:otherwise></c:choose>
            </div>
            <div class="col-md-5">
                <button type="button" id="save_button" class="btn btn-sm btn-circle green page-title-element hidden-print">저장</button>
                <button type="button" class="btn btn-sm btn-circle blue btn-outline page-title-element btn-print hidden-print">인쇄</button>
                <c:if test="${ !empty user_detail}">
                <button type="button" id="withdraw_button" class="btn btn-sm btn-circle green btn-outline page-title-element hidden-print">탈퇴하기</button>
                </c:if>
            </div>
        </div>
        <!-- END PAGE TITLE-->
        <!-- END PAGE HEADER-->
        <input id="status" name="status" type="hidden" value="1">
        <div class="row">
            <div class="col-md-12">
                <div class="portlet box blue-hoki ">
                    <div class="portlet-title">
                        <div class="caption">인적사항</div>
                    </div>
                    <div class="portlet-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="col-md-3 control-label">등록번호</label>
                                    <div class="col-md-9">
                                        <input id="user_num" name="user_num" type="text" class="form-control input-sm" placeholder="" value="${user_detail.user_num}" readonly="readonly">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-3 control-label">성명</label>
                                    <div class="col-md-9">
                                    	<c:set var="user_name" value=""/>
                                    	<c:choose><c:when test="${ !empty user_detail }"><c:set var="user_name" value="${user_detail.user_name}"/></c:when>
                                    	<c:when test="${ !empty ipin_result_data }"><c:set var="user_name" value="${ipin_result_data.strUserName}"/></c:when>
                                    	<c:when test="${ !empty checkplus_result_data }"><c:set var="user_name" value="${checkplus_result_data.name}"/></c:when>
                                    	</c:choose>
                                        <input id="user_name" name="user_name" type="text" class="form-control input-sm" placeholder=""
                                               value="${user_name}">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-3 control-label">주민등록번호</label>
                                    <div class="col-md-7">
                                    <c:set var="user_social_security_num" value="${fn:split(user_detail.user_social_security_num, '-')}"/>
                                        <div class="col-md-5 col zero-padding">
                                            <input id="user_social_security_num_0" name="user_social_security_num_0" type="text" name="phone" class="form-control input-sm" size="6" maxlength="6" title="" value="${user_social_security_num[0]}">
                                        </div>
                                        <div class="col-md-2 text-align-center" style="margin-top: 5px;">
                                            -
                                        </div>
                                        <div class="col-md-5 col zero-padding">
                                            <input id="user_social_security_num_1" name="user_social_security_num_1" type="password" name="text" class="form-control input-sm" size="7" maxlength="7" title="" value="${user_social_security_num[1]}">
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <button id="btn_name_check" type="button" class="btn blue">실명확인</button>
                                        <label id="name_check_true" class="sr-only" style="margin-top: 6px;"><i class="fa fa-check"></i> 확인됨</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-3 control-label">생년월일</label>
                                    <div class="col-md-9">
                                    	<c:set var="user_birthday" value=""/>
                                    	<c:choose><c:when test="${user_detail.user_birthday != ''}"><c:set var="user_birthday" value="${user_detail.user_birthday}"/></c:when>
                                    	<c:when test="${ipin_result_data.strBirthDate != ''}"><c:set var="user_birthday" value="${ipin_result_data.strBirthDate}"/></c:when>
                                    	<c:when test="${checkplus_result_data.birthdate != ''}"><c:set var="user_birthday" value="${checkplus_result_data.birthdate}"/></c:when>
                                    	<c:otherwise><c:set var="user_birthday" value=""/></c:otherwise>
                                    	</c:choose>
                                        <input id="user_birthday" name="user_birthday" type="text" size="10" id="" class="input-sm form_datetime form-control" value="${user_birthday}">
                                    </div>
                                </div>
                                <div class="form-group phone-number">
                                    <label class="col-md-3 control-label">휴대전화</label>
                                    <c:set var="user_mobile" value="${fn:split(user_detail.user_mobile, '-')}"/>
                                    <div class="col-md-9">
                                        <div class="col-md-3 col zero-padding print-col-md-3">
                                            <input id="user_mobile_0" name="user_mobile_0" type="tel" name="phone" class="form-control input-sm" size="3" maxlength="3" title="" value="${user_mobile[0]}">
                                        </div>
                                        <div class="col-md-1 text-align-center print-col-md-1" style="margin-top: 5px; padding-left:13px;">
                                            -
                                        </div>
                                        <div class="col-md-3 col zero-padding print-col-md-3">
                                            <input id="user_mobile_1" name="user_mobile_1" type="tel" name="phone" class="form-control input-sm" size="4" maxlength="4" title="" value="${user_mobile[1]}">
                                        </div>
                                        <div class="col-md-1 text-align-center print-col-md-1" style="margin-top: 5px; padding-left:13px;">
                                            -
                                        </div>
                                        <div class="col-md-4 col zero-padding print-col-md-4">
                                            <input id="user_mobile_2" name="user_mobile_2" type="tel" name="phone" class="form-control input-sm" size="4" maxlength="4" title="" value="${user_mobile[2]}">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <h5 class="col-md-3 ">기본주소</h5>
                                </div>
                                <div class="portlet_inner_group">
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">우편번호</label>
                                        <div class="col-md-7">
                                            <input id="user_post" name="user_post" type="text" class="form-control input-sm input_post" placeholder="" value="${user_detail.user_post}">                                        	
                                        </div>
                                        <div class="col-md-2">                                            
                                        	<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호" class="btn blue">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">주소</label>
                                        <div class="col-md-9">
                                            <input id="user_address" name="user_address" type="text" class="form-control input-sm input_address" placeholder="" value="${user_detail.user_address}">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">상세주소</label>
                                        <div class="col-md-9">
                                            <input id="user_address_detail" name="user_address_detail" type="text" class="form-control input-sm input_address_detail" placeholder="" value="${user_detail.user_address_detail}">
                                        </div>
                                    </div>                                   
									<input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
                                </div>
                                <div class="form-group">
                                    <h5 class="col-md-2 ">송달주소</h5>
                                    <div class="col-md-1">
                                        <label class="mt-checkbox" style="padding-top: 5px;">
                                            <input id="same_address_btn" name="same_address_btn" type="checkbox" class="input-sm" value="1"><span></span>
                                        </label>
                                    </div>
                                    <label class="col-md-9 control-label text-align-left" style="padding-top: 10px;">기본주소와 같은 경우 버튼을 눌러주세요</label>
                                </div>
                                <div class="portlet_inner_group">
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">우편번호</label>
                                        <div class="col-md-9">
                                            <input id="user_send_post" name="user_send_post" type="text" class="form-control input-sm input_post" placeholder="" value="${user_detail.user_send_post}">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">주소</label>
                                        <div class="col-md-9">
                                            <input id="user_send_address" name="user_send_address" type="text" class="form-control input-sm input_address" placeholder="" value="${user_detail.user_send_address}">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">상세주소</label>
                                        <div class="col-md-9">
                                            <input id="user_send_address_detail" name="user_send_address_detail" type="text" class="form-control input-sm input_address_detail" placeholder="" value="${user_detail.user_send_address_detail}">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /.col-md-6 -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="col-md-3 control-label">나이</label>
                                    <div class="col-md-9">
                                        <input id="user_age" name="user_age" type="number" class="form-control input-sm" placeholder="" value="${user_detail.user_age}" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-3 control-label">성별</label>
                                    <div class="col-md-9">
                                        <select id="user_sex" name="user_sex" class="form-control input-sm">
                                        	<c:forEach var="value" items="${enum_array.user_sex}" varStatus="status">
                                            <c:set var="selected" value=""/>
												<c:if test="${ !empty user_detail }">
                                                    <c:if test="${user_detail.user_sex != ''}">                                                        
                                                       	<c:if test="${user_detail.user_sex == status.index}">                                                            
                                                        	<c:set var="selected" value="selected"/>
                                                        </c:if>
                                                    </c:if>
                                                </c:if>
                                                <c:if test="${ !empty ipin_result_data }">
                                                    <c:if test="${ipin_result_data.strGender != ''}">                                                        
                                                       	<c:if test="${ipin_result_data.strGender == status.index}">                                                            
                                                        	<c:set var="selected" value="selected"/>
                                                        </c:if>
                                                    </c:if>
                                                </c:if>
                                                <c:if test="${ !empty checkplus_result_data }">
                                                    <c:if test="${checkplus_result_data.gender != ''}">                                                        
                                                       	<c:if test="${checkplus_result_data.gender == status.index}">                                                            
                                                        	<c:set var="selected" value="selected"/>
                                                        </c:if>
                                                    </c:if>
                                                </c:if>
                                            <option value="${status.index}" ${selected}>${value}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group phone-number">
                                    <label class="col-md-3 control-label">집전화</label>
                                    <c:set var="user_phone" value="${fn:split(user_detail.user_phone, '-')}"/>
                                    <div class="col-md-9">
                                        <div class="col-md-3 col zero-padding print-col-md-3">
                                            <input id="user_phone_0" name="user_phone_0" type="tel" name="phone" class="form-control input-sm" size="4" maxlength="4" title="" value="${user_phone[0]}">
                                        </div>
                                        <div class="col-md-1 text-align-center print-col-md-1" style="margin-top: 5px; padding-left:13px;">
                                            -
                                        </div>
                                        <div class="col-md-3 col zero-padding print-col-md-3">
                                            <input id="user_phone_1" name="user_phone_1" type="tel" name="phone" class="form-control input-sm" size="4" maxlength="4" title="" value="${user_phone[1]}">
                                        </div>
                                        <div class="col-md-1 text-align-center print-col-md-1" style="margin-top: 5px; padding-left:13px;">
                                            -
                                        </div>
                                        <div class="col-md-4 col zero-padding print-col-md-4">
                                            <input id="user_phone_2" name="user_phone_2" type="tel" name="phone" class="form-control input-sm" size="4" maxlength="4" title="" value="${user_phone[2]}">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-3 control-label">이메일</label>
                                    <c:set var="user_email" value="${fn:split(user_detail.user_email, '@')}"/>
                                    <div class="col-md-9">
                                        <div class="col-md-3 col zero-padding">
                                            <input id="user_email_1" name="user_email_1" type="text" class="form-control input-sm" placeholder="" value="${user_email[0]}">
                                        </div>
                                        <div class="col-md-1 col zero-padding text-center" style="height:28px; margin-top:5px;">
                                            @
                                        </div>
                                        <div class="col-md-4 col zero-padding" hidden>
                                            <input id="user_email_2" name="user_email_2" type="text" class="form-control input-sm" placeholder="" value="${user_email[1]}">
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
                                    </div>
                                </div>
                                <br>
                                <div class="form-group">
                                    <label class="col-md-3 control-label important-form-mark">법정대리인 정보</label>
                                    <div class="col-md-9">
                                        <%-- <input id="user_legal_representative_info" name="user_legal_representative_info" type="text" class="form-control input-sm" placeholder="" value="${user_detail.user_legal_representative_info}"> --%>
                                    	<select id="user_legal_representative_info" name="user_legal_representative_info" class="form-control input-sm">
                                    	    <option value="" ></option>                                    	
                                        	<option value="부" ${user_detail.user_legal_representative_info eq '부'?'selected':''}>부</option>
                                        	<option value="모" ${user_detail.user_legal_representative_info eq '모'?'selected':''}>모</option>
                                        	<option value="조부모" ${user_detail.user_legal_representative_info eq '조부모'?'selected':''}>조부모</option>
                                        	<option value="형제" ${user_detail.user_legal_representative_info eq '형제'?'selected':''}>형제</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group" hidden>
                                    <label class="col-md-3 control-label important-form-mark">법정대리인 증명서류</label>
                                    <div class="col-md-9">
                                        <label class="mt-checkbox" style="margin-top: 8px;">&nbsp
                                        	<%-- <c:set var="checked" value=""/>
                                        	<c:if test="${user_detail.user_is_legal_representative_text != ''}"><c:set var="checked" value="checked"/></c:if> --%>
                                            <input id="user_is_legal_representative_text" name="user_is_legal_representative_text" type="checkbox" class="input-sm" value="1" ${user_detail.user_is_legal_representative_text == 1?"checked":""}><span></span>
                                        </label>
                                    </div>
                                </div>                                                                                                                               
			                	<div class="form-group">
                                    <label class="col-md-3 control-label important-form-mark">첨부파일</label>
                                    <div class="col-md-9">
                                    	<a href="/user/fileDownload.do?org_file_name=${userAttach.org_file_name}&re_file_name=${userAttach.re_file_name}">${userAttach.org_file_name}</a>
                                    	<input type="file" id="org_file_name" name="org_file_name" onchange="fileYN();">
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
        <div class="row">
            <div class="col-md-6">
                <div class="portlet box blue-hoki ">
                    <div class="portlet-title">
                        <div class="caption">등록정보</div>
                    </div>
                    <div class="portlet-body" style="height:333px;">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="col-md-6 control-label important-form-mark">등록구분</label>
                                    <div class="col-md-6">
                                        <select id="user_recognize_type" name="user_recognize_type" class="form-control input-sm">                                        	
                                        	<c:forEach var="value" items="${enum_array.user_recognize_type}" varStatus="status">
                                        	<c:set var="selected" value=""/>
                                            	<c:if test="${user_detail.user_recognize_type != ''}">
                                            		<c:if test="${user_detail.user_recognize_type == status.index}">
                                               		<c:set var="selected" value="selected"/>
                                               		</c:if>
                                               	</c:if>
                                               	<option value="${status.index}" ${selected}>${value}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6 control-label mt-checkbox">기증형태</label>
                                    <div class="col-md-6">
                                    	<c:set var="checked" value=""/>
                                        <c:if test="${user_detail.user_donation_type_organ != ''}"><c:set var="checked" value="checked"/></c:if>
                                        <label class="mt-checkbox" style="margin-top: 8px;">기증형태_장기
                                            <input id="user_donation_type_organ" name="user_donation_type_organ" type="checkbox" class="input-sm" value="1" ${checked}><span></span>
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6 control-label mt-checkbox"></label>
                                    <div class="col-md-6">
                                    	<c:set var="checked" value=""/>
                                        <c:if test="${user_detail.user_donation_type_body != ''}"><c:set var="checked" value="checked"/></c:if>
                                        <label class="mt-checkbox" style="margin-top: 8px;">기증형태_조직
                                            <input id="user_donation_type_body" name="user_donation_type_body" type="checkbox" class="input-sm" value="1" ${checked}><span></span>
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6 control-label mt-checkbox"></label>
                                    <div class="col-md-6">
                                    	<c:set var="checked" value=""/>
                                        <c:if test="${user_detail.user_donation_type_comea != ''}"><c:set var="checked" value="checked"/></c:if>
                                        <label class="mt-checkbox" style="margin-top: 8px;">기증형태_각막
                                            <input id="user_donation_type_comea" name="user_donation_type_comea" type="checkbox" class="input-sm" value="1" ${checked}><span></span>
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6 control-label">운전면허증 표시</label>
                                    <div class="col-md-6">
                                        <select id="user_is_driving_license" name="user_is_driving_license" class="form-control input-sm">
                                        	<c:forEach var="value" items="${enum_array.user_is_driving_license}" varStatus="status">
                                        	<c:set var="selected" value=""/>
                                            	<c:if test="${user_detail.user_is_driving_license != ''}">
                                            		<c:if test="${user_detail.user_is_driving_license == status.index}">
                                               		<c:set var="selected" value="selected"/>
                                               		</c:if>
                                               	</c:if>
                                               	<option value="${status.index}" ${selected}>${value}</option>
                                            </c:forEach>                                           
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group" hidden>
                                    <label class="col-md-6 control-label important-form-mark">Konos 등록상태</label>
                                    <div class="col-md-6">
                                        <select id="user_konos_register_state" name="user_konos_register_state" class="form-control input-sm">
                                        	<c:forEach var="value" items="${enum_array.user_konos_register_state}" varStatus="status">
                                        	<c:set var="selected" value=""/>
                                            	<c:if test="${user_detail.user_konos_register_state != ''}">
                                            		<c:if test="${user_detail.user_konos_register_state == status.index}">
                                               		<c:set var="selected" value="selected"/>
                                               		</c:if>
                                               	</c:if>
                                               	<option value="${status.index}" ${selected}>${value}</option>
                                            </c:forEach>                                                                                             
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group" hidden>
                                    <label class="col-md-6 control-label">서약일</label>
                                    <div class="col-md-6">
                                        <input id="user_pledge_date" name="user_pledge_date" type="text" size="10" id="" class="input-sm form_datetime form-control" value="${user_detail.user_pledge_date}">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6 control-label important-form-mark">등록일</label>
                                    <div class="col-md-6">
                                        <input id="user_registration_date" name="user_registration_date" type="text" size="10" id="" class="input-sm form_datetime form-control" value="${user_detail.user_registration_date}">
                                    </div>
                                </div>
                                <div class="form-group" hidden>
                                    <label class="col-md-6 control-label important-form-mark">Konos 등록일</label>
                                    <div class="col-md-6">
                                        <input id="user_konos_registration_date" name="user_konos_registration_date" type="text" size="10" id="" class="input-sm form_datetime form-control" value="${user_detail.user_konos_registration_date}">
                                    </div>
                                </div>
                            </div>
                            <!-- /.col-md-6 -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="col-md-6 control-label important-form-mark">담당자</label>
                                    <div class="col-md-6">
                                        <input id="user_register" name="user_register" type="text" class="form-control input-sm" placeholder="" value="${user_detail.user_register}">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6 control-label important-form-mark">등록 분류</label>
                                    <div class="col-md-6">
                                        <select id="user_register_channel" name="user_register_channel" class="form-control input-sm">
                                        	<c:forEach var="value" items="${enum_array.user_register_channel}" varStatus="status">
                                        	<c:set var="selected" value=""/>
                                            	<c:if test="${user_detail.user_register_channel != ''}">
                                            		<c:if test="${user_detail.user_register_channel == status.index}">
                                               		<c:set var="selected" value="selected"/>
                                               		</c:if>
                                               	</c:if>
                                               	<option value="${status.index}" ${selected}>${value}</option>
                                            </c:forEach>                                            
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6 control-label important-form-mark">취소일</label>
                                    <div class="col-md-6">
                                        <input id="user_withdraw_date" name="user_withdraw_date" type="text" size="10" id="" class="input-sm form_datetime form-control" value="${user_detail.user_withdraw_date}">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6 control-label important-form-mark">취소사유</label>
                                    <div class="col-md-6">
                                        <select id="user_withdraw_reason" name="user_withdraw_reason" class="form-control input-sm">
                                        	<c:forEach var="value" items="${enum_array.user_withdraw_reason}" varStatus="status">
                                        	<c:set var="selected" value=""/>
                                            	<c:if test="${user_detail.user_withdraw_reason != ''}">
                                            		<c:if test="${user_detail.user_withdraw_reason == status.index}">
                                               		<c:set var="selected" value="selected"/>
                                               		</c:if>
                                               	</c:if>
                                               	<option value="${status.index}" ${selected}>${value}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6 control-label important-form-mark">가입경로</label>
                                    <div class="col-md-6">
                                        <select id="user_withdraw_way" name="user_withdraw_way" class="form-control input-sm">
                                        	<c:forEach var="value" items="${enum_array.user_withdraw_way}" varStatus="status">
                                        	<c:set var="selected" value=""/>
                                            	<c:if test="${user_detail.user_withdraw_way != ''}">
                                            		<c:if test="${user_detail.user_withdraw_way == status.index}">
                                               		<c:set var="selected" value="selected"/>
                                               		</c:if>
                                               	</c:if>
                                               	<option value="${status.index}" ${selected}>${value}</option>                                               	
                                            </c:forEach>                                               
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group" hidden>
                                    <label class="col-md-6 control-label important-form-mark">Konos 탈퇴일</label>
                                    <div class="col-md-6">
                                        <input id="user_konos_withdraw_date" name="user_konos_withdraw_date" type="text" size="10" id="" class="input-sm form_datetime form-control" value="${user_detail.user_konos_withdraw_date}">
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
                <div class="portlet box blue-hoki ">
                    <div class="portlet-title">
                        <div class="caption">정보수신동의 및 발송현황</div>
                    </div>
                    <div class="portlet-body" style="height:333px;">                    	
                        <div class="row">
                            <div class="col-md-6">                            	
                           		<div class="form-group">
                                    <label class="col-md-6 control-label">정보수신 일괄 동의</label>
                                    <div class="col-md-6">
                                        <label class="mt-checkbox" style="margin-top: 8px;">&nbsp
											<input id="user_agree_all" name="user_agree_all" type="checkbox" class="input-sm" value="1"><span></span>
										</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6 control-label">이메일동의</label>
                                    <div class="col-md-6">
                                        <select id="user_is_email_agree" name="user_is_email_agree" class="form-control input-sm">
                                        	<c:forEach var="value" items="${enum_array.user_is_email_agree}" varStatus="status">
                                        	<c:set var="selected" value=""/>
                                            	<c:if test="${user_detail.user_is_email_agree != ''}">
                                            		<c:if test="${user_detail.user_is_email_agree == status.index}">
                                               		<c:set var="selected" value="selected"/>
                                               		</c:if>
                                               	</c:if>
                                               	<option value="${status.index}" ${selected}>${value}</option>
                                            </c:forEach>                                            
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6 control-label">문자동의</label>
                                    <div class="col-md-6">
                                        <select id="user_is_sms_agree" name="user_is_sms_agree" class="form-control input-sm">
                                        	<c:forEach var="value" items="${enum_array.user_is_sms_agree}" varStatus="status">
                                        	<c:set var="selected" value=""/>
                                            	<c:if test="${user_detail.user_is_sms_agree != ''}">
                                            		<c:if test="${user_detail.user_is_sms_agree == status.index}">
                                               		<c:set var="selected" value="selected"/>
                                               		</c:if>
                                               	</c:if>
                                               	<option value="${status.index}" ${selected}>${value}</option>
                                            </c:forEach>                                           
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6 control-label">우편동의</label>
                                    <div class="col-md-6">
                                        <select id="user_is_mail_agree" name="user_is_mail_agree" class="form-control input-sm">
                                        	<c:forEach var="value" items="${enum_array.user_is_mail_agree}" varStatus="status">
                                        	<c:set var="selected" value=""/>
                                            	<c:if test="${user_detail.user_is_mail_agree != ''}">
                                            		<c:if test="${user_detail.user_is_mail_agree == status.index}">
                                               		<c:set var="selected" value="selected"/>
                                               		</c:if>
                                               	</c:if>
                                               	<option value="${status.index}" ${selected}>${value}</option>
                                            </c:forEach>                                            
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6 control-label important-form-mark">등록카드</label>
                                    <div class="col-md-6">
                                        <select id="user_pledge_card_state" name="user_pledge_card_state" class="form-control input-sm">
                                        	<c:forEach var="value" items="${enum_array.user_pledge_card_state}" varStatus="status">
                                        	<c:set var="selected" value=""/>
                                            	<c:if test="${user_detail.user_pledge_card_state != ''}">
                                            		<c:if test="${user_detail.user_pledge_card_state == status.index}">
                                               		<c:set var="selected" value="selected"/>
                                               		</c:if>
                                               	</c:if>
                                               	<option value="${status.index}" ${selected}>${value}</option>
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
        <div class="row">
            <div class="col-md-12">
                <div class="portlet box blue-hoki ">
                    <div class="portlet-title">
                        <div class="caption">상담정보</div>
                    </div>
                    <div class="portlet-body">
                        <div class="row">
                            <div class="col-md-12">
                                <h5 class="form-title-line">신규상담</h5>
                                <div class="form-group">
                                    <label class="col-md-1 control-label">상담일시</label>
                                    <div class="col-md-2">
                                        <input id="new_consult_date" name="consult_date" type="text" size="10" id="" class="input-sm form_datetime form-control" >
                                    </div>
                                    <label class="col-md-1 control-label">상담시간</label>
                                    <div class="col-md-2">
                                        <input id="new_consult_time" name="consult_time" type="text" size="10" id="" class="input-sm form_timemin form-control">
                                    </div>
                                    <label class="col-md-1 control-label">상담항목</label>
                                    <div class="col-md-2">
                                        <select id="new_consult_type" name="consult_type" class="form-control input-sm">
                                        	<c:forEach var="value" items="${enum_array.consult_type}" varStatus="status">                                            
                                                <option value="${status.index}">${value}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <label class="col-md-1 control-label">담당자</label>
                                    <div class="col-md-2">
                                        <input id="new_consult_consultor" name="consult_consultor" type="text" class="form-control input-sm" placeholder="" >
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-1 control-label">상담메모</label>
                                    <div class="col-md-11">
                                        <textarea id="new_consult_memo" name="consult_memo" class="form-control input-sm" rows="5"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-1 control-label">처리결과</label>
                                    <div class="col-md-11">
                                        <textarea id="new_consult_result" name="consult_result" class="form-control input-sm" rows="5"></textarea>
                                    </div>
                                </div>
                                <c:if test="${ !empty user_detail }">
                                <div style="margin-bottom: 60px;">
                                    <button id="btn_save_new_consult" type="button" class="btn btn-sm btn-circle green align-right hidden-print">저장 후 추가하기</button>
                                </div>
                                <h5 class="form-title-line">상담기록</h5>
                                <div id="consult_record_list">
                                </div>
                                </c:if>
                            </div>
                            <!-- /.col-md-6 -->
                        </div>
                        <!-- /.row -->
                    </div>
                    <div class="col-md-12 text-center">
                        <br>
                        <button type="submit" class="btn btn-circle green hidden-print">저장하기</button>
                        <br>&nbsp
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END CONTENT BODY -->
    </form>
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
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script language="JavaScript" type="text/javascript">
	
    // Conversion Data from PHP to Javascript
    <c:choose><c:when test="${ !empty consult_list}">
	var consult_list = ${consult_list};
	</c:when><c:otherwise>
	var consult_list = null;
	</c:otherwise></c:choose>
	
	<c:choose><c:when test="${ !empty enum_array}">
	var enum_array = ${enum_array};
	</c:when><c:otherwise>
	var enum_array = null;
	</c:otherwise></c:choose>	

    var selected_post;

    function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,jibunAddr,zipNo){
    	
        //$("#user_post").val(zipNo);
        //$("#user_address").val(roadAddrPart1);
        //$("#user_address_detail").val(addrDetail);
        selected_post.val(zipNo);
        selected_post.parent().parent().parent().find(".input_address").val(roadAddrPart1);
        selected_post.parent().parent().parent().find(".input_address_detail").val(addrDetail);
        selected_post.parent().parent().parent().find(".input_address").trigger('change');
    }

    function warning_delete() {
        if(confirm('정말 삭제하시겠습니까? ')){
            return true;
        } else {
            return false;
        }
    }

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

    // location='front' or 'last'
    function showConsultRecord(consult, location) {

        var consult_type_option_html = "";
        jQuery.each(enum_array.consult_type, function(key, val) {
            if (consult.consult_type == key) {
                consult_type_option_html += '<option value="'+key+'" selected>'+val+'</option>';
            } else {
                consult_type_option_html += '<option value="'+key+'">'+val+'</option>';
            }
        });

        var consult_record_html =
            '<div class="consult_record">' +
                '<div class="form-group">' +
                    '<label class="col-md-1 control-label">상담일시</label>' +
                    '<div class="col-md-2">' +
                        '<input name="record_consult_date" type="text" size="10" id="" class="input-sm form_datetime form-control" >' +
                    '</div>' +
                    '<label class="col-md-1 control-label">상담시간</label>' +
                    '<div class="col-md-2">' +
                        '<input name="record_consult_time" type="text" size="10" id="" class="input-sm form_timemin form-control" >' +
                    '</div>' +
                    '<label class="col-md-1 control-label">상담분류</label>' +
                    '<div class="col-md-2">' +
                        '<select name="record_consult_type" class="form-control input-sm">' +
                            consult_type_option_html +
                        '</select>' +
                    '</div>' +
                    '<label class="col-md-1 control-label">담당자</label>' +
                    '<div class="col-md-2">' +
                        '<input name="record_consult_consultor" type="text" class="form-control input-sm" placeholder="">' +
                    '</div>' +
                '</div>' +
                '<div class="form-group">' +
                    '<label class="col-md-1 control-label">상담메모</label>' +
                    '<div class="col-md-11">' +
                        '<textarea name="record_consult_memo" class="form-control input-sm" rows="5"></textarea>' +
                    '</div>' +
                '</div>' +
                '<div class="form-group">' +
                    '<label class="col-md-1 control-label">처리결과</label>' +
                    '<div class="col-md-11">' +
                        '<textarea name="record_consult_result" class="form-control input-sm" rows="5"></textarea>' +
                    '</div>' +
                '</div>' +
                '<div class="col-md-12 text-center consult_record_bottom">' +
                    '<button type="button" class="btn btn-sm btn-circle green btn_save_record_consult hidden-print">수정</button>' +
                    '<button type="button" class="btn btn-sm btn-circle red btn_cancel_record_consult hidden-print">Cancel</button>' +
                '</div>' +
            '</div>';
        var consult_record_object;
        if(location == 'first') {
            consult_record_object = $('#consult_record_list').prepend(consult_record_html)
        } else if (location == 'last') {
            consult_record_object = $('#consult_record_list').append(consult_record_html)
        }

        initDateForm();
        // Init consult record value 
        if(consult_record_object) {
            consult_record_object.find('.consult_record:'+location).attr('consult_index', consult.consult_index);
            consult_record_object.find('.consult_record:'+location+' input[name=record_consult_date]').val(consult.consult_date);
            consult_record_object.find('.consult_record:'+location+' input[name=record_consult_time]').val(consult.consult_time);
            consult_record_object.find('.consult_record:'+location+' select[name=record_consult_type]').val(consult.consult_type);
            consult_record_object.find('.consult_record:'+location+' input[name=record_consult_consultor]').val(consult.consult_consultor);
            consult_record_object.find('.consult_record:'+location+' textarea[name=record_consult_memo]').val(consult.consult_memo);
            consult_record_object.find('.consult_record:'+location+' textarea[name=record_consult_result]').val(consult.consult_result);
        }

        $(".btn_save_record_consult").unbind('click');
        $(".btn_save_record_consult").click(function(e) {
            var data_ajax = {
                'user_index': $("#user_index").val(),
                'consult_index': $(this).parent().parent().attr('consult_index'),
                'consult_date': $(this).parent().parent().find('input[name=record_consult_date]').val(),
                'consult_time': $(this).parent().parent().find('input[name=record_consult_time]').val(),
                'consult_type': $(this).parent().parent().find('select[name=record_consult_type]').val(),
                'consult_consultor': $(this).parent().parent().find('input[name=record_consult_consultor]').val(),
                'consult_memo': $(this).parent().parent().find('textarea[name=record_consult_memo]').val(),
                'consult_result': $(this).parent().parent().find('textarea[name=record_consult_result]').val()
            };
            saveConsultRecordAjax(data_ajax);
        });
        $(".btn_cancel_record_consult").unbind('click');
        $(".btn_cancel_record_consult").click(function(e) {
            var consult_record = $(this).parent().parent();
            var result = warning_delete();
            if (result) {
                $.ajax({
                    url: "<c:url value='/user/deleteConsultAjax.do'/>",
                    type: 'post',
                    dataType: "json",
                    data: {
                        'consult_index': $(this).parent().parent().attr('consult_index')
                    },
                    success: function(data) {                        
                        if(data != null && data.rtnCode == "") {
                        	toastr.success('상담내역이 삭제되었습니다.');
                            toastr.options = {
                                "positionClass": "toast-bottom-center"
                            }
                        	consult_record.remove();
                    	} else {
                    		 alert(data.rtnMsg);
                    	}
                    },
                    error: function(xhr, desc, err) {
                        alert('데이터 삭제가 안됩니다. 잠시후에 다시 해주시기 바랍니다.')
                    }
                });
            }
        });

    }

    function getToday() {
        var today = new Date();

        var today_string = $("#new_consult_date").val();
        if(today_string == "") {
            today_string = today.getFullYear() + "." + pad((today.getMonth() + 1),2) + "." + today.getDate();
        }
        return today_string;
    }

    function saveNewConsultAjax() {
        var today = new Date();

        var today_string = $("#new_consult_date").val();
        if(today_string == "") {
            today_string = today.getFullYear() + "." + pad((today.getMonth() + 1),2) + "." + today.getDate();
        }
        var current_time_string = $("#new_consult_time").val();
        if(current_time_string == "") {
            current_time_string = pad(today.getHours(),2) + ":" + pad(today.getMinutes(),2);
        }

        $.ajax({
            url: "<c:url value='/user/saveConsultAjax.do'/>",
            type: 'post',
            dataType: "json",
            data: {'user_index': $("#user_index").val(),
                'consult_date': today_string,
                'consult_time': current_time_string,
                'consult_type': $("#new_consult_type").val(),
                'consult_consultor': $("#new_consult_consultor").val(),
                'consult_memo': $("#new_consult_memo").val(),
                'consult_result': $("#new_consult_result").val()
            },
            success: function(data) {
            	/*
                var parsedData = $.parseJSON(data);
                if (parsedData) {
                    showConsultRecord(parsedData, 'first');
                    initConsultForm();
                }
                */
                if(data != null && data.rtnCode == "") {	
                	if(data.consult) {
                		showConsultRecord(data.consult, 'first');
                    	initConsultForm();
                	}
            	} else {
            		 alert(data.rtnMsg);
            	}

            },
            error: function(xhr, desc, err) {
                alert('데이터 저장이 안됩니다. 잠시후에 다시 해주시기 바랍니다.')
            }
        });
    }
    function saveConsultRecordAjax(data_ajax) {
        $.ajax({
            url: "<c:url value='/user/saveConsultAjax.do'/>",
            type: 'post',
            dataType: "json",
            data: data_ajax,            
            success: function(data) {
            	/*
                var parsedData = $.parseJSON(data);
                if (parsedData) {
                    toastr.success('수정되었습니다.');
                    toastr.options = {
                        "positionClass": "toast-bottom-center"
                    }
                }
                */
                if(data != null && data.rtnCode == "") {	                
                	toastr.success('상담내역이 수정되었습니다.');
                    toastr.options = {
                        "positionClass": "toast-bottom-center"
                    }
            	} else {
            		 alert(data.rtnMsg);
            	}
            },
            error: function(xhr, desc, err) {
                alert('데이터 저장이 안됩니다. 잠시후에 다시 해주시기 바랍니다.')
            }
        });
    }
    // delete 0
    function pad(n, width) {
        n = n + '';
        return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
    }
    function goAddrPopup(){
    	document.domain = "localhost"; // 나중에 도메인주소 변경하자
    	window.name="jusoPopup";
        // 주소검색을 수행할 팝업 페이지를 호출합니다.
        // 호출된 페이지(jusoPopup_utf8.php)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
        var pop = window.open("<c:url value='/user/openAddrPopup.do'/>","pop","width=570,height=420, scrollbars=yes, resizable=yes");

        // 모바일 웹인 경우, 호출된 페이지(jusoPopup_utf8.php)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
        //var pop = window.open("/jusoPopup_utf8.php","pop","scrollbars=yes, resizable=yes");
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
            // Set Age
            var today = new Date();
            var age = today.getFullYear() - parseInt(year) + 1;
            $("#user_age").val(age);
            // Set Sex
            if(sex_string == 1 || sex_string == 3 || sex_string == 5 || sex_string == 7 || sex_string == 9) {
                $("#user_sex").val("1");
            } else {
                $("#user_sex").val("2");
            }
        }
    }

    function initConsultForm() {
        $("#new_consult_date").val('');
        $("#new_consult_time").val('');
        $("#new_consult_type").val('');
        $("#new_consult_consultor").val('');
        $("#new_consult_memo").val('');
        $("#new_consult_result").val('');
    }
    function initDateForm() {
        $(".form_datetime").datetimepicker({
            autoclose: true,
            isRTL: App.isRTL(),
            format: "yyyy.mm.dd",
            minView: 2,
            maxView: 5,
            fontAwesome: true,
            initialDate: new Date(),
            pickerPosition: (App.isRTL() ? "bottom-right" : "bottom-left")
        });
        $(".form_timemin").datetimepicker({
            autoclose: true,
            isRTL: App.isRTL(),
            format: "hh:ii",
            startView: 0,
            minView: 0,
            maxView: 1,
            fontAwesome: true,
            initialDate: new Date(),
            pickerPosition: (App.isRTL() ? "bottom-right" : "bottom-left")
        });
    }
    function initValue() {
        // user pledge date
        var today = new Date();
        var today_string = today.getFullYear() + "." + pad((today.getMonth() + 1),2) + "." + pad(today.getDate(), 2);
        if($("#user_pledge_date").val() == "") {
            $("#user_pledge_date").val(today_string);
        }
        if($("#user_registration_date").val() == "") {
            $("#user_registration_date").val(today_string);
        }
        // user_recognize_type
        var user_recognize_type_key = getEnumKey('user_recognize_type', '서약자');
        if($("#user_recognize_type").val() == 0) {
            $("#user_recognize_type").val(user_recognize_type_key);
        }
        // user_register_channel
        var user_register_channel_key = getEnumKey('user_register_channel', '온라인');
        if ($("#user_register_channel").val() == 0) {
            $("#user_register_channel").val(user_register_channel_key);
        }
        // consult list
        jQuery.each(consult_list, function(key, consult) {
            showConsultRecord(consult, 'last');
        });
    }
    $(document).ready(function() {
        initDateForm();
        initValue();

        $("#btn_save_new_consult").click(function(e) {
            var user_index = $("#user_index").val();
            if(user_index) {
                saveNewConsultAjax();
            }
        });
        $(".btn-print").click(function(e) {
            $("#page_content").printThis({
                debug: false,
                importCSS: true,
                importStyle: true,
                printContainer: true,
                loadCSS: {
                },
                pageTitle: "서약자관리 - 상세정보",
                removeInline: false,
                printDelay: 333,
                header: null,
                formValues: true
            });
        });
        $("#user_withdraw_date").on('change', function () {
            if ($("#user_withdraw_date").val()) {
                var key = getEnumKey('user_recognize_type', '탈퇴자');
                $("#user_recognize_type").val(key);
            }
        });
        /* $("#user_post").click(function(e) {
        	e.preventDefault();
        	console.log("aaaaaaaa");
            selected_post = $(this);
           	console.log("selected_post", selected_post);
            goAddrPopup();
        }).focus(function(e) {        	
        	if(selected_post == null || selected_post.attr('id') != $(this).attr('id')) {
	        	selected_post = $(this);
	            goAddrPopup();
        	}
        }); */
        
        /* $("#user_send_post").click(function(e) {
            selected_post = $(this);
            goAddrPopup();
        }).focus(function(e) {        	
        	if(selected_post == null || selected_post.attr('id') != $(this).attr('id')) {
	        	selected_post = $(this);
	            goAddrPopup();
        	}
        }); */
        
        $("#user_agree_all").click(function(e) {
        	var check_state = $(this).is(":checked");
            if(check_state == true) {
                $("#user_is_email_agree").val("1");
                $("#user_is_sms_agree").val("1");
                $("#user_is_mail_agree").val("1");
            }
        });        
        $("#same_address_btn").click(function(e) {
            var check_state = $(this).is(":checked");
            if(check_state == true) {
                $("#user_send_post").val($("#user_post").val());
                $("#user_send_address").val($("#user_address").val());
                $("#user_send_address_detail").val($("#user_address_detail").val());
            }
        });
        
        $('#user_address, #user_address_detail').on('change', function() {
        	if($('#same_address_btn').is(":checked")) {
        		$("#user_send_post").val($("#user_post").val());
                $("#user_send_address").val($("#user_address").val());
                $("#user_send_address_detail").val($("#user_address_detail").val());
        	}
        });
        
        $("#user_email_3").on('change', function () {
            if ($(this).val() == '직접입력') {
                $("#user_email_2").val("");
                $("#user_email_2").parent().removeAttr("hidden");

            } else if ($(this).val() == '선택하세요') {
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

        $("#save_button").click(function(e) {
            $("#is_here_after_save").val("1");
            $("#user_form").submit();
        });

        $("#btn_name_check").click(function(e) {
            var str_name = $("#user_name").val();
            var str_jumin = $("#user_social_security_num_0").val() + $("#user_social_security_num_1").val();
            $.ajax({
                url: "<c:url value='/user/getNameCheckResultAjax.do'/>",
                type: 'post',
                dataType: "json",
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
	                        alert('주민번호 오류.');
	                    } else if(parsedData == '6') {
	                        // 미성년자
	                        alert('미성년자.');
	                    } else if(parsedData == '9') {
	                        // 데이터 오류
	                        alert('데이터 오류.');
	                    } else if(parsedData == '21') {
	                        // 데이터 오류
	                        alert('데이터 오류. 입력 주민번호 이상');
	                    } else if(parsedData == '24') {
	                        // 데이터 오류
	                        alert('데이터 오류. 올바르지 않은 주민번호');
	                    } else if(parsedData == '31') {
	                        // 데이터 오류
	                        alert('연결 장애');
	                    } else if(parsedData == '50') {
	                        // 데이터 오류
	                        alert('NICE지키미 정보도용 차단 요청 주민번호');
	                    } else if(parsedData == '55' || parsedData == '56' || parsedData == '57') {
	                        // 데이터 오류
	                        alert('외국인 번호 확인 오류');
	                    } else if(parsedData == '58') {
	                        // 데이터 오류
	                        alert('출입국 관리소 통신 오류');
	                    } else if(parsedData == '901') {
	                        // 데이터 오류
	                        alert('이미 가입되어 있는 회원입니다.');
	                    } else {
	                        // 시스템 장애
	                        alert('시스템 장애 Code:'+parsedData+' 잠시 후 다시 해주시기 바랍니다.');
	                    }
                    } else {
                    	alert(data.rtnMsg);
                    }
                },
                error: function(xhr, desc, err) {
                    alert('실명체크중 오류가 발생했습니다. 잠시후에 다시 해주시기 바랍니다.')
                }
            });
        });

        // 탈퇴하기 버튼
        $("#withdraw_button").click(function(e) {
            // 삭제: 주민등록번호, 생년월일, 나이, 성별, 법정대리인 정보,법정대리인 증명서류, 우편번호, 주소, 상세주소 
            var result = 1;//warning_delete();
            if(result) {
                $("#user_social_security_num_0").val('');
                $("#user_social_security_num_1").val('');
                $("#user_birthday").val('');
                $("#user_age").val('0');
                $("#user_sex").val('0');
                $("#user_legal_representative_info").val('');
                $("#user_is_legal_representative_text").prop('checked', false);
                $("#user_post").val('');
                $("#user_address").val('');
                $("#user_address_detail").val('');
                $("#user_send_post").val('');
                $("#user_send_address").val('');
                $("#user_send_address_detail").val('');
                // 서약구분: 탈퇴자
                $("#user_recognize_type").val('2'); 
                // 탈퇴일: 해당일
                $("#user_withdraw_date").val(getToday());
                // 저장하고 현재 페이지 리로딩
                //$("#is_here_after_save").val("1");
                //$("#user_form").submit();
            }
        });
        
     	// prevent enter
    	$(window).keydown(function(event){
    		if(event.keyCode == 13) {
    			event.preventDefault();
    			return false;
    		}
    	});
     	
     	$('#user_social_security_num_0').on('keyup', function() {
     		if($(this).val().length == 6) {
     			$('#user_social_security_num_1').focus();
     		}
     	});
     	$('#user_mobile_0').on('keyup', function() {
     		if($(this).val().length == 3) {
     			$('#user_mobile_1').focus();
     		}
     	});
     	
     	$('#user_mobile_1').on('keyup', function() {
     		if($(this).val().length == 4) {
     			$('#user_mobile_2').focus();
     		}
     	});
     	
     	$('#user_phone_0').on('keyup', function() {
     		if($(this).val().length == 3) {
     			$('#user_phone_1').focus();
     		}
     	});
     	
     	$('#user_phone_1').on('keyup', function() {
     		if($(this).val().length == 4) {
     			$('#user_phone_2').focus();
     		}
     	});
     	     	
    });
    
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }                
                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){                	
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {                	
                	document.getElementById("sample6_extraAddress").value = '';
                }
				
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('user_post').value = data.zonecode;
                document.getElementById("user_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("user_address_detail").focus();
            }
        }).open();
    }
    function fileYN(){    	
    	if(!$("#org_file_name").val()){    		
    		$("#user_is_legal_representative_text").removeAttr("checked");
    	}else{
    		$("#user_is_legal_representative_text").prop("checked","true");
    	}
    	
    }
</script>