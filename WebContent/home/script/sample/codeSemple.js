$(function(){
    
    /* 콤보 박스 셋팅1 */
    CodeUtil.setCodeList('combo', 'cmbCode1', '2', '001', '', '선택', '');
    
    /* 콤보 박스 셋팅2 */
    CodeUtil.setCodeList('combo', 'cmbCode2', '2', '001', '', '선택', '');
    /* 콤보 박스 셋팅2 에 onchang 이벤트 처리 */
    $('#cmbCode2').on('change', function() {
        CodeUtil.setCodeList('combo', 'cmbCode2Sub', '3', '001', this.value, '선택', '');
    });
    
    /* 라디오 버튼 생성 */
    CodeUtil.setCodeList('radio', 'testCodeObj', '2', '001', '', null, '');
    
    /* 리스트 박스 셋팅 */
    CodeUtil.setCodeList('combo', 'cmbCode3', '2', '001', '', '선택', '');
    
});

// 콤보 박스 셋팅2 [수행(03) , 설계(0303)] 로 콤보 셋팅  
function fn_setCmbCode2() {
    var cd2 = '03';
    var cd3 = '0303';
    
    $('#cmbCode2').val(cd2);
    CodeUtil.setCodeList('combo', 'cmbCode2Sub', '3', '001', cd2, '선택', cd3);
}