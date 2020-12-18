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
		<input type="hidden" name="pageRoute" id="pageRoute" value="${param.pageRoute }"/>
		<input type="hidden" name="userId" id="userId" value="${param.matchId }"/>
		<c:choose>
			<c:when test="${param.matchGubn eq 'D' }">
				※ 매칭회원(수혜자) 검색
			</c:when>
			<c:otherwise>
				※ 매칭회원(기증자 가족회원) 검색
			</c:otherwise>
		</c:choose>
		<br/><br/>
	    <!-- BEGIN PAGE HEADER-->
    	<form id="searchFrm" name="searchFrm">
    		<input type="hidden" id="gubn" name="gubn" value="${param.matchGubn }"/>
			<table class="table table-bordered">
				<c:choose>
					<c:when test="${param.matchGubn eq 'D' }">
						<input type="hidden" id="benefiNameArr" name="benefiNameArr" value="${param.benefiNames }"/>
						<input type="hidden" id="benefiBirthArr" name="benefiBirthArr" value="${param.benefiBirths }"/>
						<input type="hidden" id="benefiHospitalIdxsArr" name="benefiHospitalIdxsArr" value="${param.benefiHospitalIdxs }"/>
						<input type="hidden" id="benefiPartsIdxsArr" name="benefiPartsIdxsArr" value="${param.benefiPartsIdxs }"/>
						<input type="hidden" id="selIdx" name="selIdx" value=""/>
						<c:set var="benefiNameArr" value="${fn:split(param.benefiNames, ',') }"/>
						<c:set var="benefiBirthArr" value="${fn:split(param.benefiBirths, ',') }"/>
						<c:set var="benefiHospitalIdxsArr" value="${fn:split(param.benefiHospitalIdxs, ',') }"/>
						<c:set var="benefiHospitalNamesArr" value="${fn:split(param.benefiHospitalNames, ',') }"/>
						<c:set var="benefiPartsIdxsArr" value="${fn:split(param.benefiPartsIdxs, ',') }"/>
						<c:set var="benefiPartsNamesArr" value="${fn:split(param.benefiPartsNames, ',') }"/>
						<c:set var="benefiLength" value="${fn:length(benefiNameArr) }"/>
						<tr>
							<td>수혜자명</td>
							<td>생년월일</td>
							<td>기증병원</td>
							<td>수혜장기</td>
							<td>검색</td>
						</tr>
						<c:forEach var="idx" begin="0" end="${benefiLength-1}">
							<tr>
								<td>${benefiNameArr[idx] }</td>
								<td>${benefiBirthArr[idx] }</td>
								<td>${benefiHospitalNamesArr[idx] }</td>
								<td>${benefiPartsNamesArr[idx] }</td>
								<td>
			    					<a id="btnSearch" class="btn dark btn-outline btn-circle btn-sm" href="#" onclick="fnObj.fnSearch('${idx}');" style="margin-top: 6px; border-radius: 8px!important; width:80px;">검색</a>
			    				</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<input type="hidden" id="donorName" name="donorName" value="${param.matchDonorName }"/>
						<input type="hidden" id="donorBirth" name="donorBirth" value="${param.matchDonorBirth }"/>
						<input type="hidden" id="donorHospitalIdx" name="donorHospitalIdx" value="${param.matchDonorHospitalIdx }"/>
						<input type="hidden" id="donorDate" name="donorDate" value="${param.matchDonorDate }"/>
						<tr>
							<td>기증자</td>
				    		<td>생년월일</td>
				    		<td>기증병원</td>
				    		<td>기증일</td>
				    		<td>검색</td>
				    	</tr>
				    	<tr>
			    			<td>${param.matchDonorName }</td>
			    			<td>${param.matchDonorBirth }</td>
			    			<td>${param.matchDonorHospitalName }</td>
			    			<td>${param.matchDonorDate }</td>
			    			<td>
			    				<a id="btnSearch" class="btn dark btn-outline btn-circle btn-sm" href="#" onclick="fnObj.fnSearch(0);" style="margin-top: 6px; border-radius: 8px!important; width:80px;">검색</a>
			    			</td>
				    	</tr>
					</c:otherwise>
				</c:choose> 
		    </table>
		</form>
	    
	    
		<!-- END PAGE HEADER-->
		<div class="row" style="margin-top:20px;">
			<div class="col-md-12">
	   		<!-- BEGIN SAMPLE TABLE PORTLET-->
				<div class="portlet light portlet-fit bordered">                     
	                <div class="portlet-body">
	                	<table class="table table-bordered">
	                		<tr>
								<td>번호</td>
								<td>구분</td>			                      
								<td>이름(아이디)</td>					                      					                      					                      				                      					                      
								<td>핸드폰</td>
								<td>
									<c:choose>
										<c:when test="${param.matchGubn eq 'D' }">
											수혜자정보
										</c:when>
										<c:otherwise>
											기증자정보
										</c:otherwise>
									</c:choose>
								</td>
								<td>선택</td>
							</tr>   
							<tbody id="tbodyMatch">
								
							</tbody>
	                	</table>   
	                </div>                     
	            </div>   
	            <c:choose>
	            	<c:when test="${param.matchGubn eq 'D' }">
						※ 수혜자 회원
	            	</c:when>
	            	<c:otherwise>
	            		※ 기증자 가족 회원
	            	</c:otherwise>
	            </c:choose>
	            <input type="text" id="arrMatchNameList" name="arrMatchNameList" value=""/>
	            <input type="hidden" id="arrMatchIdList" name="arrMatchIdList" value=""/>  
	            
	            <a id="btnSearch" class="btn dark btn-outline btn-circle btn-sm" href="#" onclick="fnObj.fnApply();" style="margin-top: 6px; border-radius: 8px!important; width:150px;">적용</a>
	            <a id="btnInit" class="btn dark btn-outline btn-circle btn-sm" href="#" onclick="fnObj.fnInit();" style="margin-top: 6px; border-radius: 8px!important; width:150px;">초기화</a>             
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


