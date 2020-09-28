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
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>한국장기조직기증원 대국민소통사업단</title>
    <meta name="description" content="대국민소통사업단 소개, 기증과정안내, 문화콘텐츠 안내">

    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/home/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/home/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/home/css/animations.css" rel="stylesheet" >
    <link href="${pageContext.request.contextPath}/common/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css"/>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>

<div class="container">
<div class="row">

<div id="right_content">
    <div class="top_title">
        <h2>희망서약 하기</h2>
    </div>
    <div class="right_content_text" style="position: relative;">
        <style>
            .return_content_boder{
                width: 100%;
                /*height: 100%;
                position: absolute;
                z-index: 99;*/
                float: left;
                background: #fff;
                padding:15px;
                box-sizing: border-box;
            }
            .return_content{
                width: 100%;
                float: left;
                height: 100%;
            }
            .return_content_title{
                width: 100%;
                float: left;
                font-size: 20px;
                padding: 10px 8px;
                background: #000;
                color: #fff;
                box-sizing: border-box;
            }
            .return_content_title > a{
                float: right;
                color: #fff;
            }
            .return_content_text{
                width: 100%;
                margin: 50px auto;
                overflow: hidden;
                max-width: 700px;
                border: 1px solid #1c1819;
                -moz-border-radius: 15px;
                -webkit-border-radius: 15px;
                -o-border-radius: 15px;
                -ms-border-radius: 15px;
                border-radius: 15px;
            }
            .return_content_text_title{
                width: 100%;
                float:left;
                background: #ec1b30;
                font-size: 34px;
                font-weight: bold;
                box-sizing: border-box;
                color: #fff;
                padding:20px 30px 15px 30px;
            }

            .return_content_text_content{
                width: 100%;
                float: left;
                padding: 30px 0;
            }
            .return_content_text_bottom{
                width: 100%;
                float: left;
                padding:10px 10px;
                background: #c9cacc;
                overflow: hidden;
                box-sizing: border-box;
            }
            @media (max-width:1024px){
                .first_form_group{
                    margin-bottom: 15px !important;
                }
                .return_content{
                    height: auto !important;
                }

            }
            @media (max-width:768px){
                .return_content_text{

                    max-width: 100%;

                }
            }
        </style>

        <!--add   return-->

        <div class="return_content_boder">
            <div class="return_content">
                <h4>이미 서약하신 회원입니다.</h4>
                <div class="clearfix"></div>
                <div class="return_content_text">
                    <div class="return_content_text_title">
                        <h2 style="float: left; font-family:'나눔고딕';">기증희망등록증</h2>
                        <img src="${pageContext.request.contextPath}/home/images/return_img.jpg" class="return_img" style="float: right;">
                    </div>
                    <div class="return_content_text_content">

                        <form class="form-horizontal">
                            <div class="col-md-12" style="padding:0;">
                                <div class="col-md-6">
                                    <div class="form-group first_form_group" style="margin-bottom: 100px;">
                                        <label class="col-md-4 control-label" style="font-size: 18px;">성명 :</label>
                                        <div class="col-md-8" style="font-size: 18px; padding-top: 7px;">
                                            ${user_detail.user_name}
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="col-md-4 control-label" style="font-size: 18px;">서약기관: </label>
                                        <div class="col-md-8" style="font-size: 18px; padding-top: 7px;">
                                            한국장기조직기증원
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label" style="font-size: 18px;">서약번호:</label>
                                        <div class="col-md-8" style="font-size: 18px; padding-top: 7px;">
                                            ${user_detail.user_num}
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label" style="font-size: 18px;">서약일자:</label>
                                        <div class="col-md-8" style="font-size: 18px; padding-top: 7px;">
                                            ${user_detail.user_pledge_date}
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-md-2 control-label" style="font-size: 18px;">기증형태 :</label>
                                    <div class="col-md-10" style=" font-size: 18px; padding-top: 7px;">
                                        ${donation_type_string}
                                    </div>
                                </div>
                            </div>
                        </form>

                    </div>
                    <div class="return_content_text_bottom">
                        <div class="col-md-7" style="padding: 0px 5px;">
                            <p style="font-size: 13px; color: #1c1819; font-weight: bold; letter-spacing: -1px; font-family:'나눔고딕'; padding-top: 15px;">
                                카드는 항상 휴대하시고, 분실시 재발급 받으시기 바랍니다.<br>
                                *본 증을 습득하신 분은 1544-0606으로 연락 주시기 바랍니다.<br>
                            </p>

                        </div>
                        <div class="col-md-5" style="padding: 0px 10px;">
                            <p style="font-size: 24px; color: #1c1819; font-weight: bold; letter-spacing: -1px; font-family:'나눔고딕';">
                                서약문의:1544-0606<br>
                                기증발생:1577-1458<br>
                            </p>

                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!--add   return-->




    </div>
