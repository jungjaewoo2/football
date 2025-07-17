<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en" class="darkmode" data-theme="light">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>축구예매사이트</title>
    <!--================= Favicon =================-->
    <link rel="apple-touch-icon" href="assets/images/fav.png">
    <link rel="shortcut icon" type="image/x-icon" href="assets/images/fav.png">
    <!--================= Bootstrap V5 CSS =================-->
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
    <!--================= Font Awesome 5 CSS =================-->
    <link rel="stylesheet" type="text/css" href="assets/css/all.min.css">
    <!--================= RT Icons CSS =================-->
    <link rel="stylesheet" type="text/css" href="assets/css/rt-icons.css">
    <!--================= Animate css =================-->
    <link rel="stylesheet" type="text/css" href="assets/css/animate.min.css">
    <!--================= Magnific popup Plugin =================-->
    <link rel="stylesheet" type="text/css" href="assets/css/magnific-popup.css">
    <!--================= Animate css =================-->
    <link rel="stylesheet" type="text/css" href="assets/css/magnific.css">
    <!--================= Animate css =================-->
    <link rel="stylesheet" type="text/css" href="assets/css/animate.min.css">
    <!--================= Swiper Slider Plugin =================-->
    <link rel="stylesheet" type="text/css" href="assets/css/swiper-bundle.min.css">
    <!--================= Mobile Menu CSS =================-->
    <link rel="stylesheet" type="text/css" href="assets/css/metisMenu.css">
    <!--================= Main Menu CSS =================-->
    <link rel="stylesheet" type="text/css" href="assets/css/rtsmenu.css">
    <!--================= Main Stylesheet =================-->
    <link rel="stylesheet" type="text/css" href="assets/css/variables/variable1.css">
    <!--================= Main Stylesheet =================-->
    <link rel="stylesheet" type="text/css" href="assets/css/main.css">
    <!--================= Add Stylesheet =================-->
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
</head>

