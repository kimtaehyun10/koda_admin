	var checked = false; //아이디 중복체크
    var regnoCheck = false;  //사원번호 중복체크
    
    //이메일 체크 정규식
    var emailCheck = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
    //전화번호 체크 정규식
    var telCheck = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
    

     
    // 상세조회 초기화
    function doClear() {
        $('#frmD')[0].reset();
        checked = false;
        regnoCheck = false;
        
        $('#regno_check').val('');
        $('#id_check').val('');
        
        setButton('I');
    }
    
    //버튼 세팅
    function setButton(btnType) {        
        $('#b_Insert').css("display", "none");
        $('#b_Update').css("display", "none");
        $('#b_Delete').css("display", "none");
        
        if (btnType == 'I') {
            $('#b_Insert').css("display", "");
            $('#user_id').attr("readonly",false);
            $('#user_id').css("background-color", "#FFFFFF");
            $('#user_pw_h').css("display","");
            $('#user_pw_re_h').css("display","");
            $('#user_pw').removeAttr('disabled');
            $('#user_pw_re').removeAttr('disabled');
            $('#user_pw').css("background-color", "#FFFFFF");
            $('#user_pw_re').css("background-color", "#FFFFFF");
            $('#b_pw_clear').css("display", "none");
            $('#id_che').css("display", "");
            $('#regno_che').css("display", "");
            $('#user_id').css("width","66%");
            $('#reg_date').attr("disabled", "disabled");
            $('#lchg_dtime').attr("disabled", "disabled");
            $('#reg_date').css("background-color", "#e2e2e2");
            $('#lchg_dtime').css("background-color", "#e2e2e2");
            
        } else if (btnType == 'U') {
            $('#b_Update').css("display", "");
            $('#b_Delete').css("display", "");
            $('#user_id').attr("readonly",true);
            $('#user_id').css("background-color", "#e2e2e2");
            $('#user_pw_h').css("display","");
            $('#user_pw_re_h').css("display", "");
            $('#user_pw').attr("disabled", "disabled");
            $('#user_pw_re').attr("disabled", "disabled");
            $('#user_pw').css("background-color", "#e2e2e2");
            $('#user_pw_re').css("background-color", "#e2e2e2");
            $('#b_pw_clear').css("display", "");
            $('#id_che').css("display", "none");
            $('#regno_che').css("display", "none");
            $('#user_id').css("width","98%");
            $('#reg_date').removeAttr('disabled');
            $('#lchg_dtime').removeAttr('disabled');
            $('#reg_date').css("background-color", "#e2e2e2");
            $('#lchg_dtime').css("background-color", "#e2e2e2");
        }
    }
    //검색
    function Search(){
        //조회
        listGird(1);
    }
    
    /********************************************************************************
    * 그리드 검색
    *********************************************************************************/
    var tb1_wini_grid = 
    { 
            url:"./selectUserMngList.do",
            mtype : 'POST',
            postData:{},
            colNames:[
                {"head" : ['사용자SN','사용자명', '사용자ID','사원번호','내선번호','연락처','관리자여부']}
                ], 
            colModel:[
                {name:'userSn',            index:'userSn',         width:140,     align:"center",  hidden:true,  coltype:""},
                {name:'userName',          index:'userName',       width:120,     align:"center",  hidden:false, coltype:""},
                {name:'userId',            index:'userId',         width:140,     align:"center",  hidden:false, coltype:""},
                {name:'regno',             index:'regno',          width:80,      align:"center",  hidden:false, coltype:""},
                {name:'extTel',            index:'extTel',         width:70,      align:"center",  hidden:false, coltype:""},
                {name:'cell',              index:'cell',           width:70,      align:"center",  hidden:false, coltype:""},
                {name:'sysmgrYn',          index:'sysmgrYn',       width:70,      align:"center",  hidden:false, coltype:""}
                ],
            autowidth: true,        //자동크기조절
            rowNum: '10',
            rownumbers: true,     //No 뷰
            viewrecords: true,   //리스트 뷰
            viewpager: true,    //페이지 뷰
            rowCntView: true,  //총 건수 뷰
            multiselect: false, //첫 컬럼에 체크박스 생성
            multiselectPosition:"left", // 체크박스 위치 left or rigit
            headmerge: false,
            rowscroll: false,
            dataheight:285,
            //datamerge: [2, 3],
            onClickRow: "grid_Detail_Info",
            tableid: "grid_dataList",       
            page:1,
            pagerurl: "listGird",
            pager: "grid_dataList_page"
           
    }
    
    
    function listGird(pagenum){ 

        document.frmS.target = "";
        document.frmS.action = "";
        
//         doClear();
        tb1_wini_grid.formName = "#frmS";
        tb1_wini_grid.dummyList = false;
        tb1_wini_grid.page = pagenum;
        winigrid_call(tb1_wini_grid);
    
    }
    
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
            url:"./wardIdDetail.do",
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
    /*******************************************************************************************
    * 목록 클릭
    ******************************************************************************************/
    function grid_Detail_Info(nRow){
    
        var data = ""; 
        var user_sn = "";
    
        data = winigrid_getRowObj("grid_dataList", nRow);
        
        user_sn = winigrid_getRowValue(data, "userSn");
        $('#user_sn').val('');
        $('#user_sn').val(user_sn);
        //alert(id);
        get_docDetail(user_sn);
    }
    
    
    //상세조회
    function get_docDetail(user_sn){
        doClear();
        
        if (user_sn == "") return;
        
        // 사용자 상세정보
        var ajax_set = 
        { 
            url:"./selectUserMngListDetail.do",
            param:"user_sn="+user_sn,        
            return_fn:function(jdata){set_docDetail(jdata);}   
        }
        
        winigrid_getDetail(ajax_set);   
        
        setButton('U');
    }
    
    // 상세조회 셋팅
    function set_docDetail(jdata) {
    
        if (jdata == null && jdata.errCd=='-1') {
            alert("상세조회를 실패하였습니다.");
        }

        if (jdata.rows.length > 0){
    
            var detail = jdata.rows[0];
//             if(detail.dSeowardId == detail.wardId)
//             {
//                 $('#ward_id').val(detail.wardId);
//                 //센터 콤보박스에 선택 셋팅
//                 wardDetailList('detail','');
//             }
//             else{
//                 $('#ward_id').val(detail.dSeowardId);
//                 //센터 콤보박에 상세조회값 셋팅
//                 wardDetailList('detail',detail.wardId);
//             }
            
            $('#sysmgr_yn').val(detail.sysmgrYn); //관리자여부
            $('#user_id').val(detail.userId);  //아이디
            $('#user_name').val(detail.userName);  //이름
            $('#regno').val(detail.regno);  //사번
            $('#cell').val(detail.cell);  //휴대전화
            $('#email').val(detail.email);  // 이메일
            $('#ext_tel').val(detail.extTel);  //내선전화
            $('#home_tel').val(detail.homeTel);  //내선전화
            $('#etc_addr').val(detail.etcAddr);  //주소
            $('#user_sn').val(detail.userSn);  //user_sn
            $('#user_sttus_cd').val(detail.userSttusCd);  //사용자상태코드
            $('#reg_date').val(detail.regDate);  //등록일자
            $('#lchg_dtime').val(detail.lchgDtime);  //수정일자
           
        }
    }
    
    
    /*******************************************************************************************
    * 등록/수정/삭제
    ******************************************************************************************/
    function app_req(iud) {
        var user_sn = $('#user_sn').val();
        
        var c_firm = " 하시겠습니까?";
        if (iud == "I") {
            c_firm = "등록"+c_firm;
        } else if (iud == "U") {
            c_firm = "수정"+c_firm;         
        } else if (iud == "D") {
            c_firm = "삭제"+c_firm;         
        } else if (iud == "C") {
            c_firm = "비밀번호 초기화"+c_firm +"(초기화시 비밀번호는 1111입니다.)";         
        }
        
          if(t_checkNotNull(iud)){
                var ajax_set = 
                { 
                    form_name:"#frmD",
                    url:"./saveUserMng.do?iud="+iud,
                    return_fn:function(jdata){submit_result(jdata,iud, user_sn);}    
                }  
                wini_submitIUD(ajax_set, c_firm);
          }
        
    }
  
    //처리결과
    function submit_result(jdata, iud,user_sn) {

        if (jdata.errCd != null && jdata.errCd != "1") {
            alert(jdata.errMsg);
        } else {
            var str = "";
            if (iud == "I") {
                str = "등록";
                doClear();
                listGird(1); // 목록 재조회
            } else if (iud == "U") {
                str = "수정";   
                listGird(tb1_wini_grid.page); // 목록 재조회
            } else if (iud == "D") {
                str = "삭제";          
                listGird(1); // 목록 재조회
            } else if (iud == "C") {
                str = "비밀번호 초기화가";
                listGird(tb1_wini_grid.page);
                get_docDetail(user_sn);
            }
            alert(str+" 되었습니다.");
        }       
    }
     
    //아이디 중복 체크
    function id_chechk(){
        
        var id = $('#user_id').val();
        if(id == ""){
            alert("ID를 입력하세요");
            $('#user_id').focus();
        }else{
            var ajax_set = 
            { 
                url:"./idChecking.do",
                param:"user_id="+id,        
                return_fn:function(jdata){id_chechk_result(jdata,id);}
            }
            winigrid_getDetail(ajax_set);
        }
    }
    
    //아이디 중복 체크 결과
    function id_chechk_result(jdata,id){
        
        if (jdata == null) {
            alert("체크를 실패하였습니다.");
            return false;
        }
        
        var check = jdata.rows[0];
        if(check.idCheck == 0){
           alert("사용가능한 아이디 입니다.");
           checked = true;
           $('#id_check').val(id);
        }else{
           alert("사용중인 아이디 입니다.");
           checked = false;
         }    
        
    }
    
    //필수항목 체크
    function t_checkNotNull(gbun_IUD) {
        
        if (gbun_IUD == "D" || gbun_IUD == "C") return true;
        
        
//         if($.trim($('#ward_id').val())==''){
//             alert("서/센터ID를 선택하세요");
//             $('#ward_id').focus();
//             return false;
//         }
        if($.trim($('#user_name').val())==''){
            alert("이름을 입력하세요");
            $('#user_name').focus();
            return false;
        }
        if($.trim($('#regno').val())==''){
            alert("사번를 입력하세요");
            $('#regno').focus();
            return false;
        }
//         if($.trim($('#work_cd').val())==''){
//             alert("직류를 선택하세요");
//             $('#work_cd').focus();
//             return false;
//         }
//         if($.trim($('#title_cd').val())==''){
//             alert("직위를 선택하세요");
//             $('#title_cd').focus();
//             return false;
//         }
        if($.trim($('#user_id').val())==''){
            alert("사용자ID를 입력하세요");
            $('#user_id').focus();
            return false;
        }
//         if($.trim($('#work_section_cd').val())==''){
//             alert("근무구분을 선택하세요");
//             $('#work_section_cd').focus();
//             return false;
//         }
        if($.trim($('#user_sttus_cd').val())==''){
            alert("승인 상태를 선택하세요");
            $('#user_sttus_cd').focus();
            return false;
        }
        if($.trim($('#sysmgr_yn').val())==''){
            alert("관리자여부 선택하세요");
            $('#sysmgr_yn').focus();
            return false;
        }
        if($.trim($('#user_pw').val())=='' && gbun_IUD=="I"){
            alert("비밀번호를 입력하세요");
            $('#user_pw').focus();
            return false;
        }
        if($.trim($('#user_pw').val()) != $.trim($('#user_pw_re').val()) && gbun_IUD=="I"){
            alert("비밀번호가 일치하지않습니다.");
            $('#user_pw_re').focus();
            return false;
        }
//         if(!emailCheck.test($('#email').val()) && $.trim($('#cell').val())!=''){
//             alert("이메일 형식이 맞지 않습니다.");
//             $('#email').focus();
//             return false;
//         }
//         if (!telCheck.test($('#cell').val()) && $.trim($('#cell').val())!='') {
//             alert("휴대전화번호 형식이 맞지 않습니다.");
//             $('#tel').focus();
//             return false;
//         }
        if(checked != true && gbun_IUD=="I"){
            alert("아이디 체크를 해주세요.");
            $('#user_id').focus();
            return false;
        }
        
        if(checked==false && gbun_IUD=="I"){
            alert("아이디가 중복입니다.");
            $('#user_id').focus();
            return false;
        }
        
        if($.trim($('#user_id').val())!=$.trim($('#id_check').val()) && gbun_IUD=="I"){
            alert("아이디 체크를 해주세요.");
            $('#user_id').focus();
            checked = false;
            return false;
        }
        
        if(regnoCheck != true && gbun_IUD=="I"){
            alert("사원번호 체크를 해주세요.");
            $('#regno').focus();
            return false;
        }
        
        if(regnoCheck ==false && gbun_IUD=="I"){
            alert("사원번호가 중복입니다.");
            $('#regno').focus();
            return false;
        }
        
        if($.trim($('#regno').val())!=$.trim($('#regno_check').val()) && gbun_IUD=="I"){
            alert("사원번호 체크를 해주세요.");
            $('#regno').focus();
            regnoCheck = false;
            return false;
        }
        return true;
    }   
    
    //전화번호 -삽입
    function insertHypen(tel)
    {
        var RemoveTempTel = removeHypen(tel.value);
        var CheckTempTel = tel.value;
        var chars = "-0123456789";
        
        if(containsCharsOnly(tel,chars) == false){
//             alert("숫자만 입력가능합니다.");
            tel.value = CheckTempTel.substring(0, CheckTempTel.length-1);
            tel.focus();
        }
        else {
            if(RemoveTempTel.length<=3) tel.value = RemoveTempTel;
            if (RemoveTempTel.length == 4) tel.value = RemoveTempTel.substring(0,3) + "-" + RemoveTempTel.substring(3,4); 
            if (RemoveTempTel.length == 5) tel.value = RemoveTempTel.substring(0,3) + "-" + RemoveTempTel.substring(3,5); 
            if (RemoveTempTel.length == 6) tel.value = RemoveTempTel.substring(0,3) + "-" + RemoveTempTel.substring(3,6); 
            if (RemoveTempTel.length == 7) tel.value = RemoveTempTel.substring(0,3) + "-" + RemoveTempTel.substring(3,6) + "-" + RemoveTempTel.substring(6,7); 
            if (RemoveTempTel.length == 8) tel.value = RemoveTempTel.substring(0,3) + "-" + RemoveTempTel.substring(3,6) + "-" + RemoveTempTel.substring(6,8);  
            if (RemoveTempTel.length == 9) tel.value = RemoveTempTel.substring(0,3) + "-" + RemoveTempTel.substring(3,6) + "-" + RemoveTempTel.substring(6,9); 
            if (RemoveTempTel.length == 10) tel.value = RemoveTempTel.substring(0,3) + "-" + RemoveTempTel.substring(3,6) + "-" + RemoveTempTel.substring(6,10);
            if (RemoveTempTel.length == 11) tel.value = RemoveTempTel.substring(0,3) + "-" + RemoveTempTel.substring(3,7) + "-" + RemoveTempTel.substring(7,11);
            if(RemoveTempTel.length >= 12){
                alert("전화번호 길이가 넘어갔습니다.");
                tel.value = RemoveTempTel.substring(0,3) + "-" + RemoveTempTel.substring(3,7) + "-" + RemoveTempTel.substring(7,11);
            }
        }
    }
    //전화번호 '-' 삭제
    function removeHypen(sNo) { 
        var reNo = "" 
        for(var i=0; i<sNo.length; i++) { 
        if ( sNo.charAt(i) != "-" ) { 
        reNo += sNo.charAt(i) 
        } 
      } 
        return reNo 
    }
    
 
    /**********************사원번호 중복체크*************************/
    function fn_regnoCheck(){
//        if($('#user_id').val().trim().length < 6 ) { alert('영문 또는 숫자 6~14자 이내로 입력하세요.'); $('#user_id').focus();  return;}
        regnoCheck = false;
        var regno = $('#regno').val();
        if(regno == null || regno ==''){ 
            alert('사원번호를 입력하세요.'); 
            $('#regno').focus(); 
            return; 
        }
        var ajax_set = 
        { 
            url:"./regnoChecking.do",
            param:"regno="+regno,
            return_fn:function(jdata){regno_result(jdata,regno);}      
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
                regnoCheck = false;
                return;
            }else if(check.regnoCheck == 0){
                alert("사용가능한 사원번호 입니다.");
                $('#regno_check').val(regno);
                regnoCheck = true;
                return;
            }
        }  
    }
    
    // 엑셀저장
    function listExcel() {
        document.frmS.target = "_blank";
        document.frmS.action = "./UserManagerExcel.do";
        document.frmS.submit();
    }