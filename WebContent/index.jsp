<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ include file= "./include/adminip_chk.jsp" %> --%>
<%
	String userIp = request.getRemoteAddr();
	boolean isAllow = false;
	String allowIps[] = new String[] {
		"222.110.3.114","125.187.137.210","124.54.142.24","175.193.254.45", "0:0:0:0:0:0:0:1", "127.0.0.1"
	}; //181018 홈페이지 수정 개발자 IP 추가 

	for(int i=0; i < allowIps.length; i++) {

		if(userIp.indexOf(allowIps[i]) != -1) {

			isAllow = true;
			break;
		 }
	}
	isAllow = true;
	if(!isAllow) {

%>

<script language="javascript">
	alert("접근이 제한되어있습니다.<%=userIp%>");
	window.open('about:blank','_self').self.close();
</script>

<%  	
	} else {
		response.sendRedirect("login.do");	 
 	}
%>