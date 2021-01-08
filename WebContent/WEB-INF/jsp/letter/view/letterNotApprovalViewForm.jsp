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
                <h1 class="page-title">우체통 상세보기</h1>                
            </div>
        </div>
        <!-- END PAGE TITLE-->
        <!-- END PAGE HEADER-->
        <div class="row">
            <div class="col-md-12">
                <div class="portlet box blue-hoki ">
                    <div class="portlet-title">
                        <div class="caption">우체통 상세보기</div>
                    </div>
                    <div class="portlet-body">
                    	<form name="fileFrm" id="fileFrm" class="form-horizontal" method="post" enctype="multipart/form-data" action="<c:url value='/mailbox/letterNotApprovalUpdate.do'/>">
                    	<input type="hidden" name="letter_id" id="letter_id" value="${letter.letter_id }" />
				        <div class="row">
                           	<div class="col-md-12">
                           		<div class="form-group">
                           			<label class="col-md-1 control-label">보내는사람</label>
                                   	<div class="col-md-11">
                                   		<input type="hidden" id="sender_name" value="${letter.sender_name }" />
                                   		${letter.sender_name }
                                   	</div>
                           		</div>                               
                               	<div class="form-group">                         
                                   	<label class="col-md-1 control-label">받는사람</label>
                                   	<div class="col-md-11">
                                   		<input type="hidden" id="receiver_name" value="${letter.receiver_name }" />
                                   		${letter.receiver_name }
                                   	</div>                                                                
                               	</div>
								<div class="form-group">
                           			<label class="col-md-1 control-label">제목</label>
                                   	<div class="col-md-11">
                                   		<input type="hidden" id="title" value="${letter.title }" />
                                   		${letter.title }
                                   	</div>
                           		</div>
                           	
                           		<div class="form-group">
                            		<label class="col-md-1 control-label">스킨명</label>
                                    <div class="col-md-11">
                                    	<input type="hidden" id="skin_id" value="${letter.skin_id }" />
                                    	<c:forEach var="letterSkin" items="${letterSkinList }" varStatus="status">
                                    		<c:if test="${letterSkin.letter_skin_id eq letter.skin_id }">${letterSkin.letter_skin_name }</c:if>
                                    	</c:forEach>
                                    </div>
                            	</div>
                           	
                           		<div class="form-group">
		                        	<label class="col-md-1 control-label">내용</label>
	                           		<div class="col-md-11">
	                           			<textarea rows="10" cols="10" id="content" style="display: none;">${letter.content }</textarea>
			                        	${letter.content }
                          			</div>
                      			</div>
                               
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">첨부파일 #1</label>
                                    <div class="col-md-11">                                        
										<c:forEach var="letterFile" items="${letterFileList }">
                                    		<c:if test="${letterFile.letter_file_seq eq '1' }">
                                    			<input type="hidden" id="delFile1Name" name="delFile1Name" value="${letterFile.letter_file_org_nm  }" />
                                    			<a href="javascript:fnFiledown('letter', '${letterFile.letter_id}', '${letterFile.letter_file_seq }')">${letterFile.letter_file_org_nm }</a>
                                    		</c:if>
                                    	</c:forEach>
                                    </div>
                                </div>
                               
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">첨부파일 #2</label>
                                    <div class="col-md-11">                                        
										<c:forEach var="letterFile" items="${letterFileList }">
                                    		<c:if test="${letterFile.letter_file_seq eq '2' }">
                                    			<input type="hidden" id="delFile2Name" name="delFile2Name" value="${letterFile.letter_file_org_nm  }" />
                                    			<a href="javascript:fnFiledown('letter', '${letterFile.letter_id}', '${letterFile.letter_file_seq }')">${letterFile.letter_file_org_nm }</a>
                                    		</c:if>
                                    	</c:forEach>
                                    </div>
                                </div>
                               
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">첨부파일 #3</label>
                                    <div class="col-md-11">                                        
										<c:forEach var="letterFile" items="${letterFileList }">
                                    		<c:if test="${letterFile.letter_file_seq eq '3' }">
                                    			<input type="hidden" id="delFile3Name" name="delFile3Name" value="${letterFile.letter_file_org_nm  }" />
                                    			<a href="javascript:fnFiledown('letter', '${letterFile.letter_id}', '${letterFile.letter_file_seq }')">${letterFile.letter_file_org_nm }</a>
                                    		</c:if>
                                    	</c:forEach>
                                    </div>                                                                                                          
                                </div>
                               
                                <div class="form-group">
                            		<label class="col-md-1 control-label">상태</label>
                                    <div class="col-md-11">
                                       	<c:if test="${letter.status eq 'notApproval' }">미승인</c:if>
                                       	<c:if test="${letter.status eq 'approval' }">승인</c:if>
                                       	<c:if test="${letter.status eq 'return' }">반송</c:if>
                                       	<c:if test="${letter.status eq 'sendStay' }">발송대기</c:if>
                                    </div>
                            	</div>
                           		<c:if test="${letter.status eq 'return' || letter.status eq 'sendStay'}">
	                            	<div class="form-group">
			                        	<label class="col-md-1 control-label">반송사유</label>
		                           		<div class="col-md-11">
				                        	<textarea class="ckeditor" id="letter_return_reason" name="letter_return_reason" >${letter.return_season}</textarea>
	                          			</div>
	                      			</div>
	                      		</c:if>
                            </div>
                            <div class="col-md-12" style="text-align: right;">
                            	<c:if test="${letter.status eq 'notApproval' || letter.status eq 'sendStay' }">
									<input type="button" class="btn green" name="btnModify" id="btnModify" onClick="javascript:fnLetterUpdateForm();" value="수정">
								</c:if>
								<input type="button" class="btn green" name="btnReply" id="btnReply" onClick="javascript:fnLetterReplyForm();" value="답장">
								<input type="button" class="btn green" name="btnList" id="btnList" onClick="javascript:fnList();" value="목록으로">
								<input type="button" class="btn purple" name="btnPreview" id="btnPreview" onClick="javascript:fnPreview();" value="미리보기">
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


