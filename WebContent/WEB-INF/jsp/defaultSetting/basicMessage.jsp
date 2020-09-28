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
	-문자발송
	1. 화면 css 수정 필요
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
                
                <button type="button" class="btn btn-sm btn-circle blue btn-outline page-title-element btn-sms align-left">일반 문자발송</button>
                    
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
                                        <!-- <textarea id="sms_send_mobile_list" name="sms_send_mobile_list" class="form-control col-md-12 input-sm" rows="9"></textarea> -->
                                        <input type="text" id="sms_send_mobile_list" name="sms_send_mobile_list" class="form-control col-md-12" placeholder="010-0000-0000">
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
        alert();
    }

    function showSMSSendDialog() {
        var sms_send_mobile_list_html = "";       
        window.sms_send_mobile_list_sentence = "";
        var checked_count = 0;
        showTotalSMSCount();
        
        $('#sms_send_msg').html('');        
        $('#sms_send_dialog').modal('show');
    }

    function showSMSMessageFormDialog() {
        $('#sms_message_form_dialog').modal('show');
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

    function initValue() {
        // sms form
        jQuery.each(sms_form_list, function(key, val) {
        	//console.log(val);
            showMessageForm(val.sms_form_index, val.sms_form_value);
        });

    }
    $(document).ready(function() {
        initValue();

        $("#search_btn").click(function(e) {
            showUserListAjax();
        });

        $(".btn-sms").click(function(e) {
            showSMSSendDialog();
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
        
        $("#add_message_form_btn").click(function() {
            showMessageForm(0,"");
        });
        

    });
</script>