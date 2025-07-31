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
            <i class="fas fa-check-circle me-2"></i><c:out value="${message}"/>
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i><c:out value="${error}"/>
        </div>
    </c:if>
    
    <!-- 검색 폼 -->
    <form method="GET" action="/admin/schedule_info/list" class="mb-4">
        <input type="hidden" name="page" value="0">
        <div class="row">
            <div class="col-md-4">
                <div class="input-group">
                    <input type="text" class="form-control" name="search" 
                           placeholder="팀명으로 검색..." value="<c:out value='${search}'/>">
                    <button class="btn btn-secondary" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>
            <div class="col-md-4">
                <select class="form-control" name="category" onchange="this.form.submit()">
                    <option value="">전체 경기분류</option>
                    <option value="UEFA 챔스" <c:out value="${category == 'UEFA 챔스' ? 'selected' : ''}"/>>UEFA 챔스</option>
                    <option value="UEFA 컵" <c:out value="${category == 'UEFA 컵' ? 'selected' : ''}"/>>UEFA 컵</option>
                    <option value="FA컵" <c:out value="${category == 'FA컵' ? 'selected' : ''}"/>>FA컵</option>
                    <option value="리그컵" <c:out value="${category == '리그컵' ? 'selected' : ''}"/>>리그컵</option>
                    <option value="커뮤니티 쉴드" <c:out value="${category == '커뮤니티 쉴드' ? 'selected' : ''}"/>>커뮤니티 쉴드</option>
                    <option value="A 매치" <c:out value="${category == 'A 매치' ? 'selected' : ''}"/>>A 매치</option>
                    <option value="기타" <c:out value="${category == '기타' ? 'selected' : ''}"/>>기타</option>
                </select>
            </div>
        </div>
    </form>
    
    <!-- 일괄 삭제 버튼 -->
    <div class="mb-3" id="bulkActionButtons" style="display: none;">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <span class="text-muted">
                    <i class="fas fa-check-square me-1"></i>
                    <span id="selectedCount">0</span>개 선택됨
                </span>
            </div>
            <div>
                <button type="button" class="btn btn-danger" onclick="deleteSelected()">
                    <i class="fas fa-trash me-1"></i>선택한 일정 삭제
                </button>
            </div>
        </div>
    </div>
    
    <!-- 일정표 목록 테이블 -->
    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th width="5%" class="text-center">
                        <div class="checkbox-container">
                            <input type="checkbox" id="selectAll" class="form-check-input">
                        </div>
                    </th>
                    <th width="12%" class="text-center">참가대회종류</th>
                    <th width="15%" class="text-center">홈팀구장명</th>
                    <th width="15%" class="text-center">홈팀</th>
                    <th width="15%" class="text-center">원정팀</th>
                    <th width="16%" class="text-center">경기날짜</th>
                    <th width="14%" class="text-center">경기시간</th>
                    <th width="13%" class="text-center">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty scheduleList}">
                        <tr>
                            <td colspan="9" class="text-center py-4">
                                <i class="fas fa-calendar-alt fa-2x text-muted mb-2"></i>
                                <p class="text-muted">등록된 일정이 없습니다.</p>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="schedule" items="${scheduleList}" varStatus="status">
                            <tr>
                                <td class="text-center">
                                    <div class="checkbox-container">
                                        <input type="checkbox" class="form-check-input schedule-checkbox" 
                                               value="<c:out value='${schedule.uid}'/>" data-schedule-name="<c:out value='${schedule.homeTeam}'/> vs <c:out value='${schedule.otherTeam}'/>">
                                    </div>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${schedule.gameCategory == 'EPL_1'}">
                                            <span class="badge bg-success">EPL(공식)</span>
                                        </c:when>
                                        <c:when test="${schedule.gameCategory == 'EPL_2'}">
                                            <span class="badge bg-warning">EPL(비공식)</span>
                                        </c:when>
                                        <c:when test="${schedule.gameCategory == 'ETC'}">
                                            <span class="badge bg-info">OET(공식)</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-primary"><c:out value="${schedule.gameCategory}"/></span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center"><c:out value="${schedule.homeStadium}"/></td>
                                <td class="text-center">
                                    <strong><c:out value="${schedule.homeTeam}"/></strong>
                                </td>
                                <td class="text-center">
                                    <strong><c:out value="${schedule.otherTeam}"/></strong>
                                </td>
                                <td class="text-center"><c:out value="${schedule.gameDate}"/></td>
                                <td class="text-center"><c:out value="${schedule.gameTime}"/></td>
                                <td class="text-center">
                                    <div class="btn-group" role="group">
                                        <a href="/admin/schedule_info/edit/<c:out value='${schedule.uid}'/>" 
                                           class="btn btn-sm btn-primary" 
                                           title="수정">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="/admin/schedule_info/delete/<c:out value='${schedule.uid}'/>" 
                                           class="btn btn-sm btn-danger" 
                                           title="삭제"
                                           onclick="return confirm('정말 삭제하시겠습니까?')">
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
        <nav aria-label="일정표 목록 페이지 네비게이션">
            <ul class="pagination justify-content-center">
                <!-- 처음 페이지 버튼 -->
                <li class="page-item <c:out value="${currentPage == 0 ? 'disabled' : ''}"/>">
                    <a class="page-link" href="/admin/schedule_info/list?page=0&search=<c:out value='${search}'/>&category=<c:out value='${category}'/>">
                        <i class="fas fa-angle-double-left"></i>
                    </a>
                </li>
                
                <!-- 이전 페이지 버튼 -->
                <li class="page-item <c:out value="${currentPage == 0 ? 'disabled' : ''}"/>">
                    <a class="page-link" href="/admin/schedule_info/list?page=<c:out value='${currentPage - 1}'/>&search=<c:out value='${search}'/>&category=<c:out value='${category}'/>">
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
                    <li class="page-item <c:out value="${pageNum == currentPage ? 'active' : ''}"/>">
                        <a class="page-link" href="/admin/schedule_info/list?page=<c:out value='${pageNum}'/>&search=<c:out value='${search}'/>&category=<c:out value='${category}'/>">
                            <c:out value="${pageNum + 1}"/>
                        </a>
                    </li>
                </c:forEach>
                
                <!-- 다음 페이지 버튼 -->
                <li class="page-item <c:out value="${currentPage >= totalPages - 1 ? 'disabled' : ''}"/>">
                    <a class="page-link" href="/admin/schedule_info/list?page=<c:out value='${currentPage + 1}'/>&search=<c:out value='${search}'/>&category=<c:out value='${category}'/>">
                        <i class="fas fa-angle-right"></i>
                    </a>
                </li>
                
                <!-- 마지막 페이지 버튼 -->
                <li class="page-item <c:out value="${currentPage >= totalPages - 1 ? 'disabled' : ''}"/>">
                    <a class="page-link" href="/admin/schedule_info/list?page=<c:out value='${totalPages - 1}'/>&search=<c:out value='${search}'/>&category=<c:out value='${category}'/>">
                        <i class="fas fa-angle-double-right"></i>
                    </a>
                </li>
            </ul>
        </nav>
        
        <!-- 페이지 정보 -->
        <div class="text-center text-muted">
            총 <c:out value="${totalItems}"/>개의 일정 중 <c:out value="${(currentPage * 10) + 1}"/> - <c:out value="${Math.min((currentPage + 1) * 10, totalItems)}"/>개 표시
            <br>
            <small><i class="fas fa-sort-amount-down me-1"></i>ID 내림차순으로 정렬됩니다.</small>
        </div>
    </c:if>
