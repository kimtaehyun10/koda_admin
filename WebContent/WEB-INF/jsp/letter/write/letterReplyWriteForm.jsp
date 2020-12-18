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
<div id="page_content" class="page-content-wrapper">
    <!-- BEGIN CONTENT BODY -->
    <div class="page-content">    	 
        <!-- BEGIN PAGE TITLE-->
        <div class="row" style="margin-top: 70px;">
            <div class="col-md-7">            	
                <h1 class="page-title">우체통 답장쓰기</h1>                
            </div>
        </div>
        <!-- END PAGE TITLE-->
        <!-- END PAGE HEADER-->
        <div class="row">
            <div class="col-md-12">
                <div class="portlet box blue-hoki ">
                    <div class="portlet-title">
                        <div class="caption">우체통 답장쓰기(입력)</div>
                    </div>
                    <div class="portlet-body">
                    	<form name="fileFrm" id="fileFrm" class="form-horizontal" method="post" enctype="multipart/form-data" action="<c:url value='/mailbox/letterReplySave.do'/>">
                    	<input type="hidden" name="group_id" value="${letter.group_id }" />
                    	<input type="hidden" name="group_order" value="${letter.group_order }" />
                    	<input type="hidden" name="depth" value="${letter.depth }" />
                    	<input type="hidden" name="admin_reply_yn" value="Y" />
				        <div class="row">
                           	<div class="col-md-12">
                           		<div class="form-group">
                           			<label class="col-md-1 control-label">보내는사람</label>
                                   	<div class="col-md-9">
                                    	<input id="sender_id" name="sender_id" type="text" class="form-control input-sm" placeholder="" value=""/>
                                        <input id="sender_name" name="sender_name" type="text" class="form-control input-sm" placeholder="" value=""/>
                                    </div>
                                    <div class="col-md-2">
                                    	<input type="button" class="btn green" onClick="javscript:fnLetterAdminSearchPopup();" value="예시글 불러오기" />
                                    	<input type="button" class="btn green" onClick="javscript:fnLetterAdminSearchReset();" value="초기화" />
                                    </div>
                           		</div>                               
                               	<div class="form-group">                         
                                   	<label class="col-md-1 control-label">받는사람</label>
                                   	<div class="col-md-11">
                                       	<input id="letter_receiver_id" name="letter_receiver_id" type="hidden" class="form-control input-sm" placeholder="" value="${letter.sender_id }" readOnly>
                                       	<input id="letter_receiver_name" name="letter_receiver_name" type="text" class="form-control input-sm" placeholder="" value="${letter.sender_name }" readOnly>
                                   	</div>                                                                
                               	</div>
								<div class="form-group">
                           			<label class="col-md-1 control-label">제목</label>
                                   	<div class="col-md-11">
                                       	<input id="letter_title" name="letter_title" type="text" class="form-control input-sm" placeholder="" value="[RE] ${letter.title } ">
                                   	</div>
                           		</div>
                           	
                           		<div class="form-group">
                            		<label class="col-md-1 control-label">스킨</label>
                                    <div class="col-md-11">
                                    	<c:forEach var="letterSkin" items="${letterSkinList }" varStatus="status">
                                    		<label class="mt-checkbox">
                                    			${letterSkin.letter_skin_name }
                                    			<input id="letter_skin_id" name="letter_skin_id" type="radio" class="input-sm" value="${letterSkin.letter_skin_id }" <c:if test="${status.index eq 0 }"> checked </c:if>>
                                    			<span></span>
                                    		</label>
                                    	</c:forEach>
                                    </div>
                            	</div>
                           	
                           		<div class="form-group">
		                        	<label class="col-md-1 control-label">내용</label>
	                           		<div class="col-md-11">
			                        	<textarea class="ckeditor" id="letter_content" name="letter_content">
			                        		<br />
				                        	==================================================================<br />
				                        	<b>From</b>:${letter.sender_name }<br />
				                        	<b>Send</b>:${letter.sender_date }<br />
				                        	<b>Subject</b>:${letter.title }<br />
				                        	${letter.content }
			                        	</textarea>
                          			</div>
                      			</div>
                               
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">첨부파일 #1</label>
                                    <div class="col-md-11">                                        
										<input type="file" id="letter_file_org_nm1" name="letter_file_org_nm1" size="34"/>
                                    </div>                                                                                                          
                                </div>
                               
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">첨부파일 #2</label>
                                    <div class="col-md-11">                                        
										<input type="file" id="letter_file_org_nm2" name="letter_file_org_nm2" size="34"/>
                                    </div>                                                                                                          
                                </div>
                               
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">첨부파일 #3</label>
                                    <div class="col-md-11">                                        
										<input type="file" id="letter_file_org_nm3" name="letter_file_org_nm3" size="34"/>
                                    </div>                                                                                                          
                                </div>
                               
                                <div class="form-group">
                            		<label class="col-md-1 control-label">상태</label>
                                    <div class="col-md-11">
                                        	<label class="mt-checkbox">미승인<input name="letter_status" type="radio" class="input-sm" value="notApproval" checked><span></span></label>
                                        &nbsp;&nbsp;&nbsp;
                                        <label class="mt-checkbox">승인<input name="letter_status" type="radio" class="input-sm" value="approval"><span></span></label>
                                        &nbsp;&nbsp;&nbsp;
                                        <label class="mt-checkbox">반송<input name="letter_status" type="radio" class="input-sm" value="return"><span></span></label>
                                        &nbsp;&nbsp;&nbsp;
                                        <label class="mt-checkbox">발송대기<input name="letter_status" type="radio" class="input-sm" value="sendStay"><span></span></label>
                                    </div>
                            	</div>
                           	
                            	<div class="form-group">
		                        	<label class="col-md-1 control-label">반송사유</label>
	                           		<div class="col-md-11">
			                        	<textarea class="ckeditor" id="letter_return_reason" name="letter_return_reason"></textarea>
                          			</div>
                      			</div>
                            </div>
                            <div class="col-md-offset-5 col-md-7">
								<input type="submit" class="btn green" value="저장"/>
								<input type="button" class="btn green" name="list" id="list" onClick="javascript:fnList();" value="목록으로">
							</div>
						</div>
						</form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END CONTENT BODY -->
