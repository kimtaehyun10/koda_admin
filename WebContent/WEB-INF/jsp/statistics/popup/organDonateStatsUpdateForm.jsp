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
                      	<input type="hidden" name="stats_idx" value="${selectedOrgan.stats_idx}">                      	
                      	<table class="table table-bordered">
                      		
                       		<tr>                      			
                      			<th colspan="2">연도</th>                     			
                      			<td style="text-align:left;">
									<input type="text" size="15" name="stats_date" id="stats_date" class="form-control input-sm" value="${selectedOrgan.stats_date}"/>	                                                                                                                           
                      			</td>
                      		</tr>
                      		<tr>                      			
                      			<th colspan="2">뇌사자(명)</th>                     			
                      			<td style="text-align:left;">
									<input type="text" size="15" name="stats_brain_total" id="stats_brain_total" class="form-control input-sm" value="${selectedOrgan.stats_brain_total}"/>	                                                                                                                           
                      			</td>
                      		</tr>
                      		<tr>                      			
                      			<th colspan="2">계</th>                     			
                      			<td style="text-align:left;">
									<input type="text" size="15" name="stats_total" id="stats_total" class="form-control input-sm" value="${selectedOrgan.stats_total}"/>	                                                                                                                           
                      			</td>
                      		</tr>
                      		<tr>                      			
                      			<th colspan="2">신장</th>                     			
                      			<td style="text-align:left;">
									<input type="text" size="15" name="stats_kidney" id="stats_kidney" class="form-control input-sm" value="${selectedOrgan.stats_kidney}"/>	                                                                                                                           
                      			</td>
                      		</tr>
                      		<tr>                      			
                      			<th colspan="2">간장</th>                     			
                      			<td style="text-align:left;">
									<input type="text" size="15" name="stats_hepar" id="stats_hepar" class="form-control input-sm" value="${selectedOrgan.stats_hepar}"/>	                                                                                                                           
                      			</td>
                      		</tr>
                      		<tr>                      			
                      			<th colspan="2">췌장</th>                     			
                      			<td style="text-align:left;">
									<input type="text" size="15" name="stats_pancreas" id="stats_pancreas" class="form-control input-sm" value="${selectedOrgan.stats_pancreas}"/>	                                                                                                                           
                      			</td>
                      		</tr>
                      		<tr>                      			
                      			<th colspan="2">심장</th>                     			
                      			<td style="text-align:left;">
									<input type="text" size="15" name="stats_heart" id="stats_heart" class="form-control input-sm" value="${selectedOrgan.stats_heart}"/>	                                                                                                                           
                      			</td>
                      		</tr>
                      		<tr>                      			
                      			<th colspan="2">폐</th>                     			
                      			<td style="text-align:left;">
									<input type="text" size="15" name="stats_lung" id="stats_lung" class="form-control input-sm" value="${selectedOrgan.stats_lung}"/>	                                                                                                                           
                      			</td>
                      		</tr>
                      		<tr>                      			
                      			<th colspan="2">췌도</th>                     			
                      			<td style="text-align:left;">
									<input type="text" size="15" name="stats_islet" id="stats_islet" class="form-control input-sm" value="${selectedOrgan.stats_islet}"/>	                                                                                                                           
                      			</td>
                      		</tr>
                      		<tr>                      			
                      			<th colspan="2">소장</th>                     			
                      			<td style="text-align:left;">
									<input type="text" size="15" name="stats_intestine" id="stats_intestine" class="form-control input-sm" value="${selectedOrgan.stats_intestine}"/>	                                                                                                                           
                      			</td>
                      		</tr>
                      		<tr>                      			
                      			<th colspan="2">각막</th>                     			
                      			<td style="text-align:left;">
									<input type="text" size="15" name="stats_cornea" id="stats_cornea" class="form-control input-sm" value="${selectedOrgan.stats_cornea}"/>	                                                                                                                           
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
            url : "/statistics/organDonateStatsUpdateEnd.do",
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