<script type="text/javascript">
$(document).ready(function(){
});

var fnObj = {
	fnSelect:function(id, name) {
		var arrMatchNameList = $("#arrMatchNameList").val();
		var arrMatchIdList = $("#arrMatchIdList").val();
		
		if(arrMatchIdList.indexOf(id) < 0) {
			arrMatchNameList += (arrMatchNameList.length == 0 ? "": ",") + "" + name + "";
			arrMatchIdList += (arrMatchIdList.length == 0 ? "": ",") + "" + id + "";
			
	 		$("#arrMatchNameList").val(arrMatchNameList);
			$("#arrMatchIdList").val(arrMatchIdList);
		} else {
			alert('이미 추가된 회원입니다.');
			return false;
		}
	},
	fnInit:function() {
		$("#arrMatchNameList").val("");
		$("#arrMatchIdList").val("");
	},
	fnSearch:function(idx) {
		
		$("#selIdx").val(idx);
		
		var param = $("#searchFrm").serialize();
		
		$.ajax({
	        url: "<c:url value='/mailbox/selectMatchPopList.do'/>",
	        type: "POST",
	        async: false,
	        dataType: "json",
	        data: param,
	        success: function(data) {  
	        	var list = data.resultList;
	        	console.log(list);
	        	var innerHtml = "";
	        	for(var i=0; i<list.length; i++) {
	        		innerHtml += "<tr>";
		        	innerHtml += "<td>"+(i+1)+"</td>";
		        	if(list[i].gubn == "D") {
		        		
		        		innerHtml += "<td>" + list[i].gubnNm + "</td>";
			        	innerHtml += "<td>" + list[i].name + "(" + list[i].id + ")" + "</td>";
			        	innerHtml += "<td>" + list[i].phone + "</td>";
			        	innerHtml += "<td>" + list[i].donorName + "|" + list[i].donorBirth + "|" + list[i].hospitalName + "|" + list[i].donorDate + "</td>";
			        	innerHtml += "<td>";
			        	innerHtml += '<a id="btnSearch" class="btn dark btn-outline btn-circle btn-sm" href="#" onclick="fnObj.fnSelect(\''+list[i].id+'\', \''+list[i].name+'\');" style="margin-top: 6px; border-radius: 8px!important; width:80px;">선택</a>';			        	
			        	innerHtml += "</td>";
		        	} else {
		        		innerHtml += "<td>" + list[i].gubnNm + "</td>";
			        	innerHtml += "<td>" + list[i].name + "(" + list[i].id + ")" + "</td>";
			        	innerHtml += "<td>" + list[i].phone + "</td>";
			        	innerHtml += "<td>" + list[i].benefiName + "|" + list[i].benefiBirth + "|" + list[i].hospitalName + "|" + list[i].benefiPartsName + "</td>";
			        	innerHtml += "<td>";
			        	innerHtml += '<a id="btnSearch" class="btn dark btn-outline btn-circle btn-sm" href="#" onclick="fnObj.fnSelect(\''+list[i].id+'\', \''+list[i].name+'\');" style="margin-top: 6px; border-radius: 8px!important; width:80px;">선택</a>';
			        	innerHtml += "</td>";
		        	}
		        	innerHtml += "</tr>";
	        	}
	        	
	        	$("#tbodyMatch").html(innerHtml);
	        },
	        error: function(xhr, desc, err) {
	            alert("조회 실패");
	        }
	    });  
	},
	fnApply:function() {
		var param = {};
		
		if($("#pageRoute").val() == "memberMgmtList") {
			$.ajax({
		        url: "<c:url value='/mailbox/insertMatchList.do'/>",
		        type: "POST",
		        async: false,
		        dataType: "json",
		        data: {
		        	userId : $("#userId").val(),
		        	arrMatchId : $("#arrMatchIdList").val()
		        },
		        success: function(data) {    
		        	if(data.flag) {
		        		alert(data.msg);
		        		opener.parent.location = "/mailbox/memberMgmtList.do";    		
		        		window.close();
		        	} else {
		        		alert(data.msg);
		        		return false;
		        	}
		        },
		        error: function(xhr, desc, err) {
		            alert("저장 실패");
		        }
		    });
		} else {
			$("#matchingName", parent.opener.document).val($("#arrMatchNameList").val());
			$("#arrMatchId", parent.opener.document).val($("#arrMatchIdList").val());
			
		}
		
	}
		
}

var page = {
	fnInit:function() {
		$("#searchFrm").attr("action", "/mailbox/searchMatchPopList.do");
		$("#searchFrm").submit();

	}
}
</script>