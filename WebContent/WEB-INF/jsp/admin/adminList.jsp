<%@ page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="ajax" uri="http://ajaxtags.sourceforge.net/tags/ajaxtags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
              <div class="col-md-12">
                  <!-- BEGIN SAMPLE TABLE PORTLET-->
                  <div class="portlet light portlet-fit bordered">
                      <div class="portlet-title">
                          <div class="caption">
                              <span class="caption-subject font-dark bold uppercase">관리자 목록</span>
                              </div>
                              <div class="actions">
                              <div class="btn-group">
                                  <a class="btn dark btn-outline btn-circle btn-sm" href="<c:url value="/admin/adminAdd.do"/>">새 관리자 추가</a>
                              </div>
                          </div>    
                      </div>
                      <div class="portlet-body">
                          <div class="table-scrollable">
                              <table class="table table-hover">
                                  <thead>
                                      <tr>
                                          <th>No</th>
                                          <th>아이디</th>
                                          <th>별칭</th>
                                          <th>등급</th>
                                          <th>날짜</th>
                                          <th>작업</th>
                                      </tr>
                                  </thead>
                                  <tbody>
									<c:forEach var="admin" items="${admin_list}" varStatus="status">                                      
                                      <tr>
                                          <td>${(total_count - status.index) - ( (currentPage - 1)  *  displayNum ) }</td>
                                          <td style="line-height:60px">${admin.admin_id}</td>
                                          <td style="line-height:60px">${admin.admin_nick_name}</td>
                                          <td style="line-height:60px">
                                              <c:if test="${admin.admin_grade == 0}">일반 관리자</c:if>
                                              <c:if test="${admin.admin_grade == 1}">고급 관리자</c:if>
                                              <c:if test="${admin.admin_grade == 2}">마스터 관리자</c:if>
                                          </td>
                                          <td class="center" style="line-height:60px">${admin.admin_create_time}</td>
                                          <td class="center">
                                          <c:if test="${admin_grade == -1 || admin_grade == 2}">
                                          <a style="line-height:60px" href="<c:url value='/admin/adminEdit.do'/>?admin_index=${admin.admin_index}"><button class="btn btn-default btn-circle mt-sweetalert" type="button"><i class="fa fa-paste"></i> 수정</button></a>
                                          <a style="line-height:60px" href="<c:url value='/admin/adminEditPwd.do'/>?admin_index=${admin.admin_index}"><button class="btn btn-default btn-circle mt-sweetalert" type="button"><i class="fa fa-paste"></i> 비밀번호 변경</button></a>                                          
                                          <a style="line-height:60px" href="<c:url value='/admin/delete.do'/>?admin_index=${admin.admin_index}" onclick="javascript:return del();"><button class="btn btn-danger btn-circle mt-sweetalert" type="button"><i class="fa fa-times"></i> 지우기</button></a>
                                          </c:if>
                                          <c:if test="${admin_grade == -1 || admin_grade == 2}">
                                          <c:choose>                                          
                                          <c:when test="${admin.login_fail_cnt >= 3}">
                                          <a style="line-height:60px" href="<c:url value='/admin/unlock.do'/>?admin_index=${admin.admin_index}" onclick="javascript:return unlock();"><button class="btn btn-danger btn-circle mt-sweetalert" type="button"><i class="fas fa-lock-open"></i> 잠김해제</button></a>
                                          </c:when>
                                          <c:otherwise>
                                          <a style="line-height:60px" href="<c:url value='/admin/lock.do'/>?admin_index=${admin.admin_index}" onclick="javascript:return lock();"><button class="btn btn-default btn-circle mt-sweetalert" type="button"><i class="fas fa-lock"></i> 잠김</button></a>
                                          </c:otherwise>
                                          </c:choose>
                                          </c:if>
                                          </td>
                                      </tr>
                                      </c:forEach>
                                  </tbody>
                              </table>
                          </div>
                      </div>
                  </div>
                  <!-- END SAMPLE TABLE PORTLET-->
				  <nav aria-label="Page navigation" style="margin-top: 50px; text-align: center;">
                      <ul class="pagination my_pagetion">
                          <c:if test="${not empty paginationInfo}"> <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_search"/> </c:if>
                      </ul>
                  </nav>  
              </div>
          </div>
      </div>
      <!-- END CONTENT BODY -->
  </div>
<script>
function fn_search(pageNo) {
	location.href = '<c:url value="/admin/adminList.do"/>?page='+pageNo;
}
</script>  
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>