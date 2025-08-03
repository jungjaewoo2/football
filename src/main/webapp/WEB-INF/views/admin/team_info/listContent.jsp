<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content-card">
    <div class="content-header">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h2>⚽ 팀정보 관리</h2>
                <p>축구팀 정보를 관리하고 설정할 수 있습니다.</p>
            </div>
            <a href="/admin/team_info/register" class="btn btn-primary">
                <i class="fas fa-plus me-2"></i>새 팀정보 등록
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
    <form method="GET" action="/admin/team_info/list" class="mb-4">
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
                    <i class="fas fa-trash me-1"></i>선택한 팀정보 삭제
                </button>
            </div>
        </div>
    </div>
    
    <!-- 팀정보 목록 테이블 -->
    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th width="6%" class="text-center">
                        <div class="checkbox-container">
                            <input type="checkbox" id="selectAll" class="form-check-input">
                        </div>
                    </th>
                    <th width="8%">번호</th>
                    <th width="28%">팀구단명</th>
                    <th width="28%">경기장명</th>
                    <th width="20%">메인노출</th>
                    <th width="10%">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty teamInfos}">
                        <tr>
                            <td colspan="6" class="text-center py-4">
                                <i class="fas fa-futbol fa-2x text-muted mb-2"></i>
                                <p class="text-muted">등록된 팀정보가 없습니다.</p>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="teamInfo" items="${teamInfos}" varStatus="status">
                            <tr>
                                <td class="text-center">
                                    <div class="checkbox-container">
                                        <input type="checkbox" class="form-check-input team-info-checkbox" 
                                               value="<c:out value='${teamInfo.uid}'/>" data-team-info-name="<c:out value='${teamInfo.teamName}'/>">
                                    </div>
                                </td>
                                <td><c:out value="${totalItems - (currentPage * 10) - status.index}"/></td>
                                <td>
                                    <strong><c:out value="${teamInfo.teamName}"/></strong>
                                </td>
                                <td><c:out value="${teamInfo.stadium}"/></td>
                                <td>
                                    ${teamInfo.mainDisplay}
                                </td>
                                <td>
                                    <div class="btn-group" role="group">
                                        <a href="/admin/team_info/edit/<c:out value='${teamInfo.uid}'/>" 
                                           class="btn btn-sm btn-primary" 
                                           title="수정">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <button type="button" 
                                                class="btn btn-sm btn-danger delete-btn" 
                                                data-uid="<c:out value='${teamInfo.uid}'/>"
                                                data-team-name="<c:out value='${teamInfo.teamName}'/>"
                                                title="삭제">
                                            <i class="fas fa-trash"></i>
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
    <c:if test="${totalPages >= 1}">
        <nav aria-label="팀정보 목록 페이지 네비게이션">
            <ul class="pagination justify-content-center">
                <!-- 처음 페이지 버튼 -->
                <li class="page-item <c:out value='${firstPageDisabled}'/>">
                    <a class="page-link" href="/admin/team_info/list?page=0&search=<c:out value='${search}'/>">
                        <i class="fas fa-angle-double-left"></i>
                    </a>
                </li>
                
                <!-- 이전 페이지 버튼 -->
                <li class="page-item <c:out value='${prevPageDisabled}'/>">
                    <a class="page-link" href="/admin/team_info/list?page=<c:out value='${currentPage - 1}'/>&search=<c:out value='${search}'/>">
                        <i class="fas fa-angle-left"></i>
                    </a>
                </li>
                
                <!-- 페이지 번호들 -->
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                    <li class="page-item <c:out value='${pageNum == currentPage ? "active" : ""}'/>">
                        <a class="page-link" href="/admin/team_info/list?page=<c:out value='${pageNum}'/>&search=<c:out value='${search}'/>">
                            <c:out value="${pageNum + 1}"/>
                        </a>
                    </li>
                </c:forEach>
                
                <!-- 다음 페이지 버튼 -->
                <li class="page-item <c:out value='${nextPageDisabled}'/>">
                    <a class="page-link" href="/admin/team_info/list?page=<c:out value='${currentPage + 1}'/>&search=<c:out value='${search}'/>">
                        <i class="fas fa-angle-right"></i>
                    </a>
                </li>
                
                <!-- 마지막 페이지 버튼 -->
                <li class="page-item <c:out value='${lastPageDisabled}'/>">
                    <a class="page-link" href="/admin/team_info/list?page=<c:out value='${totalPages - 1}'/>&search=<c:out value='${search}'/>">
                        <i class="fas fa-angle-double-right"></i>
                    </a>
                </li>
            </ul>
        </nav>
        
        <!-- 페이지 정보 -->
        <div class="text-center text-muted">
            총 <c:out value="${totalItems}"/>개의 팀정보 중 <c:out value="${(currentPage * 10) + 1}"/> - <c:out value="${Math.min((currentPage + 1) * 10, totalItems)}"/>개 표시
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

