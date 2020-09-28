<?php
defined('BASEPATH') OR exit('No direct script access allowed');
$this->load->view('include/header');
?>
<div class="container">
  <div class="row">
  <div id="left_menu">
      <div class="left_menu_top_title"> 주요 사업 </div>
      <div class="left_menu_content">
        <?php
        $count = 0;
        foreach($category_contents_list as $vv):
        $count++;
        ?>
        <a href="
        <?php if($count == 1):?>
        <?php echo site_url('contents/index/'.$vv['category_contents_index']);?>
        <?php endif;?>
        <?php if($count == 2):?>
        <?php echo site_url('contents/youth_education/'.$vv['category_contents_index']);?>
        <?php endif;?>
        <?php if($count == 6):?>
        <?php echo site_url('contents/product/'.$vv['category_contents_index']);?>
        <?php endif;?>
        <?php if( $count < 6 && $count > 2):?>
        <?php echo site_url('contents/culture/'.$vv['category_contents_index']);?>
        <?php endif;?>
        " <?php if($arr_contents['category_contents_index'] == $vv['category_contents_index']):?>class="active"<?php endif;?>>
        <div class="left_menu_content_menu">
          <div class="icon_images icon_1_<?php echo $count?>"> <span><?php echo $vv['category_contents_name']?></span> </div>
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
        <h2>
            <?php foreach($category_contents_list as $vvv):?>
                  <?php if($arr_contents['category_contents_index'] == $vvv['category_contents_index']):?><?php echo $vvv['category_contents_name']?><?php endif;?>
            <?php endforeach;?>
        </h2>
        <ol class="breadcrumb my_board">
          <li><a href="<?php echo site_url();?>">HOME</a></li>
          <?php
          $count = 0;
          foreach($category_contents_list as $vv):
          $count++;
          ?>
          <?php if($count == 1):?>
          <li><a href="<?php echo site_url('contents/index/'.$vv['category_contents_index']);?>"> 정책∙교육 문화 </a></li>
          <?php endif;?>
          <?php endforeach;?>
          <?php foreach($category_contents_list as $i):?>
           <?php if($arr_contents['category_contents_index'] == $i['category_contents_index']):?>
              <li class="active"><?php echo $i['category_contents_name']?></li>
          <?php endif;?>
          <?php endforeach;?>
        </ol>
      </div>
      <div class="right_content_text">
	  <p style="margin:0px;"><img src="<?php echo base_url(); ?>resource/home/images/kost_20180827_01.png" style="max-width: 100%"></p>
	  <p style="margin:0px;"><img src="<?php echo base_url(); ?>resource/home/images/kost_20180827_02.png" style="max-width: 100%"></p>
	  <p style="margin:0px;"><img src="<?php echo base_url(); ?>resource/home/images/kost_20180827_03.png" style="max-width: 100%"></p>
	  <p style="margin:0px;" class="pc_re"><img src="<?php echo base_url(); ?>resource/home/images/kost_20180827_04.png" usemap="#Map" style="max-width: 100%">
	  <map name="Map">
          <area shape="rect" coords="102,586,320,806" href="https://www.koda15440606.kr/index.php/culture/index/1/7" target="_blank">
          <area shape="rect" coords="336,584,557,805" href="https://www.koda15440606.kr/index.php/culture/index/1/6" target="_blank">
          <area shape="rect" coords="569,588,793,807" href="https://www.koda15440606.kr/index.php/culture/index/1/5" target="_blank">
          <area shape="rect" coords="104,228,421,429" href="https://www.koda15440606.kr/index.php/culture/culture_detail/62" target="_blank">
          <area shape="rect" coords="467,228,786,430" href="https://www.koda15440606.kr/index.php/culture/culture_detail/61" target="_blank">
        </map>
	  </p>
	  <p style="margin:0px;" class="mobile_re">
	  <img src="<?php echo base_url(); ?>resource/home/images/kost_20180827_mobile_01.png" style="max-width: 100%">
	  </p>
	   <p style="margin:0px;" class="mobile_re">
	   <a href="#" style="float:none; width:50%;">
	  <img src="<?php echo base_url(); ?>resource/home/images/kost_20180827_mobile_02.png" style="max-width: 100%">
	  </a>
	  <a href="#" style="float:none; width:50%;">
	  <img src="<?php echo base_url(); ?>resource/home/images/kost_20180827_mobile_03.png" style="max-width: 100%">
	  </a>
	  </p>
	  <p style="margin:0px;"><img src="<?php echo base_url(); ?>resource/home/images/kost_20180827_05.png" usemap="#Map2"  style="max-width: 100%">
	  <map name="Map2">
          <area shape="rect" coords="181,1592,727,1715" href="<?php echo base_url(); ?>resource/home/files/[안내 및 신청양식] 2018년 생명나눔 콘텐츠 리뷰 공모전_한국장기조직기증원.zip" download>
        </map>
	  </p>
	  <p style="margin:0px;"><img src="<?php echo base_url(); ?>resource/home/images/kost_20180827_06.png" style="max-width: 100%"></p>
      </div>
    </div>
  </div>
</div>
  </div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<style>
.pc_re{
display:block;
}
.mobile_re{
display:none;
}
@media(max-width:768px){
.pc_re{
display:none;
}
.mobile_re{
display:block;
}
}
</style>
<?php $this->load->view('include/right_menu');?>
<?php $this->load->view('include/footer');?>
