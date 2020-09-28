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
                      	<input type="hidden" name="stats_idx" value="${selectedBrain.stats_idx}">                      	
                      	<table class="table table-bordered">
                      		<colgroup>
                       			<col width="15%"/>
                       			<col width="15%"/>                       		
                       			<col width="35%"/>                       		
                       		</colgroup>
                       		<tr>                      			
                      			<th colspan="2">일자</th>                     			
                      			<td style="text-align:left;">
									<input type="text" size="20" name="stats_date" id="stats_date" class="form_datetime form-control input-sm" value="${selectedBrain.stats_date}">	                                                                                                                           
                      			</td>
                      		</tr>
                      		<tr>                      			
                      			<th colspan="2">노출여부</th>                     			
                      			<td style="text-align:left;">
									<div class="form-group">                                  
                                    <div class="col-md-11">
                                       <label class="mt-checkbox" >노출                                       	                                       	
                                            <input id="stats_view" name="stats_view" type="radio" class="input-sm" value="Y" ${selectedBrain.stats_view=='Y'?'checked':''}><span></span>
                                        </label>
                                        &nbsp;&nbsp;&nbsp;
                                        <label class="mt-checkbox" >비노출                                   	                                       	
                                            <input id="stats_view" name="stats_view" type="radio" class="input-sm" value="N" ${selectedBrain.stats_view=='N'?'checked':''}><span></span>
                                        </label> 
                                    </div>
                                </div>	                                        
                      			</td>
                      		</tr>
                      		<tr>
                      			<th rowspan="2">서울권역</th>
                      			<td>장기기증</td>
                      			<td style="text-align:left;">
                      			<input type="text" size=20" name="stats_sphere_tdonor1" id="stats_sphere_tdonor1" class="form-control input-sm" value="${selectedBrain.stats_sphere_tdonor1}"/>                      			
                      			</td>                      			
                      		</tr>  
                      	    <tr>                      	    	
                      			<td>조직기증</td>
                      			<td style="text-align:left;">
                      			<input type="text" size=20" name="stats_sphere_edonor1" id="stats_sphere_edonor1" class="form-control input-sm" value="${selectedBrain.stats_sphere_edonor1}"/>                      			
                      			</td>
                      	    </tr>
                      	    <tr>
                      			<th rowspan="2">충청·호남권역</th>
                      			<td>장기기증</td>
                      			<td style="text-align:left;">
                      			<input type="text" size=20" name="stats_sphere_tdonor2" id="stats_sphere_tdonor2" class="form-control input-sm" value="${selectedBrain.stats_sphere_tdonor2}"/>                      			
                      			</td>                      			
                      		</tr>  
                      	    <tr>                      	    	
                      			<td>조직기증</td>
                      			<td style="text-align:left;">
                      			<input type="text" size=20" name="stats_sphere_edonor2" id="stats_sphere_edonor2" class="form-control input-sm" value="${selectedBrain.stats_sphere_edonor2}"/>                      			
                      			</td>
                      	    </tr>
                      	    <tr>
                      			<th rowspan="2">영남권역</th>
                      			<td>장기기증</td>
                      			<td style="text-align:left;">
                      			<input type="text" size=20" name="stats_sphere_tdonor3" id="stats_sphere_tdonor3" class="form-control input-sm" value="${selectedBrain.stats_sphere_tdonor3}"/>                      			
                      			</td>                      			
                      		</tr>  
                      	    <tr>                      	    	
                      			<td>조직기증</td>
                      			<td style="text-align:left;">
                      			<input type="text" size=20" name="stats_sphere_edonor3" id="stats_sphere_edonor3" class="form-control input-sm" value="${selectedBrain.stats_sphere_edonor3}"/>                      			
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
            url : "/statistics/brainDonateStatsUpdateEnd.do",
            type: "POST",
            data:$("#Frm").serialize(),
            dataType:"json", 
            success : function(data, textStatus, jqXHR) {
            	  alert(data);
            	  window.opener.schFrm.submit();
            	  window.close();                              
            }, 
            error : function(jqXHR, textStatus, errorThrown){
             	
            }
        });   
});
Date.prototype.addDays = function (n) {
    var time = this.getTime();
    var changedDate = new Date(time + (n * 24 * 60 * 60 * 1000));
    this.setTime(changedDate.getTime());
    return this;
};
function setSearchStartDateByOption(period) {	
	if($("#search_end_date").val() == '') initValue();
    var search_end_date = $("#search_end_date").val();        
    var date_arr = search_end_date.split('-');
    var search_end_date_obj = new Date(date_arr[0], date_arr[1]-1, date_arr[2]);
    var search_start_date_obj = search_end_date_obj;
    var search_start_date_string = "";
    if(period == 30) {
        search_start_date_string = search_start_date_obj.getFullYear() + "-" + ((search_start_date_obj.getMonth()+1) < 10 ? "0"+(search_start_date_obj.getMonth()+1) : (search_start_date_obj.getMonth()+1)) + "-" + "01";
    } else if(period == 365){
        search_start_date_string = search_start_date_obj.getFullYear() + "-" + "01" + "-" + "01";
    } else {
        search_start_date_obj = search_start_date_obj.addDays(-period);
        search_start_date_string = search_start_date_obj.getFullYear() + "-" + ((search_start_date_obj.getMonth()+1) < 10 ? "0"+(search_start_date_obj.getMonth()+1) : (search_start_date_obj.getMonth()+1)) + "-"
        						+ (search_start_date_obj.getDate() < 10 ? "0"+search_start_date_obj.getDate() : search_start_date_obj.getDate());
    }
    $("#search_start_date").val(search_start_date_string);
}
function initValue() {
    // Search Init
    $("#detail_search_visit_period").addClass("active");
    $("#user_period_search_day").addClass("active");
    var today = new Date();
    today.setDate(today.getDate());
    var today_string = today.getFullYear() + "-" + ((today.getMonth()+1 < 10) ? "0"+(today.getMonth()+1) : (today.getMonth()+1)) + "-" 
    					+ (today.getDate() < 10 ? "0"+today.getDate() : today.getDate());
    $("#search_start_date").val(today_string);
    $("#search_end_date").val(today_string);
}
$(function() {	
	$("#user_period_search_day").click(function(e) {
		e.preventDefault();
        setSearchStartDateByOption(0);        
    });
    $("#user_period_search_week").click(function(e) {
    	e.preventDefault();
        setSearchStartDateByOption(7);
    });
    $("#user_period_search_month").click(function(e) {
    	e.preventDefault();
        setSearchStartDateByOption(30);
    });
    $("#user_period_search_year").click(function(e) {
    	e.preventDefault();
        setSearchStartDateByOption(365);
    });
    
	$(".form_datetime").datetimepicker({
        autoclose: true,
        isRTL: App.isRTL(),
        format: "yyyy-mm-dd",
        minView: 2,
        maxView: 3,
        fontAwesome: true,
        initialDate: new Date(),
        pickerPosition: (App.isRTL() ? "bottom-right" : "bottom-left")
    }).on('changeDate', function(ev){        
    });
	
	$('#btnSearch').on('click', function(e){
		e.preventDefault();
		$('#page').val('1');
		$('#schFrm').submit();
	})
});
</script>