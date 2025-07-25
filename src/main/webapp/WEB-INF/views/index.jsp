<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" class="darkmode" data-theme="light">

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
    <link rel="stylesheet" type="text/css" href="assets/css/variables/variable2.css">
    <!--================= Main Stylesheet =================-->
    <link rel="stylesheet" type="text/css" href="assets/css/main.css">
    <!--================= Add Stylesheet =================-->
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
</head>

<body class="home-five">
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
    <header id="rtsHeader" class="rts-header1 header-four">
        <div class="navbar-sticky">
            <div class="navbar-part navbar-part1">
                <div class="container">
                    <div class="navbar-inner">
                        <a href="./" class="logo"><img src="assets/images/logo.jpg" alt="sportius-logo"></a>
                        <a href="./" class="logo-sticky"><img src="assets/images/logo.jpg" alt="kester-logo"></a>
                        <div class="rts-menu main-menu">
                            <nav class="menus menu-toggle">
                                <ul class="nav__menu">
                                    <li class="has-dropdown"><a class="menu-item active1" href="#">Home</a></li>
                                    <li><a class="menu-item" href="account">일정표</a></li>
                                    <li class="has-dropdown"><a class="menu-item" href="faq">자주하는질문</a></li>
                                    <li class="has-dropdown"><a class="menu-item" href="ticket-qna">티켓문의</a></li>
                                    <li class="has-dropdown"><a class="menu-item" href="customer-center">고객센터</a></li>
                                    <li class="has-dropdown"><a class="menu-item" href="board">관전후기</a></li>
                                    <li><a class="menu-item" href="about">유로풋볼투어</a></li>
                                </ul>
                            </nav>
                        </div>
                        <div class="header-action-items header-action-items1">
                            <div class="search-part">
                                <div class="search-icon action-item icon"><i class="rt-search"></i></div>
                                <div class="search-input-area">
                                    <div class="container">
                                        <div class="search-input-inner">
                                            <div class="input-div">
                                                <div class="search-input-icon"><i class="rt-search mr--10"></i></div>
                                                <input id="searchInput1" class="search-input" type="text" placeholder="Search by keyword or #">
                                            </div>
                                            <div class="search-close-icon"><i class="rt-xmark"></i></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <a class="hamburger-menu aitem d-block d-lg-none">
                            <div class="hamburger-menu-inner">
                                <span></span>
                                <span class=""></span>
                                <span></span>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>

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
                    <li class="mm-link"><a class="mm-link" href="board">관전후기</a></li>
                    <li class="mm-link"><a class="mm-link" href="about">유로풋볼투어</a></li>
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
        <div class="banner banner1 banner5">
            <div class="swiper bannerSlide2">
                <div class="swiper-wrapper">
                    
 <!--- 메인 이미지 시작-->                   
                    <c:forEach var="mainImg" items="${mainImgs}">
                        <div class="swiper-slide">
                            <div class="banner-single banner-single-1 banner-bg" style="background-image: url('uploads/main_img/${mainImg.img}');">
                                <div class="container">
                                    <div class="banner-content">
                                        <span class="pretitle">NEW SEASON</span>
                                        <h1 class="banner-heading">프리미어 티켓
                                            <div class="fs-4 mt-5 fw-light">개막 전 및 박싱데이 사전예약</div>
                                        </h1>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