</div>

<!-- 스타일 추가 -->
<style>
    .form-check-input {
        cursor: pointer;
        width: 16px;
        height: 16px;
        margin: 0;
        vertical-align: middle;
        position: relative;
        flex-shrink: 0;
        border: 1px solid #adb5bd;
        appearance: none;
        color-adjust: exact;
        background-color: #fff;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 16px 16px;
        border-radius: 0.25em;
        transition: background-color 0.15s ease-in-out, background-position 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
    }
    
    .form-check-input:checked {
        background-color: #dc3545;
        border-color: #dc3545;
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 20 20'%3e%3cpath fill='none' stroke='%23fff' stroke-linecap='round' stroke-linejoin='round' stroke-width='3' d='m6 10 3 3 6-6'/%3e%3c/svg%3e");
    }
    
    .form-check-input:focus {
        border-color: #86b7fe;
        outline: 0;
        box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
    }
    
    .form-check-input:checked:focus {
        border-color: #dc3545;
        box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25);
    }
    
    #bulkActionButtons {
        background-color: #f8f9fa;
        border: 1px solid #dee2e6;
        border-radius: 0.375rem;
        padding: 1rem;
    }
    
    .table tbody tr:hover {
        background-color: rgba(0,0,0,.075);
    }
    
    /* 체크박스가 보이지 않는 경우를 위한 추가 스타일 */
    input[type="checkbox"] {
        display: inline-block !important;
        visibility: visible !important;
        opacity: 1 !important;
        width: 16px !important;
        height: 16px !important;
        margin: 0 !important;
        padding: 0 !important;
        border: 1px solid #adb5bd !important;
        background-color: #fff !important;
        border-radius: 0.25em !important;
        position: relative !important;
        flex-shrink: 0 !important;
        appearance: none !important;
        color-adjust: exact !important;
        background-repeat: no-repeat !important;
        background-position: center !important;
        background-size: 16px 16px !important;
        transition: background-color 0.15s ease-in-out, background-position 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out !important;
    }
    
    input[type="checkbox"]:checked {
        background-color: #dc3545 !important;
        border-color: #dc3545 !important;
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 20 20'%3e%3cpath fill='none' stroke='%23fff' stroke-linecap='round' stroke-linejoin='round' stroke-width='3' d='m6 10 3 3 6-6'/%3e%3c/svg%3e") !important;
    }
    
    input[type="checkbox"]:focus {
        border-color: #86b7fe !important;
        outline: 0 !important;
        box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25) !important;
    }
    
    input[type="checkbox"]:checked:focus {
        border-color: #dc3545 !important;
        box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25) !important;
    }
    
    .table th, .table td {
        vertical-align: middle;
    }
    
    /* 체크박스 컨테이너 스타일 */
    .checkbox-container {
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 20px;
    }
