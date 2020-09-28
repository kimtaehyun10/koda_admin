<?php
defined('BASEPATH') OR exit('No direct script access allowed');
$this->load->view('include/header');
?>
<div class="container">
  <div class="row">
    <div id="left_menu">
      <div class="left_menu_top_title"> 홍보센터 </div>

      <div class="left_menu_content">
	  <a class="active" href="<?php echo site_url('material/picture_list');?>" <?php if($arr_material['category_material_index'] == $vv['category_material_index']):?>class="active"<?php endif;?>>
        <div class="left_menu_content_menu">
          <div class="icon_images icon_1_1"> <span>홍보자료</span> </div>
        </div>
        </a>  
       	<?php 
        $count = 0;
        foreach($category_material_list as $vv):
        $count++;
        ?>

        <a href="<?php echo site_url('material/index/'.$vv['category_material_index']);?>" <?php if($arr_material['category_material_index'] == $vv['category_material_index']):?>class="active"<?php endif;?>>
        <div class="left_menu_content_menu">
          <div class="icon_images icon_1_<?php echo $count?>"> <span>교육자료<!--<?php echo $vv['category_material_name']?>--></span> </div>
        </div>
        </a>              
        <?php endforeach;?>
		
      </div>
      <div class="left_content_text_01"> 한 분의 따뜻한 기증자가 <br/>
        새 생명을 살릴 수 있는 기적을 <br/>
        만들어냅니다.<br/>
      </div>
      <div class="left_content_text_02"> <img src="<?php echo base_url(); ?>resource/home/images/left_text_img.png" style="max-width: 100%"> </div>
      <div class="left_content_bottom"> <img src="<?php echo base_url(); ?>resource/home/images/left_bottom_img.png" style="max-width: 100%"> </div>
    </div>
    <div id="right_content" >
      <div class="top_title">
        <h2>홍보자료<?php foreach($category_material_list as $vvv):?>
                  <?php if($arr_material['category_material_index'] == $vvv['category_material_index']):?><?php echo $vvv['category_material_name']?><?php endif;?>
            <?php endforeach;?></h2>
        <ol class="breadcrumb my_board">
        	<li><a href="<?php echo site_url();?>">HOME</a></li>
          	<?php 
        	$count = 0;
        	foreach($category_material_list as $vv):
        	$count++;
          	?>
          	<?php if($count == 1):?>
          	<li><a href="<?php echo site_url('material/index/'.$vv['category_material_index']);?>"> 홍보자료 </a></li>
      	  	<?php endif;?>
          	<?php endforeach;?>
          	<?php foreach($category_material_list as $i):?>
           	<?php if($arr_material['category_material_index'] == $i['category_material_index']):?>
          		<li class="active"><?php echo $i['category_material_name']?></li>
          	<?php endif;?>
          	<?php endforeach;?>
			<li class="active">홍보자료</li>
        </ol>
      </div>
      <div class="right_content_text">
        <p><img src="<?php echo base_url(); ?>resource/home/images/5-1-title-img.png" style="max-width: 100%;"></p>
<style>
	.pictrue_list{
		width: 100%;
		float: left;
	}
	.pictrue_list li{
		width: 16.666666666%;
		float: left;
		text-align: center;
		margin-bottom: 15px;
		box-sizing: border-box;
		padding: 5px;
		
	}
	.pictrue_list li .images{
		width: 100%;
		float: left;
		border: 1px solid #ccc;
		text-align: center;
	}
	.pictrue_list li .title{
		width: 100%;
		float: left;
		text-align: center;
		font-size: 14px;
	}
	.pictrue_list li .title a{
		font-size: 14px;
		color: #000;
	}
