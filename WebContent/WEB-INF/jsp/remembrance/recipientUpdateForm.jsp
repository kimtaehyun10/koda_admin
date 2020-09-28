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
       <form role="form" name="updateForm" id="updateForm" class="form-horizontal"> 

        <!-- BEGIN PAGE TITLE-->
        <div class="row">
            <div class="col-md-7">            	
                <h1 class="page-title"> 수혜자 편지 수정</h1>                
            </div>
            
        </div>
        <!-- END PAGE TITLE-->
        <!-- END PAGE HEADER-->
        <input type="hidden" name="story_idx" value="${selectedLetterStory.story_idx}">
		<input type="hidden" name="story_gubun" value="${selectedLetterStory.story_gubun}">
		<input type="hidden" name="story_contents" id="story_contents" value="">
		        
        <div class="row">
            <div class="col-md-12">
                <div class="portlet box blue-hoki ">
                    <div class="portlet-title">
                        <div class="caption">수혜자 편지 정보</div>
                    </div>
                    <div class="portlet-body">
                        <div class="row">
                            <div class="col-md-12">
                            	<div class="form-group">
                            		<label class="col-md-1 control-label">제목</label>
                                    <div class="col-md-11">
                                        <input id="donate_title" name="story_title" type="text" class="form-control input-sm" placeholder="" value="${fn:split(selectedLetterStory.story_title,'|')[0]}">  
                                    </div>
                            	</div>                               
                                <div class="form-group">                         
                                    <label class="col-md-1 control-label">수혜자</label>
                                    <div class="col-md-2">
                                        <input id="donate_age" name="story_writer" type="text" class="form-control input-sm" placeholder="" value="${selectedLetterStory.story_writer}">
                                    	<label class="mt-checkbox" >익명                                       	                                       	
                                            <input id="story_area" name=story_anonymity type="checkbox" class="input-sm" value="Y" ${selectedLetterStory.story_anonymity=='Y'?'checked':''}><span></span>
                                        </label>
                                    </div>
                                    <label class="col-md-1 control-label">비밀번호</label>
                                    <div class="col-md-2">
                                        <input id="donate_age" name="story_password" type="text" class="form-control input-sm" placeholder="" value="${selectedLetterStory.story_password}">
                                    </div>                                   
                                    <label class="col-md-1 control-label">기증받은 장기</label>
                                    <div class="col-md-2">
                                        <select class="form-control input-sm" name="story_area" id="story_area" style="width:200px;">
	                      					<option value="">전체</option>
	                      					<option value="1" ${selectedLetterStory.story_area=='1'?'selected':''}>신장</option>
	                      					<option value="2" ${selectedLetterStory.story_area=='2'?'selected':''}>간장</option>
	                      					<option value="3" ${selectedLetterStory.story_area=='3'?'selected':''}>췌장</option>
	                      					<option value="4" ${selectedLetterStory.story_area=='4'?'selected':''}>심장</option>
	                      					<option value="5" ${selectedLetterStory.story_area=='5'?'selected':''}>폐</option>
	                      					<option value="6" ${selectedLetterStory.story_area=='6'?'selected':''}>췌도</option>
	                      					<option value="7" ${selectedLetterStory.story_area=='7'?'selected':''}>소장</option>
	                      					<option value="8" ${selectedLetterStory.story_area=='8'?'selected':''}>대장</option>
	                      					<option value="9" ${selectedLetterStory.story_area=='9'?'selected':''}>위장</option>
	                      					<option value="10" ${selectedLetterStory.story_area=='10'?'selected':''}>십이지장</option>
	                      					<option value="11" ${selectedLetterStory.story_area=='11'?'selected':''}>비장</option>
	                      					<option value="12" ${selectedLetterStory.story_area=='12'?'selected':''}>손,팔</option>
	                      					<option value="13" ${selectedLetterStory.story_area=='13'?'selected':''}>안구</option>
	                      					<option value="14" ${selectedLetterStory.story_area=='14'?'selected':''}>인체조직</option>                     					                    					                      					                     					                   					                      					                      					                     					
	                      				</select>                                 	
                                    </div>                                                                                                        
                                    <label class="col-md-1 control-label">기증받은 년도</label>
                                    <div class="col-md-2">
                                        <input id="year" name="year" type="text" class="form-control input-sm" placeholder="" value="${fn:split(selectedLetterStory.story_title,'|')[1]}">
                                    </div>                                                                                                          
                                </div>
                                </form>                              
                                <div class="form-group">
                                    <label class="col-md-1 control-label">내용</label>
                                    <div class="col-md-11">
                                        <textarea class=" ckeditor" id="before_story_contents" name="before_story_contents" msg="내용을 " >${selectedLetterStory.story_contents}</textarea>
                                    </div>
                                </div>
                                
                            </div>
                            <!-- /.col-md-6 -->
                        </div>
                        <!-- /.row -->
                    </div>
                    
                    <div class="portlet-body">
                        <div class="row">
                            <div class="col-md-12">
                            	<span style="text-align: right; display: block;"><input type="button" value="댓글등록" onclick="letterStoryCommentWriteForm();" class="btn green btn-outline btn-circle btn-sm"></span>
                                
                                <c:forEach items="${letterStoryComment}" var="comment">
                                	<h5 class="form-title-line"></h5>
	                                <div class="form-group">
	                                    <label class="col-md-1 control-label">등록일</label>
	                                    <div class="col-md-2">
	                                        <input type="text" size="10" value="<fmt:formatDate value="${comment.com_reg_date}" pattern="yyyy-MM-dd" />" class="form-control input-sm" readonly>   
	                                    </div>
	                                    <label class="col-md-1 control-label">작성자</label>
	                                    <div class="col-md-2">
	                                        <input type="text" size="10" value="${comment.com_reg_name}" class="form-control input-sm" readonly>
	                                    </div>	                  
	                                    <div class="col-md-6" style="text-align: right;">
	                                        <input type="button" value="댓글수정" onclick="letterStoryCommentUpdateEnd(${comment.com_idx},'${comment.com_div}');" class="btn red btn-outline btn-circle btn-sm">
	                                        <input type="button" value="댓글삭제" onclick="letterStoryCommentDeleteEnd(${comment.com_idx},'${comment.com_div}');" class="btn red btn-outline btn-circle btn-sm">
	                                    </div>                                    
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label class="col-md-1 control-label">내용</label>
	                                    <div class="col-md-11">
	                                        <textarea id="com_content${comment.com_idx}" class="form-control input-sm" rows="5">${comment.com_content}</textarea>
	                                    </div>
	                                </div>
                                </c:forEach>                                                                
                                
                            </div>
                            
                            <!-- /.col-md-6 -->
                        </div>
                        <!-- /.row -->
                    </div>
                    
                    <div class="col-md-12 text-center">
                        <br>
                        <input type="button" class="btn green btn-outline btn-circle btn-sm" value="수정하기" onclick="letterStoryUpdateEnd();">
                        <br>&nbsp
                    </div>
                </div>
            </div>
        </div>
      
      <!-- 댓글등록 form -->
      <form id="commentFrm" action="<c:url value='/remembrance/letterStoryCommentWriteForm.p'/>" target="popup_window" method="post">
      	<input type="hidden" name="bod_idx" value="${selectedLetterStory.story_idx}">
      	<input type="hidden" name="com_div" value="${selectedLetterStory.story_gubun}">
      </form>
      
      <!-- 검색, 페이징 내용 저장해서 list로 보내기 form -->
      <form id="listForm" method="post" action="<c:url value="/remembrance/recipient.do"/>">
      	<input type="hidden" name="search_keyword" value="${param.search_keyword}">
      	<input type="hidden" name="search_gubun" value="${param.search_gubun}">
      	<input type="hidden" name="search_janggi" value="${param.search_janggi}">
      	<input type="hidden" name="search_end_date" value="${param.search_end_date}">
      	<input type="hidden" name="search_start_date" value="${param.search_start_date}">
      	<input type="hidden" name="page" value="${param.page}">
      </form>
      
      <!-- 댓글등록,수정,삭제 후 수혜자편지 수정 새로고침 -->
      <form id="myForm" method="post" action="<c:url value="/remembrance/recipientUpdateForm.do"/>">
      	<input type="hidden" name="story_idx" value="${selectedLetterStory.story_idx}">
      	<input type="hidden" name="search_keyword" value="${param.search_keyword}">
      	<input type="hidden" name="search_gubun" value="${param.search_gubun}">
      	<input type="hidden" name="search_end_date" value="${param.search_end_date}">
      	<input type="hidden" name="search_start_date" value="${param.search_start_date}">
      	<input type="hidden" name="page" value="${param.page}">
      </form>
    </div>
    <!-- END CONTENT BODY -->
    
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
<script type="text/javascript" charset="utf-8" src="/common/ckeditor/ckeditor.js"></script>

