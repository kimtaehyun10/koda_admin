<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader("Expires",0);
%>

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
    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <link href="${pageContext.request.contextPath}/common/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/common/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
    <!-- END GLOBAL MANDATORY STYLES -->
    <!-- BEGIN THEME GLOBAL STYLES -->
    <link href="${pageContext.request.contextPath}/common/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
    <link href="${pageContext.request.contextPath}/common/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
    <!-- END THEME GLOBAL STYLES -->
    <!-- BEGIN THEME LAYOUT STYLES -->
    <link href="${pageContext.request.contextPath}/common/layouts/layout/css/layout.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/common/layouts/layout/css/themes/darkblue.min.css" rel="stylesheet" type="text/css" id="style_color" />
    <link href="${pageContext.request.contextPath}/common/layouts/layout/css/custom.min.css" rel="stylesheet" type="text/css" />
    <!-- END THEME LAYOUT STYLES -->
    <link href="${pageContext.request.contextPath}/common/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/common/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/common/global/plugins/select2/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/common/pages/css/login.min.css" rel="stylesheet" type="text/css" />
</head>
<body class="login">
    <div class="logo">
        <h2>한국장기조직기증원 관리자페이지</h2>
    </div>
    <div class="content">
        <!-- BEGIN LOGIN FORM -->
        <form name="frm" id="frm" method="post" onsubmit="return false;" action="">        
            <h4 class="form-title font-gree text-align-center">관리자 로그인</h4>
            <div class="form-group">
                <label class="control-label visible-ie8 visible-ie9">아이디</label>
                <input class="form-control form-control-solid placeholder-no-fix" type="text" autocomplete="off" placeholder="아이디" name="user_id" id="user_id"/> 
            </div>
            <div class="form-group">
                <label class="control-label visible-ie8 visible-ie9">비밀번호</label>
                <input class="form-control form-control-solid placeholder-no-fix" type="password" autocomplete="off" placeholder="비밀번호" name="pwd" id="pwd" /> 
            </div>            
            <%-- <div class="form-group">
                <label class="control-label visible-ie8 visible-ie9">검정코드</label>
                <input class="form-control form-control-solid placeholder-no-fix" type="text" autocomplete="off" placeholder="Captcha" name="captcha" id="captcha" style="width:60%"/> <img src="<c:url value="login/code.do"/>" onclick="this.src='<?php echo site_url('login/code').'/'?> '+Math.random();"/>               
                <h4 class="form-title font-gree text-align-center"></h4>
            </div> --%>
            <div id="loginCaptcha" class="loginCaptchaInput" style="display: none" >
		          <ul>
		            <li style="margin-top: 10px;">비밀번호를 5회 이상 잘못 입력하면, 정보보호를 위해<br/>자동입력방지문자를 함께 입력하셔야 합니다. </li>
		              <li><img id="spamCaptchaimg" alt="자동등록방지코드" src="${pageContext.request.contextPath}/spamCaptcha.png" class="image"/> <br/></li>
		              <li style="margin-bottom: 5px;"><label for="captchaInput">위 이미지를 보이는 대로 입력해주세요.</label></li>
		              <li><input type="text" name="captchaInput" id="captchaInput" class="captchaText" style="ime-mode:disabled;" value="자동입력방지문자" /></li>
		              <li><a href="javascript:void(0);" onclick="fn_replaceSpamCaptchaimg();" class="atag" >[이미지 새로고침]</a></li>
		          </ul>
		      </div>
            <div class="form-actions" id="divLogin">
            	<input type="checkbox" id="checkId"  name="checkId" tabindex="6" checked="checked" style="width: 20px; height: 20px; border: 0px; background: #ffffff"/><a href="#" id="b_id_save" class="id_Btn" title="ID저장"><label for="checkId">아이디 저장</label></a>
                <input type="button" class="btn green uppercase" name="submit" id="login" value="로그인" style="float:right;">                
            </div>
            <div id="divAuth" style="display:none;">
            	<h4 class="form-title font-gree text-align-center">SMS 인증</h4>
	            <div class="form-group">
	                <label class="control-label visible-ie8 visible-ie9">인증번호</label>
	                <input class="form-control form-control-solid placeholder-no-fix" type="password" autocomplete="off" placeholder="인증번호" name="auth_num" id="auth_num" /> 
	            </div>
	            <div class="form-actions">            	
	                <input type="button" class="btn green uppercase" name="submit" id="btnAuth" value="휴대폰 인증" style="float:right;">                
	            </div>
            </div>
            
        </form>
        <form name="frm2" id="frm2" method="post" onsubmit="return false;" action="">        
	        <input type="hidden" id="rsaPublicKeyModulus" name="rsaPublicKeyModulus" value="${publicKeyMap.modulus}" />
	        <input type="hidden" id="rsaPublicKeyExponent" name="rsaPublicKeyExponent" value="${publicKeyMap.exponent}" />
	        <input type="hidden" id="securedUserId" name="securedUserId" value="" />
	        <input type="hidden" id="securedPwd" name="securedPwd" value="" />
	        <input type="hidden" id="captchaInputVal" name="captchaInputVal" value="" />
	        <input type="hidden" id="captchaInputYn" name="captchaInputYn" value="" />            
	    </form>
    </div>

<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/rsa/jsbn.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/rsa/rsa.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/rsa/prng4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/rsa/rng.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/jquery1.9/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/jquery1.9/jquery-ui-1.10.3.custom.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/jquery1.9/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/jquery1.9/jquery.blockUI.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/common/webco_default.1.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/login/login.js"></script>
<script type="text/javascript">
    <!--
    /********************** 자동입력방지 이미지 새로고침 *************************/
    function fn_replaceSpamCaptchaimg() {
        document.frm.spamCaptchaimg.src = "${pageContext.request.contextPath}/spamCaptcha.png?id="+Math.random();
        
    } 
    //-->    
</script>
<script type="text/javascript">
$(function() {
	$('#pwd').on('keyup', function(e) {
		e.preventDefault();
		if(e.keyCode == '13') {
			$('#login').trigger('click');
		}
	});
});
</script>
</body>
</html>





