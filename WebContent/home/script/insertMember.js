var idCheck = 'N';  //아이디중복체크 여부
var regnoCheck = 'N';  //사원번호 중복체크 여부
    
/*회원가입 화면 이동*/
function joinMember() {
    
//    if(confirm("※ 인사정보시스템에 ID가 없으신 직원 및 무기계약직이나\n 계약직만 회원가입하시기 바랍니다.")){
    
        gfn_openPop(
                {
                    url : "./joinMember.do",
                    name : "joinMember",
                    width : 850,
                    height : 450,
                    scrollbars : "yes",
                    resizable : "no",
                    param:{},
                    callback : ""
                });
//    }
}

/**********************회원가입*************************/
function insertMember(){
    if(confirm("회원가입 하시겠습니까?")){
//        var tr = false;
//        tr =  password_check();
//        if(tr == false){
//            return;
//        }else if(tr == true){
            
            if(!t_checkNotNull()){
                return;
            }
            
            var ajax_set = 
            { 
               form_name:"#frm",
               url:"./insertMember.do",
               return_fn:function(jdata){submit_result(jdata);}    
            };
            wini_ajaxSubmit(ajax_set);
//        }
    }
}

//결과
function submit_result(jdata) {
    if (jdata.errCd != null && jdata.errCd != "") {
        alert(jdata.errMsg);
    }else {
        alert("회원가입이 완료되었습니다.");
        doClose();
    }       
}

/**
 *  유효성 검사
 */
   function t_checkNotNull() {  //유효성 검사
    
   if (idCheck == 'N') {
       alert("사용불가능한 아이디 이거나 중복체크를 하지 않았습니다.");
       $('#user_id').focus();
       return false;
   }else if (regnoCheck == 'N') {
       alert("사용불가능한 사원번호 이거나 중복체크를 하지 않았습니다.");
       $('#regno').focus();
       return false;
   }else if($.trim($('#user_pw').val()) != $.trim($('#user_pw_identify').val())){
       alert("신규비밀번호와 비밀번호확인이 일치 하지 않습니다.");
       $('#user_pw_identify').focus();
       return false;
   }else if ($.trim($('#user_name').val()) == '') {
       alert("이름을입력하세요.");
       $('#user_name').focus();
       return false;
   }else if ($.trim($('#user_id').val()) == '') {
       alert("아이디를 입력하세요");
       $('#user_id').focus();
       return false;
   }else if($('#user_id').val() != $('#id_check').val()){
       alert('아이디 중복확인을 하세요.');
       return;
   }else if ($.trim($('#regno').val()) == '') {
       alert("사원번호를 입력하세요");
       $('#regno').focus();
       return false;
   }else if($('#regno').val() != $('#regno_check').val()){
       alert('사원번호 중복확인을 하세요.');
       $('#regno').focus();
       return;
   }else if ($.trim($('#user_pw').val()) == '') {
       alert("비밀번호를입력하세요.");
       $('#user_pw').focus();
       return false;
   }else if ($.trim($('#user_pw_identify').val()) == '') {
       alert("비밀번호확인을 입력하세요.");
       $('#user_pw_identify').focus();
       return false;
   }
//   else if ($.trim($('#srch_ward_id').val()) == '') {
//       alert("서를 선택하세요.");
//       $('#srch_ward_id').focus();
//       return false;
//   }else if ($.trim($('#srch_ward_id_detail').val()) == '') {
//       alert("센터를 선택하세요.");
//       $('#srch_ward_id_detail').focus();
//       return false;
//   }else if ($.trim($('#etc_addr').val()) == '') {
//       alert("주소를 입력하세요.");
//       $('#etc_addr').focus();
//       return false;
//   }
   else{
       
       var rsaPublicKeyModulus = $.trim($("#rsaPublicKeyModulus").val());
       var rsaPublicKeyExponent = $.trim($("#rsaPublicKeyExponent").val());
       var userName     = $.trim($('#user_name').val());
       var userId       = $.trim($('#user_id').val());
       var regno      = $.trim($('#regno').val());
       var userPw       = $.trim($('#user_pw').val());
//       var upwardId     = $.trim($('#srch_ward_id').val());
//       var wardId       = $.trim($('#srch_ward_id_detail').val());
//       var etcAddr      = $.trim($('#etc_addr').val());
       var cell01       = $.trim($('#cell1').val());
       var cell02       = $.trim($('#cell2').val());
       var cell03       = $.trim($('#cell3').val());
//       var hometel1     = $.trim($('#hometel1').val());
//       var hometel2     = $.trim($('#hometel2').val());
//       var hometel3     = $.trim($('#hometel3').val());
       var extTel       = $.trim($('#ext_tel').val());
//       var coTel        = $.trim($('#co_tel').val());
//       var faxTel       = $.trim($('#fax_tel').val());
//       var titleCd      = $.trim($('#title_cd').val());
//       var workSectionCd = $.trim($('#work_section_cd').val());
//       var workCd        = $.trim($('#work_cd').val());
       var email         = $.trim($('#email').val());
       var etcAddr         = $.trim($('#etc_addr').val());
       
       try {
           encryptedFormDate(userName,      "securedUserName",      rsaPublicKeyModulus, rsaPublicKeyExponent);
           encryptedFormDate(userId,        "securedUserId",        rsaPublicKeyModulus, rsaPublicKeyExponent);
           encryptedFormDate(regno,         "securedRegno",         rsaPublicKeyModulus, rsaPublicKeyExponent);
           encryptedFormDate(userPw,        "securedPwd",           rsaPublicKeyModulus, rsaPublicKeyExponent);
//           encryptedFormDate(upwardId,      "securedUpWardId",      rsaPublicKeyModulus, rsaPublicKeyExponent);
//           encryptedFormDate(wardId,        "securedWardId",        rsaPublicKeyModulus, rsaPublicKeyExponent);
//           encryptedFormDate(etcAddr,       "securedEtcAddr",       rsaPublicKeyModulus, rsaPublicKeyExponent);
           encryptedFormDate(cell01,        "securedCell01",        rsaPublicKeyModulus, rsaPublicKeyExponent);
           encryptedFormDate(cell02,        "securedCell02",        rsaPublicKeyModulus, rsaPublicKeyExponent);
           encryptedFormDate(cell03,        "securedCell03",        rsaPublicKeyModulus, rsaPublicKeyExponent);
//           encryptedFormDate(hometel1,      "securedHomeTel01",     rsaPublicKeyModulus, rsaPublicKeyExponent);
//           encryptedFormDate(hometel2,      "securedHomeTel02",     rsaPublicKeyModulus, rsaPublicKeyExponent);
//           encryptedFormDate(hometel3,      "securedHomeTel03",     rsaPublicKeyModulus, rsaPublicKeyExponent);
           encryptedFormDate(extTel,        "securedExtTel",        rsaPublicKeyModulus, rsaPublicKeyExponent);
//           encryptedFormDate(coTel,         "securedCoTel",         rsaPublicKeyModulus, rsaPublicKeyExponent);
//           encryptedFormDate(faxTel,        "securedFaxTel",        rsaPublicKeyModulus, rsaPublicKeyExponent);
//           encryptedFormDate(titleCd,       "securedTitleCd",       rsaPublicKeyModulus, rsaPublicKeyExponent);
//           encryptedFormDate(workSectionCd, "securedWorkSectionCd", rsaPublicKeyModulus, rsaPublicKeyExponent);
//           encryptedFormDate(workCd,        "securedWorkCd",        rsaPublicKeyModulus, rsaPublicKeyExponent);
           encryptedFormDate(email,         "securedEmail",         rsaPublicKeyModulus, rsaPublicKeyExponent);
           encryptedFormDate(etcAddr,       "securedEtcAddr",       rsaPublicKeyModulus, rsaPublicKeyExponent);
            } catch(err) {
               alert(err);
               return false;
            }
       }
       return true;
    }
   
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
    
