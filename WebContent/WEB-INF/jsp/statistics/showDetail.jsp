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
<%
/*
	-상세조회
	1.한국장기조직기증원 요청사항을 최대한 반영하였지만 보완필요
	2.방문분석 -> 페이지 뷰 기능 미완료
	홈페이지의 주 메뉴와 서브메뉴가 확정난 후에 기능 추가 필요
	현재 주 메뉴만 페이지뷰 작업되어있음
	주메뉴 -> 서브메뉴 -> 그래프 작업 요구됨
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
<!-- END HEAD -->
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/common/global/plugins/amcharts/amcharts/plugins/export/export.css" rel="stylesheet" type="text/css" media="all"/>
<style>
    .statistics_data_list .table {
        margin-bottom: 60px !important;
    }
</style>
<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">
<c:import url="/webMenu.do" charEncoding="UTF-8"></c:import>
<!-- BEGIN CONTENT -->
<div id="page_content" class="page-content-wrapper">
    <!-- BEGIN CONTENT BODY -->
    <div class="page-content">
        <!-- BEGIN PAGE HEADER-->
        <!-- BEGIN PAGE TITLE-->
        <div class="row">
            <div class="col-md-2">
                <h1 class="page-title"> 상세조회</h1>
            </div>
            <div class="col-md-7">
                <div class="m-grid top-nav">
                    <div class="m-grid-row">
                        <div class="m-grid-col m-grid-col-middle m-grid-col-center m-grid-col-md-6 nav-title">
                            <span class="caption-subject bold uppercase">방문분석</span>
                        </div>
                        <div class="m-grid-col m-grid-col-middle m-grid-col-center m-grid-col-md-9 nav-title">
                            <span class="caption-subject bold uppercase ">서약자분석</span>
                        </div>
                    </div>
                    <div class="m-grid-row">
                        <div class="m-grid-col m-grid-col-middle m-grid-col-center m-grid-col-md-3">
                            <div id="detail_search_visit_period" class="col-md-6  nav-menu">기간별 통계분석</div>
                            <div id="detail_search_page_view" class="col-md-6  nav-menu">페이지 뷰</div>
                        </div>
                        <div class="m-grid-col m-grid-col-middle m-grid-col-center m-grid-col-md-9 user_period_search_option_row">
                            <div id="detail_search_channel" class="col-md-3  nav-menu">유입채널별</div>
                            <div id="detail_search_sex_age" class="col-md-3  nav-menu">성별/연령별 분포</div>
                            <div id="detail_search_recognize_type" class="col-md-3  nav-menu">등록구분별</div>
                            <div id="detail_search_withdraw" class="col-md-3  nav-menu">탈퇴자 통계분석</div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="col-md-3">
                <!--<button type="button" class="btn btn-sm btn-circle blue btn-outline page-title-element btn-print hidden-print">인쇄</button>-->
                <button type="button" class="btn btn-sm btn-circle green page-title-element btn-export">내보내기</button>
            </div>
        </div>
        <div class="row">
            <div class="col-md-9">
                <form class="form-inline" role="form" id="" action="" method="post">
                    <div class="m-grid period_search_div">
                        <div class="m-grid-row">
                            <div class="m-grid-col m-grid-col-middle m-grid-col-center m-grid-col-md-5">
                                <div class="caption">
                                    <span class="caption-subject bold uppercase">기간설정</span>
                                </div>
                            </div>
                            <div class="m-grid-col m-grid-col-middle m-grid-col-center m-grid-col-md-5">
                                <div class="caption">
                                    <span class="caption-subject bold uppercase">기간설정 옵션</span>
                                </div>
                            </div>
                        </div>
                        <div class="m-grid-row">
                            <div class="m-grid-col m-grid-col-middle m-grid-col-center m-grid-col-md-5">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <div class="input-group date form_datetime bs-datetime">
                                            <input type="text" size="10" id="search_start_date" class="form-control">
                                                                    <span class="input-group-addon">
                                                                        <button class="btn default date-set" type="button">
                                                                            <i class="fa fa-calendar"></i>
                                                                        </button>
                                                                    </span>
                                        </div>
                                        ~
                                        <div class="input-group date form_datetime bs-datetime">
                                            <input type="text" size="10" id="search_end_date" class="form-control">
                                                                    <span class="input-group-addon">
                                                                        <button class="btn default date-set" type="button">
                                                                            <i class="fa fa-calendar"></i>
                                                                        </button>
                                                                    </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="m-grid-col m-grid-col-middle m-grid-col-center m-grid-col-md-5 user_period_search_option_row">
                                <div id="user_period_search_day" class="col-md-2 col-md-offset-1 user_period_search_option_tab">일간</div>
                                <div id="user_period_search_week" class="col-md-2 user_period_search_option_tab">주간</div>
                                <div id="user_period_search_month" class="col-md-2 user_period_search_option_tab">월간</div>
                                <div id="user_period_search_year" class="col-md-2 user_period_search_option_tab">연간</div>
                            </div>
                        </div>
                    </div>
                </form>                                
                
                <form class="form-inline" id="menu_selectbox" style="display: none;">
                    <div class="m-grid period_search_div">
                        <div class="m-grid-row">
                            <div class="m-grid-col m-grid-col-middle m-grid-col-center m-grid-col-md-5">
                                <div class="caption">
                                    <span class="caption-subject bold uppercase">주 메뉴</span>
                                </div>
                            </div>
                            <div class="m-grid-col m-grid-col-middle m-grid-col-center m-grid-col-md-5">
                                <div class="caption">
                                    <span class="caption-subject bold uppercase">서브 메뉴</span>
                                </div>
                            </div>
                        </div>
                        <div class="m-grid-row">
                            <div class="m-grid-col m-grid-col-middle m-grid-col-center m-grid-col-md-5">
                                <div class="form-group">
                                    <div class="col-md-12">                                        
					                    <select class="form-control input-sm" id="search_page_view_menu" style="width:200px;" onchange="getPageViewAjax();">	   					
						   					<option value="1" >장기조직 기증</option>
						   					<option value="2" >기증자예우</option>
						   					<option value="3" >홍보·소식</option>
						   					<option value="4" >정보공개</option>
						   					<option value="5" >KODA</option>
						   					<option value="6" >생명나눔우체통</option>
						   					<option value="7" >기증희망등록</option>	   					                     					                    					                      					                     					                   					                      					                      					                     					
						   				</select>
                                    </div>
                                </div>
                            </div>
                            <div class="m-grid-col m-grid-col-middle m-grid-col-center m-grid-col-md-5 user_period_search_option_row">
                                
                            </div>
                        </div>
                    </div>
                </form>
                
                
            </div>
        </div>
        <!-- END PAGE TITLE-->
        <!-- END PAGE HEADER-->
        <input id="status" name="status" type="hidden" value="1">
        <div class="row" id="statistics_contents">
            <div class="col-md-12">
                <div id="detail_search_visit_period_data" class="col-md-12 statistics-data">
                    <div class="portlet light ">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject bold uppercase font-dark" id="statistics-column-chart-title"></span>
                                <span class="caption-helper">검색된 기간동안 방문자/서약자 총합수치입니다.</span>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div id="column_chart_1" class="statistics_column_chart"></div>
                            <div class="col-md-6 statistics_data_list" id="column_chart_1_data_list_left">
                                <div class="outer-line-box">
                                    <p class="bold">방문자수</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">방문인원</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="column_chart_1_data_list_right">
                                <div class="outer-line-box">
                                    <p class="bold">서약자수</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">서약인원</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="detail_search_channel_data" class="col-md-12 statistics-data">
                    <div class="portlet light ">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject bold uppercase font-dark" id="detail_search_channel_title"></span>
                                <span class="caption-helper">검색된 기간동안 서약자 총합수치입니다.</span>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="col-md-12">
                                <div class="col-md-9">
                                    <div id="pie_chart_1" class="statistics_pie_chart"></div>
                                </div>
                                <div class="col-md-3">
                                    <div id="pie_chart_1_legend" class="pie_chart_legend"></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_1_data_list_left">
                                <div class="outer-line-box">
                                    <p class="bold">온라인 유입</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">인원</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_1_data_list_right">
                                <div class="outer-line-box">
                                    <p class="bold">오프라인 유입</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">인원</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_1_data_list_bottom_left">
                                <div class="outer-line-box">
                                    <p class="bold">SYRUP 유입</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">인원</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="detail_search_sex_age_data" class="col-md-12 statistics-data">
                    <div class="portlet light ">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject bold uppercase font-dark" id="detail_search_sex_age_title"></span>
                                <span class="caption-helper">검색된 기간동안 서약자 총합수치입니다.</span>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div id="column_chart_2" class="statistics_column_chart"></div>
                            <div class="col-md-6 statistics_data_list" id="column_chart_2_data_list_left">
                                <div class="outer-line-box">
                                    <p class="bold">서약자 - 남성</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">인원</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="column_chart_2_data_list_right">
                                <div class="outer-line-box">
                                    <p class="bold">서약자 - 여성</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">인원</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="column_chart_2_data_list_bottom">
                                <div class="outer-line-box">
                                    <p class="bold">서약자 - 연령분포</p>
                                    <p class="" id="column_chart_2_data_list_title_helper"></p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">연령구간</th>
                                            <th class="">인원</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                
                <div id="detail_search_recognize_data" class="col-md-12 statistics-data">
                    <div class="portlet light ">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject bold uppercase font-dark" id="detail_search_recognize_title"></span>
                                <span class="caption-helper">검색된 기간동안 서약자 총합수치입니다.</span>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="col-md-12">
                                <div class="col-md-9">
                                    <div id="pie_chart_3" class="statistics_pie_chart"></div>
                                </div>
                                <div class="col-md-3">
                                    <div id="pie_chart_3_legend" class="pie_chart_legend"></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_3_data_list_left">
                                <div class="outer-line-box">
                                    <p class="bold">서약자</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">인원</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_3_data_list_right">
                                <div class="outer-line-box">
                                    <p class="bold">탈퇴자</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">인원</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_3_data_list_bottom_left">
                                <div class="outer-line-box">
                                    <p class="bold">등록보류자</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">인원</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_3_data_list_bottom_right">
                                <div class="outer-line-box">
                                    <p class="bold">사망자</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">인원</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_3_data_list_bottom_left2">
                                <div class="outer-line-box">
                                    <p class="bold">중복</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">인원</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_3_data_list_bottom_right2">
                                <div class="outer-line-box">
                                    <p class="bold">타기관</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">인원</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                
                <div id="detail_search_withdraw_data" class="col-md-12 statistics-data">
                    <div class="portlet light ">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject bold uppercase font-dark" id="detail_search_withdraw_title"></span>
                                <span class="caption-helper">검색된 기간동안 탈퇴자 총합수치입니다.</span>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="col-md-12">
                                <div class="col-md-9">
                                    <div id="pie_chart_2" class="statistics_pie_chart"></div>
                                </div>
                                <div class="col-md-3">
                                    <div id="pie_chart_2_legend" class="pie_chart_legend"></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_2_data_list_left">
                                <div class="outer-line-box">
                                    <p class="bold">마음이바뀜</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">인원</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_2_data_list_right">
                                <div class="outer-line-box">
                                    <p class="bold">가족반대</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">인원</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_2_data_list_bottom_left">
                                <div class="outer-line-box">
                                    <p class="bold">타기관서약</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">인원</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_2_data_list_bottom_right">
                                <div class="outer-line-box">
                                    <p class="bold">기타</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">인원</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 페이지 뷰 form단 -->                                              
                <div id="detail_search_page_view_data" class="col-md-12 statistics-data">
                    <div class="portlet light ">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject bold uppercase font-dark" id="detail_search_page_view_title"></span>
                                <span class="caption-helper">검색된 기간동안 접속한 페이지 총합수치입니다.</span>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="col-md-12">
                                <div class="col-md-9">
                                    <div id="pie_chart_4" class="statistics_pie_chart"></div>
                                </div>
                                <div class="col-md-3">
                                    <div id="pie_chart_4_legend" class="pie_chart_legend"></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_4_data_list_left">
                                <div class="outer-line-box">
                                    <p class="bold">장기조직 기증</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">접속수</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_4_data_list_right">
                                <div class="outer-line-box">
                                    <p class="bold">기증자예우</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">접속수</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_4_data_list_bottom_left">
                                <div class="outer-line-box">
                                    <p class="bold">홍보·소식</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">접속수</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_4_data_list_bottom_right">
                                <div class="outer-line-box">
                                    <p class="bold">정보공개</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">접속수</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_4_data_list_bottom_left2">
                                <div class="outer-line-box">
                                    <p class="bold">KODA</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">접속수</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_4_data_list_bottom_right2">
                                <div class="outer-line-box">
                                    <p class="bold">생명나눔우체통</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">접속수</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                            <div class="col-md-6 statistics_data_list" id="pie_chart_4_data_list_bottom_left3">
                                <div class="outer-line-box">
                                    <p class="bold">기증희망등록</p>
                                    <table class="table table-condensed">
                                        <thead>
                                        <tr>
                                            <th class="">날짜</th>
                                            <th class="">접속수</th>
                                            <th class="">비율</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                    <div class="pagination_div" ></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--  -->
                
            </div>
        </div>
        <!-- END CONTENT BODY -->
    </div>
    <!-- END CONTENT -->
</div>
<!-- END CONTAINER -->
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery_redirect/jquery.redirect.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/printThis/printThis.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/amcharts/amcharts/amcharts.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/amcharts/amcharts/pie.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/amcharts/amcharts/serial.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/amcharts/amcharts/plugins/export/export.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/amcharts/amcharts/themes/light.js" type="text/javascript"></script>

<script language="JavaScript" type="text/javascript">
    var chart_table_per_page = 20;
    var max_show_page_count = 10;
    var visit_period_data_array = [];
    var channel_data_array = [];
    var sex_age_data_array = [];
    var sex_age_chart_data_array = [];
    var withdraw_data_array = [];

    function showStaticsDetail() {
        var selected_nav_menu = $(".nav-menu").filter(".active").attr("id");
        if (selected_nav_menu == "detail_search_visit_period") {
        	$("#menu_selectbox").attr("style","display:none;");
            getVisitPeriodAjax();
        } else if (selected_nav_menu == "detail_search_channel") {
        	$("#menu_selectbox").attr("style","display:none;");
        	getChannelAjax();
        } else if (selected_nav_menu == "detail_search_sex_age") {
        	$("#menu_selectbox").attr("style","display:none;");
        	getSexAgeAjax();
        } else if (selected_nav_menu == "detail_search_withdraw") {
        	$("#menu_selectbox").attr("style","display:none;");
        	getWithdrawAjax();
        } else if (selected_nav_menu == "detail_search_recognize_type"){
        	$("#menu_selectbox").attr("style","display:none;");
        	getRecognizeTypeAjax();
        } else if (selected_nav_menu == "detail_search_page_view"){
        	//페이지뷰 작업 하자
        	//$("#menu_selectbox").attr("style","display:block;");
        	getPageViewAjax();
        } else {
            getVisitPeriodAjax();
        }
    }

    function exportExcelAjax() {
        var selected_nav_menu = $(".nav-menu").filter(".active").attr("id");
        var url_ajax = "";
        if (selected_nav_menu == "detail_search_visit_period") {
            url_ajax = "<c:url value='/statistics/exportExcelVisitPeriodAjax.do'/>";
        } else if (selected_nav_menu == "detail_search_channel") {
            url_ajax = "<c:url value='/statistics/exportExcelChannelAjax.do'/>";
        } else if (selected_nav_menu == "detail_search_sex_age") {
            url_ajax = "<c:url value='/statistics/exportExcelSexAgeAjax.do'/>";
        } else if (selected_nav_menu == "detail_search_withdraw") {
            url_ajax = "<c:url value='/statistics/exportExcelWithdrawAjax.do'/>";
        } else if (selected_nav_menu == "detail_search_recognize_type"){
        	url_ajax = "<c:url value='/statistics/exportExcelRecognizeTypeAjax.do'/>";
        }
        var data_search = {
            'search_start_date': $("#search_start_date").val(),
            'search_end_date': $("#search_end_date").val()
        };

        $.ajax({
            url: url_ajax,
            type: 'post',
            dataType: "json",
            data: data_search,
            success: function(data) {
                /* var parsedData = $.parseJSON(data);
                if(parsedData == 1 ) {
                    var target_url = "${pageContext.request.contextPath}/uploads/statistics/statistics.xls";
                    window.open(target_url, 'excel');
                } else {
                    alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=1');
                } */
                if(data != null && data.rtnCode == "") {
                	var target_url = "<c:url value='/uploads/statistics/statistics.xls'/>";
                    window.open(target_url, 'excel');
                } else {
                    alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=1');
                }
            },
            error: function(xhr, desc, err) {
                alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=2');
            }
        });
    }

    function getVisitPeriodAjax() {
        var data_search = {
            'search_start_date': $("#search_start_date").val(),
            'search_end_date': $("#search_end_date").val()
        };

        $.ajax({
            url: "<c:url value='/statistics/getVisitPeriodAjax.do'/>",
            type: 'post',
            data: data_search,
            dataType: "json",
            success: function(data) {            	      
            	if(data != null && data.rtnCode == "") {	               
	                $(".statistics-data").hide();
	                $("#detail_search_visit_period_data").show();
	                // Set Chart
	                var title = "방문자: "+data.total_visit_count+" / 서약자: "+data.total_pledge_count+" ";
	                $("#statistics-column-chart-title").html(title);
	                column_chart_1.dataProvider = data.chart_data_array;
	                column_chart_1.validateData();
	                // Set Data Table
	                visit_period_data_array = data.data_list_data_array;
	                showDataTable("column_chart_1_data_list_left", 'visit_period_data_array', 'day', 'visit', '', 1, true);
	                showDataTable("column_chart_1_data_list_right", 'visit_period_data_array', 'day', 'pledge', '', 1, true);
            	} else {
            		//alert(data.rtnMsg);
            		alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=1');
            	}
            },
            error: function(xhr, desc, err) {
                alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=2');
            }
        });
    }
    function getChannelAjax() {
        var data_search = {
            'search_start_date': $("#search_start_date").val(),
            'search_end_date': $("#search_end_date").val()
        };

        $.ajax({
            url: "<c:url value='/statistics/getChannelAjax.do'/>",
            type: 'post',
            data: data_search,
            dataType: "json",
            success: function(data) {
            	if(data != null && data.rtnCode == "") {
	                //var parsedData = $.parseJSON(data);
	                $(".statistics-data").hide();
	                $("#detail_search_channel_data").show();
	                // Set Chart
	                var total_count = data.total_online_count + data.total_offline_count + data.total_syrup_count;
	                var title = "총서약자: "+total_count+" ";
	                $("#detail_search_channel_title").html(title);
	                pie_chart_1.dataProvider = data.chart_data_array;
	                pie_chart_1.validateData()
	                showPieChart1Legend();
	                // Set Data Table
	                channel_data_array = data.data_list_data_array;
	                showDataTable("pie_chart_1_data_list_left", 'channel_data_array', 'day', 'online', 'online_percentage', 1, true);
	                showDataTable("pie_chart_1_data_list_right", 'channel_data_array', 'day', 'offline', 'offline_percentage', 1, true);
	                showDataTable("pie_chart_1_data_list_bottom_left", 'channel_data_array', 'day', 'syrup', 'syrup_percentage', 1, true);
            	} else {
            		alert(data.rtnMsg);
            	}
            },
            error: function(xhr, desc, err) {
                alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=2');
            }
        });
    }
    function getSexAgeAjax() {
        var data_search = {
            'search_start_date': $("#search_start_date").val(),
            'search_end_date': $("#search_end_date").val()
        };

        $.ajax({
            url: "<c:url value='/statistics/getSexAgeAjax.do'/>",
            type: 'post',
            data: data_search,
            dataType: "json",
            success: function(data) {
            	if(data != null && data.rtnCode == "") {
	                //ar parsedData = $.parseJSON(data);
	                $(".statistics-data").hide();
	                $("#detail_search_sex_age_data").show();
	                // Set Chart
	                var total_count = data.total_count;
	                var title = "총서약자: "+total_count+" ";
	                $("#detail_search_sex_age_title").html(title);
	                column_chart_2.dataProvider = data.chart_data_array;
	                column_chart_2.validateData();
	                // Set Data Table
	                sex_age_data_array = data.data_list_data_array;
	                sex_age_chart_data_array = data.chart_data_array.reverse();
	                showDataTable("column_chart_2_data_list_left", 'sex_age_data_array', 'day', 'male', 'male_percentage', 1, true);
	                showDataTable("column_chart_2_data_list_right", 'sex_age_data_array', 'day', 'female', 'female_percentage', 1, true);
	                showDataTable("column_chart_2_data_list_bottom", 'sex_age_chart_data_array', 'age', 'human', 'rate', 1, false);
            	} else {
            		alert(data.rtnMsg);
            	}
            },
            error: function(xhr, desc, err) {
                alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=2');
            }
        });
    }
    function getRecognizeTypeAjax() {
        
        var data_search = {
                'search_start_date': $("#search_start_date").val(),
                'search_end_date': $("#search_end_date").val()
            };

            $.ajax({
                url: "<c:url value='/statistics/getRecognizeTypeAjax.do'/>",
                type: 'post',
                data: data_search,
                dataType: "json",
                success: function(data) {
                	if(data != null && data.rtnCode == "") {
    	                //var parsedData = $.parseJSON(data);
    	                $(".statistics-data").hide();
    	                $("#detail_search_recognize_data").show();
    	                // Set Chart
    	                var total_count = data.total_pledge_count + data.total_withdraw_count + data.total_hold_count + data.total_dead_count + data.total_overlap_count + data.total_other_count;
    	                var title = "총서약자: "+total_count+" ";
    	                $("#detail_search_recognize_title").html(title);
    	                pie_chart_3.dataProvider = data.chart_data_array;
    	                pie_chart_3.validateData()
    	                showPieChart3Legend();
    	                // Set Data Table
    	                channel_data_array = data.data_list_data_array;
    	                showDataTable("pie_chart_3_data_list_left", 'channel_data_array', 'day', 'pledge', 'pledge_percentage', 1, true);
    	                showDataTable("pie_chart_3_data_list_right", 'channel_data_array', 'day', 'withdraw', 'withdraw_percentage', 1, true);
    	                showDataTable("pie_chart_3_data_list_bottom_left", 'channel_data_array', 'day', 'hold', 'hold_percentage', 1, true);
    	                showDataTable("pie_chart_3_data_list_bottom_right", 'channel_data_array', 'day', 'dead', 'dead_percentage', 1, true);
    	                showDataTable("pie_chart_3_data_list_bottom_left2", 'channel_data_array', 'day', 'overlap', 'overlap_percentage', 1, true);
    	                showDataTable("pie_chart_3_data_list_bottom_right2", 'channel_data_array', 'day', 'other', 'other_percentage', 1, true);
                	} else {
                		alert(data.rtnMsg);
                	}
                },
                error: function(xhr, desc, err) {
                    alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=2');
                }
            });
        
    }
    function getWithdrawAjax() {
        var data_search = {
            'search_start_date': $("#search_start_date").val(),
            'search_end_date': $("#search_end_date").val()
        };

        $.ajax({
            url: "<c:url value='/statistics/getWithdrawAjax.do'/>",
            type: 'post',
            data: data_search,
            dataType: "json",
            success: function(data) {
            	if(data != null && data.rtnCode == "") {
	                //var parsedData = $.parseJSON(data);
	                $(".statistics-data").hide();
	                $("#detail_search_withdraw_data").show();
	                // Set Chart
	                var title = "총탈퇴자: "+data.total_withdraw_count+" ";
	                $("#detail_search_withdraw_title").html(title);
	                pie_chart_2.dataProvider = data.chart_data_array;
	                pie_chart_2.validateData();
	                showPieChart2Legend();
	                // Set Data Table
	                withdraw_data_array = data.data_list_data_array;
	                showDataTable("pie_chart_2_data_list_left", 'withdraw_data_array', 'day', 'withdraw1', 'withdraw1_percentage', 1, true);
	                showDataTable("pie_chart_2_data_list_right", 'withdraw_data_array', 'day', 'withdraw2', 'withdraw2_percentage', 1, true);
	                showDataTable("pie_chart_2_data_list_bottom_left", 'withdraw_data_array', 'day', 'withdraw3', 'withdraw3_percentage', 1, true);
	                showDataTable("pie_chart_2_data_list_bottom_right", 'withdraw_data_array', 'day', 'withdraw4', 'withdraw4_percentage', 1, true);
            	}
            },
            error: function(xhr, desc, err) {
                alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=2');
            }
        });
    }
	function getPageViewAjax() {
	        
        var data_search = {
                'search_start_date': $("#search_start_date").val(),
                'search_end_date': $("#search_end_date").val(),
                'search_page_view_menu': $("#search_page_view_menu").val() 
            };
			//alert($("#search_page_view_menu").val());
            $.ajax({
                url: "<c:url value='/statistics/getPageViewAjax.do'/>",
                type: 'post',
                data: data_search,
                dataType: "json",
                success: function(data) {
                	if(data != null && data.rtnCode == "") {
    	                //var parsedData = $.parseJSON(data);
    	                $(".statistics-data").hide();
    	                $("#detail_search_page_view_data").show();
    	                // Set Chart
    	                    	                
    	                var total_count = data.total_donate_count + data.total_remembrance_count + data.total_notification_count + data.total_info_count + data.total_koda_count + data.total_mailbox_count + data.total_hopeDonateStats_count;    	                
    	                var title = "총페이지 접속수: "+total_count+" ";
    	                $("#detail_search_page_view_title").html(title);
    	                pie_chart_4.dataProvider = data.chart_data_array;
    	                pie_chart_4.validateData()
    	                showPieChart4Legend();
    	                // Set Data Table
    	                channel_data_array = data.data_list_data_array;
    	                showDataTable("pie_chart_4_data_list_left", 'channel_data_array', 'day', 'donate', 'donate_percentage', 1, true);
    	                showDataTable("pie_chart_4_data_list_right", 'channel_data_array', 'day', 'remembrance', 'remembrance_percentage', 1, true);
    	                showDataTable("pie_chart_4_data_list_bottom_left", 'channel_data_array', 'day', 'notification', 'notification_percentage', 1, true);
    	                showDataTable("pie_chart_4_data_list_bottom_right", 'channel_data_array', 'day', 'info', 'info_percentage', 1, true);
    	                showDataTable("pie_chart_4_data_list_bottom_left2", 'channel_data_array', 'day', 'koda', 'koda_percentage', 1, true);
    	                showDataTable("pie_chart_4_data_list_bottom_right2", 'channel_data_array', 'day', 'mailbox', 'mailbox_percentage', 1, true);
    	                showDataTable("pie_chart_4_data_list_bottom_left3", 'channel_data_array', 'day', 'hopeDonateStats', 'hopeDonateStats_percentage', 1, true);
                	} else {
                		alert(data.rtnMsg);
                	}
                },
                error: function(xhr, desc, err) {
                    alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=2');
                }
            });
        
    }
    function exportExcelVisitPeriodAjax() {
        var data_search = {
            'search_start_date': $("#search_start_date").val(),
            'search_end_date': $("#search_end_date").val()
        };

        $.ajax({
            url: "<c:url value='/statistics/exportExcelVisitPeriodAjax.do'/>",
            type: 'post',
            data: data_search,
            dataType: "json",
            success: function(data) {
            	if(data != null && data.rtnCode == "") {
	                /* var parsedData = $.parseJSON(data);
	                if(parsedData == 1 ) {
	                    var target_url = "${pageContext.request.contextPath}/uploads/statistics/statistics.xls";
	                    window.open(target_url, 'excel');
	                } else {
	                    alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=1');
	                } */
	                if(data != null && data.rtnCode == "") {
                    	var target_url = "<c:url value='/uploads/statistics/statistics.xls'/>";
                        window.open(target_url, 'excel');
                    } else {
                        alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=1');
                    }
            	}
            },
            error: function(xhr, desc, err) {
                alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=2');
            }
        });
    }
    function exportExcelChannelAjax() {
        var data_search = {
            'search_start_date': $("#search_start_date").val(),
            'search_end_date': $("#search_end_date").val()
        };

        $.ajax({
            url: "<c:url value='/statistics/exportExcelChannelAjax.do'/>",
            type: 'post',
            dataType: "json",
            data: data_search,
            success: function(data) {
            	if(data != null && data.rtnCode == "") {
	                /* var parsedData = $.parseJSON(data);
	                if(parsedData == 1 ) {
	                    var target_url = "${pageContext.request.contextPath}/uploads/statistics/statistics.xls";
	                    window.open(target_url, 'excel');
	                } else {
	                    alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=1');
	                } */
	                if(data != null && data.rtnCode == "") {
                    	var target_url = "<c:url value='/uploads/statistics/statistics.xls'/>";
                        window.open(target_url, 'excel');
                    } else {
                        alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=1');
                    }
            	}
            },
            error: function(xhr, desc, err) {
                alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=2');
            }
        });
    }
    function exportExcelSexAgeAjax() {
        var data_search = {
            'search_start_date': $("#search_start_date").val(),
            'search_end_date': $("#search_end_date").val()
        };

        $.ajax({
            url: "<c:url value='/statistics/exportExcelSexAgeAjax.do'/>",
            type: 'post',
            dataType: "json",
            data: data_search,
            success: function(data) {
            	if(data != null && data.rtnCode == "") {
	                /* var parsedData = $.parseJSON(data);
	                if(parsedData == 1 ) {
	                    var target_url = "${pageContext.request.contextPath}/uploads/statistics/statistics.xls";
	                    window.open(target_url, 'excel');
	                } else {
	                    alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=1');
	                } */
	                if(data != null && data.rtnCode == "") {
                    	var target_url = "<c:url value='/uploads/statistics/statistics.xls'/>";
                        window.open(target_url, 'excel');
                    } else {
                        alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=1');
                    }
            	}
            },
            error: function(xhr, desc, err) {
                alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=2');
            }
        });
    }
    function exportExcelWithdrawAjax() {
        var data_search = {
            'search_start_date': $("#search_start_date").val(),
            'search_end_date': $("#search_end_date").val()
        };

        $.ajax({
            url: "<c:url value='/statistics/exportExcelWithdrawAjax.do'/>",
            type: 'post',
            dataType: "json",
            data: data_search,
            success: function(data) {
            	if(data != null && data.rtnCode == "") {
	                /* var parsedData = $.parseJSON(data);
	                if(parsedData == 1 ) {
	                    var target_url = "${pageContext.request.contextPath}/uploads/statistics/statistics.xls";
	                    window.open(target_url, 'excel');
	                } else {
	                    alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=1');
	                } */
	                if(data != null && data.rtnCode == "") {
                    	var target_url = "<c:url value='/uploads/statistics/statistics.xls'/>";
                        window.open(target_url, 'excel');
                    } else {
                        alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=1');
                    }
            	}
            },
            error: function(xhr, desc, err) {
                alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=2');
            }
        });
    }

    function showDataTable(data_list_id, data_array_name, data_name1, data_name2, data_name3, cur_page, is_pagination) {
        $("#"+data_list_id+" tbody *").remove();
        var count = 0;
        var start_index = (cur_page-1) * chart_table_per_page;
        var data_array =  eval(data_array_name);
        var max_index = data_array.length;
        for(var index=start_index; index < max_index; index++) {
            var tr_html =
                '<tr>'+
                    '<td>'+data_array[max_index-index-1][data_name1]+'</td>'+
                    '<td>'+data_array[max_index-index-1][data_name2]+'</td>';
            if(data_name3 != '') {
                tr_html += '<td>'+data_array[max_index-index-1][data_name3]+'</td>';
            }
            tr_html += '</tr>';
            $("#"+data_list_id+" tbody").append(tr_html);
            count++;
            if(count >= chart_table_per_page && is_pagination) {
                break;
            }
        }
        if (is_pagination) {
            addPagination(data_list_id, data_array_name, data_name1, data_name2, data_name3, cur_page, is_pagination);
        }

    }
    function addPagination(data_list_id, data_array_name, data_name1, data_name2, data_name3, cur_page, is_pagination){
        var per_page = chart_table_per_page;
        var total_count = eval(data_array_name).length;
        var page_max = total_count%per_page == 0 ? parseInt(total_count/per_page) : parseInt(total_count/per_page) + 1;
        var start_page = (cur_page-max_show_page_count/2 > 1 ) ? cur_page-max_show_page_count/2 : 1;
        var end_page = (cur_page+max_show_page_count/2 < page_max) ? cur_page+max_show_page_count/2 : page_max;
        if(end_page >= max_show_page_count/2 && cur_page < max_show_page_count/2) {
            end_page = end_page + (max_show_page_count/2-cur_page);
        }
        if(start_page > 1 && cur_page > page_max-max_show_page_count/2) {
            start_page = start_page - (cur_page-page_max+max_show_page_count/2);
        }
        var prev_page = (cur_page-max_show_page_count > 1) ? cur_page-max_show_page_count : 1;
        var next_page = (cur_page+max_show_page_count < page_max) ? cur_page+max_show_page_count : page_max;
        var pagintation_html = '<ul class="pagination">';
        pagintation_html += '<li class="page_prev">' +
                                '<a href="javascript:showDataTable(\''+data_list_id+'\', \''+data_array_name+'\',  \''+data_name1+'\', \''+data_name2+'\',  \''+data_name3+'\', '+prev_page+', '+is_pagination+')" aria-label="Previous">' +
                                    '<span aria-hidden="true">&laquo;</span>' +
                                '</a>' +
                            '</li>';
        for(var page = start_page; page <= end_page; page++){
            pagintation_html += '<li>' +
                                    '<a href="javascript:showDataTable(\''+data_list_id+'\', \''+data_array_name+'\',  \''+data_name1+'\', \''+data_name2+'\',  \''+data_name3+'\',  '+page+', '+is_pagination+')">'+page+'</a>' +
                                '</li>'
        }
        pagintation_html += '<li class="page_next">' +
                                '<a href="javascript:showDataTable(\''+data_list_id+'\', \''+data_array_name+'\', \''+data_name1+'\', \''+data_name2+'\', \''+data_name3+'\', '+next_page+', '+is_pagination+')" aria-label="Next">' +
                                    '<span aria-hidden="true">&raquo;</span>' +
                                '</a>' +
                            '</li>';
        pagintation_html += '</ul>';
        $("#"+data_list_id+" .pagination_div").html(pagintation_html);
        // Hide prev/next button
        if(cur_page == 1) {
            $("#"+data_list_id+" .pagination_div").find(".page_prev").hide();
        }
        if(cur_page == page_max) {
            $("#"+data_list_id+" .pagination_div").find(".page_next").hide();
        }
        // Set Current Page Highlight
        $("#"+data_list_id+" .pagination_div").find("li").removeClass("active");
        $("#"+data_list_id+" .pagination_div").find("li:nth-of-type("+(cur_page-start_page+2)+")").addClass("active");
    }

    var column_chart_1 = AmCharts.makeChart("column_chart_1", {
        "type": "serial",
        "theme": "light",
        "autoMargins": false,
        "marginLeft": 30,
        "marginRight": 8,
        "marginTop": 10,
        "marginBottom": 26,

        "fontFamily": 'Open Sans',
        "color":    '#888',

        "legend": {
            "useGraphSettings": true,
            "markerSize": 14,
            "valueWidth": 0,
            "verticalGap": 0
        },

        "dataProvider": [],
        "valueAxes": [{
            "axisAlpha": 0,
            "position": "left"
        }],
        "startDuration": 1,
        "graphs": [{
            "alphaField": "alpha",
            "balloonText": "<span style='font-size:13px;'>[[title]] in [[category]]:<b>[[value]]</b> [[additional]]</span>",
            "dashLengthField": "dashLengthColumn",
            "fillAlphas": 1,
            "title": "방문자",
            "type": "column",
            "valueField": "visit"
        }, {
            "balloonText": "<span style='font-size:13px;'>[[title]] in [[category]]:<b>[[value]]</b> [[additional]]</span>",
            "bullet": "round",
            "dashLengthField": "dashLengthLine",
            "lineThickness": 3,
            "bulletSize": 7,
            "bulletBorderAlpha": 1,
            "bulletColor": "#FFFFFF",
            "useLineColorForBulletBorder": true,
            "bulletBorderThickness": 3,
            "fillAlphas": 0,
            "lineAlpha": 1,
            "title": "서약자",
            "valueField": "pledge"
        }],
        "categoryField": "day",
        "categoryAxis": {
            "gridPosition": "start",
            "axisAlpha": 0,
            "tickLength": 0
        },
        "export": {
            "enabled": true
        }
    });
    var column_chart_2 = AmCharts.makeChart("column_chart_2", {
        "type": "serial",
        "theme": "light",
        "autoMargins": false,
        "marginLeft": 30,
        "marginRight": 8,
        "marginTop": 10,
        "marginBottom": 26,

        "fontFamily": 'Open Sans',
        "color":    '#888',

        "legend": {
            "useGraphSettings": true,
            "markerSize": 14,
            "valueWidth": 0,
            "verticalGap": 0
        },
        "trendLines": [],
        "guides": [],
        "dataProvider": [],
        "valueAxes": [{
            "axisAlpha": 0,
            "position": "left"
        }],
        "startDuration": 1,
        "graphs": [
            {
                "balloonText": "서약자-남성:[[value]]",
                "fillAlphas": 0.8,
                "id": "male",
                "lineAlpha": 0.2,
                "title": "서약자-남성",
                "type": "column",
                "valueField": "male"
            },
            {
                "balloonText": "서약자-여성:[[value]]",
                "fillAlphas": 0.8,
                "id": "female",
                "lineAlpha": 0.2,
                "title": "서약자-여성",
                "type": "column",
                "valueField": "female"
            }
        ],
        "categoryField": "age",
        "categoryAxis": {
            "gridPosition": "start",
            "position": "bottom"
        },
        "export": {
            "enabled": true
        }
    });

    var pie_chart_1 = AmCharts.makeChart("pie_chart_1", {
        "type": "pie",
        "startDuration": 0,
        "theme": "light",
        "addClassNames": true,
        "innerRadius": "30%",
        "defs": {
            "filter": [{
                "id": "shadow",
                "width": "200%",
                "height": "200%",
                "feOffset": {
                    "result": "offOut",
                    "in": "SourceAlpha",
                    "dx": 0,
                    "dy": 0
                },
                "feGaussianBlur": {
                    "result": "blurOut",
                    "in": "offOut",
                    "stdDeviation": 5
                },
                "feBlend": {
                    "in": "SourceGraphic",
                    "in2": "blurOut",
                    "mode": "normal"
                }
            }]
        },
        "dataProvider": [],
        "valueField": "pledge",
        "titleField": "channel",
        "export": {
            "enabled": true
        }
    });
    
    pie_chart_1.addListener("init", function() {
        //pie_chart_1.legend.addListener("rollOverItem", handleRollOver);
    });
    pie_chart_1.addListener("rollOverSlice", function(e) {
        var wedge = e.dataItem.wedge.node;
        wedge.parentNode.appendChild(wedge);
    });
    function showPieChart1Legend() {
        // populate our custom legend when chart renders
        var innerhtml = "";
        for (var i in pie_chart_1.chartData) {
            var row = pie_chart_1.chartData[i];
            var color = pie_chart_1.colors[i];
            var percent = Math.round(row.percents * 100) / 100;
            var value = row.value;
            innerhtml += '<div class="legend-item" id="legend-item-' + i + '" onclick="toggleSlice(' + i + ');" onmouseover="hoverSlice(' + i + ');" onmouseout="blurSlice(' + i + ');" style="color: ' + color + ';"><div class="legend-marker" style="background: ' + color + '"></div>' + row.title + '<div class="legend-value">' + value + ' | ' + percent + '%</div></div>';
        }
        $("#pie_chart_1_legend").html(innerhtml);
    }
    
    function toggleSlice(item) {
        chart.clickSlice(item);
    }

    function hoverSlice(item) {
        chart.rollOverSlice(item);
    }

    function blurSlice(item) {
        chart.rollOutSlice(item);
    }
    var pie_chart_2 = AmCharts.makeChart("pie_chart_2", {
        "type": "pie",
        "startDuration": 0,
        "theme": "light",
        "addClassNames": true,
        "innerRadius": "30%",
        "defs": {
            "filter": [{
                "id": "shadow",
                "width": "200%",
                "height": "200%",
                "feOffset": {
                    "result": "offOut",
                    "in": "SourceAlpha",
                    "dx": 0,
                    "dy": 0
                },
                "feGaussianBlur": {
                    "result": "blurOut",
                    "in": "offOut",
                    "stdDeviation": 5
                },
                "feBlend": {
                    "in": "SourceGraphic",
                    "in2": "blurOut",
                    "mode": "normal"
                }
            }]
        },
        "dataProvider": [],
        "valueField": "pledge",
        "titleField": "withdraw",
        "export": {
            "enabled": true
        }
    });
    pie_chart_2.addListener("init", function() {
        //pie_chart_1.legend.addListener("rollOverItem", handleRollOver);
    });
    pie_chart_2.addListener("rollOverSlice", function(e) {
        var wedge = e.dataItem.wedge.node;
        wedge.parentNode.appendChild(wedge);
    });
    
    function showPieChart2Legend() {
        // populate our custom legend when chart renders
        var innerhtml = "";
        for (var i in pie_chart_2.chartData) {
            var row = pie_chart_2.chartData[i];
            var color = pie_chart_2.colors[i];
            var percent = Math.round(row.percents * 100) / 100;
            var value = row.value;
            innerhtml += '<div class="legend-item" id="legend-item-' + i + '" onclick="toggleSlice(' + i + ');" onmouseover="hoverSlice(' + i + ');" onmouseout="blurSlice(' + i + ');" style="color: ' + color + ';"><div class="legend-marker" style="background: ' + color + '"></div>' + row.title + '<div class="legend-value">' + value + ' | ' + percent + '%</div></div>';
        }
        $("#pie_chart_2_legend").html(innerhtml);
    }
	
    var pie_chart_3 = AmCharts.makeChart("pie_chart_3", {
        "type": "pie",
        "startDuration": 0,
        "theme": "light",
        "addClassNames": true,
        "innerRadius": "30%",
        "defs": {
            "filter": [{
                "id": "shadow",
                "width": "200%",
                "height": "200%",
                "feOffset": {
                    "result": "offOut",
                    "in": "SourceAlpha",
                    "dx": 0,
                    "dy": 0
                },
                "feGaussianBlur": {
                    "result": "blurOut",
                    "in": "offOut",
                    "stdDeviation": 5
                },
                "feBlend": {
                    "in": "SourceGraphic",
                    "in2": "blurOut",
                    "mode": "normal"
                }
            }]
        },
        "dataProvider": [],
        "valueField": "pledge",
        "titleField": "gubun",
        "export": {
            "enabled": true
        }
    });
    
    pie_chart_3.addListener("init", function() {
        //pie_chart_1.legend.addListener("rollOverItem", handleRollOver);    	
    });
    pie_chart_3.addListener("rollOverSlice", function(e) {
        var wedge = e.dataItem.wedge.node;
        wedge.parentNode.appendChild(wedge);      
    });
    function showPieChart3Legend() {
        // populate our custom legend when chart renders
        var innerhtml = "";
        for (var i in pie_chart_3.chartData) {
            var row = pie_chart_3.chartData[i];
            var color = pie_chart_3.colors[i];
            var percent = Math.round(row.percents * 100) / 100;
            var value = row.value;
            innerhtml += '<div class="legend-item" id="legend-item-' + i + '" onclick="toggleSlice(' + i + ');" onmouseover="hoverSlice(' + i + ');" onmouseout="blurSlice(' + i + ');" style="color: ' + color + ';"><div class="legend-marker" style="background: ' + color + '"></div>' + row.title + '<div class="legend-value">' + value + ' | ' + percent + '%</div></div>';
        }
        $("#pie_chart_3_legend").html(innerhtml);
    }
    
    var pie_chart_4 = AmCharts.makeChart("pie_chart_4", {
        "type": "pie",
        "startDuration": 0,
        "theme": "light",
        "addClassNames": true,
        "innerRadius": "30%",
        "defs": {
            "filter": [{
                "id": "shadow",
                "width": "200%",
                "height": "200%",
                "feOffset": {
                    "result": "offOut",
                    "in": "SourceAlpha",
                    "dx": 0,
                    "dy": 0
                },
                "feGaussianBlur": {
                    "result": "blurOut",
                    "in": "offOut",
                    "stdDeviation": 5
                },
                "feBlend": {
                    "in": "SourceGraphic",
                    "in2": "blurOut",
                    "mode": "normal"
                }
            }]
        },
        "dataProvider": [],
        "valueField": "pledge",
        "titleField": "gubun",
        "export": {
            "enabled": true
        }
    });
    
    pie_chart_4.addListener("init", function() {
        //pie_chart_1.legend.addListener("rollOverItem", handleRollOver);    	
    });
    pie_chart_4.addListener("rollOverSlice", function(e) {
        var wedge = e.dataItem.wedge.node;
        wedge.parentNode.appendChild(wedge);      
    });
    function showPieChart4Legend() {
        // populate our custom legend when chart renders
        var innerhtml = "";
        for (var i in pie_chart_4.chartData) {
            var row = pie_chart_4.chartData[i];
            var color = pie_chart_4.colors[i];
            var percent = Math.round(row.percents * 100) / 100;
            var value = row.value;
            innerhtml += '<div class="legend-item" id="legend-item-' + i + '" onclick="toggleSlice(' + i + ');" onmouseover="hoverSlice(' + i + ');" onmouseout="blurSlice(' + i + ');" style="color: ' + color + ';"><div class="legend-marker" style="background: ' + color + '"></div>' + row.title + '<div class="legend-value">' + value + ' | ' + percent + '%</div></div>';
        }
        $("#pie_chart_4_legend").html(innerhtml);
    }
    
    function warning_delete() {
        if(confirm('이 항목을 삭제하시겠습니까? ')){
            return true;
        } else {
            return false;
        }
    }

    Date.prototype.addDays = function (n) {
        var time = this.getTime();
        var changedDate = new Date(time + (n * 24 * 60 * 60 * 1000));
        this.setTime(changedDate.getTime());
        return this;
    };
    function setSearchStartDateByOption(period) {
        var search_end_date = $("#search_end_date").val();
        var date_arr = search_end_date.split('.');
        var search_end_date_obj = new Date(date_arr[0], date_arr[1]-1, date_arr[2]);
        var search_start_date_obj = search_end_date_obj;
        var search_start_date_string = "";
        if(period == 30) {
            search_start_date_string = search_start_date_obj.getFullYear() + "." + ((search_start_date_obj.getMonth()+1) < 10 ? "0"+(search_start_date_obj.getMonth()+1) : (search_start_date_obj.getMonth()+1)) + "." + "01";
        } else if(period == 365){
            search_start_date_string = search_start_date_obj.getFullYear() + "." + "01" + "." + "01";
        } else {
            search_start_date_obj = search_start_date_obj.addDays(-period);
            search_start_date_string = search_start_date_obj.getFullYear() + "." + ((search_start_date_obj.getMonth()+1) < 10 ? "0"+(search_start_date_obj.getMonth()+1) : (search_start_date_obj.getMonth()+1)) + "."
            						+ (search_start_date_obj.getDate() < 10 ? "0"+search_start_date_obj.getDate() : search_start_date_obj.getDate());
        }
        $("#search_start_date").val(search_start_date_string);
    }
    function setSearchStartDateInit() {
        var search_start_date_obj = new Date(2000,1,1);
        var search_start_date_string = search_start_date_obj.getFullYear() + "." + (search_start_date_obj.getMonth() < 10 ? "0"+search_start_date_obj.getMonth() : search_start_date_obj.getMonth()) + "." 
        							+ (search_start_date_obj.getDate() < 10 ? "0"+search_start_date_obj.getDate() : search_start_date_obj.getDate());
        $("#search_start_date").val(search_start_date_string);
    }

    function initValue() {
        // Search Init
        $("#detail_search_visit_period").addClass("active");
        $("#user_period_search_day").addClass("active");
        var today = new Date();
        today.setDate(today.getDate());
        var today_string = today.getFullYear() + "." + ((today.getMonth()+1 < 10) ? "0"+(today.getMonth()+1) : (today.getMonth()+1)) + "." 
        					+ (today.getDate() < 10 ? "0"+today.getDate() : today.getDate());
        $("#search_start_date").val(today_string);
        $("#search_end_date").val(today_string);
    }

    $(document).ready(function() {
        initValue();
        getVisitPeriodAjax();
        //dashboardChart.init();

        $(".btn-print").click(function(e) {
            $("#statistics_contents").printThis({
                debug: false,
                importCSS: true,
                importStyle: true,
                printContainer: true,
                loadCSS: {
                },
                pageTitle: "통계메뉴 - 상세조회",
                removeInline: false,
                printDelay: 333,
                header: null,
                formValues: true
            });
        });
        $(".btn-export").click(function(e) {
            exportExcelAjax();
        });

        // Nav Menu
        $(".nav-menu").click(function(e) {
            $(".nav-menu").removeClass("active");
            $(this).addClass("active");
            showStaticsDetail();
        });

        // Period
        $(".user_period_search_option_tab").click(function(e) {
            var user_period_search_option_id = $(this).attr("id");
            $(".user_period_search_option_tab").removeClass("active");
            $(this).addClass("active");
        });
        $("#user_period_search_day").click(function(e) {
            setSearchStartDateByOption(0);
            showStaticsDetail();
        });
        $("#user_period_search_week").click(function(e) {
            setSearchStartDateByOption(7);
            showStaticsDetail();
        });
        $("#user_period_search_month").click(function(e) {
            setSearchStartDateByOption(30);
            showStaticsDetail();
        });
        $("#user_period_search_year").click(function(e) {
            setSearchStartDateByOption(365);
            showStaticsDetail();
        });
        /*$("#user_period_search_all").click(function(e) {
            setSearchStartDateInit();
            showStaticsDetail();
        });*/
        $(".form_datetime").datetimepicker({
            autoclose: true,
            isRTL: App.isRTL(),
            format: "yyyy.mm.dd",
            minView: 2,
            maxView: 3,
            fontAwesome: true,
            initialDate: new Date(),
            pickerPosition: (App.isRTL() ? "bottom-right" : "bottom-left")
        }).on('changeDate', function(ev){
            showStaticsDetail();
        });
        $("#user_period_search_month").trigger("click");

    });
</script>