</style>

<!-- JavaScript 코드 -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    console.log('일정표 관리 스크립트 로드됨');
    
    const selectAllCheckbox = document.getElementById('selectAll');
    const scheduleCheckboxes = document.querySelectorAll('.schedule-checkbox');
    const bulkActionButtons = document.getElementById('bulkActionButtons');
    const selectedCountSpan = document.getElementById('selectedCount');
    
    console.log('전체선택 체크박스:', selectAllCheckbox);
    console.log('일정 체크박스 개수:', scheduleCheckboxes.length);
    console.log('일괄 액션 버튼:', bulkActionButtons);
    console.log('선택 개수 표시:', selectedCountSpan);
    
    // 체크박스가 제대로 로드되었는지 확인
    if (selectAllCheckbox) {
        console.log('전체선택 체크박스 발견');
    } else {
        console.error('전체선택 체크박스를 찾을 수 없습니다!');
    }
    
    if (scheduleCheckboxes.length > 0) {
        console.log('일정 체크박스들 발견:', scheduleCheckboxes.length + '개');
    } else {
        console.error('일정 체크박스를 찾을 수 없습니다!');
    }
    
    // 전체 선택/해제 기능
    if (selectAllCheckbox) {
        selectAllCheckbox.addEventListener('change', function() {
            const isChecked = this.checked;
            console.log('전체선택 변경:', isChecked);
            scheduleCheckboxes.forEach(checkbox => {
                checkbox.checked = isChecked;
            });
            updateBulkActionVisibility();
        });
    }
    
    // 개별 체크박스 변경 시
    scheduleCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            console.log('개별 체크박스 변경:', this.value, this.checked);
            updateSelectAllState();
            updateBulkActionVisibility();
        });
    });
    
    // 전체 선택 상태 업데이트
    function updateSelectAllState() {
        const checkedCount = document.querySelectorAll('.schedule-checkbox:checked').length;
        const totalCount = scheduleCheckboxes.length;
        
        console.log('체크된 개수:', checkedCount, '/', totalCount);
        
        if (checkedCount === 0) {
            selectAllCheckbox.checked = false;
            selectAllCheckbox.indeterminate = false;
        } else if (checkedCount === totalCount) {
            selectAllCheckbox.checked = true;
            selectAllCheckbox.indeterminate = false;
        } else {
            selectAllCheckbox.checked = false;
            selectAllCheckbox.indeterminate = true;
        }
    }
    
    // 일괄 액션 버튼 표시/숨김
    function updateBulkActionVisibility() {
        const checkedCount = document.querySelectorAll('.schedule-checkbox:checked').length;
        selectedCountSpan.textContent = checkedCount;
        
        console.log('선택된 개수:', checkedCount);
        
        if (checkedCount > 0) {
            bulkActionButtons.style.display = 'block';
        } else {
            bulkActionButtons.style.display = 'none';
        }
    }
    
    // 초기 상태 설정
    updateBulkActionVisibility();
});

