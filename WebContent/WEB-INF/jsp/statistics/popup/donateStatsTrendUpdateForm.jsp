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
          <div class="row" style="margin-top:20px;">
              <div class="col-md-12">
                  <!-- BEGIN SAMPLE TABLE PORTLET-->
                  <div class="portlet light portlet-fit bordered">                     
                      <div class="portlet-body">
                      	<form name="Frm" id="Frm" method="post">
                      	<input type="hidden" name="trend_idx" value="${selectedTrend.trend_idx}">                      	
                      	<table class="table table-bordered">
                      		<colgroup>
                       			<col width="15%"/>
                       			<col width="15%"/>                       		
                       			<col width="35%"/>                       		
                       		</colgroup>
                       		<tr>                      			
                      			<th colspan="2">연도</th>                     			
                      			<td style="text-align:left;">
									<input type="text" size="15" name="trend_date" id="trend_date" class="form-control input-sm" value="${selectedTrend.trend_date}"/>	                                                                                                                           
                      			</td>
                      		</tr>
                      		<tr>                      			
                      			<th colspan="2">뇌사 장기 기증자수</th>                     			
                      			<td style="text-align:left;">
									<input type="text" size="15" name="trend_value1" id="trend_value1" class="form-control input-sm" value="${selectedTrend.trend_value1}"/>	                                                                                                                           
                      			</td>
                      		</tr>
                      		<tr>                      			
                      			<th colspan="2">조직 기증자 수</th>                     			
                      			<td style="text-align:left;">
									<input type="text" size="15" name="trend_value2" id="trend_value2" class="form-control input-sm" value="${selectedTrend.trend_value2}"/>	                                                                                                                           
                      			</td>
                      		</tr>
                      		<tr>
                      			<td colspan="3">
                      				<div class="btn-group">
                                  		<a id="btn" class="btn dark btn-outline btn-circle btn-sm" href="#">수정</a>
                             		</div>
                      			</td>
                      		</tr>                     		                  		
                      	</table>   
                      	</form>                   	
                      </div>                     
                  </div>                  
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
$("#btn").click(function(){
    	$.ajax({
            url : "/statistics/donateStatsTrendUpdateEnd.do",
            type: "POST",
            data:$("#Frm").serialize(),
            dataType:"json", 
            success : function(data, textStatus, jqXHR) {
            	  alert(data);
            	  opener.parent.location.reload();
            	  window.close();                              
            }, 
            error : function(jqXHR, textStatus, errorThrown){
             	
            }
        });   
});

</script>