<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="ajax" uri="http://ajaxtags.sourceforge.net/tags/ajaxtags"%>
<!-- <style>
	.nav-item{
		float: left;						
	}		
</style> -->
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-fixed-top">
<!-- BEGIN HEADER INNER -->
<div class="page-header-inner ">
<!-- BEGIN LOGO -->
<div class="page-logo">
    <h4 onclick="window.location.href='/statistics/dashboard.do'" style="cursor:pointer;">한국장기조직기증원 관리자페이지</h4>
</div>
<!-- END LOGO -->
<!-- BEGIN RESPONSIVE MENU TOGGLER -->
<a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse">
<span></span>
</a>
<!-- END RESPONSIVE MENU TOGGLER -->
<!-- BEGIN TOP NAVIGATION MENU -->
<div class="top-menu">
<ul class="nav navbar-nav pull-right">
<!-- BEGIN NOTIFICATION DROPDOWN -->
<!-- DOC: Apply "dropdown-dark" class after "dropdown-extended" to change the dropdown styte -->
<!-- DOC: Apply "dropdown-hoverable" class after below "dropdown" and remove data-toggle="dropdown" data-hover="dropdown" data-close-others="true" attributes to enable hover dropdown mode -->
<!-- DOC: Remove "dropdown-hoverable" and add data-toggle="dropdown" data-hover="dropdown" data-close-others="true" attributes to the below A element with dropdown-toggle class -->
<!-- BEGIN USER LOGIN DROPDOWN -->
<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
	    <li class="dropdown dropdown-user">
        <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
            <!-- <img alt="" class="img-circle" src="../assets/layouts/layout/img/avatar3_small.jpg" /> -->
            <span class="username username-hide-on-mobile"> ${adminInfo.admin_nick_name} </span>
            <i class="fa fa-angle-down"></i>
        </a>
        <ul class="dropdown-menu dropdown-menu-default">
            <li>
                <a href="<c:url value='/admin/adminEdit.do'/>">
                    <i class="icon-user"></i> 나의 정보 </a>
            </li>
            <!-- <li>
                <a href="app_calendar.html">
                    <i class="icon-calendar"></i> My Calendar </a>
            </li>
            <li>
                <a href="app_inbox.html">
                    <i class="icon-envelope-open"></i> My Inbox
                    <span class="badge badge-danger"> 3 </span>
                </a>
            </li>
            <li>
                <a href="app_todo.html">
                    <i class="icon-rocket"></i> My Tasks
                    <span class="badge badge-success"> 7 </span>
                </a>
            </li>
            <li class="divider"> </li> -->
            <li>
                <a href="<c:url value='/admin/adminChgPwd.do'/>">
                    <i class="icon-lock"></i> 비밀번호 변경 </a>
            </li>
            <!-- <li>
                <a href="">
                    <i class="icon-key"></i> Log Out </a>
            </li> -->
        </ul>
    </li>
<!-- END USER LOGIN DROPDOWN -->
<!-- BEGIN QUICK SIDEBAR TOGGLER -->
<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
    <li class="dropdown dropdown-quick-sidebar-toggler">
        <a href="<c:url value='/actionLogout.do'/>" class="dropdown-toggle">
            <i class="icon-logout"></i>
        </a>
    </li>
<!-- END QUICK SIDEBAR TOGGLER -->
</ul>
</div>
<!-- END TOP NAVIGATION MENU -->
</div>
<!-- END HEADER INNER -->
</div>
<!-- END HEADER -->
<!-- BEGIN HEADER & CONTENT DIVIDER -->
<div class="clearfix"> </div>
<!-- END HEADER & CONTENT DIVIDER -->
<!-- BEGIN CONTAINER -->
<div class="page-container">
<!-- BEGIN SIDEBAR -->
<div class="page-sidebar-wrapper">
 
