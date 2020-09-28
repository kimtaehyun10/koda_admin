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
<script>
function formCheck() {
	var new_pwd = $('admin_new_pwd').val();
	var chk_new_pwd = $('confirm_admin_new_pwd').val();
	
	if(new_pwd.length < 9){
		alert("비밀번호는 9자리 이상으로 설정하셔야 합니다.");
		$('admin_new_pwd').focus();
		return false;
	}
	
	if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{9,20}$/.test(new_pwd) || new_pwd.indexOf(' ') > -1)  {
        alert('비밀번호는 숫자, 영문, 특수문자(!@#$%^*+=-) 조합으로 9~20자리를 사용해야 합니다.');
        return false;
	}


	if(/(\w)\1\1\1/.test(new_pwd))   {
		alert('비밀번호에 같은 문자를 4번 이상 사용하실 수 없습니다.');
		return false;
	}

	var SamePass_0 = 0; //동일문자 카운트
	var SamePass_1 = 0; //연속성(+) 카운드
	var SamePass_2 = 0; //연속성(-) 카운드
	var chr_pass_0;
	var chr_pass_1;

	for(var i=0; i < new_pwd.length; i++) {
		chr_pass_0 = new_pwd.charAt(i);
		chr_pass_1 = new_pwd.charAt(i+1);

		//동일문자 카운트
		if(chr_pass_0 == chr_pass_1) {
			SamePass_0 = SamePass_0 + 1;
		} // if

		//연속성(+) 카운드
		if(chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == 1) {
			SamePass_1 = SamePass_1 + 1;
		} // if

		//연속성(-) 카운드
		if(chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == -1) {
			SamePass_2 = SamePass_2 + 1;
		} // if
	} // for

	if(SamePass_0 > 3) {
		alert("비밀번호는 동일문자를 3번 이상 사용할 수 없습니다.");
		return false;
	} 

	if(SamePass_1 > 3 || SamePass_2 > 3 )  {
		alert("비밀번호는 연속된 문자열(123 또는 321, abc, cba 등)을\n 3자 이상 사용 할 수 없습니다.");
		return false;
	}
	
	if(new_pwd != chk_new_pwd) {
		alert("[비밀번호 확인] 비밀번호가 틀립니다.");
		return false;
	}
	return true;
}
</script>
<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">
<c:import url="/webMenu.do" charEncoding="UTF-8"></c:import>
<!-- BEGIN CONTENT -->
<div class="page-content-wrapper">
    <!-- BEGIN CONTENT BODY -->
    <div class="page-content">
       
        <!-- END PAGE HEADER-->
        <div class="row" style="margin-top: 70px;">
            <div class="col-md-1"></div>
            <div class="col-md-10 ">
                <!-- BEGIN SAMPLE FORM PORTLET-->
                <div class="portlet light bordered">
                    <div class="portlet-title">
                        <div class="caption">
                            <span class="caption-subject font-dark sbold uppercase">비밀번호 변경</span>
                        </div>
                    </div>
                    <div class="portlet-body form">
                        <form id="admin_edit_pwd" class="form-horizontal" role="form" method="post" enctype="multipart/form-data" action="<c:url value='/admin/updatePwd.do'/>">
                             <input type="hidden" class="form-control" value="${admin.admin_index}" name="admin_index" id="admin_index">
                            <div class="form-body">
                                <!--<div class="form-group">
                                    <label class="col-md-3 control-label">Admin Old Password</label>
                                    <div class="col-md-9">
                                        <input type="password" name="admin_password" id="admin_password" class="form-control" placeholder="Enter Old Password">
                                        
                                    </div>
                                </div>-->

                                <div class="form-group">
                                    <label class="col-md-2 control-label">새 비밀번호</label>
                                    <div class="col-md-9">
                                        <input type="password" name="admin_new_pwd" id="admin_new_pwd" class="form-control" placeholder="Enter New Password">
                                     
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="col-md-2 control-label">비밀번호 확인</label>
                                    <div class="col-md-9">
                                        <input type="password" name="confirm_admin_new_pwd" id="confirm_admin_new_pwd" class="form-control" placeholder="Enter Confirm New Password">
                                        
                                    </div>
                                </div>
                                
                            </div>   
                            <div class="form-actions">
                                <div class="row">
                                    <div class="col-md-offset-5 col-md-9">
                                        <input type="submit" class="btn green" type="submit" name="submit" id="submit" value="저장">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- END SAMPLE FORM PORTLET-->   
            </div>
        </div>  
    </div>
    <!-- END CONTENT BODY -->
</div>
<!-- END CONTENT -->
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>