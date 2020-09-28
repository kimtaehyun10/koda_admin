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
                              <span class="caption-subject font-dark bold uppercase">접속자집계</span>
                              </div>
                              <div class="actions">
                              
                          </div>    
                      </div>
                      <div class="portlet-body">
                      	<form name="schFrm" id="schFrm" method="post" action="<c:url value="/defaultSetting/visitCount.do"/>">
                      	<input type="hidden" name="page" id="page" value=""/>
                      	<table class="table table-bordered">
                      		<colgroup>
                       			<col width="8%"/>
                       			<col width="25%"/>
                       			<col width="8%"/>
                       			<col width="38%"/>
                       			<col width="8%"/>
                       		</colgroup>
                      		<tr>
                      			<th>년도</th>
                      			
                      			<td style="text-align:left;">
                      				<select name="search_year" id="search_year" style="width:200px;" onchange="searchFrm();">                        				                    					
                      					<option value="2021" ${year=='2021'?'selected':''}>2021</option>
                      					<option value="2020" ${year=='2020'?'selected':''}>2020</option>
                      					<option value="2019" ${year=='2019'?'selected':''}>2019</option>
                      					<option value="2018" ${year=='2018'?'selected':''}>2018</option>                      					                      					                    					                      					                     					                   					                      					                      					                     					
                      					<option value="2017" ${year=='2017'?'selected':''}>2017</option>                      					                      					                    					                      					                     					                   					                      					                      					                     					
                      				</select>
                      			</td>                      			                      			
                      		</tr>
                      	
                      	</table>   
                      	</form>                   	
                      </div>
                      
                      <div class="container"> 
                      	<canvas id="visitChart"></canvas> 
                      </div>                      
                      
                  </div>
                  <!-- END SAMPLE TABLE PORTLET-->
                  <!-- 접속자 월별 통계 데이터 -->
				  <c:forEach items="${visitCountList}" var="list">
				 	<input type="hidden" id="month${list.date}" value="${list.sum}">
				  </c:forEach>
				  <!-- 총 접속자 수 -->
				  <input type="hidden" id="totalSum" value="${totalSum}">
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
<!-- 차트 링크 --> 
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<!-- 차트 -->
<script>
	
	var ctx = document.getElementById('visitChart');
	var myChart = new Chart(ctx,
			{
				type : 'bar',
				data : {
					labels : [ '1월', '2월', '3월', '4월', '5월','6월','7월','8월','9월','10월','11월','12월'
						     ],
					datasets : [ {
						label : '접속자 수 | 총 접속자 수 : '+$("#totalSum").val(),							
						data : [ $("#month1").val(), $("#month2").val(), $("#month3").val(), $("#month4").val(), $("#month5").val(), $("#month6").val(), $("#month7").val(), $("#month8").val(), $("#month9").val(), $("#month10").val(), $("#month11").val(), $("#month12").val() ],
						backgroundColor : [ 'rgba(54, 162, 235, 0.2)',
								'rgba(54, 162, 235, 0.2)',
								'rgba(54, 162, 235, 0.2)',
								'rgba(54, 162, 235, 0.2)',
								'rgba(54, 162, 235, 0.2)',
								'rgba(54, 162, 235, 0.2)',
								'rgba(54, 162, 235, 0.2)',
								'rgba(54, 162, 235, 0.2)',
								'rgba(54, 162, 235, 0.2)',
								'rgba(54, 162, 235, 0.2)',
								'rgba(54, 162, 235, 0.2)',
								'rgba(54, 162, 235, 0.2)' ],
						borderColor : [ 'rgba(54, 162, 235, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(54, 162, 235, 1)' ],
						borderWidth : 1
					} ]
				},
				options : {
					scales : {
						yAxes : [ {
							ticks : {
								beginAtZero : true
							}
						} ]
					}
				}
			});
	
	function searchFrm(){
		$('#schFrm').submit();
	}
</script>