<%@ page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="ajax" uri="http://ajaxtags.sourceforge.net/tags/ajaxtags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader("Expires",0);
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
	<style>
	ul.checktree, ul.checktree ul {
	 list-style-type: none;
	 padding: 0;
	 margin: 0;
	 font: 15px sans-serif;
	}
	
	ul.checktree li {
	 background: url(http://www.blueb.co.kr/SRC/javascript/image3/node.gif) no-repeat;
	 margin: 0;
	 padding: 0 0 0 20px;
	 cursor: default;
	}
	ul.checktree li.last {
	 background-image: url(http://www.blueb.co.kr/SRC/javascript/image3/node-last.gif);
	}
	ul.checktree li.plus {
	 background-image: url(http://www.blueb.co.kr/SRC/javascript/image3/plus.gif);
	}
	ul.checktree li.plus-last {
	 background-image: url(http://www.blueb.co.kr/SRC/javascript/image3/plus-last.gif);
	}
	ul.checktree li.minus {
	 background-image: url(http://www.blueb.co.kr/SRC/javascript/image3/minus.gif);
	}
	ul.checktree li.minus-last {
	 background-image: url(http://www.blueb.co.kr/SRC/javascript/image3/minus-last.gif);
	}
	
	ul.checktree span.count {
	 text-indent: 5pt;
	 color: #999;
	 font-style: italic;
	}
	</style>
</head>
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
              <div class="col-md-11" style="float: none; margin: 0 auto;">
                  <!-- BEGIN SAMPLE TABLE PORTLET-->
                  <div class="portlet light portlet-fit bordered">
                      <div class="portlet-title">
                          <div class="caption">
                              <span class="caption-subject font-dark bold uppercase">권한메뉴관리</span>
                              </div>
                              <div class="actions">
                              
                          </div>    
                      </div>
                      <div class="portlet-body">
                      	<form name="schFrm" id="schFrm" method="post" action="<c:url value="/admin/adminMenu.do"/>">                      	
                      	<table class="table table-bordered">
                      		<colgroup>
                       			<col width="8%"/>
                       			<col width="38%"/>
                       			<col width="8%"/>
                       			<col width="38%"/>
                       			<col width="8%"/>
                       		</colgroup>
                      		<tr>           
                      			<th>권한 명</th>
                      			<td style="text-align:left;">
                      				<select name="search_auth" id="search_auth" style="width:200px;" onchange="searchFrm();">                      					
                      					<option value="0" ${param.search_auth=='0'?'selected':''}>일반 관리자</option>
                      					<option value="1" ${param.search_auth=='1'?'selected':''}>고급 관리자</option>                      					                      					                     					
                      					<option value="2" ${param.search_auth=='2'?'selected':''}>마스터 관리자</option>                      					                      					                     					
                      				</select>
                      			</td>
                      			
                      		</tr>
                      		
                      	</table>   
                      	</form>                   	
                      </div>
                      <div class="portlet-body">                      
                      <form id="Frm">
                      	<input type="hidden" name="admin_grade" id="admin_grade" value="">
						<ul id="tree-checkmenu" class="checktree">						 
						 <li id="show-netscape1">
						  <input id="check-netscape1" type="checkbox" />
						     기본설정
						  <span id="count-netscape1" class="count"></span>
						  <ul id="tree-netscape1">
						   	<c:forEach items="${adminMenuList}" var="adminMenuList">
						   	  <c:if test="${adminMenuList.menu_cd eq 1 and adminMenuList.seq_cd ne 1 and adminMenuList.seq_cd ne 6 and adminMenuList.seq_cd ne 7 and adminMenuList.seq_cd ne 5}">
						   	  	<li><input type="checkbox" name="menu1" value="${adminMenuList.seq_cd}" ${not empty adminMenuList.admin_grade ? 'checked':''}/>${adminMenuList.menu_nm}</li>
						   	  </c:if>
						   	</c:forEach>					   
						  </ul>
						 </li>
						 <li id="show-netscape2">
						  <input id="check-netscape2" type="checkbox" />
						     등록자
						  <span id="count-netscape2" class="count"></span>
						  <ul id="tree-netscape2">
						  	<c:forEach items="${adminMenuList}" var="adminMenuList">
						   	  <c:if test="${adminMenuList.menu_cd eq 2 and adminMenuList.seq_cd ne 1}">
						   	  	<li><input type="checkbox" name="menu2" value="${adminMenuList.seq_cd}" ${not empty adminMenuList.admin_grade ? 'checked':''}/>${adminMenuList.menu_nm}</li>
						   	  </c:if>
						   	</c:forEach>						   						   						   
						  </ul>
						 </li>
						 <li id="show-netscape3">
						  <input id="check-netscape3" type="checkbox" />
						     국민소통 게시판
						  <span id="count-netscape3" class="count"></span>
						  <ul id="tree-netscape3">
							  <c:forEach items="${adminMenuList}" var="adminMenuList">
							   	  <c:if test="${adminMenuList.menu_cd eq 3 and adminMenuList.seq_cd ne 1}">
							   	  	<li><input type="checkbox" name="menu3" value="${adminMenuList.seq_cd}" ${not empty adminMenuList.admin_grade ? 'checked':''}/>${adminMenuList.menu_nm}</li>
							   	  </c:if>
							  </c:forEach>						   						   						   						   						   
						  </ul>
						 </li>
						 <li id="show-netscape4">
						  <input id="check-netscape4" type="checkbox" />
						     정보공개 게시판
						  <span id="count-netscape4" class="count"></span>
						  <ul id="tree-netscape4">
						  	<c:forEach items="${adminMenuList}" var="adminMenuList">
						   	  <c:if test="${adminMenuList.menu_cd eq 4 and adminMenuList.seq_cd ne 1}">
						   	  	<li><input type="checkbox" name="menu4" value="${adminMenuList.seq_cd}" ${not empty adminMenuList.admin_grade ? 'checked':''}/>${adminMenuList.menu_nm}</li>
						   	  </c:if>
						   	</c:forEach>						   								   						   						   						   						   						   
						  </ul>
						 </li>						 
						 <li id="show-netscape6">
						  <input id="check-netscape6" type="checkbox" />
						     관리자
						  <span id="count-netscape6" class="count"></span>
						  <ul id="tree-netscape6">
						   	<c:forEach items="${adminMenuList}" var="adminMenuList">
						   	  <c:if test="${adminMenuList.menu_cd eq 6 and adminMenuList.seq_cd ne 1}">
						   	  	<li><input type="checkbox" name="menu6" value="${adminMenuList.seq_cd}" ${not empty adminMenuList.admin_grade ? 'checked':''}/>${adminMenuList.menu_nm}</li>
						   	  </c:if>
						   	</c:forEach>						   						   						   						   								   						   						   						   						   						   
						  </ul>
						 </li>
						 <li id="show-netscape7">
						  <input id="check-netscape7" type="checkbox" />
						     생명나눔 우체통 <br/>
						  <span id="count-netscape7" class="count"></span>
						  <ul id="tree-netscape7">
						   	<c:forEach items="${adminMenuList}" var="adminMenuList">
						   	  <c:if test="${adminMenuList.menu_cd eq 7 and adminMenuList.seq_cd ne 1}">
						   	  	<li><input type="checkbox" name="menu7" value="${adminMenuList.seq_cd}" ${not empty adminMenuList.admin_grade ? 'checked':''}/>${adminMenuList.menu_nm}</li>
						   	  </c:if>
						   	</c:forEach>						   						   						   						   								   						   						   						   						   						   						   						   						   						   						   								   						   						   						   						   						   
						  </ul>
						 </li>
						 <li id="show-netscape8">
						  <input id="check-netscape8" type="checkbox" />
						     통계메뉴
						  <span id="count-netscape8" class="count"></span>
						  <ul id="tree-netscape8">
						    <c:forEach items="${adminMenuList}" var="adminMenuList">
						   	  <c:if test="${adminMenuList.menu_cd eq 8 and adminMenuList.seq_cd ne 1}">
						   	  	<li><input type="checkbox" name="menu8" value="${adminMenuList.seq_cd}" ${not empty adminMenuList.admin_grade ? 'checked':''}/>${adminMenuList.menu_nm}</li>
						   	  </c:if>
						   	</c:forEach>						   						   						   						   						   						   						   						   
						  </ul>
						 </li>
						 <li id="show-netscape9">
						  <input id="check-netscape9" type="checkbox" />
						     병원관리
						  <span id="count-netscape9" class="count"></span>
						  <ul id="tree-netscape9">
						  	<c:forEach items="${adminMenuList}" var="adminMenuList">
						   	  <c:if test="${adminMenuList.menu_cd eq 9 and adminMenuList.seq_cd ne 1}">
						   	  	<li><input type="checkbox" name="menu9" value="${adminMenuList.seq_cd}" ${not empty adminMenuList.admin_grade ? 'checked':''}/>${adminMenuList.menu_nm}</li>
						   	  </c:if>
						   	</c:forEach>						   						   						   						   						   						   						   						   						   						   						   
						  </ul>
						 </li>
						 <li id="show-netscape10">
						  <input id="check-netscape10" type="checkbox" />
						     추모공간
						  <span id="count-netscape10" class="count"></span>
						  <ul id="tree-netscape10">
						  	<c:forEach items="${adminMenuList}" var="adminMenuList">
						   	  <c:if test="${adminMenuList.menu_cd eq 10 and adminMenuList.seq_cd ne 1}">
						   	  	<li><input type="checkbox" name="menu10" value="${adminMenuList.seq_cd}" ${not empty adminMenuList.admin_grade ? 'checked':''}/>${adminMenuList.menu_nm}</li>
						   	  </c:if>
						   	</c:forEach>						   						   						   						   						   						   						   						   						   						   						   
						  </ul>
						 </li>						 					 										 						 				 
						</ul>						
						</form>
						<div class="col-md-12 text-center">
	                        <br>
	                        <input type="button" id="saveBtn" value="메뉴저장" class="btn dark btn-outline btn-circle btn-sm" >
	                        <br>&nbsp
                    	</div>
                      </div>
                      
                      
                  </div>
                    
              </div>
          </div>
      </div>
      <!-- END CONTENT BODY -->
  </div> 
<c:import url="/webBottom.do" charEncoding="UTF-8"></c:import>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery_redirect/jquery.redirect.js" type="text/javascript"></script>

<script type="text/javascript">
function CheckTree(myName) {
	this.myName = myName;
	this.root = null;
	this.countAllLevels = false;
	this.checkFormat = '(%n% checked)';
	this.evtProcessed = navigator.userAgent.indexOf('Safari') > -1 ? 'safRtnVal' : 'returnValue';
		 CheckTree.list[myName] = this;
};
CheckTree.list = [];


// Called onload, this sets up a reference to the 'root' node and hides sublevels.
CheckTree.prototype.init = function() { with (this)
{
 if (!document.getElementById) return;
 root = document.getElementById('tree-' + myName);
 if (root)
 {
  var lists = root.getElementsByTagName('ul');
  for (var ul = 0; ul < lists.length; ul++)
  {
   // Hide all UL sublevels under the root node, and assign them a toggle/click methods.
   lists[ul].style.display = 'block';
   lists[ul].treeObj = this;
   lists[ul].setBoxStates = setBoxStates;

   var fn = new Function('e', 'this.setBoxStates(e)');
   // Grr, workaronud another Safari bug.
   if (lists[ul].addEventListener && navigator.vendor != 'Apple Computer, Inc.')
   {
    lists[ul].addEventListener('click', fn, false);
   }
   else lists[ul].onclick = fn;
  }

  // Now do a similar event capture setup for the 'root' node.
  root.treeObj = this;
  root.setBoxStates = setBoxStates;
  if (root.addEventListener && navigator.vendor != 'Apple Computer, Inc.')
  {
   root.addEventListener('click', new Function('e', myName + '.click(e)'), false);
  }
  else root.onclick = new Function('e', myName + '.click(e)');
  // Trigger a quick state update, to set the counters for each level.
  root.setBoxStates({}, true, true);

  // Now go through and assign plus/plus-last classes to the appropriate <LI>s.
  var nodes = root.getElementsByTagName('li');
  for (var li = 0; li < nodes.length; li++)
  {
   if (nodes[li].id.match(/^show-/))
   {
    nodes[li].className = (nodes[li].className=='last' ? 'plus-last' : 'minus');
   }
  }
 }
}};


// Called on click of the entire tree, this manages visibility of sublevels.
CheckTree.prototype.click = function(e) { with (this)
{
 e = e || window.event;
 var elm = e.srcElement || e.target;

 // Has a checkbox been clicked, but not processed by a lower level onclick event?
 // If so, one of the 'root' checkboxes must have been clicked.
 // We must therefore trigger a manual 'downwards route' for that tree to update it.
 if (!e[evtProcessed] && elm.id && elm.id.match(/^check-(.*)/))
 {
  var tree = document.getElementById('tree-' + RegExp.$1);
  if (tree) tree.setBoxStates(e, true, false);
 }

 while (elm)
 {
  // Dont' do expand/collapses for clicks on checkboxes, or nested within menus.
  if (elm.tagName.match(/^(input|ul)/i)) break;
  // Show/hide the menu element that matches the source id="show-xxx" tag and quit.
  if (elm.id && elm.id.match(/^show-(.*)/))
  {
   var targ = document.getElementById('tree-' + RegExp.$1);
   if (targ.style)
   {
    var col = (targ.style.display == 'none');
    targ.style.display = col ? 'block' : 'none';
    // Swap the class of the <span> tag inside, maintaining "-last" state if applied.
    elm.className = elm.className.replace(col?'plus':'minus', col?'minus':'plus');
   }
   break;
  }
  // Otherwise, continue looping up the DOM tree, looking for a match.
  elm = elm.parentNode;
 }
}};

function setBoxStates(e, routingDown, countOnly) { with (this)
{
 // Opera <7 fix... don't perform any actions in those browsers.
 if (!this.childNodes) return;

 e = e || window.event;
 var elm = e.srcElement || e.target;

 // Initial check: if the parent checkbox for a tree level has been clicked, trigger a
 // pre-emptive downwards route within that tree, and set returnValue to true so that we
 // don't repeat it or mess with any of the original checkbox's siblings.
 if (elm && elm.id && elm.id.match(/^check-(.*)/) && !routingDown && !e[treeObj.evtProcessed])
 {
  var refTree = document.getElementById('tree-' + RegExp.$1);
  if (refTree)
  {
   refTree.setBoxStates(e, true, countOnly);
   e[treeObj.evtProcessed] = true;
  }
 }

  // Some counter and reference variables.
 var allChecked = true, boxCount = 0, subBoxes = null;
 // Get the name of this branch and see if the source element has id="check-xxxx".
 var thisLevel = this.id.match(/^tree-(.*)/)[1];
 var parBox = document.getElementById('check-' + thisLevel);

 // Loop through all children of all list elements inside this UL tag.
 for (var li = 0; li < childNodes.length; li++)
 {
  for (var tag = 0; tag < childNodes[li].childNodes.length; tag++)
  {
   var child = childNodes[li].childNodes[tag];
   if (!child) continue;
   if (child.tagName && child.type && child.tagName.match(/^input/i) &&
    child.type.match(/^checkbox/i))
   {
    // Set this box's state depending on its parent state, if we're routing downwards.
    if (routingDown && parBox && elm && elm.id && elm.id.match(/^check-/) && !countOnly)
     child.checked = parBox.checked;
    // Count the checked boxes directly under this level.
    allChecked &= child.checked;
    if (child.checked) boxCount++;
   }
   // And route this event to sublevels, to update their nodes, during a downwards route.
   if (child.tagName && child.tagName.match(/^ul/i) && (!e[treeObj.evtProcessed] || routingDown))
    child.setBoxStates(e, true, countOnly);
  }
 }

 // Once we've routed the event to all sublevels, set the 'returnValue' to true, so that
 // upper levels don't re-trigger a downwards route. This is a bit of a hack, admittedly :).
 if (!routingDown) e[treeObj.evtProcessed] = true;

 // Next, set the parent parBox state depending if all checkboxes in this menu are checked.
 // Of course, we don't set its state if it's the source of the event!
 if (parBox && parBox != elm && !countOnly) parBox.checked = allChecked;

 // If "countAllLevels" is set, overwrite the previous one-level-only count.
 if (treeObj.countAllLevels)
 {
  boxCount = 0;
  var subBoxes = this.getElementsByTagName('input');
  for (var i = 0; i < subBoxes.length; i++) if (subBoxes[i].checked) boxCount++;
 }

 // Either way, assign the counted value to the id="count-xxx" page element.
 var countElm = document.getElementById('count-' + thisLevel);
 if (countElm)
 {
  while (countElm.firstChild) countElm.removeChild(countElm.firstChild);
  if (boxCount) countElm.appendChild(document.createTextNode(treeObj.checkFormat.replace('%n%',
   boxCount)));
 }
}};


// Calls the init() function of any active trees on page load, and backup previous onloads.
var chtOldOL = window.onload;
window.onload = function()
{
 if (chtOldOL) chtOldOL();
 for (var i in CheckTree.list) CheckTree.list[i].init();
};


function searchFrm(){
	$('#schFrm').submit();
}

$("#saveBtn").on("click",function(){
	
	$("#admin_grade").val($("#search_auth").val());
	
	if(confirm('메뉴저장 하시겠습니까? ')){
    	$.ajax({
            url : "/admin/adminMenuChange.do",
            type: "POST",
            data:$("#Frm").serialize(),
            dataType:"json", 
            success : function(data, textStatus, jqXHR) {
            	  alert(data);
            	  $('#schFrm').submit();                             
            }, 
            error : function(jqXHR, textStatus, errorThrown){
             	
            }
        });
    }
});

</script>
<script type="text/javascript">
<!--
var checkmenu = new CheckTree('checkmenu');
//-->
</script>

  
