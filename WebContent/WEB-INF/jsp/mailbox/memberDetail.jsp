<%@ page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="ajax" uri="http://ajaxtags.sourceforge.net/tags/ajaxtags"%>
<%@taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<style>
	.table td, .table th {
		text-align: left;
		vertical-align: middle !important;
	}
</style>
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/common/global/plugins/amcharts/amcharts/plugins/export/export.css" rel="stylesheet" type="text/css" media="all"/>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- END HEAD -->
<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">
<c:import url="/webMenu.do" charEncoding="UTF-8"></c:import>
<form id="frm_koda_member" class="form-horizontal" role="form" method="post" enctype="multipart/form-data" action="<c:url value='/mailbox/memberSave.do'/>">

<input type="hidden" id="inpType" name="inpType" value="U"/>
<input type="hidden" id="adultFlag" name="adultFlag" value="Y"/>
	<!-- BEGIN CONTENT -->
	<div class="page-content-wrapper">
		<!-- BEGIN CONTENT BODY -->
		<div class="page-content">
	    	<!-- BEGIN PAGE HEADER-->                    
			<!-- END PAGE HEADER-->
				<div class="row" style="margin-top: 70px;">
					▶  회원 상세보기
					<br/><br/>
					<div id="initDiv">
						<table class="table table-bordered">
							<thead>
							  <tr>
							    <th class="post_view_gray">구분</th>
							    <th colspan="5">${kodaMemberInfo.gubnName }</th>
							  </tr>
							</thead>
							<tbody>
								<tr>
								    <td class="post_view_gray">아이디</td>
								    <td>${kodaMemberInfo.id }</td>
									<td class="post_view_purple">이름</td>
									<td>${kodaMemberInfo.name }</td>
									<td class="post_view_purple">닉네임</td>
									<td>${kodaMemberInfo.nickName }</td>
								</tr>
								<tr>
									<td class="post_view_gray">연락처</td>
									<td>${kodaMemberInfo.phone }</td>
									<td class="post_view_purple">이메일주소</td>
									<td colspan="3">${kodaMemberInfo.email }</td>
								</tr>
								<tr>
									<td class="post_view_purple">생년월일</td>
									<td>${kodaMemberInfo.birthday }</td>
									<td class="post_view_purple">성별</td>
									<td colspan="3">
										<c:if test="${kodaMemberInfo.gender != '' }">
											${kodaMemberInfo.gender eq 'M' ? '남자' : '여자' }
										</c:if>
									</td>
								</tr>
								<tr>
									<td class="post_view_purple">문자수신여부</td>
									<td>${kodaMemberInfo.smsFlag }</td>
									<td class="post_view_purple">이메일수신여부</td>
									<td colspan="3">${kodaMemberInfo.emailFlag }</td>
								</tr>
								<tr>
									<td class="post_view_purple">주소</td>
									<td colspan="5">${kodaMemberInfo.address } ${kodaMemberInfo.addressDetail }</td>
								</tr>
							  	<c:choose>
							  		<c:when test="${kodaMemberInfo.gubn eq 'D' }">
										<tr>
											<td class="post_view_purple" rowspan="2">기증자정보</td>
											<td class="post_view_green">기증자명</td>
											<td>${kodaMemberInfo.donorName }</td>
											<td class="post_view_green">생년월일</td>
											<td colspan="2">${kodaMemberInfo.donorBirth }</td>
										</tr>
										<tr>
											<td class="post_view_green">기증병원</td>
											<td>${kodaMemberInfo.donorHospitalNm }</td>
											<td class="post_view_green">기증날짜</td>
											<td colspan="2">${kodaMemberInfo.donorDate }</td>
										</tr>
										<tr>
											<td class="post_view_purple">기증자와의 관계</td>
											<td colspan="5">${kodaMemberInfo.donorRelationNm }</td>
										</tr>
							  		</c:when>
							  		<c:otherwise>
								  		<tr>
											<td class="post_view_purple" rowspan="2">수혜자정보</td>
											<td class="post_view_green">이름</td>
											<td class="">${kodaMemberInfo.benefiName }</td>
											<td class="post_view_green">생년월일</td>
											<td colspan="2">${kodaMemberInfo.benefiBirth }</td>
										</tr>
										<tr>
											<td class="post_view_green">병원명</td>
											<td class="">${kodaMemberInfo.benefiHospitalNm }</td>
											<td class="post_view_green">이식장기</td>
											<td colspan="2">${kodaMemberInfo.benefiPartsNm }</td>
										</tr>
							  		</c:otherwise>
							  	</c:choose>
								
								<tr>
									<td class="post_view_purple">보호자명</td>
									<td colspan="5">${kodaMemberInfo.prtName }</td>
								</tr>
								<tr>
									<td class="post_view_purple">보호자생년월일</td>
									<td colspan="5">${kodaMemberInfo.prtBirthday }</td>
								</tr>
								<tr>
									<td class="post_view_purple">보호자 연락처</td>
									<td colspan="5">${kodaMemberInfo.prtPhone }</td>
								</tr>
								<tr>
									<td class="post_view_purple">보호자 성별</td>
									<td colspan="5">
										<c:if test="${kodaMemberInfo.prtGender != ''}">
											${kodaMemberInfo.prtGender eq 'M' ? '남자' : '여자' }
										</c:if>
									</td>
								</tr>
								<tr>
									<td class="post_view_purple">연계가족</td>
									<td colspan="5">
										<c:choose>
											<c:when test="${kodaMemberInfo.gubn == 'D' }">
												${kodaMemberInfo.relationList }
											</c:when>
											<c:otherwise>
												<p style="text-decoration: line-through; color: red;">(수혜자의 경우 연계가족 없습니다.)</p>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<c:choose>
									<c:when test="${kodaMemberInfo.gubn == 'D' }">
										<tr>
											<td class="post_view_purple">매칭<br/>(수혜자현황)</td>
											<td colspan="5">${kodaMemberInfo.matchList }</td>
										</tr>
									</c:when>
									<c:otherwise>
										<tr>
											<td class="post_view_purple">매칭<br/>(기증자 가족 현황)</td>
											<td colspan="5">${kodaMemberInfo.matchList }</td>
										</tr>
									</c:otherwise>
								</c:choose>
								<tr>
									<td class="post_view_purple">등록일</td>
									<td colspan="5">${kodaMemberInfo.inpDate }</td>
								</tr>
								<tr>
									<td class="post_view_purple">승인여부</td>
									<td colspan="5">
										<input type="radio" id="apprFlag1" name="rdoApprFlag" value="Y" ${kodaMemberInfo.apprFlag=='Y'?'checked':''}/>승인
										<input type="radio" id="apprFlag2" name="rdoApprFlag" value="N" ${kodaMemberInfo.apprFlag=='N'?'checked':''}/>미승인
									</td>
								</tr>
							</tbody>
						</table>
					
				</div>
				<div class="col-md-offset-5 col-md-9">
					<input type="button" class="btn green" onClick="fnObj.fnSave()" value="저장"/>
					<input type="button" class="btn green" name="list" id="list" onClick="fnObj.fnList();" value="목록으로">
				</div>
		</div>
		<!-- END CONTENT BODY -->
	</div>
</form>


  
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery_redirect/jquery.redirect.js" type="text/javascript"></script>
 
<script type="text/javascript">
$(document).ready(function(){
	
});

var fnObj = {
	fnList:function() {
		location.href = "/mailbox/memberMgmtList.do";
	},
	fnSave:function() {
		var paramObj = {};
		paramObj.id = "${kodaMemberInfo.id}";
		paramObj.apprFlag = $("input[name='rdoApprFlag']:checked").val();
		
		$.ajax({
	        url: "<c:url value='/mailbox/updateApprFlag.do'/>",
	        type: "POST",
	        async: false,
	        dataType: "json",
	        data: paramObj,
	        success: function(data) {    
	        	if(data.flag) {
	        		alert(data.msg);
	        		location.href = "/mailbox/memberMgmtList.do";
	        	} else {
	        		alert(data.msg);
	        		return false;
	        	}
	        },
	        error: function(xhr, desc, err) {
	            alert("저장 실패");
	        }
	    });  
	}
}
</script>