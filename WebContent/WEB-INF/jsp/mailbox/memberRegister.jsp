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
<%
/*
	-우체통 전체회원관리
	1.틀만 만들어놓음 작업해야함
*/
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
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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
				<form id="frm_koda_member" name="frm_koda_member" class="form-horizontal" role="form" method="post" enctype="multipart/form-data" action="<c:url value='/mailbox/memberSave.do'/>">
					<input type="hidden" id="inpType" name="inpType" value="${kodaMemberInfo.id==null?'I':'U'}"/>
					<input type="hidden" id="adultFlag" name="adultFlag" value="Y"/>
						▶  회원 등록
						<br/><br/>
						<div id="initDiv">
							<table class="table table-hover">
								<tr>
									<td class="post_register_td_170 post_td_gray">
										<span class="post_star">*</span> 
										구분
									</td>
									<td>
										<input type="radio" id="gubn1" name="gubn" value="D" ${kodaMemberInfo != null ? (kodaMemberInfo.gubn=='D' ? 'checked' : '') : 'checked'}/>기증자가족
										<input type="radio" id="gubn2" name="gubn" value="B" ${kodaMemberInfo != null ? (kodaMemberInfo.gubn=='B' ? 'checked' : '') : ''}/>수혜자
									</td>
								</tr>
								<tr>
									<td class="post_register_td_170 post_td_gray">
										<span class="post_star">*</span> 
										아이디
									</td>
									<td><input type="text" class="post_inp_style post_input200" id="userId" name="userId" value="${kodaMemberInfo.id }" ${kodaMemberInfo != null ? 'readonly' : '' } onBlur="fnValid.fnId()"/> ※ 최소 3자이상 (영문자, 숫자, _만 가능)</td>
								</tr>
								<tr>
									<td class="post_register_td_170 post_td_gray">
										<span class="post_star">*</span>
										 패스워드
									</td>
									<td><input type="password" class="post_inp_style post_input200" id="userPassword" name="userPassword" value="${kodaMemberInfo.password }" onBlur="fnValid.fnPassword()"/> ※ 9자 이상 ~ 16자 이하 (영문자 + 숫자 + 특수문자 조합)</td>
								</tr>
								<tr>
									<td class="post_register_td_170 post_td_gray">
										<span class="post_star">*</span>
										 패스워드 확인
									</td>
									<td><input type="password" class="post_inp_style post_input200" id="userPasswordConfirm" name="userPasswordConfirm" value="${kodaMemberInfo.password }" onBlur="fnValid.fnPassword('C')"/></td>
								</tr>
								<tr>
									<td class="post_register_td_170 post_td_gray">
										<span class="post_star">*</span>
										이름
									</td>
									<td><input type="text" class="post_inp_style post_input200" id="userName" name="userName" value="${kodaMemberInfo.name }" required/></td>
								</tr>
								<tr>
									<td class="post_register_td_170 post_td_gray">
										<span class="post_star">*</span>
										닉네임
									</td>
									<td><input type="text" class="post_inp_style post_input200" id="userNickName" name="userNickName" value="${kodaMemberInfo.nickName }" required/></td>
								</tr>
								<tr>
									<td class="post_register_td_170 post_td_gray">
										<span class="post_star">*</span>
										성별
									</td>
									<td>
										<input type="radio" id="gender1" name="gender" value="M" ${kodaMemberInfo != null ? (kodaMemberInfo.gender=='M' ? 'checked' : '') : 'checked'}/>남성
										<input type="radio" id="gender2" name="gender" value="F" ${kodaMemberInfo != null ? (kodaMemberInfo.gender=='F' ? 'checked' : '') : ''}/>여성
									</td>
								</tr>
								<tr>
									<td class="post_register_td_170 post_td_gray">	
										<span class="post_star">*</span> 
										생년월일
									</td>
									<td>
										<input type="text" class="post_inp_style post_input200 form_datetime" size="20" name="birthday" id="birthday" value="${kodaMemberInfo.birthday }">
									</td>
								</tr>
								<tr>
									<td class="post_register_td_170 post_td_gray">	
										<span class="post_star">*</span>
										연락처
									</td>
									<td>
										<input type="text" class="post_inp_style post_input200" size="20" name="phone" id="phone" value="${kodaMemberInfo.phone }"> 예) 010-0000-0000
									</td>
								</tr>
								<tr>
									<td class="post_register_td_170 post_td_gray">	
										<span class="post_star">*</span>
										이메일주소 #1
									</td>
									<td>
										<input type="email" class="post_inp_style post_input200" size="50" name="email" id="email" value="${kodaMemberInfo.email }"> 예) kildong@naver.com
									</td>
								</tr>
								<tr>
									<td class="post_register_td_170 post_td_gray"><span style="margin-left: 12px;">이메일주소 #2</span></td>
									<td>
										<input type="email" class="post_inp_style post_input200" size="50" name="email2" id="email2" value="${kodaMemberInfo.email2 }"> 예) kildong@naver.com
									</td>
								</tr>
								<tr>
									<td class="post_register_td_170 post_td_gray"><span style="margin-left: 12px;">이메일 수신여부</span></td>
									<td>
										<input type="radio" id="emailFlag1" name="emailFlag" value="Y" ${kodaMemberInfo.emailFlag=='Y'?'checked':''}/>동의
										<input type="radio" id="emailFlag2" name="emailFlag" value="N" ${kodaMemberInfo.emailFlag=='N'?'checked':''}/>거부
									</td>
								</tr>
								<tr>
									<td class="post_register_td_170 post_td_gray"><span style="margin-left: 12px;">문자 수신여부</span></td>
									<td>
										<input type="radio" id="smsFlag1" name="smsFlag" value="Y" ${kodaMemberInfo.smsFlag=='Y'?'checked':''}/>동의
										<input type="radio" id="smsFlag2" name="smsFlag" value="N" ${kodaMemberInfo.smsFlag=='N'?'checked':''}/>거부
									</td>
								</tr>
								<tr>
									<td rowspan="3" class="post_register_td_170 post_td_gray">	
										<span class="post_star">*</span>
										주소
									</td>
									<td>
										<input type="text" class="post_inp_style" id="post" name="post" value="${kodaMemberInfo.post }"/>
										<span>                                            
											<input type="button" onclick="sample6_execDaumPostcode();" value="우편번호" class="btn blue">
										</span>
									</td>
								</tr>
								<tr>
									<td>
										<input type="text" class="post_inp_style post_input600" id="address" name="address" value="${kodaMemberInfo.address }"/>
									</td>
								</tr>
								<tr>
									<td>
										<input type="text" class="post_inp_style post_input600" id="addressDetail" name="addressDetail" value="${kodaMemberInfo.addressDetail }"/>
										<input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
									</td>
								</tr>
							</table>
						</div>
						<div id="parentDiv" style="display:none;">
							○ 보호자 정보 ※ 만 14세 미만의 어린이는 보호자 동의가 필요합니다.
							<table class="table table-hover">
								<tr>
									<td class="post_register_td_170 post_td_gray">
										<span class="post_star">*</span>
										보호자이름
									</td>
									<td>
										<input type="text" class="post_inp_style post_input200" id="parentName" name="parentName" value="${kodaMemberInfo.prtName }"/>
									</td>
								</tr>
								<tr>
									<td class="post_register_td_170 post_td_gray">	
										<span class="post_star">*</span> 
										보호자 생년월일
									</td>
									<td>
										<input type="text" class="post_inp_style post_input200 form_datetime" size="20" name="parentBirthday" id="parentBirthday" value="${kodaMemberInfo.prtBirthday }">
									</td>
								</tr>
								<tr>
									<td class="post_register_td_170 post_td_gray">	
										<span class="post_star">*</span>
									 	보호자 성별
									 </td>
									<td>
										<input type="radio" id="parentGender1" name="parentGender" value="M" ${kodaMemberInfo.prtGender=='M'?'checked':''}/>남성
										<input type="radio" id="parentGender2" name="parentGender" value="F" ${kodaMemberInfo.prtGender=='F'?'checked':''}/>여성
									</td>
								</tr>
								<tr>
									<td class="post_register_td_170 post_td_gray">	
										<span class="post_star">*</span>
										 휴대전화
									</td>
									<td>
										<input type="text" class="post_inp_style post_input200" size="20" name="parentPhone" id="parentPhone" value="${kodaMemberInfo.prtPhone }"> 예) 010-0000-0000
									</td>
								</tr>
							</table>
						</div>
						<input type="hidden" id="apprFlag" name="apprFlag" value=""/>
					</form>
					
					<form id="donorForm" name="donorForm">
						<div id="donorDiv" style="display:${kodaMemberInfo != null ? (kodaMemberInfo.gubn == 'B' ? 'none' : 'block') : 'block'}">
							○ 기증자 정보 <font color="red">※ 기증자 정보가 일치해야 회원으로 승인이 됩니다.</font> 
							<input type="button" value="KONOS" onclick="fnPop.fnKonosPop()"/> 
							<br/>
							<table class="table table-hover">
								<tr>
									<td class="post_register_td_170 post_td_green">	
										<span class="post_star">*</span> 
										기증자명
									</td>
									<td>
										<input type="text" class="post_inp_style post_input200" id="dDonorName" name="dDonorName" value="${donorList.donorName }"/>
									</td>
								</tr>
								<tr>
									<td class="post_register_td_170 post_td_green">	
										<span class="post_star">*</span> 
										기증병원
									</td>
									<td>
										<select id="dDonorHospital" name="dDonorHospital">
											<c:forEach var="hospitalList" items="${hospitalList}" varStatus="status">
												<option value="${hospitalList.hospital_idx}" <c:if test="${donorList.hospitalIdx eq hospitalList.hospital_idx}"> selected </c:if>> ${hospitalList.hospital_name} </option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td class="post_register_td_170 post_td_green">	
										<span class="post_star">*</span> 
										생년월일
									</td>
									<td>
										<input type="text" class="post_inp_style post_input200 form_datetime" size="20" name="dDonorBirthday" id="dDonorBirthday" value="${donorList.donorBirth }">
									</td>
								</tr>
								<tr>
									<td class="post_register_td_170 post_td_green">	
										<span class="post_star">*</span> 
										기증일
									</td>
									<td>
										<input type="text" class="post_inp_style post_input200 form_datetime" size="20" name="dDonorDate" id="dDonorDate" value="${donorList.donorDate }">
									</td>
								</tr>
							</table>
							○ 기증자와의 관계
							<table class="table table-hover">
								<tr>
									<td class="post_register_td_170 post_td_gray"><span style="margin-left: 12px;">기증자와의 관계</span></td>
									<td>
										<select id="dDonorRelation" name="dDonorRelation">
											<c:forEach var="donorRelationList" items="${donorRelationList }" varStatus="status">
												<option value="${donorRelationList.code }" <c:if test="${donorList.donorRelation eq donorRelationList.code}"> selected </c:if>>${donorRelationList.name }</option>
											</c:forEach>
										</select>
									</td>
								</tr>
							</table>
							○ 수혜자 정보 <font color="red">※ 수혜자 정보가 일치해야 회원 매칭이 됩니다.</font>
							<input type="button" onclick="fnObj.addBenefiRow()" value="행추가"/>
							<input type="button" onclick="fnObj.delBenefiRow()" value="행삭제"/>
							<table class="table table-hover" id="dBenefiTable">
								<tr>
									<td>수혜자명</td>
									<td>생년월일</td>
									<td>기증병원</td>
									<td>수혜장기</td>
								</tr>
								<tbody>
									<c:if test="${kodaMemberInfo != null }">
										<c:forEach var="benefiList" items="${benefiList }" varStatus="status">
										<c:set var="idx" value="${status.count }"/>
											<tr>
												<td><input type="text" id="dBenefiName" name="dBenefiName" value="${benefiList.benefiName}"/></td>
												<td><input type="text" id="dBenefiBirth" name="dBenefiBirth" value="${benefiList.benefiBirth }"/></td>
												<td>
													<select id="dBenefiHospital_${idx }" name="dBenefiHospital_${idx }">
														<c:forEach var="hospitalList" items="${hospitalList}" varStatus="status">
															<option value="${hospitalList.hospital_idx}" <c:if test="${benefiList.hospitalIdx eq hospitalList.hospital_idx}"> selected </c:if>> ${hospitalList.hospital_name} </option>
														</c:forEach>
													</select>
												</td>
												<td>
													<select id="dBenefiParts_${idx }" name="dBenefiParts_${idx }">
														<c:forEach var="benefiPartList" items="${benefiPartList}" varStatus="status">
															<option value="${benefiPartList.code}" <c:if test="${benefiList.benefiParts eq benefiPartList.code}"> selected </c:if>> ${benefiPartList.name} </option>
														</c:forEach>
													</select>
												</td>
											</tr>
										</c:forEach>
									</c:if>
								</tbody>
							</table>
						</div>
						<input type="hidden" id="arrDBenefiName" name="arrDBenefiName" value=""/>
						<input type="hidden" id="arrDBenefiBirthday" name="arrDBenefiBirthday" value=""/>
						<input type="hidden" id="arrDBenefiHospital" name="arrDBenefiHospital" value=""/>
						<input type="hidden" id="arrDBenefiHospitalName" name="arrDBenefiHospitalName" value=""/>
						<input type="hidden" id="arrDBenefiParts" name="arrDBenefiParts" value=""/>
						<input type="hidden" id="arrDBenefiPartsName" name="arrDBenefiPartsName" value=""/>
					</form>
					
					<form id="benefiForm" name="benefiForm">
						<div id="benefiDiv" style="display:${kodaMemberInfo != null ? (kodaMemberInfo.gubn == 'D' ? 'none' : 'block') : 'none'}">
							○ 수혜자 정보 <font color="red">※ 수혜자 정보가 일치해야 회원으로 승인이 됩니다.</font>
							<input type="button" value="KONOS" onclick="fnPop.fnKonosPop()"/>
							</br>
							<table class="table table-hover">
								<c:choose>
									<c:when test="${fn:length(benefiList) != 0 }">
										<c:forEach var="benefiList" items="${benefiList }" varStatus="status">
											<c:if test="${status.first }">
												<tr>
													<td class="post_register_td_170 post_td_green">	
														<span class="post_star">*</span> 
														수혜자성명
													</td>
													<td>
														<input type="text" class="post_inp_style post_input200" id="bBenefiName" name="bBnefiName" value="${benefiList.benefiName }"/>
													</td>
												</tr>
												<tr>
													<td class="post_register_td_170 post_td_green">
														<span class="post_star">*</span>
														기증병원
													</td>
													<td>
														<select id="bBenefiHospital" name="bBenefiHospital">
															<c:forEach var="hospitalList" items="${hospitalList}" varStatus="status">
																<option value="${hospitalList.hospital_idx}" <c:if test="${benefiList.hospitalIdx eq hospitalList.hospital_idx}"> selected </c:if>> ${hospitalList.hospital_name} </option>
															</c:forEach>
														</select>
													</td>
												</tr>
												<tr>
													<td class="post_register_td_170 post_td_green">
														<span class="post_star">*</span>
														생년월일
													</td>
													<td>
														<input type="text" class="post_inp_style post_input200 form_datetime" size="20" name="bBenefiBirthday" id="bBenefiBirthday" value="${benefiList.benefiBirth }">
													</td>
												</tr>
												<tr>
													<td class="post_register_td_170 post_td_green">	
														<span class="post_star">*</span> 
														기증장기
													</td>
													<td>
														<select id="bBenefiParts" name="bBenefiParts">
															<c:forEach var="benefiPartList" items="${benefiPartList}" varStatus="status">
																<option value="${benefiPartList.code}" <c:if test="${benefiList.benefiParts eq benefiPartList.code}"> selected </c:if>> ${benefiPartList.name} </option>
															</c:forEach>
														</select>
													</td>
												</tr>
											</c:if>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td class="post_register_td_170 post_td_green">	
												<span class="post_star">*</span> 
												수혜자성명
											</td>
											<td>
												<input type="text" class="post_inp_style post_input200" id="bBenefiName" name="bBenefiName" value=""/>
											</td>
										</tr>
										<tr>
											<td class="post_register_td_170 post_td_green">
												<span class="post_star">*</span>
												기증병원
											</td>
											<td>
												<select id="bBenefiHospital" name="bBenefiHospital">
													<c:forEach var="hospitalList" items="${hospitalList}" varStatus="status">
														<option value="${hospitalList.hospital_idx}"> ${hospitalList.hospital_name} </option>
													</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<td class="post_register_td_170 post_td_green">
												<span class="post_star">*</span>
												생년월일
											</td>
											<td>
												<input type="text" class="post_inp_style post_input200 form_datetime" size="20" name="bBenefiBirthday" id="bBenefiBirthday" value="">
											</td>
										</tr>
										<tr>
											<td class="post_register_td_170 post_td_green">	
												<span class="post_star">*</span> 
												기증장기
											</td>
											<td>
												<select id="bBenefiParts" name="bBenefiParts">
													<c:forEach var="benefiPartList" items="${benefiPartList}" varStatus="status">
														<option value="${benefiPartList.code}"> ${benefiPartList.name} </option>
													</c:forEach>
												</select>
											</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
							○ 기증자 정보 <font color="red">※ 기증자 정보가 일치해야 회원 매칭이 됩니다.</font>
							<table class="table table-hover">
								<tr>
									<td>기증자</td>
									<td>생년월일</td>
									<td>기증병원</td>
									<td>기증일</td>
								</tr>
								<tr>
									<td>
										<input type="text" id="bDonorName" name="bDonorName" value="${donorList.donorName }"/>
									</td>
									<td>
										<input type="text" class="post_inp_style post_input200 form_datetime" size="20" name="bDonorBirthday" id="bDonorBirthday" value="${donorList.donorBirth}">
									</td>
									<td>
										<select id="bDonorHospital" name="bDonorHospital">
											<c:forEach var="hospitalList" items="${hospitalList}" varStatus="status">
												<option value="${hospitalList.hospital_idx}" <c:if test="${donorList.hospitalIdx eq hospitalList.hospital_idx}"> selected </c:if>> ${hospitalList.hospital_name} </option>
											</c:forEach>
										</select>
									</td>
									<td>
										<input type="text" class="post_inp_style post_input200 form_datetime" size="20" name="bDonorDate" id="bDonorDate" value="${donorList.donorDate }">
									</td>
							</table>
						</div>
					</form>
					
					<form id="relaMatchFrm" name="relaMatchFrm">
						<table class="table table-hover">
							<tr>
								<td class="post_register_td_170 post_td_gray"><span style="margin-left: 12px;">연계회원</span></td>
								<td>
									<c:choose>
										<c:when test="${kodaMemberInfo != null }">
											<span id="benefiText" style="color: red; display:${kodaMemberInfo.gubn eq 'B' ? 'block' : 'none'};">※ 수혜자는 연계회원 없음</span>
											<span id="benefiVisible" style="display:${kodaMemberInfo.gubn eq 'B' ? 'none' : 'block'};">
												<input type="text" class="post_inp_style post_input200"  id="relationName" name="relationName" value="${kodaMemberInfo.relationNameDetail }" readonly/>
												<input type="button" id="relationPop" onclick="fnPop.fnRelationPop();" value="검색" class="btn blue">
												<input type="button" id="relationInit" onclick="fnPop.fnRelationInit();" value="초기화" class="btn black">
											</span>
										</c:when>
										<c:otherwise>
											<span id="benefiText" style="color: red; display:none;">※ 수혜자는 연계회원 없음</span>
											<span id="benefiVisible" style="display:block;">
												<input type="text" class="post_inp_style post_input200"  id="relationName" name="relationName" value="${kodaMemberInfo.relationNameDetail }" readonly/>
												<input type="button" id="relationPop" onclick="fnPop.fnRelationPop();" value="검색" class="btn blue">
												<input type="button" id="relationInit" onclick="fnPop.fnRelationInit();" value="초기화" class="btn black">
											</span>
										</c:otherwise>
									</c:choose>
									<input type="hidden" id="arrRelationId" name="arrRelationId" value="${kodaMemberInfo.relationIdDetail }"/>
								</td>
							</tr>
							<tr>
								<td class="post_register_td_170 post_td_gray">
									<span style="margin-left: 12px;">매칭회원</span>
									<br/>
									<span id="matchText"></span>
								</td>
								<td>
									<input type="text" class="post_inp_style post_input200" id="matchingName" name="matchingName" value="${kodaMemberInfo.matchNameDetail }" readonly/>
									<span>
										<input type="button" onclick="fnPop.fnMatchingPop();" value="검색" class="btn blue">
										<input type="button" onclick="fnPop.fnMatchingInit();" value="초기화" class="btn block">
									</span>
									<input type="hidden" id="arrMatchId" name="arrMatchId" value="${kodaMemberInfo.matchIdDetail }"/>
								</td>
							</tr>
							<tr>
								<td class="post_register_td_170 post_td_gray">	
									<span class="post_star">*</span> 
									승인여부
								</td>
								<td>
									<input type="radio" id="apprFlag1" name="rdoApprFlag" value="Y" ${kodaMemberInfo.apprFlag=='Y'?'checked':''}/>승인
									<input type="radio" id="apprFlag2" name="rdoApprFlag" value="N" ${kodaMemberInfo.apprFlag=='N'?'checked':''}/>미승인
								</td>
							</tr>
						</table>
					</form>
					<div class="col-md-offset-5 col-md-9">
						<input type="button" class="btn green" name="list" id="list" onClick="fnObj.fnSave();" value="저장">
						<input type="button" class="btn green" name="list" id="list" onClick="fnObj.fnList();" value="목록으로">
					</div>
				</div>
				
		</div>
		<!-- END CONTENT BODY -->
	</div>




