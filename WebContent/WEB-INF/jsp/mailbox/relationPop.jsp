<%@ page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="ajax" uri="http://ajaxtags.sourceforge.net/tags/ajaxtags"%>
<%@taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/common/global/plugins/amcharts/amcharts/plugins/export/export.css" rel="stylesheet" type="text/css" media="all"/>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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
	※ 연계회원(기증자 가족회원) 검색
		<br/><br/>
	    <!-- BEGIN PAGE HEADER-->
	    <table class="table table-bordered">
	    	<tr>
	    		<td>기증자</td>
	    		<td>생년월일</td>
	    		<td>기증병원</td>
	    		<td>기증일</td>
	    	</tr>
	    	<tr>
    			<td>${donorInfo.donorName }</td>
    			<td>${donorInfo.donorBirth }</td>
    			<td>${donorInfo.donorHospitalName }</td>
    			<td>${donorInfo.donorDate }</td>
	    	</tr>
	    </table>
	    
	    <a id="btnSearch" class="btn dark btn-outline btn-circle btn-sm" href="#" onclick="page.fnInit();" style="margin-top: 6px; border-radius: 8px!important; width:80px;">검색</a>
		
		
		<!-- END PAGE HEADER-->
		<div class="row" style="margin-top:20px;">
			<div class="col-md-12">
	   		<!-- BEGIN SAMPLE TABLE PORTLET-->
				<div class="portlet light portlet-fit bordered">                     
	                <div class="portlet-body">
	                	<form name="searchFrm" id="searchFrm" method="post">
	                		<input type="hidden" id="id" name="id" value="${donorInfo.id}"/>
		                	<input type="hidden" id="donorName" name="donorName" value="${donorInfo.donorName}"/>
		                	<input type="hidden" id="donorBirth" name="donorBirth" value="${donorInfo.donorBirth}"/>
		                	<input type="hidden" id="donorHospitalName" name="donorHospitalName" value="${donorInfo.donorHospitalName}"/>
		                	<input type="hidden" id="donorHospitalIdx" name="donorHospitalIdx" value="${donorInfo.donorHospitalIdx}"/>
		                	<input type="hidden" id="donorDate" name="donorDate" value="${donorInfo.donorDate}"/>
		                	<table class="table table-bordered">
		                		<tr>
									<td><input type="checkbox" name="allCheck" id="allCheck" value="all"/></td>
									<td>번호</td>
									<td>구분</td>			                      
									<td>이름(아이디)</td>					                      					                      					                      				                      					                      
									<td>핸드폰</td>
									<td>기증자정보</td>
									<td>선택</td>
								</tr>   
								<c:forEach var="donorList" items="${relaKodaMemberList}" varStatus="status">
								<tr>
									<td><input type="checkbox" name="checkId" value="${donorList.id}"/></td>
									<td>${(total_count - status.index) - ( (currentPage - 1)  *  displayNum ) }</td>
									<td>${donorList.gubnNm }</td>
									<td>${donorList.name }(${donorList.id })</td>
									<td>${donorList.phone }</td>
									<td>${donorList.donorName } | ${donorList.hospitalName } | ${donorList.donorBirth }</td>
									<td>
										<a id="btnSearch" class="btn dark btn-outline btn-circle btn-sm" href="#" onclick="fnObj.fnSelect('${donorList.id}', '${donorList.name }');" style="margin-top: 6px; border-radius: 8px!important; width:80px;">선택</a>
									</td>
								</tr>
								</c:forEach> 
		                	</table>   
	                	</form>                   	
	                </div>                     
	            </div>     
	            <a id="btnSearch" class="btn dark btn-outline btn-circle btn-sm" href="#" onclick="fnObj.fnSelectAll();" style="margin-top: 6px; border-radius: 8px!important; width:150px;">선택항목 일괄적용</a>             
	        </div>
	    </div>
	    
	    <input type="hidden" name="page" id="page" value="${param.page}"/>
		<nav aria-label="Page navigation" style="margin-top: 50px; text-align: center;">
			<ul class="pagination my_pagetion">
				<c:if test="${not empty paginationInfo}"> 
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="page.fnInit"/>
				</c:if>
			</ul>
		</nav> 
	</div>
	
<!-- END CONTENT BODY -->
</div>

<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery_redirect/jquery.redirect.js" type="text/javascript"></script>


<script type="text/javascript">
$(document).ready(function(){
	fnObj.fnAllCheckbox();
});

var fnObj = {
	fnAllCheckbox:function() {
		$("#allCheck").click(function(){ 
			if($("#allCheck").is(":checked")) {
				$("input[name='checkId']").prop("checked", true);
			} else {
				$("input[name='checkId']").prop("checked", false);
			}
		});
	},
	fnSelect:function(id, name) {
		var relaId = $("#arrRelationId", opener.document).val();
		var relationName = $("#relationName", opener.document).val();
		var relaIdCnt = $("#arrRelationId", opener.document).val().split(',').length;
		if(relaId == null) {
			
			$("#relationName", parent.opener.document).val(name);
			$("#arrRelationId", parent.opener.document).val(id);
			
		} else if(relaId != null) {
			
			if(relaIdCnt > 2) {
				alert("선택된 인원이 3명을 초과하였습니다.");
				return false;
			}
			
			if(relaId.indexOf(id) < 0) {
				relaId += (relaId.length == 0 ? "": ",") + "" + id + "";
				relationName += (relationName.length == 0 ? "": "|") + "" + name + "";
				$("#relationName", parent.opener.document).val(relationName);
				$("#arrRelationId", parent.opener.document).val(relaId);
			} else {
				alert("해당 인원은 선택된 상태입니다.");
				return false;
			}			
		}
	},
	fnSelectAll:function() {
		var checkLen = $('input:checkbox[name="checkId"]:checked').length;
		var relaId = $("#arrRelationId", opener.document).val();
		
		var relaIdCnt = $("#arrRelationId", opener.document).val().split(',');
		
		if(checkLen == 0) {
			alert('체크된 항목이 없습니다.');
			return false;
		} else if((checkLen+relaIdCnt.length) > 2) {
			alert('선택된 연계회원이 3명을 초과하였습니다.');
			return false;
		} else {
			// 체크 된 인원 추가
			
			window.close();
		}
	}
		
}

var page = {
	fnInit:function(pageNo) {
		if(pageNo == null) {
			pageNo = '1';
		} else {
			pageNo = pageNo;
		}
		
		$("#page").val(pageNo);
		$("#searchFrm").attr("action", "/mailbox/selectRelationPopList.do");
		
		$("#searchFrm").submit();
		

	}
}
</script>