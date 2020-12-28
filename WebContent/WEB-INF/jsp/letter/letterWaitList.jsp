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
<link href="${pageContext.request.contextPath}/common/css/card_style.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css" />

<!-- BEGIN CONTENT -->
<div class="page-content-wrapper">
	<!-- BEGIN CONTENT BODY -->
    <div class="page-content">
    	<!-- BEGIN PAGE HEADER-->                    
        <!-- END PAGE HEADER-->
        <div class="row" style="margin-top: 70px;">
        	<div class="col-md-12">
            	<!-- BEGIN SAMPLE TABLE PORTLET-->
                <div class="portlet light portlet-fit bordered">
                	<div class="portlet-title">
                    	<div class="caption">
                        	<span class="caption-subject font-dark bold uppercase">▶ 우체통 현황</span>
                        </div>
                    </div>    
                </div>
				
				<div class="portlet-body">
                	<form name="schFrm" id="schFrm" method="post" action="<c:url value="/mailbox/letterWaitList.do"/>">
                		<input type="hidden" name="page" id="page" value="${param.page}"/>
                		<input type="hidden" name="status" id="status" value="sendStay"/>
                      	<table class="table table-bordered">
                      		<tr>
                      			<th rowspan="3">검색<br/>조건</th>
                      			<td style="text-align: left;">
                      				<div>
										<select class="post_select" id="gubn" name="gubn">
											<option value="">구분</option>
											<option value="D" <c:if test="${param.gubn eq 'D'}"> selected </c:if> >기증자가족</option>
											<option value="B" <c:if test="${param.gubn eq 'B'}"> selected </c:if> >수혜자</option>
										</select>
										
										<select class="post_select" id="senderType" name="senderType">
											<option value="">보내는사람</option>
											<option value="ID" <c:if test="${param.senderType eq 'ID'}"> selected </c:if> >아이디</option>
											<option value="NAME" <c:if test="${param.senderType eq 'NAME'}"> selected </c:if> >이름</option>
											<option value="PHONE" <c:if test="${param.senderType eq 'PHONE'}"> selected </c:if> >연락처</option>
										</select>
										<input type="text" class="post_input300" id="senderText" name="senderText" value="${param.senderText }" />
										
										<select class="post_select" id="receiverType" name="receiverType">
											<option value="">받는사람</option>
											<option value="ID" <c:if test="${param.receiverType eq 'ID'}"> selected </c:if> >아이디</option>
											<option value="NAME" <c:if test="${param.receiverType eq 'NAME'}"> selected </c:if> >이름</option>
											<option value="PHONE" <c:if test="${param.receiverType eq 'PHONE'}"> selected </c:if> >연락처</option>
										</select>
										<input type="text" class="post_input300" id="receiverText" name="receiverText" value="${param.receiverText }" />
									</div>
                      			</td>
                      			<td rowspan="3">
                      				<a id="btnSearch" class="btn dark btn-outline btn-circle btn-sm" style="height: 100%;" href="#">검색</a>
                      			</td>
                      		</tr>
                      		<tr>
                      			<td style="text-align: left;">
                      				발송일 
                      				<input type="text" size="20" name="startDate" id="startDate" class="form_datetime" value="${param.startDate}">
									~
									<input type="text" size="20" name="endDate" id="endDate" class="form_datetime" value="${param.endDate}"> 
                      			</td>
                      		</tr>
                      	</table>     
                    </form>                   	
                </div>
				
				<div>
			        <div class="text-right">
			            <input type="button" class="btn blue" name="btnExcel" id="btnExcel" onClick="javascript:fnExcel();" value="엑셀 다운로드">
			        </div>
			    </div>
				
                <form name="Frm" id="Frm" method="post" action="">
                	<input type="hidden" id="letter_id" name="letter_id" value="" />
                	<div class="portlet-body">
                        <div class="table-scrollable">
                        	<table class="table table-hover">
                                  <thead>
                                      <tr>
                                      	  <th>No</th>
					                      <th>구분</th>					                      
					                      <th>보내는사람</th>					                      					                      					                      				                      					                      
					                      <th>받는사람</th>
					                      <th>제목</th>
					                      <th>발송일</th>
					                      <th>수신일</th>
					                      <th>상태</th>
					                      <th>관리</th>
					                  </tr>
					                  
                                  </thead>
                                  <tbody>
									<c:forEach var="letter" items="${letterList}" varStatus="status">                                      
                                      <tr>
                                      	  <td>${(total_count - status.index) - ( (currentPage - 1)  *  displayNum ) }</td>                    	                                                                                 
                                          <td>
                                          	<c:if test="${letter.gubn eq 'D'}">기증자가족</c:if>
                                          	<c:if test="${letter.gubn eq 'B'}">수혜자</c:if>
                                          </td>
                                          <td>
                                          	${letter.sender_name}(${letter.sender_id })
                                          	<a onclick="javascript:fnShowSmsModal('${letter.sender_phone }', '${letter.receiver_phone }')"><button class="btn btn-default" type="button">SMS</button></a>
                                          </td>
                                          <td>
                                          	${letter.receiver_name}
                                          	<c:if test="${not empty letter.receiver_id }">
                                          		(${letter.receiver_id })
                                          	</c:if>
                                          	<c:if test="${not empty letter.receiver_id }">
                                          		<a onclick="javascript:fnShowSmsModal('${letter.receiver_phone }', '${letter.sender_phone }');"><button class="btn btn-default" type="button">SMS</button></a>
                                          	</c:if>
                                          </td>
                                          <td style="text-align:left;">
                                          	<c:forEach begin="0" end="${letter.depth }">
                                          		&nbsp;&nbsp;
                                          	</c:forEach>
                                          	<a href="javascript:fnLetterViewForm('${letter.letter_id}')">${letter.title}</a>
                                          </td>
                                          <td>
                                          	<fmt:formatDate value="${letter.sender_date }" pattern="yyyy-MM-dd" var="sender_date_fmt"/>
                                          	${sender_date_fmt}
                                          </td>
                                          <td>
                                          	<fmt:formatDate value="${letter.receiver_date }" pattern="yyyy-MM-dd" var="receiver_date_fmt"/>
                                          	${receiver_date_fmt}
                                          </td>
                                          <td>
                                          	<c:if test="${letter.status eq 'notApproval' }">미승인</c:if>
                                          	<c:if test="${letter.status eq 'approval' }">승인</c:if>
                                          	<c:if test="${letter.status eq 'return' }">반송<br/><font color="red"><b><a href="javascript:fnShowReturnReasonModal('${letter.return_reason }')">[보기]</a></b></font></c:if>
                                          	<c:if test="${letter.status eq 'sendStay' }">발송대기</c:if>
                                          	
                                          </td>
                                          <td style="text-align: left;">
                                          	<c:if test="${letter.status eq 'notApproval' || letter.status eq 'sendStay' }">
                                          		<a onclick="fnLetterUpdateForm(${letter.letter_id});"><button class="btn btn-default btn-circle mt-sweetalert" type="button"><i class="fa fa-paste"></i> 수정</button></a>
                                          		<a onclick="fnLetterDeleteForm(${letter.letter_id})"><button class="btn btn-danger btn-circle mt-sweetalert" type="button"><i class="fa fa-times"></i> 삭제</button></a>	
                                          	</c:if>
                                          </td>
                                      </tr>
                                      </c:forEach>
                                      <c:if test="${fn:length(letterList) eq 0 }">
                                      <tr>
                                      	<td colspan="8">데이터가 존재하지 않습니다.</td>
                                      </tr>
                                      </c:if>
                                  </tbody>
                              </table>
                        </div>
                    </div>
                    </form>
                </div>
                <!-- END SAMPLE TABLE PORTLET-->
				<nav aria-label="Page navigation" style="margin-top: 50px; text-align: center;">
                	<ul class="pagination my_pagetion">
                    	<c:if test="${not empty paginationInfo}"> <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_search"/> </c:if>
                    </ul>
                </nav>
                
                <div class="col-md-12">
                	<div class="text-right">
			            <input type="button" class="btn dark" name="btnWrite" id="btnWrite" onClick="javascript:fnLetterWriteForm();" value="편지쓰기">
			        </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END CONTENT BODY -->


