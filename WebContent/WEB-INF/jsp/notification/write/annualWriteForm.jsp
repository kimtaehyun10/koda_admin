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
                      	<input type="hidden" name="brd_no" value="24">
                      	<input type="hidden" name="brd_cont_no" value="">
                      	<input type="hidden" name="type" value="board_insert">
                      	<table class="table table-bordered">
                      		<colgroup>
                       			<col width="10%"/>
                       			<col width="35%"/>
                       			<col width="10%"/>
                       			<col width="35%"/>
                       			<col width="10%"/>
                       		</colgroup>
                      		<tr>
                      			<th>제목</th>
                      			<td style="text-align:left;" colspan="3"><input type="text" size="90" name="brd_title" id="brd_title" class="form-control input-sm" value=""/></td>	
                      		</tr>  
                      		<tr>
                      			<th>작성자</th>
                      			<td style="text-align:left;" colspan="3"><input type="text" size="90" name="brd_mkr_nm" id="brd_mkr_nm" class="form-control input-sm" value=""/></td>	
                      		</tr>
                      		<tr>                      			
                      			<th>첨부파일</th>
                      			<td style="text-align:left;" colspan="3">
									<div class="form-group">                                                                       	
										<input type="file" id="brd_file_org_nm" name="brd_file_org_nm" size="20"/>
                                    </div>
                                </div>	                                        
                      			</td>
                      		</tr> 
                      		<tr>
                      			<th>미리보기 URL</th>
                      			<td style="text-align:left;" colspan="3"><input type="text" size="90" name="brd_url" id="brd_url" class="form-control input-sm" value=""/></td>	
                      		</tr>
                      		<tr>
                      			<th>다운로드 URL</th>
                      			<td style="text-align:left;" colspan="3"><input type="text" size="90" name="brd_down_url" id="brd_down_url" class="form-control input-sm" value=""/></td>	
                      		</tr>
                      		<td colspan="2">
                  				<div class="btn-group">
                              		<a id="btn" class="btn dark btn-outline btn-circle btn-sm">등록</a>
                         		</div>
                  			</td>                  		
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
    
    var form = $('#Frm')[0];

    var data = new FormData(form);

    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: "/admin/fileUpload.do",
        data: data,
        processData: false,
        contentType: false,
        cache: false,
        timeout: 600000,
        success: function (data) {
        	var reData = data.replace(/"/gi,"");
        	alert(reData.split(",")[0]);
        	opener.parent.location.reload();
      	  	window.close();
        },
        error: function (e) {
            
        }
    });
	
	
});
</script>