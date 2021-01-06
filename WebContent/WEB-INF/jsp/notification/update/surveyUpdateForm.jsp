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
          <div class="row">
              <div class="col-md-12">
                  <!-- BEGIN SAMPLE TABLE PORTLET-->
                  <div class="portlet light portlet-fit bordered">                     
                      <div class="portlet-body">
                      	<form name="Frm" id="Frm" method="post">
                      	<table id="surveyTable" class="table table-bordered">                      		
                       		<tr>
                      			<th colspan="6">설문조사</th>
                      		</tr>
                      		<tr>
                      			<th>제목</th>
                      			<td style="text-align: left;" colspan="5">
                      				${survey.survey_title}
                      			</td>	
                      		</tr>  
                      		<tr>
                      			<th>작성자</th>
                      			<td style="text-align: left;" colspan="5">
                      				${survey.survey_writer}
                      			</td>	
                      		</tr>
                      		<tr>                      			
                      			<th>시작일</th>
                      			<td style="text-align: left;" colspan="5">
									${survey.start_date}										                                        
                      			</td>
                      		</tr> 
                      		<tr>
                      			<th>종료일</th>
                      			<td style="text-align: left;" colspan="5">
                      				${survey.end_date}
                      			</td>	
                      		</tr>
                      		
                      		<c:forEach items="${surveyItemList}" var="item">
                      			<tr>
	                      			<th colspan="6">질문지</th>
	                      		</tr>
	                      		<tr>
	                      			<th>문항</th>
	                      			<td style="text-align: left;" colspan="5">
	                      				${item.item_title}
	                      			</td>	                      				
	                      		</tr>
	                      		<tr>
	                      			<th>1</th>
	                      			<td style="text-align: left;" colspan="5">
	                      				${item.item_que1}
	                      			</td>	
	                      		</tr>
	                      		<tr>
	                      			<th>2</th>
	                      			<td style="text-align: left;" colspan="5">
	                      				${item.item_que2}
	                      			</td>	
	                      		</tr>
	                      		<tr>
	                      			<th>3</th>
	                      			<td style="text-align: left;" colspan="5">
	                      				${item.item_que3}
	                      			</td>	
	                      		</tr>
	                      		<tr>
	                      			<th>4</th>
	                      			<td style="text-align: left;" colspan="5">
	                      				${item.item_que4}
	                      			</td>	
	                      		</tr>
	                      		<tr>
	                      			<th>5</th>
	                      			<td style="text-align: left;" colspan="5">
	                      				${item.item_que5}
	                      			</td>	
	                      		</tr>
	                      		<tr>
	                      			<th>통계</th>
	                      			<td>1번(0)</td>
	                      			<td>2번(0)</td>	                      			
	                      			<td>3번(0)</td>	                      			
	                      			<td>4번(0)</td>	                      			
	                      			<td>5번(0)</td>	                      			
	                      		</tr>
                      		</c:forEach>   
                      		                   		                      		                  		
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
$(document).ready(function() {    
    
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
    
    var form = $('#Frm')[0];

    var data = new FormData(form);

    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',        
        url: "/notification/surveyWriteEnd.do",
        data: data,
        dataType: "json",
        processData: false,
        contentType: false,
        cache: false,
        timeout: 600000,        
        success: function (data) {
        	alert(data.msg);
        	opener.parent.location.reload();
      	  	window.close();
        },
        error: function (e) {
            
        }
    });		
});

$("#surveyBtn").click(function(){
	var html="";
	html += '<tr><th colspan="2">질문지</th></tr>';
	html += '<tr><th>문항</th><td><input type="text" name="item_title" class="form-control input-sm" value=""/></td></tr>';
	html += '<tr><th>답변1</th><td><input type="text" name="item_que1" class="form-control input-sm" value=""/></td></tr>';
	html += '<tr><th>답변2</th><td><input type="text" name="item_que2" class="form-control input-sm" value=""/></td></tr>';
	html += '<tr><th>답변3</th><td><input type="text" name="item_que3" class="form-control input-sm" value=""/></td></tr>';
	html += '<tr><th>답변4</th><td><input type="text" name="item_que4" class="form-control input-sm" value=""/></td></tr>';
	html += '<tr><th>답변5</th><td><input type="text" name="item_que5" class="form-control input-sm" value=""/></td></tr>';
	$("#surveyTable").append(html);
	
});
</script>