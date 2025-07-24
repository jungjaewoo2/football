<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-calendar-check me-2"></i>예약목록 관리</h2>
        <p>예약 목록을 관리합니다.</p>
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
        <form method="GET" action="/admin/register_schedule/list" class="d-flex gap-2">
            <input type="hidden" name="page" value="0">
            <select name="searchType" class="form-select" style="width: auto;">
                <option value="customerName" ${searchType == 'customerName' ? 'selected' : ''}>예약자명</option>
                <option value="homeTeam" ${searchType == 'homeTeam' ? 'selected' : ''}>홈팀</option>
                <option value="awayTeam" ${searchType == 'awayTeam' ? 'selected' : ''}>원정팀</option>
                <option value="reservationStatus" ${searchType == 'reservationStatus' ? 'selected' : ''}>예약상태</option>
                <option value="approvalStatus" ${searchType == 'approvalStatus' ? 'selected' : ''}>승인상태</option>
            </select>
            <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="검색어를 입력하세요" style="width: 200px;" id="searchKeyword">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-search me-1"></i>검색
            </button>
            <c:if test="${not empty keyword}">
                <a href="/admin/register_schedule/list" class="btn btn-secondary">
                    <i class="fas fa-times me-1"></i>초기화
                </a>
            </c:if>
        </form>
        
        <!-- 빠른 검색 버튼 -->
        <div class="d-flex gap-2">
            <a href="/admin/register_schedule/list" 
               class="btn btn-sm ${(empty searchType && empty keyword) ? 'btn-primary' : 'btn-outline-primary'}">
                <i class="fas fa-list me-1"></i>전체목록
            </a>
            <a href="/admin/register_schedule/list?searchType=reservationStatus&keyword=예약완료&page=0" 
               class="btn btn-sm ${(searchType == 'reservationStatus' && keyword == '예약완료') ? 'btn-success' : 'btn-outline-success'}">
                <i class="fas fa-check me-1"></i>예약완료
            </a>
            <a href="/admin/register_schedule/list?searchType=approvalStatus&keyword=미승인&page=0" 
               class="btn btn-sm ${(searchType == 'approvalStatus' && keyword == '미승인') ? 'btn-warning' : 'btn-outline-warning'}">
                <i class="fas fa-clock me-1"></i>미승인
            </a>
        </div>
    </div>

    <%-- 년/월별 버튼 영역 추가 --%>
    <div class="mb-3">
        <div>
            <strong>${thisYear}년</strong>
            <c:forEach begin="1" end="12" var="m">
                <a href="?searchYear=${thisYear}&searchMonth=${m}&searchType=${searchType}&keyword=${keyword}"
                   class="btn btn-sm ${(thisYear == selectedYear && m == selectedMonth) ? 'btn-primary' : 'btn-outline-secondary'}"
                   style="margin-right:2px; margin-bottom:2px;">
                    ${m}월(${yearMonthCounts[thisYear][m] != null ? yearMonthCounts[thisYear][m] : 0})
                </a>
            </c:forEach>
        </div>
        <div class="mt-2">
            <strong>${nextYear}년</strong>
            <c:forEach begin="1" end="12" var="m">
                <a href="?searchYear=${nextYear}&searchMonth=${m}&searchType=${searchType}&keyword=${keyword}"
                   class="btn btn-sm ${(nextYear == selectedYear && m == selectedMonth) ? 'btn-primary' : 'btn-outline-secondary'}"
                   style="margin-right:2px; margin-bottom:2px;">
                    ${m}월(${yearMonthCounts[nextYear][m] != null ? yearMonthCounts[nextYear][m] : 0})
                </a>
            </c:forEach>
        </div>
    </div>

    <!-- 예약목록 테이블 -->
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th  class="text-center" style="width: 120px;">예약자명</th>
                    <th  class="text-center" style="width: 200px;">경기명</th>
                    <th  class="text-center" style="width: 120px;">경기날짜</th>
                    <th  class="text-center" style="width: 100px;">총금액</th>
                    <th  class="text-center" style="width: 100px;">예약상태</th>
                    <th  class="text-center" style="width: 100px;">결제상태</th>
                    <th  class="text-center" style="width: 100px;">승인상태</th>
                    <th  class="text-center" style="width: 120px;">등록일</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty reservations}">
                        <tr>
                            <td colspan="8" class="text-center py-4">
                                <i class="fas fa-inbox fa-2x text-muted mb-2"></i>
                                <p class="text-muted">등록된 예약이 없습니다.</p>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="reservation" items="${reservations}" varStatus="status">
                            <tr>
                                <td class="text-center">
                                    <a href="/admin/register_schedule/detail/${reservation.id}" class="text-decoration-none">
                                        <i class="fas fa-user me-1 text-primary"></i>
                                        ${reservation.customerName}
                                    </a>
                                    <br>
                                    <small class="text-muted">
                                        <i class="fas fa-hashtag me-1"></i>
                                        ${reservation.uid}
                                    </small>
                                </td>
                                <td class="text-center">
                                    <strong>${reservation.homeTeamDisplay}</strong> vs <strong>${reservation.awayTeamDisplay}</strong>
                                </td>
                                <td class="text-center">${reservation.gameDate} ${reservation.gameTime}</td>
                                <td class="text-center">
                                    <span class="badge bg-success">
                                        ${reservation.totalPrice}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${reservation.reservationStatus == '예약완료'}">
                                            <button type="button" class="btn btn-sm btn-success" disabled>
                                                <i class="fas fa-check me-1"></i>예약완료
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="btn btn-sm btn-warning" 
                                                    onclick="updateReservationStatus('${reservation.id}', '예약완료')">
                                                <i class="fas fa-clock me-1"></i>예약대기
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${reservation.paymentStatus == '결제완료'}">
                                            <button type="button" class="btn btn-sm btn-success" disabled>
                                                <i class="fas fa-check me-1"></i>결제완료
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="btn btn-sm btn-warning" 
                                                    onclick="updatePaymentStatus('${reservation.id}', '결제완료')">
                                                <i class="fas fa-clock me-1"></i>결제대기
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${reservation.approvalStatus == '승인완료'}">
                                            <button type="button" class="btn btn-sm btn-success" disabled>
                                                <i class="fas fa-check me-1"></i>승인완료
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="btn btn-sm btn-warning" 
                                                    onclick="updateApprovalStatus('${reservation.id}', '승인완료')">
                                                <i class="fas fa-clock me-1"></i>미승인
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    ${reservation.createdAt != null ? reservation.createdAt : '-'}
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
        <nav aria-label="예약목록 페이지 네비게이션">
            <ul class="pagination justify-content-center">
                <!-- 처음 페이지 버튼 -->
                <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                    <a class="page-link" href="/admin/register_schedule/list?page=0&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">
                        <i class="fas fa-angle-double-left"></i>
                    </a>
                </li>
                
                <!-- 이전 페이지 버튼 -->
                <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                    <a class="page-link" href="/admin/register_schedule/list?page=${currentPage - 1}&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">
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
                        <a class="page-link" href="/admin/register_schedule/list?page=${pageNum}&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">
                            ${pageNum + 1}
                        </a>
                    </li>
                </c:forEach>
                
                <!-- 다음 페이지 버튼 -->
                <li class="page-item ${currentPage >= totalPages - 1 ? 'disabled' : ''}">
                    <a class="page-link" href="/admin/register_schedule/list?page=${currentPage + 1}&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">
                        <i class="fas fa-angle-right"></i>
                    </a>
                </li>
                
                <!-- 마지막 페이지 버튼 -->
                <li class="page-item ${currentPage >= totalPages - 1 ? 'disabled' : ''}">
                    <a class="page-link" href="/admin/register_schedule/list?page=${totalPages - 1}&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">
                        <i class="fas fa-angle-double-right"></i>
                    </a>
                </li>
            </ul>
        </nav>
        
        <!-- 페이지 정보 -->
        <div class="text-center text-muted">
            총 ${totalItems}개의 예약 중 ${(currentPage * 10) + 1} - ${Math.min((currentPage + 1) * 10, totalItems)}개 표시
        </div>
    </c:if>
