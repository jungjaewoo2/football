<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${empty schedule}">
    <div style="color:red;">schedule 값이 없습니다. 컨트롤러에서 Model에 schedule을 넣어주는지 확인하세요.</div>
</c:if>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <style>
        .seat-reserve {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        
        .seat-reserve img {
            width: 100%;
            max-width: 100%;
            height: auto;
            display: block;
        }
        
        .seat-reserve img {
            display: block;
        }
        
        /* 라디오 버튼 클릭 시 페이지 이동 방지 */
        input[type="radio"] {
            cursor: pointer;
        }
        
        /* 라디오 버튼 클릭 시 포커스 아웃라인 제거 */
        input[type="radio"]:focus {
            outline: none;
        }
        
        /* 테이블 내 라디오 버튼 클릭 시 스크롤 방지 */
        .table input[type="radio"] {
            user-select: none;
        }
    </style>
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
                    <div class="col-lg-9 m-auto">
                        <div class="row r-content-2">
                            <div class="d-flex flex-column gap-3">
                                <div class="col-lg-12 border mb-1">
                                    <div class="seat-reserve">
                                        <c:choose>
                                            <c:when test="${not empty homeTeamSeatImg}">
                                                <img class="" src="uploads/team_info/${homeTeamSeatImg}" alt="${schedule.homeTeam} 홈구장 좌석 배치도">
                                            </c:when>
                                            <c:otherwise>
                                                <img class="" src="assets/images/img/all.jpg" alt="좌석 배치도">
                                            </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${not empty homeTeamSeatImg1}">
                                                <img class="" src="uploads/team_info/${homeTeamSeatImg1}" alt="${schedule.homeTeam} 홈구장 좌석 배치도">
                                            </c:when>
                                            <c:otherwise>
                                                <img class="" src="assets/images/img/all.jpg" alt="좌석 배치도">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="col-lg-12 mt-3">
                                    <c:if test="${schedule != null}">
                                        <table class="table table-bordered mb-2">
                                           <colgroup>
                                                <col width="25%">
                                                <col width="25%">
                                                <col width="25%">
                                                <col width="25%">
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <th class="border bg-light px-2" style="width: 30%;">날짜(시각)</th>
                                                    <td class="border px-2">${schedule.gameDate} ${schedule.gameTime}</td>
                                                    <th class="border bg-light px-2" style="width: 30%;">경기분류</th>
                                                    <td class="border px-2">${schedule.gameCategory}</td>
                                                </tr>
                                                <tr>
                                                    <th class="border bg-light px-2" style="width: 30%;">홈팀</th>
                                                    <td class="border px-2">${schedule.homeTeam}</td>
                                                    <th class="border bg-light px-2" style="width: 30%;">원정팀</th>
                                                    <td class="border px-2">${schedule.otherTeam}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </c:if>
                                    <c:if test="${schedule != null && not empty seatPriceItems}">
                                        <table class="table table-bordered">
                                           <colgroup>
                                                <col width="25%">
                                                <col width="25%">
                                                <col width="25%">
                                                <col width="25%">
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <th colspan="3" class="border bg-light px-2" style="width: 30%;">좌석명</th>
                                                    <td class="border px-2">요금(구역)</td>
                                                </tr>
                                                <c:forEach var="seatItem" items="${seatPriceItems}" varStatus="status">
                                                    <tr>
                                                        <th colspan="3" class="border bg-light px-2">${seatItem.seatName}</th>
                                                        <td class="d-flex justify-content-between px-2">
                                                            <div><span class="text-danger">
                                                                    <fmt:formatNumber value="${seatItem.price}" pattern="#,###" />
                                                                </span>원</div>
                                                            <div><input type="radio" name="color" value="${status.index}"></div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:if>
                                    <c:if test="${schedule != null && empty seatPriceItems}">
                                        <div class="alert alert-warning" role="alert">
                                            <h5><i class="fas fa-exclamation-triangle"></i> 좌석 요금 정보 없음</h5>
                                            <p>해당 경기의 좌석 요금 정보가 등록되지 않았습니다.</p>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                            <c:if test="${schedule != null}">
                                <div class="col-lg-12 mt--10 text-end p-0">
                                    <button type="button" class="btn btn-sm btn-danger" onclick="submitReservation()">예약신청</button>
                                </div>
                                <!-- 숨겨진 input 필드들로 좌석 가격 정보 전달 -->
                                <c:forEach var="seatItem" items="${seatPriceItems}" varStatus="status">
                                    <input type="hidden" id="price_${status.index}" value="${seatItem.price}">
                                    <input type="hidden" id="seatName_${status.index}" value="${seatItem.seatName}">
                                </c:forEach>
                            </c:if>
                            <div class="bg-light border-2 border-dark border-top col-lg-12 mt--50 p-3">
                                <c:choose>
                                    <c:when test="${not empty ticketInfo.content}">
                                        ${ticketInfo.content}
                                    </c:when>
                                    <c:otherwise>
                                        <h5><i class="fal fa-ticket"></i> 티켓 구입 안내</h5><br>
                                        <div class="fw-bold">1. 티켓 구입 방법</div><br>
                                        <p>
                                            - 좌석배치표를 참고하여 원하시는 구역을 결정 후 "바로구매하기" 버튼을 클릭, 예약 정보 입력 페이지로 이동합니다.<br>
                                            - 구역 내 상세 좌석의 경우 결제 시점에서 확보 가능한 티켓 중 관전에 가장 좋은 좌석으로 확보됩니다.(무작위배정)<br>
                                            - 특정 블럭 및 좌석 예약을 희망하시는 경우 추가 비용이 발생 할 수 있습니다.<br>
                                            - 2매 예약 시 2연석 기본 좌석 배정입니다.(단, 일부 경기의 경우 1~2칸 떨어진 대체 좌석으로 확보 될 수 있습니다.)
                                        </p><br>
                                        <div class="fw-bold">2. 티켓 종류</div><br>
                                        <p>
                                            - 확보 되는 대부분의 티켓은 별도 수령 및 반납이 필요하지 않는 e티켓인 '모바일 e티켓'으로 제공됩니다.<br>
                                            - 경기 확정 후 킥오프 1~3일 전 e메일로 발송되며 핸드폰에 저장 후 활성화 된 QR코드를 스캔하는 방식으로 입장합니다.<br>
                                            - 단, 임박한 경기 또는 일부 경기와 확보 되는 시점에 따라 '회원 카드'로 확보 및 전달 될 수 있습니다.<br>
                                            - 회원카드는 경기 종료 후 반납이 필요하며 타인 명의이 티켓을 1회 양도 받는 형식으로 진행 됩니다.
                                        </p><br>
                                        <div class="fw-bold">3. 결제</div><br>
                                        <p>
                                            - 결제는 계좌이체 및 신용카드 결제가 가능하며 게좌이체의 경우 24시간 이내에 입금해야 합니다.<br>
                                            - 결제 확인은 시차로 인해 결제일 오후 4~6시 또는 다음 날 오전 확인 전화드리며 티켓 수령/반납 등 상세 안내가 이루어집니다.
                                        </p><br>
                                        <h5><i class="fal fa-user-headset"></i> 상담 안내</h5><br>
                                        <div class="fw-bold">1. 상담시간</div><br>
                                        <p>
                                            - 평일 오전 10:00 ~ 오후 06:00까지 입니다.<br>
                                            - 토요일, 일요일 및 공휴일은 휴무입니다.<br>
                                            - 정보 변경에 관해서는 반드시 전화 및 이메일로만 변경 가능합니다.(문자상담불가)
                                        </p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--================= Account Section End Here =================-->
    <script>
        // 전역 변수로 이벤트 리스너 중복 등록 방지
        let eventListenersInitialized = false;
        
        // 페이지 로드 시 스크롤을 맨 위로 이동
        window.addEventListener('load', function() {
            window.scrollTo(0, 0);
        });
        
        // DOM 로드 완료 시에도 스크롤 위치 설정
        document.addEventListener('DOMContentLoaded', function() {
            window.scrollTo(0, 0);
        });
        
        // 모든 이벤트 리스너를 한 번에 초기화하는 함수
        function initializeEventListeners() {
            if (eventListenersInitialized) return;
            eventListenersInitialized = true;
            
            // 좌석 선택에 따른 배치도 이미지 변경 JS
            const radioInputs = document.querySelectorAll('.table input[type="radio"]');
            const seatImages = document.querySelectorAll('.seat-reserve img');

            // 요소들이 존재하는지 확인
            if (radioInputs.length > 0 && seatImages.length > 0) {
                // 모든 이미지를 보여주는 함수 (기본 상태)
                const showAllImages = () => {
                    seatImages.forEach(img => {
                        if (img && img.style) {
                            img.style.display = 'block';
                        }
                    });
                };

                // 좌석 선택 시 이미지 상태 유지 (변경하지 않음)
                const showImage = (color) => {
                    // 이미지 변경하지 않고 현재 상태 유지
                    // 필요시에만 이미지 변경 로직 추가
                };
                
                // 페이지 로드 시 모든 이미지 표시
                showAllImages();

                // 라디오 버튼에 클릭 이벤트 추가
                radioInputs.forEach(radio => {
                    // 기존 이벤트 리스너 제거 (중복 방지)
                    radio.removeEventListener('click', handleRadioClick);
                    radio.removeEventListener('change', handleRadioClick);
                    // 새 이벤트 리스너 추가
                    radio.addEventListener('click', handleRadioClick);
                    radio.addEventListener('change', handleRadioClick);
                });
                
                // 라디오 버튼 클릭 핸들러 함수
                function handleRadioClick(e) {
                    // 현재 스크롤 위치 저장
                    const currentScrollPosition = window.pageYOffset || document.documentElement.scrollTop;
                    
                    // 이미지 변경 (현재는 변경하지 않음)
                    showImage('default');
                    
                    // 스크롤 위치 복원 (즉시 실행)
                    window.scrollTo(0, currentScrollPosition);
                    
                    // 디버깅: 선택된 라디오 버튼 확인
                    console.log('라디오 버튼 클릭됨:', e.target.value);
                }
            }

            // 왼쪽 탭 클릭하면 오른쪽 영역 일정테이블로 변경 JS
            const filterButtons = document.querySelectorAll('.filter-btn');
            const content1 = document.querySelector('.r-content-1');
            const content2 = document.querySelector('.r-content-2');

            // 요소가 존재하는지 확인 후 스타일 변경
            if (content1 && content2) {
                // Initially set r-content-1 to display none and r-content-2 to display block
                content1.style.display = 'none';
                content2.style.display = 'block';

                // Add click event listener to each filter button
                filterButtons.forEach(button => {
                    button.addEventListener('click', function() {
                        // Show r-content-1 and hide r-content-2
                        content1.style.display = 'block';
                        content2.style.display = 'none';
                    });
                });
            }
        }
        
        // DOM 로드 완료 시 이벤트 리스너 초기화
        document.addEventListener('DOMContentLoaded', initializeEventListeners);
        
        // 페이지 로드 완료 시에도 이벤트 리스너 초기화 (안전장치)
        window.addEventListener('load', initializeEventListeners);

        // 예약신청 버튼 클릭 시 선택한 좌석 정보를 전달하는 함수
        function submitReservation() {
            const selectedColor = document.querySelector('input[name="color"]:checked');

            if (!selectedColor) {
                alert('좌석을 선택해주세요.');
                return;
            }

            const color = selectedColor.value;
            const scheduleId = '${schedule.uid}';
            const homeTeam = '${schedule.homeTeam}';
            const awayTeam = '${schedule.otherTeam}';
            const gameDate = '${schedule.gameDate}';
            const gameTime = '${schedule.gameTime}';

            // 선택한 좌석의 가격 정보 가져오기
            let seatPrice = 0;
            let selectedSeatName = '';
            
            // color는 이제 인덱스 값이므로 해당 인덱스의 가격과 좌석명을 가져옴
            const priceElement = document.getElementById('price_' + color);
            const seatNameElement = document.getElementById('seatName_' + color);
            
            if (priceElement) {
                seatPrice = priceElement.value;
            }
            if (seatNameElement) {
                selectedSeatName = seatNameElement.value;
            }
            
            // URL 파라미터로 정보 전달 (문자열 더하기 방식)
            const url = "account-detail-2" +
                "?uid=" + encodeURIComponent(scheduleId) +
                "&homeTeam=" + encodeURIComponent(homeTeam) +
                "&awayTeam=" + encodeURIComponent(awayTeam) +
                "&gameDate=" + encodeURIComponent(gameDate) +
                "&gameTime=" + encodeURIComponent(gameTime) +
                "&selectedColor=" + encodeURIComponent(color) +
                "&selectedSeatName=" + encodeURIComponent(selectedSeatName) +
                "&seatPrice=" + encodeURIComponent(seatPrice);
                
            // 페이지 이동 전에 스크롤을 맨 위로 이동하고 즉시 페이지 이동
            window.scrollTo(0, 0);
            
            // 페이지 이동을 더 안정적으로 처리
            try {
                window.location.href = url;
            } catch (error) {
                // 에러 발생 시 대체 방법
                window.location.replace(url);
            }
        }

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
                                <li class="widget-list-item"><a href="accout">일정표</a></li>
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


<script>
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