</style>
<ul class="pictrue_list">
	<li>
		<div class="images">
			<img src="<?php echo base_url(); ?>resource/home/images/001_hello.gif" style="max-width: 100%;">
		</div>
		<div class="title">
			<a href="<?php echo base_url(); ?>resource/home/images/001_hello.gif">다운로드</a>
		</div>
	</li>
	<li>
		<div class="images">
			<img src="<?php echo base_url(); ?>resource/home/images/002_lovely.gif" style="max-width: 100%;">
		</div>
		<div class="title">
			<a href="<?php echo base_url(); ?>resource/home/images/002_lovely.gif">다운로드</a>
		</div>
	</li>
		<li>
		<div class="images">
			<img src="<?php echo base_url(); ?>resource/home/images/003_lonely.gif" style="max-width: 100%;">
		</div>
		<div class="title">
			<a href="<?php echo base_url(); ?>resource/home/images/003_lonely.gif">다운로드</a>
		</div>
	</li>
		</li>
		<li>
		<div class="images">
			<img src="<?php echo base_url(); ?>resource/home/images/004_gnight.gif" style="max-width: 100%;">
		</div>
		<div class="title">
			<a href="<?php echo base_url(); ?>resource/home/images/004_gnight.gif">다운로드</a>
		</div>
	</li>
	<li>
		<div class="images">
			<img src="<?php echo base_url(); ?>resource/home/images/005_iloveu.gif" style="max-width: 100%;">
		</div>
		<div class="title">
			<a href="<?php echo base_url(); ?>resource/home/images/005_iloveu.gif">다운로드</a>
		</div>
	</li>
	<li>
		<div class="images">
			<img src="<?php echo base_url(); ?>resource/home/images/006_possi.gif" style="max-width: 100%;">
		</div>
		<div class="title">
			<a href="<?php echo base_url(); ?>resource/home/images/006_possi.gif">다운로드</a>
		</div>
	</li>
	<li>
		<div class="images">
			<img src="<?php echo base_url(); ?>resource/home/images/007_busy.gif" style="max-width: 100%;">
		</div>
		<div class="title">
			<a href="<?php echo base_url(); ?>resource/home/images/007_busy.gif">다운로드</a>
		</div>
	</li>
	<li>
		<div class="images">
			<img src="<?php echo base_url(); ?>resource/home/images/008_like.gif" style="max-width: 100%;">
		</div>
		<div class="title">
			<a href="<?php echo base_url(); ?>resource/home/images/008_like.gif">다운로드</a>
		</div>
	</li>
	<li>
		<div class="images">
			<img src="<?php echo base_url(); ?>resource/home/images/009_boring.gif" style="max-width: 100%;">
		</div>
		<div class="title">
			<a href="<?php echo base_url(); ?>resource/home/images/009_boring.gif">다운로드</a>
		</div>
	</li>
	<li>
		<div class="images">
			<img src="<?php echo base_url(); ?>resource/home/images/010_fun.gif" style="max-width: 100%;">
		</div>
		<div class="title">
			<a href="<?php echo base_url(); ?>resource/home/images/010_fun.gif">다운로드</a>
		</div>
	</li>
	<li>
		<div class="images">
			<img src="<?php echo base_url(); ?>resource/home/images/011_sad.gif" style="max-width: 100%;">
		</div>
		<div class="title">
			<a href="<?php echo base_url(); ?>resource/home/images/011_sad.gif">다운로드</a>
		</div>
	</li>
	<li>
		<div class="images">
			<img src="<?php echo base_url(); ?>resource/home/images/012_best.gif" style="max-width: 100%;">
		</div>
		<div class="title">
			<a href="<?php echo base_url(); ?>resource/home/images/012_best.gif">다운로드</a>
		</div>
	</li>
	<li>
		<div class="images">
			<img src="<?php echo base_url(); ?>resource/home/images/013_cheer.gif" style="max-width: 100%;">
		</div>
		<div class="title">
			<a href="<?php echo base_url(); ?>resource/home/images/013_cheer.gif">다운로드</a>
		</div>
	</li>
	<li>
		<div class="images">
			<img src="<?php echo base_url(); ?>resource/home/images/014_what.gif" style="max-width: 100%;">
		</div>
		<div class="title">
			<a href="<?php echo base_url(); ?>resource/home/images/014_what.gif">다운로드</a>
		</div>
	</li>
	<li>
		<div class="images">
			<img src="<?php echo base_url(); ?>resource/home/images/015_ang.gif" style="max-width: 100%;">
		</div>
		<div class="title">
			<a href="<?php echo base_url(); ?>resource/home/images/015_ang.gif">다운로드</a>
		</div>
	</li>
	<li>
		<div class="images">
			<img src="<?php echo base_url(); ?>resource/home/images/016_tired.gif" style="max-width: 100%;">
		</div>
		<div class="title">
			<a href="<?php echo base_url(); ?>resource/home/images/016_tired.gif">다운로드</a>
		</div>
	</li>
</ul>

      </div>
    </div>
  </div>
</div>
<?php $this->load->view('include/right_menu');?>
<?php $this->load->view('include/footer');?>