<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="darkmode" data-theme="light">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>유로풋볼투어</title>
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
                    <li class="mm-link"><a class="mm-link" href="index.html">Home</a></li>
                    <li><a class="mm-link" href="account.html">일정표</a></li>
                    <li class="mm-link"><a class="mm-link" href="faq.html">자주하는질문</a></li>
                    <li class="mm-link"><a class="mm-link" href="ticket-qna.html">티켓문의</a></li>
                    <li class="mm-link"><a class="mm-link" href="customer-center.html">고객센터</a></li>
                    <li><a class="mm-link" href="board.html">관전후기</a></li>
                    <li><a class="mm-link" href="about.html">유로풋볼투어</a></li>
                </ul>
            </nav>
            <div>
                <div class="offset-widget offset-logo mb-30">
                    <a href="index.html">
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
                                <li><a class="home-page-link" href="index.html">Home</a></li>
                                <li><a class="current-page" href="#">일정표</a></li>
                            </ul>
                        </div>
                        <h1 class="banner-heading">일정표</h1>
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
                    <div class="col-lg-3 d-none d-lg-block account-side-navigation nav nav-tabs" id="myTab" role="tablist">
                        <div class="left_bnall">
                            <div class="left_bn border border-bottom-0">
                                <img src="assets/images/img/left-img-1.jpg" alt="고객센터 070-4085-9614">
                            </div>
                            <div class="left_bn border border-bottom-0"><a href="board.php?board=qna"><img src="assets/images/img/left_qna.gif" alt="문의게시판"></a></div>
                            <div class="left_bn border">
                                <img src="assets/images/img/left-img-2.jpg" alt="입금안내">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-9">
                        <div class="row">
                            <div class="bg-light border-2 border-dark border-top col-lg-12 p-3">
                                <h5><i class="fal fa-ticket"></i> 티켓 구입 약관</h5><br>
                                <p>
                                <div class="text-orange">※ 프리미어티켓은 프리미어리그 티켓 구매 대행 서비스를 제공합니다.</div>

                                <div>※ 사전 좌석 확정 및 즉시 티켓 확인 등이 가능한 직접 예약을 희망하실 경우 각 구단 홈페이지를 이용해 주세요.</div>

                                <div>※ 프리미어티켓은 비회원 예약이 가능하며 예약 내용은 e메일 통해 확인할 수 있습니다.</div>

                                <div>※ 프리미어티켓을 통해 구입한 모든 티켓은 <span class="text-orange fw-normal">경기 킥오프 기준 30분 전 입장을 원칙</span>으로 합니다.</div>
                                <div class="text-orange">※ 일정표 게시 금액은 예약 당시 티켓을 확보하기 위한 실시간 요금이며 추후 변동 될 수 있습니다. (차액환불불가)</div>
                                <div class="text-danger">※ 약관 필수 확인 부탁 드립니다. 약관 미 확인 후 진행 시 불이익이 발생할 수 있습니다.</div>
                                </p><br>
                                <div class="fw-bold">[환불 규정] 프리미어티켓 환불 규정 안내 입니다.</div><br>
                                <p>
                                    * 입금 후 관전을 취소할 경우 아래의 비율로 취소 위약금을 부과함을 알려드립니다.<br>
                                    * 주최 측 사정으로 경기가 연기 될 경우 50% 즉시 환불 또는 (미 확정 일정 포함)변경 날짜로 변경 할 수 있습니다.<br>
                                    - 이 경우 하기 환불 규정이 적용 되지 않습니다. (예) 여왕 서거로 인한 무기한 연기<br>
                                    * 취소 접수는 업무 시간 내 접수 및 확인이 가능합니다.<br>
                                    (예) 평일 금요일 업무 종료 전까지 취소 하셔야 합니다. (주말 및 공휴일 취소 신청 및 적용 불가)<br>
                                </p><br>
                                <p class="text-orange">
                                    - 입금일 당일 통보 시 : 전액 환불<br>
                                    - 시합일 20일 전(~20)까지 통보 시 : 요금의 20% 배상<br>
                                    - 시합일 10일 전(19~10)까지 통보 시 : 요금의 30% 배상<br>
                                    - 시합일 8일 전(9~8)까지 통보 시 : 요금의 45% 배상<br>
                                    - 시합일 1일 전(7~1)까지 통보 시 : 요금의 60% 배상<br>
                                    - 시합일 통보 시 : 전액 환불 불가<br>
                                </p><br>
                                <p>
                                    - 일정 변경은 협회 및 구단의 협의를 통해 이루어지며 해외 팬들에 대한 배려를 기대하기 어려운 점 양해 바랍니다.<br>
                                    - 일정 변경으로 인해 여행 일정 내 관전이 어려운 경우 관전이 가능한 경기로 예약을 변경해 드릴 수 있습니다.<br>
                                    - 경기 및 예약 시점에 따라 본인 명의가 아닌 회원 카드로 경기에 대한 관전 권리를 양도 받는 형식으로 진행 될 수 있습니다.<br>
                                </p><br>
                                <div class="fw-bold">[예약 안내] <span class="text-danger">예약 > 메일안내 > 결제 > 결제 확인 > 바우처 발급 > 알림 > 실제 e티켓 메일 발송</span> 절차로 진행 됩니다.</div><br>
                                <p>
                                    1. 입금이 확인되면 예약 당일 오후 또는 다음 날 연락드립니다.<br>
                                    2. 카드 결제를 요청 하신 경우 담당자가 직접 연락 드립니다. <span class="text-orange fw-normal">(PayPal 결제 e메일 발송, 5% 수수료 발생)</span><br>
                                    3. 입금 확인 시 예약 확인증(바우처) e메일로 전달됩니다. <span class="text-danger fw-normal text-decoration-underline">단, 실제 티켓은 경기 1~3일 전 전달 됩니다.</span><br>
                                    4. 일부 경기의 경우 회원카드로 전달 되거나, 경기 당일 e티켓이 전달 될 수 있습니다.<br>
                                    5. 바우처에는 예약 내용, 비상 연락망, 경기장 대중교통 안내 등의 정보를 포함하고 있습니다.<br>
                                    6. 2매 이상 좌석은 기본 연석으로 제공되지만, 몇몇 임박한 경기에 한해 대체 좌석으로 확보 될 수 있습니다. (필수확인)<br>
                                    - 바로가기 링크 : <a class="text-decoration-underline text-info" href="http://www.premierticket.kr/assignseat.pdf" target="_blank">http://www.premierticket.kr/assignseat.pdf</a><br>
                                <div class="text-danger">7. 3인 이상의 연석으로 확보 요청 시 추가 요금이 발생하며 개별 문의 부탁 드립니다.</div><br>
                                8. 미성년자의 경우 단독 입장이 불가 하며 가족 및 보호자 동행 하에 입장 가능합니다. (미성년 기준 구단 별 상이함)<br>
                                9. 임박한 경기 및 예상치 못한 상황으로 티켓 전달 시점이 변경 될 수 있으며 이 경우 개별 연락드리고 양해를 구합니다.<br>
                                10. 예매시점 또는 극히 일부 경기에 따라 연석이 1~2 좌석 떨어져 배정 될 수 있습니다. (예: oxxo, oxo 또는 앞뒤좌우 등)<br>
                                11. 희망 카테고리 내 좌석 확보가 어려운 경우 경기 전 변경 될 수 있으며 차액은 환불 처리 됩니다.<br>
                                </p><br>
                                <div class="fw-bold">[주의사항안내] 주의사항 필독 바랍니다.</div><br>
                                <p>
                                    1. 예약 확정 후 제공되는 바우처는 특정 구단과 무관하며 구단 관계자에게 제시하지 않습니다.<br>
                                    2. 티켓은 사전 협의 된 날짜에 전달을 목표로 합니다.<br>
                                    - 토너먼트 경기 일정이 갑작스럽게 확정 되는 경우 리그 일정이 변경 될 수 있습니다.<br>
                                <div class="text-orange">- 기타 특별 이유로 경기의 티켓 전달 시점이 변경 될 수 있으며 사전 연락 드립니다.</div>
                                3. 회원 카드가 제공 된 경우 반납 불 이행 시 고객 정보를 바탕으로 손해 배상 청구 등의 법적 대응이 진행 됩니다.<br>
                                - 회원 카드가 정해진 날짜에 반납이 되지 않을 경우 다음 경기에 대한 100% 금액이 청구 됩니다.<br>
                                - 회원 카드 분실 및 고객 부주의로 인한 퇴장 등 반납 불 이행 시 책임 소재에 따라 남은 경기에 대한 전액이 청구 될 수 있습니다.<br>
                                - 배상에 대한 기준은 각 구단 내 규정을 적용합니다.<br>
                                4. 일정 변경: 주최 측의 사정으로 날짜 및 시간이 변경된 경우 회사에서 알려드릴 의무가 없습니다.<br>
                                - 일정 변경은 잉글랜드FA 에서 결정하며 일정 변경으로 인한 취소 시 수수료가 발생합니다.<br>
                                - 주말 중 하루에 전체 10경기가 배정 된 일정은 임시 일정으로 일반적으로 경기 예정일 2개월 전 토/일 일정이 확정 됩니다.<br>
                                - 주말 경기 관전 시 토/일 일정 전체를 해당 도시에서 숙박하시는 것이 좋습니다.(평일 월/금 역시 배정될 수 있습니다.)<br>
                                5. 경기 취소: 주최 측의 사정으로 경기가 취소 된 경우 전액 환불 진행됩니다.<br>
                                6. 천재 지변: 천재지변으로 인해 경기 일정이 변경된 경우는 변경된 일정의 티켓으로 교환해 드립니다. - 취소 시 수수료 발생
                                7. 입장 시간: 경기 시작 전 30분 전부터 입장 가능 합니다. 사전 입장 시 가드의 제지 및 퇴장 당할 수 있으며 재 입장 불가 합니다.<br>
                                8. 일반 안내: 경기장 입장 후 지나친 음주, 흡연, 비매너 행동 등 이에 준하는 이유로 퇴장 시 회사는 책임지지 않습니다.<br>
                                9. 복장 안내: 일반적으로 홈 좌석으로 예약하는 EPL환경에서 <span class="text-orange fw-normal">원정팬과 동일한 의상 또는 응원도구 일체는 입장/반입 불가 합니다.</span><br>
                                10. 입장 후 적발 시 강제 퇴장 조치 될 수 있습니다. (중립색인 검은색 가능, 애매한 복장의 경우 홈 팀 응원 스카프 구매 추천)<br>
                                </p>
                            </div>
                            <div class="text-center bg-light mt--10 mb--10 p-1">상기 내용에 대한 확인 및 이에 동의합니다. <input type="checkbox" class="form-input-type"></div>
                            <div class="mt--10 mb--10 p-1">
                                <div><span class="text-danger">[필수]</span> 개인정보 수집, 이용 동의</div>
                                <div class="table-responsive">
                                    <table class="table text-center">
                                        <thead>
                                            <tr class="bg-light">
                                                <th class="border">목적</th>
                                                <th class="border">항목</th>
                                                <th class="border">보유기간</th>
                                                <th class="border">동의여부</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td class="border">이용자 식별 및 본인여부 확인</td>
                                                <td class="border">성명/여권영문명/성별</td>
                                                <td>경기 종료 후 5일까지</td>
                                                <td class="border" rowspan="3" style="white-space: nowrap;">
                                                    <div><input type="radio"> 동의함</div>
                                                    <div><input type="radio"> 동의안함</div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="border">계약 이행을 위한 연락 민원 등 고객 고충 처리</td>
                                                <td class="border">연락처(이메일, 휴대전화번호)</td>
                                                <td class="border">경기 종료 후 5일까지</td>
                                            </tr>
                                            <tr>
                                                <td class="border">이용자 연령 확인 (만 17세 미만 단독 예약불가)</td>
                                                <td class="border">생년월일</td>
                                                <td class="border">경기 종료 후 5일까지</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="fw-bold">※ 프리미어티켓 서비스 제공을 위해서 필요한 최소한의 개인정보이므로 동의를 해 주셔야 서비스를 이용하실 수 있습니다.</div>
                                <div class="col-lg-12 mt--20 text-center">
                                    <button type="submit" class="btn btn-sm btn-danger" onclick="location.href='account-detail-3.html'"><i class="fal fa-box-check"></i> 구매하기</button>
                                    <button type="submit" class="btn btn-sm btn-secondary"> 동의안함</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--================= Account Section End Here =================-->


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
                                <li class="widget-list-item"><a href="account.html">일정표</a></li>
                                <li class="widget-list-item"><a href="faq.html">자주하는질문</a></li>
                                <li class="widget-list-item"><a href="ticket-qna.html">티켓문의</a></li>
                                <li class="widget-list-item"><a href="customer-center.html">고객센터</a></li>
                                <li class="widget-list-item"><a href="board.html">관전후기</a></li>
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
                        <a href="#">회원약관</a>
                        <a href="faq.html">개인정보처리방침</a>
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


<script>
    // 

    document.addEventListener('DOMContentLoaded', function() {
        const navButtons = document.querySelectorAll('.nav-item .filter-btn');

        navButtons.forEach(button => {
            button.addEventListener('click', function() {
                // Remove active class from all buttons
                navButtons.forEach(btn => btn.classList.remove('active'));

                // Add active class to clicked button
                this.classList.add('active');
            });
        });
    });

</script>