</div>

<!-- 스타일 추가 -->
<style>
    @keyframes slideIn {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes slideOut {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(100%);
            opacity: 0;
        }
    }
    
    .btn:disabled {
        cursor: not-allowed;
        opacity: 0.6;
    }
    
    .alert-floating {
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 9999;
        min-width: 300px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        animation: slideIn 0.3s ease-out;
    }
</style>

<!-- 개선된 JavaScript 코드 -->
<script>
// CSRF 토큰 가져오기 (Spring Security 사용 시)
function getCsrfToken() {
    const token = document.querySelector('meta[name="_csrf"]');
    const header = document.querySelector('meta[name="_csrf_header"]');
    return {
        token: token ? token.getAttribute('content') : '',
        header: header ? header.getAttribute('content') : 'X-CSRF-TOKEN'
    };
}

// 성공 메시지 표시 함수
function showSuccessMessage(message) {
    // 기존 알림이 있으면 제거
    const existingAlert = document.querySelector('.alert-floating');
    if (existingAlert) {
        existingAlert.remove();
    }
    
    // 새 알림 생성
    const alertDiv = document.createElement('div');
    alertDiv.className = 'alert alert-success alert-floating';
    alertDiv.innerHTML = '<i class="fas fa-check-circle me-2"></i>' + message;
    
    document.body.appendChild(alertDiv);
    
    // 3초 후 자동으로 사라지게
    setTimeout(() => {
        alertDiv.style.animation = 'slideOut 0.3s ease-out';
        setTimeout(() => alertDiv.remove(), 300);
    }, 3000);
}

