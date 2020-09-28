<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="ajax" uri="http://ajaxtags.sourceforge.net/tags/ajaxtags"%>

<%      
  int menuNum = 0; 
%>

<div data-options="region:'west',border:false" style="width:210px;background: url(${pageContext.request.contextPath}/home/images/container_bg.gif) repeat-y #fff;">
    <div class="snb">
      <h2><c:out value="${upmenuInfo.menuName}"/></h2>
      <ul class="dep02">
       <%--  <li><a href="javascript:void(0);" onclick="gfn_openMenu('${pageContext.request.contextPath}/sample/sampleList.do',this)">샘플리스트(미완성)</a></li>
        <li><a href="javascript:void(0);" onclick="gfn_openMenu('${pageContext.request.contextPath}/sample/sampleCom.do',this)">공통컴포턴트예시</a></li>
        <li><a href="javascript:void(0);" onclick="gfn_openMenu('${pageContext.request.contextPath}/sample/sampleList2.do',this)">샘플2(CRUD)</a></li>
        <li><a href="javascript:void(0);" onclick="gfn_openMenu('${pageContext.request.contextPath}/sample/sampleList3.do',this)">샘플리스트3(AXGrid)</a></li>
        <li><a href="javascript:void(0);" onclick="gfn_openMenu('${pageContext.request.contextPath}/sample/sampleList_edu2.do',this)">샘플-edu2</a></li>
        <li><a href="javascript:void(0);" onclick="gfn_openMenu('${pageContext.request.contextPath}/sample/ManageList.do',this)">부동산관리1</a></li>
        <li><a href="javascript:void(0);" onclick="gfn_openMenu('${pageContext.request.contextPath}/sample/sample_board.do',this)">샘플게시판-민섭</a></li>
        <li><a href="javascript:void(0);" onclick="gfn_openMenu('${pageContext.request.contextPath}/sample/sample_board2.do',this)">이성훈-1</a></li> --%>
      <c:choose>
        <c:when test="${upmenuInfo.menuId == 'WEB_002' }">
            <%-- 정보공유 인경우  --%>
<%--                 <li><a href="${pageContext.request.contextPath}/info/infoMain.do" <c:if test="${parmMap.bbsId == null && menuAuthMap.menuId == null}"> class="on" </c:if>>최근게시글</a></li> --%>
                
                <% menuNum = 0; %>    
                <c:forEach var="menuVO" items="${menuList}" varStatus="status">
                   <c:if test="${menuVO.progrmUrl != null }">
                        <c:if test="${menuVO.menuStep == '3'}">
                            <% menuNum++; 
                               if (menuNum == 1) {
                                   out.println("<ul class=\"dep03\">");
                               }
                             %>
                        </c:if>
                        <li><a href="${pageContext.request.contextPath}<c:out value="${menuVO.progrmUrl}"/>" <c:if test="${parmMap.bbsId == null && menuAuthMap.menuId == menuVO.menuId}"> class="on" </c:if> ><c:out value="${menuVO.menuName}"/></a></li>
                    </c:if>
                    <c:if test="${menuVO.progrmUrl == null }">
    <%--                     <li><c:out value="${menuVO.menuName}"/>/<c:out value="${menuVO.menuStep}"/></li> --%>
                    </c:if>
                </c:forEach>
                <% 
                   if (menuNum > 0) {
                       out.println("</ul>");
                   }
                %>
                
                <li><a href="javascript:void(0);" <c:if test="${parmMap.bbsId != null && brdMstrVO.wardId == 'info'}"> class="on" </c:if>>정보공유 게시판</a></li>
                <ul class="dep03">
                <c:forEach var="menuVO" items="${boardMenuList}" varStatus="status">
                    <c:choose>
                        <c:when test="${menuVO.privWardInputYn == 'Y' && loginVO.sysmgrYn == 'Y'}">  <%-- // 부서별게시판인경우 --%>
                         <li class="plus m_${menuVO.bbsId}"><a href="javascript:void(0);" <c:if test="${parmMap.bbsId == menuVO.bbsId }"> class="on" </c:if> onclick="fn_showDownMenu('m_${menuVO.bbsId}');"><c:out value="${menuVO.bbsName}"/></a></li>
                         <ul class="dep04" <c:if test="${parmMap.bbsId == menuVO.bbsId}"> style="display:" </c:if> <c:if test="${parmMap.bbsId != menuVO.bbsId}"> style="display:none" </c:if>>
                            <c:forEach var="wardList" items="${boardWardList}" varStatus="status">
                            <li class="sub"><a href="javascript:void(0);" <c:if test="${parmMap.bbsId == menuVO.bbsId && wardList.wardId ==  bbsParm_ward_id}"> class="on" </c:if> onclick="go_boardListPage('${wardList.wardId}', '<c:out value="${menuVO.bbsId}"/>', '')"><c:out value="${wardList.wardName}"/></a></li>
                            </c:forEach>
                          </ul>
                        </c:when>
                        <c:when test="${menuVO.bbscttClsUseYn == 'Y'}">  <%-- // 분류사용 게시판인경우 --%>
                         <li class="plus m_${menuVO.bbsId}"><a href="javascript:void(0);" <c:if test="${parmMap.bbsId == menuVO.bbsId }"> class="on" </c:if> onclick="fn_showDownMenu('m_${menuVO.bbsId}');"><c:out value="${menuVO.bbsName}"/></a></li>
                         <ul class="dep04" <c:if test="${parmMap.bbsId == menuVO.bbsId}"> style="display:" </c:if> <c:if test="${parmMap.bbsId != menuVO.bbsId}"> style="display:none" </c:if>>
                            <c:forEach var="clsList" items="${boardClsList}" varStatus="status">
                                <c:if test="${clsList.bbsId == menuVO.bbsId }">
                                <li class="sub"><a href="javascript:void(0);" <c:if test="${parmMap.bbsId == menuVO.bbsId && clsList.bbscttClsSn ==  parmMap.sl}"> class="on" </c:if> onclick="go_boardListPage('${wardList.wardId}', '<c:out value="${menuVO.bbsId}"/>', '${clsList.bbscttClsSn}')"><c:out value="${clsList.bbscttClsName}"/></a></li>
                                </c:if>
                            </c:forEach>
                          </ul>
                        </c:when>
                        <c:otherwise> <%-- // 부서별게시판 또는 분류가 없는 일반게시판인경우 --%>
                        <li><a href="javascript:void(0);" <c:if test="${parmMap.bbsId == menuVO.bbsId }"> class="on" </c:if> onclick="go_boardListPage('', '<c:out value="${menuVO.bbsId}"/>', '')"><c:out value="${menuVO.bbsName}"/></a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>    
                
                </ul>    
                
        </c:when>
        
        <c:when test="${upmenuInfo.menuId == 'WEB_003' }">
            <%-- 커뮤니티 인경우  --%>
