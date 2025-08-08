<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                            <li class="widget-list-item"><i class="fas fa-envelope-open"></i><a href="mailto:${footerInfo != null ? footerInfo.email : ''}">${footerInfo != null ? footerInfo.email : ''}</a></li>
                            <li class="widget-list-item"><i class="fas fa-phone"></i><a href="tel:${footerInfo != null ? footerInfo.phone : ''}">${footerInfo != null ? footerInfo.phone : ''}</a></li>
                            <li class="widget-list-item"><i class="fas fa-map-marker-alt"></i> <span>${footerInfo != null ? footerInfo.address : '강원 춘천시 충혼길 52번길 10(온의동) 드림타워 3층 302호'}</span></li>
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