<!-- BEGIN SIDEBAR -->
<!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
<!-- DOC: Change data-auto-speed="200" to adjust the sub menu slide up/down speed -->
<div class="page-sidebar navbar-collapse collapse">
<!-- BEGIN SIDEBAR MENU -->
<!-- DOC: Apply "page-sidebar-menu-light" class right after "page-sidebar-menu" to enable light sidebar menu style(without borders) -->
<!-- DOC: Apply "page-sidebar-menu-hover-submenu" class right after "page-sidebar-menu" to enable hoverable(hover vs accordion) sub menu mode -->
<!-- DOC: Apply "page-sidebar-menu-closed" class right after "page-sidebar-menu" to collapse("page-sidebar-closed" class must be applied to the body element) the sidebar sub menu mode -->
<!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
<!-- DOC: Set data-keep-expand="true" to keep the submenues expanded -->
<!-- DOC: Set data-auto-speed="200" to adjust the sub menu slide up/down speed -->
<ul class="page-sidebar-menu page-header-fixed " data-keep-expanded="false" data-slide-speed="200" style="padding-top: 20px">
<!-- DOC: To remove the sidebar toggler from the sidebar you just need to completely remove the below "sidebar-toggler-wrapper" LI element -->
<!-- BEGIN SIDEBAR TOGGLER BUTTON -->
    <li class="sidebar-toggler-wrapper hide">
        <div class="sidebar-toggler">
            <span></span>
        </div>
    </li>