<%--                 <li><a href="${pageContext.request.contextPath}/cumm/cummMain.do" <c:if test="${parmMap.bbsId == null && menuAuthMap.menuId == null}"> class="on" </c:if>>최근게시글</a></li> --%>
                
                <% menuNum = 0; %>    
                <c:forEach var="menuVO" items="${menuList}" varStatus="status">
                   <c:if test="${menuVO.progrmUrl != null }">
                        <c:if test="${menuVO.menuStep == '3'}">
                            <% menuNum++; 
                               if (menuNum == 1) {
                                   out.println("<ul class=\"dep03\">");
                               }
                             %>
                        </c:if>
                        <li><a href="${pageContext.request.contextPath}<c:out value="${menuVO.progrmUrl}"/>" <c:if test="${parmMap.bbsId == null && menuAuthMap.menuId == menuVO.menuId}"> class="on" </c:if> ><c:out value="${menuVO.menuName}"/></a></li>
                    </c:if>
                    <c:if test="${menuVO.progrmUrl == null }">
    <%--                     <li><c:out value="${menuVO.menuName}"/>/<c:out value="${menuVO.menuStep}"/></li> --%>
                    </c:if>
                </c:forEach>
                <% 
                   if (menuNum > 0) {
                       out.println("</ul>");
                   }
                %>
                
                <li><a href="javascript:void(0);" <c:if test="${parmMap.bbsId != null && brdMstrVO.wardId == 'cumm' }"> class="on" </c:if>>커뮤니티 게시판</a></li>
                <ul class="dep03">
                <c:forEach var="menuVO" items="${boardMenuList}" varStatus="status">
                   <%-- <li><a href="javascript:void(0);" <c:if test="${parmMap.bbsId == menuVO.bbsId }"> class="on" </c:if> onclick="go_boardListPage('', '<c:out value="${menuVO.bbsId}"/>')"><c:out value="${menuVO.bbsName}"/></a></li> --%>
                   <c:choose>
                        <c:when test="${menuVO.privWardInputYn == 'Y' && loginVO.sysmgrYn == 'Y'}">  <%-- // 부서별게시판인경우 --%>
                         <li class="plus m_${menuVO.bbsId}"><a href="javascript:void(0);" <c:if test="${parmMap.bbsId == menuVO.bbsId }"> class="on" </c:if> onclick="fn_showDownMenu('m_${menuVO.bbsId}');"><c:out value="${menuVO.bbsName}"/></a></li>
                         <ul class="dep04" <c:if test="${parmMap.bbsId == menuVO.bbsId}"> style="display:" </c:if> <c:if test="${parmMap.bbsId != menuVO.bbsId}"> style="display:none" </c:if>>
                            <c:forEach var="wardList" items="${boardWardList}" varStatus="status">
                            <li class="sub"><a href="javascript:void(0);" <c:if test="${parmMap.bbsId == menuVO.bbsId && wardList.wardId ==  bbsParm_ward_id}"> class="on" </c:if> onclick="go_boardListPage('${wardList.wardId}', '<c:out value="${menuVO.bbsId}"/>', '')"><c:out value="${wardList.wardName}"/></a></li>
                            </c:forEach>
                          </ul>
                        </c:when>
                        <c:when test="${menuVO.bbscttClsUseYn == 'Y'}">  <%-- // 분류사용 게시판인경우 --%>
                         <li class="plus m_${menuVO.bbsId}"><a href="javascript:void(0);" <c:if test="${parmMap.bbsId == menuVO.bbsId }"> class="on" </c:if> onclick="fn_showDownMenu('m_${menuVO.bbsId}');"><c:out value="${menuVO.bbsName}"/></a></li>
                         <ul class="dep04" <c:if test="${parmMap.bbsId == menuVO.bbsId}"> style="display:" </c:if> <c:if test="${parmMap.bbsId != menuVO.bbsId}"> style="display:none" </c:if>>
                            <c:forEach var="clsList" items="${boardClsList}" varStatus="status">
                                <c:if test="${clsList.bbsId == menuVO.bbsId }">
                                <li class="sub"><a href="javascript:void(0);" <c:if test="${parmMap.bbsId == menuVO.bbsId && clsList.bbscttClsSn ==  parmMap.sl}"> class="on" </c:if> onclick="go_boardListPage('${wardList.wardId}', '<c:out value="${menuVO.bbsId}"/>', '${clsList.bbscttClsSn}')"><c:out value="${clsList.bbscttClsName}"/></a></li>
                                </c:if>
                            </c:forEach>
                          </ul>
                        </c:when>
                        <c:otherwise> <%-- // 부서별게시판 또는 분류가 없는 일반게시판인경우 --%>
                        <li><a href="javascript:void(0);" <c:if test="${parmMap.bbsId == menuVO.bbsId }"> class="on" </c:if> onclick="go_boardListPage('', '<c:out value="${menuVO.bbsId}"/>', '')"><c:out value="${menuVO.bbsName}"/></a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>    
                </ul>        
             
        </c:when>
        
        <c:when test="${upmenuInfo.menuId == 'WEB_005' }">
            <%-- 개인과제인경우  --%>
