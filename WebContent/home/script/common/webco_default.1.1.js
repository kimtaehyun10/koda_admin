
// 조회 호출
function wini_getAjax(ajax_set) {
    
    $.ajax({
        type: "POST",
        url: ajax_set.url,
        data: ajax_set.param,
        processData: false,
        dataType: 'json',
        error: function(){
            alert('조회중 오류가 발생하였습니다.');
        },
        success: ajax_set.return_fn
    });
}


//등록, 수정, 삭제 등 트랜젝션 발생 시 사용
function wini_ajaxSubmit(ajax_set, c_firm) {
        
    if (c_firm != null && c_firm != "") {
        winigrid_submit_ingView(true);
        if (!confirm(c_firm)) {
            winigrid_submit_ingView(false);
            return;
        }
    }
    
    $(ajax_set.form_name).ajaxSubmit({ 
        type:"POST",
        dataType:'json',
        url:ajax_set.url, 
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        async:false,
        beforeSubmit : wini_beforeViewImg,
        complete: function() {
            wini_submit_ingView(false);
        },
        error: function(){            
            alert('처리중 오류가 발생하였습니다.');
            wini_submit_ingView(false);
        },
        success:ajax_set.return_fn
    });
}

// submit 전처리
function wini_beforeViewImg(formData, jqForm, options) {
    wini_submit_ingView(true);
}

//저장등 do_submitIUD 발생시 진행중 표시 화면
function wini_submit_ingView(flag){
    
    if (flag) {
        var h = $("body").height();
        $("#wini_submit_ing").css({height:h});
        $("#wini_submit_ing").show();
        $("#wini_window_mask_cont").show();
    } else {
        $("#wini_submit_ing").hide();
        $("#wini_window_mask_cont").hide();
    }
    
}

function MM_moveURL(url) { // v1.0
    location.href = url;
}

/**
 * 폰트 크기 조절
 */
//Font Size Zoom In & Out
var defaultsize = 9;
var resize = defaultsize;
var nowZoom = 100; 
var maxZoom = 200;
var minZoom = 80; 
 
function zoom_it(n) 
{ 
    var browser = checkBrowser();
    
    
    // msie(10버전에서는 지원하지 않음), chrome, safari, opera
    if (browser.name == "msie" || browser.name == "chrome"  
        || browser.name == "safari"  || browser.name == "opera" ) {
        
        if (n > 0 ) {
            if (nowZoom < maxZoom) 
            { 
                nowZoom += 10;  
            } 
            else 
            { 
                return; 
            } 
        } else if (n < 0 ) {
            if (nowZoom > minZoom) 
            { 
                nowZoom -= 10; 
            } 
            else 
            { 
                return; 
            }         
        } else {
            nowZoom = 100; 
        }
        
        try {
            
            if (n == 0) { // 일부 버튼이 사라지는 현상때문에 화면 새로고침
                location.reload();
            } else {
                document.body.style.zoom = nowZoom + "%";
            }
        } catch(err) {
            alert(err);
            return false;
        }
    } else { // 그외 브라우저
        
        var objs = document.getElementsByTagName("body").item(0);
        if (n != 0) { 
            if(7 < resize && resize < 16){
                resize += n;
                if(resize == 7){
                    resize += 1;
                }
                if(resize == 16){
                    resize -= 1;
                }
            }   
        } else {
            resize = defaultsize;
        }
        
        if(7 < resize && resize < 16){
            objs.style.fontSize = resize + "pt";
        }
        if(resize == 9){
            objs.style.fontSize = "0.75em";
        }
        
    }
    
} 