<div id="sms_send_dialog" class="modal fade" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog">
    	<div class="modal-content">
        	<div class="modal-header">
            	<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
               	<h4 class="modal-title">※ 문자발송</h4>
           	</div>
           	<div class="modal-body">
            	<div class="" style="height:300px" data-always-visible="1" data-rail-visible1="1">
                	<div class="row">
                    	<div class="col-md-4"><h5>수신번호</h5></div>
                       	<div class="col-md-8">
                       		<input type="text" id="sms_sender_phone_no" name="sms_sender_phone_no" class="form-control col-md-12 input-sm" readonly="readonly"/>
                       	</div>
                   	</div>
                   	<div class="row">
                    	<div class="col-md-4"><h5>발신번호</h5></div>
                       	<div class="col-md-8">
                       		<input type="text" id="sms_receiver_phone_no" name="sms_receiver_phone_no" class="form-control col-md-12 input-sm"/>
                       	</div>
                   	</div>
                   	<div class="row">
                    	<div class="col-md-4"><h5>제목</h5></div>
                       	<div class="col-md-8">
                       		<input type="text" id="sms_title" name="sms_title" class="form-control col-md-12 input-sm" />
                      	</div>
                   	</div>
                   	<div class="row">
                    	<div class="col-md-4"><h5>내용</h5></div>
                       	<div class="col-md-8">
                       		<textarea id="sms_content" name="sms_content" class="form-control col-md-12 input-sm" rows="9"></textarea>
                       	</div>
                   	</div>
               	</div>
           	</div>
           	<div class="modal-footer">
            	<input type="button" type="button" class="btn blue" onclick="javascript:fnSendSms();" value="보내기"></input>
            </div>
        </div>
    </div>
