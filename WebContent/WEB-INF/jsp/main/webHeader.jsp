<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="ajax" uri="http://ajaxtags.sourceforge.net/tags/ajaxtags"%>

<%       
  int menuNum = 0;
%>

<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/jquery1.9/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/jquery1.9/jquery-ui-1.10.3.custom.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/jquery1.9/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/jquery1.9/jquery.blockUI.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/jquery1.9/ui/i18n/jquery.ui.datepicker-ko.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/home/script/jquery1.9/jQuery.MaskedInput.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/ui/jquery.easyui.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/common/wini_grid-1.5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/common/wini_default.1.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/common/wini_cal.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/common/wini_code.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/board.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/header.js"></script>

<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/home/script/axisj/dist/AXJ.min.js"></script> --%>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/home/script/axisj/lib/AXJ.js"></script> --%>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/home/script/axisj/lib/AXInput.js"></script> --%>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/home/script/axisj/lib/AXSelect.js"></script> --%>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/home/script/axisj/lib/AXGrid.js"></script> --%>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/home/script/axisj/lib/AXSearch.js"></script> --%>
 <script type="text/javascript"> 
 /* 상위 네비게이션바 수치 조절 8월 18일 서지숙  */
 	$(function(){ 	
 		var max_h=0;
 		var tmp_h=0;
 		for(var i =0; i<5;i++){
 			var h = $('.twoDep').eq(i).css("height");
 			if( h!=null){
 				tmp_h = Number(h.replace('px', ''));
 				if(tmp_h  > max_h){
 					max_h = tmp_h;
 				}
 			}   
 		}
 		
 		max_h = max_h + 100;
 		
 		for( var i=0; i <2 ; i++){
 			var h = $('.count').eq(i).css("height");
			$('.count').eq(i).slideUp(0);			
 		}
 		
	    /* 상위 네비게이션바 이벤트 등록*/
 		$('.top_menu').mouseenter(function(e){
 			$('.top_menu').stop().animate({height:max_h},330);
 			$('.gnbBg').stop().animate({height:max_h-45}, 330);
 			$('.gnbBg').css("border-bottom", "1px solid #0070bd");
 		}).focusin(function(){ //focus가 들어왔을떄 
 			$('.top_menu').mouseenter();
 		});
 		
 		$('.top_menu').mouseleave(function(e){
			$('.top_menu').stop().animate({height:45}, 330);
 			$('.gnbBg').stop().animate({height:0}, 330);
 			$('.gnbBg').css("border", "none");
 		}).focusout(function(){//focus가 다른곳으로 넘어갔을때
 			$('.top_menu').mouseleave();
 		});
 		
 		$('.gnbBg').mouseenter(function(e){
 			$('.top_menu').stop().animate({height:max_h},330);
 			$('.gnbBg').stop().animate({height:max_h-45}, 330);
 			$('.gnbBg').css("border-bottom", "1px solid #0070bd");
 		}).focusin(function(){ //focus가 들어왔을떄 
 			$('.top_menu').mouseenter();
 		});   
 		
 		$('.gnbBg').mouseleave(function(e){
		$('.top_menu').stop().animate({height:45}, 330);
			$('.gnbBg').stop().animate({height:0}, 330);
			$('.gnbBg').css("border", "none");
		}).focusout(function(){//focus가 다른곳으로 넘어갔을때
			$('.top_menu').mouseleave(); 
		});
	
 	});
 	 /* 상위 네비게이션바 수치 조절 끝 8월 18일 서지숙  */
 	</script>

    <c:if test="${loginVO == null }">
        <script type="text/javascript">
             location.href = "${pageContext.request.contextPath}/";
        </script>
    </c:if>
    <!-- 헤더 메뉴 위치 변경 8월 24일 김수지 -->
    <div id="header1" style="width:100%; margin:0 auto;">
<%--     <div data-options="region:'north',border:false" style="height:<c:if test="${parmMap.cssType == 'sub' }">60px</c:if><c:if test="${parmMap.cssType == 'main' }">70px</c:if>; background:url(${pageContext.request.contextPath}/home/images/header_bg.gif) repeat-x;"> --%>
        <div id="<c:if test="${parmMap.cssType == 'sub' || parmMap.cssType == null}">sub_</c:if>header">
            <h1><a href="${pageContext.request.contextPath}/" id="logo"><img src="${pageContext.request.contextPath}/home/images/winiweb.JPG"  alt="로고" style="margin-top: 8px;" width="104" height="26" /></a></h1>
            <div id="userlog"><span><b>${loginVO.userName}</b>님이 로그인했습니다.</span> 
                <a href="${pageContext.request.contextPath}/logout.do" class="btn_rwhite b_h25">로그아웃</a>
                <a href="javascript:void(0)" onclick="changeInfo();" class="btn_rwhite b_h25">비번변경</a> 
            </div>            
        </div>
           <div id="top_panel">
            <div id="gnb_menu">
              <ul class="top_menu" id="top_menu">
                    <c:forEach var="menuVO" items="${menuList}" varStatus="status">
                    <c:if test="${menuVO.menuStep == '2' }"><!-- 2단계 메뉴  -->
                        <% menuNum++; %>
                        <li class="menu<%=menuNum%>">
                            <a class="oneDep" href="${pageContext.request.contextPath}/goMenu.do?um=<c:out value="${menuVO.menuId}"/>" ><c:out value="${menuVO.menuName}"/></a>
                         <div class="twoDep"> 
                            <!-- 상위메뉴에 해당되는 하단메뉴 구성 추가 8월 18일 서지숙  -->
                            <c:forEach var="menuSubVO" items="${menuList}" varStatus="status2"> 
                               <c:if test="${menuSubVO.menuStep == '3' && menuSubVO.upmenuId == menuVO.menuId}"> <!-- 3단계 메뉴  -->                      
                                    
                                    <c:choose>
                                        <%--  <c:when test="${menuSubVO.menuClsCd == '47100010'}"> 
                                            게시판 인경우 
                                            <a class="off" href="/<c:out value="${homeInfo.hmpgDrctryPath}"/>/goMenu.do?menuId=<c:out value="${menuSubVO.menuId}"/>&amp;bbsId=<c:out value="${menuSubVO.bbsId}"/>" <c:if test="${menuSubVO.popupYn == 'Y' }"> target="_blank" </c:if>><c:out value="${menuSubVO.menuName}"/></a> 
                                        </c:when>   --%>
                                         <c:when test="${menuSubVO.menuClsCd == '47100027'}">                     