// 브라우저 버전 확인
function checkBrowser() {

    var a = navigator.userAgent.toLowerCase();
    var b,v;

    if(a.indexOf("safari/") > -1) {
     b = "safari";
     var s = a.indexOf("version/");
     var l = a.indexOf(" ", s);
     v = a.substring(s+8, l);
    }
    if(a.indexOf("chrome/") > -1) {
     b = "chrome";
     var ver = /[ \/]([\w.]+)/.exec(a)||[];
     v = ver[1];
    }
    if(a.indexOf("firefox/") > -1) {
     b = "firefox";
     var ver = /(?:.*? rv:([\w.]+)|)/.exec(a)||[];
     v = ver[1];
    }
    if(a.indexOf("opera/") > -1 || a.indexOf("opr/") > -1) {
     b = "opera";
     var ver = /(?:.*version|)[ \/]([\w.]+)/.exec(a)||[];
     v = ver[1];
    }
    if((a.indexOf("msie") > -1) || (a.indexOf(".net") > -1)) {
     b = "msie";
     var ver = /(?:.*? rv:([\w.]+))?/.exec(a)||[];
     if(ver[1])
      v = ver[1];
     else{
      var s = a.indexOf("msie");
      var l = a.indexOf(".", s);
      v = a.substring(s+4, l);
     }
    }
  
    return { name: b || "", version: v || 0};

}

// 바로가기 이동
function fn_goBaro(selectId)
{   
    var selectObj = document.getElementById(selectId);
    if(selectObj != null)
    {
        if(selectObj.selectedIndex <= 0)
        {
            alert("항목을 선택하세요.");
            selectObj.focus();
            return false;
        }
    }else
    {
        alert("링크 항목이 없습니다.");
        return false;
    }
    return true;
}

//바로가기 이동
function fn_emailpolicy() {   

    gfn_openPop({
        url : "/guide/emailpolicy.do",
        name : "emailpolicy",
        width : 380,
        height : 250,
        scrollbars : "no",
        resizable : "no",
        param : "",
        callback : ""   
    });
}


function containsCharsOnly(input,chars) {

    for (var inx = 0; inx < input.value.length; inx++) {

       if (chars.indexOf(input.value.charAt(inx)) == -1)

           return false;

    }

    return true;

}

/**
 * 전화번호 검사1
 */
function gfn_isNumDash(input) {
	
    var chars = "-0123456789";
    
    if (containsCharsOnly(input,chars) == false) {
	    alert("숫자와 -(대시)만 입력가능합니다.");
	    input.value = "";
	    input.focus();
    	return false;
    }
    
    return true;
}

/**
 * 숫자만 체크
 */
function gfn_isNum(input) {
	
    var chars = "0123456789";
    
    if (containsCharsOnly(input,chars) == false) {
	    alert("숫자만 입력가능합니다.");
	    input.value = "";
	    input.focus();
    	return false;
    }
    
    return true;
}

function gfn_check_tel(obj, event, maxLen)
{
    
    if(gfn_isNumber(this.event.keyCode) && obj.readOnly == false)
    {
        var divChar = "-";

        //if(Boolean(char)) divChar = char;

        var oTxt = obj.value.replace(/-/g, "");

        obj.value = transFormTelFormat(oTxt, divChar).substring(0, maxLen);
    }
    else
    {
        return;
    }
}


/**
 * 전화번호 검사2 - input box 3 개 사용 
 */
function gfn_check_tel2(id, tel)
{
	var tel1 = '#'+id+'01'; 
	var tel2 = '#'+id+'02';
	var tel3 = '#'+id+'03';
	
	var type = '';
	if (tel == 'tel') {
	    type = '전화';
    }else if(tel == 'cell'){
    	type = '휴대폰';
    }else if(tel == 'fax'){
    	type = '팩스';
    } else if(tel == 'co'){
    	type = '회사전화';
    }
	var str01 = $.trim($(tel1).val());
    if (tel == 'tel' || tel == 'fax' || tel == 'co' ) {
    	
	    if(!(str01 =='02'||str01 =='031'||str01 =='032'||str01 =='033'||
	    	 str01 =='041'||str01 =='042'||str01 =='043'||str01 =='044'||
	    	 str01 =='051'||str01 =='052'||str01 =='053'||str01 =='054'||str01 =='055'||
	    	 str01 =='061'||str01 =='062'||str01 =='063'||str01 =='064'||str01 =='0505')){
	    	alert(type+'번호를 정확하게 입력해 주세요.');
	    	$(tel1).focus();
	    	return false;
	    }
    }else if(tel == 'cell'){
    	if (str01 == '') {
    		alert(type+'번호를 정확하게 입력해 주세요.');
	    	$(tel1).focus();
	    	return false;
        }
    }
    
    if($.trim($(tel2).val()).length < 3 || $.trim($(tel2).val()).length > 4){
    	alert(type+'번호를 정확하게 입력해 주세요.');
    	$(tel2).focus();
    	return false;
    } else if(!($.trim($(tel3).val()).length == 4)){
    	alert(type+'번호를 정확하게 입력해 주세요.');
    	$(tel3).focus();
    	return false;
    }
    
    return true; 
}


