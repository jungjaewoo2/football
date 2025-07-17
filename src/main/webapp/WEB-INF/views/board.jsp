<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                                <li><a class="current-page" href="#">FEEDBACK</a></li>
                            </ul>
                        </div>
                        <h1 class="banner-heading">관전후기</h1>
                    </div>
                </div>
            </div>
        </div>
        <!--================= Banner Section End Here =================-->
    </header>
    <!--================= Header Section End Here =================-->



    <!--================= Account Section Start Here =================-->
    <div class="rts-events-section section-gap">
        <div class="container">
            <div class="account-inner">
                <div class="row d-flex">
                    <!-- 좌측 메뉴 include -->
                    <jsp:include page="account-list-left.jsp" />                                  
                    <div class="col-lg-9">
                        
                        
                        <div class="r-content-2">
                            <div class="row">
                                <c:forEach var="gallery" items="${galleries}">
                                    <div class="col-xl-4 col-md-6">
                                        <div class="event-single">
                                            <div class="event-picture">
                                                <c:choose>
                                                    <c:when test="${not empty gallery.img}">
                                                        <a href="board-detail?uid=${gallery.uid}"><img src="/uploads/gallery/${gallery.img}" alt="관전후기 이미지">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="board-detail?uid=${gallery.uid}"><img src="assets/images/event/event1.jpg" alt="기본 이미지">
                                                    </c:otherwise>
                                                </c:choose>
                                                <div class="event-date-floating gap-1">
                                                    <span class="day">by.</span>
                                                    <span class="month">${gallery.name}</span>
                                                    <span class="year">${gallery.ref} views</span>
                                                </div>
                                            </div>

                                            <div class="contents">
                                                <a href="board-detail?uid=${gallery.uid}" style="text-decoration: none; color: inherit;">
                                                    <p>
                                                        <c:choose>
                                                            <c:when test="${fn:length(gallery.title) > 50}">
                                                                ${fn:substring(gallery.title, 0, 50)}...
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${gallery.title}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            
                            <!-- 페이징 처리 -->
                            <div class="product-pagination-area justify-content-center mt-4">
                                <c:if test="${hasPrevious}">
                                    <button class="prev" onclick="location.href='board?page=${currentPage - 1}'">
                                        <i class="fal fa-angle-double-left"></i>
                                    </button>
                                </c:if>
                                
                                <c:set var="startPage" value="${(currentPage / 5) * 5}" />
                                <c:set var="endPage" value="${startPage + 4}" />
                                <c:if test="${endPage >= totalPages}">
                                    <c:set var="endPage" value="${totalPages - 1}" />
                                </c:if>
                                
                                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                    <c:choose>
                                        <c:when test="${i == currentPage}">
                                            <button class="number active">${i + 1}</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="number" onclick="location.href='board?page=${i}'">${i + 1}</button>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                
                                <c:if test="${hasNext}">
                                    <button class="next" onclick="location.href='board?page=${currentPage + 1}'">
                                        <i class="fal fa-angle-double-right"></i>
                                    </button>
                                </c:if>
                            </div>
                        </div>
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

        // 왼쪽 탭 클릭하면 오른쪽 영역 일정테이블로 변경 JS

        document.addEventListener('DOMContentLoaded', function() {
            // Select all filter buttons
            const filterButtons = document.querySelectorAll('.filter-btn');

            // Select content containers
            const content1 = document.querySelector('.r-content-1');
            const content2 = document.querySelector('.r-content-2');

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
                        <a href="#">회원약관</a>
                        <a href="faq">개인정보처리방침</a>
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
