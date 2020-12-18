<link href="${pageContext.request.contextPath}/common/css/card_style.css" rel="stylesheet" type="text/css" />
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
	-등록자관리
	1.현재 등록자의 주민번호 출력 등록 수정 기능이 AES암호화 복호화로 작업되어있음 
	추후에 damo로 수정해야함   
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
<link href="${pageContext.request.contextPath}/common/css/card_style.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css" />
	<!-- BEGIN CONTENT -->
    <div class="page-content-wrapper">
        <!-- BEGIN CONTENT BODY -->
        <div class="page-content" >
            <div class="row" style="margin-top: 70px;">
                <div class="col-md-2">
                    <h1 class="page-title"> 등록자관리 </h1>
                    <table class="table table-bordered" id="user_option_tab_table">
                        <thead>
                            <tr>
                                <th colspan="2" align="center">보기옵션</th>
                            </tr>
                            <tr>
                                <th id="user_option_show_all" class="user_option_show_type_tab">전체보기</th>
                                <th id="user_option_show_basic" class="user_option_show_type_tab">기본옵션</th>
                            </tr>
                        </thead>
                        <tbody id="user_option_tab_tbody">
                            <tr><td colspan="2" id="user_option_user_num" col="user_num" class="user_option_tab">등록번호</td></tr>
                            <tr><td colspan="2" id="user_option_user_registration_date" col="user_registration_date" class="user_option_tab">등록일</td></tr>
                            <tr><td colspan="2" id="user_option_social_security_num" col="user_social_security_num" class="user_option_tab">주민등록번호</td></tr>
                            <tr><td colspan="2" id="user_option_user_name" col="user_name" class="user_option_tab">성명</td></tr>
                            <tr><td colspan="2" id="user_option_user_mobile" col="user_mobile" class="user_option_tab">휴대전화</td></tr>
                            <tr><td colspan="2" id="user_option_user_is_driving_license" col="user_is_driving_license" class="user_option_tab">운전면허증 표시</td></tr>
                            <tr><td colspan="2" id="user_option_user_email" col="user_email" class="user_option_tab">이메일</td></tr>
                            <tr><td colspan="2" id="user_option_user_is_email_agree" col="user_is_email_agree" class="user_option_tab">이메일동의</td></tr>
                            <tr><td colspan="2" id="user_option_user_is_sms_agree" col="user_is_sms_agree" class="user_option_tab">문자동의</td></tr>
                            <tr><td colspan="2" id="user_option_user_is_mail_agree" col="user_is_mail_agree" class="user_option_tab">우편동의</td></tr>
                            <tr><td colspan="2" id="user_option_user_donation_type_organ" col="user_donation_type_organ" class="user_option_tab">기증형태_장기</td></tr>                            
                            <tr><td colspan="2" id="user_option_user_donation_type_comea" col="user_donation_type_comea" class="user_option_tab">기증형태_각막</td></tr>
                            <tr><td colspan="2" id="user_option_user_donation_type_body" col="user_donation_type_body" class="user_option_tab">기증형태_조직</td></tr>
                            <tr><td colspan="2" id="user_option_user_post" col="user_post" class="user_option_tab">우편번호</td></tr>
                            <tr><td colspan="2" id="user_option_user_address" col="user_address" class="user_option_tab">주소</td></tr>
                            <tr><td colspan="2" id="user_option_user_address_detail" col="user_address_detail" class="user_option_tab">상세주소</td></tr>
                            <tr><td colspan="2" id="user_option_user_register" col="user_register" class="user_option_tab">등록자</td></tr>
                            <tr><td colspan="2" id="user_option_user_register_channel" col="user_register_channel" class="user_option_tab">등록 분류</td></tr>
                            <tr><td colspan="2" id="user_option_user_withdraw_way" col="user_withdraw_way" class="user_option_tab">가입경로</td></tr>
                            <tr><td colspan="2" id="user_option_user_recognize_type" col="user_recognize_type" class="user_option_tab">서약구분</td></tr>                                                 
                            <tr><td colspan="2" id="user_option_user_birthday" col="user_birthday" class="user_option_tab">생년월일</td></tr>
                            <tr><td colspan="2" id="user_option_user_age" col="user_age" class="user_option_tab">나이</td></tr>
                            <tr><td colspan="2" id="user_option_user_sex" col="user_sex" class="user_option_tab">성별</td></tr>
                            <tr><td colspan="2" id="user_option_user_phone" col="user_phone" class="user_option_tab">집전화</td></tr>
                            <tr><td colspan="2" id="user_option_user_pledge_date" col="user_pledge_date" class="user_option_tab">서약일</td></tr>
                            <tr><td colspan="2" id="user_option_user_withdraw_date" col="user_withdraw_date" class="user_option_tab">탈퇴일</td></tr>
                            <tr><td colspan="2" id="user_option_user_withdraw_reason" col="user_withdraw_reason" class="user_option_tab">탈퇴사유</td></tr>
                            <tr><td colspan="2" id="user_option_user_konos_register_state" col="user_konos_register_state" class="user_option_tab">Konos 등록상태</td></tr>                                                        
                            <tr><td colspan="2" id="user_option_user_konos_registration_date" col="user_konos_registration_date" class="user_option_tab">Konos 등록일</td></tr>                                                                                                                
                            <tr><td colspan="2" id="user_option_user_konos_withdraw_date" col="user_konos_withdraw_date" class="user_option_tab">Konos 탈퇴일</td></tr>
                            <tr><td colspan="2" id="user_option_user_pledge_card_state" col="user_pledge_card_state" class="user_option_tab">등록카드</td></tr>
                            <tr><td colspan="2" id="user_option_user_legal_representative_info" col="user_legal_representative_info" class="user_option_tab">법정대리인정보</td></tr>
                            <tr><td colspan="2" id="user_option_user_is_legal_representative_text" col="user_is_legal_representative_text" class="user_option_tab">법정대리인 첨부서류</td></tr>                         
                            <!-- <tr><td colspan="2" id="user_option_user_send_post" col="user_send_post" class="user_option_tab">송달우편번호</td></tr>
                            <tr><td colspan="2" id="user_option_user_send_address" col="user_send_address" class="user_option_tab">송달주소</td></tr>
                            <tr><td colspan="2" id="user_option_user_send_address_detail" col="user_send_address_detail" class="user_option_tab">송달상세주소</td></tr> -->
                        </tbody>
                    </table>
                </div>
                <div class="col-md-10">
                    <form class="form-inline" role="form" id="" action="" method="post">
                        <div class="col-md-12">
                            <div class="col-md-5 col zero-padding">
                                <div class="input-group horizontal-no-margin">
                                    <select id="search_keyword_type1" input-id="search_keyword1" class="search_keyword_type form-control input-small input-inline page-title-element zero-margin-left">
                                        <option value="user_num">등록번호</option>
                                        <option value="user_name" selected >성명</option>
                                        <option value="user_social_security_num">주민등록번호</option>
                                        <option value="user_birthday">생년월일</option>
                                        <option value="user_age">나이</option>
                                        <option value="user_sex">성별</option>
                                        <option value="user_email">이메일</option>
                                        <option value="user_post">우편번호</option>
                                        <option value="user_address">주소</option>
                                        <option value="user_address_detail">상세주소</option>
                                        <option value="user_send_post">송달우편번호</option>
                                        <option value="user_send_address">송달주소</option>
                                        <option value="user_send_address_detail">송달상세주소</option>
                                        <option value="user_mobile">휴대전화</option>
                                        <option value="user_phone">집전화</option>
                                        <option value="user_recognize_type">서약구분</option>
                                        <option value="user_donation_type_organ">기증형태_장기</option>
                                        <option value="user_donation_type_body">기증형태_조직</option>
                                        <option value="user_donation_type_comea">기증형태_각막</option>
                                        <option value="user_is_driving_license">운전면허증 표시</option>
                                        <option value="user_konos_register_state">Konos 등록상태</option>
                                        <option value="user_pledge_date">서약일</option>
                                        <option value="user_registration_date">등록일</option>
                                        <option value="user_konos_registration_date">Konos 등록일</option>
                                        <option value="user_register">등록자</option>
                                        <option value="user_register_channel">등록 분류</option>
                                        <option value="user_withdraw_date">탈퇴일</option>
                                        <option value="user_withdraw_reason">탈퇴사유</option>
                                        <option value="user_withdraw_way">가입경로</option>
                                        <option value="user_konos_withdraw_date">Konos 탈퇴일</option>
                                        <option value="user_is_email_agree">이메일동의</option>
                                        <option value="user_is_sms_agree">문자동의</option>
                                        <option value="user_is_mail_agree">우편동의</option>
                                        <option value="user_pledge_card_state">등록카드</option>
                                        <option value="user_legal_representative_info">법정대리인정보</option>
                                        <option value="user_is_legal_representative_text">법정대리인 첨부서류</option>
                                    </select>
                                    <input id="search_keyword1" type="text" class="form-control input-small page-title-element horizontal-no-margin" placeholder="검색어">
                                    <span class="input-group-btn ">
                                        <button id="open_additive_search_btn" class="btn btn-circle green page-title-element" type="button" style="margin-left:10px;"> <i class="fa fa-plus"></i></button>
                                    </span>
                                </div>
                            </div>
                            <div class="col-md-1 col zero-padding">
                                <span class="input-group-btn ">
                                        <button id="search_btn" class="btn blue page-title-element" type="button" style="padding-left:25px; padding-right:25px;">검색</button>
                                    </span>
                            </div>
                            <div class="col-md-6" >
                                <div class="col-md-12" >
                                    <button type="button" class="btn btn-sm btn-circle blue btn-outline page-title-element btn-excel-export align-right">내보내기</button>
                                    <button type="button" class="btn btn-sm btn-circle blue btn-outline page-title-element btn-print align-right">카드 인쇄</button>
                                    <button type="button" class="btn btn-sm btn-circle blue btn-outline page-title-element btn-sms align-right">선택 문자발송</button>
                                    <button type="button" class="btn btn-sm btn-circle blue btn-outline page-title-element align-right" onclick="showSMSSendDialog('A');">일반 문자발송</button>
                                </div>
                                <div class="col-md-12" >
                                    <button type="button" class="zero-margin-top btn btn-sm btn-circle blue btn-outline page-title-element btn-delete-selected align-right">선택 삭제</button>
                                    <!--<button type="button" class="zero-margin-top btn btn-sm btn-circle blue btn-outline page-title-element btn-selected-exel-export align-right">선택 내보내기</button>-->
                                    <button type="button" class="zero-margin-top btn btn-sm btn-circle blue btn-outline page-title-element btn-selected-label-excel-export align-right">선택 라벨내보내기</button>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12" id="additive_search" style="display:none;">
                            <div class="col-md-5 col zero-padding">
                                <div class="input-group horizontal-no-margin">
                                    <select id="search_keyword_type2" input-id="search_keyword2" class="search_keyword_type form-control input-small input-inline page-title-element zero-margin-left">
                                        <option value="user_num">등록번호</option>
                                        <option value="user_name">성명</option>
                                        <option value="user_social_security_num">주민등록번호</option>
                                        <option value="user_birthday">생년월일</option>
                                        <option value="user_age">나이</option>
                                        <option value="user_sex">성별</option>
                                        <option value="user_email">이메일</option>
                                        <option value="user_post">우편번호</option>
                                        <option value="user_address">주소</option>
                                        <option value="user_address_detail">상세주소</option>
                                        <option value="user_send_post">송달우편번호</option>
                                        <option value="user_send_address">송달주소</option>
                                        <option value="user_send_address_detail">송달상세주소</option>
                                        <option value="user_mobile">휴대전화</option>
                                        <option value="user_phone">집전화</option>
                                        <option value="user_recognize_type">서약구분</option>
                                        <option value="user_donation_type_organ">기증형태_장기</option>
                                        <option value="user_donation_type_body">기증형태_조직</option>
                                        <option value="user_donation_type_comea">기증형태_각막</option>
                                        <option value="user_is_driving_license">운전면허증 표시</option>
                                        <option value="user_konos_register_state">Konos 등록상태</option>
                                        <option value="user_pledge_date">서약일</option>
                                        <option value="user_registration_date">등록일</option>
                                        <option value="user_konos_registration_date">Konos 등록일</option>
                                        <option value="user_register">등록자</option>
                                        <option value="user_register_channel">등록 분류</option>
                                        <option value="user_withdraw_date">탈퇴일</option>
                                        <option value="user_withdraw_reason">탈퇴사유</option>
                                        <option value="user_withdraw_way">가입경로</option>
                                        <option value="user_konos_withdraw_date">Konos 탈퇴일</option>
                                        <option value="user_is_email_agree">이메일동의</option>
                                        <option value="user_is_sms_agree">문자동의</option>
                                        <option value="user_is_mail_agree">우편동의</option>
                                        <option value="user_pledge_card_state">등록카드</option>
                                        <option value="user_legal_representative_info">법정대리인정보</option>
                                        <option value="user_is_legal_representative_text">법정대리인 첨부서류</option>
                                    </select>
                                    <input id="search_keyword2" type="text" class="form-control input-small page-title-element horizontal-no-margin" placeholder="검색어">
                                </div>
                            </div>
                            <div class="col-md-7 col zero-padding" style="margin-bottom: 20px;">
                                <div class="input-group horizontal-no-margin">
                                    <select id="search_keyword_type3" input-id="search_keyword3" class="search_keyword_type form-control input-small input-inline page-title-element zero-margin-left">
                                        <option value="user_num">등록번호</option>
                                        <option value="user_name">성명</option>
                                        <option value="user_social_security_num">주민등록번호</option>
                                        <option value="user_birthday">생년월일</option>
                                        <option value="user_age">나이</option>
                                        <option value="user_sex">성별</option>
                                        <option value="user_email">이메일</option>
                                        <option value="user_post">우편번호</option>
                                        <option value="user_address">주소</option>
                                        <option value="user_address_detail">상세주소</option>
                                        <option value="user_send_post">송달우편번호</option>
                                        <option value="user_send_address">송달주소</option>
                                        <option value="user_send_address_detail">송달상세주소</option>
                                        <option value="user_mobile">휴대전화</option>
                                        <option value="user_phone">집전화</option>
                                        <option value="user_recognize_type">서약구분</option>
                                        <option value="user_donation_type_body">기증형태_조직</option>
                                        <option value="user_donation_type_organ">기증형태_장기</option>
                                        <option value="user_donation_type_comea">기증형태_각막</option>
                                        <option value="user_is_driving_license">운전면허증 표시</option>
                                        <option value="user_konos_register_state">Konos 등록상태</option>
                                        <option value="user_pledge_date">서약일</option>
                                        <option value="user_registration_date">등록일</option>
                                        <option value="user_konos_registration_date">Konos 등록일</option>
                                        <option value="user_register">등록자</option>
                                        <option value="user_register_channel">등록 분류</option>
                                        <option value="user_withdraw_date">탈퇴일</option>
                                        <option value="user_withdraw_reason">탈퇴사유</option>
                                        <option value="user_withdraw_way">가입경로</option>
                                        <option value="user_konos_withdraw_date">Konos 탈퇴일</option>
                                        <option value="user_is_email_agree">이메일동의</option>
                                        <option value="user_is_sms_agree">문자동의</option>
                                        <option value="user_is_mail_agree">우편동의</option>
                                        <option value="user_pledge_card_state">등록카드</option>
                                        <option value="user_legal_representative_info">법정대리인정보</option>
                                        <option value="user_is_legal_representative_text">법정대리인 첨부서류</option>
                                    </select>
                                    <input id="search_keyword3" type="text" class="form-control input-small page-title-element horizontal-no-margin" placeholder="검색어">
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="clearfix"></div>
                    <div class="col-md-12">
                        <form class="form-inline" role="form" id="" action="" method="post">
                            <div class="m-grid period_search_div">
                                <div class="m-grid-row">
                                    <div class="m-grid-col m-grid-col-middle m-grid-col-center m-grid-col-md-5">
                                        <div class="caption">
                                            <span class="caption-subject bold uppercase">기간설정</span>
                                            <span class="mt-radio-inline" style="margin-left:25px;">
                                            <c:set var="checked1" value="checked"/>
                                            <c:set var="checked2" value=""/>
                                           	<c:if test="${data_get != null}">
                                           		<c:if test="${data_get.search_between_type == 'user.user_withdraw_date'}">                                                
                                                    <c:set var="checked1" value=""/>
                                            		<c:set var="checked2" value="checked"/>
                                            	</c:if>    
                                            </c:if>                                            
                                                <label class="mt-radio" style="margin-bottom:0px;">
                                                    <input class="search_between_type_btn" name="search_between_type" value="" type="radio" <c:out value="${checked1}"/>> 서약일
                                                    <span></span>
                                                </label>
                                                <label class="mt-radio" style="margin-bottom:0px;">
                                                    <input class="search_between_type_btn" name="search_between_type" value="user.user_withdraw_date" type="radio" <c:out value="${checked2}"/>> 탈퇴일
                                                    <span></span>
                                                </label>
                                                
                                            </span>
                                        </div>
                                    </div>
                                    <div class="m-grid-col m-grid-col-middle m-grid-col-center m-grid-col-md-5">
                                        <div class="caption">
                                            <span class="caption-subject bold uppercase">기간설정 옵션</span>
                                        </div>
                                    </div>
                                    <!-- <div class="m-grid-col m-grid-col-middle m-grid-col-center m-grid-col-md-2">
                                        <div class="caption">
                                            <span class="caption-subject bold uppercase">가져오기</span>
                                        </div>
                                    </div> -->
                                </div>
                                <div class="m-grid-row">
                                    <div class="m-grid-col m-grid-col-middle m-grid-col-center m-grid-col-md-5">
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <div class="input-group date form_datetime bs-datetime">
                                                    <input type="text" size="10" id="search_start_date" class="form-control">
                                                        <span class="input-group-addon">
                                                            <button class="btn default date-set" type="button">
                                                                <i class="fa fa-calendar"></i>
                                                            </button>
                                                        </span>
                                                </div>
                                                ~
                                                <div class="input-group date form_datetime bs-datetime">
                                                    <input type="text" size="10" id="search_end_date" class="form-control">
                                                        <span class="input-group-addon">
                                                            <button class="btn default date-set" type="button">
                                                                <i class="fa fa-calendar"></i>
                                                            </button>
                                                        </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="m-grid-col m-grid-col-middle m-grid-col-center m-grid-col-md-5 user_period_search_option_row">
                                        <div id="user_period_search_day" class="col-md-2 user_period_search_option_tab">일간</div>
                                        <div id="user_period_search_week" class="col-md-2 user_period_search_option_tab">주간</div>
                                        <div id="user_period_search_month" class="col-md-2 user_period_search_option_tab">월간</div>
                                        <div id="user_period_search_year" class="col-md-2 user_period_search_option_tab">연간</div>
                                        <div id="user_period_search_now" class="col-md-2 user_period_search_option_tab">현재년도</div>
                                        <div id="user_period_search_all" class="col-md-2 user_period_search_option_tab">전체</div>
                                    </div>
                                    <!-- <div class="m-grid-col m-grid-col-middle m-grid-col-center m-grid-col-md-2">
                                        <div class="col-md-4">
                                            <div class="btn btn-excel-import-base" type="button" style="font-size: 16px;padding-bottom:0px;padding-top: 10px;">
                                                <i class="fa fa-file-excel-o"></i>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <input id="btn-excel-import" name="btn-excel-import" type="file" title=" " style="margin-top:7px;">
                                        </div>
                                    </div> -->
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="clearfix"></div>
                    <!-- 등록자 내용 들어갈 부분 -->
                                     
                    <div class="col-md-12" id="user_list_div">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover table-checkable order-column table-clickable" id="user_list_table">
                                <thead>
                                <tr id="user_list_head_tr">
								
                                </tr>
                                </thead>
                                <tbody id="user_list_tbody"> 
								
                                </tbody>
                            </table>
                        </div>
                        <div style="text-align: center;" id="pagination_div">
                            project list pagination
                        </div>
                        <div class="col-md-12">
                            <p style="margin:0;font-size: 10px;">* 시스템상의 회원은 등록번호로 구분됩니다.</p>
                            <p  style="margin:0;font-size: 10px;">* Excel로 가져오기시 등록번호가 있으면 기 저장된 회원정보가 Update되고 등록번호가 없으면 새로 등록번호가 부여되면서 등록됩니다.</p>
                            <p style="margin:0;font-size: 10px;">* 가져오기시 가급적 새로 등록할 회원만 파일로 올리시기 바랍니다. 아니면 의도치 않은 회원 중복 등록 및 등록번호가 있더라도 시스템상에서 수정한 정보가 지워질 수 있습니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="sms_send_dialog" class="modal fade" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title">잔여문자발송</h4>
                        <p id="sms_total_count_sentence" style="margin:7px 0 0 0;"></p>
                    </div>
                    <div class="modal-body">
                        <div class="" style="height:300px" data-always-visible="1" data-rail-visible1="1">
                            <div class="row">
                                <div class="col-md-6">
                                    <h5>1. 발송내용</h5>
                                    <textarea id="sms_send_msg" name="sms_send_msg" class="form-control col-md-12 input-sm" rows="14"></textarea>
                                    <span id="notice_sms_balance"></span>
                                </div>
                                <div class="col-md-6">
                                    <h5>2. 휴대전화 연락처</h5>
                                        <div id="phoneArea"></div>
                                    <h5>3. 보내는 이</h5>
                                    <select id="sms_send_sender" class="col-md-12 form-control">  
                                    	<c:forEach var="value" items="${enum_array.sms_send_sender}" varStatus="status">
                                       	<c:set var="selected" value=""/>
                                           	<c:if test="${user_detail.sms_send_sender != ''}">
                                           		<c:if test="${value != ''}">
                                           		<c:if test="${user_detail.sms_send_sender == status.index}">
                                              		<c:set var="selected" value="selected"/>
                                              		</c:if>                                              	
                                              	<option value="${value}" ${selected}>${value}</option>
                                              	</c:if>
                                          	</c:if>
                                        </c:forEach>                                                                          
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="btn_open_sms_message_form" type="button" class="btn blue" style="float:left;">양식 불러오기(클릭)</button>
                        <button id="btn_send_sms" type="button" class="btn blue">보내기</button>
                        <input type="hidden" id="checkName" value="">
                    </div>
                </div>
            </div>
        </div>
        <div id="sms_message_form_dialog" class="modal fade" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title">문자 양식</h4>
                    </div>
                    <div class="modal-body">
                        <div class="" style="min-height:300px" data-always-visible="1" data-rail-visible1="1">
                            <div class="row" id="message_form_list_div">
                                <div id="add_message_form_div" class="col-md-6">
                                    <div style="text-align: center; font-size: 60px"><i id="add_message_form_btn" style="margin-top:110px;" class="fa fa-plus"></i></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- END CONTENT BODY -->
    </div>
    <!-- END CONTENT -->
    </div>
    <div id="print_card_div">
    </div>
    <!-- END CONTAINER -->
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery_redirect/jquery.redirect.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/moment/moment.min.js" type="text/javascript"></script>

