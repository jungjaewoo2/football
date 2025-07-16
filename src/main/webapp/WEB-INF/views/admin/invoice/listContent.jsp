<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-file-invoice me-2"></i>인보이스 목록</h2>
        <p>예약 인보이스 목록을 관리합니다.</p>
    </div>
    
    <!-- 알림 메시지 -->
    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle me-2"></i>${success}
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i>${error}
        </div>
    </c:if>
    
    <c:if test="${param.success != null}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle me-2"></i>${param.success}
        </div>
    </c:if>
    
    <c:if test="${param.error != null}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i>${param.error}
        </div>
    </c:if>
    
    <!-- 검색 영역 -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <!-- 검색 폼 -->
        <form method="GET" action="/admin/invoice/list" class="d-flex gap-2">
            <input type="hidden" name="page" value="0">
            <select name="searchType" class="form-select" style="width: auto;">
                <option value="customerName" ${searchType == 'customerName' ? 'selected' : ''}>예약자명</option>
                <option value="homeTeam" ${searchType == 'homeTeam' ? 'selected' : ''}>홈팀</option>
                <option value="awayTeam" ${searchType == 'awayTeam' ? 'selected' : ''}>원정팀</option>
            </select>
            <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="검색어를 입력하세요" style="width: 200px;">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-search me-1"></i>검색
            </button>
            <c:if test="${not empty keyword}">
                <a href="/admin/invoice/list" class="btn btn-secondary">
                    <i class="fas fa-times me-1"></i>초기화
                </a>
            </c:if>
        </form>
    </div>

    <!-- 인보이스 목록 테이블 -->
    <div class="table-responsive">
        <table class="table table-hover">
            <thead class="table-dark">
                <tr>
                    <th style="width: 80px;">번호</th>
                    <th style="width: 120px;">예약번호</th>
                    <th style="width: 120px;">예약자</th>
                    <th style="width: 200px;">경기명</th>
                    <th style="width: 120px;">경기날짜</th>
                    <th style="width: 100px;">좌석(수량)</th>
                    <th style="width: 100px;">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty invoices}">
                        <tr>
                            <td colspan="7" class="text-center py-4">
                                <i class="fas fa-inbox fa-2x text-muted mb-2"></i>
                                <p class="text-muted">등록된 인보이스가 없습니다.</p>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="invoice" items="${invoices}" varStatus="status">
                            <tr>
                                <td class="text-center">${totalItems - (currentPage * 10) - status.index}</td>
                                <td class="text-center">
                                    <span class="badge bg-primary">INV-${String.format("%06d", invoice.id)}</span>
                                </td>
                                <td class="text-center">
                                    <i class="fas fa-user me-1 text-primary"></i>
                                    ${invoice.customerName}
                                </td>
                                <td class="text-center">
                                    <strong>${invoice.homeTeam}</strong> vs <strong>${invoice.awayTeam}</strong>
                                </td>
                                <td class="text-center">${invoice.gameDate} ${invoice.gameTime}</td>
                                <td class="text-center">
                                    <span class="badge bg-info">${invoice.ticketQuantity}석</span>
                                </td>
                                <td class="text-center">
                                    <div class="btn-group" role="group">
                                        <a href="/admin/invoice/detail/${invoice.id}" class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-eye me-1"></i>상세보기
                                        </a>
                                        <button type="button" class="btn btn-sm btn-outline-danger" 
                                                onclick="deleteInvoice('${invoice.id}')">
                                            <i class="fas fa-trash me-1"></i>삭제
                                        </button>
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
        <nav aria-label="인보이스 목록 페이지 네비게이션">
            <ul class="pagination justify-content-center">
                <!-- 이전 페이지 -->
                <li class="page-item ${hasPrevious ? '' : 'disabled'}">
                    <a class="page-link" href="/admin/invoice/list?page=${currentPage - 1}&searchType=${searchType}&keyword=${keyword}">
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
                        <a class="page-link" href="/admin/invoice/list?page=0&searchType=${searchType}&keyword=${keyword}">1</a>
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
                        <a class="page-link" href="/admin/invoice/list?page=${pageNum}&searchType=${searchType}&keyword=${keyword}">
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
                        <a class="page-link" href="/admin/invoice/list?page=${totalPages - 1}&searchType=${searchType}&keyword=${keyword}">${totalPages}</a>
                    </li>
                </c:if>
                
                <!-- 다음 페이지 -->
                <li class="page-item ${hasNext ? '' : 'disabled'}">
                    <a class="page-link" href="/admin/invoice/list?page=${currentPage + 1}&searchType=${searchType}&keyword=${keyword}">
                        <i class="fas fa-chevron-right"></i>
                    </a>
                </li>
            </ul>
        </nav>
        
        <!-- 페이지 정보 -->
        <div class="text-center text-muted">
            총 ${totalItems}개의 인보이스 중 ${(currentPage * 10) + 1} - ${Math.min((currentPage + 1) * 10, totalItems)}번째
        </div>
    </c:if>
</div>

<script>
function deleteInvoice(id) {
    if (confirm('정말로 이 인보이스를 삭제하시겠습니까?')) {
        fetch(`/admin/invoice/delete/${id}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            }
        })
        .then(response => {
            if (response.ok) {
                location.reload();
            } else {
                alert('삭제 중 오류가 발생했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('삭제 중 오류가 발생했습니다.');
        });
    }
}
</script> 