// 공통 상태 업데이트 함수
function updateStatus(type, id, status) {
    const typeText = {
        'reservation': '예약상태',
        'payment': '결제상태',
        'approval': '승인상태'
    };
    
    if (!confirm(typeText[type] + '를 변경하시겠습니까?')) {
        return;
    }
    
    console.log(typeText[type] + ' 변경 요청:', { id: id, status: status });
    
    // CSRF 토큰 정보
    const csrf = getCsrfToken();
    
    // 요청 헤더 설정
    const headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
    };
    
    // CSRF 토큰이 있으면 헤더에 추가
    if (csrf.token) {
        headers[csrf.header] = csrf.token;
    }
    
    // API URL 구성
    const url = '/admin/register_schedule/update-' + type + '-status/' + id;
    
    // POST 요청 보내기
    fetch(url, {
        method: 'POST',
        headers: headers,
        body: JSON.stringify({ status: status })
    })
    .then(function(response) {
        console.log('응답 상태:', response.status);
        
        // 응답 상태 확인
        if (!response.ok) {
            throw new Error('HTTP error! status: ' + response.status);
        }
        
        // Content-Type 확인
        const contentType = response.headers.get('content-type');
        console.log('Content-Type:', contentType);
        
        // JSON 응답인 경우
        if (contentType && contentType.includes('application/json')) {
            return response.json();
        }
        // 텍스트 응답인 경우
        else {
            return response.text();
        }
    })
    .then(function(data) {
        console.log('응답 데이터:', data);
        
        // 성공 여부 확인 (JSON 또는 텍스트)
        let isSuccess = false;
        let message = '';
        
        if (typeof data === 'object' && data !== null) {
            // JSON 객체인 경우
            isSuccess = data.success === true || data.success === 'true';
            message = data.message || '';
        } else if (typeof data === 'string') {
            // 텍스트인 경우
            isSuccess = data.trim() === 'success';
            message = data.trim();
        }
        
        if (isSuccess) {
            console.log('성공: ' + typeText[type] + '가 성공적으로 변경되었습니다.');
            // 성공 메시지 표시
            showSuccessMessage(typeText[type] + '가 변경되었습니다.');
            // 1초 후 페이지 새로고침
            setTimeout(function() { location.reload(); }, 1000);
        } else {
            console.error('실패:', message);
            alert('상태 변경 중 오류가 발생했습니다: ' + message);
        }
    })
    .catch(function(error) {
        console.error('에러 발생:', error);
        alert('상태 변경 중 오류가 발생했습니다: ' + error.message);
    });
}

// 각 상태별 업데이트 함수
function updateReservationStatus(id, status) {
    updateStatus('reservation', id, status);
}

function updatePaymentStatus(id, status) {
    updateStatus('payment', id, status);
}

function updateApprovalStatus(id, status) {
    updateStatus('approval', id, status);
}

// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', function() {
    console.log('예약 상태 관리 스크립트 로드됨');
    
    // CSRF 토큰 확인
    const csrf = getCsrfToken();
    if (csrf.token) {
        console.log('CSRF 토큰 발견:', csrf.header);
    } else {
        console.log('CSRF 토큰 없음 (Spring Security 미사용 또는 설정 필요)');
    }

    // 검색 타입에 따라 키워드 입력 필드의 placeholder 변경
    const searchTypeSelect = document.querySelector('select[name="searchType"]');
    const searchKeywordInput = document.getElementById('searchKeyword');

    function updateKeywordPlaceholder() {
        const selectedType = searchTypeSelect.value;
        if (selectedType === 'customerName') {
            searchKeywordInput.placeholder = '예약자명을 입력하세요';
        } else if (selectedType === 'homeTeam') {
            searchKeywordInput.placeholder = '홈팀을 입력하세요';
        } else if (selectedType === 'awayTeam') {
            searchKeywordInput.placeholder = '원정팀을 입력하세요';
        } else if (selectedType === 'reservationStatus') {
            searchKeywordInput.placeholder = '예약상태를 입력하세요';
        } else if (selectedType === 'approvalStatus') {
            searchKeywordInput.placeholder = '승인상태를 입력하세요';
        } else {
            searchKeywordInput.placeholder = '검색어를 입력하세요';
        }
    }

    // 페이지 로드 시 초기 플레이스홀더 설정
    updateKeywordPlaceholder();

    // 검색 타입이 변경될 때마다 플레이스홀더 업데이트
    searchTypeSelect.addEventListener('change', updateKeywordPlaceholder);
});
</script>