</div>
<!-- END CONTENT -->
<!-- END CONTAINER -->
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery_redirect/jquery.redirect.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/printThis/printThis.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="/common/ckeditor/ckeditor.js"></script>

<script>
$(document).ready(function() {
    CKEDITOR.replace('letter_content', {filebrowserUploadUrl:'/admin/ckeditorUpload.do',height:200});
    CKEDITOR.replace('letter_return_reason', {filebrowserUploadUrl:'/admin/ckeditorUpload.do',height:150, readOnly:true});
    
    
    $(':radio[name="letter_status"]').click(function(event) {
    	var letter_status = $(':radio[name="letter_status"]:checked').val();
    	if(letter_status === 'return' || letter_status === 'sendStay') {
    		CKEDITOR.instances.letter_return_reason.setReadOnly(false);
    		CKEDITOR.instances.letter_return_reason.setData("매칭회원 없음.");
    	} else {
    		CKEDITOR.instances.letter_return_reason.setData("");
    		CKEDITOR.instances.letter_return_reason.setReadOnly(true);
    	}
    });
});

function fnList() {
	location.href='<c:url value="/mailbox/letterList.do"/>';
}

function fnLetterAdminSearchPopup() {
	var screenW = screen.availWidth;  
	var screenH = screen.availHeight; 
	var popW = 900; 
	var popH = 600; 
	var posL=( screenW-popW ) / 2;    
	var posT=( screenH-popH ) / 2;	
	window.name = "senderForm";
    openWin = window.open('<c:url value='/mailbox/letterAdminSearchPopup.p'/>', 'childForm', 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=yes,status=no,titlebar=no');    
}

function fnLetterrSearchPopupCallback(data) {
	$('#sender_id').val(data.sender_id);
	$('#sender_name').val(data.sender_name);
	$('#letter_title').val(data.title);
	
	var content = CKEDITOR.instances.letter_content.getData();
	CKEDITOR.instances.letter_content.setData(data.content + content);
}

function fnLetterAdminSearchReset() {
	$('#sender_id').val('');
	$('#sender_name').val('');
}
</script>