<form name="relaPopupFrm" id="relaPopupFrm" method="post" action="" target="popup_window">
	<input type="hidden" id="id" name="id" value=""/>
	<input type="hidden" id="donorName" name="donorName" value=""/>
	<input type="hidden" id="donorHospitalIdx" name="donorHospitalIdx" value=""/>
	<input type="hidden" id="donorHospitalName" name="donorHospitalName" value=""/>
	<input type="hidden" id="donorBirth" name="donorBirth" value=""/>
	<input type="hidden" id="donorDate" name="donorDate" value=""/>
</form>

<form name="matchPopupFrm" id="matchPopupFrm" method="post" action="" target="popup_window">
	<input type="hidden" id="matchId" name="matchId" value=""/>
	<input type="hidden" id="matchGubn" name="matchGubn" value=""/>
	<input type="hidden" id="matchDonorName" name="matchDonorName" value=""/>
	<input type="hidden" id="matchDonorHospitalIdx" name="matchDonorHospitalIdx" value=""/>
	<input type="hidden" id="matchDonorHospitalName" name="matchDonorHospitalName" value=""/>
	<input type="hidden" id="matchDonorBirth" name="matchDonorBirth" value=""/>
	<input type="hidden" id="matchDonorDate" name="matchDonorDate" value=""/>
	<input type="hidden" id="benefiNames" name="benefiNames" value=""/>
	<input type="hidden" id="benefiBirths" name="benefiBirths" value=""/>
	<input type="hidden" id="benefiHospitalIdxs" name="benefiHospitalIdxs" value=""/>
	<input type="hidden" id="benefiHospitalNames" name="benefiHospitalNames" value=""/>
	<input type="hidden" id="benefiPartsIdxs" name="benefiPartsIdxs" value=""/>
	<input type="hidden" id="benefiPartsNames" name="benefiPartsNames" value=""/>
	