<script language="JavaScript" type="text/javascript">

    function initDateForm() {
        $(".form_datetime").datetimepicker({
            autoclose: true,
            isRTL: App.isRTL(),
            format: "yyyy-mm-dd",
            minView: 2,
            maxView: 5,
            fontAwesome: true,
            initialDate: new Date(),
            pickerPosition: (App.isRTL() ? "bottom-right" : "bottom-left")
        });
    }
    
    $(document).ready(function() {
        initDateForm();
        
	    //ckeditor
	    CKEDITOR.replace('before_story_contents',{filebrowserUploadUrl:'/admin/ckeditorUpload.do',height:450});
    });
    
    function letterStoryCommentWriteForm(){

    	var screenW = screen.availWidth;  
        var screenH = screen.availHeight; 
        var popW = 800; 
        var popH = 350; 
        var posL=( screenW-popW ) / 2;    
        var posT=( screenH-popH ) / 2;    	
    	window.open(' ','popup_window','width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=yes,status=no,titlebar=no');
    	
    	$('#commentFrm').submit();
    }
    
    function letterStoryCommentDeleteEnd(idx,div){
    	
    	if(confirm('정말 삭제하시겠습니까? ')){
	    	$.ajax({
	            url : "/remembrance/letterStoryCommentDeleteEnd.do",
	            type: "POST",
	            data:{
	                com_idx : idx,
	                com_div : div
	            },
	            dataType:"json", 
	            success : function(data, textStatus, jqXHR) {
	            	  alert(data);
	            	  $("#myForm").submit();                             
	            }, 
	            error : function(jqXHR, textStatus, errorThrown){
	             	
	            }
	        });
    	}
    }
    
	function letterStoryCommentUpdateEnd(idx,div){
    	
		var content = $("#com_content"+idx+"").val();
	
	   	if(confirm('정말 수정하시겠습니까? ')){
	    	$.ajax({
	            url : "/remembrance/letterStoryCommentUpdateEnd.do",
	            type: "POST",
	            data:{
	                com_idx : idx,
	                com_div : div,
	                com_content : content
	            },
	            dataType:"json", 
	            success : function(data, textStatus, jqXHR) {
	            	  alert(data);
	            	  $("#myForm").submit();                             
	            }, 
	            error : function(jqXHR, textStatus, errorThrown){
	             	
	            }
	        });
    	}
    }
	function letterStoryUpdateEnd(){
		    
		var story_contents = CKEDITOR.instances['before_story_contents'].getData();
		$('#story_contents').val(story_contents);
		  	$.ajax({
		          url : "/remembrance/letterStoryUpdateEnd.do",
		          type: "POST",
		          data:$("#updateForm").serialize(),
		          dataType:"json", 
		          success : function(data, textStatus, jqXHR) {
		          	  alert(data);          
		          	  $("#listForm").submit();
		          }, 
		          error : function(jqXHR, textStatus, errorThrown){
		           	
		          }
		      });    	
	}
</script>