<!-- END SIDEBAR TOGGLER BUTTON -->		
	
	<li class="nav-item ">
		<c:set var="doneLoop1" value="false"/>		
	    <c:forEach items="${webMenuList}" var="webMenuList">
	    	<c:if test="${not doneLoop1}">
		    	<c:choose>
		    		<c:when test="${webMenuList.menu_cd eq 1}">
		    			<a href="javascript:;" class="nav-link nav-toggle"> 
					        <i class="glyphicon glyphicon-plus"></i>
					        <span class="title">기본설정</span>
					        <span class="arrow"></span>
					    </a>
					    <c:set var="doneLoop1" value="true"/>
		    		</c:when>
		    		<c:otherwise>
		    			
		    		</c:otherwise>
		    	</c:choose>
	    	</c:if>
	    </c:forEach>
	    <ul class="sub-menu">
	    	<c:forEach items="${webMenuList}" var="webMenuList">
	    		<c:if test="${webMenuList.menu_cd eq 1 and webMenuList.seq_cd ne 6 and webMenuList.seq_cd ne 5}">
			        <li class="nav-item1" id="nav-item1">
			            <a href="<c:url value='${webMenuList.menu_url}'/>" class="nav-link ">	                			                	
			                <span class="title">${webMenuList.menu_nm}</span>		                		                	                
			            </a>
			        </li>
	        	</c:if>
	        </c:forEach>
	    </ul>
	</li>
	
	<li class="nav-item ">	    
	    <c:set var="doneLoop2" value="false"/>		
	    <c:forEach items="${webMenuList}" var="webMenuList">
	    	<c:if test="${not doneLoop2}">
		    	<c:choose>
		    		<c:when test="${webMenuList.menu_cd eq 2}">
		    			<a href="javascript:;" class="nav-link nav-toggle" id="nav-toggle"> 
					        <i class="icon-user"></i>
					        <span class="title">기증희망등록</span>
					        <span class="arrow"></span>
					    </a>
					    <c:set var="doneLoop2" value="true"/>
		    		</c:when>
		    		<c:otherwise>
		    			
		    		</c:otherwise>
		    	</c:choose>
	    	</c:if>
	    </c:forEach>
	    <ul class="sub-menu">
	    	<c:forEach items="${webMenuList}" var="webMenuList">
	    		<c:if test="${webMenuList.menu_cd eq 2}">
			        <li class="nav-item2">
			            <a href="<c:url value='${webMenuList.menu_url}'/>" class="nav-link ">	                			                	
			                <span class="title">${webMenuList.menu_nm}</span>		                		                	                
			            </a>
			        </li>
	        	</c:if>
	        </c:forEach>
	    </ul>
	</li>
	
	<li class="nav-item ">	    
	   	<c:set var="doneLoop3" value="false"/>		
	    <c:forEach items="${webMenuList}" var="webMenuList">
	    	<c:if test="${not doneLoop3}">
		    	<c:choose>
		    		<c:when test="${webMenuList.menu_cd eq 3}">
		    			<a href="javascript:;" class="nav-link nav-toggle" id="nav-toggle"> 
					        <i class="glyphicon glyphicon-zoom-in"></i>
					        <span class="title">국민소통 게시판</span>
					        <span class="arrow"></span>
					    </a>
					    <c:set var="doneLoop3" value="true"/>
		    		</c:when>
		    		<c:otherwise>
		    			
		    		</c:otherwise>
		    	</c:choose>
	    	</c:if>
	    </c:forEach>
	    <ul class="sub-menu">
	    	<c:forEach items="${webMenuList}" var="webMenuList">
	    		<c:if test="${webMenuList.menu_cd eq 3}">
			        <li class="nav-item3">
			            <a href="<c:url value='${webMenuList.menu_url}'/>" class="nav-link ">	                			                	
			                <span class="title">${webMenuList.menu_nm}</span>		                		                	                
			            </a>
			        </li>
	        	</c:if>
	        </c:forEach>
	    </ul>
	</li>
	
	<li class="nav-item ">	    
	    <c:set var="doneLoop4" value="false"/>		
	    <c:forEach items="${webMenuList}" var="webMenuList">
	    	<c:if test="${not doneLoop4}">
		    	<c:choose>
		    		<c:when test="${webMenuList.menu_cd eq 4}">
		    			<a href="javascript:;" class="nav-link nav-toggle" id="nav-toggle"> 
					        <i class="glyphicon glyphicon-file"></i>
					        <span class="title">정보공개 게시판</span>
					        <span class="arrow"></span>
					    </a>
					    <c:set var="doneLoop4" value="true"/>
		    		</c:when>
		    		<c:otherwise>
		    			
		    		</c:otherwise>
		    	</c:choose>
	    	</c:if>
	    </c:forEach>
	    <ul class="sub-menu">
	    	<c:forEach items="${webMenuList}" var="webMenuList">
	    		<c:if test="${webMenuList.menu_cd eq 4}">
			        <li class="nav-item4">
			            <a href="<c:url value='${webMenuList.menu_url}'/>" class="nav-link ">	                			                	
			                <span class="title">${webMenuList.menu_nm}</span>		                		                	                
			            </a>
			        </li>
	        	</c:if>
	        </c:forEach>
	    </ul>
	</li>
	
	<li class="nav-item ">
	    <c:set var="doneLoop6" value="false"/>		
	    <c:forEach items="${webMenuList}" var="webMenuList">
	    	<c:if test="${not doneLoop6}">
		    	<c:choose>
		    		<c:when test="${webMenuList.menu_cd eq 6}">
    				    <a href="javascript:;" class="nav-link nav-toggle" id="nav-toggle"> 
					        <i class="glyphicon glyphicon-list-alt"></i>
					        <span class="title">관리자</span>
					        <span class="arrow"></span>
					    </a>
					    <c:set var="doneLoop6" value="true"/>
		    		</c:when>
		    		<c:otherwise>
		    			
		    		</c:otherwise>
		    	</c:choose>
	    	</c:if>
	    </c:forEach>
	    <ul class="sub-menu">
	    	<c:forEach items="${webMenuList}" var="webMenuList">
	    		<c:if test="${webMenuList.menu_cd eq 6}">
			        <li class="nav-item6">
			            <a href="<c:url value='${webMenuList.menu_url}'/>" class="nav-link ">	                			                	
			                <span class="title">${webMenuList.menu_nm}</span>		                		                	                
			            </a>
			        </li>
	        	</c:if>
	        </c:forEach>
	    </ul>
	</li>
	
	<li class="nav-item ">	    
	    <c:set var="doneLoop7" value="false"/>		
	    <c:forEach items="${webMenuList}" var="webMenuList">
	    	<c:if test="${not doneLoop7}">
		    	<c:choose>
		    		<c:when test="${webMenuList.menu_cd eq 7}">
    				    <a href="javascript:;" class="nav-link nav-toggle" id="nav-toggle"> 
					        <i class="glyphicon glyphicon-share"></i>
					        <span class="title">생명나눔 우체통</span>
					        <span class="arrow"></span>
					    </a>
					    <c:set var="doneLoop7" value="true"/>
		    		</c:when>
		    		<c:otherwise>
		    			
		    		</c:otherwise>
		    	</c:choose>
	    	</c:if>
	    </c:forEach>
	    <ul class="sub-menu">
	    	<c:forEach items="${webMenuList}" var="webMenuList">
	    		<c:if test="${webMenuList.menu_cd eq 7}">
			        <li class="nav-item7">
			            <a href="<c:url value='${webMenuList.menu_url}'/>" class="nav-link ">	                			                	
			                <span class="title">${webMenuList.menu_nm}</span>		                		                	                
			            </a>
			        </li>
	        	</c:if>
	        </c:forEach>
	    </ul>
	</li>
	
	<li class="nav-item ">	    
	    <c:set var="doneLoop8" value="false"/>		
	    <c:forEach items="${webMenuList}" var="webMenuList">
	    	<c:if test="${not doneLoop8}">
		    	<c:choose>
		    		<c:when test="${webMenuList.menu_cd eq 8}">
    				    <a href="javascript:;" class="nav-link nav-toggle" id="nav-toggle"> 
					        <i class="glyphicon glyphicon-stats"></i>
					        <span class="title">통계메뉴</span>
					        <span class="arrow"></span>
					    </a>
					    <c:set var="doneLoop8" value="true"/>
		    		</c:when>
		    		<c:otherwise>
		    			
		    		</c:otherwise>
		    	</c:choose>
	    	</c:if>
	    </c:forEach>
	    <ul class="sub-menu">
	    	<c:forEach items="${webMenuList}" var="webMenuList">
	    		<c:if test="${webMenuList.menu_cd eq 8}">
			        <li class="nav-item8">
			            <a href="<c:url value='${webMenuList.menu_url}'/>" class="nav-link ">	                			                	
			                <span class="title">${webMenuList.menu_nm}</span>		                		                	                
			            </a>
			        </li>
	        	</c:if>
	        </c:forEach>
	    </ul>
	</li>
	
	<li class="nav-item ">	    
	    <c:set var="doneLoop9" value="false"/>		
	    <c:forEach items="${webMenuList}" var="webMenuList">
	    	<c:if test="${not doneLoop9}">
		    	<c:choose>
		    		<c:when test="${webMenuList.menu_cd eq 9}">
    				    <a href="javascript:;" class="nav-link nav-toggle" id="nav-toggle"> 
					        <i class="glyphicon glyphicon-gift"></i>
					        <span class="title">병원관리</span>
					        <span class="arrow"></span>
					    </a>
					    <c:set var="doneLoop9" value="true"/>
		    		</c:when>
		    		<c:otherwise>
		    			
		    		</c:otherwise>
		    	</c:choose>
	    	</c:if>
	    </c:forEach>
	    <ul class="sub-menu">
	    	<c:forEach items="${webMenuList}" var="webMenuList">
	    		<c:if test="${webMenuList.menu_cd eq 9 and webMenuList.seq_cd ne 5}">
			        <li class="nav-item9">
			            <a href="<c:url value='${webMenuList.menu_url}'/>" class="nav-link ">	                			                	
			                <span class="title">${webMenuList.menu_nm}</span>		                		                	                
			            </a>
			        </li>
	        	</c:if>
	        </c:forEach>
	    </ul>
	</li>
	
	<li class="nav-item ">	    
	    <c:set var="doneLoop10" value="false"/>		
	    <c:forEach items="${webMenuList}" var="webMenuList">
	    	<c:if test="${not doneLoop10}">
		    	<c:choose>
		    		<c:when test="${webMenuList.menu_cd eq 10}">
    				    <a href="javascript:;" class="nav-link nav-toggle" id="nav-toggle"> 
					        <i class="glyphicon glyphicon-star"></i>
					        <span class="title">추모공간</span>
					        <span class="arrow"></span>
					    </a>
					    <c:set var="doneLoop10" value="true"/>
		    		</c:when>
		    		<c:otherwise>
		    			
		    		</c:otherwise>
		    	</c:choose>
	    	</c:if>
	    </c:forEach>
	    <ul class="sub-menu">
	    	<c:forEach items="${webMenuList}" var="webMenuList">
	    		<c:if test="${webMenuList.menu_cd eq 10}">
			        <li class="nav-item10">
			            <a href="<c:url value='${webMenuList.menu_url}'/>" class="nav-link ">	                			                	
			                <span class="title">${webMenuList.menu_nm}</span>		                		                	                
			            </a>
			        </li>
	        	</c:if>
	        </c:forEach>
	    </ul>
	</li>
	
	<!-- 문자발송 테스트 -->
</ul>
<!-- END SIDEBAR MENU -->
<!-- END SIDEBAR MENU -->
</div>
<!-- END SIDEBAR -->
</div>
<!-- END SIDEBAR -->