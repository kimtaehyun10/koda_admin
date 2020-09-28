<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="ajax" uri="http://ajaxtags.sourceforge.net/tags/ajaxtags"%>
<%@taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>비밀번호수정</title>
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
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/home/css/ui_layer.css"/>
</head>
<body>

<div class="wrap_popup">
    <div class="popupcontents">
     <input type="hidden" id="rsaPublicKeyModulus" name="rsaPublicKeyModulus" value="${publicKeyMap.modulus}" />
     <input type="hidden" id="rsaPublicKeyExponent" name="rsaPublicKeyExponent" value="${publicKeyMap.exponent}" />
     <form name="frm" id="frm" method="post" enctype="multipart/form-data" action="" onsubmit="return false;" >
        <input type="hidden" id="securedPwd" name="securedPwd" value="" />
        <input type="hidden" id="check" name="check" value="pw"/>
           <div>
               <span>비밀번호변경</span>
               <table class="tbl_type02" border="1" cellspacing="0" summary="검색결과">
                    <caption>
                         목록
                    </caption>
                    <colgroup>
                    <col width="130"/>
                    <col width=""/>
                    </colgroup>     
                    <tbody>
                        <tr>
                            <th><label for="prev_pw">이전비밀번호</label></th>
                            <td><input type="password" id="prev_pw" name="prev_pw" class="i_text" style="width:95%;ime-mode:active;" maxlength="20" /></td>
                        </tr>
                        <tr>
                            <th><label for="new_pw">신규비밀번호</label></th>
                            <td><input type="password" id="new_pw" name="new_pw" class="i_text" style="width:95%;ime-mode:active;" maxlength="20" /></td>
                        </tr>
                        <tr>
                            <th><label for="check_pw">비밀번호확인</label></th>
                            <td><input type="password" id="check_pw" name="check_pw" class="i_text" style="width:95%;ime-mode:active;" maxlength="20" /></td>
                        </tr>
                    </tbody>
               </table>
           </div>
     </form>
     <div class="btn_right" style="width: 94.5%">
        <div class="al_l m_l35">
            <a class="btn_tb01_blue" id="save" name="save" onclick="doSave('pw');">비밀번호변경</a>
            <a class="btn_tb01_red" onclick="javascript:window.close();">닫기</a>
        </div>
     </div>
 </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/rsa/jsbn.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/rsa/rsa.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/rsa/prng4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/rsa/rng.js"></script>  
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/jquery1.9/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/jquery1.9/jquery-ui-1.10.3.custom.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/jquery1.9/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/jquery1.9/jquery.blockUI.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/jquery1.9/ui/i18n/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/jquery1.9/jQuery.MaskedInput.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/ui/jquery.easyui.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/common/wini_grid-1.5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/common/wini_default.1.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/common/wini_cal.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/header.js"></script>
</body>
</html>
    