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
    			<th>연락처</th>
    			<th>이메일</th>
    			<th>매칭</th>
    			<th>승인여부</th>
    			<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="kodaMemberList" items="${kodaMemberList}" varStatus="status">
				<tr style="background:${kodaMemberList.gubn == 'D'?'#9ede9e':''}">
					<td><input type="checkbox" name="checkId" value="${kodaMemberList.id}"/></td>
					<td>${(total_count - status.index) - ( (currentPage - 1)  *  displayNum ) }</td>		
					<td>${kodaMemberList.gubnNm}</td>
					<td><a href="#" onclick="page.fnMemberDetail('${kodaMemberList.id}');">${kodaMemberList.id}</a></td>
					<td>${kodaMemberList.name}</td>
					<td><input type="hidden" id="phone_"+${status.count}/>${kodaMemberList.phone}</td>
					<td>${kodaMemberList.email}</td>
					<td>매칭목록</td>
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