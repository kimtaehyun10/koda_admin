	
$(document).ready(function(){
	
	
   $('.left_menu_content > a').each(function(){
		if($($(this))[0].href==String(window.location))
			$(this).addClass('active');
	});
	
$(".left_table_button").click(function(){
	 if($(this).hasClass("close_btn")){
		 $(this).removeClass("close_btn");
		  $("#table_left").hide(300,function(){
		  var left_min_height = $("#right_content").outerHeight();
	 $("#left_menu").css("min-height",left_min_height);
		  
		  });
		  		
	  }else{
		   $(this).addClass("close_btn");
		  $("#table_left").show(300);
		  		var left_min_height = $("#right_content").outerHeight();
	 $("#left_menu").css("min-height",left_min_height);
	  }
});

$(".left_table_button_02").click(function(){
	 if($(this).hasClass("close_btn")){
		 $(this).removeClass("close_btn");
		  $("#table_left_02").hide(300,function(){
		  var left_min_height = $("#right_content").outerHeight();
	 $("#left_menu").css("min-height",left_min_height);
		  
		  });
	  }else{
		   $(this).addClass("close_btn");
		  $("#table_left_02").show(300);
		  		var left_min_height = $("#right_content").outerHeight();
	 $("#left_menu").css("min-height",left_min_height);
	  }
});
		
$(".right_table_button").click(function(){
	 if($(this).hasClass("close_btn")){
		 $(this).removeClass("close_btn");
		  $("#table_right").hide(300,function(){
		  var left_min_height = $("#right_content").outerHeight();
	 $("#left_menu").css("min-height",left_min_height);
		  
		  });
	  }else{
		   $(this).addClass("close_btn");
		  $("#table_right").show(300);
		  		var left_min_height = $("#right_content").outerHeight();
	 $("#left_menu").css("min-height",left_min_height);
	  }
	
 
});
	

	$(window).resize(function() {
		if($(".header_banner_btn").hasClass("header_banner_open")){
			var header_banner_height = $("#header_banner").height();
			$(".header_banner").css({marginTop:-header_banner_height});
		}else{
			
		}
		
		var left_min_height = $("#right_content").outerHeight();
	 $("#left_menu").css("min-height",left_min_height);
});
	
	/*dropdownOpen();*/
  $(".header_banner_btn").click(function(){
	  if($(".header_banner_btn").hasClass("header_banner_open")){
		      var header_banner_height = $("#header_banner").height();
              $(".header_banner").animate({marginTop:0});
		      $(this).removeClass("header_banner_open");
	  }else{
		      var header_banner_height = $("#header_banner").height();
              $(".header_banner").animate({marginTop:-header_banner_height-2});
		      $(this).addClass("header_banner_open");  
	  }
  });
	
	
	
	
	$("#header_nav").bootstrapDropdownOnHover({
 
  // Number of milliseconds to wait before closing the menu on mouseleave
  mouseOutDelay: 50,
 
  // Pixel width where the menus should no-longer be activated by hover
  responsiveThreshold: 767,
 
  // Whether to remove the menu backdrop upon hover
  hideBackdrop: true
   
});   
});