</div>

<div id="return_reason_dialog" class="modal fade" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog">
    	<div class="modal-content">
        	<div class="modal-header">
            	<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
               	<h4 class="modal-title">※ 반송사유</h4>
           	</div>
           	<div class="modal-body">
            	<div class="" style="height:300px" data-always-visible="1" data-rail-visible1="1">
                	<div class="row">
                       	<div class="col-md-12">
                       		<textarea class="ckeditor" id="letter_return_reason" name="letter_return_reason"></textarea>
                       	</div>
                    </div>
               	</div>
           	</div>
        </div>
    </div>
</div>

<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery_redirect/jquery.redirect.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="/common/ckeditor/ckeditor.js"></script>
  
<script>
$(document).ready(function() {
    CKEDITOR.replace('letter_return_reason', {height:150, readOnly:true});
});

$(".form_datetime").datetimepicker({
    autoclose: true,
    isRTL: App.isRTL(),
    format: "yyyy-mm-dd",
    minView: 2,
    maxView: 3,
    fontAwesome: true,
    initialDate: new Date(),
    pickerPosition: (App.isRTL() ? "bottom-right" : "bottom-left")
}).on('changeDate', function(ev){        
});

function fn_search(pageNo) {		
	$('#page').val(pageNo);
	$('#schFrm').submit();
};

$('#btnSearch').on('click', function(e){
	e.preventDefault();
	$('#page').val('1');
	$('#schFrm').submit();
});

function fnLetterWriteForm(){
	location.href="<c:url value='/mailbox/letterWaitWriteForm.do'/>";
}

function fnLetterViewForm(letter_id) {
	$("#letter_id").val(letter_id);
	$('#Frm').attr("action","/mailbox/letterWaitView.do");
	$('#Frm').submit();
}

function fnLetterUpdateForm(letter_id) {
	$("#letter_id").val(letter_id);
	$('#Frm').attr("action","/mailbox/letterWaitUpdateForm.do");
	$('#Frm').submit();
}

