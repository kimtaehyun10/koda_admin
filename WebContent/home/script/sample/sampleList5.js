    // 목록 조회;
    function Search(){
        listGrid(1);
    }
    
    function listGrid(pageNum) {
        $('#grid_dataList').datagrid({
            url: './selectSample5List.do',
            queryParams:{
                            srch_name:$('#srch_name').val(),
                            srch_use_yn:$('#srch_use_yn').val()
                        },
            method: 'post',
            pageNumber:pageNum,
            /*title: '그리드 제목',*/
            width: 0,
            height: 310,
            fitColumns: true,
            singleSelect:true,
            rownumbers:true,
            autoRowHeight:false,
            pageSize:10,
            pageList:[10,20,30],
            pagination:true,
            onSelect: grid_Detail_Info,
            columns:[[
                {field:'id',title:'ID',width:80,align:'center'},
                {field:'name',title:'이름',width:80,align:'center'},
                {field:'description',title:'내용',width:200,align:'left'},
                {field:'useYn',title:'사용여부',width:50,align:'center',styler:cellStyler},
                {field:'regUser',title:'작성자',width:120,align:'center'}
            ]],
            onHeaderContextMenu: function(e, field){
                e.preventDefault();
            }
        });
    }
    
    function cellStyler(value,row,index){
        if (value == 'N'){
            return 'color:red;';
        }
    }
    
    /*******************************************************************************************
    * 목록 클릭
    ******************************************************************************************/
    function grid_Detail_Info(index, field){
        
        var row = $('#grid_dataList').datagrid('getSelected');  
        if (row){
            //alert(row.id);
            //alert(row.name);
            get_docDetail(row.id);
        }
        
    }
    
    
        
    // 상세조회 초기화
    function doClear() {
        $('#frmD')[0].reset();
        
        $('#use_yn_y').prop("checked",true);
        $('#use_yn_n').prop("checked",false);
        
        setButton('I');
    }
    
    function setButton(btnType) {        
        $('#b_Insert').css("display", "none");
        $('#b_Update').css("display", "none");
        $('#b_Delete').css("display", "none");
        
        if (btnType == 'I') {
            $('#b_Insert').css("display", "");
        } else if (btnType == 'U') {
            $('#b_Update').css("display", "");
            $('#b_Delete').css("display", "");
        }
    }
    
    //상세조회
    function get_docDetail(id){
        doClear();
        
        if (id == "") return;
        
        // 기안 상세정보
        var ajax_set = 
        { 
            url:"./selectSampleDetail.do",
            param:"id="+id,        
            return_fn:function(jdata){set_docDetail(jdata);}   
        };
        
        winigrid_getDetail(ajax_set);   
        
        setButton('U');
    }
    
    // 상세조회 셋팅
    function set_docDetail(jdata) {
    
        if (jdata == null) {
            alert("상세조회를 실패하였습니다.");
        }

        if (jdata.rows.length > 0){
    
            var detail = jdata.rows[0];
        
            $('#id').val(detail.id); 
            $('#name').val(detail.name);
            $('#description').val(detail.description);
            $('#reg_user').val(detail.regUser);
            if ( detail.useYn== 'Y') 
                $('#use_yn_y').prop("checked",true); 
            else  
                $('#use_yn_n').prop("checked",true);
            
        } else {
            alert("조회할 데이터가 없습니다.");
        } 
           
    }
    
    
    /*******************************************************************************************
    * 등록/수정/삭제
    ******************************************************************************************/
    function app_req(iud) {
        
        var c_firm = " 하시겠습니까?";
        if (iud == "I") {
            c_firm = "등록"+c_firm;
        } else if (iud == "U") {
            c_firm = "수정"+c_firm;         
        } else if (iud == "D") {
            c_firm = "삭제"+c_firm;         
        }

        if(t_checkNotNull(iud)){
            
            $('#use_yn').val($("input:radio[name=use_ynTmp]:checked").val());
            
            var ajax_set = 
            { 
                form_name:"#frmD",
                url:"./saveSample5.do?iud="+iud,
                return_fn:function(jdata){submit_result(jdata,iud);}    
            };            
            
            wini_submitIUD(ajax_set, c_firm);
        }
    }
  
    //처리결과
    function submit_result(jdata, iud) {

        if (jdata.errCd != null && jdata.errCd != "1") {
            alert(jdata.errMsg);
        } else {
            var str = "";
            if (iud == "I") {
                str = "등록";
                listGrid(1); // 목록 재조회
            } else if (iud == "U") {
                str = "수정";   
                $('#grid_dataList').datagrid('reload');  // 현재페이지 목록 재조회
            } else if (iud == "D") {
                str = "삭제";          
                listGrid(1); // 목록 재조회
            }
            
            alert(str+" 되었습니다.");
                          
        }       
        
    }
    
    //필수항목 체크
    function t_checkNotNull(gbun_IUD) {

        if (gbun_IUD == "D") return true;
            
        if($.trim($('#name').val())==''){
            alert("이름을 입력하세요");
            $('#name').focus();
            return false;
        }        
        
        return true;
    }    