<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content-card">
    <div class="content-header">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h2>📅 일정표 관리</h2>
                <p>경기 일정을 관리하고 설정할 수 있습니다.</p>
            </div>
            <a href="/admin/schedule_info/register" class="btn btn-primary">
                <i class="fas fa-plus me-2"></i>새 일정 등록
            </a>
        </div>
    </div>
    
    <!-- 알림 메시지 -->
    <c:if test="${not empty message}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle me-2"></i>${message}
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i>${error}
        </div>
    </c:if>
    
    <!-- 검색 폼 -->
    <form method="GET" action="/admin/schedule_info/list" class="mb-4">
        <div class="row">
            <div class="col-md-4">
                <div class="input-group">
                    <input type="text" class="form-control" name="search" 
                           placeholder="팀명으로 검색..." value="${search}">
                    <button class="btn btn-secondary" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>
            <div class="col-md-4">
                <select class="form-control" name="category" onchange="this.form.submit()">
                    <option value="">전체 경기분류</option>
                    <option value="UEFA 챔스" ${category == 'UEFA 챔스' ? 'selected' : ''}>UEFA 챔스</option>
                    <option value="UEFA 컵" ${category == 'UEFA 컵' ? 'selected' : ''}>UEFA 컵</option>
                    <option value="FA컵" ${category == 'FA컵' ? 'selected' : ''}>FA컵</option>
                    <option value="리그컵" ${category == '리그컵' ? 'selected' : ''}>리그컵</option>
                    <option value="커뮤니티 쉴드" ${category == '커뮤니티 쉴드' ? 'selected' : ''}>커뮤니티 쉴드</option>
                    <option value="A 매치" ${category == 'A 매치' ? 'selected' : ''}>A 매치</option>
                    <option value="기타" ${category == '기타' ? 'selected' : ''}>기타</option>
                </select>
            </div>
        </div>
    </form>
    
    <!-- 일정표 목록 테이블 -->
    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th width="8%">번호</th>
                    <th width="12%">경기분류</th>
                    <th width="15%">홈팀구장명</th>
                    <th width="15%">홈팀</th>
                    <th width="15%">원정팀</th>
                    <th width="12%">경기날짜</th>
                    <th width="10%">경기시간</th>
                    <th width="13%">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty scheduleList}">
                        <tr>
                            <td colspan="8" class="text-center py-4">
                                <i class="fas fa-calendar-alt fa-2x text-muted mb-2"></i>
                                <p class="text-muted">등록된 일정이 없습니다.</p>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="schedule" items="${scheduleList}" varStatus="status">
                            <tr>
                                <td>${schedule.uid}</td>
                                <td>
                                    <span class="badge bg-primary">${schedule.gameCategory}</span>
                                </td>
                                <td>${schedule.homeStadium}</td>
                                <td>
                                    <strong>${schedule.homeTeam}</strong>
                                </td>
                                <td>
                                    <strong>${schedule.otherTeam}</strong>
                                </td>
                                <td>${schedule.gameDate}</td>
                                <td>${schedule.gameTime}</td>
                                <td>
                                    <div class="btn-group" role="group">
                                        <a href="/admin/schedule_info/edit/${schedule.uid}" 
                                           class="btn btn-sm btn-primary" 
                                           title="수정">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="/admin/schedule_info/delete/${schedule.uid}" 
                                           class="btn btn-sm btn-danger" 
                                           title="삭제">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
    
    <!-- 페이징 -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="일정표 목록 페이지">
            <ul class="pagination">
                <!-- 이전 페이지 -->
                <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                    <a class="page-link" href="/admin/schedule_info/list?page=${currentPage - 1}&search=${search}&category=${category}">
                        <i class="fas fa-chevron-left"></i>
                    </a>
                </li>
                
                <!-- 페이지 번호 -->
                <c:forEach begin="0" end="${totalPages - 1}" var="pageNum">
                    <li class="page-item ${currentPage == pageNum ? 'active' : ''}">
                        <a class="page-link" href="/admin/schedule_info/list?page=${pageNum}&search=${search}&category=${category}">
                            ${pageNum + 1}
                        </a>
                    </li>
                </c:forEach>
                
                <!-- 다음 페이지 -->
                <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                    <a class="page-link" href="/admin/schedule_info/list?page=${currentPage + 1}&search=${search}&category=${category}">
                        <i class="fas fa-chevron-right"></i>
                    </a>
                </li>
            </ul>
        </nav>
    </c:if>
    
    <!-- 통계 정보 -->
    <div class="text-muted text-center mt-3">
        <small>
            총 ${totalItems}개의 일정이 있습니다.
            (${currentPage + 1} / ${totalPages} 페이지)
        </small>
    </div>
</div> 