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
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>한국장기조직기증원 대국민소통사업단</title>
    <meta name="description" content="대국민소통사업단 소개, 기증과정안내, 문화콘텐츠 안내">

    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/home/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/home/css/style.css" rel="stylesheet">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>


<div class="container">
    <div class="row">
        <div id="right_content">
            <div class="top_title">
                <h2>절차가 완료 되었습니다.</h2>
            </div>
            <div class="col-md-12" >
                <label style="margin-top: 50px; font-size:16px; ">
                </label>
            </div>
            <div class="col-md-12 text-center">
            </div>
        </div>
    </div>
</div>


<script src="${pageContext.request.contextPath}/home/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/home/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/home/js/SWJSObjectSrc.min.js" type="text/javascript"></script>

<script type="text/javascript">
    /*
    window.wallet = {};
    window.wallet.downloadCard = function(a) {
        alert(a);
    }
    window.wallet.showCardDetail = function(a) {
        alert(a);
    }
    window.wallet.finish = function() {
        alert("3");
    }*/

    function downloadSuccess() {

    }
    
    function downloadFail() {

    }
    $(document).ready(function() {
        window.wallet.downloadCard("{\"card_id\":\"11013\", \"br\":\"0\", \"ch\":\"0\", \"successCallbackJS\":\"downloadSuccess()\",\"failCallbackJS\":\"downloadFail()\"}");
        window.wallet.showCardDetail("{\"card_id\":\"11013\"}");
        window.wallet.finish();
    });

</script>

</body>
</html>
