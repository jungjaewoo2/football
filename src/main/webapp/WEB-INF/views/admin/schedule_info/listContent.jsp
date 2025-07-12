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
        <input type="hidden" name="page" value="0">
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
            <ul class="pagination justify-content-center">
                <!-- 이전 페이지 -->
                <li class="page-item ${hasPrevious ? '' : 'disabled'}">
                    <a class="page-link" href="/admin/schedule_info/list?page=${currentPage - 1}&search=${search}&category=${category}">
                        <i class="fas fa-chevron-left"></i>
                    </a>
                </li>
                
                <!-- 페이지 번호 (최대 10개, 현재 페이지 중앙 배치) -->
                <c:set var="startPage" value="0" />
                <c:set var="endPage" value="${totalPages - 1}" />
                
                <c:if test="${totalPages > 10}">
                    <c:set var="halfDisplay" value="5" />
                    <c:set var="startPage" value="${currentPage - halfDisplay}" />
                    <c:set var="endPage" value="${currentPage + halfDisplay}" />
                    
                    <c:if test="${startPage < 0}">
                        <c:set var="startPage" value="0" />
                        <c:set var="endPage" value="9" />
                    </c:if>
                    
                    <c:if test="${endPage >= totalPages}">
                        <c:set var="endPage" value="${totalPages - 1}" />
                        <c:set var="startPage" value="${endPage - 9}" />
                        <c:if test="${startPage < 0}">
                            <c:set var="startPage" value="0" />
                        </c:if>
                    </c:if>
                </c:if>
                
                <!-- 첫 페이지로 이동 (생략 표시) -->
                <c:if test="${startPage > 0}">
                    <li class="page-item">
                        <a class="page-link" href="/admin/schedule_info/list?page=0&search=${search}&category=${category}">1</a>
                    </li>
                    <c:if test="${startPage > 1}">
                        <li class="page-item disabled">
                            <span class="page-link">...</span>
                        </li>
                    </c:if>
                </c:if>
                
                <!-- 페이지 번호들 -->
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                    <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                        <a class="page-link" href="/admin/schedule_info/list?page=${pageNum}&search=${search}&category=${category}">
                            ${pageNum + 1}
                        </a>
                    </li>
                </c:forEach>
                
                <!-- 마지막 페이지로 이동 (생략 표시) -->
                <c:if test="${endPage < totalPages - 1}">
                    <c:if test="${endPage < totalPages - 2}">
                        <li class="page-item disabled">
                            <span class="page-link">...</span>
                        </li>
                    </c:if>
                    <li class="page-item">
                        <a class="page-link" href="/admin/schedule_info/list?page=${totalPages - 1}&search=${search}&category=${category}">${totalPages}</a>
                    </li>
                </c:if>
                
                <!-- 다음 페이지 -->
                <li class="page-item ${hasNext ? '' : 'disabled'}">
                    <a class="page-link" href="/admin/schedule_info/list?page=${currentPage + 1}&search=${search}&category=${category}">
                        <i class="fas fa-chevron-right"></i>
                    </a>
                </li>
            </ul>
        </nav>
        
        <!-- 페이지 정보 -->
        <div class="text-center text-muted">
            총 ${totalItems}개의 일정 중 ${(currentPage * 10) + 1} - ${Math.min((currentPage + 1) * 10, totalItems)}번째
        </div>
    </c:if>
</div> 