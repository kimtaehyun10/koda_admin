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
	String inputYn = (request.getParameter("inputYn") != null ? request.getParameter("inputYn") : "");
	String roadFullAddr = (request.getParameter("roadFullAddr") != null ? request.getParameter("roadFullAddr") : "");
	String roadAddrPart1 = (request.getParameter("roadAddrPart1") != null ? request.getParameter("roadAddrPart1") : "");
	String roadAddrPart2 = (request.getParameter("roadAddrPart2") != null ? request.getParameter("roadAddrPart2") : "");
	String jibunAddr = (request.getParameter("jibunAddr") != null ? request.getParameter("jibunAddr") : "");
	String zipNo = (request.getParameter("zipNo") != null ? request.getParameter("zipNo") : "");
	String addrDetail = (request.getParameter("addrDetail") != null ? request.getParameter("addrDetail") : "");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath}/common/css/addrlink.css" rel="stylesheet" type="text/css" />
    <title>도로명주소 입력</title>
</head>
<script language="javascript">
    // opener관련 오류가 발생하는 경우 아래 주석을 해지하고, 사용자의 도메인정보를 입력합니다. ("주소입력화면 소스"도 동일하게 적용시켜야 합니다.)
    document.domain = "localhost"; // 나중에 도메인주소 변경하자
	
    function init(){
    	
        var url = location.href;
        var filter = "win16|win32|win64|mac|macintel";
        var confmKey = "";
        var formAction = "";
        if ( navigator.platform ) {
            if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) {
            //Mobile
                confmKey = "U01TX0FVVEgyMDE3MDYxOTE0Mzk1NTIxOTc1";
                formAction = "http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do";
            } else {
            // PC
                confmKey = "U01TX0FVVEgyMDE3MDYxMjE4MDExNDIxNzk2";
                formAction = "http://www.juso.go.kr/addrlink/addrLinkUrl.do";
            }
        }
        var resultType = "4"; // 도로명주소 검색결과 화면 출력내용, 1 : 도로명, 2 : 도로명+지번, 3 : 도로명+상세건물명, 4 : 도로명+지번+상세건물명
        // php.ini 에 short_open_tag 가 On 으로 설정되어 되어 있는 경우 아래 소스 코드 사용
        var inputYn= "<%=inputYn%>";
        // php.ini 에 short_open_tag 가 Off 으로 설정되어 되어 있는 경우 아래 소스 코드 사용
        // var inputYn= "<?php echo $ADDR['inputYn']; ?>";
        if(inputYn != "Y"){
        	
        	document.form.confmKey.value = confmKey;
            document.form.returnUrl.value = url;
            document.form.resultType.value = resultType;
            document.form.action= formAction; //인터넷망
            document.form.submit();
        }else{
        	if(opener == null || opener == undefined) opener = window.open("", "jusoPopup");
            opener.jusoCallBack("<%=roadFullAddr%>","<%=roadAddrPart1%>","<%=addrDetail%>","<%=roadAddrPart2%>","<%=jibunAddr%>","<%=zipNo%>");
            window.open("about:blank", "_self").close();
        }
    }
</script>
<body onload="init();">
<form id="form" name="form" method="post">
    <input type="hidden" id="confmKey" name="confmKey" value=""/>
    <input type="hidden" id="returnUrl" name="returnUrl" value=""/>
    <input type="hidden" id="resultType" name="resultType" value=""/>
    <!-- 해당시스템의 인코딩타입이 EUC-KR일경우에만 추가 START-->
    <!--input type="hidden" id="encodingType" name="encodingType" value="EUC-KR"/-->
    <!-- 해당시스템의 인코딩타입이 EUC-KR일경우에만 추가 END-->
</form>
</body>
</html>    