</form>
  
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery_redirect/jquery.redirect.js" type="text/javascript"></script>

<script type="text/javascript">

$(document).ready(function(){
	
	fnObj.fnDatePicker();
	fnObj.fnGubnDiv();
	fnObj.fnPrtFlagDiv();
	
	
});

var fnPop = {
	fnKonosPop:function() {
		window.open("https://www.konos.go.kr/konosis/index.jsp");
	},
	fnRelationPop:function() {
		
		if($("#dDonorName").val() == "" || $("#dDonorHospital option:selected").val() == "" || $("#dDonorBirthday").val() == "" || $("#dDonorDate").val() == "") {
			alert('기증자 정보를 입력해 주시기 바랍니다.');
			return false;
		}
		
		if($("#inpType").val() == "U") {
			$("#id").val($("#userId").val());
		}
		$("#donorName").val($("#dDonorName").val());
		$("#donorHospitalIdx").val($("#dDonorHospital option:selected").val());
		$("#donorHospitalName").val($("#dDonorHospital option:selected").text());
		$("#donorBirth").val($("#dDonorBirthday").val());
		$("#donorDate").val($("#dDonorDate").val());
		
		$('#relaPopupFrm').attr("action","<c:url value='/mailbox/relationPop.p'/>");
		
		var screenW = screen.availWidth;  
	    var screenH = screen.availHeight; 
	    var popW = 800; 
	    var popH = 350; 
	    var posL = (screenW-popW) / 2;    
	    var posT = (screenH-popH) / 2;    	
		window.open('','popup_window','width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=yes,status=no,titlebar=no');
		
		$('#relaPopupFrm').submit();
	},
	fnRelationInit:function() {
		$("#relationName").val("");
		$("#arrRelationId").val("");
	},
	fnMatchingInit:function() {
		$("#matchingName").val("");
		$("#arrMatchId").val("");
	},
	fnMatchingPop:function() {
		var gubn = $('input[name="gubn"]:checked').val();
		
		if($("#inpType").val() == "U") {
			$("#matchId").val($("#userId").val());
		}
		
		
		if(!fnPop.fnMatchingPopValid(gubn)) {
			if(gubn == "D") {
				alert("수혜자 정보를 입력해 주시기 바랍니다.");
			} else {
				alert("기증자 정보를 입력해 주시기 바랍니다.");
			}
			return false;
		}		
		
		$("#matchGubn").val(gubn);
		
		if(gubn == "D") {
			fnObj.fnBenefiListSet();
			$("#benefiNames").val($("#arrDBenefiName").val());
			$("#benefiBirths").val($("#arrDBenefiBirthday").val());
			$("#benefiHospitalIdxs").val($("#arrDBenefiHospital").val());
			$("#benefiHospitalNames").val($("#arrDBenefiHospitalName").val());
			$("#benefiPartsIdxs").val($("#arrDBenefiParts").val());	
			$("#benefiPartsNames").val($("#arrDBenefiPartsName").val());	
		} else {
			$("#matchDonorName").val($("#bDonorName").val());
			$("#matchDonorHospitalIdx").val($("#bDonorHospital option:selected").val());
			$("#matchDonorHospitalName").val($("#bDonorHospital option:selected").text());
			$("#matchDonorBirth").val($("#bDonorBirthday").val());
			$("#matchDonorDate").val($("#bDonorDate").val());
		}
		
		
		$('#matchPopupFrm').attr("action","<c:url value='/mailbox/matchingPop.p'/>");

		var screenW = screen.availWidth;  
	    var screenH = screen.availHeight; 
	    var popW = 800; 
	    var popH = 350; 
	    var posL=( screenW-popW ) / 2;    
	    var posT=( screenH-popH ) / 2;    	
		window.open('','popup_window','width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=yes,status=no,titlebar=no');
		
		$('#matchPopupFrm').submit();
	},
	fnMatchingPopValid:function(gubn) {
		var flag = false;
		
		if(gubn == "D") {
			$("input[name=dBenefiName]").each(function(idx){
				var dBenefiName = $("input[name=dBenefiName]:eq("+idx+")").val();
				var dBenefiBirth = $("input[name=dBenefiBirth]:eq("+idx+")").val();
				var dBenefiHospital = $("dBenefiHospital_"+idx).val();
				var dBenefiParts = $("#dBenefiParts_"+idx).val();
				if(dBenefiName == "" || dBenefiBirth == "" || dBenefiHospital == "" || dBenefiParts == "") {
					flag = false;
				} else {
					flag = true;
				}
					
			})
		} else {
			if($("#bDonorName").val() == "" || $("#bDonorBirthday").val() == "" || $("#bDonorHospital option:selected").val() == "" || $("#bDonorDate").val() == "") {
				flag = false;
			} else {
				flag = true;
			}
			
		}
		
		return flag;
	}
}

