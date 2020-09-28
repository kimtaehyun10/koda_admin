 $(window).load(function() {
        var left_min_height = $("#right_content").outerHeight();
	 $("#left_menu").css("min-height",left_min_height);
  });
$('a[data-toggle="tab"]').on('shown.bs.tab', function () {
        var left_min_height = $("#right_content").outerHeight();
	 $("#left_menu").css("min-height",left_min_height);
})