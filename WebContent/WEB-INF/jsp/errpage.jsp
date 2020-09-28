<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<title>|| error page ||</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>

<script type="text/javascript">
<!--	
    function getCodeName(code, codename) {
        var errName;
        
        switch (code)
        {
            case 101:
                errName = "비밀번호가 일치하지 않습니다.";
                break;
            case 201:
                errName = "로그인을 하지 않았거나 해당화면에 대한 권한이 없습니다.";
                break; 
            case 301:
                errName = "등록을 실패하였습니다.";
                break;  
            case 302:
                errName = "수정을 실패하였습니다.";
                break;
            case 303:
                errName = "삭제를 실패하였습니다.";
                break;
            case 304:
                errName = "저장을 실패하였습니다.";
                break;
            case 305:
                errName = "동일한 관할구역이 존재합니다.";
                break;
            case 314:
                errName = "처리중 오류가 발생하였습니다.";
                break;
            case 401:
                errName = "잘못된 접근 경로 입니다.";
                break;  
            case 501:
                errName = codename+" 되었습니다.";
                break;
            case 999:
                errName = codename;
                break;                  
        }
    
        return errName;
    }

    <c:if test="${loginVO == null && msg_code == '201' }">
        goLogin();
    </c:if>
 
    alert(getCodeName(<c:out value='${msg_code}'/>, "<c:out value='${msg}'/>"));

    <c:if test="${loginVO != null }">
        history.go(-1);
    </c:if>
    
    function goLogin() {
        location.href = "${pageContext.request.contextPath}/";
    }
//-->
</script>

</body>
</html>