var fnObj = {
	fnValidSet:function() {
		if($("#userId").val() == "") {
			alert("ID는 필수 입력 사항입니다.");
			return false;
		}
		if($("#inpType").val() == "I") {
			if($("#userPassword").val() == "") {
				alert("패스워드는 필수 입력 사항입니다.");
				return false;
			}
		}
		if($("#userName").val() == "") {
			alert("이름은 필수 입력 사항입니다.");
			return false;
		}
		if($("#userNickName").val() == "") {
			alert("닉네임은 필수 입력 사항입니다.");
			return false;
		}
		if($("#gender").val() == "") {
			alert("성별은 필수 입력 사항입니다.");
			return false;
		}
		if($("#birthday").val() == "") {
			alert("생년월일은 필수 입력 사항입니다.");
			return false;
		}
		if($("#phone").val() == "") {
			alert("연락처는 필수 입력 사항입니다.");
			return false;
		}
		if($("#email").val() == "") {
			alert("이메일주소 #1은 필수 입력 사항입니다.");
			return false;
		}
		if($("#post").val() == "") {
			alert("주소는 필수 입력 사항입니다.");
			return false;
		}
		if($("#address").val() == "") {
			alert("주소는 필수 입력 사항입니다.");
			return false;
		}
		if($("#addressDetail").val() == "") {
			alert("주소는 필수 입력 사항입니다.");
			return false;
		}
		
		if($("#adultFlag") == "N") {
			if($("#parentName").val() == "") {
				alert("보호자 정보(보호자이름)은 필수 입력 사항입니다.");
				return false;
			}
			if($("#parentBirthday").val() == "") {
				alert("보호자 정보(보호자 생년월일)은 필수 입력 사항입니다.");
				return false;
			}
			if($("#parentGender").val() == "") {
				alert("보호자 정보(보호자 성별)은 필수 입력 사항입니다.");
				return false;
			}
			if($("#parentPhone").val() == "") {
				alert("보호자 정보(휴대전화)은 필수 입력 사항입니다.");
				return false;
			}
		}
		
		if($("#gubn option:selected").val() == "D") {
			if($("#dDonorName").val() == "") {
				alert("기증자 정보(기증자명)은 필수 입력 사항입니다.");
				return false;
			}
			if($("#dDonorHospital").val() == "") {
				alert("기증자 정보(기증병원)은 필수 입력 사항입니다.");
				return false;
			}
			if($("#dDonorBirthday").val() == "") {
				alert("기증자 정보(생년월일)은 필수 입력 사항입니다.");
				return false;
			}
			if($("#dDonorDate").val() == "") {
				alert("기증자 정보(기증일)은 필수 입력 사항입니다.");
				return false;
			}
		} else {
			if($("#bBenefiName").val() == "") {
				alert("수혜자 정보(수혜자명)은 필수 입력 사항입니다.");
				return false;
			}
			if($("#bBenefiHospital").val() == "") {
				alert("수혜자 정보(기증병원)은 필수 입력 사항입니다.");
				return false;
			}
			if($("#bBenefiBirthday").val() == "") {
				alert("수혜자 정보(생년월일)은 필수 입력 사항입니다.");
				return false;
			}
			if($("#bBenefiParts").val() == "") {
				alert("수혜자 정보(기증장기)은 필수 입력 사항입니다.");
				return false;
			}
		}
		
		
	},
	fnDatePicker:function(){
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
	},
	fnGubnDiv:function() {
		$("input[name=gubn]").change(function() {
			var gubn = $(this).val();
			if(gubn == "D") {
				$("#donorDiv").show();
				$("#benefiDiv").hide();
				
				$("#benefiText").hide();
				$("#benefiVisible").show();
				/*
				$("#relationName").show();
				$("#relationPop").show();
				$("#benefiText").hide();
				*/
				//$("#benefiForm").reset();
			} else if(gubn == "B") {
				$("#donorDiv").hide();
				$("#benefiDiv").show();
				
				$("#benefiText").show();
				$("#benefiVisible").hide();
				/*
				$("#relationName").hide();
				$("#relationPop").hide();
				$("#benefiText").show();
				*/
				
				//$("#benefiForm").reset();
			}
			
		});
	},
	fnPrtFlagDiv:function() {
		$("#birthday").on("propertychange change keyup paste input", function() {
			var birthday = this.value;
			var date = new Date();
			var year = date.getFullYear();
			var month = (date.getMonth() + 1);
			var day = date.getDate();       
			
			if (month < 10) month = '0' + month;
			if (day < 10) day = '0' + day;
			
			var monthDay = month + day;
			
			birthday = birthday.replace('-', '').replace('-', '');

			var birthdayy = birthday.substr(0, 4);
			var birthdaymd = birthday.substr(4, 4);

			var age = monthDay < birthdaymd ? year - birthdayy - 1 : year - birthdayy;

			if(age < 14) {
				$("#parentDiv").show();
				$("#adultFlag").val("N");
			} else {
				$("#parentDiv").hide();
				$("#adultFlag").val("Y");
			}
		});
	},
	fnBenefiListSet:function() {
		var gubn = $('input[name="gubn"]:checked').val();
		var benefiCnt = $("input[name=dBenefiName]").length;
		
		/* 수혜자 정보 리스트 셋팅 */
		var arrBenefiName = "";
		var arrBenefiBirthday = "";
		var arrBenefiHospital = "";
		var arrBenefiHospitalName = "";
		var arrBenefiParts = "";
		var arrBenefiPartsName = "";
		var arrBenefiName = "";
		
		/* 기증자 가족일 경우 수혜자 정보 파라미터 전달 */
		if(gubn == "D") {
			if(benefiCnt != 0) {
				for(var i=0; i<benefiCnt; i++) {
					arrBenefiName += (arrBenefiName.length == 0 ? "": ",") + "" + $("input[name='dBenefiName']")[i].value + "";
					arrBenefiBirthday += (arrBenefiBirthday.length == 0 ? "": ",") + "" + $("input[name='dBenefiBirth']")[i].value + "";
					arrBenefiHospital += (arrBenefiHospital.length == 0 ? "": ",") + "" + $("#dBenefiHospital_"+(i+1)+" option:selected").val() + "";
					arrBenefiHospitalName += (arrBenefiHospitalName.length == 0 ? "": ",") + "" + $("#dBenefiHospital_"+(i+1)+" option:selected").text() + "";
					arrBenefiParts += (arrBenefiParts.length == 0 ? "": ",") + "" + $("#dBenefiParts_"+(i+1)+" option:selected").val() + "";
					arrBenefiPartsName += (arrBenefiPartsName.length == 0 ? "": ",") + "" + $("#dBenefiParts_"+(i+1)+" option:selected").text() + "";
				}
				
				$("#arrDBenefiName").val(arrBenefiName);
				$("#arrDBenefiBirthday").val(arrBenefiBirthday);
				$("#arrDBenefiHospital").val(arrBenefiHospital);
				$("#arrDBenefiHospitalName").val($.trim(arrBenefiHospitalName));
				$("#arrDBenefiParts").val(arrBenefiParts);	
				$("#arrDBenefiPartsName").val($.trim(arrBenefiPartsName));	
			}
		}
		
	},
	fnSave:function() {
		var gubn = $('input[name="gubn"]:checked').val();
		var apprFlag = $('input[name="rdoApprFlag"]:checked').val();
		$("#apprFlag").val(apprFlag);
		
		var param = "";
		if(gubn == "D") {
			fnObj.fnBenefiListSet();
			param = $("#frm_koda_member, #donorForm, #relaMatchFrm").serialize();
		} else {
			param = $("#frm_koda_member, #benefiForm, #relaMatchFrm").serialize();			
		}
		
		var flag = this.fnValidSet();
		
		if(!flag) {
			return;
		}
		
		$.ajax({
	        url: "<c:url value='/mailbox/memberSave.do'/>",
	        type: "POST",
	        async: false,
	        dataType: "json",
	        data: param,
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
	},
	fnList:function() {
		location.href = "/mailbox/memberMgmtList.do";
	},
	addBenefiRow:function() {
		var trCnt = $("#dBenefiTable tr").length;

		if(trCnt < 4) {
			var innerHtml = "";
			innerHtml += '<tr>';
			innerHtml += '<td><input type="text" id="benefiName" name="dBenefiName" value=""/>';
			innerHtml += '</td>';
			innerHtml += '<td><input type="text" class="post_inp_style post_input200 form_datetime" size="20" name="dBenefiBirth" id="dBenefiBirth" value="">';
			innerHtml += '</td>';
			innerHtml += '<td><select id="dBenefiHospital_'+trCnt+'" name="dBenefiHospital">';
			<c:forEach var="hospitalList" items="${hospitalList}" varStatus="status">
				innerHtml += '<option value="${hospitalList.hospital_idx}"> ${hospitalList.hospital_name} </option>';
			</c:forEach>
			innerHtml += '</select></td>';
			innerHtml += '<td><select id="dBenefiParts_'+trCnt+'" name="dBenefiParts">';
			<c:forEach var="benefiPartList" items="${benefiPartList}" varStatus="status">
				innerHtml += '<option value="${benefiPartList.code}">${benefiPartList.name}</option>';
			</c:forEach>
			innerHtml += '</select></td>';
			innerHtml += '</tr>';
			$("#dBenefiTable > tbody:last").append(innerHtml);
		} else {
			alert("최대 3개까지만 가능합니다.");
			return false;
		}
	},
	delBenefiRow:function() {
		var trCnt = $("#dBenefiTable tr").length;
		
		if(trCnt > 1) {
			$("#dBenefiTable > tbody:last > tr:last").remove();
		} else {
			alert("삭제할 수혜자 정보가 없습니다.");
			return false;
		}
	}
}




Date.prototype.addDays = function (n) {
    var time = this.getTime();
    var changedDate = new Date(time + (n * 24 * 60 * 60 * 1000));
    this.setTime(changedDate.getTime());
    return this;
};


var fnValid = {
	fnPassword:function(type) {
		if($("#inpType").val() == 'I') {
			var password = $("#userPassword").val();
			var confirmPassword = $("#userPasswordConfirm").val();
			if(type == 'C') {
				if(password == "" && confirmPassword != "") {
					alert("패스워드를 입력 해 주세요");
					$("#userPasswordConfirm").val("");
					$("#userPassword").focus();
				} else if(confirmPassword != "" && password != confirmPassword) {
					alert('패스워드가 일치하지 않습니다.');
					$("#userPasswordConfirm").focus();
				}			
			} else {
				if(password != "") {
					if(!/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{9,16}$/.test(password)) {
						alert('패스워드를 확인해 주세요.');
						$("#userPassword").focus();	
					}
				}	
			}

		}
	},
	fnId:function() {
		var id = $("#userId").val();
		if(id != "") {
			if(id.length < 3) {
				alert('최소 3자 이상 입력해 주시기 바랍니다.');
				$("#userId").focus();
			}
			if(!/^[a-zA-Z0-9_]*$/.test(id)) {
				alert('ID 형식을 확인해 주시기 바랍니다.')
				$("#userId").focus();
			}
		}
	}
}

var ComFormValidCheck = function(myValidator){
	var result = myValidator.validate();
	if (!result) {
		var msg = myValidator.getErrorMessage("{message}");
		alert(msg);
		var focusObj = myValidator.getErrorElement();
		focusObj.focus();
		return false;
		
	}else{
		return true;
	}
};

function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }                
                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){                	
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {                	
                	document.getElementById("sample6_extraAddress").value = '';
                }
				
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('post').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addressDetail").focus();
            }
        }).open();
    }
</script>