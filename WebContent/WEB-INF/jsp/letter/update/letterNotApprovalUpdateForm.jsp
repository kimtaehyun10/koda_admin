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
                <h1 class="page-title">우체통 글쓰기</h1>                
            </div>
        </div>
        <!-- END PAGE TITLE-->
        <!-- END PAGE HEADER-->
        <div class="row">
            <div class="col-md-12">
                <div class="portlet box blue-hoki ">
                    <div class="portlet-title">
                        <div class="caption">우체통 글쓰기(수정)</div>
                    </div>
                    <div class="portlet-body">
                    	<form name="fileFrm" id="fileFrm" class="form-horizontal" method="post" enctype="multipart/form-data" action="<c:url value='/mailbox/lettercUpdate.do'/>">
                    	<input type="hidden" name="letter_id" id="letter_id" value="${letter.letter_id }" />
				        <div class="row">
                           	<div class="col-md-12">
                           		<div class="form-group">
                           			<label class="col-md-1 control-label">보내는사람</label>
                                   	<div class="col-md-9">
                                    	<input id="sender_id" name="sender_id" type="hidden" class="form-control input-sm" placeholder="" value="${letter.sender_id }" readonly="readonly" />
                                        <input id="sender_name" name="sender_name" type="text" class="form-control input-sm" placeholder="" value="${letter.sender_name }" readonly="readonly" />
                                    </div>
                                    <c:if test="${letter.admin_reply_yn ne 'Y' }">
                                    <div class="col-md-2">
                                    	<input type="button" class="btn green" onClick="javscript:fnLetterSenderSearchPopup();" value="검색" />
                                    	<input type="button" class="btn green" onClick="javscript:fnLetterSenderSearchReset();" value="초기화" />
                                    </div>
                                    </c:if>
                                    <c:if test="${letter.admin_reply_yn eq 'Y' }">
                                    <div class="col-md-2">
                                    	<input type="button" class="btn green" onClick="javscript:fnLetterAdminSearchPopup();" value="예시글 불러오기" />
                                    	<input type="button" class="btn green" onClick="javscript:fnLetterAdminSearchReset();" value="초기화" />
                                    </div>
                                    </c:if>
                           		</div>                               
                               	<div class="form-group">                         
                                   	<label class="col-md-1 control-label">받는사람</label>
                                   	<div class="col-md-11">
                                       	<input id="letter_receiver_id" name="letter_receiver_id" type="hidden" class="form-control input-sm" placeholder="" value="${letter.receiver_id }" readOnly>
                                       	<input id="letter_receiver_name" name="letter_receiver_name" type="text" class="form-control input-sm" placeholder="" value="${letter.receiver_name }" readOnly>
                                   	</div>                                                                
                               	</div>
								<div class="form-group">
                           			<label class="col-md-1 control-label">제목</label>
                                   	<div class="col-md-11">
                                       	<input id="letter_title" name="letter_title" type="text" class="form-control input-sm" placeholder="" value="${letter.title }">
                                   	</div>
                           		</div>
                           	
                           		<div class="form-group">
                            		<label class="col-md-1 control-label">스킨</label>
                                    <div class="col-md-11">
                                    	<c:forEach var="letterSkin" items="${letterSkinList }" varStatus="status">
                                    		<label class="mt-checkbox">
                                    			${letterSkin.letter_skin_name }
                                    			<input name="letter_skin_id" type="radio" class="input-sm" value="${letterSkin.letter_skin_id }" <c:if test="${letterSkin.letter_skin_id eq letter.skin_id }"> checked </c:if>>
                                    			<span></span>
                                    		</label>
                                    	</c:forEach>
                                    </div>
                            	</div>
                           	
                           		<div class="form-group">
		                        	<label class="col-md-1 control-label">내용</label>
	                           		<div class="col-md-11">
			                        	<textarea class="ckeditor" id="letter_content" name="letter_content">${letter.content }</textarea>
                          			</div>
                      			</div>
                               
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">첨부파일 #1</label>
                                    <div class="col-md-3">                                        
										<input type="file" id="letter_file_org_nm1" name="letter_file_org_nm1" size="34"/>
                                    </div>                                                                                
                                    <div class="col-md-8">
                                    	<c:forEach var="letterFile" items="${letterFileList }">
                                    		<c:if test="${letterFile.letter_file_seq eq '1' }">
                                    			<input type="hidden" id="delFile1Name" name="delFile1Name" value="${letterFile.letter_file_org_nm  }" />
                                    			<input type="checkbox" name="delFile1" id="delFile1"/> 파일 삭제 (${letterFile.letter_file_org_nm }) ※ 파일을 삭제하지 않으셨더라도 파일을 추가하신다면 자동으로 삭제됩니다.
                                    		</c:if>
                                    	</c:forEach>
									</div>                          
                                </div>
                               
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">첨부파일 #2</label>
                                    <div class="col-md-3">                                        
										<input type="file" id="letter_file_org_nm2" name="letter_file_org_nm2" size="34"/>
                                    </div>
                                    <div class="col-md-8">
										<c:forEach var="letterFile" items="${letterFileList }">
                                    		<c:if test="${letterFile.letter_file_seq eq '2' }">
                                    			<input type="hidden" id="delFile2Name" name="delFile2Name" value="${letterFile.letter_file_org_nm  }" />
                                    			<input type="checkbox" name="delFile2" id="delFile2"/> 파일 삭제 (${letterFile.letter_file_org_nm }) ※ 파일을 삭제하지 않으셨더라도 파일을 추가하신다면 자동으로 삭제됩니다.
                                    		</c:if>
                                    	</c:forEach>
									</div>                                                                                                          
                                </div>
                               
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">첨부파일 #3</label>
                                    <div class="col-md-3">                                        
										<input type="file" id="letter_file_org_nm3" name="letter_file_org_nm3" size="34"/>
                                    </div>
                                    <div class="col-md-8">
										<c:forEach var="letterFile" items="${letterFileList }">
                                    		<c:if test="${letterFile.letter_file_seq eq '3' }">
                                    			<input type="hidden" id="delFile3Name" name="delFile3Name" value="${letterFile.letter_file_org_nm  }" />
                                    			<input type="checkbox" name="delFile3" id="delFile3"/> 파일 삭제 (${letterFile.letter_file_org_nm }) ※ 파일을 삭제하지 않으셨더라도 파일을 추가하신다면 자동으로 삭제됩니다.
                                    		</c:if>
                                    	</c:forEach>
									</div>                                                                                                          
                                </div>
                               
                                <div class="form-group">
                            		<label class="col-md-1 control-label">상태</label>
                                    <div class="col-md-11">
                                       	<label class="mt-checkbox">미승인<input name="letter_status" type="radio" class="input-sm" value="notApproval" <c:if test="${letter.status eq 'notApproval' }"> checked </c:if>><span></span></label>
                                        &nbsp;&nbsp;&nbsp;
                                        <label class="mt-checkbox">승인<input name="letter_status" type="radio" class="input-sm" value="approval" <c:if test="${letter.status eq 'approval' }"> checked </c:if>><span></span></label>
                                        &nbsp;&nbsp;&nbsp;
                                        <label class="mt-checkbox">반송<input name="letter_status" type="radio" class="input-sm" value="return" <c:if test="${letter.status eq 'return' }"> checked </c:if>><span></span></label>
                                        &nbsp;&nbsp;&nbsp;
                                        <label class="mt-checkbox">발송대기<input name="letter_status" type="radio" class="input-sm" value="sendStay" <c:if test="${letter.status eq 'sendStay' }"> checked </c:if>><span></span></label>
                                    </div>
                            	</div>
                           	
                            	<div class="form-group">
		                        	<label class="col-md-1 control-label">반송사유</label>
	                           		<div class="col-md-11">
			                        	<textarea class="ckeditor" id="letter_return_reason" name="letter_return_reason" >${letter.return_reason }</textarea>
                          			</div>
                      			</div>
                            </div>
                            <div class="col-md-12">
			                	<div class="text-right">
						            <input type="button" class="btn red" name="btnList" id="btnList" onClick="javascript:fnList();" value="목록으로">
						            <c:if test="${letter.status ne 'approval' && letter.status ne 'return' }">
										<input type="submit" class="btn blue" value="수정"/>
									</c:if>
									<!-- <input type="button" class="btn purple" name="btnPreview" id="btnPreview" onClick="javascript:fnPreview();" value="미리보기"> -->
						        </div>
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
                      	<div class="col-md-10">
                      		<div id="letter_preview_skin">
                      			<span id="letter_preview_content"></span>
                      		</div>
                      	</div>
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
	var letter_status = $(':radio[name="letter_status"]:checked').val();
	var chkReadOnly;
	if(letter_status === 'return' || letter_status === 'sendStay') {
		chkReadOnly = false;
	} else {
		chkReadOnly = true;
	}
	
    CKEDITOR.replace('letter_content', {filebrowserUploadUrl:'/admin/ckeditorUpload.do',height:450});
    CKEDITOR.replace('letter_return_reason', {filebrowserUploadUrl:'/admin/ckeditorUpload.do',height:150, readOnly:chkReadOnly});
    
    $(':radio[name="letter_status"]').click(function(event) {
    	var letter_status = $(':radio[name="letter_status"]:checked').val();
    	if(letter_status === 'return' || letter_status === 'sendStay') {
    		CKEDITOR.instances.letter_return_reason.setData("매칭회원 없음.");
    		CKEDITOR.instances.letter_return_reason.setReadOnly(false);
    	} else {
    		CKEDITOR.instances.letter_return_reason.setData("");
    		CKEDITOR.instances.letter_return_reason.setReadOnly(true);
    	}
    });
    
	$("input:radio[name=letter_skin_id]").click(function() {
    	
    	if(!confirm('스킨변경시 글 내용이 초기화됩니다 진행하시겠습니까?')){
    		
    		$("input[name='letter_skin_id']:radio[value='" + preValue + "']").prop('checked', true);    		
    		return;
    	}
    	
		var radioVal = $('input[name="letter_skin_id"]:checked').val();
		if(radioVal === 'no'){			
			CKEDITOR.instances.letter_content.setData('');
			preValue = $("input[name='letter_skin_id']:checked").val(); //스킨 클릭 이벤트 발생 전 선택된 값 재 설정			
			return;
		}
		$.ajax({
			url: "<c:url value='/mailbox/letterPreview.do'/>",
		    type: 'post',
		    contentType: "application/x-www-form-urlencoded; charset=UTF-8",           
		    dataType: "json",
		    data: {
		    	letter_skin_id: radioVal
			},
		    success: function(data) {		    			    	
		    	var html1 = '';
		    	html1 += '<table border="0" cellpadding="0" cellspacing="0" height="1733" width="1100">'
		    	html1 += '<tr style="background-image:url(/imageView.do?imageName='+data.letter_skin_file_nm+'); background-repeat:no-repeat;">'
		    	html1 += '<td style="padding:20px 35px;" valign="top">'
		    	html1 += '</td>'
		    	html1 += '</tr>'
		    	html1 += '</table>'
		    	CKEDITOR.instances.letter_content.setData(html1);
		    	
		    	preValue = $("input[name='letter_skin_id']:checked").val(); //스킨 클릭 이벤트 발생 전 선택된 값 재 설정
		   	},
		   	error: function(xhr, desc, err) {
		    	
		    }
		});
		
    });
});

