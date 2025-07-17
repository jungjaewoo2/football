<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--좌측 메뉴 시작-->               
<div class="col-lg-3 d-none d-lg-block account-side-navigation nav nav-tabs" id="myTab" role="tablist">
    <!-- 현재 날짜 기준으로 1년간의 월별 탭 생성 -->
    <c:forEach begin="0" end="11" var="i" varStatus="status">
        <c:set var="targetMonth" value="${currentMonth + i}" />
        <c:set var="targetYear" value="${currentYear}" />
        
        <!-- 월이 12를 넘어가면 다음 해로 넘어감 -->
        <c:if test="${targetMonth > 12}">
            <c:set var="targetMonth" value="${targetMonth - 12}" />
            <c:set var="targetYear" value="${targetYear + 1}" />
        </c:if>
        
        <c:set var="displayYear" value="${targetYear % 100}" />
        <c:set var="displayMonth" value="${targetMonth < 10 ? '0' : ''}${targetMonth}" />
        <c:set var="yearMonth" value="${targetYear}-${displayMonth}" />
        <c:set var="isSelected" value="${selectedYearMonth == yearMonth}" />
        <c:set var="isActive" value="${selectedYearMonth == yearMonth || (empty selectedYearMonth && status.first)}" />
        
        <div class="nav-item" role="presentation">
            <a href="/account-list?yearMonth=${yearMonth}" class="filter-btn nav-link ${isActive ? 'active border-top' : ''}" 
               id="tab-${status.index + 1}" type="button" role="tab" 
               aria-selected="${isSelected ? 'true' : 'false'}">
                <i class="fal fa-calendar-day"></i>${displayYear}년 ${displayMonth}월 일정표
            </a>
        </div>
    </c:forEach>
</div>

<div class="d-block d-lg-none account-side-navigation nav nav-tabs" id="myTabMobile" role="tablist">
    <div class="d-flex overflow-scroll">
        
<!--모바일 일정표 날짜 선택 시작-->                            
        <!-- 현재 날짜 기준으로 1년간의 월별 탭 생성 -->
        <c:forEach begin="0" end="11" var="i" varStatus="status">
            <c:set var="targetMonth" value="${currentMonth + i}" />
            <c:set var="targetYear" value="${currentYear}" />
            
            <!-- 월이 12를 넘어가면 다음 해로 넘어감 -->
            <c:if test="${targetMonth > 12}">
                <c:set var="targetMonth" value="${targetMonth - 12}" />
                <c:set var="targetYear" value="${targetYear + 1}" />
            </c:if>
            
            <c:set var="displayYear" value="${targetYear % 100}" />
            <c:set var="displayMonth" value="${targetMonth < 10 ? '0' : ''}${targetMonth}" />
            <c:set var="yearMonth" value="${targetYear}-${displayMonth}" />
            <c:set var="isSelected" value="${selectedYearMonth == yearMonth}" />
            <c:set var="isActive" value="${selectedYearMonth == yearMonth || (empty selectedYearMonth && status.first)}" />
            
            <div class="nav-item" role="presentation">
                <a href="/account-list?yearMonth=${yearMonth}" class="filter-btn nav-link ${isActive ? 'active border-top' : ''}" 
                   id="mobile-tab-${status.index + 1}" type="button" role="tab" 
                   aria-selected="${isSelected ? 'true' : 'false'}">
                    <i class="fal fa-calendar-day"></i>${displayYear}/${displayMonth}
                </a>
            </div>
        </c:forEach>
<!--모바일 일정표 날짜 선택 끝-->

    </div>
</div>
<!--좌측 메뉴 끝--> 