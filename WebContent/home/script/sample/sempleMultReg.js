$(function(){
    
    /* 콤보 박스 셋팅1 */
    CodeUtil.setCodeList('combo', 'projectType', '2', '002', '', '선택', '');
    
    /* 콤보 박스 셋팅2 */
    CodeUtil.setCodeList('combo', 'projectStep', '2', '001', '', '선택', '');
    /* 콤보 박스 셋팅2 에 onchang 이벤트 처리 */
    $('#projectStep').on('change', function() {
        CodeUtil.setCodeList('combo', 'projectStepSub', '3', '001', this.value, '선택', '');
    });
    
    /* 날짜 샘플 셋팅 */
    wini_com_set_datepick("useDate", "0", true);
    
    $("#useDate").blur(function(){   wini_myDateChk(this, 'yyyymmdd');});
    
});

//필수항목 체크
function t_checkNotNull(gbun_IUD) {

    if (gbun_IUD == "D") return true;
    
    var tr_size = $('.d_tbody tr').size();
    
    for (var i = 0; i < tr_size; i++) {
    	 if($.trim($("input[name='userName']").eq(i).val()) == ''){
	        alert("이름을 입력하세요");
	        $("input[name='userName']").eq(i).focus();
	        return false;
	    }
    }
   
    
    return true;
}  

// 일괄등록 버튼 클릭
function saveMultReg() {
	
	var c_firm = "등록 하시겠습니까?"; 
	
	var iud = "I";
	if(t_checkNotNull(iud)){
        
        var ajax_set = 
        { 
            form_name:"#frmD",
            url:"./saveMultReg.do?iud="+iud,
            return_fn:function(jdata){submit_result(jdata,iud);}    
        };            
        
        wini_ajaxSubmit(ajax_set, c_firm);
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
           // listGrid(1); // 목록 재조회
        } else if (iud == "U") {
            str = "수정";   
            $('#grid_dataList').datagrid('reload');  // 현재페이지 목록 재조회
        } else if (iud == "D") {
            str = "삭제";          
          //  listGrid(1); // 목록 재조회
        }
        
        alert(str+" 되었습니다.");
                      
    }       
    
}


//행추가
var rowIdx = 0; // row Index 넘버링
var eventRow = 0; // 콤보박스 이벤트를 발생시키기 위한 변수
function fn_rowAdd(type) {
   rowIdx++;
   var trObj = '.d_tbody';	
   $add_html = $(trObj+' tr:last').clone();
   $('.d_tbody').append($add_html); 
   
   var rowSize = $(trObj+' tr').size()-1; // 행추가 후사이즈
   fn_chgInputId($add_html, rowSize, rowIdx); // input ID 부여
   
   // datepicker 형 선언 (기존class 삭제후 재선언해줘야 함)
   $("#useDate"+rowIdx).removeClass('hasDatepicker').datepicker();
   wini_com_set_datepick("useDate", "", true);
   
   // 동일한 콤보박스 이벤트 부여하니 id가 마지막 선언된 ID로만 이벤트가 발생하여 foucs 갈때마다 id를 알아오도록 변경
   $("select[name='projectStep']").focus(function(){ 
   	   eventRow = $("select[name='projectStep']").index(this);
   });
   
   // 콤보박스 이벤트 부여
   $('#projectStep'+rowIdx).off('change');
   $('#projectStep'+rowIdx).on('change', function() {
	   var cmbId = $("select[name='projectStepSub']").eq(eventRow).prop("id");
	   CodeUtil.setCodeList('combo', cmbId, '3', '001', this.value, '선택', '');
   });

   return rowSize;
}

// input, select ID 변경
function fn_chgInputId(obj, rowSize, rowIdx) {
	//var inpLen = $($add_html).find('input, select').length;
	
	$($add_html).find('input, select').each(function(){
		var input = $(this);
		var inputName = input.attr('name');
		var inputType = "";
		if (input.attr('type') == 'text' || input.attr('type') == 'checkbox') {
			inputType = "input";
		} else {
			inputType = "select";
		}
		
		$(inputType+'[name='+inputName+']').eq(rowSize).prop("id", inputName+rowIdx);
		
	    // select 는 clone로 값이 복사가 안되므로 이전값 가져와 셋팅
		if (inputType == "select") {
			$('select[name='+inputName+']').eq(rowSize).val($('select[name='+inputName+']').eq((rowSize-1)).val());
		}
	});
}

//행삭제
$(document).on('click','.row_delete',function () { 
   row_delete($(this)); 
});

//삭제함수
function row_delete(obj) {    
    if($('.d_tbody tr').size() > 1){ 
    	$(obj).parent().parent().remove(); 
    } 
    else { 
       alert('전체를 제거할 수 없습니다.'); 
       return false; 
    } 
} 