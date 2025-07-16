// 관리자 예약 관리 JavaScript

// 전역 함수들을 즉시 정의
window.updateReservationStatus = function(id, status) {
    if (!confirm('예약상태를 변경하시겠습니까?')) return;
    updateStatus('reservation', id, status);
};

window.updatePaymentStatus = function(id, status) {
    if (!confirm('결제상태를 변경하시겠습니까?')) return;
    updateStatus('payment', id, status);
};

window.updateApprovalStatus = function(id, status) {
    if (!confirm('승인상태를 변경하시겠습니까?')) return;
    updateStatus('approval', id, status);
};

// 간소화된 상태 업데이트 함수
function updateStatus(type, id, status) {
    const url = '/admin/register_schedule/update-' + type + '-status/' + id;
    
    // 로딩 표시
    const button = event.target.closest('button');
    const originalText = button.innerHTML;
    button.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>처리중...';
    button.disabled = true;
    
    fetch(url, {
        method: 'POST',
        headers: { 
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: JSON.stringify({ status: status })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.text();
    })
    .then(data => {
        if (data.trim() === 'success' || data.trim() === 'SUCCESS') {
            const statusText = type === 'reservation' ? '예약상태' : 
                              type === 'payment' ? '결제상태' : '승인상태';
            showAlert('success', statusText + '가 성공적으로 변경되었습니다.');
            setTimeout(() => location.reload(), 1000);
        } else {
            throw new Error('상태 변경 실패');
        }
    })
    .catch(error => {
        console.error('에러:', error);
        showAlert('error', '상태 변경 중 오류가 발생했습니다.');
        button.innerHTML = originalText;
        button.disabled = false;
    });
}

// 알림 메시지 표시 함수
function showAlert(type, message) {
    const alertClass = type === 'success' ? 'alert-success' : 'alert-danger';
    const iconClass = type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle';
    
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert ${alertClass} alert-dismissible fade show`;
    alertDiv.innerHTML = `
        <i class="fas ${iconClass} me-2"></i>${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    
    const container = document.querySelector('.content-card');
    container.insertBefore(alertDiv, container.firstChild);
    
    // 5초 후 자동 제거
    setTimeout(() => {
        if (alertDiv.parentNode) {
            alertDiv.remove();
        }
    }, 5000);
}

// 검색 기능 초기화
function initializeSearch() {
    const searchTypeSelect = document.getElementById('searchType');
    const searchKeywordInput = document.getElementById('searchKeyword');
    const dateSearchContainer = document.getElementById('dateSearchContainer');
    
    if (!searchTypeSelect || !searchKeywordInput || !dateSearchContainer) {
        return;
    }
    
    // 초기 상태 설정
    updateSearchInterface();
    
    // 검색 타입 변경 이벤트
    searchTypeSelect.addEventListener('change', updateSearchInterface);
    
    // 검색 폼 제출 전 유효성 검사
    const searchForm = document.querySelector('.search-form');
    if (searchForm) {
        searchForm.addEventListener('submit', validateSearchForm);
    }
}

// 검색 인터페이스 업데이트
function updateSearchInterface() {
    const searchTypeSelect = document.getElementById('searchType');
    const searchKeywordInput = document.getElementById('searchKeyword');
    const dateSearchContainer = document.getElementById('dateSearchContainer');
    
    const selectedType = searchTypeSelect.value;
    
    if (selectedType === 'gameDate') {
        searchKeywordInput.style.display = 'none';
        dateSearchContainer.style.display = 'flex';
        
        // 년/월 선택 시 자동 검색 (선택사항)
        const yearSelect = document.getElementById('searchYear');
        const monthSelect = document.getElementById('searchMonth');
        
        if (yearSelect && monthSelect) {
            yearSelect.addEventListener('change', autoSearch);
            monthSelect.addEventListener('change', autoSearch);
        }
    } else {
        searchKeywordInput.style.display = 'block';
        dateSearchContainer.style.display = 'none';
        
        // 플레이스홀더 업데이트
        const placeholders = {
            'customerName': '예약자명을 입력하세요',
            'homeTeam': '홈팀명을 입력하세요',
            'awayTeam': '원정팀명을 입력하세요'
        };
        
        searchKeywordInput.placeholder = placeholders[selectedType] || '검색어를 입력하세요';
    }
}

// 자동 검색 (년/월 선택 시)
function autoSearch() {
    const yearSelect = document.getElementById('searchYear');
    const monthSelect = document.getElementById('searchMonth');
    
    if (yearSelect.value && monthSelect.value) {
        // 1초 후 자동 검색 실행
        setTimeout(() => {
            const form = document.querySelector('.search-form');
            if (form) {
                form.submit();
            }
        }, 1000);
    }
}

// 검색 폼 유효성 검사
function validateSearchForm(event) {
    const searchType = document.getElementById('searchType').value;
    const keyword = document.getElementById('searchKeyword').value;
    const yearSelect = document.getElementById('searchYear');
    const monthSelect = document.getElementById('searchMonth');
    
    if (searchType === 'gameDate') {
        if (!yearSelect.value || !monthSelect.value) {
            event.preventDefault();
            showAlert('error', '년도와 월을 모두 선택해주세요.');
            return false;
        }
    } else {
        if (!keyword.trim()) {
            event.preventDefault();
            showAlert('error', '검색어를 입력해주세요.');
            return false;
        }
    }
    
    return true;
}

// 페이지 로드 후 초기화
document.addEventListener('DOMContentLoaded', function() {
    // 검색 기능 초기화
    initializeSearch();
    
    // 테이블 행 클릭 이벤트 (상세 페이지로 이동)
    const tableRows = document.querySelectorAll('.table tbody tr');
    tableRows.forEach(row => {
        row.addEventListener('click', function(e) {
            // 버튼 클릭 시에는 상세 페이지로 이동하지 않음
            if (e.target.tagName === 'BUTTON' || e.target.closest('button')) {
                return;
            }
            
            const detailLink = this.querySelector('a[href*="/detail/"]');
            if (detailLink) {
                window.location.href = detailLink.href;
            }
        });
        
        // 마우스 커서 스타일
        const detailLink = row.querySelector('a[href*="/detail/"]');
        if (detailLink) {
            row.style.cursor = 'pointer';
        }
    });
    
    // 페이징 링크 클릭 시 로딩 표시
    const paginationLinks = document.querySelectorAll('.pagination .page-link');
    paginationLinks.forEach(link => {
        link.addEventListener('click', function() {
            const wrapper = document.querySelector('.main-wrapper');
            if (wrapper) {
                wrapper.style.opacity = '0.7';
                wrapper.style.pointerEvents = 'none';
            }
        });
    });
    
    // 검색 버튼 클릭 시 로딩 표시
    const searchBtn = document.querySelector('.search-btn');
    if (searchBtn) {
        searchBtn.addEventListener('click', function() {
            const form = this.closest('form');
            if (form && validateSearchForm({ preventDefault: () => {} })) {
                this.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>검색중...';
                this.disabled = true;
            }
        });
    }
}); 