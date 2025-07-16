<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- JavaScript를 먼저 로드하여 함수들을 정의 -->
<script>
// 전역 함수들을 즉시 정의
window.updateReservationStatus = function(id, status) {
    console.log('예약상태 변경 호출:', id, status);
    if (typeof updateStatus === 'function') {
        updateStatus('reservation', id, status);
    } else {
        console.error('updateStatus 함수가 정의되지 않았습니다.');
        alert('시스템 오류가 발생했습니다. 페이지를 새로고침해주세요.');
    }
};

window.updatePaymentStatus = function(id, status) {
    console.log('결제상태 변경 호출:', id, status);
    if (typeof updateStatus === 'function') {
        updateStatus('payment', id, status);
    } else {
        console.error('updateStatus 함수가 정의되지 않았습니다.');
        alert('시스템 오류가 발생했습니다. 페이지를 새로고침해주세요.');
    }
};

window.updateApprovalStatus = function(id, status) {
    console.log('승인상태 변경 호출:', id, status);
    if (typeof updateStatus === 'function') {
        updateStatus('approval', id, status);
    } else {
        console.error('updateStatus 함수가 정의되지 않았습니다.');
        alert('시스템 오류가 발생했습니다. 페이지를 새로고침해주세요.');
    }
};

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
    
    console.log('요청 URL:', url);
    console.log('요청 헤더:', headers);
    console.log('요청 데이터:', { status: status });
    
    // POST 요청 보내기
    fetch(url, {
        method: 'POST',
        headers: headers,
        body: JSON.stringify({ status: status })
    })
    .then(function(response) {
        console.log('응답 상태:', response.status);
        console.log('응답 헤더:', response.headers);
        
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
            isSuccess = data.trim() === 'success' || data.trim() === 'SUCCESS';
            message = data.trim();
        }
        
        if (isSuccess) {
            console.log('성공: ' + typeText[type] + '가 성공적으로 변경되었습니다.');
            // 성공 메시지 표시
            showSuccessMessage(typeText[type] + '가 변경되었습니다.');
            // 1초 후 페이지 새로고침
            setTimeout(function() { 
                console.log('페이지 새로고침 실행');
                location.reload(); 
            }, 1000);
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

console.log('JavaScript 함수들이 정의되었습니다.');
</script>

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
                <option value="gameDate" ${searchType == 'gameDate' ? 'selected' : ''}>경기날짜</option>
            </select>
            <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="검색어를 입력하세요 (경기날짜: YYYY-MM 형식)" style="width: 200px;" id="searchKeyword">
            
            <!-- 경기날짜 검색용 년/월 선택 (기본 숨김) -->
            <div id="dateSearchContainer" style="display: none;" class="d-flex gap-2">
                <select name="searchYear" class="form-select" style="width: auto;" id="searchYear">
                    <option value="">년도 선택</option>
                    <option value="2025" ${searchYear == '2025' ? 'selected' : ''}>2025</option>
                    <option value="2026" ${searchYear == '2026' ? 'selected' : ''}>2026</option>
                    <option value="2027" ${searchYear == '2027' ? 'selected' : ''}>2027</option>
                    <option value="2028" ${searchYear == '2028' ? 'selected' : ''}>2028</option>
                    <option value="2029" ${searchYear == '2029' ? 'selected' : ''}>2029</option>
                    <option value="2030" ${searchYear == '2030' ? 'selected' : ''}>2030</option>
                </select>
                <select name="searchMonth" class="form-select" style="width: auto;" id="searchMonth">
                    <option value="">월 선택</option>
                    <option value="01" ${searchMonth == '01' ? 'selected' : ''}>1월</option>
                    <option value="02" ${searchMonth == '02' ? 'selected' : ''}>2월</option>
                    <option value="03" ${searchMonth == '03' ? 'selected' : ''}>3월</option>
                    <option value="04" ${searchMonth == '04' ? 'selected' : ''}>4월</option>
                    <option value="05" ${searchMonth == '05' ? 'selected' : ''}>5월</option>
                    <option value="06" ${searchMonth == '06' ? 'selected' : ''}>6월</option>
                    <option value="07" ${searchMonth == '07' ? 'selected' : ''}>7월</option>
                    <option value="08" ${searchMonth == '08' ? 'selected' : ''}>8월</option>
                    <option value="09" ${searchMonth == '09' ? 'selected' : ''}>9월</option>
                    <option value="10" ${searchMonth == '10' ? 'selected' : ''}>10월</option>
                    <option value="11" ${searchMonth == '11' ? 'selected' : ''}>11월</option>
                    <option value="12" ${searchMonth == '12' ? 'selected' : ''}>12월</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-search me-1"></i>검색
            </button>
            <c:if test="${not empty keyword}">
                <a href="/admin/register_schedule/list" class="btn btn-secondary">
                    <i class="fas fa-times me-1"></i>초기화
                </a>
            </c:if>
        </form>
    </div>

    <!-- 예약목록 테이블 -->
    <div class="table-responsive">
        <table class="table table-hover">
            <thead class="table-dark">
                <tr>
                    <th style="width: 80px;">번호</th>
                    <th style="width: 120px;">예약자명</th>
                    <th style="width: 150px;">예약번호</th>
                    <th style="width: 200px;">경기명</th>
                    <th style="width: 120px;">경기날짜</th>
                    <th style="width: 100px;">금액</th>
                    <th style="width: 100px;">예약상태</th>
                    <th style="width: 100px;">결제상태</th>
                    <th style="width: 100px;">승인상태</th>
                    <th style="width: 120px;">등록일</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty reservations}">
                        <tr>
                            <td colspan="10" class="text-center py-4">
                                <i class="fas fa-inbox fa-2x text-muted mb-2"></i>
                                <p class="text-muted">등록된 예약이 없습니다.</p>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="reservation" items="${reservations}" varStatus="status">
                            <tr>
                                <td class="text-center">${totalItems - (currentPage * 50) - status.index}</td>
                                <td class="text-center">
                                    <a href="/admin/register_schedule/detail/${reservation.id}" class="text-decoration-none">
                                        <i class="fas fa-user me-1 text-primary"></i>
                                        ${reservation.customerName}
                                    </a>
                                </td>
                                <td class="text-center">
                                    <span class="badge bg-info">
                                        <i class="fas fa-ticket-alt me-1"></i>
                                        ${reservation.id}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <strong>${reservation.homeTeam}</strong> vs <strong>${reservation.awayTeam}</strong>
                                </td>
                                <td class="text-center">${reservation.gameDate} ${reservation.gameTime}</td>
                                <td class="text-center">
                                    <span class="badge bg-success">
                                        <fmt:formatNumber value="${reservation.totalPrice}" pattern="#,###"/>
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
                                    <c:choose>
                                        <c:when test="${not empty reservation.createdAt}">
                                            <c:catch var="parseException">
                                                <fmt:parseDate value="${reservation.createdAt}" pattern="yyyy-MM-dd" var="parsedDate"/>
                                                <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd"/>
                                            </c:catch>
                                            <c:if test="${not empty parseException}">
                                                ${reservation.createdAt}
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            -
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
    
    <!-- 페이징 -->
    <div class="mt-4 mb-5">
        <nav aria-label="예약목록 페이지 네비게이션">
            <ul class="pagination justify-content-center">
                <!-- 이전 페이지 -->
                <li class="page-item ${hasPrevious ? '' : 'disabled'}">
                    <a class="page-link" href="/admin/register_schedule/list?page=${currentPage - 1}&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">
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
                        <a class="page-link" href="/admin/register_schedule/list?page=0&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">1</a>
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
                        <a class="page-link" href="/admin/register_schedule/list?page=${pageNum}&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">
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
                        <a class="page-link" href="/admin/register_schedule/list?page=${totalPages - 1}&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">${totalPages}</a>
                    </li>
                </c:if>
                
                <!-- 다음 페이지 -->
                <li class="page-item ${hasNext ? '' : 'disabled'}">
                    <a class="page-link" href="/admin/register_schedule/list?page=${currentPage + 1}&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">
                        <i class="fas fa-chevron-right"></i>
                    </a>
                </li>
            </ul>
        </nav>
        
        <!-- 페이지 정보 -->
        <div class="text-center text-muted page-info">
            총 ${totalItems}개의 예약 중 ${(currentPage * 50) + 1} - ${Math.min((currentPage + 1) * 50, totalItems)}번째
        </div>
    </div>
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
    
    /* 페이징 및 하단 여백 확보 */
    .content-card {
        min-height: 100vh;
        padding-bottom: 150px;
        margin-bottom: 50px;
    }
    
    .table-responsive {
        margin-bottom: 3rem;
    }
    
    .pagination {
        margin-bottom: 3rem;
    }
    
    /* 페이지 정보 스타일 */
    .page-info {
        margin-top: 1rem;
        padding: 1rem;
        background-color: #f8f9fa;
        border-radius: 0.375rem;
    }
    
    /* 날짜 검색 컨테이너 스타일 */
    #dateSearchContainer {
        transition: all 0.3s ease;
    }
    
    /* 예약번호 배지 스타일 */
    .badge.bg-info {
        font-size: 0.8rem;
        padding: 0.5rem 0.75rem;
    }
    
    /* 페이징 영역 스타일 */
    .pagination-container {
        margin-top: 2rem;
        margin-bottom: 3rem;
        padding-bottom: 2rem;
    }
    
    /* 테이블 하단 여백 확보 */
    .table-responsive {
        margin-bottom: 2rem;
    }
    
    /* 전체 컨테이너 하단 여백 */
    .content-card {
        padding-bottom: 2rem;
        min-height: 100vh;
    }