<div id="preview_dialog" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
    	<div class="modal-content">
        	<div class="modal-header">
            	<h4 class="modal-title">※ 미리보기</h4>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		        	<span aria-hidden="true">&times;</span>
		        </button>
           	</div>
           	<div class="modal-body">
           		<div class="row">
                      	<div class="col-md-2"><strong>보내는 사람</strong></div>
                      	<div class="col-md-10"><span id="letter_preview_sender"></span></div>
                   </div>
                   <div class="row">
                      	<div class="col-md-2"><strong>받는 사람</strong></div>
                      	<div class="col-md-10"><span id="letter_preview_receiver"></span></div>
                   </div>
                   <div class="row">
                      	<div class="col-md-2"><strong>내용</strong></div>
                      	<div class="col-md-10"><span id="letter_preview_content"></span></div>
                   </div>
                   <div class="row">
                      	<div class="col-md-2"><strong>파일 #1</strong></div>
                      	<div class="col-md-10"><span id="letter_preview_file1"></span></div>
                   </div>
                   <div class="row">
                      	<div class="col-md-2"><strong>파일 #2</strong></div>
                      	<div class="col-md-10"><span id="letter_preview_file2"></span></div>
                   </div>
                   <div class="row">
                      	<div class="col-md-2"><strong>파일 #3</strong></div>
                      	<div class="col-md-10"><span id="letter_preview_file3"></span></div>
                   </div>
           	</div>
           	<div class="modal-footer">
		    	<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		    </div>
        </div>
    </div>
</div>

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
    CKEDITOR.replace('letter_return_reason', {filebrowserUploadUrl:'/admin/ckeditorUpload.do',height:150});
});

function fnList() {
	location.href='<c:url value="/mailbox/letterNotApprovalList.do"/>';
}

function fnLetterUpdateForm() {
	$('#fileFrm').attr("action","/mailbox/letterNotApprovalUpdateForm.do");
	$('#fileFrm').submit();
}

function fnLetterReplyForm() {
	$('#fileFrm').attr("action","/mailbox/letterNotApprovalReplyWriteForm.do");
	$('#fileFrm').submit();
}

function fnFiledown(type, letter_id, letter_file_seq) {
	var newForm = document.createElement('form');
	newForm.name = 'fileDownForm';
	newForm.method = 'post';
	newForm.action = '/mailbox/filedown.do';
	newForm.target = '_blank';
	var inputType = document.createElement('input'); inputType.setAttribute('type', 'hidden'); inputType.setAttribute('name', 'type'); inputType.setAttribute('value', type); newForm.appendChild(inputType);
	var inputLetterId = document.createElement('input'); inputLetterId.setAttribute('type', 'hidden'); inputLetterId.setAttribute('name', 'letter_id'); inputLetterId.setAttribute('value', letter_id); newForm.appendChild(inputLetterId);
	var inputLetterFileSeq = document.createElement('input'); inputLetterFileSeq.setAttribute('type', 'hidden'); inputLetterFileSeq.setAttribute('name', 'letter_file_seq'); inputLetterFileSeq.setAttribute('value', letter_file_seq); newForm.appendChild(inputLetterFileSeq);
	document.body.appendChild(newForm);
	newForm.submit();
}


function fnPreview() {
	$.ajax({
		url: "<c:url value='/mailbox/letterPreview.do'/>",
	    type: 'post',
	    contentType: "application/x-www-form-urlencoded; charset=UTF-8",           
	    dataType: "json",
	    data: {
	    	letter_skin_id: $('#skin_id').val()
		},
	    success: function(data) {
	    	var cont = data.letter_content.replace('{내용}', $("#content").val());
	    	$('#letter_preview_content').html(cont);
	    	$('#letter_preview_sender').text($('#sender_name').val());
	    	$('#letter_preview_receiver').text($('#receiver_name').val());
	    	$('#letter_preview_file1').text($("#delFile1Name").val());
	    	$('#letter_preview_file2').text($("#delFile2Name").val());
	    	$('#letter_preview_file3').text($("#delFile3Name").val());
	   	},
	   	error: function(xhr, desc, err) {
	    	
	    }
	});
	$('#preview_dialog').modal('show');
}
</script>