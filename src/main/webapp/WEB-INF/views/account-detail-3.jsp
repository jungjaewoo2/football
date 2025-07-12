<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                    <div class="col-lg-3 d-none d-lg-block account-side-navigation nav nav-tabs">
                        <div class="nav-item" role="presentation">
                            <button class="filter-btn nav-link border-top" id="tab-01" data-bs-toggle="tab" data-bs-target="#tab-01-pane" type="button" role="tab" aria-controls="tab-01-pane" aria-selected="true"><i class="fal fa-calendar-day"></i>25년 07월 일정표</button>
                        </div>
                        <div class="nav-item" role="presentation">
                            <button class="filter-btn" id="tab-02" data-bs-toggle="tab" data-bs-target="#tab-02-pane" type="button" role="tab" aria-controls="tab-02-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>25년 08월 일정표</button>
                        </div>
                        <div class="nav-item" role="presentation">
                            <button class="filter-btn" id="tab-03" data-bs-toggle="tab" data-bs-target="#tab-03-pane" type="button" role="tab" aria-controls="tab-03-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>25년 09월 일정표</button>
                        </div>
                        <div class="nav-item" role="presentation">
                            <button class="filter-btn" id="tab-04" data-bs-toggle="tab" data-bs-target="#tab-04-pane" type="button" role="tab" aria-controls="tab-04-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>25년 10월 일정표</button>
                        </div>
                        <div class="nav-item" role="presentation">
                            <button class="filter-btn" id="tab-05" data-bs-toggle="tab" data-bs-target="#tab-05-pane" type="button" role="tab" aria-controls="tab-05-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>25년 11월 일정표</button>
                        </div>
                        <div class="nav-item" role="presentation">
                            <button class="filter-btn" id="tab-06" data-bs-toggle="tab" data-bs-target="#tab-06-pane" type="button" role="tab" aria-controls="tab-06-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>25년 12월 일정표</button>
                        </div>
                        <div class="nav-item" role="presentation">
                            <button class="filter-btn" id="tab-07" data-bs-toggle="tab" data-bs-target="#tab-07-pane" type="button" role="tab" aria-controls="tab-07-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>26년 01월 일정표</button>
                        </div>
                        <div class="nav-item" role="presentation">
                            <button class="filter-btn" id="tab-08" data-bs-toggle="tab" data-bs-target="#tab-08-pane" type="button" role="tab" aria-controls="tab-08-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>26년 02월 일정표</button>
                        </div>
                        <div class="nav-item" role="presentation">
                            <button class="filter-btn" id="tab-09" data-bs-toggle="tab" data-bs-target="#tab-09-pane" type="button" role="tab" aria-controls="tab-09-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>26년 03월 일정표</button>
                        </div>
                        <div class="nav-item" role="presentation">
                            <button class="filter-btn" id="tab-10" data-bs-toggle="tab" data-bs-target="#tab-10-pane" type="button" role="tab" aria-controls="tab-10-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>26년 04월 일정표</button>
                        </div>
                        <div class="nav-item" role="presentation">
                            <button class="filter-btn" id="tab-11" data-bs-toggle="tab" data-bs-target="#tab-11-pane" type="button" role="tab" aria-controls="tab-11-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>26년 05월 일정표</button>
                        </div>
                        <div class="nav-item" role="presentation">
                            <button class="filter-btn" id="tab-12" data-bs-toggle="tab" data-bs-target="#tab-12-pane" type="button" role="tab" aria-controls="tab-12-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>26년 06월 일정표</button>
                        </div>
                    </div>
                    <div class="d-block d-lg-none account-side-navigation nav nav-tabs" id="myTab" role="tablist">
                        <div class="d-flex overflow-scroll">
                            <div class="nav-item" role="presentation">
                                <button class="filter-btn nav-link border-top" id="tab-01" data-bs-toggle="tab" data-bs-target="#tab-01-pane" type="button" role="tab" aria-controls="tab-01-pane" aria-selected="true"><i class="fal fa-calendar-day"></i>25/07</button>
                            </div>
                            <div class="nav-item" role="presentation">
                                <button class="filter-btn" id="tab-02" data-bs-toggle="tab" data-bs-target="#tab-02-pane" type="button" role="tab" aria-controls="tab-02-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>25/08</button>
                            </div>
                            <div class="nav-item" role="presentation">
                                <button class="filter-btn" id="tab-03" data-bs-toggle="tab" data-bs-target="#tab-03-pane" type="button" role="tab" aria-controls="tab-03-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>25/09</button>
                            </div>
                            <div class="nav-item" role="presentation">
                                <button class="filter-btn" id="tab-04" data-bs-toggle="tab" data-bs-target="#tab-04-pane" type="button" role="tab" aria-controls="tab-04-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>25/10</button>
                            </div>
                            <div class="nav-item" role="presentation">
                                <button class="filter-btn" id="tab-05" data-bs-toggle="tab" data-bs-target="#tab-05-pane" type="button" role="tab" aria-controls="tab-05-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>25/11</button>
                            </div>
                            <div class="nav-item" role="presentation">
                                <button class="filter-btn" id="tab-06" data-bs-toggle="tab" data-bs-target="#tab-06-pane" type="button" role="tab" aria-controls="tab-06-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>25/12</button>
                            </div>
                            <div class="nav-item" role="presentation">
                                <button class="filter-btn" id="tab-07" data-bs-toggle="tab" data-bs-target="#tab-07-pane" type="button" role="tab" aria-controls="tab-07-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>26/01</button>
                            </div>
                            <div class="nav-item" role="presentation">
                                <button class="filter-btn" id="tab-08" data-bs-toggle="tab" data-bs-target="#tab-08-pane" type="button" role="tab" aria-controls="tab-08-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>26/02</button>
                            </div>
                            <div class="nav-item" role="presentation">
                                <button class="filter-btn" id="tab-09" data-bs-toggle="tab" data-bs-target="#tab-09-pane" type="button" role="tab" aria-controls="tab-09-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>26/03</button>
                            </div>
                            <div class="nav-item" role="presentation">
                                <button class="filter-btn" id="tab-10" data-bs-toggle="tab" data-bs-target="#tab-10-pane" type="button" role="tab" aria-controls="tab-10-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>26/04</button>
                            </div>
                            <div class="nav-item" role="presentation">
                                <button class="filter-btn" id="tab-11" data-bs-toggle="tab" data-bs-target="#tab-11-pane" type="button" role="tab" aria-controls="tab-11-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>26/05</button>
                            </div>
                            <div class="nav-item" role="presentation">
                                <button class="filter-btn" id="tab-12" data-bs-toggle="tab" data-bs-target="#tab-12-pane" type="button" role="tab" aria-controls="tab-12-pane" aria-selected="false"><i class="fal fa-calendar-day"></i>26/06</button>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-9">
                        <div class="row r-content-1">
                            <div class="tab-content" id="myTabContent">
                                <div class="tab-pane fade show active" id="tab-01-pane" role="tabpanel" aria-labelledby="tab-01" tabindex="0">
                                    <div class="game-date">2025년 07월 01일(화)</div>
                                    <div class="table-full d-none d-lg-block">
                                        <table class="table table-bordered text-center">
                                            <thead class="thead-dark">
                                            </thead>
                                            <tbody>
                                                <tr class="head-tr">
                                                    <th scope="col">경기</th>
                                                    <th scope="col">홈팀</th>
                                                    <th scope="col"></th>
                                                    <th scope="col">어웨이팀</th>
                                                    <th scope="col">경기시각</th>
                                                    <th scope="col">가격(원)</th>
                                                    <th scope="col">상세보기</th>
                                                </tr>
                                                <tr class="">
                                                    <td>UEFA챔스</td>
                                                    <td>맨유</td>
                                                    <td>VS</td>
                                                    <td>첼시</td>
                                                    <td>16:30</td>
                                                    <td>32만</td>
                                                    <td><button type="submit" class="btn btn-sm btn-danger" onclick="location.href='account-detail.html'">상세보기</button></td>
                                                </tr>
                                            </tbody>
                                        </table>

                                    </div>
                                    <div class="d-block d-lg-none pt-1">
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger" onclick="location.href='account-detail.html'">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨유 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>첼시 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">16:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">32만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger" onclick="location.href='account-detail.html'">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨시티 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>리버풀 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">18:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">33만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="tab-pane fade" id="tab-02-pane" role="tabpanel" aria-labelledby="tab-02" tabindex="0">
                                    <div class="game-date">2025년 08월 01일(화)</div>
                                    <div class="table-full d-none d-lg-block">
                                        <table class="table table-bordered text-center">
                                            <thead class="thead-dark">
                                            </thead>
                                            <tbody>
                                                <tr class="head-tr">
                                                    <th scope="col">경기</th>
                                                    <th scope="col">홈팀</th>
                                                    <th scope="col"></th>
                                                    <th scope="col">어웨이팀</th>
                                                    <th scope="col">경기시각</th>
                                                    <th scope="col">가격(원)</th>
                                                    <th scope="col">상세보기</th>
                                                </tr>
                                                <tr class="">
                                                    <td>UEFA챔스</td>
                                                    <td>맨유</td>
                                                    <td>VS</td>
                                                    <td>첼시</td>
                                                    <td>16:30</td>
                                                    <td>32만</td>
                                                    <td><button type="submit" class="btn btn-sm btn-danger" onclick="location.href='account-detail.html'">상세보기</button></td>
                                                </tr>
                                            </tbody>
                                        </table>

                                    </div>
                                    <div class="d-block d-lg-none pt-1">
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨유 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>첼시 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">16:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">32만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨시티 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>리버풀 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">18:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">33만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-03-pane" role="tabpanel" aria-labelledby="tab-03" tabindex="0">
                                    <div class="game-date">2025년 09월 01일(화)</div>
                                    <div class="table-full d-none d-lg-block">
                                        <table class="table table-bordered text-center">
                                            <thead class="thead-dark">
                                            </thead>
                                            <tbody>
                                                <tr class="head-tr">
                                                    <th scope="col">경기</th>
                                                    <th scope="col">홈팀</th>
                                                    <th scope="col"></th>
                                                    <th scope="col">어웨이팀</th>
                                                    <th scope="col">경기시각</th>
                                                    <th scope="col">가격(원)</th>
                                                    <th scope="col">상세보기</th>
                                                </tr>
                                                <tr class="">
                                                    <td>UEFA챔스</td>
                                                    <td>맨유</td>
                                                    <td>VS</td>
                                                    <td>첼시</td>
                                                    <td>16:30</td>
                                                    <td>32만</td>
                                                    <td><button type="submit" class="btn btn-sm btn-danger">상세보기</button></td>
                                                </tr>
                                            </tbody>
                                        </table>

                                    </div>
                                    <div class="d-block d-lg-none pt-1">
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨유 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>첼시 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">16:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">32만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨시티 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>리버풀 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">18:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">33만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-04-pane" role="tabpanel" aria-labelledby="tab-04" tabindex="0">
                                    <div class="game-date">2025년 10월 01일(화)</div>
                                    <div class="table-full d-none d-lg-block">
                                        <table class="table table-bordered text-center">
                                            <thead class="thead-dark">
                                            </thead>
                                            <tbody>
                                                <tr class="head-tr">
                                                    <th scope="col">경기</th>
                                                    <th scope="col">홈팀</th>
                                                    <th scope="col"></th>
                                                    <th scope="col">어웨이팀</th>
                                                    <th scope="col">경기시각</th>
                                                    <th scope="col">가격(원)</th>
                                                    <th scope="col">상세보기</th>
                                                </tr>
                                                <tr class="">
                                                    <td>UEFA챔스</td>
                                                    <td>맨유</td>
                                                    <td>VS</td>
                                                    <td>첼시</td>
                                                    <td>16:30</td>
                                                    <td>32만</td>
                                                    <td><button type="submit" class="btn btn-sm btn-danger">상세보기</button></td>
                                                </tr>
                                            </tbody>
                                        </table>

                                    </div>
                                    <div class="d-block d-lg-none pt-1">
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨유 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>첼시 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">16:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">32만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨시티 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>리버풀 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">18:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">33만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-05-pane" role="tabpanel" aria-labelledby="tab-05" tabindex="0">
                                    <div class="game-date">2025년 11월 01일(화)</div>
                                    <div class="table-full d-none d-lg-block">
                                        <table class="table table-bordered text-center">
                                            <thead class="thead-dark">
                                            </thead>
                                            <tbody>
                                                <tr class="head-tr">
                                                    <th scope="col">경기</th>
                                                    <th scope="col">홈팀</th>
                                                    <th scope="col"></th>
                                                    <th scope="col">어웨이팀</th>
                                                    <th scope="col">경기시각</th>
                                                    <th scope="col">가격(원)</th>
                                                    <th scope="col">상세보기</th>
                                                </tr>
                                                <tr class="">
                                                    <td>UEFA챔스</td>
                                                    <td>맨유</td>
                                                    <td>VS</td>
                                                    <td>첼시</td>
                                                    <td>16:30</td>
                                                    <td>32만</td>
                                                    <td><button type="submit" class="btn btn-sm btn-danger">상세보기</button></td>
                                                </tr>
                                            </tbody>
                                        </table>

                                    </div>
                                    <div class="d-block d-lg-none pt-1">
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨유 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>첼시 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">16:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">32만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨시티 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>리버풀 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">18:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">33만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-06-pane" role="tabpanel" aria-labelledby="tab-06" tabindex="0">
                                    <div class="game-date">2025년 12월 01일(화)</div>
                                    <div class="table-full d-none d-lg-block">
                                        <table class="table table-bordered text-center">
                                            <thead class="thead-dark">
                                            </thead>
                                            <tbody>
                                                <tr class="head-tr">
                                                    <th scope="col">경기</th>
                                                    <th scope="col">홈팀</th>
                                                    <th scope="col"></th>
                                                    <th scope="col">어웨이팀</th>
                                                    <th scope="col">경기시각</th>
                                                    <th scope="col">가격(원)</th>
                                                    <th scope="col">상세보기</th>
                                                </tr>
                                                <tr class="">
                                                    <td>UEFA챔스</td>
                                                    <td>맨유</td>
                                                    <td>VS</td>
                                                    <td>첼시</td>
                                                    <td>16:30</td>
                                                    <td>32만</td>
                                                    <td><button type="submit" class="btn btn-sm btn-danger">상세보기</button></td>
                                                </tr>
                                            </tbody>
                                        </table>

                                    </div>
                                    <div class="d-block d-lg-none pt-1">
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨유 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>첼시 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">16:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">32만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨시티 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>리버풀 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">18:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">33만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-07-pane" role="tabpanel" aria-labelledby="tab-07" tabindex="0">
                                    <div class="game-date">2026년 01월 01일(화)</div>
                                    <div class="table-full d-none d-lg-block">
                                        <table class="table table-bordered text-center">
                                            <thead class="thead-dark">
                                            </thead>
                                            <tbody>
                                                <tr class="head-tr">
                                                    <th scope="col">경기</th>
                                                    <th scope="col">홈팀</th>
                                                    <th scope="col"></th>
                                                    <th scope="col">어웨이팀</th>
                                                    <th scope="col">경기시각</th>
                                                    <th scope="col">가격(원)</th>
                                                    <th scope="col">상세보기</th>
                                                </tr>
                                                <tr class="">
                                                    <td>UEFA챔스</td>
                                                    <td>맨유</td>
                                                    <td>VS</td>
                                                    <td>첼시</td>
                                                    <td>16:30</td>
                                                    <td>32만</td>
                                                    <td><button type="submit" class="btn btn-sm btn-danger">상세보기</button></td>
                                                </tr>
                                            </tbody>
                                        </table>

                                    </div>
                                    <div class="d-block d-lg-none pt-1">
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨유 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>첼시 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">16:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">32만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨시티 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>리버풀 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">18:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">33만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-08-pane" role="tabpanel" aria-labelledby="tab-08" tabindex="0">
                                    <div class="game-date">2026년 02월 01일(화)</div>
                                    <div class="table-full d-none d-lg-block">
                                        <table class="table table-bordered text-center">
                                            <thead class="thead-dark">
                                            </thead>
                                            <tbody>
                                                <tr class="head-tr">
                                                    <th scope="col">경기</th>
                                                    <th scope="col">홈팀</th>
                                                    <th scope="col"></th>
                                                    <th scope="col">어웨이팀</th>
                                                    <th scope="col">경기시각</th>
                                                    <th scope="col">가격(원)</th>
                                                    <th scope="col">상세보기</th>
                                                </tr>
                                                <tr class="">
                                                    <td>UEFA챔스</td>
                                                    <td>맨유</td>
                                                    <td>VS</td>
                                                    <td>첼시</td>
                                                    <td>16:30</td>
                                                    <td>32만</td>
                                                    <td><button type="submit" class="btn btn-sm btn-danger">상세보기</button></td>
                                                </tr>
                                            </tbody>
                                        </table>

                                    </div>
                                    <div class="d-block d-lg-none pt-1">
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨유 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>첼시 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">16:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">32만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨시티 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>리버풀 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">18:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">33만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-09-pane" role="tabpanel" aria-labelledby="tab-09" tabindex="0">
                                    <div class="game-date">2026년 03월 01일(화)</div>
                                    <div class="table-full d-none d-lg-block">
                                        <table class="table table-bordered text-center">
                                            <thead class="thead-dark">
                                            </thead>
                                            <tbody>
                                                <tr class="head-tr">
                                                    <th scope="col">경기</th>
                                                    <th scope="col">홈팀</th>
                                                    <th scope="col"></th>
                                                    <th scope="col">어웨이팀</th>
                                                    <th scope="col">경기시각</th>
                                                    <th scope="col">가격(원)</th>
                                                    <th scope="col">상세보기</th>
                                                </tr>
                                                <tr class="">
                                                    <td>UEFA챔스</td>
                                                    <td>맨유</td>
                                                    <td>VS</td>
                                                    <td>첼시</td>
                                                    <td>16:30</td>
                                                    <td>32만</td>
                                                    <td><button type="submit" class="btn btn-sm btn-danger">상세보기</button></td>
                                                </tr>
                                            </tbody>
                                        </table>

                                    </div>
                                    <div class="d-block d-lg-none pt-1">
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨유 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>첼시 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">16:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">32만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨시티 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>리버풀 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">18:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">33만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-10-pane" role="tabpanel" aria-labelledby="tab-10" tabindex="0">
                                    <div class="game-date">2026년 04월 01일(화)</div>
                                    <div class="table-full d-none d-lg-block">
                                        <table class="table table-bordered text-center">
                                            <thead class="thead-dark">
                                            </thead>
                                            <tbody>
                                                <tr class="head-tr">
                                                    <th scope="col">경기</th>
                                                    <th scope="col">홈팀</th>
                                                    <th scope="col"></th>
                                                    <th scope="col">어웨이팀</th>
                                                    <th scope="col">경기시각</th>
                                                    <th scope="col">가격(원)</th>
                                                    <th scope="col">상세보기</th>
                                                </tr>
                                                <tr class="">
                                                    <td>UEFA챔스</td>
                                                    <td>맨유</td>
                                                    <td>VS</td>
                                                    <td>첼시</td>
                                                    <td>16:30</td>
                                                    <td>32만</td>
                                                    <td><button type="submit" class="btn btn-sm btn-danger">상세보기</button></td>
                                                </tr>
                                            </tbody>
                                        </table>

                                    </div>
                                    <div class="d-block d-lg-none pt-1">
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨유 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>첼시 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">16:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">32만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨시티 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>리버풀 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">18:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">33만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-11-pane" role="tabpanel" aria-labelledby="tab-11" tabindex="0">
                                    <div class="game-date">2026년 05월 01일(화)</div>
                                    <div class="table-full d-none d-lg-block">
                                        <table class="table table-bordered text-center">
                                            <thead class="thead-dark">
                                            </thead>
                                            <tbody>
                                                <tr class="head-tr">
                                                    <th scope="col">경기</th>
                                                    <th scope="col">홈팀</th>
                                                    <th scope="col"></th>
                                                    <th scope="col">어웨이팀</th>
                                                    <th scope="col">경기시각</th>
                                                    <th scope="col">가격(원)</th>
                                                    <th scope="col">상세보기</th>
                                                </tr>
                                                <tr class="">
                                                    <td>UEFA챔스</td>
                                                    <td>맨유</td>
                                                    <td>VS</td>
                                                    <td>첼시</td>
                                                    <td>16:30</td>
                                                    <td>32만</td>
                                                    <td><button type="submit" class="btn btn-sm btn-danger">상세보기</button></td>
                                                </tr>
                                            </tbody>
                                        </table>

                                    </div>
                                    <div class="d-block d-lg-none pt-1">
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨유 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>첼시 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">16:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">32만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨시티 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>리버풀 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">18:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">33만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-12-pane" role="tabpanel" aria-labelledby="tab-12" tabindex="0">
                                    <div class="game-date">2026년 06월 01일(화)</div>
                                    <div class="table-full d-none d-lg-block">
                                        <table class="table table-bordered text-center">
                                            <thead class="thead-dark">
                                            </thead>
                                            <tbody>
                                                <tr class="head-tr">
                                                    <th scope="col">경기</th>
                                                    <th scope="col">홈팀</th>
                                                    <th scope="col"></th>
                                                    <th scope="col">어웨이팀</th>
                                                    <th scope="col">경기시각</th>
                                                    <th scope="col">가격(원)</th>
                                                    <th scope="col">상세보기</th>
                                                </tr>
                                                <tr class="">
                                                    <td>UEFA챔스</td>
                                                    <td>맨유</td>
                                                    <td>VS</td>
                                                    <td>첼시</td>
                                                    <td>16:30</td>
                                                    <td>32만</td>
                                                    <td><button type="submit" class="btn btn-sm btn-danger">상세보기</button></td>
                                                </tr>
                                            </tbody>
                                        </table>

                                    </div>
                                    <div class="d-block d-lg-none pt-1">
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨유 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>첼시 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">16:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">32만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column p-1 mb--10">
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="text-black-50">[ UEFA챔스 ]</div>
                                                <div><button type="submit" class="btn btn-sm btn-danger">상세보기</button></div>
                                            </div>
                                            <div class="mt-1 border-top border-bottom">
                                                <div class="game-list d-flex gap-4 justify-content-center fw-bold p-2">
                                                    <div>맨시티 <span class="text-black-50 fs-7">(홈)</span></div>
                                                    <div>VS</div>
                                                    <div>리버풀 <span class="text-black-50 fs-7">(어웨이)</span></div>
                                                </div>
                                                <div class="d-flex justify-content-end gap-1 text-black-50 fs-7">
                                                    <div>경기시각 <span class="fw-bold text-danger">18:30</span></div>
                                                    <div>|</div>
                                                    <div>가격(원) <span class="fw-bold text-danger">33만</span></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="product-pagination-area justify-content-center">
                                    <button class="prev"><i class="fal fa-angle-double-left"></i></button>
                                    <button class="number active">01</button>
                                    <button class="number">02</button>
                                    <button class="number">03</button>
                                    <button class="next"><i class="fal fa-angle-double-right"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="row r-content-2">
                            <div class="col-lg-12 p-0 d-flex flex-column flex-lg-row gap-2">
                                <div class="col-lg-6">
                                    <div class="seat-reserve">
                                        <img src="assets/images/img/orange.jpg">
                                    </div>
                                </div>
                                <div class="col-lg-6 mt-1 mt-lg-0">
                                    <table class="table table-bordered tb-style1 mb-2">
                                        <tbody>
                                            <tr>
                                                <th>날짜(시각)</th>
                                                <td>1970년 01월 01일</td>
                                            </tr>
                                            <tr>
                                                <th>홀팀</th>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <th>원정팀</th>
                                                <td></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <table class="table table-bordered tb-style1">
                                        <tbody>
                                            <tr>
                                                <th>좌석(전체)</th>
                                                <td>요금(구역)</td>
                                            </tr>
                                            <tr>
                                                <th><span style="color: darkorange;">●</span> orange</th>
                                                <td class="d-flex justify-content-between">
                                                    <div>만원()</div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="bg-light border-2 border-dark col-lg-12 mt--50 pt-2 pb-2">
                                <h5><i class="fad fa-user"></i> 예약자 정보</h5>

                            </div>
                            <div class="mt--10 mb--10 p-1">
                                <div class="table-responsive d-none d-lg-block">
                                    <table class="table ">
                                        <tbody>
                                            <tr>
                                                <th class="border text-center bg-light">이름</th>
                                                <td class="border px-2"><input type="text" class="form-control" id="exampleFormControlInput1" placeholder=""></td>
                                                <th class="border text-center bg-light">성별</th>
                                                <td class="border px-2">
                                                    <div class="d-flex gap-1">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="radioDefault" id="radioDefault1">
                                                            <label class="form-check-label" for="radioDefault1">
                                                                남
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="radioDefault" id="radioDefault2" checked>
                                                            <label class="form-check-label" for="radioDefault2">
                                                                여
                                                            </label>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">영문이름(여권)</th>
                                                <td class="border px-2"><input type="text" class="form-control" id="exampleFormControlInput1" placeholder=""></td>
                                                <th class="border text-center bg-light">휴대전화</th>
                                                <td class="border px-2"><input type="text" class="form-control" id="exampleFormControlInput1" placeholder=""></td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">E-mail</th>
                                                <td class="border px-2"><input type="text" class="form-control" id="exampleFormControlInput1" placeholder=""></td>
                                                <th class="border text-center bg-light">생년월일</th>
                                                <td class="border px-2"><input type="date" class="form-control" id="exampleFormControlInput1" placeholder=""></td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">주소(한국)</th>
                                                <td class="border px-2" colspan="3">
                                                    <div class="d-flex flex-column gap-1">
                                                        <div class="d-flex">
                                                            <input type="text" class="form-control w-auto" id="exampleFormControlInput1" placeholder="우편번호">
                                                            <button class="btn btn-sm btn-dark" type="button">우편번호 찾기</button>
                                                        </div>
                                                        <div class="d-flex gap-1">
                                                            <input type="text" class="form-control" id="exampleFormControlInput1" placeholder="주소">
                                                            <input type="text" class="form-control" id="exampleFormControlInput1" placeholder="상세주소">
                                                        </div>
                                                        <div><input type="text" class="form-control" id="exampleFormControlInput1" placeholder="영문주소"></div>
                                                    </div>

                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">카카오톡ID</th>
                                                <td class="border px-2" colspan="3">
                                                    <div class="align-items-center d-flex gap-1"><input type="text" class="form-control w-auto" id="exampleFormControlInput1" placeholder="">*카카오톡ID를 입력해주세요.</div>
                                                </td>
                                            </tr>
                                        </tbody>

                                    </table>

                                </div>
                                <div class="table-responsive d-block d-lg-none">
                                    <table class="table">
                                        <tbody>
                                            <tr>
                                                <th class="border text-center bg-light">이름</th>
                                                <td class="border px-2"><input type="text" class="form-control" id="exampleFormControlInput1" placeholder=""></td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">성별</th>
                                                <td class="border px-2">
                                                    <div class="d-flex gap-1">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="radioDefault" id="radioDefault1">
                                                            <label class="form-check-label" for="radioDefault1">
                                                                남
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="radioDefault" id="radioDefault2" checked>
                                                            <label class="form-check-label" for="radioDefault2">
                                                                여
                                                            </label>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">영문이름(여권)</th>
                                                <td class="border px-2"><input type="text" class="form-control" id="exampleFormControlInput1" placeholder=""></td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">휴대전화</th>
                                                <td class="border px-2"><input type="text" class="form-control" id="exampleFormControlInput1" placeholder=""></td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">E-mail</th>
                                                <td class="border px-2"><input type="text" class="form-control" id="exampleFormControlInput1" placeholder=""></td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">생년월일</th>
                                                <td class="border px-2"><input type="date" class="form-control" id="exampleFormControlInput1" placeholder=""></td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">주소(한국)</th>
                                                <td class="border px-2">
                                                    <div class="d-flex flex-column gap-1">
                                                        <div class="d-flex gap-1">
                                                            <input type="text" class="form-control w-auto" id="exampleFormControlInput1" placeholder="우편번호">
                                                            <button class="btn btn-sm btn-dark" type="button"><i class="fal fa-search"></i></button>
                                                        </div>
                                                        <div class="d-flex flex-column gap-1">
                                                            <input type="text" class="form-control" id="exampleFormControlInput1" placeholder="주소">
                                                            <input type="text" class="form-control" id="exampleFormControlInput1" placeholder="상세주소">
                                                        </div>
                                                        <div><input type="text" class="form-control" id="exampleFormControlInput1" placeholder="영문주소"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">카카오톡ID</th>
                                                <td class="border px-2"><input type="text" class="form-control" id="exampleFormControlInput1" placeholder="">*카카오톡ID를 입력해주세요.</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>


                            </div>
                            <div class="bg-light border-2 border-dark col-lg-12 mt--50 pt-2 pb-2">
                                <h5><i class="fad fa-user"></i> 티켓예약 정보</h5>

                            </div>
                            <div class="mt--10 mb--10 p-1">
                                <div class="table-responsive">
                                    <table class="table">
                                        <tbody>
                                            <tr>
                                                <th class="border text-center bg-light">날짜[시각]</th>
                                                <td class="border px-2">1970년 01월 01일 []</td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">MATCH</th>
                                                <td class="border px-2"></td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">좌석 및 수량</th>
                                                <td class="border-end px-2 d-flex align-items-center gap-3">
                                                    <span>만원()</span>
                                                    <div class="d-flex align-items-center gap-2">
                                                        <select class="form-select" aria-label="Default select example">
                                                            <option selected>0</option>
                                                            <option value="1">1</option>
                                                            <option value="2">2</option>
                                                            <option value="3">3</option>
                                                        </select>
                                                        <span>매</span>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">동행자 정보</th>
                                                <td class="border px-2">* 동행하시는 분들의 이름 및 생년월일(예:2015-06-20)을 기입해 주세요.</td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">티켓요금 합계</th>
                                                <td class="border-end px-2 d-flex align-items-center gap-3"><input type="text" class="form-control w-auto" id="exampleFormControlInput1" placeholder="">만원</td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">결제방법</th>
                                                <td class="border px-2">
                                                    <div class="d-flex flex-column gap-1">
                                                        <div class="d-flex flex-column flex-lg-row gap-0 gap-lg-3">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="radioDefault" id="radioDefault1">
                                                                <label class="form-check-label" for="radioDefault1">
                                                                    계좌이체
                                                                </label>
                                                            </div>
                                                            <div>
                                                                ※ 예약 시 작성하신 e메일을 통해 해외 송금 안내 메일이 발송 됩니다.<br>
                                                                ※ 입금 확인은 입금일 기준 오후 4~6시 또는 다음 날 오전 전화 드립니다.<br>
                                                                ※ 예약자와 입금자 명의가 다른 경우 전화 확인 바랍니다.

                                                            </div>
                                                        </div>
                                                        <div class="d-flex flex-column flex-lg-row gap-0 gap-lg-3">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="radioDefault" id="radioDefault2" checked="">
                                                                <label class="form-check-label" for="radioDefault2">
                                                                    신용카드
                                                                </label>
                                                            </div>
                                                            <div>(카드결제를 위해 예약 담당자가 연락드릴예정입니다.)</div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">좌석 대체 확보</th>
                                                <td class="border px-2">
                                                    <div class="d-flex flex-column flex-lg-row gap-1">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="radioDefault" id="radioDefault1">
                                                            <label class="form-check-label" for="radioDefault1">
                                                                예
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="radioDefault" id="radioDefault2" checked="">
                                                            <label class="form-check-label" for="radioDefault2">
                                                                아니오
                                                            </label>
                                                        </div>
                                                        <div>(요청 좌석 매진 시 타 카테고리 좌석 변경 진행 되며 차액 발생 또는 환불 진행 됩니다.)</div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">티켓 종류 및 전달방법</th>
                                                <td class="border px-2">E - Ticket (경기 1~2일 전 메일발송) (* 티켓 전달 방법 변경 시 개별 연락드립니다.)</td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">연석희망여부</th>
                                                <td class="border px-2">
                                                    <div class="d-flex flex-column flex-lg-row gap-1">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="radioDefault" id="radioDefault1">
                                                            <label class="form-check-label" for="radioDefault1">
                                                                예
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="radioDefault" id="radioDefault2" checked="">
                                                            <label class="form-check-label" for="radioDefault2">
                                                                아니오
                                                            </label>
                                                        </div>
                                                        <div class="px-3">3연석 이상 진행 시 추가요금이 발생 할 수 있습니다. (경기 7일 전 확인가능)</div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="border text-center bg-light">기타요청사항</th>
                                                <td class="border px-2">
                                                    <textarea class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>


                            </div>
                            <div class="col-lg-12 mt--20 text-center">
                                <button type="submit" class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#exampleModal"> 티켓예약</button>
                                <button type="submit" class="btn btn-sm btn-secondary">예약취소</button>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>

    <script>
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

    <!--================= Account Section End Here =================-->
    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel"></h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="location.href='account.html'"></button>
                </div>
                <div class="modal-body">
                    구매하신 e-티켓이 이메일로 발송되었습니다.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm btn-danger" data-bs-dismiss="modal" onclick="location.href='account.html'">확인</button>
                </div>
            </div>
        </div>
    </div>

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
