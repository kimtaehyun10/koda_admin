<%@ page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="ajax" uri="http://ajaxtags.sourceforge.net/tags/ajaxtags"%>
<%@taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader("Expires",0);
%>
<%
/*
	-우체통 전체회원관리
	1.틀만 만들어놓음 작업해야함
*/
%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="ko">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <meta charset="utf-8" />
    <title>한국장기조직기증원 관리자페이지</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <meta content="한국장기조직기증원 관리자페이지" name="description" />
    <meta content="" name="author" />
	<c:import url="/webHeader.do" charEncoding="UTF-8"></c:import>
</head>
<style>
	section {
	    display: none;
	    padding: 20px 0 0;
	    border-top: 1px solid #ddd;}

	label {
	    display: inline-block;
	    margin: 0 0 -1px;
	    padding: 15px 25px;
	    font-weight: 600;
	    text-align: center;
	    color: #bbb;
	    border: 1px solid #eee;
	    /* border: 1px solid transparent; */
	}
	
	label:hover {
	    color: #2e9cdf;
	    cursor: pointer;
	}
	/*input 클릭시, label 스타일*/
	input:checked + label {
	      color: #555;
	      border: 1px solid #ddd;
	      border-top: 2px solid #2e9cdf;
	      border-bottom: 1px solid #ffffff;}
	#tab1:checked ~ #content1,
	#tab2:checked ~ #content2,
	#tab3:checked ~ #content3,
	{
	    display: block;
	}
</style>

<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/common/global/plugins/amcharts/amcharts/plugins/export/export.css" rel="stylesheet" type="text/css" media="all"/>

<!-- END HEAD -->
<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">
<c:import url="/webMenu.do" charEncoding="UTF-8"></c:import>

<!-- BEGIN CONTENT -->
<div class="page-content-wrapper">
	<!-- BEGIN CONTENT BODY -->
	<div class="page-content">
    	<!-- BEGIN PAGE HEADER-->                    
		<!-- END PAGE HEADER-->
		<div class="row" style="margin-top: 70px;">
			<div id="tabDiv">
				<input id="tab1" type="radio" name="tabs" value="" style="display:none;"checked> <!--디폴트 메뉴-->
				<label for="tab1">전체</label>
				
				<input id="tab2" type="radio" name="tabs" value="D" style="display:none;">
				<label for="tab2">기증자가족회원</label>
				
				<input id="tab3" type="radio" name="tabs" value="B" style="display:none;">
				<label for="tab3">수혜자회원</label>
			</div>
			<!-- 검색조건 div -->
			<div class="portlet-body">
			
					<input type="hidden" name="page" id="page" value="">
					
					<div class="post_searchBox">
						<table class="table table-bordered" style="margin-bottom: 0px;">
						<colgroup>
							<col width="20%">
							<col width="80%">
						</colgroup>
						<tbody>
							<tr>
								<th>검색조건</th>
								<td style="text-align:left;">
									<div>
										<select class="post_select" id="gubn" name="gubn">
											<option value=""> 구분 </option>
											<option value="D"> 기증자가족회원 </option>
											<option value="B"> 수혜자회원 </option>
										</select>
										
										<select class="post_select" id="searchType" name="searchType">
											<option value=""> 전체 </option>
											<option value="id"> 아이디 </option>
											<option value="name"> 이름 </option>
											<option value="phone"> 연락처 </option>
										</select>
										<input type="text" class="post_input300" id="searchText" name="searchText"/>
										<a id="btnSearch" class="btn dark btn-outline btn-circle btn-sm" href="#" onclick="page.fnInit();" style="margin-top: 6px; border-radius: 8px!important; width:80px;">검색</a>
									</div>
									
								</td>
							</tr>
						</tbody>
					</table> 
				</div>
			</div>
			<div align="right">
				<button type="button" class="btn blue page-title-element"  onClick="page.fnExcel();" style="padding-left:25px; padding-right:25px;">엑셀</button>
				<a style="line-height:60px" href="<c:url value='/mailbox/memberRegister.do'/>">
					<button id="memberRegister" class="btn blue page-title-element" type="button" style="padding-left:25px; padding-right:25px; margin:0px; margin-left: -5px;">
						회원 등록
					</button>
				</a>
			</div>
			
			<div id="tabContent">
			</div>
		</div>
		<input type="button" onclick="page.apprFlagUpdate();" value="선택항목 일괄변경"/>
	</div>
	
	<div id="sms_send_dialog" class="modal fade" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
	    	<div class="modal-content">
	        	<div class="modal-header">
	            	<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	               	<h4 class="modal-title">※ 문자발송</h4>
	           	</div>
	           	<div class="modal-body">
	            	<div class="" style="height:300px" data-always-visible="1" data-rail-visible1="1">
	                	<div class="row">
	                    	<div class="col-md-4"><h5>수신번호</h5></div>
	                       	<div class="col-md-8">
	                       		<input type="text" id="sms_sender_phone_no" name="sms_sender_phone_no" class="form-control col-md-12 input-sm" readonly="readonly"/>
	                       	</div>
	                   	</div>
	                   	<div class="row">
	                    	<div class="col-md-4"><h5>발신번호</h5></div>
	                       	<div class="col-md-8">
	                       		<input type="text" id="sms_receiver_phone_no" name="sms_receiver_phone_no" class="form-control col-md-12 input-sm" readonly="readonly"/>
	                       	</div>
	                   	</div>
	                   	<div class="row">
	                    	<div class="col-md-4"><h5>제목</h5></div>
	                       	<div class="col-md-8">
	                       		<input type="text" id="sms_title" name="sms_title" class="form-control col-md-12 input-sm" />
	                      	</div>
	                   	</div>
	                   	<div class="row">
	                    	<div class="col-md-4"><h5>내용</h5></div>
	                       	<div class="col-md-8">
	                       		<textarea id="sms_content" name="sms_content" class="form-control col-md-12 input-sm" rows="9"></textarea>
	                       	</div>
	                   	</div>
	               	</div>
	           	</div>
	           	<div class="modal-footer">
	            	<input type="button" type="button" class="btn blue" onclick="fnSms.fnSendSms();" value="보내기"></input>
	            </div>
	        </div>
	    </div>
	</div>
	
	<!-- END CONTENT BODY -->
</div>
  
<form id="frm_detail" class="form-horizontal" role="form" method="post" enctype="multipart/form-data" action="">
	<input type="hidden" id="id" name="id" value=""/>
	<input type="hidden" id="userId" name="userId" value=""/>
	<input type="hidden" id="inpType" name="inpType" value=""/>
</form>

<form name="matchPopupFrm" id="matchPopupFrm" method="post" action="" target="popup_window">
	<input type="hidden" id="pageRoute" name="pageRoute" value=""/>
	<input type="hidden" id="matchId" name="matchId" value=""/>
	<input type="hidden" id="matchGubn" name="matchGubn" value=""/>
	<input type="hidden" id="matchDonorName" name="matchDonorName" value=""/>
	<input type="hidden" id="matchDonorHospitalIdx" name="matchDonorHospitalIdx" value=""/>
	<input type="hidden" id="matchDonorHospitalName" name="matchDonorHospitalName" value=""/>
	<input type="hidden" id="matchDonorBirth" name="matchDonorBirth" value=""/>
	<input type="hidden" id="matchDonorDate" name="matchDonorDate" value=""/>
	<input type="hidden" id="benefiNames" name="benefiNames" value=""/>
	<input type="hidden" id="benefiBirths" name="benefiBirths" value=""/>
	<input type="hidden" id="benefiHospitalIdxs" name="benefiHospitalIdxs" value=""/>
	<input type="hidden" id="benefiHospitalNames" name="benefiHospitalNames" value=""/>
	<input type="hidden" id="benefiPartsIdxs" name="benefiPartsIdxs" value=""/>
	<input type="hidden" id="benefiPartsNames" name="benefiPartsNames" value=""/>
</form>
  
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery_redirect/jquery.redirect.js" type="text/javascript"></script>
 
<script type="text/javascript">
$(document).ready(function(){
	page.fnInit();
	page.fnAllCheckbox();
	tabAction.fnTabMove();	
});

var fnSms = {
	fnShowSmsModal:function(sender_phone_no, receiver_phone_no) {
		//$("#sms_sender_phone_no").val(sender_phone_no);
		$("#sms_sender_phone_no").val("02-3785-3177");
		$("#sms_receiver_phone_no").val(receiver_phone_no);
		$('#sms_send_dialog').modal('show');

	},
	fnSendSms:function() {
		fnSms.fnSendSmsAjax();
        $('#sms_send_dialog').modal('hide');
	},
	fnSendSmsAjax:function() {
		var obj = {};
		if($('#sms_sender_phone_no').val().trim() === '') {
			alert('수신번호가 존재하지 않습니다.');
			return;
		}
		if($('#sms_receiver_phone_no').val().trim() === '') {
			alert('발신번호가 존재하지 않습니다.');
			return;
		}
		if($('#sms_title').val().trim() === '') {
			alert('제목이 존재하지 않습니다.');
			return;
		}
		if($('#sms_content').val().trim() === '') {
			alert('내용이 존재하지 않습니다.');
			return;
		}
		var regHp = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
		/* if(!regHp.test($('#sms_sender_phone_no').val().trim())) {
		      alert("잘못된 휴대폰 번호입니다. 숫자, - 를 포함한 숫자만 입력하세요.");
		      return;
		} */
		
		if(!regHp.test($('#sms_receiver_phone_no').val().trim())) {
		      alert("잘못된 휴대폰 번호입니다. 숫자, - 를 포함한 숫자만 입력하세요.");
		      return;
		}
		
		obj.sms_sender_phone_no = $('#sms_sender_phone_no').val().trim();
		obj.sms_receiver_phone_no = $('#sms_receiver_phone_no').val().trim();
		obj.sms_title = $('#sms_title').val().trim();
		obj.sms_content = $('#sms_content').val().trim();
		obj.smsType = fnSms.fnGetSmsType();
		
		$.ajax({
			url: "<c:url value='/mailbox/ajaxSendSms.do'/>",
	        type: 'post',
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
	        data: obj,
	        dataType: "json",
	        success: function(data) {
	        	if(data != null && data.rtnCode == "") {
	            	toastr.options = {"positionClass": "toast-bottom-center"};
	                toastr.success(data.rtnMsg);
	            } else {
	            	toastr.options = {"positionClass": "toast-bottom-center"};
	            	toastr.success(data.rtnMsg);
	            }
	        },
	        error: function(xhr, desc, err) {
	            alert('SMS 전송에 실패했습니다. 잠시후에 다시 해주시기 바랍니다.')
	        }
	     });
	},
	fnGetSmsType:function() {
		var count_num = fnSms.fnCountUtf8Bytes($("#sms_content").val());
        if (count_num >= 90) {
            return 'L';
        } else {
            return 'S';
        }
	},
	fnCountUtf8Bytes:function(s) {
		var length = s.length;
		var charLength = 0;
		for (var i=0; i < length; i++) {
		    charLength += s.charCodeAt(i) > 0x00ff ? 2 : 1;
		}
		return charLength;
	}
}

var page = {
	fnInit:function(pageNo) {
		if(pageNo == null) {
			pageNo = '1';
		} else {
			pageNo = pageNo;
		}
		
		var gubn = $("#gubn option:selected").val();
		var searchType = $("#searchType option:selected").val();
		var searchText = $("#searchText").val();
		$.ajax({
	        url: "<c:url value='/mailbox/memberMgmtListAjax.do'/>",
	        type: "POST",
	        async: false,
	        dataType: "text",
	        data: {
	               type:gubn,
	               searchType:searchType,
	               searchText:searchText,
	               page:pageNo
	        },
	        success: function(data) {    	
	        	$("#tabContent").html(data);
	        },
	        error: function(xhr, desc, err) {
	            alert("조회 실패");
	        }
	    });  
	},
	fnExcel:function() {
		var gubn = $("#gubn option:selected").val();
		var searchType = $("#searchType option:selected").val();
		var searchText = $("#searchText").val();
		$.ajax({
			url: "<c:url value='/mailbox/exportExcelMemberList.do'/>",
	        type: 'post',
	        data: {
	        	type:gubn,
	        	searchType:searchType,
	            searchText:searchText
	        },
	        dataType: "json",
	        success: function(data) {
	             if(data != null && data.rtnCode == "") {
	             	var target_url = "<c:url value='/uploads/mailbox/member_list.xls'/>";
	                 window.open(target_url, 'excel');
	             } else {
	                 alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=1');
	             }
	         },
	         error: function(xhr, desc, err) {
	             alert('데이터 출력이 안됩니다. 잠시후에 다시 해주시기 바랍니다. code=2');
	         }
	     });
	},
	apprFlagUpdate:function() {
		var checkLen = $('input:checkbox[name="checkId"]:checked').length;

		if(checkLen == 0) {
			alert('체크된 항목이 없습니다.');
			return false;
		} else {
			var arrObj = [];
			
			$("input:checkbox[name=checkId]").each(function(index) {
				if(this.checked) {
					var obj = {};
					obj.arrId = this.value;
					obj.arrAppr = $("#apprFlag_"+(index+1)+" option:selected").val();
					obj.arrPhone = $("#phone_"+(index+1)).val();
					arrObj.push(obj);
				}
				
			});
			
			$.ajax({
		        url: "<c:url value='/mailbox/apprFlagUpdate.do'/>",
		        type: "POST",
		        async: false,
		        dataType: "json",
		        data: {
					arrData : JSON.stringify(arrObj)
		        },
		        success: function(data) {
		        	if(data.result > 0) {
			        	alert("저장 성공하였습니다.");
			        	
			        	//fnObj.fnSendSms();
			        	
			        	location.href = "/mailbox/memberMgmtList.do";
		        	} else {
		        		alert("저장 실패하였습니다.");
		        		return false;
		        	}
		        },
		        error: function(xhr, desc, err) {
		            alert("저장 실패");
		        }
		    });  
		}
	},
	fnAllCheckbox:function() {
		$("#allCheck").click(function(){ 
			if($("#allCheck").is(":checked")) {
				$("input[name='checkId']").prop("checked", true);
			} else {
				$("input[name='checkId']").prop("checked", false);
			}
		});
	},
	fnMemberDetail:function(id) {
		$('#id').val(id);
		$('#userId').val(id);
		$('#frm_detail').attr("action","/mailbox/memberDetail.do");
		$('#frm_detail').submit();	
	},
	fnMemberUpdate:function(id, type) {
		$('#userId').val(id);
		
		if(type == "D") {
			
			$("#inpType").val("D");
			var param = $("#frm_detail").serialize();			
			
			$.ajax({
		        url: "<c:url value='/mailbox/memberSave.do'/>",
		        type: "POST",
		        async: false,
		        dataType: "json",
		        data: param,
		        success: function(data) {    
		        	if(data.flag) {
		        		alert(data.msg);
		        		location.href = "/mailbox/memberMgmtList.do";
		        	} else {
		        		alert(data.msg);
		        		return false;
		        	}
		        },
		        error: function(xhr, desc, err) {
		            alert("저장 실패");
		        }
		    });  
			
		} else if(type == "U") {
			$('#frm_detail').attr("action","/mailbox/memberRegister.do");
			$('#frm_detail').submit();	
		}
		
	},
	
}

var fnPop = {
	fnMatchingPop:function(idx) {
		var gubn = $('#gubn_'+idx).val();
		var blCnt = $("#blCnt_"+idx).val();
		var dlCnt = $("#dlCnt_"+idx).val();
		$("#matchId").val($("#id_"+idx).val());
		$("#matchGubn").val($("#gubn_"+idx).val());
		
		
		if(gubn == "D") {
			if(blCnt == '0') {
				alert("입력된 수혜자 정보가 없습니다.");
				return false;	
			}
		} else {
			if(dlCnt == '0') {
				alert("입력된 기증자 정보가 없습니다.");
				return false;
			}
		}
		
		if(gubn == "D") {
			$("#benefiNames").val($("#benefiNames_"+idx).val());
			$("#benefiBirths").val($("#benefiBirths_"+idx).val());
			$("#benefiHospitalIdxs").val($("#benefiHospitalIdxs_"+idx).val());
			$("#benefiHospitalNames").val($("#benefiHospitalNames_"+idx).val());
			$("#benefiPartsIdxs").val($("#benefiPartsIdxs_"+idx).val());	
			$("#benefiPartsNames").val($("#benefiPartsNames_"+idx).val());	
		} else {
			$("#matchDonorName").val($("#matchDonorName_"+idx).val());
			$("#matchDonorHospitalIdx").val($("#matchDonorHospitalIdx_"+idx).val());
			$("#matchDonorHospitalName").val($("#matchDonorHospitalName_"+idx).val());
			$("#matchDonorBirth").val($("#matchDonorBirth_"+idx).val());
			$("#matchDonorDate").val($("#matchDonorDate_"+idx).val());
		}
		
		$("#pageRoute").val("memberMgmtList");
		
		$('#matchPopupFrm').attr("action","<c:url value='/mailbox/matchingPop.p'/>");

		var screenW = screen.availWidth;  
	    var screenH = screen.availHeight; 
	    var popW = 800; 
	    var popH = 350; 
	    var posL=( screenW-popW ) / 2;    
	    var posT=( screenH-popH ) / 2;    	
		window.open('','popup_window','width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=yes,status=no,titlebar=no');
		$('#matchPopupFrm').submit();	
		
	}	
}

var tabAction = {
	fnTabMove:function() {
		//radio 버튼 클릭 이벤트 
		$("input:radio[name=tabs]").click(function(){
			var gubn = $("input[name='tabs']:checked").val();
			
			if(gubn == "") {
				$("#gubn").removeAttr('disabled');
				$("#gubn").val("").prop("selected", true);
			} else if(gubn == "D") {
				$("#gubn").val("D").prop("selected", true);
				$("#gubn").attr('disabled', 'true');
			} else if(gubn == "B") {
				$("#gubn").val("B").prop("selected", true);
				$("#gubn").attr('disabled', 'true');
			}
			
			$.ajax({
		        url: "<c:url value='/mailbox/memberMgmtListAjax.do'/>",
		        type: "POST",
		        async: false,
		        dataType: "text",
		        data: {
		               type:gubn,
		        },
		        success: function(data) {            	
		        	$("#tabContent").html(data);
	            },
	            error: function(xhr, desc, err) {
	            	alert('실패');
	            }
		    });  
		});
	}
		
}
</script>