<body>
    <!--================= Preloader Section Start Here =================-->
    <div id="rts__preloader">
        <div class="main-fader responsive-height-comments">
            <div class="loader">
                <svg viewBox="0 0 866 866" xmlns="http://www.w3.org/2000/svg">
                    <svg id="Layer_1" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 164.83 151.5">
                        <path class="path-0" d="M117.24,69.24A8,8,0,0,0,115.67,67c-4.88-4-9.8-7.89-14.86-11.62A4.93,4.93,0,0,0,96.93,55c-5.76,1.89-11.4,4.17-17.18,6a4.36,4.36,0,0,0-3.42,4.12c-1,6.89-2.1,13.76-3,20.66a4,4,0,0,0,1,3.07c5.12,4.36,10.39,8.61,15.68,12.76a3.62,3.62,0,0,0,2.92.75c6.29-2.66,12.52-5.47,18.71-8.36a3.49,3.49,0,0,0,1.68-2.19c1.34-7.25,2.54-14.55,3.9-22.58Z" fill="#e41b23" />
                        <path class="path-1" d="M97.55,38.68A43.76,43.76,0,0,1,98,33.44c.41-2.36-.5-3.57-2.57-4.64C91.1,26.59,87,24,82.66,21.82a6.18,6.18,0,0,0-4-.71C73.45,22.55,68.32,24.25,63.22,26c-3.63,1.21-6.08,3.35-5.76,7.69a26.67,26.67,0,0,1-.6,4.92c-1.08,8.06-1.08,8.08,5.86,11.92,3.95,2.19,7.82,5.75,11.94,6.08s8.76-2.41,13.12-3.93c9.33-3.29,9.33-3.3,9.78-14Z" fill="#e41b23" />
                        <path class="path-2" d="M66.11,126.56c5.91-.91,11.37-1.7,16.81-2.71a3.3,3.3,0,0,0,1.87-2.17c1-4.06,1.73-8.19,2.84-12.24.54-2-.11-3-1.55-4.15-5-4-9.9-8.12-15-12a6.19,6.19,0,0,0-4.15-1.1c-5.35.66-10.7,1.54-16,2.54A4,4,0,0,0,48.34,97a109.13,109.13,0,0,0-3,12.19,4.47,4.47,0,0,0,1.34,3.6c5.54,4.36,11.23,8.53,16.91,12.69a10.84,10.84,0,0,0,2.57,1.11Z" fill="#e41b23" />
                        <path class="path-3" d="M127.42,104.12c4.1-2.1,8-3.93,11.72-6a6,6,0,0,0,2.27-3,58.22,58.22,0,0,0,3.18-29.92c-.26-1.7-8-7.28-9.71-6.85A5,5,0,0,0,133,59.65c-2.81,2.49-5.71,4.88-8.33,7.56a9.46,9.46,0,0,0-2.47,4.4c-1.29,6.49-2.38,13-3.35,19.55a5.73,5.73,0,0,0,.83,3.91c2.31,3.08,5,5.88,7.7,9Z" fill="#e41b23" />
                        <path class="path-4" d="M52.58,29.89c-2.15-.36-3.78-.54-5.39-.9-2.83-.64-4.92.1-7,2.32A64.1,64.1,0,0,0,26.09,54.64c-2.64,7.92-2.62,7.84,5.15,10.87,1.76.69,2.73.45,3.93-1C39.79,59,44.54,53.65,49.22,48.2a4.2,4.2,0,0,0,1.13-2c.8-5.32,1.49-10.68,2.24-16.34Z" fill="#e41b23" />
                        <path class="path-5" fill="#e41b23" d="M23,68.13c0,2.51,0,4.7,0,6.87a60.49,60.49,0,0,0,9.75,32.15c1.37,2.13,6.4,3,7,1.2,1.55-5,2.68-10.2,3.82-15.34.13-.58-.58-1.38-.94-2.06-2.51-4.77-5.47-9.38-7.45-14.37C32.94,71,28.22,69.84,23,68.13Z" />
                        <path class="path-6" fill="#e41b23" d="M83.91,12.86c-.32.36-.66.71-1,1.07.9,1.13,1.57,2.62,2.73,3.33,4.71,2.84,9.56,5.48,14.39,8.1a9.29,9.29,0,0,0,3.13.83c5.45.69,10.89,1.38,16.35,1.94a10.41,10.41,0,0,0,3.07-.71c-11.48-9.9-24.26-14.61-38.71-14.56Z" />
                        <path class="path-7" fill="#e41b23" d="M66.28,132.51c13.36,3.78,25.62,3.5,38-.9C91.68,129.59,79.36,128,66.28,132.51Z" />
                        <path class="path-8" fill="#e41b23" d="M127.2,30.66l-1.27.37a18.58,18.58,0,0,0,1,3.08c3,5.52,6.21,10.89,8.89,16.54,1.34,2.83,3.41,3.82,6.49,4.9a60.38,60.38,0,0,0-15.12-24.9Z" />
                        <path class="bb-9" fill="#e41b23" d="M117.35,125c5.58-2.32,16.9-13.84,18.1-19.2-2.41,1.46-5.18,2.36-6.78,4.23-4.21,5-7.89,10.37-11.32,15Z" />
                    </svg>
                </svg>
            </div>
        </div>
    </div>
    <!--================= Preloader End Here =================-->

    <div class="anywere anywere-home"></div>

    <!--================= Header Section Start Here =================-->
    <header id="rtsHeader" class="rts-header1">
        <jsp:include page="header.jsp" />

        <!--================= Slide Bar Start Here =================-->
        <aside class="slide-bar">
            <div class="offset-sidebar mb--50">
                <button class="slide-bar-close ml--30"><i class="fal fa-times"></i></button>

            </div>
            <!-- side-mobile-menu start -->
            <nav class="side-mobile-menu side-mobile-menu1">
                <ul id="mobile-menu-active">
                    <li class="mm-link"><a class="mm-link" href="./">Home</a></li>
                    <li><a class="mm-link" href="account">일정표</a></li>
                    <li class="mm-link"><a class="mm-link" href="faq">자주하는질문</a></li>
                    <li class="mm-link"><a class="mm-link" href="ticket-qna">티켓문의</a></li>
                    <li class="mm-link"><a class="mm-link" href="customer-center">고객센터</a></li>
                    <li><a class="mm-link" href="board">관전후기</a></li>
                    <li><a class="mm-link" href="about">유로풋볼투어</a></li>
                </ul>
            </nav>
            <div>
                <div class="offset-widget offset-logo mb-30">
                    <a href="./">
                        <img src="assets/images/logo.png" alt="logo">
                    </a>
                </div>
            </div>
        </aside>
        <!--================= Slide Bar Start Here =================-->
        <!--================= Banner Section Start Here =================-->
        <div class="banner banner1">
            <div class="inner-page-banner banner-bg">
                <div class="container">
                    <div class="banner-content">
                        <div class="page-path">
                            <ul>
                                <li><a class="home-page-link" href="./">Home</a></li>
                                <li><a class="current-page" href="#">privacy policy</a></li>
                            </ul>
                        </div>
                        <h1 class="banner-heading">개인정보처리방침</h1>
                    </div>
                </div>
            </div>
        </div>
        <!--================= Banner Section End Here =================-->
    </header>
    <!--================= Header Section End Here =================-->



    <!--================= Account Section Start Here =================-->
    <div class="rts-account-section section-gap">
        <div class="container">
            <div class="account-inner">
                <div class="row d-flex">
                    <div class="col-12">




                        <div class="row r-content-2">
                            <h5 class="p-0">개인정보처리방침</h5><br>



                            ㈜프리미어티켓(이하 ‘회사’라 한다)은 이용자의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 다음과 같이 개인정보 처리방침을 수립·공개합니다.<br><br>

                            <div class="p-0 fw-bold">제1조(개인정보의 처리목적)</div><br>

                            회사는 다음의 목적을 위하여 개인정보를 처리합니다.<br>

                            처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.<br><br>

                            1. 홈페이지 상품구매 회원관리<br>

                            - 홈페이지 상품구매를 위한 최소한의 정보를 수집합니다.<br>

                            2. 재화 또는 서비스 제공<br>

                            - 서비스 제공, 콘텐츠 제공, 맞춤서비스 제공, 본인인증, 연령인증, 요금결제․ 정산 등을 목적으로 개인정보를 처리합니다.<br>

                            3. 고충처리<br>

                            - 민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락․통지, 처리결과 통보 등의 목적으로 개인정보를 처리합니다.<br><br>



                            <div class="p-0 fw-bold">제2조(처리하는 개인정보 항목)</div><br>

                            회사는 다음의 개인정보 항목을 처리하고 있습니다.<br><br>

                            1. 재화 또는 서비스 제공<br>

                            - 필수항목 : 성명, 생년월일, 주소, 전화번호, 이메일주소<br><br>



                                <div class="p-0 fw-bold">제3조(개인정보 수집 방법)</div><br>

                            1. 서비스 이용 과정에서 이용자가 개인정보 수집에 대해 동의를 하고 직접 정보를 입력하는 경우, 해당 개인정보를 수집합니다.<br>

                            2. 고객센터를 통한 상담 과정에서 메일, 전화 등을 통해 이용자의 개인정보가 수집될 수 있습니다.<br>

                            3. 회사와 제휴한 외부 기업이나 단체로부터 개인정보를 제공받을 수 있으며, 이러한 경우에는 제휴사에서 이용자에게 개인정보 제공 동의를 받아야 합니다.<br>

                            4. 14세 미만의 고객은 상품구매가 불가합니다.<br><br>



                                <div class="p-0 fw-bold">제4조(개인정보의 처리 및 보유기간)</div><br>

                            ① 회사는 법령에 따른 개인정보 보유·이용기간 또는 이용자로부터 개인정보를 수집 시에 동의 받은 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.<br>

                            ② 각각의 개인정보 처리 및 보유 기간은 구매하신 상품(경기) 진행 후 5일 이내입니다.<br><br>

                            다만, 다음의 사유에 해당하는 경우에는 해당 사유 종료 시 까지<br><br>

                            1. 관계 법령 위반에 따른 수사․조사 등이 진행 중인 경우에는 해당 수사․조사 종료 시 까지<br>

                            2. 홈페이지 이용에 따른 채권․채무관계 잔존 시에는 해당 채권·채무관계 정산 시 까지<br>

                            3. 재화 또는 서비스 제공 : 재화·서비스 공급완료 및 요금결제․정산 완료시까지<br><br>

                            다만, 다음의 사유에 해당하는 경우에는 해당 기간 종료 시 까지<br><br>

                            1)「전자상거래 등에서의 소비자 보호에 관한 법률」 제6조에 따른 표시·광고, 계약내용 및 이행 등 거래에 관한 기록<br>

                            - 표시·광고에 관한 기록 : 6개월<br>

                            - 계약 또는 청약철회, 대금결제, 재화 등의 공급기록 : 5년<br>

                            - 소비자 불만 또는 분쟁처리에 관한 기록 : 3년<br><br>

                            2)「통신비밀보호법」 제15조의2에 따른 통신사실확인자료 보관<br>

                            - 가입자 전기통신일시, 개시·종료시간, 상대방 가입자번호, 사용도수 : 1년<br>

                            - 컴퓨터통신, 인터넷 로그기록자료, 접속지 추적자료 : 3개월<br><br>



                                <div class="p-0 fw-bold">제5조(개인정보의 파기)</div><br>

                            ① 회사는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 5일 이내 해당 개인정보를 파기합니다.<br>

                            ② 이용자로부터 동의받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다.<br>

                            ③ 개인정보 파기의 절차 및 방법은 다음과 같습니다.<br><br>

                            1. 파기절차<br>

                            회사는 파기 사유가 발생한 개인정보를 선정하고, 회사의 개인정보 보호책임자의 승인을 받아 개인정보를 파기합니다.<br>

                            2. 파기방법<br>

                            회사는 전자적 파일 형태로 기록․저장된 개인정보는 기록을 재생할 수 없도록 로우 레벨 포멧(Low Level Format) 등의 방법을 이용하여 파기하며, 종이 문서에 기록․저장된 개인정보는 분쇄기로 분쇄하거나 소각하여 파기합니다.<br><br>



                                <div class="p-0 fw-bold">제6조(이용자 및 법정대리인의 권리·의무 및 행사방법)</div><br>

                            ① 이용자는 회사에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다.<br><br>

                            1. 개인정보 열람요구<br>

                            2. 오류 등이 있을 경우 정정 요구<br>

                            3. 삭제요구<br>

                            4. 처리정지 요구<br><br>

                            ② 제1항에 따른 권리 행사는 회사에 대해 서면, 전화, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 회사는 이에 대해 지체없이 조치하겠습니다.<br>

                            ③ 이용자가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 회사는 정정 또는 삭제를

                            완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.<br>

                            ④ 이용자는 정보통신망법, 개인정보보호법 등 관계법령을 위반하여 회사가 처리하고 있는 이용자 본인

                            이나 타인의 개인정보 및 사생활을 침해하여서는 아니됩니다.<br><br>



                            <div class="p-0 fw-bold">제7조(개인정보 자동 수집 장치의 설치·운영 및 거부)</div><br>

                            회사는 이용자 개개인에게 개인화되고 맞춤화된 서비스를 제공하기 위해 이용자의 정보를 저장하고 수시로 불러오는 '쿠키(cookie)'를 사용합니다.<br><br>

                            1. 쿠키의 사용 목적<br>

                            구매자의 접속 빈도나 방문 시간 등의 분석, 이용자의 취향과 관심분야의 파악 및 자취 추적, 각종 이벤트 참여 정도 및 방문 회수 파악 등을 통한 타겟 마케팅 및 개인 맞춤 서비스 제공<br>

                            2. 쿠키 설정 거부 방법<br>

                            이용자는 쿠키 설치에 대해 거부할 수 있습니다. 단, 쿠키 설치를 거부하였을 경우 로그인이 필요한 일부 서비스의 이용이 어려울 수 있습니다.<br>

                            (설정방법, IE 기준)웹 브라우저 상단의 도구 > 인터넷 옵션 > 개인정보 > 사이트 차단<br><br>



                            <div class="p-0 fw-bold">제8조(개인정보의 안전성 확보조치)</div><br>

                            회사는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.<br><br>

                            1. 관리적 조치 : 내부관리계획 수립․시행, 정기적 직원 교육 등<br>

                            2. 기술적 조치 : 개인정보처리시스템 등의 접근권한 관리, 접근통제시스템 설치, 고유식별정보 등의 암호화, 보안프로그램 설치<br>

                            3. 물리적 조치 : 전산실, 자료보관실 등의 접근통제<br><br>



                                <div class="p-0 fw-bold">제9조(개인정보 보호책임자)</div><br>

                            ① 회사는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 이용자의 불만처리

                            및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자 및 담당부서를 지정·운영하고 있습니다.<br><br>

                            ▶ 개인정보 담다부서 및 보호책임자<br><br>

                            성명 : 김기곤<br>

                            직책 : 대표<br>

                            연락처 : 070-7779-9614 (e메일:premierticket7@gmail.com)<br><br>



                            ② 이용자는 회사의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리,<br>

                            피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. 회사는<br>

                            이용자의 문의에 대해 답변 및 처리해드릴 것입니다.<br><br>



                                <div class="p-0 fw-bold">제12조(개인정보 열람청구)</div><br>

                            이용자는 개인정보의 열람 청구를 아래의 부서에 할 수 있습니다. 회사는 이용자의 개인정보 열람청구가

                            신속하게 처리되도록 노력하겠습니다.<br><br>

                            ▶ 개인정보 열람청구 접수․처리 부서<br><br>

                            성명 : 김기곤<br>

                            직책 : 대표<br>

                            연락처 : 070-7779-9614 (e메일:premierticket7@gmail.com)<br><br>



                                <div class="p-0 fw-bold">제13조(권익침해 구제방법)</div><br>

                            이용자는 아래의 기관에 대해 개인정보 침해에 대한 피해구제, 상담 등을 문의하실 수 있습니다.<br><br>

                            아래의 기관은 회사와는 별개의 기관으로서, 회사의 자체적인 개인정보 불만처리, 피해구제 결과에 만족하지 못하시거나 보다 자세한 도움이 필요하시면 문의하여 주시기 바랍니다<br><br>

                                ▶ 개인정보 침해신고센터 (한국인터넷진흥원 운영)<br><br>

                                - 소관업무 : 개인정보 침해사실 신고, 상담 신청<br>

                                - 홈페이지 : privacy.kisa.or.kr<br>

                                - 전화 : (국번없이) 118<br>

                                - 주소 : (58324) 전남 나주시 진흥길 9(빛가람동 301-2) 3층 개인정보침해신고센터<br><br>

                                ▶ 개인정보 분쟁조정위원회<br><br>

                                - 소관업무 : 개인정보 분쟁조정신청, 집단분쟁조정 (민사적 해결)<br>

                                - 홈페이지 : www.kopico.go.kr<br>

                                - 전화 : (국번없이) 1833-6972<br>

                                - 주소 : (03171)서울특별시 종로구 세종대로 209 정부서울청사 4층<br><br>

                                ▶ 대검찰청 사이버범죄수사단 : 02-3480-3573<br><br>

                                ▶ 경찰청 사이버테러대응센터 : 1566-0112<br><br>



                                <div class="p-0 fw-bold">제14조(개인정보 처리방침 변경)</div><br>

                                ① 이 개인정보 처리방침은 2008 년 08 월 01 일 부터 적용됩니다.<br>

                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--================= Account Section End Here =================-->
    <script>
        // 좌석 선택에 따른 배치도 이미지 변경 JS

        document.addEventListener('DOMContentLoaded', () => {
            const radioInputs = document.querySelectorAll('.table input[type="radio"]');
            const seatImages = document.querySelectorAll('.seat-reserve img');

            // 모든 이미지를 숨기는 함수
            const resetImages = () => {
                seatImages.forEach(img => {
                    img.style.display = 'none';
                });
            };

            // 색상에 맞는 이미지를 표시하는 함수
            const showImage = (color) => {
                resetImages();
                const matchingImage = Array.from(seatImages).find(img =>
                    img.src.toLowerCase().includes(`${color.toLowerCase()}.jpg`)
                );
                if (matchingImage) {
                    matchingImage.style.display = 'block';
                }
            };

            // 라디오 버튼에 클릭 이벤트 추가
            radioInputs.forEach(radio => {
                radio.addEventListener('click', () => {
                    const row = radio.closest('tr');
                    const th = row.querySelector('th');
                    const colorText = th.textContent.trim().toLowerCase().split(' ')[1]; // 예: "● purple" -> "purple"
                    showImage(colorText);
                });
            });
        });



    </script>

    <!--================= Footer Start Here =================-->
    <div class="footer footer1 baseball">
        <div class="container">
            <div class="footer-inner">
                <div class="row">
                    <div class="col-xl-3 col-md-12">
                        <div class="footer-widget">
                            <div class="footer-logo"><img src="assets/images/logo.png" alt="footer-logo">
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-5 col-md-6 col-sm-12">
                        <div class="footer-widget address-widget">
                            <h3 class="footer-widget-title"> GET IN TOUCH</h3>
                            <ul>
                                <li class="widget-list-item"><i class="fas fa-envelope-open"></i><a href="mailto:info@webmail.com">premierticket7@gmail.com</a></li>
                                <li class="widget-list-item"><i class="fas fa-phone"></i><a href="tel:09877788890">070-7779-9614</a></li>
                                <li class="widget-list-item"><i class="fas fa-map-marker-alt"></i> <span> 강원 춘천시 충혼길 52번길 10(온의동) 드림타워 3층 302호 대표 김기곤<br>사업자등록번호 108-18-52369</span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-xl-4 col-md-6 col-sm-12">
                        <div class="footer-widget mb--20">
                            <h3 class="footer-widget-title"> QUICK LINKS</h3>
                            <ul class="widget-items cata-widget flex-row gap-2 gap-lg-3">
                                <li class="widget-list-item"><a href="account">일정표</a></li>
                                <li class="widget-list-item"><a href="faq">자주하는질문</a></li>
                                <li class="widget-list-item"><a href="ticket-qna">티켓문의</a></li>
                                <li class="widget-list-item"><a href="customer-center">고객센터</a></li>
                                <li class="widget-list-item"><a href="board">관전후기</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer-bottom-area">
            <div class="container">
                <div class="bottom-area-inner">
                    <span class="copyright">COPYRIGHT & DESIGN BY <span class="brand">유로풋볼투어</span> - 2025</span>
                    <div class="footer-bottom-links">
                        <a href="person">개인정보처리방침</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--================= Footer End Here =================-->


    <!--================= Scroll to Top Start =================-->
    <div class="scroll-top-btn scroll-top-btn1"><i class="fas fa-angle-up arrow-up"></i><i class="fas fa-circle-notch"></i></div>
    <!--================= Scroll to Top End =================-->

    <!--================= Jquery latest version =================-->
    <script src="assets/js/vendors/jquery-3.6.0.min.js"></script>
    <!--================= Bootstrap latest version =================-->
    <script src="assets/js/vendors/bootstrap.min.js"></script>
    <!--================= Wow.js =================-->
    <script src="assets/js/vendors/wow.min.js"></script>
    <!--================= Swiper Slider =================-->
    <script src="assets/js/vendors/swiper-bundle.min.js"></script>
    <!--================= Zoom Plugin =================-->
    <script src="assets/js/vendors/zoom.js"></script>
    <!--================= metisMenu Plugin =================-->
    <script src="assets/js/vendors/metisMenu.min.js"></script>
    <!--================= Main Menu Plugin =================-->
    <script src="assets/js/vendors/rtsmenu.js"></script>
    <!--================= Mobile Menu Plugin =================-->
    <script src="assets/js/vendors/metisMenu.min.js"></script>
    <!--================= Magnefic Popup Plugin =================-->
    <script src="assets/js/vendors/isotope.pkgd.min.js"></script>
    <!--================= Magnefic Popup Plugin =================-->
    <script src="assets/js/vendors/jquery.magnific-popup.min.js"></script>
    <!--================= Main Script =================-->
    <script src="assets/js/main.js"></script>
</body>

</html>