function fnLetterSenderSearchPopup() {
	var screenW = screen.availWidth;  
	var screenH = screen.availHeight; 
	var popW = 1000; 
	var popH = 750; 
	var posL=( screenW-popW ) / 2;    
	var posT=( screenH-popH ) / 2;	
	window.name = "senderForm";
    openWin = window.open('<c:url value='/mailbox/letterSenderSearchPopup.p'/>', 'childForm', 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=yes,status=no,titlebar=no');    
}

function fnPosterSenderSearchReset() {
	$('#sender_id').val('');
	$('#sender_name').val('');
	$('#letter_recevier_id').val('');
	$('#letter_recevier_name').val('');
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

function fnList() {
	location.href='<c:url value="/mailbox/letterNotApprovalList.do"/>';
}

function fnPreview() {
	$.ajax({
		url: "<c:url value='/mailbox/letterPreviewImage.do'/>",
	    type: 'post',
	    contentType: "application/x-www-form-urlencoded; charset=UTF-8",           
	    dataType: "json",
	    data: {
	    	letter_id: '${letter.letter_id}',
	    	letter_skin_id: $(':radio[name="letter_skin_id"]:checked').val()
		},
	    success: function(data) {
	    	var imgUrl = data.skinImage;
	    	var cont = data.letter_content.replace('{내용}', CKEDITOR.instances.letter_content.getData());
	    	$("#letter_preview_skin").css({"background":"url("+imgUrl+")"}); 	
	    	$("#letter_preview_skin").css("width","100%"); 	
	    	$("#letter_preview_skin").css("height","100%"); 	
	    	$("#letter_preview_skin").css("background-repeat","round"); 	
	    	$('#letter_preview_content').html(cont);
	    	$('#letter_preview_sender').text($('#sender_name').val());
	    	$('#letter_preview_receiver').text($('#letter_receiver_name').val());
	    	
	    	if($("#letter_file_org_nm1")[0].files.length > 0) {
	    		$('#letter_preview_file1').text($("#letter_file_org_nm1")[0].files[0].name);
	    	} else {
	    		$('#letter_preview_file1').text($("#delFile1Name").val());
	    	}
	    	
	    	if($("#letter_file_org_nm2")[0].files.length > 0) {
	    		$('#letter_preview_file2').text($("#letter_file_org_nm2")[0].files[0].name);
	    	} else {
	    		$('#letter_preview_file2').text($("#delFile2Name").val());
	    	}
	    	
	    	if($("#letter_file_org_nm3")[0].files.length > 0) {
	    		$('#letter_preview_file3').text($("#letter_file_org_nm3")[0].files[0].name);
	    	} else {
	    		$('#letter_preview_file3').text($("#delFile3Name").val());
	    	}
	   	},
	   	error: function(xhr, desc, err) {
	    	
	    }
	});
	$('#preview_dialog').modal('show');
}

</script>