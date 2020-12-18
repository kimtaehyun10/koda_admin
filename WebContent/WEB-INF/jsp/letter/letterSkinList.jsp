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
    	<!-- BEGIN PAGE HEADER-->                    
        <!-- END PAGE HEADER-->
        <div class="row" style="margin-top: 70px;">
        	<div class="col-md-12">
            	<!-- BEGIN SAMPLE TABLE PORTLET-->
                <div class="portlet light portlet-fit bordered">
                	<div class="portlet-title">
                    	<div class="caption">
                        	<span class="caption-subject font-dark bold uppercase">편지지 스킨관리</span>
                        </div>
                        <div class="actions">
                        <div class="btn-group">
                        	<a class="btn dark btn-outline btn-circle btn-sm" href="<c:url value="/mailbox/letterSkinWriteForm.do"/>">편지지 스킨 등록</a>
                        </div>
                    </div>    
                </div>
				<div class="portlet-body">
                	<form name="schFrm" id="schFrm" method="post" action="<c:url value="/mailbox/letterSkinList.do"/>">
                		<input type="hidden" name="page" id="page" value="${param.page}"/>
                      	<table class="table table-bordered">
                      		<tr>
                      			<th>스킨명</th>
                      			<td style="text-align:left;"><input type="text" size=20" name="searchText" id="searchText" value="${param.searchText}"/></td>
                      			<td>
                      				<div class="btn-group">
                                  		<a id="btnSearch" class="btn dark btn-outline btn-circle btn-sm" href="#">검색</a>
                             		</div>
                      			</td>
                      		</tr>
                      	</table>   
                    </form>                   	
                </div>
                      
                <form name="Frm" id="Frm" method="post" action="">
                	<input type="hidden" id="letter_skin_id" name="letter_skin_id" value="" />
                	<div class="portlet-body">
                        <div class="table-scrollable">
                        	<table class="table table-hover">
                            	<thead>
                                	<tr>
                                    	<th>No</th>
					                    <th>스킨명</th>					                      
					                    <th>이미지 파일</th>
					                    <th>관리</th>
					                </tr>
					            </thead>
                                <tbody>
								<c:forEach var="item" items="${letterSkinList}" varStatus="status">                                      
                                	<tr>
                                    	<td>${(total_count - status.index) - ( (currentPage - 1)  *  displayNum ) }</td>                    	                                                                                 
                                        <td>${item.letter_skin_name}</td>                                                                                   
                                        <td>${item.letter_skin_file_org_nm}</td>
                                        <td>
                                          	<a style="line-height:60px" onclick="fnUpdate('${item.letter_skin_id}');"><button class="btn btn-default btn-circle mt-sweetalert" type="button"><i class="fa fa-paste"></i> 수정</button></a>
	                                        <a style="line-height:60px" onclick="fnDelete('${item.letter_skin_id}')"><button class="btn btn-danger btn-circle mt-sweetalert" type="button"><i class="fa fa-times"></i> 삭제</button></a>
                                          </td>                                                                                                                                                                
                                    </tr>
                                    
                                </c:forEach>
                                <c:if test="${fn:length(letterSkinList) eq 0 }">
                                	<tr>
                                    	<td colspan="4">등록된 데이터가 없습니다.</td>
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
            </div>
        </div>
    </div>
    <!-- END CONTENT BODY -->
</div> 
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery_redirect/jquery.redirect.js" type="text/javascript"></script>
  
<script>
function fn_search(pageNo) {		
	$('#page').val(pageNo);
	$('#schFrm').submit();
};

$('#btnSearch').on('click', function(e){
	e.preventDefault();
	$('#page').val('1');
	$('#schFrm').submit();
});

function fnUpdate(letter_skin_id){
	$("#letter_skin_id").val(letter_skin_id);
	$('#Frm').attr("action","/mailbox/letterSkinUpdateForm.do");
	$('#Frm').submit();
}

function fnDelete(letter_skin_id){
	if(del()){
		$.ajax({
	        url : '<c:url value="/mailbox/ajaxUseSkinLetterId.do"/>',
	        type: "POST",
	        data: {letter_skin_id : letter_skin_id},
	        dataType:"json", 
	        success : function(data, textStatus, jqXHR) {
	        	if(data.rtnCode === '-1') {
	        		alert(data.rtnMsg);
	       			return;
	       		}
	        	$("#letter_skin_id").val(letter_skin_id);
	    		$('#Frm').attr("action","/mailbox/letterSkinDelete.do");
	    		$('#Frm').submit();      		
	        },
	        error : function(jqXHR, textStatus, errorThrown){
	         	
	        }
	    });
	}
}
</script>