</div>
</div> </div>
<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="footer_logo"> <a href="#"><img src="${pageContext.request.contextPath}/home/images/footer_logo.png" style="max-width: 100%;"></a> </div>
            <div class="footer_content">
                <div class="footer_top">
                    <div class="footer_content_nav"> <a href="#" data-toggle="modal" data-target="#footer_Modal_text">개인정보처리방침</a> </div>
                    <div class="modal fade" id="footer_Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                        <div class="modal-dialog" role="document" style="max-width:780px; width:100%;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                </div>
                                <div class="modal-body" style="text-align:center;">
                                    <a href="${pageContext.request.contextPath}/home/images/web-map-popup-images.jpg"><img src="${pageContext.request.contextPath}/home/images/web-map-popup-images.jpg" style="max-width: 100%;"></a>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal fade" id="footer_Modal_text" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                        <div class="modal-dialog" role="document" style="width:100%; max-width:850px;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title" style="float:left; font-weight:bold;">개인정보 보호정책</h4>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                </div>
                                <div class="modal-body" style="text-align:left;padding:15px 25px;">
                                    <p style="font-size:14px; line-height:25px;">
                                        한국장기조직기증원이 취급하는 모든 개인정보는 관련법령에 근거하거나<br>정보주체의 동의에 의하여
                                        수집ㆍ보유 및 처리되고 있습니다.<br>「개인정보보호법」은 개인정보의 취급에 대한 일반적 규범을 제시하고 있으며, <br>
                                        한국장기조직기증원은 이러한 법령의 규정에 따라 수집ㆍ보유 및 처리하는 개인정보를 공공업무의 <br>
                                        적절한 수행과 국민의 권익을 보호하기 위해 적법하고 적정하게 취급할 것입니다. 또한, <br>
                                        기증원은 관련법령에서 규정한 바에 따라 보유하고 있는 개인저옵에 대한 열람청구권 및 정정청구권 등 여러분의 권익을 존중합니다.
                                        <br><br>
                                        ■ 개인정보의 처리 목적, 처리 및 보유기간, 처리하는 개인정보의 항목
                                        <br>
                                        한국장기조직기증원은 개인정보를 다음의 목적을 위해 처리합니다. <br>
                                        처리한 개인정보는 다음의 목적이외의 용도로는 사용되지 않으며 이용 목적이 변경되는 경우에는 개인정보 보호법에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.<br>
                                        1. 한국장기조직기증원에서 법령의 규정에 근거하여 수집ㆍ보유하고 있는 주요 개인 정보항목<br>

                                        개인정보파일 운용 주체	한국장기조직기증원 대국민소통사업단<br>
                                        개인정보파일의 명칭	장기기증 관련 정보<br>
                                        개인정보파일의 보유근거	장기등 이식에 관한 법률<br>
                                        개인정보파일의 보유목적	뇌사 장기기증 관련 정보 관리<br>
                                        개인정보파일 항목	인적정보(이름, 주민번호, 주소, 전화번호, 보호자정보) 개인정보동의정보,서약정보
                                        보유기간	반영구<br>


                                        개인정보파일 운용 주체	한국장기조직기증원 대국민소통사업단<br>
                                        개인정보파일의 명칭	서약정보<br>
                                        개인정보파일 항목	서약직접입력정보<br>
                                        보유기간	반영구<br>

                                        <br>
                                        2. 개인정보의 제3자 제공<br>
                                        <br>
                                        한국장기조직기증원은 원칙적으로 정보주체의 개인정보를 수집ㆍ이용 목적으로 명시한 범위 내에서 처리하며, 다음의 경우를 제외하고는 정보주체의 사전 동의 없이는 본래의 목적 범위를 초과하여 처리하거나 제3자에게 제공하지 않습니다.<br>
                                        - 정보주체로부터 별도의 동의를 받는 경우<br>
                                        - 법률에 특별한 규정이 있는 경우<br>
                                        - 정보주체 또는 법정대리인이 의사표시를 할 수 없는 상태에 있거나 주소불명 등으로 사전 동의를 받을 수 없는 경우로서 명백히 정보주체 또는 제3자의 급박한 생명, 신체, 재산의 이익을 위하여 필요하다고 인정되는 경우<br>
                                        - 통계작성 및 학술연구 등의 목적을 위하여 필요한 경우로서 특정 개인을 알아 볼 수 없는 형태로 개인정보를 제공하는 경우<br>
                                        - 개인정보를 목적 외의 용도로 이용하거나 이를 제3자에게 제공하지 아니하면 다른 법률에서 정하는 소관 업무를 수행할 수 없는 경우로서 보호위원회의 심의ㆍ의결을 거친 경우<br>
                                        - 조약, 그 밖의 국제협정의 이행을 위하여 외국정부 또는 국제기구에 제공하기 위하여 필요한 경우<br>
                                        - 범죄의 수사와 공소의 제기 및 유지를 위하여 필요한 경우<br>
                                        - 형 및 감호, 보호처분의 집행을 위하여 필요한 경우<br>
                                        - 한국장기조직기증원은 다음과 같이 개인정보를 제3자에게 제공하고 있습니다.<br>
                                        ㆍ 개인정보를 제공받는 자 : 국립장기이식관리기관의 장<br>
                                        ㆍ 제공받는 자의 개인정보 이용목적 : 뇌사 장기기증 관련 업무<br>
                                        ㆍ 제공하는 개인정보 항목 : 뇌사 추정 통보자 정보(의료기관의 명칭, 성명), 뇌사 추정자(성명, 생년월일, 주소, 의식수준, 발생원인)<br>
                                        ㆍ 제공받는 자의 보유ㆍ이용기간 : 반영구<br>
                                        3. 개인정보의 파기절차 및 방법<br>

                                        한국장기조직기증원은 원칙적으로 개인정보의 수집 및 이용목적이 달성된 후에는 개인정보를 지체 없이 파기합니다. 기증원의 개인정보 파기절차 및 방법은 다음과 같습니다.<br>
                                        1) 파기절차 : 입력한 정보는 목적이 달성된 후 별도의 DB로 옮겨져(종이의 경우 별도의 서류함 보관) 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(보유 및 이용기간 참조) 일정 기간 저장된 후 파기됩니다.<br>
                                        별도 DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 보유되는 이외의 다른 목적으로 이용되지 않습니다.<br>
                                        2) 파기방법 : 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제됩니다. 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기됩니다.<br>
                                        4. 이용자의 개인정보 관리 (열람, 정정, 삭제 등)에 관한 사항<br>

                                        정보주체는 언제든지 등록되어 있는 자신의 개인정보를 조회하거나 수정할 수 있으며 열람, 정정, 삭제, 처리정지 등의 요구는 아래와 같습니다.<br>
                                        ① 정보주체는「개인정보 보호법」제35조 내지 제37조에 따라 개인정보의 열람, 정정·삭제, 처리정지 등의 요구(이하 “열람등요구”)를 할 수 있습니다. 또한 만 14세 미만 아동의 법정대리인은 그 아동의 개인정보에 대하여 열람등요구를 할 수 있습니다.<br>
                                        ② 제1항에 따른 권리 행사는[개인정보 보호법]시행규칙 별지 제8호 서식에 따라 작성 후 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며, 이에 대해 지체 없이 조치하겠습니다.<br>
                                        ③ 정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.<br>
                                        ④ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우[개인정보 보호법]시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.<br>
                                        ⑤ 개인정보 열람 및 처리정지 요구는[개인정보 보호법]제35조제5항, 제37조제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.<br>
                                        ⑥ 개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.<br>
                                        ⑦ 정보주체 권리에 따른 열람의 요구, 정정·삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.<br>
                                        ⑧ 정보주체는 열람등 요구를 개인정보보호 담당자를 통하여 할 수 있습니다.<br>
                                        ⑨ 정보주체는 제8항의 열람청구 접수ㆍ처리부서 이외에, 행정자치부의 '개인정보보호 종합포털'웹사이트(www.privacy.go.kr)에서도 개인정보 열람청구를 하실 수 있습니다.<br>
                                        ☞ 행정자치부 개인정보보호 종합포털 → 개인정보 민원 → 개인정보 열람 등 요구(본인 확인을 위하여 아이핀(I-PIN)이 있어야 함)<br>
                                        <br>
                                        개인정보보호 종합포털 바로가기<br>
                                        5. 14세 미만 아동개인정보 보호<br>
                                        <br>
                                        '개인정보 보호법'상 만 14세 미만의 아동은 온라인으로 타인에게 개인정보를 보내기 전에 반드시 개인정보의 수집 및 이용목적에 대하여 충분히 숙지하고 법정대리인(부모)의 동의를 받아야 합니다. 이에 기증원은 홈페이지 회원가입 절차에서 위 사항을 설명하고 있으며 회원 가입 시에는 반드시 법정대리인(부모)의 동의를 받는 확인절차를 거치고 있습니다.<br>
                                        법정대리인의 성명, 생년월일, 이메일주소(전자우편을 통한 동의 선택시)는 아동의 개인정보 수집에 대한 동의여부 확인의 목적으로 사용되며, 해당 정보는 아동의 회원 탈퇴 시까지 보유합니다.<br>
                                        만 14세 미만 아동의 법정 대리인(부모)은 아동의 개인정보 열람, 정정, 동의 철회를 요청할 수 있으며, 이러한 요청이 있을 경우 기증원은 지체 없이 필요한 조치를 취합니다.<br>
                                        6. 개인정보 자동수집 장치의 설치, 운영 및 그 거부에 관한 사항<br><br>

                                        기증원은 후원자 혹은 법정 대리인의 요청에 의해 해지 또는 삭제된 개인정보를 “기증원이 수집하는 개인정보의 보유 및 이용기간”에 명시된 바에 따라 처리하고, 그 외의 용도로 열람 또는 이용할 수 없도록 처리합니다.<br>
                                        기증원은 후원자 및 방문자의 정보를 수시로 저장하고 찾아내는 '쿠키(cookie)' 등을 운용합니다. 쿠키란 기증원의 홈페이지 운영을 위해 사용하는 서버가 사용자의 브라우저에 보내는 아주 작은 텍스트 파일로서 사용자의 컴퓨터 하드디스크에 저장됩니다. 기증원은 다음과 같은 목적을 위해 쿠키를 사용합니다.<br>
                                        쿠키 등 사용 목적 : 회원과 비회원의 접속 빈도나 방문 시간 등을 분석, 후원자의 취향과 관심분야 파악 및 자취 추적, 각종 이벤트 참여 정도 및 방문 횟수 파악<br>
                                        7. 개인정보의 기술적, 관리적 보호대책<br>
                                        <br>
                                        정보주체는 쿠키 설치에 대한 선택권을 가지고 있습니다. 따라서 후원자는 웹브라우저에서 옵션을 설정함으로써 모든 쿠키를 허용하거나, 쿠키가 저장될 때마다 확인을 거치거나, 아니면 모든 쿠키의 저장을 거부할 수도 있습니다.<br>
                                        기증원은 정보주체의 개인정보를 취급함에 있어 개인정보가 분실, 도난, 누출, 변조 또는 훼손되지 않도록 안전성 확보를 위하여 다음과 같은 기술적, 관리적 대책을 강구합니다.<br>
                                        1) 개인정보의 기술적/관리적 운영 : 기증원의 개인정보보호담당자는 내부관리계획을 바탕으로 한 철저한 관리감독과 교육을 통해 개인정보가 분실, 도난, 누출, 변조 또는 훼손되지 않도록 최선을 다하고 있습니다.<br>
                                        2) 해킹 등에 대한 대비책 : 개인정보의 훼손에 대비해서 자료를 수시로 백업하고 있고, 최신 백신프로그램을 이용하여 후원자들의 개인정보나 자료가 누출되거나 손상되지 않도록 방지하고 있으며, 암호화 통신 등을 통하여 네트워크상에서 개인정보를 안전하게 전송하도록 의무화합니다.<br>
                                        3) 개인정보 취급 직원의 교육 : 기증원은 개인정보보호법의 지침에 따라 내부관리계획을 수립하여 시행하며, 개인정보보호와 관련된 문제가 발생되지 않도록 노력하고, 문제가 발생할 경우 즉시 수정하고 바로잡을 수 있도록 최선을 다하고 있습니다.<br><br>
                                        8. 개인정보에 관한 민원서비스<br>
                                        <br>
                                        한국장기조직기증원은 후원자의 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 아래와 같이 관련 부서 및 개인정보 관리 책임자와 관리담당자를 지정하고 있습니다.<br>
                                        개인정보보호 책임자<br>
                                        성명 : 동복희<br>
                                        직책 : 서약운영팀 과장<br>
                                        연락처 : 02-3785-3177, 이메일 : bh.dong@koda1458.kr<br>

                                        <br>
                                        한국장기조직기증원의 후원자로 등록된 분들은 기관의 서비스를 이용하시며 발생하는 모든 개인정보보호 관련 민원을 개인정보관리 책임자 혹은 담당부서로 신고하실 수 있습니다. 한국장기조직기증원은 접수되는 신고사항에 대해 신속하게 충분한 답변을 드릴 것입니다.<br>
                                        기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.<br>
                                        1. 개인정보침해신고센터 (www.1336.or.kr/ 국번 없이 118)<br>
                                        2. 정보보호마크인증위원회 (www.eprivacy.or.kr / 02-550-9531~2)<br>
                                        3. 대검찰청 인터넷범죄수사센터 (http://www.spo.go.k / 02-3480-2000)<br>
                                        4. 경찰청 사이버테러대응센터 (www.ctrc.go.kr / 1566-0112)<br>
                                        9. 부칙<br>
                                        <br><br>
                                        이 방침은 2017년 7월 1일부터 시행합니다.<br></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="footer_bottom">
                    <p style=" font-size: 12px; color: #999999; font-family:'dotum'; line-height: 20px;"> 서울시 강남구 언주로 133길 29, 한국장기조직기증원 (우)06053  / tel: 02 - 542 - 5635 / fax: 02 - 794 - 2641 / EMail: jy.park@koda1458.kr<br/>
                        희망서약 상담번호 1544-0606   Copyright (c) 2015 All Rights Reserved. </p>
                    <p style=" font-size: 12px; color: #666666; font-family:'dotum'; line-height: 20px;"> <img src="${pageContext.request.contextPath}/home/images/footer_bottom_bg.png" class="footer_img" style="max-width: 100%; float:right; margin-right: 10px;"></p>
                </div>
            </div>
        </div>
    </div>
</footer>
<script src="${pageContext.request.contextPath}/home/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/home/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/home/js/bootstrap-hover-dropdown.js"></script>
<!--首页JS-->
<script src="${pageContext.request.contextPath}/home/js/index.js"></script>
<!--内页JS-->
<script src="${pageContext.request.contextPath}/home/js/page.js"></script>
<!--通用JS-->
<script src="${pageContext.request.contextPath}/home/js/order.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $(".footer_select").bind("change",function(){
            var firend_url = $("option:selected",this).attr("data-firend-url");
            if(firend_url!=""){
                /*
                 $("#friend_link").attr("href",firend_url).trigger('click');
                 */
                window.location.href=firend_url;
                /*window.open(firend_url);*/
            }else{

            }
        });
        $(".footer_select").on('change', function(e) {

        });

    });
</script>

</body>
</html>

<script language="JavaScript" type="text/javascript">
    // Conversion Data from Json to Javascript
    <c:choose><c:when test="${ !empty enum_array}">
	var enum_array = ${enum_array};
	</c:when><c:otherwise>
	var enum_array = null;
	</c:otherwise></c:choose>

    // delete 0
    function pad( n, width ) {
        n = n + '';
        return n.length >= width ? n : new Array( width - n.length + 1 ).join( '0' ) + n;
    }

    function initValue() {

    }
    $(document).ready( function () {
        initValue();
        $( ".btn-print" ).click( function ( e ) {

            $( "#page_content" ).printThis( {
                debug: false,
                importCSS: true,
                importStyle: true,
                printContainer: true,
                loadCSS: {},
                pageTitle: "서약자관리 - 상세정보",
                removeInline: false,
                printDelay: 333,
                header: null,
                formValues: true
            } );
        } );

    });

</script>
