<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar-sticky">
    <div class="navbar-part navbar-part1">
        <div class="container">
            <div class="navbar-inner">
                <a href="index.jsp" class="logo"><img src="assets/images/logo.png" alt="logo"></a>
                <a href="index.jsp" class="logo-sticky"><img src="assets/images/logo.png" alt="kester-logo"></a>
                <div class="rts-menu">
                    <nav class="menus menu-toggle">
                        <ul class="nav__menu">
                            <li class="has-dropdown"><a class="menu-item" href="index.jsp">Home</a></li>
                            <li><a class="menu-item" href="account">일정표</a></li>
                            <li class="has-dropdown"><a class="menu-item" href="faq.html">자주하는질문</a></li>
                            <li class="has-dropdown"><a class="menu-item" href="ticket-qna.html">티켓문의</a></li>
                            <li class="has-dropdown"><a class="menu-item" href="customer-center.html">고객센터</a></li>
                            <li class="has-dropdown"><a class="menu-item" href="board.html">관전후기</a></li>
                            <li><a class="menu-item" href="about.html">유로풋볼투어</a></li>
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

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const menuItems = document.querySelectorAll('.nav__menu li a.menu-item');

        // Function to set active class based on stored href
        function setActiveMenu() {
            const activeHref = localStorage.getItem('activeMenu');
            menuItems.forEach(item => {
                item.classList.remove('active1');
                if (item.getAttribute('href') === activeHref) {
                    item.classList.add('active1');
                }
            });
            // If no active href is stored, set default to index.jsp
            if (!activeHref && window.location.pathname.endsWith('index.jsp')) {
                document.querySelector('.nav__menu li a[href="index.jsp"]').classList.add('active1');
            }
        }

        // Set active class on page load
        setActiveMenu();

        // Add click event listeners to menu items
        menuItems.forEach(item => {
            item.addEventListener('click', function() {
                // Remove active1 class from all menu items
                menuItems.forEach(menu => menu.classList.remove('active1'));
                // Add active1 class to clicked menu item
                this.classList.add('active1');
                // Store the href of the clicked item
                localStorage.setItem('activeMenu', this.getAttribute('href'));
            });
        });
    });
</script> 