</style>

<!-- 페이지 로드 후 초기화 스크립트 -->
<script>
// 페이지 로드 후 초기화
document.addEventListener('DOMContentLoaded', function() {
    console.log('페이지 로드 완료 - 초기화 시작');
    
    // 페이징 정보 확인
    const pagination = document.querySelector('.pagination');
    const pageInfo = document.querySelector('.page-info');
    
    if (pagination) {
        console.log('페이징 발견:', pagination.outerHTML);
    } else {
        console.log('페이징이 발견되지 않음');
    }
    
    if (pageInfo) {
        console.log('페이지 정보 발견:', pageInfo.textContent);
    } else {
        console.log('페이지 정보가 발견되지 않음');
    }
    
    // 검색 타입에 따른 플레이스홀더 변경
    const searchTypeSelect = document.querySelector('select[name="searchType"]');
    const searchKeywordInput = document.getElementById('searchKeyword');
    
    if (searchTypeSelect && searchKeywordInput) {
        // 초기 플레이스홀더 설정
        updatePlaceholder();
        
        // 검색 타입 변경 시 플레이스홀더 업데이트
        searchTypeSelect.addEventListener('change', updatePlaceholder);
        
        function updatePlaceholder() {
            const selectedType = searchTypeSelect.value;
            const dateSearchContainer = document.getElementById('dateSearchContainer');
            
            switch(selectedType) {
                case 'customerName':
                    searchKeywordInput.placeholder = '예약자명을 입력하세요';
                    dateSearchContainer.style.display = 'none';
                    searchKeywordInput.style.display = 'block';
                    break;
                case 'homeTeam':
                    searchKeywordInput.placeholder = '홈팀명을 입력하세요';
                    dateSearchContainer.style.display = 'none';
                    searchKeywordInput.style.display = 'block';
                    break;
                case 'awayTeam':
                    searchKeywordInput.placeholder = '원정팀명을 입력하세요';
                    dateSearchContainer.style.display = 'none';
                    searchKeywordInput.style.display = 'block';
                    break;
                case 'gameDate':
                    searchKeywordInput.style.display = 'none';
                    dateSearchContainer.style.display = 'flex';
                    break;
                default:
                    searchKeywordInput.placeholder = '검색어를 입력하세요';
                    dateSearchContainer.style.display = 'none';
                    searchKeywordInput.style.display = 'block';
            }
        }
    }
    
    // 상태 변경 버튼 확인
    const statusButtons = document.querySelectorAll('[onclick*="update"]');
    console.log('상태 변경 버튼 개수:', statusButtons.length);
    
    statusButtons.forEach(function(button, index) {
        console.log('버튼 ' + (index + 1) + ':', button.outerHTML);
    });
    
    // 에러 처리 개선
    window.addEventListener('error', function(e) {
        console.error('JavaScript 에러 발생:', e.error);
    });
    
    // 네트워크 에러 처리
    window.addEventListener('unhandledrejection', function(e) {
        console.error('네트워크 에러 발생:', e.reason);
    });
});
</script>