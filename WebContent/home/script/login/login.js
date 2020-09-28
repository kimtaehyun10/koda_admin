var captchaInputYn = 'N';

$(function() {

    fnInit();
            
    $("#login").mouseover(function(){
    $("#login").css({"cursor":"pointer"});
    
    });
    
    $('#btnAuth').on('click', function(e) {
    	e.preventDefault();
    	if($.trim($("#auth_num").val())==''){
            $("#auth_num").focus();
            alert("로그인 인증번호를 입력해주세요.");
            return false;
        }
    	
    	var ajax_set = 
        {             
            form_name:"#frm",
            url:"./actionSmsAuthLogin.do",
            return_fn:function(jdata){doSmsAuthLoginResult(jdata);}
        };
        
        wini_ajaxSubmit(ajax_set, null);
    });
}); 


//로그인 후처리
function doSmsAuthLoginResult(jdata) {
     if (jdata.errCd == "0") {
         //MM_moveURL("/index.jsp");
         location.href = "./index.jsp";
     } else if (jdata.errCd == "-99") {
         alert("로그인 인증번호가 만료되었습니다. 다시 로그인 해주세요.");
         location.reload();
     } else {                 
        $('#auth_num').val('');
        $("#auth_num").focus();
        alert(jdata.errMsg);
        return;
     }
}

function fnInit() {
    
    getid(document.frm);
    // 포커스
    if ($("#user_id")[0].value != "") {
        $("#pwd")[0].focus();
    } else {
        $("#user_id")[0].focus();
    }
}

$("#login").click(function(){
    
    if($.trim($("#user_id").val())==''){
        $("#user_id").focus();
        alert("아이디를 입력해 주세요.");
        return false;
    }
    if($.trim($("#pwd").val())==''){
        $("#pwd").focus();
        alert("비밀번호를 입력해 주세요.");
        return false;
    }
    if(captchaInputYn == 'Y' && $.trim($("#captchaInput").val())==''){
        $("#captchaInput").focus();
        alert("자동입력방지문자를 입력해 주세요.");
        return false;
    }
    
    var userId = $.trim($("#user_id").val());
    var password = $.trim($("#pwd").val());
    var rsaPublicKeyModulus = $.trim($("#rsaPublicKeyModulus").val());
    var rsaPublicKeyExponent = $.trim($("#rsaPublicKeyExponent").val());
    
    try {
        encryptedForm(userId, password, rsaPublicKeyModulus, rsaPublicKeyExponent);
    } catch(err) {
        alert(err);
        return false;
    }
    
    if(captchaInputYn == 'Y'){
        var captchaInput = $.trim($("#captchaInput").val());
        $('#captchaInputVal').val(captchaInput);
        $('#captchaInputYn').val(captchaInputYn);
    };
    
    $("#user_id").val(userId);
    
    saveid(document.frm);
    
    var ajax_set = 
    {             
        form_name:"#frm2",
        url:"./actionLogin.do",
        return_fn:function(jdata){doLoginResult(jdata);}
    };
    
    wini_ajaxSubmit(ajax_set, null);
    
});

// 로그인 후처리
function doLoginResult(jdata) {
	 if (jdata.errCd == "00") {
		location.href = "./index.jsp";
	 } else if (jdata.errCd == "000") {
		 //alert("SMS 문자발송이 불가능하여 바로 로그인 됩니다.");
		location.href = "./index.jsp";
	 } else if (jdata.errCd == "0") {
         //MM_moveURL("/index.jsp");
         //location.reload();    	 
    	 $('#user_id').prop('readonly', true);
    	 $('#pwd').prop('readonly', true);
    	 $('#divAuth').show();
    	 $('#divLogin').hide();
    	 alert('등록된 휴대폰으로 인증번호를 전송하였습니다.\n인증번호 입력 후 로그인을 완료해주세요.');
         //location.href = "./index.jsp";
     } else if (jdata.errCd == "100") {
         alert("임시비밀번호로 로그인하셨습니다.\n 비밀번호를 변경하세요.");
         MM_moveURL("/index.jsp");
     } else {
         
         if(jdata.errCd == "-1"){
             location.reload();
         } else if(jdata.errCd == "-2"){
             location.reload();
         } else if(jdata.errCd == "1"){
             location.reload();
         } else if(jdata.errCd == "2"){
             location.reload();
         } else if(jdata.errCd == "5" || jdata.errCd == "6"){
             
            captchaInputYn = 'Y';
            fn_replaceSpamCaptchaimg();
            $('#captchaInput').val('');
            document.getElementById("loginCaptcha").style.display = "";
        }
        $('#pwd').val('');
        $("#pwd").focus();
        alert(jdata.errMsg);
        return;
     }
}

function encryptedForm(userId, password, rsaPublicKeyModulus, rsaPpublicKeyExponent) {
    var rsa = new RSAKey();
    rsa.setPublic(rsaPublicKeyModulus, rsaPpublicKeyExponent);

    // 사용자ID와 비밀번호를 RSA로 암호화한다.
    var securedUserId = rsa.encrypt(userId);
    var securedPwd = rsa.encrypt(password);

    $("#securedUserId").val(securedUserId);
    $("#securedPwd").val(securedPwd);
}


$("#b_id_save").click(function(){
    var c_obj = $("#checkId");
    if(c_obj.is(":checked")){
        c_obj.removeAttr("checked");
    } else {
        c_obj.prop("checked","checked");
    }
            
    return false;
});

function setCookie (name, value, expires) {
    document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
}

function getCookie(Name) {
    var search = Name + "="
    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
        offset = document.cookie.indexOf(search)
        if (offset != -1) { // 쿠키가 존재하면
            offset += search.length
            // set index of beginning of value
            end = document.cookie.indexOf(";", offset)
            // 쿠키 값의 마지막 위치 인덱스 번호 설정
            if (end == -1)
                end = document.cookie.length
            return unescape(document.cookie.substring(offset, end))
        }
    }
    return "";
}

function saveid(form) {
    var expdate = new Date();
    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
    if (form.checkId.checked)
        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
    else
        expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제
//    alert(form.user_id.value);    
    setCookie("websaveUsrId", form.user_id.value, expdate);
}

function getid(form) {
    form.user_id.value = getCookie("websaveUsrId");
    //form.checkId.checked = ((form.user_id.value = getCookie("saveid")) != "");
}

/*아이디 찾기 화면 이동*/
function moveSearchId() {
    
    openPop(
            {
                url : "./searchId.do",
                name : "searchId",
                width : 600,
                height : 450,
                scrollbars : "yes",
                resizable : "no",
                param:{},
                callback : ""
            });
}

/*회원가입 화면 이동*/
function joinMember() {
    
//    if(confirm("※ 인사정보시스템에 ID가 없으신 직원 및 무기계약직이나\n 계약직만 회원가입하시기 바랍니다.")){
    
        openPop(
                {
                    url : "./joinMember.do",
                    name : "joinMember",
                    width : 800,
                    height : 500,
                    scrollbars : "yes",
                    resizable : "no",
                    param:{},
                    callback : ""
                });
//    }
}