// 선택한 일정 삭제 함수
function deleteSelected() {
    const selectedCheckboxes = document.querySelectorAll('.schedule-checkbox:checked');
    
    if (selectedCheckboxes.length === 0) {
        alert('삭제할 일정을 선택해주세요.');
        return;
    }
    
    // 선택된 일정 정보 수집
    const selectedSchedules = [];
    selectedCheckboxes.forEach(checkbox => {
        selectedSchedules.push({
            uid: checkbox.value,
            name: checkbox.getAttribute('data-schedule-name')
        });
    });
    
    // 확인 메시지
    let confirmMessage = '선택한 ' + selectedSchedules.length + '개의 일정을 삭제하시겠습니까?\n\n';
    selectedSchedules.forEach(schedule => {
        confirmMessage += '• ' + schedule.name + '\n';
    });
    
    if (!confirm(confirmMessage)) {
        return;
    }
    
    // 삭제 요청
    const selectedUids = selectedSchedules.map(schedule => schedule.uid);
    
    fetch('/admin/schedule_info/bulk-delete', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: JSON.stringify({
            uids: selectedUids
        })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            alert(data.deletedCount + '개의 일정이 성공적으로 삭제되었습니다.');
            location.reload();
        } else {
            alert('삭제 중 오류가 발생했습니다: ' + (data.message || '알 수 없는 오류'));
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('삭제 중 오류가 발생했습니다.');
    });
}

// 성공 메시지 표시 함수
function showSuccessMessage(message) {
    const alertDiv = document.createElement('div');
    alertDiv.className = 'alert alert-success alert-floating';
    alertDiv.innerHTML = '<i class="fas fa-check-circle me-2"></i>' + message;
    
    document.body.appendChild(alertDiv);
    
    setTimeout(() => {
        alertDiv.style.animation = 'slideOut 0.3s ease-out';
        setTimeout(() => alertDiv.remove(), 300);
    }, 3000);
}

// 애니메이션 스타일 추가
const style = document.createElement('style');
style.textContent = `
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
    
    .alert-floating {
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 9999;
        min-width: 300px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        animation: slideIn 0.3s ease-out;
    }
`;
document.head.appendChild(style);
</script>