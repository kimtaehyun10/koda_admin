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
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/common/global/plugins/amcharts/amcharts/plugins/export/export.css" rel="stylesheet" type="text/css" media="all"/>
<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">
<c:import url="/webMenu.do" charEncoding="UTF-8"></c:import>
<!-- BEGIN CONTENT -->
<div id="page_content" class="page-content-wrapper">
<!-- BEGIN CONTENT BODY -->
<div class="page-content">
<!-- BEGIN PAGE HEADER-->
<!-- BEGIN PAGE TITLE-->
<div class="row">
    <div class="col-md-7">
        <h1 class="page-title"> 대시보드</h1>
    </div>
    <div class="col-md-5">
        <!--<button type="button" class="btn btn-sm btn-circle blue btn-outline page-title-element btn-print hidden-print">인쇄</button>-->
        <!--<button type="button" class="btn btn-sm btn-circle green page-title-element btn-export">내보내기</button>-->
    </div>
</div>
<!-- END PAGE TITLE-->
<!-- END PAGE HEADER-->
<input id="status" name="status" type="hidden" value="1">
<div class="row">
    <div class="col-md-12">
        <div class="col-md-3 dashboard-display-1" style="">
            <div class="col-md-6 dashboard-display-upper">
                <span class="vertical-align">금일 방문현황</span>
            </div>
            <div class="col-md-6 dashboard-display-upper">
                <span class="pull-right vertical-align" style="padding-left:7px;">명</span>
                <span class="pull-right vertical-align font-green-sharp" style="font-size: 22px;"><fmt:formatNumber value="${today_visit_count}" pattern="#,###" /></span>
            </div>
            <div class="col-md-12" >
                <hr class="green-sharp">
            </div>
            <div class="col-md-6 dashboard-display-lower">
                <span class="vertical-align">금일 서약현황</span>
            </div>
            <div class="col-md-6 dashboard-display-lower">
                <span class="pull-right vertical-align" style="padding-left:7px;">명</span>
                <span class="pull-right vertical-align font-green-sharp" style="font-size: 22px;"><fmt:formatNumber value="${today_pledge_count}" pattern="#,###" /></span>
            </div>
        </div>
        <div class="col-md-3 dashboard-display-1" style="">
            <div class="col-md-6 dashboard-display-upper">
                <span class="vertical-align">주간 방문현황</span>
            </div>
            <div class="col-md-6 dashboard-display-upper">
                <span class="pull-right vertical-align" style="padding-left:7px;">명</span>
                <span class="pull-right vertical-align font-red-flamingo" style="font-size: 22px;"><fmt:formatNumber value="${week_visit_count}" pattern="#,###" /></span>
            </div>
            <div class="col-md-12" >
                <hr class="red-flamingo">
            </div>
            <div class="col-md-6 dashboard-display-lower">
                <span class="vertical-align">주간 서약현황</span>
            </div>
            <div class="col-md-6 dashboard-display-lower">
                <span class="pull-right vertical-align" style="padding-left:7px;">명</span>
                <span class="pull-right vertical-align font-red-flamingo" style="font-size: 22px;"><fmt:formatNumber value="${week_pledge_count}" pattern="#,###" /></span>
            </div>
        </div>
        <div class="col-md-3 dashboard-display-1" style="">
            <div class="col-md-6 dashboard-display-upper">
                <span class="vertical-align">월간 방문현황</span>
            </div>
            <div class="col-md-6 dashboard-display-upper">
                <span class="pull-right vertical-align" style="padding-left:7px;">명</span>
                <span class="pull-right vertical-align font-blue-madison" style="font-size: 22px;"><fmt:formatNumber value="${month_visit_count}" pattern="#,###" /></span>
            </div>
            <div class="col-md-12" >
                <hr class="blue-madison">
            </div>
            <div class="col-md-6 dashboard-display-lower">
                <span class="vertical-align">월간 서약현황</span>
            </div>
            <div class="col-md-6 dashboard-display-lower">
                <span class="pull-right vertical-align" style="padding-left:7px;">명</span>
                <span class="pull-right vertical-align font-blue-madison" style="font-size: 22px;"><fmt:formatNumber value="${month_pledge_count}" pattern="#,###" /></span>
            </div>
        </div>
        <div class="col-md-3 dashboard-display-1" style="">
            <div class="col-md-6 dashboard-display-upper">
                <span class="vertical-align">연간 방문현황</span>
            </div>
            <div class="col-md-6 dashboard-display-upper">
                <span class="pull-right vertical-align" style="padding-left:7px;">명</span>
                <span class="pull-right vertical-align font-purple-plum" style="font-size: 22px;"><fmt:formatNumber value="${total_visit_count}" pattern="#,###" /></span>
            </div>
            <div class="col-md-12" >
                <hr class="purple-plum">
            </div>
            <div class="col-md-6 dashboard-display-lower">
                <span class="vertical-align">연간 서약현황</span>
            </div>
            <div class="col-md-6 dashboard-display-lower">
                <span class="pull-right vertical-align" style="padding-left:7px;">명</span>
                <span class="pull-right vertical-align font-purple-plum" style="font-size: 22px;"><fmt:formatNumber value="${total_pledge_count}" pattern="#,###" /></span>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div class="col-md-6 dashboard-chart-box">
            <div class="portlet light ">
                <div class="portlet-title">
                    <div class="caption">
                        <span class="caption-subject bold uppercase font-dark">주간 서약/방문 통계</span>
                        <span class="caption-helper">한주간 일별서약자/방문자 수치입니다.</span>
                    </div>
                </div>
                <div class="portlet-body">
                    <div id="dashboard_column_chart_1" class="dashboard_column_chart"></div>
                    <p class="bold uppercase font-dark">주간 도달율</p>
                    <span class="title-helper">주간 서약자수/방문자수 백분율 값입니다.</span>
                    <table class="table table-no-bordered dashboard_state_table">
                        <tbody>
                            <tr style="height:7px;"></tr>
                            <tr>
                                <td class="col-md-3 vertical-align">서약자 수</td>
                                <td class="col-md-3 text-align-right right_line"><span class="font-green-sharp vertical-align" style="font-size: 22px;"><fmt:formatNumber value="${week_pledge_count}" pattern="#,###" />&nbsp;명</span></td>
                                <td rowspan="2" class="col-md-6"><span class="font-green-sharp vertical-align" style="font-size: 30px;">${week_pledge_visit_rate}&nbsp;%</span></td>
                            </tr>
                            <tr>
                                <td class="col-md-3 vertical-align">방문자 수</td>
                                <td class="col-md-3 text-align-right right_line"><span class="font-green-sharp vertical-align" style="font-size: 22px;"><fmt:formatNumber value="${week_visit_count}" pattern="#,###" />&nbsp;명</span></td>
                            </tr>
                            <tr style="height:7px;"></tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-md-6 dashboard-chart-box">
            <div class="portlet light ">
                <div class="portlet-title">
                    <div class="caption">
                        <span class="caption-subject bold uppercase font-dark">월간 서약/방문 통계</span>
                        <span class="caption-helper">한달간 일별서약자/방문자 수치입니다.</span>
                    </div>
                </div>
                <div class="portlet-body">
                    <div id="dashboard_column_chart_2" class="dashboard_column_chart"></div>
                    <p class="bold uppercase font-dark">월간 도달율</p>
                    <span class="title-helper">월간 서약자수/방문자수 백분율 값입니다.</span>
                    <table class="table table-no-bordered dashboard_state_table">
                        <tbody>
                        <tr style="height:7px;"></tr>
                        <tr>
                            <td class="col-md-3 vertical-align">서약자 수</td>
                            <td class="col-md-3 text-align-right right_line"><span class="font-green-sharp vertical-align" style="font-size: 22px;"><fmt:formatNumber value="${month_pledge_count}" pattern="#,###" />&nbsp;명</span></td>
                            <td rowspan="2" class="col-md-6"><span class="font-green-sharp vertical-align" style="font-size: 30px;">${month_pledge_visit_rate}&nbsp;%</span></td>
                        </tr>
                        <tr>
                            <td class="col-md-3 vertical-align">방문자 수</td>
                            <td class="col-md-3 text-align-right right_line"><span class="font-green-sharp vertical-align" style="font-size: 22px;"><fmt:formatNumber value="${month_visit_count}" pattern="#,###" />&nbsp;명</span></td>
                        </tr>
                        <tr style="height:7px;"></tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
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
<script src="${pageContext.request.contextPath}/common/global/plugins/amcharts/amcharts/serial.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/amcharts/amcharts/plugins/export/export.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/amcharts/amcharts/themes/light.js" type="text/javascript"></script>

