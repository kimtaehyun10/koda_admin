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
                      	<input type="hidden" name="hospital_idx" value="">
                      	<input type="hidden" name="hospital_type" value="${hospital_type}">
                      	<table class="table table-bordered">
                      		<colgroup>
                       			<col width="10%"/>
                       			<col width="35%"/>
                       			<col width="10%"/>
                       			<col width="35%"/>
                       			<col width="10%"/>
                       		</colgroup>
                      		<tr>
                      			<th>병원명</th>
                      			<td style="text-align:left;" colspan="3"><input type="text" size=43" name="hospital_name" id="hospital_name" class="form-control input-sm" value=""/></td>                      			                      			                      			
                      		</tr>  
                      		<tr>                      			
                      			<th>지역</th>
                      			<td style="text-align:left;" colspan="3">
									<div class="form-group">                                  
                                    <div class="col-md-11">
                                       <label class="mt-checkbox" >중부권역                                       	                                       	
                                            <input id="hospital_area" name="hospital_area" type="radio" class="input-sm" value="0" ><span></span>
                                        </label>
                                        &nbsp;&nbsp;&nbsp;
                                        <label class="mt-checkbox" >충청,호남권역                                   	                                       	
                                            <input id="hospital_area" name="hospital_area" type="radio" class="input-sm" value="1" ><span></span>
                                        </label>
                                        &nbsp;&nbsp;&nbsp;
                                        <label class="mt-checkbox" >영남권역                                   	                                       	
                                            <input id="hospital_area" name="hospital_area" type="radio" class="input-sm" value="2" ><span></span>
                                        </label> 
                                    </div>
                                </div>	                                        
                      			</td>
                      		</tr>
                      		<tr>
                      			<th>협약체결일</th>
                      			<td style="text-align:left;" colspan="3"><input type="text" size="20" name="hospital_dt" id="hospital_dt" class="form-control input-sm form_datetime" value=""></td>
                      		</tr>
                      		<tr>
                      			<th>위치</th>
                      			<td style="text-align:left;" colspan="3"><input type="text" size=43" name="hospital_loc" id="hospital_loc" class="form-control input-sm" value=""/></td>                      			                      	                      			
                      		</tr>
                      		<tr>
                      			<th>전화번호</th>
                      			<td style="text-align:left;" colspan="3"><input type="text" size=43" name="hospital_tel" id="hospital_tel" class="form-control input-sm" value=""/></td>                      			                      	                      			
                      		</tr>
                      		<tr>
                      			<th>홈페이지</th>
                      			<td style="text-align:left;" colspan="3"><input type="text" size=43" name="hospital_link" id="hospital_link" class="form-control input-sm" value=""/></td>                      			                      	                      			
                      		</tr>
                      		<tr>
                      			<td colspan="2">
                      				<div class="btn-group">
                                  		<a id="btn" class="btn dark btn-outline btn-circle btn-sm" href="#">등록</a>
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
$(document).ready(function(){
	//날짜
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
});

$("#btn").click(function(){
    	$.ajax({
            url : "/hospital/hospitalWriteEnd.do",
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
</script>