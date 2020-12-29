<%@ page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="ajax" uri="http://ajaxtags.sourceforge.net/tags/ajaxtags"%>
<%@taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="table-scrollable">
	<table class="table table-hover">
		<thead>
			<tr>
				<th><input type="checkbox" name="allCheck" id="allCheck" value="all"/></th>
				<th>No</th>
    			<th>구분</th>			                      
    			<th>아이디</th>					                      					                      					                      				                      					                      
    			<th>이름</th>
    			<th colspan="2">연락처</th>
    			<th>이메일</th>
    			<th colspan="2">매칭</th>
    			<th>승인여부</th>
    			<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="kodaMemberList" items="${kodaMemberList}" varStatus="status">
				<input type="hidden" name="gubn" id="gubn_${status.index }" value="${kodaMemberList.gubn }"/>
				<input type="hidden" name="id" id="id_${status.index }" value="${kodaMemberList.id }"/>
				<input type="hidden" name="matchDonorName" id="matchDonorName_${status.index }" value="${kodaMemberList.matchDonorName }"/>
				<input type="hidden" name="matchDonorHospitalIdx" id="matchDonorHospitalIdx_${status.index }" value="${kodaMemberList.matchDonorHospitalIdx }"/>
				<input type="hidden" name="matchDonorHospitalName" id="matchDonorHospitalName_${status.index }" value="${kodaMemberList.matchDonorHospitalName }"/>
				<input type="hidden" name="matchDonorBirth" id="matchDonorBirth_${status.index }" value="${kodaMemberList.matchDonorBirth }"/>
				<input type="hidden" name="matchDonorDate" id="matchDonorDate_${status.index }" value="${kodaMemberList.matchDonorDate }"/>
				<input type="hidden" name="dlCnt" id="dlCnt_${status.index }" value="${kodaMemberList.dlCnt }"/>
				<input type="hidden" name="benefiNames" id="benefiNames_${status.index }" value="${kodaMemberList.benefiNames }"/>
				<input type="hidden" name="benefiBirths" id="benefiBirths_${status.index }" value="${kodaMemberList.benefiBirths }"/>
				<input type="hidden" name="benefiHospitalIdxs" id="benefiHospitalIdxs_${status.index }" value="${kodaMemberList.benefiHospitalIdxs }"/>
				<input type="hidden" name="benefiHospitalNames" id="benefiHospitalNames_${status.index }" value="${kodaMemberList.benefiHospitalNames }"/>
				<input type="hidden" name="benefiPartsIdxs" id="benefiPartsIdxs_${status.index }" value="${kodaMemberList.benefiPartsIdxs }"/>
				<input type="hidden" name="benefiPartsNames" id="benefiPartsNames_${status.index }" value="${kodaMemberList.benefiPartsNames }"/>
				<input type="hidden" name="blCnt" id="blCnt_${status.index }" value="${kodaMemberList.blCnt }"/>
				<tr style="background:${kodaMemberList.gubn == 'D'?'#9ede9e':''}">
					<td><input type="checkbox" name="checkId" value="${kodaMemberList.id}"/></td>
					<td>${(total_count - status.index) - ( (currentPage - 1)  *  displayNum ) }</td>		
					<td>${kodaMemberList.gubnNm}</td>
					<td><a href="#" onclick="page.fnMemberDetail('${kodaMemberList.id}');">${kodaMemberList.id}</a></td>
					<td>${kodaMemberList.name}</td>
					<td><input type="hidden" id="phone_${status.count}"/>${kodaMemberList.phone}</td>
					<td><input type="button" onclick="fnSms.fnShowSmsModal('', '${kodaMemberList.phone}');" value="SMS" class="btn blue"></td>
					<td>${kodaMemberList.email}</td>
					<td>${kodaMemberList.matchNameList }</td>
					<td><input type="button" onclick="fnPop.fnMatchingPop('${status.index}');" value="매칭검색" class="btn blue"></td>
					<td>
						<select name="apprFlag" id="apprFlag_${status.count}" style="width:200px;">
							<option value="Y" ${kodaMemberList.apprFlag=='Y'?'selected':''}>승인</option>
							<option value="N" ${kodaMemberList.apprFlag=='N'?'selected':''}>미승인</option>
						</select>
					</td>
					<td>
						<a href="#" onclick="page.fnMemberUpdate('${kodaMemberList.id}', 'U')">[수정]</a>
						<a href="#" onclick="page.fnMemberUpdate('${kodaMemberList.id}', 'D')">[탈퇴]</a>
					</td>
				</tr>
			</c:forEach>    
			
		</tbody>
	</table>
	<input type="hidden" name="page" id="page" value="${param.page}"/>
</div>
<!-- END SAMPLE TABLE PORTLET-->
<nav aria-label="Page navigation" style="margin-top: 50px; text-align: center;">
	<ul class="pagination my_pagetion">
		<c:if test="${not empty paginationInfo}"> 
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="page.fnInit"/>
		</c:if>
	</ul>
</nav> 