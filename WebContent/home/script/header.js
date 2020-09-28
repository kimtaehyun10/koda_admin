//정보 변경창 이동
function changeInfo(){
    
    gfn_openPop(
            {
                url : "./changeInfo.do",
                name : "changeInfo",
                width : 600,
                height : 200,
                scrollbars : "yes",
                resizable : "no",
                param:{},
                callback : ""
            });
    
}

//비밀번호, 생년월일 변경
function doSave(check){
    var msg ='';
    var name = '';
    if(check == 'pw'){
        msg = "비밀번호를 변경 하시겠습니까?.";
        if (!confirm(msg)) {
            return;
        }else if ($.trim($('#prev_pw').val()) == '') {
            alert("이전비밀번호를 입력하세요");
            $('#prev_pw').focus();
            return false;
        }else if ($.trim($('#new_pw').val()) == '') {
            alert("신규비밀번호 입력 하세요");
            $('#new_pw').focus();
            return false;
        }else if ($.trim($('#check_pw').val()) == '') {
            alert("비밀번호확인을 입력 하세요");
            $('#check_pw').focus();
            return false;
        }else {
            var rsaPublicKeyModulus = $.trim($("#rsaPublicKeyModulus").val());
            var rsaPublicKeyExponent = $.trim($("#rsaPublicKeyExponent").val());
            var userPw = $.trim($('#new_pw').val());
            
            try {
                encryptedFormDate(userPw,    "securedPwd",    rsaPublicKeyModulus, rsaPublicKeyExponent);
             } catch(err) {
                alert(err);
                return false;
             }
        }
        
        if($.trim($('#new_pw').val()) != $.trim($('#check_pw').val())){
            alert("신규비밀번호와 비밀번호확인이 일치 하지 않습니다.");
            $('#check_pw').focus();
            return false;
        }
        name = '#frm';
    }else if(check == 'birth'){
        msg = "생년월일을 변경 하시겠습니까?.";
        if (!confirm(msg)) {
            return;
        }else if ($.trim($('#selecet_year').val()) == '') {
            alert("년을 선택하세요.");
            $('#selecet_year').focus();
            return false;
        }else if ($.trim($('#selecet_month').val()) == '') {
            alert("월을 선택하세요");
            $('#selecet_month').focus();
            return false;
        }else if ($.trim($('#selecet_day').val()) == '') {
            alert("일을 선택하세요");
            $('#selecet_day').focus();
            return false;
        }else {
            var rsaPublicKeyModulus = $.trim($("#rsaPublicKeyModulus").val());
            var rsaPublicKeyExponent = $.trim($("#rsaPublicKeyExponent").val());
            var birthYear    = $.trim($('#selecet_year').val());
            var birthMonth   = $.trim($('#selecet_month').val());
            var birthDay     = $.trim($('#selecet_day').val());
            
            try {
                encryptedFormDate(birthYear,    "securedBirthYear",     rsaPublicKeyModulus, rsaPublicKeyExponent);
                encryptedFormDate(birthMonth,   "securedBirthMonth",    rsaPublicKeyModulus, rsaPublicKeyExponent);
                encryptedFormDate(birthDay,     "securedBirthDay",      rsaPublicKeyModulus, rsaPublicKeyExponent);
             } catch(err) {
                alert(err);
                return false;
             }
        }
        name = '#frmS';
    }else if(check == 'etc'){
        msg = "기타 회원정보를 변경 하시겠습니까?.";
        if (!confirm(msg)) {
            return;
        }else if ($.trim($('#cell1').val()) == '') {
            alert("휴대전화번호를 입력하세요.");
            $('#cell1').focus();
            return false;
        }else if ($.trim($('#cell2').val()) == '') {
            alert("휴대전화번호를 입력하세요.");
            $('#cell2').focus();
            return false;
        }else if ($.trim($('#cell3').val()) == '') {
            alert("휴대전화번호를 입력하세요.");
            $('#cell3').focus();
            return false;
        }else {
            var rsaPublicKeyModulus = $.trim($("#rsaPublicKeyModulus").val());
            var rsaPublicKeyExponent = $.trim($("#rsaPublicKeyExponent").val());
            var cell01       = $.trim($('#cell1').val());
            var cell02       = $.trim($('#cell2').val());
            var cell03       = $.trim($('#cell3').val());
            
            try {
                encryptedFormDate(cell01,       "securedCell01",        rsaPublicKeyModulus, rsaPublicKeyExponent);
                encryptedFormDate(cell02,       "securedCell02",        rsaPublicKeyModulus, rsaPublicKeyExponent);
                encryptedFormDate(cell03,       "securedCell03",        rsaPublicKeyModulus, rsaPublicKeyExponent);
             } catch(err) {
                alert(err);
                return false;
             }
        }
        name = '#frmU';
    }else {
        return;
    }
    
    var ajax_set =
    { 
       url:"./changeInfoIUD.do",
//       param:"check="+check,
       form_name: name,
       return_fn:function(jdata){set_changeInfo(jdata,check);}      
    };
    wini_ajaxSubmit(ajax_set);
}

function set_changeInfo(jdata,check) {
    
    if (jdata.errCd =='-1') {
        alert(jdata.errMsg);
    } else {
        if(check =='pw'){
            $('#prev_pw').val('');
            $('#new_pw').val('');
            $('#check_pw').val('');
            if (confirm("비밀번호가 변경 되었습니다. 창을 닫으시겠습니까?")) {
                window.close();
            }
        }else if(check =='birth'){
            if (confirm("생년월일이 변경 되었습니다. 창을 닫으시겠습니까?")) {
                window.close();
            }
        }else if(check =='etc') {
            if (confirm("기타 회원정보가 변경 되었습니다. 창을 닫으시겠습니까?")) {
                window.close();
            }
        }
    }  
}

//RSA 암호화 처리
function encryptedFormDate(Id, securedId, rsaPublicKeyModulus, rsaPpublicKeyExponent) {
    var rsa = new RSAKey();
    var securedData = "";
    rsa.setPublic(rsaPublicKeyModulus, rsaPpublicKeyExponent);

    if(Id != null && Id != ""){
        // RSA로 암호화한다.
        securedData = rsa.encrypt(Id);
    }else{
        securedData = '';
    }
    $('#'+securedId).val(securedData);
}

//이메일 주소 선택 
function fn_email(form, obj){
    
    form.email_juso.value = (obj[obj.selectedIndex].value == "" ? form.email_juso.value : obj[obj.selectedIndex].value);
}