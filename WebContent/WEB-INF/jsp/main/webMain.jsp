<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="ajax" uri="http://ajaxtags.sourceforge.net/tags/ajaxtags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>WiniWeb</title>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/home/css/default.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/home/css/buttons.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/home/css/table.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/home/css/wini_grid.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/home/css/jquery/ui/jquery.ui.base.css"/> 
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/home/css/jquery/ui.jqgrid.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/home/css/jquery/jquery.ui.theme.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/home/css/jquery/jquery.button.theme.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/home/css/jquery/jquery.grid.theme.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/home/css/jquery/jquery.datepicker.theme.css"/>
<%-- <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/home/css/ui_layer.css"/> --%>

</head>
<body class="main">
    <div id="wrap">
   
      <c:import url="/main/webHeader.do" charEncoding="UTF-8">
        <c:param name="cssType" value="sub" />
      </c:import>
      
      <%-- <c:import url="/main/webLeftMenu.do" charEncoding="utf-8">
        <c:param name="upmenu_id" value="${menuAuthMap.upmenuId}" />
      </c:import> --%>
        
                
    <%--  본문부분 --%>
      <div id="main_contents">
          <div id="main_contents_board">
              
              <div class="subtitle">
                <h3> WEB정보공유  최근게시글 목록</h3>
              </div>
              <div>
                <form name="frm" id="frm" method="post" enctype="multipart/form-data" action="">
                      <input type="hidden" id="bbsId" name="bbsId" value=""/>
                      <input type="hidden" id="board_ward_id" name="board_ward_id" value="" />
                      <input type="hidden" name="page" value="" />
                      <input type="hidden" id="bbscttSn" name="bbscttSn" value=""/>
                       <input type="hidden" id="iud" name="iud" />
                      <input type="hidden" id="sl" name="sl" />
                      <input type="hidden" id="st" name="st" />
                      <input type="hidden" id="sc" name="sc" />
                      <input type="hidden" id="sd" name="sd" value="" />
                      <input type="hidden" id="ed" name="ed" value="" />
                </form>
                    <table class="tbl_type01" border="1" cellspacing="0" summary="최근글목록">
                      <caption>
                      최근글목록
                      </caption>
                      <colgroup>
                      <col width="200" />
                      <col width="" />
                      <col width="120" />
                      <col width="120" />
                      </colgroup>
                      <thead>
                        <tr>
                          <th scope="col">게시판명</th>
                          <th scope="col">제목</th>
                          <th scope="col">글쓴이</th>
                          <th scope="col">작성일</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:forEach var="result" items="${resultNewList}" varStatus="status"> 
                        <tr>
                          <td scope="row"><c:out value="${result.bbsName}"/></td>
                          <td class="tal"><a onclick="go_boardDetail('${result.bbsId}','1','${result.bbscttSn}','','','','','');" title="최신글 상세보기"><c:out value="${result.title}" escapeXml="false"/>&nbsp;<c:if test="${result.answerCnt > 0 }">(${result.answerCnt })</c:if>&nbsp;<c:if test="${result.newYn == 'Y'}"><img src="${pageContext.request.contextPath}/home/images/icon_new.gif" alt="새글" /></c:if></a></td>
                          <td><c:out value="${result.wrterName}" escapeXml="false"/></td>
                          <td><c:out value="${result.regDtime}"/></td>
                        </tr>
                        </c:forEach>
                        <c:if test="${resultNewListCnt == 0}">
                        <tr>
                          <td colspan="4">등록된 글이 없습니다</td>
                        </tr>
                        </c:if>
                      </tbody>
                    </table>
              </div>
              
              
              <div class="subtitle" style="margin-top: 15px;">
                <h3>커뮤니티 최근게시글 목록</h3>
              </div>
              <div>
                    <table class="tbl_type01" border="1" cellspacing="0" summary="최근글목록">
                      <caption>
                      최근글목록
                      </caption>
                      <colgroup>
                      <col width="200" />
                      <col width="" />
                      <col width="120" />
                      <col width="120" />
                      </colgroup>
                      <thead>
                        <tr>
                          <th scope="col">게시판명</th>
                          <th scope="col">제목</th>
                          <th scope="col">글쓴이</th>
                          <th scope="col">작성일</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:forEach var="result" items="${cummBoardList}" varStatus="status"> 
                        <tr>
                          <td scope="row"><c:out value="${result.bbsName}"/></td>
                          <td class="tal"><a onclick="go_boardDetail('${result.bbsId}','1','${result.bbscttSn}','','','','','');" title="최신글 상세보기"><c:out value="${result.title}" escapeXml="false"/>&nbsp;<c:if test="${result.answerCnt > 0 }">(${result.answerCnt })</c:if>&nbsp;<c:if test="${result.newYn == 'Y'}"><img src="${pageContext.request.contextPath}/home/images/icon_new.gif" alt="새글" /></c:if></a></td>
                          <td><c:out value="${result.wrterName}" escapeXml="false"/></td>
                          <td><c:out value="${result.regDtime}"/></td>
                        </tr>
                        </c:forEach>
                        <c:if test="${cummBoardListCnt == 0}">
                        <tr>
                          <td colspan="4">등록된 글이 없습니다</td>
                        </tr>
                        </c:if>
                      </tbody>
                    </table>
              </div>
          </div>
    </div>
    
</div>

    

<c:import url="/main/webBottom.do" charEncoding="UTF-8"></c:import>

<script type="text/javascript">
<!--

//-->  
</script>

    
</body>
</html>

