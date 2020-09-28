/**********************게시판 목록보기*************************/
function fn_select_List(pageNo,sl,st,sc,sd,ed) {
	
	var bbscttSn = $('#bbscttSn').val();
	if (bbscttSn == null || bbscttSn == "") {
	    bbscttSn = "0";
    }
    document.frm.page.value = pageNo;
    document.frm.bbscttSn.value = bbscttSn;
	document.frm.action = "boardList.do";
    document.frm.submit();  
}

/**********************등록/수정*************************/

// 게시글 관리 메인 화면 이동
function go_boardMain(obj){
    alert("게시글 메인???");
    //location.href = "/winiWeb/board/boardMain.do?board_ward_id="+obj.value;
}

// 게시글 관리 리스트 화면 이동
function go_boardListPage(ward_id, bbsId, clsSn){
	
    if (clsSn == null)
        clsSn = "";
    
//    location.href = "../board/boardList.do?bbsParm_ward_id="+ward_id+"&bbsId="+bbsId+"&sl="+clsSn;
    location.href = "../board/boardList.do?bbsId="+bbsId+"&sl="+clsSn;
}

//게시글 관리  이미지 B형 리스트 
function go_imgBDetail(ward_id, bbsId,bbscttSn){
	document.frm.bbscttSn.value = bbscttSn;
//    location.href = "/gbitr/board/boardList.do?board_ward_id="+ward_id+"&bbsId="+bbsId+"&param_bbscttSn="+bbscttSn;
//	document.frm.action = "../board/boardList.do?board_ward_id="+ward_id+"&bbsId="+bbsId;
	document.frm.action = "../board/boardList.do?bbsId="+bbsId;
    document.frm.submit(); 
}

// 게시글 상세정보 화면 이동
function go_boardDetail(bbsId, page, bbscttSn,sl,st,sc,sd,ed){
    
//	document.frm.board_ward_id.value = ward_id;
	document.frm.iud.value =  "v";
	document.frm.bbsId.value = bbsId;
	document.frm.page.value = page;
	document.frm.bbscttSn.value = bbscttSn;
	document.frm.sl.value = sl;
	document.frm.st.value = st;
	document.frm.sc.value = sc;
	document.frm.sd.value = sd;
	document.frm.ed.value = ed;
//	location.href = "/gbitr/board/boardDetail.do?board_ward_id="+ward_id+"&bbsId="+bbsId+"&page="+page+"&bbscttSn="+bbscttSn;
	document.frm.action = "../board/boardDetail.do";
    document.frm.submit();  
}

// 게시글 등록/수정 화면 이동
function go_boardWritePage(bbsId, iud, page, bbscttSn,sl,st,sc,sd,ed){
	document.frm.bbsId.value = bbsId;
	document.frm.iud.value = iud;
	document.frm.page.value = page;
	document.frm.bbscttSn.value = bbscttSn;
	document.frm.sl.value = sl;
	document.frm.st.value = st;
	document.frm.sc.value = sc;
	document.frm.sd.value = sd;
    document.frm.ed.value = ed;
//    location.href = "/gbitr/board/boardWrite.do?board_ward_id="+ward_id+"&bbsId="+bbsId+"&iud="+iud+"&page="+page+"&bbscttSn="+bbscttSn;
	document.frm.action = "boardWrite.do";
    document.frm.submit();  
}

/********************** 파일 초기화(삭제)*************************/	  
function resetFileForm(id) { 
 
	 
	 var check = checkBrowser();
	 
		 if(check.name=='msie' && check.version < 10 ){
			    
		   	 $("#"+id).replaceWith( $("#"+id).clone(true) );
		    
		    }else{
		   	 $("#"+id).val("");
			 $("#"+id+'data').val("");
		    }
		 
   
 }

// 작성자 검색
function wrterSearch(userId){
    location.href = "../user/fireUserManager.do?srch_id="+userId;
    
}