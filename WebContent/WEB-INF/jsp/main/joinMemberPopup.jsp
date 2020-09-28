<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="ajax" uri="http://ajaxtags.sourceforge.net/tags/ajaxtags"%>
<%@taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader("Expires",0);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>회원가입</title>
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
    <div class="subtitle" style="margin-bottom: 3px;">
        <h3>회원가입</h3>
    </div>
<!--     <div class="tbcomt" style="padding: 0px;">- <span>소방근무자가 아닌분만 가입</span>하시길 바랍니다.</div> -->
<!--     <div class="tbcomt" style="padding: 0px;">- <span>소방근무자</span>이신분은 소방인사정보시스템 아이디로 로그인 하시면 되오니 회원가입이 불필요 합니다.</div> -->
<!--     <div class="tbcomt" style="padding: 0px;">- '<span>*</span>'는 필수 항목입니다.</div> -->
    <form name="frm" id="frm" method="post" enctype="multipart/form-data" action="" onsubmit=" return false;" >
    <input type="hidden" id="rsaPublicKeyModulus" name="rsaPublicKeyModulus" value="${publicKeyMap.modulus}" />
    <input type="hidden" id="rsaPublicKeyExponent" name="rsaPublicKeyExponent" value="${publicKeyMap.exponent}" />
    <input type="hidden" id="securedUserName" name="securedUserName" value="" />
    <input type="hidden" id="securedUserId" name="securedUserId" value="" />
    <input type="hidden" id="securedRegno" name="securedRegno" value="" />
    <input type="hidden" id="securedPwd" name="securedPwd" value="" />
<!--     <input type="hidden" id="securedUpWardId" name="securedUpWardId" value="" /> -->
<!--     <input type="hidden" id="securedWardId" name="securedWardId" value="" /> -->
<!--     <input type="hidden" id="securedEtcAddr" name="securedEtcAddr" value="" /> -->
    <input type="hidden" id="securedCell01" name="securedCell01" value="" />
    <input type="hidden" id="securedCell02" name="securedCell02" value="" />
    <input type="hidden" id="securedCell03" name="securedCell03" value="" />
<!--     <input type="hidden" id="securedHomeTel01" name="securedHomeTel01" value="" /> -->
<!--     <input type="hidden" id="securedHomeTel02" name="securedHomeTel02" value="" /> -->
<!--     <input type="hidden" id="securedHomeTel03" name="securedHomeTel03" value="" /> -->
    <input type="hidden" id="securedExtTel" name="securedExtTel" value="" />
<!--     <input type="hidden" id="securedCoTel" name="securedCoTel" value="" /> -->
<!--     <input type="hidden" id="securedFaxTel" name="securedFaxTel" value="" /> -->
<!--     <input type="hidden" id="securedTitleCd" name="securedTitleCd" value="" /> -->
<!--     <input type="hidden" id="securedWorkSectionCd" name="securedWorkSectionCd" value="" /> -->
<!--     <input type="hidden" id="securedWorkCd" name="securedWorkCd" value="" /> -->
    <input type="hidden" id="securedEmail" name="securedEmail" value="" />
    
    <div>
        <table class="tbl_type02" border="1" cellspacing="0" summary="회원가입">
            <caption>
                 목록
            </caption>
            <colgroup>
            <col width="120"/>
            <col width=""/>
            <col width="120"/>
            <col width=""/>
            </colgroup>     
          <tbody>
            <tr> 
                <th><label for="user_name"><font color="red">*</font>이름</label></th>
                <td colspan="3">
                    <input type="text" id="user_name" name="user_name" class="i_text" style="width: 130px; ime-mode:active;" maxlength="10"/> 
                </td>
            </tr>
            <tr> 
                <th><label for="user_id"><font color="red">*</font>아이디</label></th>
                <td colspan="3">
                    <input type="text" id="user_id" name="user_id" class="i_text" style="width: 50%; ime-mode:disabled;" maxlength="14"/>&nbsp;&nbsp;
                    <input type="hidden" id="id_check" name="id_check"/>
                    <a class="btn_tb01_gray" onclick="fn_idCheck();" href="javascript:void(0);">중복체크</a>