function fnLetterDeleteForm(letter_id) {
	var searchParam = {
		letter_id: letter_id
	}
	$.ajax({
		url: "<c:url value='/mailbox/ajaxLetterReplyCheck.do'/>",
        type: 'post',
        data: searchParam,
        dataType: "json",
        success: function(data) {
        	if(data.rtnCode === '-1') {
       			alert(data.rtnMsg);
       			return;
       		} else {
       			if(del()){
       				$("#letter_id").val(letter_id);
       				$('#Frm').attr("action","/mailbox/letterDelete.do");
       				$('#Frm').submit();
       			}
       		}
         },
         error: function(xhr, desc, err) {
             alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=2');
         }
     });
}

function fnExcel() {
	var searchParam = {
		gubn: $("#gubn option:selected").val(),
		senderType: $("#senderType option:selected").val(),
		senderText: $("#senderText").val(),
		receiverType: $("#receiverType option:selected").val(),
		receiverText: $("#receiverText").val(),
		startDate: $("#startDate").val(),
		endDate: $("#endDate").val(),
		status: 'sendStay',
	}
	
	$.ajax({
		url: "<c:url value='/mailbox/exportExcelLetterList.do'/>",
        type: 'post',
        data: searchParam,
        dataType: "json",
        success: function(data) {
             if(data != null && data.rtnCode == "") {
             	var target_url = "<c:url value='/uploads/letter_list/letter_list.xls'/>";
                 window.open(target_url, 'excel');
             } else {
                 alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=1');
             }
         },
         error: function(xhr, desc, err) {
             alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=2');
         }
     });
}

function fnShowSmsModal(sender_phone_no, receiver_phone_no) {
	//$("#sms_sender_phone_no").val(sender_phone_no);
	$("#sms_sender_phone_no").val("02-3785-3177");
	$("#sms_receiver_phone_no").val(receiver_phone_no);
	$('#sms_send_dialog').modal('show');
}

function fnShowReturnReasonModal(return_reason) {
	CKEDITOR.instances.letter_return_reason.setData(return_reason);
	$('#return_reason_dialog').modal('show');
}

function fnSendSms() {
	var obj = {};
	
	if($('#sms_sender_phone_no').val().trim() === '') {
		alert('수신번호가 존재하지 않습니다.');
		return;
	}
	
	if($('#sms_receiver_phone_no').val().trim() === '') {
		alert('발신번호가 존재하지 않습니다.');
		return;
	}
	
	if($('#sms_title').val().trim() === '') {
		alert('제목이 존재하지 않습니다.');
		return;
	}
	
	if($('#sms_content').val().trim() === '') {
		alert('내용이 존재하지 않습니다.');
		return;
	}
	
	var regHp = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
	/*
	if(!regHp.test($('#sms_sender_phone_no').val().trim())) {
	      alert("잘못된 휴대폰 번호입니다. 숫자, - 를 포함한 숫자만 입력하세요.");
	      return;
	}
	*/
	
	if(!regHp.test($('#sms_receiver_phone_no').val().trim())) {
	      alert("잘못된 휴대폰 번호입니다. 숫자, - 를 포함한 숫자만 입력하세요.");
	      return;
	}
	
	obj.sms_sender_phone_no = $('#sms_sender_phone_no').val().trim();
	obj.sms_receiver_phone_no = $('#sms_receiver_phone_no').val().trim();
	obj.sms_title = $('#sms_title').val().trim();
	obj.sms_content = $('#sms_content').val().trim();
	
	$.ajax({
		url: "<c:url value='/mailbox/ajaxSendSms.do'/>",
        type: 'post',
        data: obj,
        dataType: "json",
        success: function(data) {
            /* var parsedData = $.parseJSON(data); */
            if(data != null && data.rtnCode == "") {
                toastr.options = {"positionClass": "toast-bottom-center"};
                toastr.success(data.rtnMsg);
            } else {
            	toastr.options = {"positionClass": "toast-bottom-center"};
	            toastr.success(data.rtnMsg);
            }
        },
        error: function(xhr, desc, err) {
            alert('SMS 전송에 실패했습니다. 잠시후에 다시 해주시기 바랍니다.')
        }
     });
}

function showTotalSMSCount() {
    $.ajax({
        url: "<c:url value='/user/getSMSTotalCountAjax.do'/>",
        type: 'post',
        dataType: "json",
        data: {},
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
</script>