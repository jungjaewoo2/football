<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content-card">
    <div class="content-header">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h2>🏟️ 좌석요금 관리</h2>
                <p>경기장 좌석별 요금을 설정하고 관리할 수 있습니다.</p>
            </div>
            <a href="/admin/seat_fee/register" class="btn btn-primary">
                <i class="fas fa-plus me-2"></i>새 좌석요금 등록
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
    <form method="GET" action="/admin/seat_fee/list" class="mb-4">
        <input type="hidden" name="page" value="0">
        <div class="row">
            <div class="col-md-4">
                <div class="input-group">
                    <input type="text" class="form-control" name="search" 
                           placeholder="좌석요금명으로 검색..." value="${search}">
                    <button class="btn btn-secondary" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>
        </div>
    </form>
    
    <!-- 좌석요금 목록 테이블 -->
    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th width="8%">번호</th>
                    <th width="15%">좌석요금명</th>
                    <th width="10%">ORANGE</th>
                    <th width="10%">YELLOW</th>
                    <th width="10%">GREEN</th>
                    <th width="10%">BLUE</th>
                    <th width="10%">PURPLE</th>
                    <th width="10%">RED</th>
                    <th width="10%">BLACK</th>
                    <th width="7%">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty seatFees}">
                        <tr>
                            <td colspan="10" class="text-center py-4">
                                <i class="fas fa-inbox fa-2x text-muted mb-2"></i>
                                <p class="text-muted">등록된 좌석요금이 없습니다.</p>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="seatFee" items="${seatFees}" varStatus="status">
                            <tr>
                                <td>${seatFee.uid}</td>
                                <td>
                                    <strong>${seatFee.seatName}</strong>
                                </td>
                                <td>
                                    <span class="badge bg-warning">
                                        <fmt:formatNumber value="${seatFee.orange}" pattern="#,###"/>
                                    </span>
                                </td>
                                <td>
                                    <span class="badge bg-warning">
                                        <fmt:formatNumber value="${seatFee.yellow}" pattern="#,###"/>
                                    </span>
                                </td>
                                <td>
                                    <span class="badge bg-success">
                                        <fmt:formatNumber value="${seatFee.green}" pattern="#,###"/>
                                    </span>
                                </td>
                                <td>
                                    <span class="badge bg-primary">
                                        <fmt:formatNumber value="${seatFee.blue}" pattern="#,###"/>
                                    </span>
                                </td>
                                <td>
                                    <span class="badge bg-purple">
                                        <fmt:formatNumber value="${seatFee.purple}" pattern="#,###"/>
                                    </span>
                                </td>
                                <td>
                                    <span class="badge bg-danger">
                                        <fmt:formatNumber value="${seatFee.red}" pattern="#,###"/>
                                    </span>
                                </td>
                                <td>
                                    <span class="badge bg-dark">
                                        <fmt:formatNumber value="${seatFee.black}" pattern="#,###"/>
                                    </span>
                                </td>
                                <td>
                                    <div class="btn-group" role="group">
                                        <a href="/admin/seat_fee/edit/${seatFee.uid}" 
                                           class="btn btn-sm btn-primary" 
                                           title="수정">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="/admin/seat_fee/delete/${seatFee.uid}" 
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
    <c:if test="${totalPages >= 1}">
        <nav aria-label="좌석요금 목록 페이지 네비게이션">
            <ul class="pagination justify-content-center">
                <!-- 처음 페이지 버튼 -->
                <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                    <a class="page-link" href="/admin/seat_fee/list?page=0&search=${search}">
                        <i class="fas fa-angle-double-left"></i>
                    </a>
                </li>
                
                <!-- 이전 페이지 버튼 -->
                <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                    <a class="page-link" href="/admin/seat_fee/list?page=${currentPage - 1}&search=${search}">
                        <i class="fas fa-angle-left"></i>
                    </a>
                </li>
                
                <!-- 페이지 번호 (5개씩 그룹화) -->
                <c:set var="startPage" value="${(currentPage / 5) * 5}" />
                <c:set var="endPage" value="${startPage + 4}" />
                <c:if test="${endPage >= totalPages}">
                    <c:set var="endPage" value="${totalPages - 1}" />
                </c:if>
                
                <!-- 페이지 번호들 -->
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                    <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                        <a class="page-link" href="/admin/seat_fee/list?page=${pageNum}&search=${search}">
                            ${pageNum + 1}
                        </a>
                    </li>
                </c:forEach>
                
                <!-- 다음 페이지 버튼 -->
                <li class="page-item ${currentPage >= totalPages - 1 ? 'disabled' : ''}">
                    <a class="page-link" href="/admin/seat_fee/list?page=${currentPage + 1}&search=${search}">
                        <i class="fas fa-angle-right"></i>
                    </a>
                </li>
                
                <!-- 마지막 페이지 버튼 -->
                <li class="page-item ${currentPage >= totalPages - 1 ? 'disabled' : ''}">
                    <a class="page-link" href="/admin/seat_fee/list?page=${totalPages - 1}&search=${search}">
                        <i class="fas fa-angle-double-right"></i>
                    </a>
                </li>
            </ul>
        </nav>
        
        <!-- 페이지 정보 -->
        <div class="text-center text-muted">
            총 ${totalItems}개의 좌석요금 중 ${(currentPage * 10) + 1} - ${Math.min((currentPage + 1) * 10, totalItems)}개 표시
        </div>
    </c:if>
</div> 