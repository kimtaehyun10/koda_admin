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
                        	<span class="caption-subject font-dark bold uppercase">※ 회원리스트</span>
                        </div>    
					</div>
					
					<form name="schFrm" id="schFrm" method="post" action="<c:url value="/mailbox/letterSenderSearchPopup.p"/>">
                    <div class="portlet-body">
                    	<input type="hidden" name="page" id="page" value="${param.page}"/>
                      	<table class="table table-bordered">
                      	<tr>
                      		<th>검색<br/>조건</th>
                      		<td style="text-align: left;">
	                     		<div>
									<select class="post_select" id="search_type" name="search_type">
										<option value="" <c:if test="${empty param.search_type || '' eq param.search_type}">selected</c:if>>전체</option>
										<option value="ID" <c:if test="${'ID' eq param.search_type}">selected</c:if>>아이디</option>
										<option value="NAME" <c:if test="${'NAME' eq param.search_type}">selected</c:if>>이름</option>
										<option value="PHONE" <c:if test="${'PHONE' eq param.search_type}">selected</c:if>>전화번호</option>
									</select>
									<input type="text" class="post_input300" id="search_text" name="search_text" value="${param.search_text }"/>
								</div>
                      		</td>
                      		<td style="text-align: left;">
                      			구분
								<select class="post_select" id="gubn" name="gubn">
									<option value="" <c:if test="${empty param.gubn || '' eq param.gubn}">selected</c:if>>전체 </option>
									<option value="D" <c:if test="${'D' eq param.gubn}">selected</c:if>>기증자가족</option>
									<option value="B" <c:if test="${'B' eq param.gubn}">selected</c:if>>수혜자</option>
								</select>
                      		</td>
                      		<td>
                      			<div class="btn-group">
                            		<a id="btnSearch" class="btn dark btn-outline btn-circle btn-sm" href="#">검색</a>
                            	</div>
                      		</td>
                      	</tr>
                      	</table>   
                    </div>
                      
                    <div class="portlet-body">
                    	<div class="table-scrollable">
                        	<table class="table table-hover">
                            	<thead>
                                	<tr>
                                    	<th>번호</th>
					                    <th>구분</th>					                      
					                    <th>이름(아이디)</th>					                      					                      					                      				                      					                      
					                    <th>핸드폰</th>
					                    <th>매칭정보</th>
					                    <th>매칭회원</th>
					                    <th>선택</th>
					                </tr>
					            </thead>
                                <tbody>
									<c:forEach var="letterSender" items="${letterSenderList}" varStatus="status">                                      
                                    <tr>
                                    	<td>${(total_count - status.index) - ( (currentPage - 1)  *  displayNum ) }</td>                    	                                                                                 
                                        <td>
                                        	<c:if test="${letterSender.gubn eq 'D'}">기증자가족</c:if>
                                        	<c:if test="${letterSender.gubn eq 'B'}">수혜자</c:if>
                                        </td>
                                        <td>${letterSender.name}(${letterSender.id })</td>
                                        <td>${letterSender.phone }</td>
                                        <td>
                                        	<c:if test="${letterSender.gubn eq 'D'}">
                                        		${letterSender.donor_name } 
                                        		<c:if test="${not empty letterSender.donor_hospital }">
                                        		  | ${letterSender.donor_hospital } 
                                        		</c:if>
                                        		<br />
                                        		<c:if test="${not empty letterSender.donor_date }">
                                        		  ${letterSender.donor_date }
                                        		</c:if>
                                        		<c:if test="${not empty letterSender.donor_birthday }">
                                        		  | ${letterSender.donor_birthday }
                                        		</c:if>
                                        	</c:if>
                                        	<c:if test="${poster_sender.gubn eq 'B'}">
                                        		${letterSender.benefi_name }
                                        		
                                        		<c:if test="${not empty letterSender.benefi_hospital }">
                                        		  | ${letterSender.benefi_hospital }
                                        		</c:if>
                                        	    <br/> 
                                        		<c:if test="${not empty letterSender.benefi_date }">
                                        		  ${letterSender.benefi_date }
                                        		</c:if>
                                        	    <c:if test="${not empty letterSender.benefi_parts }">
                                        		  | ${letterSender.benefi_parts }
                                        		</c:if>
                                        	</c:if>
                                        </td>
                                        <td>${letterSender.match_name }</td>
                                        <td><a href="javascript:fnSelectedValue('${letterSender.id }', '${letterSender.name }', '${letterSender.match_id }', '${letterSender.match_name }')">[선택]</a></td>
                                    </tr>
                                    </c:forEach>
                                    <c:if test="${fn:length(letterSenderList) eq 0 }">
                                    <tr>
                                    	<td colspan="7">데이터가 존재하지 않습니다.</td>
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

function fnSelectedValue(letter_sender_id, letter_sender_name, letter_receiver_id, letter_receiver_name) {
	opener.document.getElementById("sender_id").value = letter_sender_id;
	opener.document.getElementById("sender_name").value = letter_sender_name;
	opener.document.getElementById("letter_receiver_id").value = letter_receiver_id;
	opener.document.getElementById("letter_receiver_name").value = letter_receiver_name;
	self.close();
}
</script>