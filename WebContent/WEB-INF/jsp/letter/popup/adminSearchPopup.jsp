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
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/common/global/plugins/amcharts/amcharts/plugins/export/export.css" rel="stylesheet" type="text/css" media="all"/>
<!-- END HEAD -->

<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">
<!-- BEGIN CONTENT -->
<div class="page-content-wrapper">
	<!-- BEGIN CONTENT BODY -->
    	<div class="page-content">
        	<!-- BEGIN PAGE HEADER-->                    
          	<!-- END PAGE HEADER-->
          	<div class="row" style="margin-top: 0 px;">
            	<div class="col-md-12">
                	<!-- BEGIN SAMPLE TABLE PORTLET-->
                  	<div class="portlet">
                    	<div class="portlet-title">
                        	<span class="caption-subject font-dark bold uppercase">※ 관리자 리스트</span>
                        </div>    
					</div>
					
					<form name="schFrm" id="schFrm" method="post" action="<c:url value="/mailbox/adminSearchPopup.p"/>">
                    <div class="portlet-body">
                    	<input type="hidden" name="page" id="page" value="${param.page}"/>
                    </div>
                      
                    <div class="portlet-body">
                    	<div class="table-scrollable">
                        	<table class="table table-hover">
                            	<thead>
                                	<tr>
                                    	<th>아이디</th>
					                    <th>이름</th>
					                    <th>선택</th>
					                </tr>
					            </thead>
                                <tbody>
									<c:forEach var="admin" items="${adminList}" varStatus="status">                                      
                                    <tr>
                                    	<td>${(total_count - status.index) - ( (currentPage - 1)  *  displayNum ) }</td>                    	                                                                                 
                                        <td>${admin.id }</td>
                                        <td>${admin.nm }</td>
                                        <td><a href="javascript:fnSelectedValue('${admin.id }', '${admin.nm }')">[선택]</a></td>
                                    </tr>
                                    </c:forEach>
                                    <c:if test="${fn:length(adminList) eq 0 }">
                                    <tr>
                                    	<td colspan="3">데이터가 존재하지 않습니다.</td>
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
</body>
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery_redirect/jquery.redirect.js" type="text/javascript"></script>
<script language="javascript">
function fn_search(pageNo) {		
	$('#page').val(pageNo);
	$('#schFrm').submit();
}

$('#btnSearch').on('click', function(e){
	e.preventDefault();
	$('#page').val('1');
	$('#schFrm').submit();
});

function fnSelectedValue(id, nm) {
	opener.document.getElementById("sender_id").value = id;
	opener.document.getElementById("sender_name").value = nm;
	self.close();
}
</script>