<script language="JavaScript" type="text/javascript">
    window.user_list = [];
    window.selected_page = 1;
    window.sms_send_user_list = [];
    window.sms_send_mobile_list = [];
    window.max_lms_length = 1000;
    window.is_over_max_lms = 0;

    var show_sms_ok = "";
    <c:choose><c:when test="${ !empty sms_form_list}">
	var enum_array = ${enum_array};
	</c:when><c:otherwise>
	var enum_array = null;
	</c:otherwise></c:choose>
	<c:choose><c:when test="${ !empty sms_form_list}">
	var sms_form_list = ${sms_form_list};
	</c:when><c:otherwise>
	var sms_form_list = null;
	</c:otherwise></c:choose>
	<c:choose><c:when test="${ !empty data_get}">
	var data_get = ${data_get};
	</c:when><c:otherwise>
	var data_get = null;
	</c:otherwise></c:choose>

    function showTotalSMSCount() {
        $.ajax({
            url: "<c:url value='/user/getSMSTotalCountAjax.do'/>",
            type: 'post',
            dataType: "json",
            data: {
            },
            success: function(data) { 
            	if(data != null && data.rtnCode == "") {
	                var sms_total_count = data.sms_total_count;
	                var today = new Date();
	                var dd = today.getDate();
	                var mm = today.getMonth()+1; //January is 0!
	                var yyyy = today.getFullYear();
	                var sms_total_count_sentence = "- 수량 "+yyyy+"년"+mm+"월"+dd+"일 "+sms_total_count+"개의 문자가 남아 있습니다.";
	                $("#sms_total_count_sentence").html(sms_total_count_sentence);
            	} else {
            		alert('잔여건수 조회에 실패하였습니다.')
            	}
            },
            error: function(xhr, desc, err) {
                alert('데이터 로딩이 안됩니다. 잠시후에 다시 해주시기 바랍니다.')
            }
        });
    }

    function sendSMSAjax() {
    	
    	if($("#checkName").val() === 'A'){    		
    		var user_mobile = $("#sms_send_mobile_list").val();
    		window.sms_send_mobile_list.push(user_mobile);
    		window.sms_send_mobile_list_sentence += user_mobile;
    	}    	
    	
        jQuery.ajaxSettings.traditional = true;
        $.ajax({
            url: "<c:url value='/user/sendSMSAjax.do'/>",
            type: 'post',
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",           
            dataType: "json",
            data: {
                'sms_send_user_list': window.sms_send_user_list,
                'sms_send_mobile_list': window.sms_send_mobile_list,
                'sms_send_msg': $("#sms_send_msg").val(),
                'sms_send_sender': $("#sms_send_sender").val(),
                'sms_send_mobile_list_sentence':window.sms_send_mobile_list_sentence,
                'smsType': getSMSType()
            },
            success: function(data) {
                /* var parsedData = $.parseJSON(data); */
                if(data != null && data.rtnCode == "") {
	                showTotalSMSCount();
	                toastr.options = {
	                    "positionClass": "toast-bottom-center"
	                };
	                toastr.success(data.rtnMsg);
                } else {
                	toastr.options = {
   	                    "positionClass": "toast-bottom-center"
   	                };
   	                toastr.success(data.rtnMsg);
                }
            },
            error: function(xhr, desc, err) {
                alert('SMS 전송에 실패했습니다. 잠시후에 다시 해주시기 바랍니다.')
            }
        });
    }

    function warning_delete() {
        if(confirm('정말 지우시겠습니까? ')){
            return true;
        } else {
            return false;
        }
    }

    function deleteUserAjax(user_index) {
        $.ajax({
            url: "<c:url value='/user/deleteUserAjax.do'/>",
            type: 'post',
            dataType: "json",
            data: {
                'user_index': user_index
            },
            success: function(data) {
                /* var parsedData = $.parseJSON(data); */
                toastr.options = {
                    "positionClass": "toast-bottom-center"
                };
                toastr.success("삭제하였습니다.");
                showUserListAjax();
            },
            error: function(xhr, desc, err) {
                alert('실패하였습니다. 잠시후에 다시 해주시기 바랍니다.')
            }
        });
    }

    function deleteSelectedUser() {
        if(warning_delete()) {
            $("#user_list_tbody").find(".checkboxes").each(function() {
                if($(this).is(":checked")) {
                    var user_index = $(this).parent().parent().parent().attr("user_index");
                    deleteUserAjax(user_index);
                }
            });
        }
    }

    function showSMSSendDialog(checkName) {
    	$("#checkName").val(checkName);
        var sms_send_mobile_list_html = "";
        window.sms_send_user_list = [];
        window.sms_send_mobile_list = [];
        window.sms_send_mobile_list_sentence = "";
        var checked_count = 0;
        showTotalSMSCount();
        if(!checkName){
        	$("#phoneArea").html('<textarea id="sms_send_mobile_list" name="sms_send_mobile_list" class="form-control col-md-12 input-sm" rows="9"></textarea>');
        	$("#user_list_tbody").find(".checkboxes").each(function() {
                if($(this).is(":checked")) {
                    var user_index = $(this).closest('tr').attr("user_index");
                    var user_mobile = $(this).closest('tr').attr("user_mobile");
                    var user_is_sms_agree = $(this).closest('tr').attr("user_is_sms_agree");
                    if (user_mobile != "" && user_is_sms_agree == 'Y') {
                        checked_count++;
                        if(checked_count%2 == 0) {
                            sms_send_mobile_list_html += user_mobile + '\n';
                        } else {
                            sms_send_mobile_list_html += user_mobile + '\t';
                        }
                        window.sms_send_user_list.push(user_index);
                        window.sms_send_mobile_list.push(user_mobile);
                        if( checked_count == 1) {
                            window.sms_send_mobile_list_sentence += user_mobile;
                        } else {
                            window.sms_send_mobile_list_sentence += "," + user_mobile;
                        }
                    }
                }
            });
        }else{
        	$("#phoneArea").html('<input type="text" id="sms_send_mobile_list" name="sms_send_mobile_list" class="form-control col-md-12" placeholder="010-0000-0000" style="margin-bottom:20px;">');
        }
        $('#sms_send_msg').html('');
        $('#sms_send_mobile_list').html(sms_send_mobile_list_html);
        $('#sms_send_dialog').modal('show');
    }

    function showSMSMessageFormDialog() {
        $('#sms_message_form_dialog').modal('show');
    }

    function showUserList() {
        $("#user_list_head_tr *").remove();
        $("#user_list_tbody *").remove();
        // show header
        var head_tr = '<th>' +
                            '<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">' +
                                '<input type="checkbox" class="group-checkable" data-set="" checked />' +
                                '<span></span>' +
                            '</label>' +
                        '</th>';

        $("#user_option_tab_tbody").find(".active").each(function() {
            head_tr += '<th>'+ $(this).html()+'</th>';
        });
        $("#user_list_head_tr").append(head_tr);
        // show tr
        jQuery.each(window.user_list, function(i, val) {
            // get donation type string
            var donation_type = "";
            var donation_type_count = 0;
            if(val.user_donation_type_organ == "Y") {
                donation_type += "뇌사 시 장기";
                donation_type_count++;
            }
            if(val.user_donation_type_body == "Y") {
                if(donation_type_count >0 ) donation_type += ", ";
                donation_type += "인체조직";
                donation_type_count++;
            }
            if(val.user_donation_type_comea == "Y") {
                if(donation_type_count >0 ) donation_type += ", ";
                donation_type += "각막";
                donation_type_count++;
            }
            if(donation_type_count == 0) donation_type="";
            // get tr
            var body_tr =  '<tr class="" user_index="'+val.user_index+'" user_mobile="'+val.user_mobile+'" user_is_sms_agree="'+val.user_is_sms_agree+'" ' +
                            'user_name="'+val.user_name+'" user_num="'+val.user_num+'" user_pledge_date="'+val.user_pledge_date+'" donation_type="'+donation_type+'" >' +
                                '<td class="no-click">' +
                                    '<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">' +
                                        '<input type="checkbox" class="checkboxes" value="1" checked />' +
                                        '<span></span>' +
                                    '</label>' +
                                '</td>';
            // get td's
            $("#user_option_tab_tbody").find(".active").each(function() {
                var col_name = $(this).attr("col");
                body_tr += '<td>'+ val[col_name]+'</td>';
            });
            body_tr += '</tr>';
            $("#user_list_tbody").append(body_tr);
        });
        // The following codes work when each table row is clicked
        $(".table-clickable").delegate('td', 'click', function() {
            // Get clicked product_index and show product detail inf page
            if(!$(this).hasClass('no-click')) {
                var user_index = $(this).parent().attr('user_index');
                if ( user_index ) {
                    var redirect_address = "<c:url value='/user/detail.do'/>";
                    $.redirect(redirect_address, { user_index : user_index }, "POST", "");
                }
            }
        });
        // Each of table row is shown as hand shape on mouse over (Except title row)
        $(".table-clickable tr:has(td)").css('cursor', 'pointer');
        // Group check
        $(".group-checkable").click(function(e) {
            if($(this).is(':checked')) {
                $(".checkboxes").prop("checked", true);
            } else {
                $(".checkboxes").prop("checked", false);
            }
        });
    }

    function addPagination(pagination_id, link_function_name, total_count, per_page, show_page_count, cur_page) {
        var page_max = total_count%per_page == 0 ? parseInt(total_count/per_page) : parseInt(total_count/per_page) + 1;
        var start_page = (cur_page-show_page_count/2 > 1 ) ? cur_page-show_page_count/2 : 1;
        var end_page = (cur_page+show_page_count/2 < page_max) ? cur_page+show_page_count/2 : page_max;
        if(end_page >= show_page_count/2 && cur_page < show_page_count/2) {
            end_page = end_page + (show_page_count/2-cur_page);
        }
        if(start_page > 1 && cur_page > page_max-show_page_count/2) {
            start_page = start_page - (cur_page-page_max+show_page_count/2);
        }
        var prev_page = (cur_page-show_page_count > 1) ? cur_page-show_page_count : 1;
        var next_page = (cur_page+show_page_count < page_max) ? cur_page+show_page_count : page_max;
        var pagintation_html = '<ul class="pagination">';
        pagintation_html += '<li class="page_prev">' +
            '<a href="javascript:'+link_function_name+'('+prev_page+')" aria-label="Previous">' +
            '<span aria-hidden="true">&laquo;</span>' +
            '</a>' +
            '</li>';
        for(var page = start_page; page <= end_page; page++){
            pagintation_html += '<li>' +
                '<a href="javascript:'+link_function_name+'('+page+')">'+page+'</a>' +
                '</li>'
        }
        pagintation_html += '<li class="page_next">' +
            '<a href="javascript:'+link_function_name+'('+next_page+')" aria-label="Next">' +
            '<span aria-hidden="true">&raquo;</span>' +
            '</a>' +
            '</li>';
        pagintation_html += '</ul>';
        $("#"+pagination_id).html(pagintation_html);
        // Hide prev/next button
        if(cur_page == 1) {
            $("#"+pagination_id).find(".page_prev").hide();
        }
        if(cur_page == page_max) {
            $("#"+pagination_id).find(".page_next").hide();
        }
        // Set Current Page Highlight
        $("#"+pagination_id).find("li").removeClass("active");
        $("#"+pagination_id).find("li:nth-of-type("+(cur_page-start_page+2)+")").addClass("active");
    }

    function showUserListAjax(page) {
        page = typeof page !== 'undefined' ? page : 1;
        window.selected_page = page;
        var search_keyword_type_array = [$("#search_keyword_type1").val(), $("#search_keyword_type2").val(), $("#search_keyword_type3").val()];
        var search_keyword_array = [$("#search_keyword1").val(), $("#search_keyword2").val(), $("#search_keyword3").val()];
        var data_search = {
            'page': page,
            'search_keyword_type_array': search_keyword_type_array,
            'search_keyword_array': search_keyword_array,
            'search_start_date': $("#search_start_date").val(),
            'search_end_date': $("#search_end_date").val(),
            'search_between_type': $("input[name='search_between_type']:checked").val()
        };
       	
        $.ajax({
            url: "<c:url value='/user/getUserListAjax.do'/>",
            type: 'post',
            data: data_search,
            dataType: "json",
            success: function(data) {
            	/*
                var parsedData = $.parseJSON(data);
                window.user_list = parsedData.user_list;
                showUserList();
                addPagination('pagination_div', 'showUserListAjax', parsedData.total_count, parsedData.search_value['limit'], 10, page);
                */                
            	if(data != null && data.rtnCode == "") {	                
	                window.user_list = data.user_list;            	
	                showUserList();
	                addPagination('pagination_div', 'showUserListAjax', data.total_count, data.search_value.limit, 5, page);
            	} else {
            		 alert('데이터 로딩이 안됩니다. 잠시후에 다시 해주시기 바랍니다.')
            	}
            },
            error: function(xhr, desc, err) {
                alert('데이터 로딩이 안됩니다. 잠시후에 다시 해주시기 바랍니다.')
            }
        });
    }
    function showUserOptionAll() {
        $(".user_option_tab").addClass("active");
    }
    function showUserOptionBasic() {
        $(".user_option_tab").removeClass("active");
        $("#user_option_user_registration_date").addClass("active");
        //$("#user_option_social_security_num").addClass("active");
        $("#user_option_user_name").addClass("active");
        $("#user_option_user_mobile").addClass("active");
        $("#user_option_user_is_driving_license").addClass("active");
        $("#user_option_user_email").addClass("active");
        $("#user_option_user_is_email_agree").addClass("active");
        $("#user_option_user_is_sms_agree").addClass("active");
        $("#user_option_user_is_mail_agree").addClass("active");
        $("#user_option_user_donation_type_organ").addClass("active");
        $("#user_option_user_donation_type_comea").addClass("active");
        $("#user_option_user_donation_type_body").addClass("active");
        $("#user_option_user_post").addClass("active");
        $("#user_option_user_address").addClass("active");
        $("#user_option_user_address_detail").addClass("active");
        /* $("#user_option_user_num").addClass("active");
        $("#user_option_user_name").addClass("active");
        $("#user_option_user_birthday").addClass("active");
        $("#user_option_user_post").addClass("active");
        $("#user_option_user_address").addClass("active");
        $("#user_option_user_address_detail").addClass("active");
        $("#user_option_user_mobile").addClass("active");
        $("#user_option_user_recognize_type").addClass("active");
        $("#user_option_user_donation_type_body").addClass("active");
        $("#user_option_user_pledge_date").addClass("active"); */
    }
    Date.prototype.addDays = function (n) {
        var time = this.getTime();
        var changedDate = new Date(time + (n * 24 * 60 * 60 * 1000));
        this.setTime(changedDate.getTime());
        return this;
    };
    function setSearchStartDateByOption(period) {
        var search_end_date = $("#search_end_date").val();
        var date_arr = search_end_date.split('.');
        var search_end_date_obj = new Date(date_arr[0], parseInt(date_arr[1])-1, date_arr[2]);
        var search_start_date_obj = search_end_date_obj.addDays(-period);
        var yyyy = search_start_date_obj.getFullYear();
        var mm = ((search_start_date_obj.getMonth() + 1) < 10 ? "0" + (search_start_date_obj.getMonth() + 1) : (search_start_date_obj.getMonth() + 1));
        var dd = (search_start_date_obj.getDate() < 10 ? "0" + search_start_date_obj.getDate() : search_start_date_obj.getDate());
        var search_start_date_string =  yyyy+ "." + mm + "." + dd
        $("#search_start_date").val(search_start_date_string);
    }
    function setSearchStartDateNow() {
    	var today = new Date();  
    	var year = today.getFullYear();
    	var dateString = year+"."+"01"+"."+"01";      	      	   	
        $("#search_start_date").val(dateString);
    }
    function setSearchStartDateInit() {
        var search_start_date_obj = new Date(2000,1,1);
        var yyyy = search_start_date_obj.getFullYear();
        var mm = (search_start_date_obj.getMonth() < 10 ? "0" + search_start_date_obj.getMonth() : search_start_date_obj.getMonth());
        var dd = (search_start_date_obj.getDate() < 10 ? "0" + search_start_date_obj.getDate() : search_start_date_obj.getDate());
        var search_start_date_string =  yyyy+ "." + mm + "." + dd
        $("#search_start_date").val(search_start_date_string);
    }

    function uploadUserListAjax() {
        var button_id = "btn-excel-import";
        var file = $("#btn-excel-import")[0].files[0];
        var formData = new FormData();
        formData.append(button_id, file);
        formData.append('button_id', button_id);
        $.ajax({
            url: "<c:url value='/user/uploadUserListAjax.do'/>",
            type: 'post',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function(data) {
                var parsedData = $.parseJSON(data);
                if (parsedData) {
                    $("#btn-excel-import")[0].value="";
                    toastr.options = {
                        "positionClass": "toast-bottom-center"
                    };
                    toastr.success('적용되었습니다.');
                    showUserListAjax();
                }else {
                    alert("실패하였습니다. 잠시 후 다시 시도바랍니다.");
                }
            },
            error: function(xhr, desc, err) {
                alert("실패하였습니다. 잠시 후 다시 시도바랍니다.");
            }
        });
    }
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
    function warning_delete() {
        if(confirm('정말 삭제하시겠습니까? ')){
            return true;
        } else {
            return false;
        }
    }
    function showMessageForm(message_form_index, message_form_value) {    	
        var message_form_num = $('.message_form').length + 1;
        var message_form_dom =
            '<div class="col-md-6 message_form">' +
                '<input type="hidden" class="sms_form_index" value="'+message_form_index+'">' +
                '<h5>양식'+message_form_num+'</h5>' +
                '<textarea class="form-control col-md-12 input-sm" rows="10" style="margin-bottom: 5px;">'+message_form_value+'</textarea>' +
                '<button type="button" class="btn purple save_message_form_btn">저장하기</button>' +
                '<button type="button" class="btn purple del_message_form_btn" style="margin-left:5px;">삭제하기</button>' +
                '<button type="button" class="btn purple set_message_form_btn" style="float:right;">선택하기</button>' +
            '</div>';
        $('#add_message_form_div').before(message_form_dom);
        $(".save_message_form_btn").unbind('click');
        $(".save_message_form_btn").click(function(e) {
            var sms_form_index = $(this).closest('div.message_form').find('.sms_form_index').val();
            var sms_form_value = $(this).closest('div.message_form').find('textarea').val();
            var $obj_sms_form_index = $(this).closest('div.message_form').find('.sms_form_index');
            $.ajax({
                url: "<c:url value='/user/saveSMSFormAjax.do'/>",
                type: 'post',
                dataType: "json",
                data: {
                    'sms_form_index': sms_form_index,
                    'sms_form_value': sms_form_value
                },
                success: function(data) {
                	/*
                    var parsedData = $.parseJSON(data);
                    alert('데이터가 저장되었습니다.');
                    */
                    if(data != null && data.rtnCode == "") {
                        alert('데이터가 저장되었습니다.');
                        $obj_sms_form_index.val(data.search_value.sms_form_index);
                	} else {
                		alert(data.rtnMsg);
                	}
                },
                error: function(xhr, desc, err) {
                    alert('데이터 저장이 안됩니다. 잠시후에 다시 해주시기 바랍니다.');
                }
            });
        });
        
        $(".del_message_form_btn").unbind('click');
        $(".del_message_form_btn").click(function(e) {
            var sms_form_index = $(this).parent().find('.sms_form_index').val();
           	var $divObj = $(this).closest('div.message_form');
            if(sms_form_index == 0) {
            	$divObj.remove();
            } else {
            	var result = warning_delete();
                if (result) {
		            $.ajax({
		                url: "<c:url value='/user/deleteSMSFormAjax.do'/>",
		                type: 'post',
		                dataType: "json",
		                data: {
		                    'sms_form_index': sms_form_index                    
		                },
		                success: function(data) {
		                	/*
		                    var parsedData = $.parseJSON(data);
		                    alert('데이터가 저장되었습니다.');
		                    */
		                    if(data != null && data.rtnCode == "") {                    	
		                        alert('데이터가 삭제되었습니다.');
		                        $divObj.remove();
		                	} else {
		                		alert(data.rtnMsg);
		                	}
		                },
		                error: function(xhr, desc, err) {
		                    alert('데이터 삭제가 안됩니다. 잠시후에 다시 해주시기 바랍니다.');
		                }
		            });
                }
            }
        });
        $(".set_message_form_btn").unbind('click');
        $(".set_message_form_btn").click(function(e) {
            var sms_form_value = $(this).parent().find('textarea').val();
            $("#sms_send_msg").val(sms_form_value);
            $('#sms_message_form_dialog').modal('hide');
        });
    }
    function printDiv(divName) {
        var search_data = {
            search_keyword_type1 : $("#search_keyword_type1").val(),
            search_keyword_type2 : $("#search_keyword_type2").val(),
            search_keyword_type3 : $("#search_keyword_type3").val(),
            search_keyword1 : $("#search_keyword1").val(),
            search_keyword2 : $("#search_keyword2").val(),
            search_keyword3 : $("#search_keyword3").val(),
            search_start_date : $("#search_start_date").val(),
            search_end_date : $("#search_end_date").val(),
            selected_page : window.selected_page
        };
        var printContents = document.getElementById(divName).innerHTML;
        document.body.innerHTML = printContents;
        window.print();
        var redirect_address = "<c:url value='/user/userList.do'/>";
        var start_date =  $("#search_start_date").val();
        $.redirect(redirect_address, search_data , "GET", "");
    }

    function makePrintCardDiv() {
        var card_div = "";
        var card_count = 0;

        $("#user_list_tbody").find(".checkboxes").each(function() {
            if($(this).is(":checked")) {
                var user_name = $(this).parent().parent().parent().attr("user_name");
                var user_num = $(this).parent().parent().parent().attr("user_num");
                var user_pledge_date = $(this).parent().parent().parent().attr("user_pledge_date");
                var donation_type = $(this).parent().parent().parent().attr("donation_type");
                if(card_count > 0) {
                    card_div += '<div class="page-divide"></div>';
                }
                card_div += '<div class="card_object">';
                if(user_name.length <= 3) {
                    card_div += '<div class="card_user_name">'+user_name+'</div>';
                } else if (user_name.length == 4) {
                    card_div += '<div class="card_user_name card_user_name_4">'+user_name+'</div>';
                } else if (user_name.length == 5) {
                    card_div += '<div class="card_user_name card_user_name_5">'+user_name+'</div>';
                } else if (user_name.length == 6) {
                    card_div += '<div class="card_user_name card_user_name_6">'+user_name+'</div>';
                } else {
                    card_div += '<div class="card_user_name card_user_name_7">'+user_name+'</div>';
                }
                card_div +=     '<div class="card_user_num">'+user_num+'</div>' +
                                '<div class="card_user_pledge_date">'+user_pledge_date+'</div>' +
                                '<div class="card_donation_type">'+donation_type+'</div>' +
                            '</div>';
                card_count++;
            }
        });

        $("#print_card_div").append(card_div);
    }
    function initValue() {
        // Show option init
        $(".user_option_show_type_tab").removeClass("active");
        $("#user_option_show_basic").addClass("active");
        showUserOptionBasic();
        // Search Init
        $("#user_period_search_day").addClass("active");
        var today = new Date();
        today.setDate(today.getDate());
        var yyyy = today.getFullYear();
        var mm = ((today.getMonth()+1) < 10 ? "0" + (today.getMonth()+1) : (today.getMonth()+1));
        var dd = (today.getDate() < 10 ? "0" + today.getDate() : today.getDate());
        var today_string = yyyy + "." + mm + "." + dd;
        $("#search_start_date").val(today_string);
        $("#search_end_date").val(today_string);
        
        // User List Init
        showUserListAjax();
        // Dialog Init
        //showTotalSMSCount();
        if(show_sms_ok == 'true') {
            toastr.options = {
                "positionClass": "toast-bottom-center"
            };
            toastr.success('문자가 전송되었습니다..');
        }
        // sms form
        jQuery.each(sms_form_list, function(key, val) {
        	//console.log(val);
            showMessageForm(val.sms_form_index, val.sms_form_value);
        });

    }
    $(document).ready(function() {
        initValue();

        $("#user_option_show_all").click(function(e) {
            $(".user_option_show_type_tab").removeClass("active");
            $("#user_option_show_all").addClass("active");
            showUserOptionAll();
            showUserListAjax();
        });
        $("#user_option_show_basic").click(function(e) {
            $(".user_option_show_type_tab").removeClass("active");
            $("#user_option_show_basic").addClass("active");
            showUserOptionBasic();
            showUserListAjax();
        });
        $(".user_option_tab").click(function(e) {
            var user_option_tab_id = $(this).attr("id");
            var isActive = $(this).hasClass("active");
            if(isActive){
                $(this).removeClass("active");
            } else {
                $(this).addClass("active");
            }
            showUserListAjax();
        });
        $(".user_period_search_option_tab").click(function(e) {
            $(".user_period_search_option_tab").removeClass("active");
            $(this).addClass("active");
        });
        $(".search_between_type_btn").click(function(e) {
            showUserListAjax();
        });
        $("#search_btn").click(function(e) {
            showUserListAjax();
        });
        $("#user_period_search_day").click(function(e) {
            setSearchStartDateByOption(0);
            showUserListAjax();
        });
        $("#user_period_search_week").click(function(e) {
            setSearchStartDateByOption(7);
            showUserListAjax();
        });
        $("#user_period_search_month").click(function(e) {
            setSearchStartDateByOption(30);
            showUserListAjax();
        });
        $("#user_period_search_year").click(function(e) {
            setSearchStartDateByOption(365);
            showUserListAjax();
        });
        $("#user_period_search_now").click(function(e) {
            setSearchStartDateNow();
            showUserListAjax();
        });
        $("#user_period_search_all").click(function(e) {
            setSearchStartDateInit();
            showUserListAjax();
        });
        $(".form_datetime").datetimepicker({
            autoclose: true,
            isRTL: App.isRTL(),
            format: "yyyy.mm.dd",
            minView: 2,
            maxView: 4,
            fontAwesome: true,
            initialDate: new Date(),
            pickerPosition: (App.isRTL() ? "bottom-right" : "bottom-left")
        }).on('changeDate', function(ev){
            showUserListAjax();
        });
        $(".btn-print").click(function(e) {
            makePrintCardDiv();
            printDiv("print_card_div");
        });
        $(".btn-excel-export").click(function(e) {
            var search_keyword_type_array = [$("#search_keyword_type1").val(), $("#search_keyword_type2").val(), $("#search_keyword_type3").val()];
            var search_keyword_array = [$("#search_keyword1").val(), $("#search_keyword2").val(), $("#search_keyword3").val()];
            var data_search = {
                'search_keyword_type_array': search_keyword_type_array,
                'search_keyword_array': search_keyword_array,
                'search_start_date': $("#search_start_date").val(),
                'search_end_date': $("#search_end_date").val()
            };

            $.ajax({
                url: "<c:url value='/user/exportExcelAjax.do'/>",
                type: 'post',
                data: data_search,
                dataType: "json",
                success: function(data) {
                	/*
                    var parsedData = $.parseJSON(data);
                    if(parsedData == 1 ) {
                        var target_url = "/uploads/user_list/user_list.xlsx";
                        window.open(target_url, 'excel');
                    } else {
                        alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=1');
                    }
                    */
                    
                    if(data != null && data.rtnCode == "") {
                    	var target_url = "<c:url value='/uploads/user_list/user_list.xls'/>";
                        window.open(target_url, 'excel');
                    } else {
                        alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=1');
                    }
                },
                error: function(xhr, desc, err) {
                    alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=2');
                }
            });
        });
        $("#btn-excel-import").on('change', function () {
            if ($("#btn-excel-import")[0].files[0]) {
                uploadUserListAjax();
            }
        });
        $(".btn-excel-import-base").click(function(e) {
            var target_url = "/uploads/user_list/user_list_import_reference.xlsx";
            window.open(target_url, 'excel');
        });
        $(".btn-sms").click(function(e) {
            showSMSSendDialog();
        });
        $(".btn-delete-selected").click(function(e) {
            deleteSelectedUser();
        });
        $(".btn-selected-exel-export").click(function(e) {

        });
        $(".btn-selected-label-excel-export").click(function(e) {
            var user_export_array = [];
            var user_export_col_array = [];
            var user_export_col_name_array = [];
            $("#user_list_tbody").find(".checkboxes").each(function() {
                if($(this).is(":checked")) {
                    var user_index = $(this).parent().parent().parent().attr("user_index");
                    user_export_array.push(user_index);
                }
            });
            $('#user_option_tab_tbody td').each(function() {
            	if($(this).hasClass('active')) {
            		user_export_col_array.push($(this).attr('col'));
            		user_export_col_name_array.push($(this).text());
            	}
            });
            var data_export = {
                'user_export_array': user_export_array,
                'user_export_col_array' : user_export_col_array,
                'user_export_col_name_array' : user_export_col_name_array
            };
			
            $.ajax({
                url: "<c:url value='/user/exportLabelforSelectedUser.do'/>",
                type: 'post',
                data: data_export,
                dataType: "json",
                success: function(data) {
                	/*
                    var parsedData = $.parseJSON(data);
                    if(parsedData == 1 ) {
                        var target_url = "uploads/user_list/label_list.xlsx";
                        window.open(target_url, 'excel');
                    } else {
                        alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=1');
                    }
                    */
                    if(data != null && data.rtnCode == "") {
                    	var target_url = "<c:url value='/uploads/user_list/label_list.xls'/>";
                        window.open(target_url, 'excel');
                    } else {
                        alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=1');
                    }
                },
                error: function(xhr, desc, err) {
                    alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=2');
                }
            });
        });
        $("#btn_send_sms").click(function(e) {
            sendSMSAjax();
            $('#sms_send_dialog').modal('hide');
        });
        $("#btn_open_sms_message_form").click(function(e) {
            showSMSMessageFormDialog();
        });
        $("#sms_send_msg").unbind('keydown keyup mouseup');
        $("#sms_send_msg").bind('keydown keyup mouseup', function() {
            var smsType = getSMSType();
            if (smsType == 'L') {
                $("#notice_sms_balance").html("<i class='fa fa-check'></i>LMS로 보내기 : 한 번호당 3건 차감.");
            } else {
                $("#notice_sms_balance").html("<i class='fa fa-check'></i>SMS로 보내기 : 한 번호당 1건 차감.");
            }
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
        $("#open_additive_search_btn").click(function() {
            $("#additive_search").toggle();
        });
        $(".search_keyword_type").on('change', function () {
            var search_keyword_type = $(this).val();
            var search_keyword_id = $(this).attr('input-id');
            if(search_keyword_type == 'user_sex' || search_keyword_type == 'user_recognize_type' || search_keyword_type == 'user_is_driving_license' || search_keyword_type == 'user_konos_register_state'
                || search_keyword_type == 'user_register_channel' || search_keyword_type == 'user_withdraw_reason' || search_keyword_type == 'user_withdraw_way' || search_keyword_type == 'user_is_email_agree'
                || search_keyword_type == 'user_is_sms_agree' || search_keyword_type == 'user_is_mail_agree' || search_keyword_type == 'user_pledge_card_state' || search_keyword_type == 'consult_type'
                || search_keyword_type == 'user_is_legal_representative_text' || search_keyword_type == 'user_donation_type_body' || search_keyword_type == 'user_donation_type_organ' || search_keyword_type == 'user_donation_type_comea' ) {
                $(this).next().remove();
                var enum_object = enum_array[search_keyword_type];
                var option_html = "";
                jQuery.each(enum_object, function(key, val) {
                    option_html += "<option value='"+key+"'>"+val+"</option>";
                });
                $(this).after(
                    "<select id='"+search_keyword_id+"' class='search_keyword_type form-control input-small input-inline page-title-element horizontal-no-margin '>"
                    +option_html
                    +"</select>"
                );
            } else {
                $(this).next().remove();
                $(this).after(
                    '<input id="'+search_keyword_id+'" type="text" class="form-control input-small page-title-element horizontal-no-margin " placeholder="검색어">'
                );
            }
        });
        $("#add_message_form_btn").click(function() {
            showMessageForm(0,"");
        });
        // Set user_period_search_all clicked
        if(data_get == null) {
            $("#user_period_search_all").trigger('click');
        } else {
            $("#search_keyword_type1").val(data_get.search_keyword_type1);
            $("#search_keyword_type2").val(data_get.search_keyword_type2);
            $("#search_keyword_type3").val(data_get.search_keyword_type3);
            $("#search_keyword1").val(data_get.search_keyword1);
            $("#search_keyword2").val(data_get.search_keyword2);
            $("#search_keyword3").val(data_get.search_keyword3);
            $("#search_start_date").val(data_get.search_start_date);
            $("#search_end_date").val(data_get.search_end_date);
            $("#search_keyword_type1").val(data_get.search_keyword_type1);
            showUserListAjax(data_get.selected_page);
        }

    });
</script>