/**********************아이디중복체크*************************/
function fn_idCheck(){
//    if($('#user_id').val().trim().length < 6 ) { alert('영문 또는 숫자 6~14자 이내로 입력하세요.'); $('#user_id').focus();  return;}
    idCheck = 'N';
    var user_id = $('#user_id').val();
    if(user_id == null || user_id ==''){ 
        alert('아이디를 입력하세요.'); 
        $('#user_id').focus(); 
        return; 
    }
    var ajax_set = 
    { 
        url:"sys/idChecking.do",
        param:"user_id="+user_id,  
        return_fn:function(jdata){idCheck_result(jdata,user_id);}      
    };
    winigrid_getDetail(ajax_set);
}

function idCheck_result(jdata,user_id) {
    if (jdata.errCd != null && jdata.errCd != "") {
        alert(jdata.errMsg);
        return;
    } else {
        var check = jdata.rows[0];
        if(check.idCheck != 0){
            alert("같은 아이디가 이미 존재 합니다.");
            $('#user_id').val('');
            $('#user_id').focus(); 
            idCheck = 'N';
            return;
        }else if(check.idCheck == 0){
            alert("사용가능한 아이디 입니다.");
            $('#id_check').val(user_id);
            idCheck = 'Y';
            return;
        }
    }  
}

/**********************사원번호 중복체크*************************/
function fn_regnoCheck(){
//    if($('#user_id').val().trim().length < 6 ) { alert('영문 또는 숫자 6~14자 이내로 입력하세요.'); $('#user_id').focus();  return;}
    regnoCheck = 'N';
    var regno = 'Htec-'+$('#regno').val();
    var ori_regno = $('#regno').val();
    if(regno == null || regno ==''){ 
        alert('사원번호를 입력하세요.'); 
        $('#regno').focus(); 
        return; 
    }
    var ajax_set = 
    { 
        url:"sys/regnoChecking.do",
        param:"regno="+regno,
        return_fn:function(jdata){regno_result(jdata,ori_regno);}      
    };
    winigrid_getDetail(ajax_set);
}

function regno_result(jdata,regno) {
    if (jdata.errCd != null && jdata.errCd != "") {
        alert(jdata.errMsg);
        return;
    } else {
        var check = jdata.rows[0];
        if(check.regnoCheck != 0){
            alert("사용중인 사원번호 입니다.");
            $('#regno').val('');
            $('#regno').focus(); 
            regnoCheck = 'N';
            return;
        }else if(check.regnoCheck == 0){
            alert("사용가능한 사원번호 입니다.");
            $('#regno_check').val(regno);
            regnoCheck = 'Y';
            return;
        }
    }  
}

//이메일 주소 선택 
function fn_email(form, obj){
    
    form.email_juso.value = (obj[obj.selectedIndex].value == "" ? form.email_juso.value : obj[obj.selectedIndex].value);
}

function doClose(){
    opener.location.reload();
    window.close();
}