<%--                                             <a class="off" href="/<c:out value="${homeInfo.hmpgDrctryPath}"/>/goMenu.do?menuId=<c:out value="${menuSubVO.menuId}"/>" <c:if test="${menuSubVO.popupYn == 'Y' }"> target="_blank" </c:if>><c:out value="${menuSubVO.menuName}"/></a> --%>
                                            <a class="off" href="/${subUrl}/goMenu.do?menuId=<c:out value="${menuSubVO.menuId}"/>" <c:if test="${menuSubVO.popupYn == 'Y' }"> target="_blank" </c:if>><c:out value="${menuSubVO.menuName}"/></a>
                                        </c:when> 
                                        
                                        <%-- <c:when test="${menuSubVO.menuClsCd == '47100028'}"> 
                                            컨텐츠 경우 
                                            <a class="off" href="/<c:out value="${homeInfo.hmpgDrctryPath}"/>/goMenu.do?menuId=<c:out value="${menuSubVO.menuId}"/>&amp;cntntsSn=<c:out value="${menuSubVO.cntntsSn}"/>" <c:if test="${menuSubVO.popupYn == 'Y' }"> target="_blank" </c:if>><c:out value="${menuSubVO.menuName}"/></a>
                                        </c:when>
                                        <c:when test="${menuSubVO.menuClsCd == '47100036'}"> 
                                            타사이트 링크인 경우  
                                            <a class="off" href="<c:out value="${menuSubVO.progrmUrl}"/>" <c:if test="${menuSubVO.popupYn == 'Y' }"> target="_blank" title="${menuSubVO.menuName}(새창)" </c:if>><c:out value="${menuSubVO.menuName}"/><c:if test="${menuSubVO.popupYn == 'Y' }"> <img src="/gb119www/home/www/images/icon_newwindow.gif" alt=""  /> </c:if></a>                                    
                                        </c:when> --%>
                                    </c:choose>
                               </c:if>
                                </c:forEach>  
                                <!-- 게시판 메뉴 시작 추가 8월 19일 서지숙 -->  
                                    <c:if test="${menuVO.menuId eq 'WEB_002'}" >  
                                        <p class="pnone">==정보공유 게시판==</p>
                                       <c:forEach var="bbscttVO" items="${boardMenuList}" varStatus="status">    
                                            <c:if test="${bbscttVO.wardId eq 'info' }" >
                                                    <a href="javascript:void(0);" class="inoff" onclick="go_boardListPage('', '${bbscttVO.bbsId}', '')"> · <c:out value="${bbscttVO.bbsName}"/></a>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${menuVO.menuId eq 'WEB_003'}" >
                                        <p class="pnone">==커뮤니티 게시판==</p>
                                       <c:forEach var="bbscttVO" items="${boardMenuList}" varStatus="status">
                                            <c:if test="${bbscttVO.wardId eq 'cumm' }" >
                                                    <a href="javascript:void(0);" class="inoff" onclick="go_boardListPage('', '${bbscttVO.bbsId}', '')"> · <c:out value="${bbscttVO.bbsName}"/></a>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${menuVO.menuId eq 'WEB_005'}" >
                                        <p class="pnone">==개인과제 게시판==</p>
                                       <c:forEach var="bbscttVO" items="${boardMenuList}" varStatus="status"> 
                                            <c:if test="${bbscttVO.wardId eq 'stu'}" >
                                                    <a href="javascript:void(0);" class="inoff" onclick="go_boardListPage('', '${bbscttVO.bbsId}', '')"> · <c:out value="${bbscttVO.bbsName}"/></a>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                     <!-- 게시판 메뉴 끝 -->
                              </div> 
                            </li>
                                  
                            
                        </c:if>
                           
                    </c:forEach>    
              </ul>
            </div>     
              <p class="gnbBg" style="height: 0px; border: none; overflow: hidden; width:100%;">&nbsp;</p>           
        </div>
    </div>      
      