$(document).ready(function(){
	$(".introduction_images").hover(function() {
		var hover_images = $(this).attr("data-hover-images");
		$(this).attr("src",hover_images);
	});
	
$(".introduction_images").mouseleave(function(){
 		var src_images = $(this).attr("data-mouseleave-images");
		$(this).attr("src",src_images);
});
	$(".index_left_bar_close").click(function(){
	  if($(".index_left_bar_close").hasClass("index_left_bar_open")){
              $(".index_left_bar").animate({marginLeft:0});
		      $(this).removeClass("index_left_bar_open");
	  }else{
		      var index_left_bar_width = $(".index_left_bar").width();
              $(".index_left_bar").animate({marginLeft:-index_left_bar_width});
		      $(this).addClass("index_left_bar_open");  
	  }
  });
	
});