<script language="JavaScript" type="text/javascript">
// Conversion Data from PHP to Javascript
<c:choose>
	<c:when test="${fn:length(dashboard_column_chart_1_data) > 0}">
var dashboard_column_chart_1_data = ${dashboard_column_chart_1_data};
	</c:when>
	<c:otherwise>
var dashboard_column_chart_1_data = null;
	</c:otherwise>
</c:choose>
<c:choose>
<c:when test="${fn:length(dashboard_column_chart_2_data) > 0}">
var dashboard_column_chart_2_data = ${dashboard_column_chart_2_data};
</c:when>
<c:otherwise>
var dashboard_column_chart_2_data = null;
</c:otherwise>
</c:choose>
var dashboardChart = function() {
    var initDashboardColumnChart1 = function() {
        var dashboard_column_chart_1 = AmCharts.makeChart( "dashboard_column_chart_1", {
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

            "dataProvider": dashboard_column_chart_1_data,
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
        } );
    };
    var initDashboardColumnChart2 = function() {
        var dashboard_column_chart_2 = AmCharts.makeChart( "dashboard_column_chart_2", {
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

            "dataProvider": dashboard_column_chart_2_data,
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
        } );
    };
    return {
        //main function to initiate the module
        init: function() {
            initDashboardColumnChart1();
            initDashboardColumnChart2();
        }
    };

}();

function warning_delete() {
    if(confirm('이 항목을 삭제하시겠습니까? ')){
        return true;
    } else {
        return false;
    }
}

function getEnumKey(enum_name, enum_value) {
    var enum_object = enum_array[enum_name];
    var enum_key= 0;
    jQuery.each(enum_object, function(key, val) {
        if(val==enum_value){
            enum_key = key;
            return false;
        }
    });
    return enum_key;
}

function initValue() {

}

$(document).ready(function() {
    initValue();
    dashboardChart.init();

});
</script>