/**
 * 전화번호 검사3 - onblur="gfn_check_tel3(this,'tel');" 
 */
function gfn_check_tel3(id, tel) {
	
	var str01 = id.value;
	
	if(str01 == '') return;	
		
	if (tel == 'tel1') {
	    if(!(str01 =='02'||str01 =='031'||str01 =='032'||str01 =='033'||
	    	 str01 =='041'||str01 =='042'||str01 =='043'||str01 =='044'||
	    	 str01 =='051'||str01 =='052'||str01 =='053'||str01 =='054'||str01 =='055'||
	    	 str01 =='061'||str01 =='062'||str01 =='063'||str01 =='064'||str01 =='0505')){
	    	alert('지역번호를 정확하게 입력해 주세요.');
	    	id.focus();
	    	return false;
	    }
    }
	
	if(tel == 'tel2' && !(str01.length < 5 && str01.length > 2) ){
		alert('번호를 정확하게 입력해 주세요.');
		id.focus();
	}
	
	if(tel == 'tel3' && !(str01.length == 4) ){
		alert('번호를 정확하게 입력해 주세요.');
		id.focus();
	}
}


/**
 * 영문과 숫자 만 가능   (id, name)
 */
function gfn_CheckValue(id, name) 
{ 	
	 var strValue = $('#'+id).val().replace(/ /g, "");
	 $('#'+id).val(strValue);
	 
	 if(strValue == ''){ return false; }
	 
	 var strReg = /^[A-Za-z0-9]+$/; 
       if (strValue != '' && !strReg.test(strValue) )
       {
			alert(name + '은(는) 영문과 숫자만 입력가능합니다.');			
//			$('#'+id).focus();
			return false;
       }
       return true;
}

/**
* 영문과 숫자 . 사용 가능 (id, name)
*/
function emailCheck(email){
	
	var text = email.value;
	var regexp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	if(text == '') return;
	
	if(text.search(regexp) == -1){
		alert("이메일 주소 형식에 맞게 입력해 주세요");
	}

}


var pw_passed = true; // 추호 밸리데이션 처리시에 해당 인자값 확인을 위해