<%--                 <li><a href="${pageContext.request.contextPath}/stu/stuMain.do" <c:if test="${parmMap.bbsId == null && menuAuthMap.menuId == null}"> class="on" </c:if>>최근게시글</a></li> --%>
                
                <% menuNum = 0; %>    
                <c:forEach var="menuVO" items="${menuList}" varStatus="status">
                   <c:if test="${menuVO.progrmUrl != null }">
                        <c:if test="${menuVO.menuStep == '3'}">
                            <% menuNum++; 
                               if (menuNum == 1) {
                                   out.println("<ul class=\"dep03\">");
                               }
                             %>
                        </c:if>
                        <li><a href="${pageContext.request.contextPath}<c:out value="${menuVO.progrmUrl}"/>" <c:if test="${parmMap.bbsId == null && menuAuthMap.menuId == menuVO.menuId}"> class="on" </c:if> ><c:out value="${menuVO.menuName}"/></a></li>
                    </c:if>
                    <c:if test="${menuVO.progrmUrl == null }">
    <%--                     <li><c:out value="${menuVO.menuName}"/>/<c:out value="${menuVO.menuStep}"/></li> --%>
                    </c:if>
                </c:forEach>
                <% 
                   if (menuNum > 0) {
                       out.println("</ul>");
                   }
                %>
                
                <li><a href="javascript:void(0);" <c:if test="${parmMap.bbsId != null && brdMstrVO.wardId == 'stu' }"> class="on" </c:if>>개인과제</a></li>
                <ul class="dep03">
                <c:forEach var="menuVO" items="${boardMenuList}" varStatus="status">
                   <%-- <li><a href="javascript:void(0);" <c:if test="${parmMap.bbsId == menuVO.bbsId }"> class="on" </c:if> onclick="go_boardListPage('', '<c:out value="${menuVO.bbsId}"/>')"><c:out value="${menuVO.bbsName}"/></a></li> --%>
                   <c:choose>
                        <c:when test="${menuVO.privWardInputYn == 'Y' && loginVO.sysmgrYn == 'Y'}">  <%-- // 부서별게시판인경우 --%>
                         <li class="plus m_${menuVO.bbsId}"><a href="javascript:void(0);" <c:if test="${parmMap.bbsId == menuVO.bbsId }"> class="on" </c:if> onclick="fn_showDownMenu('m_${menuVO.bbsId}');"><c:out value="${menuVO.bbsName}"/></a></li>
                         <ul class="dep04" <c:if test="${parmMap.bbsId == menuVO.bbsId}"> style="display:" </c:if> <c:if test="${parmMap.bbsId != menuVO.bbsId}"> style="display:none" </c:if>>
                            <c:forEach var="wardList" items="${boardWardList}" varStatus="status">
                            <li class="sub"><a href="javascript:void(0);" <c:if test="${parmMap.bbsId == menuVO.bbsId && wardList.wardId ==  bbsParm_ward_id}"> class="on" </c:if> onclick="go_boardListPage('${wardList.wardId}', '<c:out value="${menuVO.bbsId}"/>', '')"><c:out value="${wardList.wardName}"/></a></li>
                            </c:forEach>
                          </ul>
                        </c:when>
                        <c:when test="${menuVO.bbscttClsUseYn == 'Y'}">  <%-- // 분류사용 게시판인경우 --%>
                         <li class="plus m_${menuVO.bbsId}"><a href="javascript:void(0);" <c:if test="${parmMap.bbsId == menuVO.bbsId }"> class="on" </c:if> onclick="fn_showDownMenu('m_${menuVO.bbsId}');"><c:out value="${menuVO.bbsName}"/></a></li>
                         <ul class="dep04" <c:if test="${parmMap.bbsId == menuVO.bbsId}"> style="display:" </c:if> <c:if test="${parmMap.bbsId != menuVO.bbsId}"> style="display:none" </c:if>>
                            <c:forEach var="clsList" items="${boardClsList}" varStatus="status">
                                <c:if test="${clsList.bbsId == menuVO.bbsId }">
                                <li class="sub"><a href="javascript:void(0);" <c:if test="${parmMap.bbsId == menuVO.bbsId && clsList.bbscttClsSn ==  parmMap.sl}"> class="on" </c:if> onclick="go_boardListPage('${wardList.wardId}', '<c:out value="${menuVO.bbsId}"/>', '${clsList.bbscttClsSn}')"><c:out value="${clsList.bbscttClsName}"/></a></li>
                                </c:if>
                            </c:forEach>
                          </ul>
                        </c:when>
                        <c:otherwise> <%-- // 부서별게시판 또는 분류가 없는 일반게시판인경우 --%>
                        <li><a href="javascript:void(0);" <c:if test="${parmMap.bbsId == menuVO.bbsId }"> class="on" </c:if> onclick="go_boardListPage('', '<c:out value="${menuVO.bbsId}"/>', '')"><c:out value="${menuVO.bbsName}"/></a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>    
                </ul>        
             
        </c:when>
        
        <c:otherwise>
           <%--  나머지 메뉴  --%>       
           <% menuNum = 0; %>    
            <c:forEach var="menuVO" items="${menuList}" varStatus="status">
               <c:if test="${menuVO.progrmUrl != null }">
                    <c:if test="${menuVO.menuStep == '3'}">
                        <% menuNum++; 
                           if (menuNum == 1) {
                               out.println("<ul class=\"dep03\">");
                           }
                         %>
                    </c:if>
                    <li><a href="${pageContext.request.contextPath}<c:out value="${menuVO.progrmUrl}"/>" <c:if test="${menuAuthMap.menuId == menuVO.menuId }"> class="on" </c:if> ><c:out value="${menuVO.menuName}"/></a></li>
                </c:if>
                <c:if test="${menuVO.progrmUrl == null }">
<%--                     <li><c:out value="${menuVO.menuName}"/>/<c:out value="${menuVO.menuStep}"/></li> --%>
                </c:if>
            </c:forEach>
            <% 
               if (menuNum > 0) {
                   out.println("</ul>");
               }
            %>        
        </c:otherwise>
    </c:choose>
     
     </ul>    
    </div>

</div>    