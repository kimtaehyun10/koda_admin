<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="ajax" uri="http://ajaxtags.sourceforge.net/tags/ajaxtags"%>
<!-- BEGIN FOOTER -->
<div class="page-footer">
    <div class="page-footer-inner"> 2020 한국장기조직기증원
        <a target="_blank" href=""></a> &nbsp;|&nbsp;
        <a href="" title="" target="_blank"></a>
    </div>
    <div class="scroll-to-top">
        <i class="icon-arrow-up"></i>
    </div>
</div>
<!-- END FOOTER -->
</div>
<!--[if lt IE 9]>
<script src="${pageContext.request.contextPath}/common/global/plugins/respond.min.js"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/excanvas.min.js"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/ie8.fix.min.js"></script>
<![endif]-->
<!-- BEGIN CORE PLUGINS -->
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>

<!-- image crop -->
<script src="${pageContext.request.contextPath}/common/js/crop/cropper.js"></script>
<script src="${pageContext.request.contextPath}/common/js/crop/main.js"></script>

<script src="${pageContext.request.contextPath}/common/global/plugins/js.cookie.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN THEME GLOBAL SCRIPTS -->
<script src="${pageContext.request.contextPath}/common/global/scripts/app.min.js" type="text/javascript"></script>
<!-- END THEME GLOBAL SCRIPTS -->

<!-- BEGIN THEME LAYOUT SCRIPTS -->
<script src="${pageContext.request.contextPath}/common/layouts/layout/scripts/layout.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/layouts/global/scripts/quick-nav.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/common/jquery.validate.js"></script>
<script src="${pageContext.request.contextPath}/common/validate.js"></script>
<script>
/* $(document).ready(function () {
	$("#admin_id").blur(function() {
	var admin_id = $("#admin_id").val();
	htmlobj = $.ajax({
		url: "<c:url value='/admin/ajaxCheckAdminId.do'/>",
		type: "POST",
		async:false ,
		dataType: "json",
		data: {
			   admin_id:admin_id
			  }
		});
		$("#check_admin").html(htmlobj.responseText);               
	});
}); */
</script>
<!-- END THEME LAYOUT SCRIPTS -->
<script>
  /*   $(document).ready(function()
    {
        $('#clickmewow').click(function()
        {
            $('#radio1003').attr('checked', 'checked');
        });
    }) */
</script>
</body>
</html>