function password_check() {
	var pw = document.getElementById("user_pw").value; //비밀번호
	var pw2 = document.getElementById("user_pw_identify").value; //확인 비밀번호
	var id = document.getElementById("id_check").value; // 아이디
	
	pw_passed = true;
	
	var pattern1 = /[0-9]/;
	var pattern2 = /[a-zA-Z]/;
	var pattern3 = /[~!@#$%^&*<>?`]/;
	
	if(pw2.length != 0) {
		if(pw != pw2) {
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
	}
	
	if(!pattern1.test(pw) || !pattern2.test(pw) || !pattern3.test(pw) || pw.length < 8 || pw.length > 16) {
		alert("영문, 숫자, 특수기호를 포함한 8~16자리로 구성하여야 합니다.");
		return false;
	}
	
	if(pw.indexOf(id) > -1) {
		alert("비밀번호는 ID를 포함할 수 없습니다.");
		return false;
	}
	
	var samePass_0 = 0; //동일문자 카운트
	var samePass_1 = 0; //연속성(+)카운트
	var samePass_2 = 0; //연속성(-)카운트

	for(var i=0; i < pw.length; i++) {
		var chr_pass_0;
		var chr_pass_1;
		var chr_pass_2;

		if(i >= 2) {

			chr_pass_0 = pw.charCodeAt(i-2);
			chr_pass_1 = pw.charCodeAt(i-1);
			chr_pass_2 = pw.charCodeAt(i);
			
			//동일문자 카운트
			if((chr_pass_0 == chr_pass_1) && (chr_pass_1 == chr_pass_2)) {
				samePass_0++;
			}
			else {
				samePass_0 = 0;
			}
			
			//연속성(+) 카운트
			if(chr_pass_0 - chr_pass_1 == 1 && chr_pass_1 - chr_pass_2 == 1) {
				samePass_1++;
			}
			else {
				samePass_1 = 0;
			}
			
			//연속성(-) 카운트
			if(chr_pass_0 - chr_pass_1 == -1 && chr_pass_1 - chr_pass_2 == -1) {
				samePass_2++;
			}
			else {
				samePass_2 = 0;
			}
		}
		
		if(samePass_0 > 0) {
			alert("동일문자를 3자 이상 연속 입력할 수 없습니다.");
			pw_passed = false;
		}
		
		if(samePass_1 > 0 || samePass_2 > 0) {
			alert("영문, 숫자는 3자이상 연속 입력할 수 없습니다.");
			pw_passed = false;
		}
		
		if(!pw_passed) {
			return false;
			break;
		}
	}
	
	return true;
}


/**
 * 숫자체크
 */
function gfn_isNumber(keyCode)
{
    return ((keyCode > 47 && keyCode < 58) || (keyCode > 95 && keyCode < 106));

}

/**
* @param obj  : this (고정)
* @param type : int =>  정수(소수 입력 안 됨) / -int => -정수(소수 입력 안 됨) / float => 실수(소수 입력 가능) / -float => -실수 (소수 입력 가능)
* @param tlen : tlen => 총 자리수 (정수 입력 시 tlen에서 flen 뺀 결과가 정수자리수)
* @param flen : 소수 자리수 (~까지) 
* @param comma : Y => 세자리마다 콤마(,) 자동입력 N => 콤마 미적용
* @return
* <input type="" onkeyup="gfn_check_number(this,'int',5,2,'Y');" />
*/
function gfn_check_number(obj, type, tlen, flen, comma){
    var returnVal = String(obj.value);
    var regexp = /[^-\.0-9]/g;
    var repexp = "";
    var len = 2;
    var ilen = 0;

    if(flen != undefined){
        len = flen;
    }
    
    ilen = tlen - flen;

    returnVal = returnVal.replace(regexp, repexp);
    
    if(returnVal.split(".").length > 1){
        returnVal = returnVal.split(".")[0].substr(0,ilen) + "." + returnVal.split(".")[1].substr(0, len);
    }else{
        returnVal = returnVal.substring(0,ilen);
    }

    
    
    switch(type){
        case "int" : regexp = /[^0-9]/g; break;
        case "float" : regexp = /^(-?)([0-9]*)(\.?)([^0-9]*)([0-9]*)([^0-9]*)/; break;
        case "-int" : regexp = /^(-?)([0-9]*)([^0-9]*)([0-9]*)([^0-9]*)/; break;
        case "-float" : regexp = /^(-?)([0-9]*)(\.?)([^0-9]*)([0-9]*)([^0-9]*)/; break;
        default : regexp = /[^0-9]/g; break;
    }

    switch(type){
        case "int" : repexp = ""; break;
        case "float" : repexp = "$2$3$5"; break;
        case "-int" : repexp = "$1$2$4"; break;
        case "-float" : repexp = "$1$2$3$5"; break;
        default : repexp = /[^0-9]/g; break; 
    }
    
    returnVal = returnVal.replace(regexp, repexp);

    
    if(comma == "Y"){
        var str = "" + returnVal.replace(/,/gi,'');
        var regx = new RegExp(/(-?\d+)(\d{3})/);
        var bExists = str.indexOf(".",0);
        var strArr = str.split('.');
         
        while(regx.test(strArr[0])){
             strArr[0] = strArr[0].replace(regx,"$1,$2");
         }
     
         if (bExists > -1){
            obj.value = strArr[0] + "." + strArr[1];
        }else{
             obj.value = strArr[0];
         }
            
    }else{
        obj.value =  returnVal;
    }
}

/**
* TextArea 입력 글자 제한 gfn_check_input_length(id, byte size)
*/
function gfn_check_input_length(name, msgMax) {
    
   var msgList = name.value;               //글자가 입력되는 이벤트가 발생되는 value 값
   var msgListLength = msgList.length;  //입력 되는 글자의 전체 길이
   var limitSize = msgMax;  //제한 할 글자 길이
   var charOne = "";           //한 글자씩 검사하기 위한 변수
   var charByte = 0;           //입력 되고 있는 문자의 길이(바이트) 를 저장할 변수
   var msgLen = 0;           //입력 내용을 담아 subString 할 변수
   var msgLast = "";           //글자수가 초과 할 경우, 제한 할 마지막 글자 까지 보여준다
   
   for(var i = 0; i < msgListLength; i++) {  //입력 되고 있는 글자의 전체길이를 루프를 돈다.
         charOne = msgList.charAt(i);            //한글자씩 읽음
        
         //한글은 2byte 이므로, 한글이 입력 되고 있을 경우 2를 더한다.
         if(escape(charOne).length > 4) {
          charByte += 2;
         } else {
          charByte++;  //그 외에 경우에는 1byte. 1을 더한다.
         }
         
         if(charByte <= limitSize) {  //전체 크기가 제한 글자 길이를 넘지 않는다면..
          msgLen = i + 1;
         }
   }
   
   if(charByte > limitSize) {
         alert("영문, 숫자, 특수문자는 " + parseInt(limitSize) +" 글자,\n한글은 "  + parseInt(limitSize)/2 + " 글자를 초과 입력 할 수 없습니다.");
         msgLast = msgList.substr(0, msgLen);
         name.value = msgLast;
         charByte = limitSize;
   }
}


// 화면 이동
function gfn_openMenu(url,a){
    location.href = url;
}


// 확장자 체크
function gfn_extChk(fileType, fileObj) {

    var flag = false;
    var fileName = fileObj.val();
    var ext = fileName.slice(fileName.lastIndexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.
    
    
    if (ext == null || ext == "") { // 확장자가 없다면
        return true;
    } else {
    	
        // 일반문서파일
        if (fileType == "DOC") {
            
            if(ext == "doc"  || ext == "docx"
                      || ext == "ppt"  || ext == "pptx"
                      || ext == "xls"  || ext == "xlsx"
                      || ext == "hwp"  || ext == "pdf"
                      || ext == "zip"  || ext == "jar"
                      || ext == "tar"  || ext == "txt") {
                flag = true; //조건을 만족하면 flag에 true
            } else {
                alert("첨부한 문서 파일이 첨부 가능한\n확장자 파일[doc,docx,ppt,pptx,xls,xlsx,hwp,pdf,zip,jar,tar,txt]이 아닙니다.");
                flag = false;
            }
            
        } else if (fileType == "IMG") { // 이미지
            
            if(ext == "jpg"  || ext == "jpeg"
                || ext == "gif"  || ext == "png"
                || ext == "tif"  || ext == "bmp"
                || ext == "pic") {
               flag = true; 
            } else {
               alert("첨부한 이미지 파일이 첨부 가능한\n확장자 파일[jpg,jpeg,gif,png,tif,bmp,pic]이 아닙니다.");
               flag = false;
            }
            
        } else if (fileType == "MOV") { // 동영상
            
             if(ext == "mp4"  || ext == "avi"
                 || ext == "mkv"  || ext == "mka"
                 || ext == "mpeg" || ext == "mpg"
                 || ext == "wmv"  || ext == "asf"
                 || ext == "mov"  || ext == "flv") {
                flag = true; //조건을 만족하면 flag에 true
             } else {
                alert("첨부한 동영상 파일이 첨부 가능한\n확장자 파일[mp4,avi,mkv,mka,mpeg,mpg,wmv,asf,mov,flv]이 아닙니다.");
                flag = false;
             }
         
        } else { // 그외
        	if(ext == "doc"  || ext == "docx"
	                || ext == "ppt"  || ext == "pptx"
	                || ext == "xls"  || ext == "xlsx"
	                || ext == "hwp"  || ext == "pdf"
	                || ext == "zip"  || ext == "jar"
	                || ext == "tar"  || ext == "txt"
	                || ext == "jpg"  || ext == "jpeg"
	                || ext == "gif"  || ext == "png"
	                || ext == "tif"  || ext == "bmp"
	                || ext == "pic"
                	|| ext == "mp4"  || ext == "avi"
                    || ext == "mkv"  || ext == "mka"
                    || ext == "mpeg" || ext == "mpg"
                    || ext == "wmv"  || ext == "asf"
                    || ext == "mov"  || ext == "flv") {
	          flag = true; //조건을 만족하면 flag에 true
	      } else {
	          alert(ext+"파일은 첨부가 불가능합니다.");
	          flag = false;
	      }
        }
        
        return flag;
    }
     
    
}


/**
 * 팝업창 띄움
 */

function gfn_openPop(option)
{
    var data = "";
    
    if(typeof option.callback != 'undefined')
    {
        if(data == "")
            data = data + "?" + "callback=" + option.callback;
        else
            data = data + "&" + "callback=" + option.callback;
    }
    
    if(typeof option.param != 'undefined')
    {
        $.each(option.param, function(key, value){
            
            if(data == "")
                data = data + "?" + key + "=" + encodeURIComponent(value);
            else
                data = data + "&" + key + "=" + encodeURIComponent(value);
        });
    }
    
    var pop = window.open(
        option.url + data, 
        option.name, 
        "width=" + (typeof option.width == 'undefined' ? 500 : option.width) +
        ",height=" + (typeof option.height == 'undefined' ? 500 : option.height) +
        ",scrollbars=" + (typeof option.scroll == 'undefined' ? 'yes' : option.scroll) +
        ",toolbar=" + (typeof option.toolbar == 'undefined' ? 'no' : option.toolbar) +
        ",menubar=" + (typeof option.menubar == 'undefined' ? 'no' : option.menubar) +
        ",location=" + (typeof option.location == 'undefined' ? 'no' : option.location) +
        ",resizable=" + (typeof option.resizable == 'undefined' ? 'yes' : option.resizable) +
        ",fullscreen=" + (typeof option.fullscreen == 'undefined' ? 'no' : option.fullscreen) +
        ",channelmode=" + (typeof option.channelmode == 'undefined' ? 'no' : option.channelmode) 
    );
    
    pop.focus();
    
    return pop;
}

//팝업창 닫기
function gfn_popClose() {    
    self.close();        
}

//날짜체크 함수
function wini_myDateChk(obj, type){
    
    var valueDate = "";
    var tmpDate = obj.value.replace(/-/g,"").replace(/\,/g,"").replace(/\./g,"");
    
    wini_numCheck(obj,4);// 숫자 체크
    
    if(obj.value == ""){
        return;
    }
    
    var len = tmpDate.length;   
    if(len != type.length && obj.value != ""){
        alert("날짜의 입력이 잘못되었습니다.");
        obj.value = "";
        return;
    }
    //alert(Number(tmpDate));
    
        
    var yyyy = "";
    var mm = "";
    var dd = "";    

    if(type == "yyyymmdd"){
        yyyy = tmpDate.substring(0,4);
        mm = tmpDate.substring(4,6);
        dd = tmpDate.substring(6,8);
    }
    else if(type == "yyyymm"){
        yyyy = tmpDate.substring(0,4);
        mm = tmpDate.substring(4,6);
    }
    else if(type == "yyyy"){
        yyyy = tmpDate;
    }
    else if(type == "mm"){
        mm = tmpDate;
    }
    else{
    }

    if(yyyy != ""){
        if(Number(yyyy) < 1000 ){
            alert("년도는 1000년 이후를 입력하셔야 합니다.");
            obj.value = "";
            return;
        }
        else{
            // 정상
            if(mm != ""){
                valueDate = yyyy+"-";
            }
            else{
                valueDate = yyyy;
            }
        }

    }
    if(mm != ""){
        var d1 = "";
        var d2 = "";
        
        if(dd=="" && (mm=="01"||mm=="02"||mm=="03"||mm=="04"||mm=="05"||mm=="06"||
            mm=="07"||mm=="08"||mm=="09"||mm=="10"||mm=="11"||mm=="12")){
            // 정상
            valueDate += mm;
        }
        else if(dd!="" && (mm=="01"||mm=="02"||mm=="03"||mm=="04"||mm=="05"||mm=="06"||
            mm=="07"||mm=="08"||mm=="09"||mm=="10"||mm=="11"||mm=="12")){
            if(mm=="01"||mm=="03"||mm=="05"||mm=="07"||mm=="08"||mm=="10"||mm=="12"){
                d1 = dd.substring(0,1);
                d2 = dd.substring(1,2);
                if(d1 == "0" && (Number(d2) > 0 && Number(d2) < 10)){
                    // 정상
                    valueDate += mm+"-"+dd;
                }
                else if(d1 != "0" && (Number(dd) > 9 && Number(dd) <= 31)){
                    // 정상
                    valueDate += mm+"-"+dd;
                }
                else{
                    alert("날짜의 입력이 잘못되었습니다.");
                    obj.value = "";
                    return;
                }
            }
            if(mm=="04"||mm=="06"||mm=="09"||mm=="11"){
                d1 = dd.substring(0,1);
                d2 = dd.substring(1,2);
                if(d1 == "0" && (Number(d2) > 0 && Number(d2) < 10)){
                    // 정상
                    valueDate += mm+"-"+dd;
                }
                else if(d1 != "0" && (Number(dd) > 9 && Number(dd) <= 30)){
                    // 정상
                    valueDate += mm+"-"+dd;
                }
                else{
                    alert("날짜의 입력이 잘못되었습니다.");
                    obj.value = "";
                    return;
                }
            }
            if(mm=="02"){
                d1 = dd.substring(0,1);
                d2 = dd.substring(1,2);
                if(d1 == "0" && (Number(d2) > 0 && Number(d2) < 10)){
                    // 정상
                    valueDate += mm+"-"+dd;
                }
                else if(d1 != "0" && getLeapYearYN(yyyy)=="Y"){
                    if(Number(dd) > 9 && Number(dd) <= 29){
                        // 정상
                        valueDate += mm+"-"+dd;
                    }
                    else{
                        alert("날짜의 입력이 잘못되었습니다.");
                        obj.value = "";
                        return;
                    }
                }
                else if(d1 != "0" && getLeapYearYN(yyyy)=="N"){
                    if(Number(dd) > 9 && Number(dd) <= 28){
                        // 정상
                        valueDate += mm+"-"+dd;
                    }
                    else{
                        alert("날짜의 입력이 잘못되었습니다.");
                        obj.value = "";
                        return;
                    }
                }
                else{
                    alert("날짜의 입력이 잘못되었습니다.");
                    obj.value = "";
                    return;
                }
            }
        }
        else{
            alert("날짜의 입력이 잘못되었습니다.");
            obj.value = "";
            return;
        }
    }
    obj.value = valueDate;

    return;
}

//숫자체크
function wini_numCheck(obj, type) {
   var strr = "0123456789";
   
   if (type == 1) {
       strr = strr + "-+";
   } else if (type == 2) {
       strr = strr + ".";
   } else if (type == 3) {
       strr = strr + "-+.";
   } else if (type == 4) {
       strr = strr + "-";
   }
   
   var Number_Value = obj.value;
   for (i = 0; i < Number_Value.length; i++) {
       for (j = 0; j < strr.length; j++) {
           if (Number_Value .charAt(i) == strr.charAt(j)) break;
       }
       
       if (j == strr.length) {
           obj.value = "";
           alert("숫자만 입력가능합니다.");
           return;
       }
   }
   return;
 }