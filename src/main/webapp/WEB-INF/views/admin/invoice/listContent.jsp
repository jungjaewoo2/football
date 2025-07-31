<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-file-invoice me-2"></i>확정목록</h2>
        <p>확정목록을 관리합니다.</p>
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
                <option value="customerName" <c:if test="${searchType == 'customerName'}">selected</c:if>>예약자명</option>
                <option value="homeTeam" <c:if test="${searchType == 'homeTeam'}">selected</c:if>>홈팀</option>
                <option value="awayTeam" <c:if test="${searchType == 'awayTeam'}">selected</c:if>>원정팀</option>
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
                    <i class="fas fa-trash me-1"></i>선택한 인보이스 삭제
                </button>
            </div>
        </div>
    </div>

    <%-- 년/월별 버튼 영역 추가 --%>
    <c:if test="${not empty thisYear and not empty nextYear}">
        <div class="mb-3">
            <div>
                <strong>${thisYear}년</strong>
                <c:forEach begin="1" end="12" var="m">
                    <c:set var="count" value="0" />
                    <c:if test="${not empty yearMonthCounts and not empty yearMonthCounts[thisYear] and not empty yearMonthCounts[thisYear][m]}">
                        <c:set var="count" value="${yearMonthCounts[thisYear][m]}" />
                    </c:if>
                    <c:choose>
                        <c:when test="${thisYear == selectedYear and m == selectedMonth}">
                            <a href="?searchYear=${thisYear}&searchMonth=${m}&searchType=${searchType}&keyword=${keyword}"
                               class="btn btn-sm btn-primary"
                               style="margin-right:2px; margin-bottom:2px;">
                                ${m}월(${count})
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="?searchYear=${thisYear}&searchMonth=${m}&searchType=${searchType}&keyword=${keyword}"
                               class="btn btn-sm btn-outline-secondary"
                               style="margin-right:2px; margin-bottom:2px;">
                                ${m}월(${count})
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
            <div class="mt-2">
                <strong>${nextYear}년</strong>
                <c:forEach begin="1" end="12" var="m">
                    <c:set var="count" value="0" />
                    <c:if test="${not empty yearMonthCounts and not empty yearMonthCounts[nextYear] and not empty yearMonthCounts[nextYear][m]}">
                        <c:set var="count" value="${yearMonthCounts[nextYear][m]}" />
                    </c:if>
                    <c:choose>
                        <c:when test="${nextYear == selectedYear and m == selectedMonth}">
                            <a href="?searchYear=${nextYear}&searchMonth=${m}&searchType=${searchType}&keyword=${keyword}"
                               class="btn btn-sm btn-primary"
                               style="margin-right:2px; margin-bottom:2px;">
                                ${m}월(${count})
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="?searchYear=${nextYear}&searchMonth=${m}&searchType=${searchType}&keyword=${keyword}"
                               class="btn btn-sm btn-outline-secondary"
                               style="margin-right:2px; margin-bottom:2px;">
                                ${m}월(${count})
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
        </div>
    </c:if>

    <!-- 인보이스 목록 테이블 -->
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th width="5%" class="text-center">
                        <div class="checkbox-container">
                            <input type="checkbox" id="selectAll" class="form-check-input">
                        </div>
                    </th>
                    <th class="text-center" style="width: 120px;">예약번호</th>
                    <th class="text-center" style="width: 120px;">예약자</th>
                    <th class="text-center" style="width: 200px;">경기명</th>
                    <th class="text-center" style="width: 120px;">경기날짜</th>
                    <th class="text-center" style="width: 80px;">수량</th>
                    <th class="text-center" style="width: 120px;">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty invoices}">
                        <tr>
                            <td colspan="7" class="text-center py-4">
                                <i class="fas fa-inbox fa-2x text-muted mb-2"></i>
                                <p class="text-muted">등록된 확정목록이 없습니다.</p>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="invoice" items="${invoices}" varStatus="status">
                            <tr>
                                <td class="text-center">
                                    <div class="checkbox-container">
                                        <input type="checkbox" class="form-check-input invoice-checkbox" 
                                               value="${invoice.id}" data-invoice-name="${invoice.customerName} - ${invoice.homeTeam} vs ${invoice.awayTeam}">
                                    </div>
                                </td>
                                <td class="text-center">
                                    <span class="badge bg-primary">${invoice.uid}</span>
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
                                            <i class="fas fa-eye me-1"></i>보기
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
    <c:if test="${totalPages >= 1}">
        <nav aria-label="인보이스 목록 페이지 네비게이션">
            <ul class="pagination justify-content-center">
                <!-- 처음 페이지 버튼 -->
                <c:choose>
                    <c:when test="${currentPage == 0}">
                        <li class="page-item disabled">
                            <a class="page-link" href="/admin/invoice/list?page=0&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">
                                <i class="fas fa-angle-double-left"></i>
                            </a>
                        </li>
                        
                        <!-- 이전 페이지 버튼 -->
                        <li class="page-item disabled">
                            <a class="page-link" href="/admin/invoice/list?page=${currentPage - 1}&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">
                                <i class="fas fa-angle-left"></i>
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link" href="/admin/invoice/list?page=0&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">
                                <i class="fas fa-angle-double-left"></i>
                            </a>
                        </li>
                        
                        <!-- 이전 페이지 버튼 -->
                        <li class="page-item">
                            <a class="page-link" href="/admin/invoice/list?page=${currentPage - 1}&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">
                                <i class="fas fa-angle-left"></i>
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
                
                <!-- 페이지 번호 (5개씩 그룹화) -->
                <c:set var="startPage" value="0" />
                <c:set var="endPage" value="4" />
                <c:if test="${not empty currentPage and not empty totalPages}">
                    <c:set var="startPage" value="${(currentPage / 5) * 5}" />
                    <c:set var="endPage" value="${startPage + 4}" />
                    <c:if test="${endPage >= totalPages}">
                        <c:set var="endPage" value="${totalPages - 1}" />
                    </c:if>
                </c:if>
                
                <!-- 페이지 번호들 -->
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                    <c:choose>
                        <c:when test="${pageNum == currentPage}">
                            <li class="page-item active">
                                <a class="page-link" href="/admin/invoice/list?page=${pageNum}&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">
                                    ${pageNum + 1}
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item">
                                <a class="page-link" href="/admin/invoice/list?page=${pageNum}&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">
                                    ${pageNum + 1}
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                
                <!-- 다음 페이지 버튼 -->
                <c:choose>
                    <c:when test="${currentPage >= totalPages - 1}">
                        <li class="page-item disabled">
                            <a class="page-link" href="/admin/invoice/list?page=${currentPage + 1}&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">
                                <i class="fas fa-angle-right"></i>
                            </a>
                        </li>
                        
                        <!-- 마지막 페이지 버튼 -->
                        <li class="page-item disabled">
                            <a class="page-link" href="/admin/invoice/list?page=${totalPages - 1}&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">
                                <i class="fas fa-angle-double-right"></i>
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link" href="/admin/invoice/list?page=${currentPage + 1}&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">
                                <i class="fas fa-angle-right"></i>
                            </a>
                        </li>
                        
                        <!-- 마지막 페이지 버튼 -->
                        <li class="page-item">
                            <a class="page-link" href="/admin/invoice/list?page=${totalPages - 1}&searchType=${searchType}&keyword=${keyword}&searchYear=${searchYear}&searchMonth=${searchMonth}">
                                <i class="fas fa-angle-double-right"></i>
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </nav>
        
        <!-- 페이지 정보 -->
        <div class="text-center text-muted">
            <c:if test="${not empty totalItems and not empty currentPage}">
                <c:set var="startItem" value="${(currentPage * 10) + 1}" />
                <c:set var="endItem" value="${(currentPage + 1) * 10}" />
                <c:if test="${endItem > totalItems}">
                    <c:set var="endItem" value="${totalItems}" />
                </c:if>
                총 ${totalItems}개의 인보이스 중 ${startItem} - ${endItem}개 표시
            </c:if>
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
    console.log('인보이스 관리 스크립트 로드됨');
    
    const selectAllCheckbox = document.getElementById('selectAll');
    const invoiceCheckboxes = document.querySelectorAll('.invoice-checkbox');
    const bulkActionButtons = document.getElementById('bulkActionButtons');
    const selectedCountSpan = document.getElementById('selectedCount');
    
    console.log('전체선택 체크박스:', selectAllCheckbox);
    console.log('인보이스 체크박스 개수:', invoiceCheckboxes.length);
    console.log('일괄 액션 버튼:', bulkActionButtons);
    console.log('선택 개수 표시:', selectedCountSpan);
    
    // 체크박스가 제대로 로드되었는지 확인
    if (selectAllCheckbox) {
        console.log('전체선택 체크박스 발견');
    } else {
        console.error('전체선택 체크박스를 찾을 수 없습니다!');
    }
    
    if (invoiceCheckboxes.length > 0) {
        console.log('인보이스 체크박스들 발견:', invoiceCheckboxes.length + '개');
    } else {
        console.error('인보이스 체크박스를 찾을 수 없습니다!');
    }
    
    // 전체 선택/해제 기능
    if (selectAllCheckbox) {
        selectAllCheckbox.addEventListener('change', function() {
            const isChecked = this.checked;
            console.log('전체선택 변경:', isChecked);
            invoiceCheckboxes.forEach(checkbox => {
                checkbox.checked = isChecked;
            });
            updateBulkActionVisibility();
        });
    }
    
    // 개별 체크박스 변경 시
    invoiceCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            console.log('개별 체크박스 변경:', this.value, this.checked);
            updateSelectAllState();
            updateBulkActionVisibility();
        });
    });
    
    // 전체 선택 상태 업데이트
    function updateSelectAllState() {
        const checkedCount = document.querySelectorAll('.invoice-checkbox:checked').length;
        const totalCount = invoiceCheckboxes.length;
        
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
        const checkedCount = document.querySelectorAll('.invoice-checkbox:checked').length;
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

// 선택한 인보이스 삭제 함수
function deleteSelected() {
    const selectedCheckboxes = document.querySelectorAll('.invoice-checkbox:checked');
    
    if (selectedCheckboxes.length === 0) {
        alert('삭제할 인보이스를 선택해주세요.');
        return;
    }
    
    // 선택된 인보이스 정보 수집
    const selectedInvoices = [];
    selectedCheckboxes.forEach(checkbox => {
        selectedInvoices.push({
            id: checkbox.value,
            name: checkbox.getAttribute('data-invoice-name')
        });
    });
    
    // 확인 메시지
    let confirmMessage = `선택한 ${selectedInvoices.length}개의 인보이스를 삭제하시겠습니까?\n\n`;
    selectedInvoices.forEach(invoice => {
        confirmMessage += `• ${invoice.name}\n`;
    });
    
    if (!confirm(confirmMessage)) {
        return;
    }
    
    // 삭제 요청
    const selectedIds = selectedInvoices.map(invoice => invoice.id);
    
    fetch('/admin/invoice/bulk-delete', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: JSON.stringify({
            ids: selectedIds
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
            alert(`${data.deletedCount}개의 인보이스가 성공적으로 삭제되었습니다.`);
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