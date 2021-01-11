<%@ page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="ajax" uri="http://ajaxtags.sourceforge.net/tags/ajaxtags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
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
<body
	class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">
	<c:import url="/webMenu.do" charEncoding="UTF-8"></c:import>
	<link
		href="${pageContext.request.contextPath}/common/css/card_style.css"
		rel="stylesheet" type="text/css" />
	<link
		href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css"
		rel="stylesheet" type="text/css">
	<link
		href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.css"
		rel="stylesheet" type="text/css" />

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
								<span class="caption-subject font-dark bold uppercase">▶발신통계</span>
							</div>
						</div>
					</div>

					<div class="portlet-body">
						<form name="schFrm" id="schFrm" method="post" action="<c:url value="/mailbox/letterStatistics.do"/>">
							<input type="hidden" id="typeTabSelected" name="typeTabSelected" />
							<div>
								<!-- Nav tabs -->
								<ul class="nav nav-tabs" role="tablist" id="type-tabs">
									<li role="presentation" class="active" value="mail"><a href="#mail" aria-controls="mail" role="tab" data-toggle="tab">우체통</a></li>
									<li role="presentation" value="other"><a href="#other" aria-controls="other" role="tab" data-toggle="tab">우체통 외</a></li>
								</ul>

								<!-- Tab panes -->
								<div class="tab-content">
									<div role="tabpanel" class="tab-pane active" id="mail">
										<table class="table table-bordered">
											<tr>
												<th>조회대상</th>
												<td style="text-align: left;">
													<label class="radio-inline"><input type="radio" name="mailDateCondition" id="mailDateCondition" value="year" <c:if test="${param.mailDateCondition eq 'year' || empty param.mailDateCondition}"> checked </c:if> onchange="fnMailDateConditionChange();">년도별</label>
													<label class="radio-inline"><input type="radio" name="mailDateCondition" id="mailDateCondition" value="month" <c:if test="${param.mailDateCondition eq 'month'}"> checked </c:if> onchange="fnMailDateConditionChange();">월별</label>
													<label class="radio-inline"><input type="radio" name="mailDateCondition" id="mailDateCondition" value="day" <c:if test="${param.mailDateCondition eq 'day'}"> checked </c:if> onchange="fnMailDateConditionChange();">일별</label>
												</td>
												<td rowspan="2">
													<a id="btnMailSearch" class="btn dark btn-outline btn-circle btn-sm" style="height: 100%;" href="#">검색</a>
												</td>
											</tr>
											<tr>
												<th>조회일</th>
												<td>
													<table>
														<tr>
															<td>
																<c:set var="now" value="<%=new java.util.Date()%>" /> 
																<c:set var="sysYear">
																	<fmt:formatDate value="${now}" pattern="yyyy" />
																</c:set> 
																<select id="schMailYear" name="schMailYear">
																	<c:forEach var="i" begin="0" end="${sysYear-minYear}">
																		<c:set var="yearOption" value="${sysYear-i}" />
																		<option value="${yearOption}" <c:if test="${param.schMailYear eq yearOption}"> selected</c:if>>${yearOption}</option>
																	</c:forEach>
																</select>
																<select id="schMailMonth" name="schMailMonth">
																	<c:forEach begin="1" end="12" step="1" var="month">
																		<option value="${month}"
																			<c:if test="${param.schMailMonth eq month}"> selected</c:if>>${month}</option>
																	</c:forEach>
																</select> 
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									
									</div>
									<div role="tabpanel" class="tab-pane" id="other">
										<table class="table table-bordered">
											<tr>
												<th>조회대상</th>
												<td style="text-align: left;">
													<label class="radio-inline"><input type="radio" name="target" id="target" value="gender" <c:if test="${param.target eq 'gender' || empty param.target}"> checked </c:if>>성별</label>
													<label class="radio-inline"><input type="radio" name="target" id="target" value="age" <c:if test="${param.target eq 'age'}"> checked </c:if>>연령별</label>
													<label class="radio-inline"><input type="radio" name="target" id="target" value="memberType" <c:if test="${param.target eq 'memberType'}"> checked </c:if>>회원유형별</label>
													<label class="radio-inline"><input type="radio" name="target" id="target" value="donorRelation" <c:if test="${param.target eq 'donorRelation'}"> checked </c:if>>기증자와의 관계별</label>
													<label class="radio-inline"><input type="radio" name="target" id="target" value="benefitOrgan" <c:if test="${param.target eq 'benefitOrgan'}"> checked </c:if>>수혜장기별</label>
												</td>
												<td rowspan="2">
													<a id="btnOtherSearch" class="btn dark btn-outline btn-circle btn-sm" style="height: 100%;" href="#">검색</a>
												</td>
											</tr>
											<tr>
												<th>조회일</th>
												<td>
													<table>
														<tr>
															<td>
																<c:set var="now" value="<%=new java.util.Date()%>" /> 
																<c:set var="sysYear">
																	<fmt:formatDate value="${now}" pattern="yyyy" />
																</c:set> 
																<select id="schYear" name="schYear"">
																	<c:forEach var="i" begin="0" end="${sysYear-minYear}">
																		<c:set var="yearOption" value="${sysYear-i}" />
																		<option value="${yearOption}" <c:if test="${param.schYear eq yearOption}"> selected</c:if>>${yearOption}</option>
																	</c:forEach>
																</select> 
																	<select id="schMonth" name="schMonth" onchange="javascript:lastday();">
																	<option value="" <c:if test="${empty param.schMonth}"> checked</c:if>>월(전체)</option>
																	<c:forEach begin="1" end="12" step="1" var="month">
																		<option value="${month}" <c:if test="${param.schMonth eq month}"> selected</c:if>>${month}</option>
																	</c:forEach>
																</select> 
																<select id="schDay" name="schDay">
																	<option value="">일(전체)</option>
																</select>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</div>
								</div>
							</div>
						</form>
					</div>

					<div>
						<div class="text-right">
							<input type="button" class="btn blue" name="btnExcel"
								id="btnExcel" onClick="javascript:fnExcel();" value="엑셀 다운로드">
						</div>
					</div>

					<div class="portlet-body">
						<div class="table-scrollable">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>
											<c:choose>
												<c:when test="${empty param.typeTabSelected || param.typeTabSelected eq '#mail' }">구분</c:when>
												<c:otherwise>유형</c:otherwise>
											</c:choose>
										</th>
										<th>발송건수</th>
										<th>반송건수</th>
										<th>수신건수</th>
										<th>발송대기건수</th>
										<th>총편지수</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${fn:length(list) > 0}">
											<c:forEach var="item" items="${list}" varStatus="status">
												<tr <c:if test="${item.type eq '합계'}"> style="background:yellow;font-weight:bold;" </c:if>>
													<td style="font-weight: bold;">${item.type}</td>
													<td>${item.SENDER_CNT}</td>
													<td>${item.RETURN_CNT}</td>
													<td>${item.RECEIVER_CNT}</td>
													<td>${item.SENDER_STAY_CNT}</td>
													<td>${item.SUM_CNT}</td>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr>
												<td colspan="6">
													정보가 존재하지 않습니다.
												</td>
											</tr>
										</c:otherwise>
									</c:choose>
									

								</tbody>
							</table>
						</div>
					</div>

				</div>
			</div>
		</div>
		<!-- END CONTENT BODY -->
		<form name="schExcel" id="schExcel" method="post"
			action="<c:url value="exportExcelLetterStatisticsList"/>"></form>

		<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
		<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/common/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/common/global/plugins/jquery_redirect/jquery.redirect.js" type="text/javascript"></script>

		<script>
			$(document).ready(function() {
				$('#type-tabs a').click(function(e) {
					e.preventDefault();
					$(this).tab('show');
				});
				
				$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
					$("#typeTabSelected").val($(e.target).attr('href'));
				});
				
				$('#btnMailSearch').on('click', function(e) {
					fnSearch();
				});
				
				$('#btnOtherSearch').on('click', function(e) {
					fnSearch();
				});
				
				var typeTabSelected = '${param.typeTabSelected}';
				$("#typeTabSelected").val(typeTabSelected);
				if(typeTabSelected != '') {
					$('#type-tabs a[href="' + typeTabSelected +'"]').tab('show');	
				} else {
					$('#type-tabs a[href="#mail"]').tab('show');
				}
				
				fnMailDateConditionChange();
				lastday();
			});
			
			// 검색 버튼을 클릭시
			function fnSearch() {
				var typeTabSelected = $("#typeTabSelected").val();		// 탭 선택 유형
				var mailDateCondition = $('input[name=mailDateCondition]:checked').val();	// 우체통 선택유형
				var schMailYear = document.getElementById('schMailYear').value;				// 우체통 년도
				var schMailMonth = document.getElementById('schMailMonth').value;			// 우체통 월
				
				var target = document.getElementById('target').value;						// 우체통외 유형
				var schYear = document.getElementById('schYear').value;						// 우체통외 년도
				var schMonth = document.getElementById('schMonth').value;					// 우체통외 월
				var schDay = document.getElementById('schDay').value;						// 우체통외 일
				
				if(typeTabSelected == '#other') {
					if(schMonth == '' && schDay != '') {
						alert('월을 선택하여 주시기 바랍니다.');
						return;
					}
				}
				
				$('#schFrm').submit();
			}
			
			// 우체통의 조회대상을 클릭시
			function fnMailDateConditionChange() {
				var mailDateCondition = $('input[name=mailDateCondition]:checked').val();
				document.getElementById("schMailYear").disabled = false;
				document.getElementById("schMailMonth").disabled = false;
				if(mailDateCondition === 'year') {
					document.getElementById("schMailYear").disabled = true;
					document.getElementById("schMailMonth").disabled = true;
				} else if(mailDateCondition === 'month') {
					document.getElementById("schMailMonth").disabled = true;
				} else {
					
				}
			}

			//년과 월에 따라 마지막 일 구하기
			function lastday() {
				var Year = document.getElementById('schYear').value;
				var Month = document.getElementById('schMonth').value;
				var dayindex_len = document.getElementById('schDay').length;
				if (Month == '') {
					for (var i = dayindex_len; i > 1; i--) {
						document.getElementById('schDay').options[i - 1] = null;
					}
					return;
				}

				var day = new Date(new Date(Year, Month, 1) - 86400000)
						.getDate();

				if (day > dayindex_len) {
					for (var i = (dayindex_len + 1); i <= day + 1; i++) {
						document.getElementById('schDay').options[i - 1] = new Option(
								i - 1, i - 1);
					}
				} else if (day < dayindex_len) {
					for (var i = dayindex_len; i >= day + 1; i--) {
						document.getElementById('schDay').options[i - 1] = null;
					}
				}
			}

			function fnExcel() {
				var newForm = document.createElement('form');
				newForm.name = 'newForm';
				newForm.method = 'post';
				newForm.action = "<c:url value='/mailbox/exportExcelLetterStatisticsList.do'/>";
				newForm.target = '_blank';
				
				// 탭 선택 유형
				var typeTabSelected = document.createElement('input');
				typeTabSelected.setAttribute("type", "hidden");
				typeTabSelected.setAttribute("name", "typeTabSelected");
				typeTabSelected.setAttribute("value", $("#typeTabSelected").val());
				newForm.appendChild(typeTabSelected);

				// 유체통 선택유형
				var mailDateCondition = document.createElement('input');
				mailDateCondition.setAttribute("type", "hidden");
				mailDateCondition.setAttribute("name", "mailDateCondition");
				mailDateCondition.setAttribute("value", $('input[name=mailDateCondition]:checked').val());
				newForm.appendChild(mailDateCondition);

				// 우체통 년도
				var schMailYear = document.createElement('input');
				schMailYear.setAttribute("type", "hidden");
				schMailYear.setAttribute("name", "schMailYear");
				schMailYear.setAttribute("value", document.getElementById('schMailYear').value);
				newForm.appendChild(schMailYear);

				// 우체통 원
				var schMailMonth = document.createElement('input');
				schMailMonth.setAttribute("type", "hidden");
				schMailMonth.setAttribute("name", "schMailMonth");
				schMailMonth.setAttribute("value", document.getElementById('schMailMonth').value);
				newForm.appendChild(schMailMonth);

				// 우체통외 유형
				var target = document.createElement('input');
				target.setAttribute("type", "hidden");
				target.setAttribute("name", "target");
				target.setAttribute("value", $('input[name="target"]:checked').val());
				newForm.appendChild(target);
				
				// 우체통외 년도
				var schYear = document.createElement('input');
				schYear.setAttribute("type", "hidden");
				schYear.setAttribute("name", "schYear");
				schYear.setAttribute("value", document.getElementById('schYear').value);
				newForm.appendChild(schYear);
				
				// 우체통외 월
				var schMonth = document.createElement('input');
				schMonth.setAttribute("type", "hidden");
				schMonth.setAttribute("name", "schMonth");
				schMonth.setAttribute("value", document.getElementById('schMonth').value);
				newForm.appendChild(schMonth);
				
				// 우체통외 일
				var schDay = document.createElement('input');
				schDay.setAttribute("type", "hidden");
				schDay.setAttribute("name", "schDay");
				schDay.setAttribute("value", document.getElementById('schDay').value);
				newForm.appendChild(schDay);
				
				document.body.appendChild(newForm);
				newForm.submit();
			}
		</script>