<script>
document.addEventListener('DOMContentLoaded', function() {
    console.log('팀정보 관리 스크립트 로드됨');
    
    const selectAllCheckbox = document.getElementById('selectAll');
    const teamInfoCheckboxes = document.querySelectorAll('.team-info-checkbox');
    const bulkActionButtons = document.getElementById('bulkActionButtons');
    const selectedCountSpan = document.getElementById('selectedCount');
    
    console.log('전체선택 체크박스:', selectAllCheckbox);
    console.log('팀정보 체크박스 개수:', teamInfoCheckboxes.length);
    console.log('일괄 액션 버튼:', bulkActionButtons);
    console.log('선택 개수 표시:', selectedCountSpan);
    
    // 체크박스가 제대로 로드되었는지 확인
    if (selectAllCheckbox) {
        console.log('전체선택 체크박스 발견');
    } else {
        console.error('전체선택 체크박스를 찾을 수 없습니다!');
    }
    
    if (teamInfoCheckboxes.length > 0) {
        console.log('팀정보 체크박스들 발견:', teamInfoCheckboxes.length + '개');
    } else {
        console.error('팀정보 체크박스를 찾을 수 없습니다!');
    }
    
    // 전체 선택/해제 기능
    if (selectAllCheckbox) {
        selectAllCheckbox.addEventListener('change', function() {
            const isChecked = this.checked;
            console.log('전체선택 변경:', isChecked);
            teamInfoCheckboxes.forEach(checkbox => {
                checkbox.checked = isChecked;
            });
            updateBulkActionVisibility();
        });
    }
    
    // 개별 체크박스 변경 시
    teamInfoCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            console.log('개별 체크박스 변경:', this.value, this.checked);
            updateSelectAllState();
            updateBulkActionVisibility();
        });
    });
    
    // 전체 선택 상태 업데이트
    function updateSelectAllState() {
        const checkedCount = document.querySelectorAll('.team-info-checkbox:checked').length;
        const totalCount = teamInfoCheckboxes.length;
        
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
        const checkedCount = document.querySelectorAll('.team-info-checkbox:checked').length;
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
    
    // 기존 삭제 버튼 클릭 이벤트
    const deleteButtons = document.querySelectorAll('.delete-btn');
    
    deleteButtons.forEach(function(button) {
        button.addEventListener('click', function() {
            const uid = this.getAttribute('data-uid');
            const teamName = this.getAttribute('data-team-name');
            
            // 삭제 확인
            if (confirm('정말로 "' + teamName + '" 팀정보를 삭제하시겠습니까?\n\n이 작업은 되돌릴 수 없습니다.')) {
                // 삭제 진행
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '/admin/team_info/delete/' + uid;
                
                // CSRF 토큰이 있다면 추가
                const csrfToken = document.querySelector('meta[name="_csrf"]');
                if (csrfToken) {
                    const csrfInput = document.createElement('input');
                    csrfInput.type = 'hidden';
                    csrfInput.name = '_csrf';
                    csrfInput.value = csrfToken.getAttribute('content');
                    form.appendChild(csrfInput);
                }
                
                document.body.appendChild(form);
                form.submit();
            }
        });
    });
});

// 선택한 팀정보 삭제 함수
function deleteSelected() {
    const selectedCheckboxes = document.querySelectorAll('.team-info-checkbox:checked');
    
    if (selectedCheckboxes.length === 0) {
        alert('삭제할 팀정보를 선택해주세요.');
        return;
    }
    
    // 선택된 팀정보 정보 수집
    const selectedTeamInfos = [];
    selectedCheckboxes.forEach(checkbox => {
        selectedTeamInfos.push({
            uid: checkbox.value,
            name: checkbox.getAttribute('data-team-info-name')
        });
    });
    
    // 확인 메시지
    let confirmMessage = '선택한 ' + selectedTeamInfos.length + '개의 팀정보를 삭제하시겠습니까?\n\n';
    selectedTeamInfos.forEach(teamInfo => {
        confirmMessage += '• ' + teamInfo.name + '\n';
    });
    
    if (!confirm(confirmMessage)) {
        return;
    }
    
    // 삭제 요청
    const selectedUids = selectedTeamInfos.map(teamInfo => teamInfo.uid);
    
    fetch('/admin/team_info/bulk-delete', {
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
            alert(data.deletedCount + '개의 팀정보가 성공적으로 삭제되었습니다.');
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
</script>