<!--- 메인 이미지 끝-->





                </div>
            </div>
            <div class="container">
                <div class="swiper-bottom-area">
                    <div class="slider-pagination-area">
                        <div class="swiper-pagination">
                            <c:forEach var="mainImg" items="${mainImgs}" varStatus="status">
                                <span class="swiper-pagination-bullet ${status.index == 0 ? 'one' : status.index == 1 ? 'two' : 'three'}"></span>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 메인 하단 이미지링크 -->
        <div class="banner-r" style="margin: 130px auto 30px;">
            <div class="container d-flex gap-2 justify-content-end">
                
    <!--메인 배너 시작-->            
                <c:forEach var="mainBanner" items="${mainBanners}">
                    <div class="main-slide-bottom-img">
                        <a href="${not empty mainBanner.url ? mainBanner.url : 'account.html'}">
                            <img src="uploads/main_banner/${mainBanner.img}" alt="${mainBanner.imgName}">
                        </a>
                    </div>
                </c:forEach>
    <!--메인 배너 끝-->            
            </div>
        </div>
        <!--================= Banner Section End Here =================-->
    </div>
    </header>
    <!--================= Header Section End Here =================-->

    <!--================= Gallery Section Start Here =================-->
    <div class="rts-gallery-section home-four baseball border-top">
        <div class="container">
            <div class="top-wrap justify-content-center">
                <div class="section-title-area section-title-area1 text-center">
                    <h1 class="title mb--20">티켓 안내</h1>
                    <p>해당 클럽 클릭 시 소속 리그 일정표로 바로 안내!</p>
                </div>
            </div>
            <div class="home">
                <div class="gallery-grid">
                    <div class="row">
                        <c:if test="${not empty teamInfos}">
                            <c:forEach var="teamInfo" items="${teamInfos}" varStatus="status">
                        <div class="col-lg-4 col-md-6">
                            <div class="item small-post flex-column flex-lg-row">
                                        <a href="account?team=${teamInfo.teamName}" class="gallery-picture">
                                            <c:choose>
                                                <c:when test="${not empty teamInfo.logoImg}">
                                                    <img src="uploads/team_info/${teamInfo.logoImg}" alt="${teamInfo.teamName}">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="assets/images/img/team-01.jpg" alt="${teamInfo.teamName}">
                                                </c:otherwise>
                                            </c:choose>
                                </a>
                                <div class="contents-wrapper">
                                    <div class="contents text-start pb-3 pt-3">
                                        <div class="d-block">
                                            <div class="gallery-title">
                                                        <a href="account-list?team=${teamInfo.teamName}">${teamInfo.teamName}</a>
                                            </div>
                                                    <div class="heading flex-column" style="min-height: 60px;">
                                                        <c:choose>
                                                            <c:when test="${not empty teamInfo.content and teamInfo.content != '' and teamInfo.content != '뉎꽮뉎꽮뉎꽮뉎꽮뉎꽮' and teamInfo.content != '뉎꽮뉎꽮뉎꽮뉎꽮뉎꽮뉎꽮' and teamInfo.content != '뉎꽮뉎꽩밤뀋담꽮뉎꽩밤뀋담꽮' and teamInfo.content != '뉎꽮뉎꽮뉎꽮담꽮담꽮뉎꽩밤뀋담꽮뉎꽩밤뀋담꽮담뀋밤뀋담꽮담뀋밤꽩뉎꽮담뀋밤꽩뉎꽮담뀋밤꽩뉎꽮담뀋'}">
                                                                <p class="team-content">${teamInfo.content}</p>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <p class="team-content">${teamInfo.teamName}의 일정을 확인하세요.</p>
                                                            </c:otherwise>
                                                        </c:choose>
                                            </div>
                                        </div>
                                        <div class="author-info">
                                            <div class="content">
                                                        <a href="account-list?team=${teamInfo.teamName}" class="read-more">바로가기</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty teamInfos}">
                            <div class="col-12 text-center">
                                <p class="text-muted">등록된 팀정보가 없습니다.</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--================= Gallery Section End Here =================-->

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
    <!--================= counter up Plugin =================-->
    <script src="assets/js/vendors/jquery.counterup.min.js"></script>
    <!--================= Timer Plugin =================-->
    <script src="assets/js/vendors/timer.js"></script>
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
    
    <!-- 팝업창 기능 -->
    <c:if test="${not empty popups}">
        <c:forEach var="popup" items="${popups}">
            <div id="popup-${popup.uid}" class="popup-overlay" style="display: none;">
                <div class="popup-content">
                    <div class="popup-header">
                        <h3>${popup.popupName}</h3>
                        <button class="popup-close" onclick="closePopup('${popup.uid}')">&times;</button>
                    </div>
                    <div class="popup-body">
                        <img src="uploads/popup/${popup.img}" alt="${popup.popupName}" style="max-width: 100%; height: auto;">
                    </div>
                </div>
            </div>
        </c:forEach>
    </c:if>
    
    <style>
        .popup-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 9999;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .popup-content {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            max-width: 90%;
            max-height: 90%;
            overflow: auto;
        }
        
        .popup-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
        }
        
        .popup-header h3 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
        }
        
        .popup-close {
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
            color: #666;
            padding: 0;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .popup-close:hover {
            color: #000;
        }
        
        .popup-body {
            padding: 20px;
        }
        
        /* 팀 내용 텍스트 스타일 */
        .team-content {
            line-height: 1.4;
            word-wrap: break-word;
            overflow-wrap: break-word;
        }
    </style>
    
    <script>
        // 팝업창 기능
        function showPopup(popupId) {
            document.getElementById('popup-' + popupId).style.display = 'flex';
        }
        
        function closePopup(popupId) {
            document.getElementById('popup-' + popupId).style.display = 'none';
            // 쿠키에 팝업 닫힘 정보 저장 (24시간 동안)
            setCookie('popup_closed_' + popupId, 'true', 1);
        }
        
        function setCookie(name, value, days) {
            const expires = new Date();
            expires.setTime(expires.getTime() + (days * 24 * 60 * 60 * 1000));
            document.cookie = name + '=' + value + ';expires=' + expires.toUTCString() + ';path=/';
        }
        
        function getCookie(name) {
            const nameEQ = name + "=";
            const ca = document.cookie.split(';');
            for(let i = 0; i < ca.length; i++) {
                let c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
            }
            return null;
        }
        
        // 페이지 로드 시 팝업 표시
        document.addEventListener('DOMContentLoaded', function() {
            // 팝업 데이터가 있는 경우에만 실행
            const popupElements = document.querySelectorAll('[id^="popup-"]');
            popupElements.forEach(function(element) {
                const popupId = element.id.replace('popup-', '');
                // 팝업이 닫혔는지 확인
                if (getCookie('popup_closed_' + popupId) !== 'true') {
                    // 1초 후 팝업 표시
                    setTimeout(function() {
                        showPopup(popupId);
                    }, 1000);
                }
            });
            
            // 팀 내용 텍스트 40자 제한 처리
            const teamContents = document.querySelectorAll('.team-content');
            teamContents.forEach(function(element) {
                const text = element.textContent;
                
                // 40자 이상인 경우 처리
                if (text.length > 40) {
                    // 원본 텍스트를 저장
                    element.setAttribute('data-full-text', text);
                    
                    // 40자로 자르고 "..." 추가
                    const truncatedText = text.substring(0, 40);
                    element.textContent = truncatedText + '...';
                    
                    // 마우스 호버 시 전체 텍스트 표시
                    element.addEventListener('mouseenter', function() {
                        const fullText = this.getAttribute('data-full-text');
                        if (fullText) {
                            this.textContent = fullText;
                        }
                    });
                    
                    element.addEventListener('mouseleave', function() {
                        const fullText = this.getAttribute('data-full-text');
                        if (fullText) {
                            this.textContent = truncatedText + '...';
                        }
                    });
                }
            });
        });
    </script>
</body>

</html> 