<!--                     <span>영문 또는 숫자  6~14자 이내</span>  -->
                </td>
            </tr>
            <tr> 
                <th><label for="regno"><font color="red">*</font>사원번호</label></th>
                <td colspan="3">
                    Htec-<input type="text" id="regno" name="regno" class="i_text" style="width: 50%; ime-mode:inactive;" onblur="gfn_check_number(this,'int',3,0,'N');" maxlength="3"/>&nbsp;&nbsp;
                    <input type="hidden" id="regno_check" name="regno_check"/>
                    <a class="btn_tb01_gray" onclick="fn_regnoCheck();" href="javascript:void(0);">중복체크</a>
<!--                     <span>영문 또는 숫자  6~14자 이내</span>  -->
                    <span>숫자만 입력 가능</span>
                </td>
            </tr>
            <tr> 
                <th><label for="user_pw"><font color="red">*</font>비밀번호</label></th>
                <td colspan="3">
                    <input type="password" id="user_pw" name="user_pw" class="i_text" style="width:50%; margin-bottom:5px; ime-mode:disabled;" maxlength="20" />
                    <br />
<!--                     <span>영어, 숫자, 특수문자(!,#,$,?등)의 조합으로 8~16자리로 입력해 주세요.(같은문자 3회연속, 연속된 문자 사용불가)</span> -->
                </td>
            </tr>
            <tr> 
                <th><label for="user_pw_identify"><font color="red">*</font>비밀번호확인</label></th>
                <td colspan="3">
                    <input type="password" id="user_pw_identify" name="user_pw_identify" class="i_text" style="width:50%;ime-mode:disabled;" maxlength="20" />
                    <span>입력오류 방지를 위하여 똑같이 한번 더 입력합니다.</span>
                </td>
            </tr>
<!--             <tr>  -->
<!--                 <th><label for="srch_ward_id"><font color="red">*</font>서/센터</label></th> -->
<!--                 <td colspan="3"><div> -->
<!--                     <select id="srch_ward_id" name="srch_ward_id"  style="width: 150px" onchange="wardDetailList('srch','');"> -->
<!--                         <option value="" selected="selected">서</option> -->
<%--                         <c:forEach var="result" items="${wardIdlist}" varStatus="status"> --%>
<%--                             <option value="<c:out value="${result.wardId}"/>"><c:out value="${result.wardName}"/></option> --%>
<%--                         </c:forEach> --%>
<!--                     </select> -->
<!--                     <select id="srch_ward_id_detail" name="srch_ward_id_detail"  style="width: 200px"> -->
<!--                         <option value="" selected="selected" >센터</option> -->
<!--                     </select> -->
<!--                 </div></td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--                 <th ><label for="etc_addr"><font color="red">*</font>주소</label></th> -->
<!--                 <td colspan="3"> -->
<!--                     <input type="text" id="etc_addr" name="etc_addr" maxlength="50" class="i_text" style="width:98%; ime-mode:active;"/> -->
<!--                 </td> -->
<!--             </tr> -->
            <tr> 
                <th><label for="cell1">휴대전화</label></th>
                <td>
                    <input type="text" id="cell1" name="cell1" class="i_text"  style="width:30px;  ime-mode:active; text-align: left;" maxlength="3" onkeyup="gfn_isNumDash(this);" onblur="gfn_check_number(this,'int',3,0,'N');"   title="전화번호앞자리"/>-
                    <input type="text" id="cell2" name="cell2" class="i_text"  style="width:30px;  ime-mode:active; text-align: left;" maxlength="4" onkeyup="gfn_isNumDash(this);" onblur="gfn_check_number(this,'int',4,0,'N');"   title="전화번호중간자리"/>-
                    <input type="text" id="cell3" name="cell3" class="i_text"  style="width:30px;  ime-mode:active; text-align: left;" maxlength="4" onkeyup="gfn_isNumDash(this);" onblur="gfn_check_number(this,'int',4,0,'N');"   title="전화번호끝자리"/>
                    <span>숫자만 입력 가능</span>
                </td>
                <th><label for="ext_tel">내선번호</label></th>
                <td>
                    <input type="text" id="ext_tel" name="ext_tel" class="i_text" style="width: 130px; ime-mode:active;" onkeyup="gfn_isNumDash(this);" onblur="gfn_check_number(this,'int',10,0,'N');" maxlength="10"/> 
                </td>
<!--                 <th><label for="hometel1">집전화번호</label></th> -->
<!--                 <td> -->
<!--                     <input type="text" id="hometel1" name="hometel1" class="i_text"  style="width:30px;  ime-mode:active; text-align: left;" maxlength="3" onkeyup="gfn_isNumDash(this);" onblur="gfn_check_number(this,'int',3,0,'N');"   title="전화번호앞자리"/>- -->
<!--                     <input type="text" id="hometel2" name="hometel2" class="i_text"  style="width:30px;  ime-mode:active; text-align: left;" maxlength="4" onkeyup="gfn_isNumDash(this);" onblur="gfn_check_number(this,'int',4,0,'N');"   title="전화번호중간자리"/>- -->
<!--                     <input type="text" id="hometel3" name="hometel3" class="i_text"  style="width:30px;  ime-mode:active; text-align: left;" maxlength="4" onkeyup="gfn_isNumDash(this);" onblur="gfn_check_number(this,'int',4,0,'N');"   title="전화번호끝자리"/> -->
<!--                     <span>숫자만 입력 가능</span> -->
<!--                 </td> -->
            </tr>
<!--             <tr>  -->
<!--                 <th><label for="ext_tel">내선번호</label></th> -->
<!--                 <td> -->
<!--                     <input type="text" id="ext_tel" name="ext_tel" class="i_text" style="width: 130px; ime-mode:active;" onkeyup="gfn_isNumDash(this);" onblur="gfn_check_number(this,'int',10,0,'N');" maxlength="10"/>  -->
<!--                 </td> -->
<!--                 <th><label for="co_tel">직장전화번호</label></th> -->
<!--                 <td> -->
<!--                     <input type="text" id="co_tel" name="co_tel" class="i_text" style="width: 130px; ime-mode:active;" onkeyup="gfn_isNumDash(this);" onblur="gfn_check_number(this,'int',10,0,'N');" maxlength="10"/>  -->
<!--                 </td> -->
<!--             </tr> -->
<!--             <tr>  -->
<!--                 <th ><label for="fax_tel">팩스번호</label></th> -->
<!--                 <td> -->
<!--                     <input type="text" id="fax_tel" name="fax_tel" class="i_text" maxlength="20" style="width: 130px; ime-mode:active;" onkeyup="gfn_isNumDash(this);" onblur="gfn_check_number(this,'int',20,0,'N');"/> -->
<!--                 </td> -->
<!--                 <th ><label for="title_cd">직위</label></th> -->
<!--                 <td><div> -->
<!--                      <select id="title_cd" name="title_cd" style="width:150px;" class="i_text"> -->
<!--                         <option value="" selected="selected" >선택</option> -->
<%--                          <c:forEach var="result" items="${titleCdList}" varStatus="status"> --%>
<%--                               <option value="<c:out value="${result.cd}"/>" ><c:out value="${result.cdName}"/></option> --%>
<%--                          </c:forEach> --%>
<!--                      </select> -->
<!--                      </div> -->
<!--                 </td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--                 <th ><label for="work_section_cd">근무구분</label></th> -->
<!--                 <td><div> -->
<!--                     <select id="work_section_cd" name="work_section_cd" style="width:100px;" class="i_text"> -->
<!--                         <option value="" selected="selected" >선택</option> -->
<%--                          <c:forEach var="result" items="${workSectionCdList}" varStatus="status"> --%>
<%--                               <option value="<c:out value="${result.cd}"/>" ><c:out value="${result.cdName}"/></option> --%>
<%--                          </c:forEach> --%>
<!--                     </select> -->
<!--                     </div> -->
<!--                 </td> -->
<!--                 <th ><label for="work_cd">직류</label></th> -->
<!--                 <td><div> -->
<!--                      <select id="work_cd" name="work_cd" style="width:100px;" class="i_text"> -->
<!--                         <option value="" selected="selected" >선택</option> -->
<%--                          <c:forEach var="result" items="${workCdList}" varStatus="status"> --%>
<%--                               <option value="<c:out value="${result.cd}"/>" ><c:out value="${result.cdName}"/></option> --%>
<%--                          </c:forEach> --%>
<!--                      </select> -->
<!--                      </div> -->
<!--                 </td> -->
<!--             </tr> -->
            <tr> 
                <th ><label for="email">이메일</label></th>
                <td colspan="3">
                    <input type="text" id="email" name="email" maxlength="25" class="i_text" style="width:98%; ime-mode:inactive;"/>
                </td>
            </tr>
            <tr> 
                <th ><label for="etc_addr">주소</label></th>
                <td colspan="3">
                    <input type="text" id="etc_addr" name="etc_addr" maxlength="50" class="i_text" style="width:98%; ime-mode:active;"/>
                </td>
            </tr>
          </tbody>
        </table>
    </div>
   </form>
   
   <div class="btn_right" style="width: 94.5%">
        <div class="al_l m_l35">
            <a class="btn_tb01_blue b_h25" href="javascript:void(0);" onclick="insertMember();">회원가입</a>
            <a class="btn_tb01_red b_h25" href="javascript:void(0);" onclick="doClose();">닫기</a>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/webnote/webnote.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/home/script/insertMember.js"></script>
<script type="text/javascript">
    <!--
  //서센터 ID 2단계 부분
    function wardDetailList(flag, wardId) {
        var para = null;
        if(flag == "srch"){
            para = "ward_id="+$("#srch_ward_id").val();
        }
        else if(flag == "detail"){
            para = "ward_id="+$("#ward_id").val();
        }
        var ajax_set = 
        { 
            url:"sys/wardIdDetail.do",
            param : para,     
            return_fn:function(jdata){wardDetailList_result(jdata, flag, wardId);}    
        }            
        
        winigrid_getDetail(ajax_set);
        
    }
    //wardDetailList 처리결과
    function wardDetailList_result(jdata, flag, wardId){
        if(flag == "srch"){
            var temp_data = "<option value="+">전체</option>";
        }else if(flag == "detail"){
            var temp_data = "<option value="+">선택</option>";
        }
        
        if(flag == "srch"){
            $("#srch_ward_id_detail").empty();
            $("#srch_ward_id_detail").html(temp_data);
        }
        else if(flag == "detail"){
            $("#ward_id_detail").empty();
            $("#ward_id_detail").html(temp_data);
        }
        
        if (jdata == null) {
            alert("서센터 상세조회를 실패하였습니다.");
        }
        
        if (jdata.rows.length > 0){
            for ( var i = 0; i < jdata.rows.length; i++) {
                var result =jdata.rows[i]; 
                
                temp_data += "<option value="+result.wardId+">"+result.wardName+"</option>";
            }
            
            if(flag == "srch"){
                $('#srch_ward_id_detail').html(temp_data);
            }
            else if(flag == "detail"){
                $('#ward_id_detail').html(temp_data);
                //센터 값 셋팅
                $('#ward_id_detail').val(wardId);
            }
        } 
    }    
    
//-->
</script>   
</body>
</html>
    