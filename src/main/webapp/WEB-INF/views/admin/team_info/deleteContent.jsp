<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-exclamation-triangle me-2"></i>팀정보 삭제 확인</h2>
        <p>삭제할 팀정보를 확인하고 삭제를 진행해주세요.</p>
    </div>
    
    <!-- 알림 메시지 -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i>${error}
        </div>
    </c:if>
    
    <!-- 경고 메시지 -->
    <div class="alert alert-warning">
        <h5 class="alert-heading">
            <i class="fas fa-exclamation-triangle me-2"></i>삭제 전 확인사항
        </h5>
        <p class="mb-0">
            아래 팀정보를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.
        </p>
    </div>
    
    <!-- 삭제할 팀정보 -->
    <div class="card mb-4">
        <div class="card-header">
            <h5 class="mb-0">
                <i class="fas fa-info-circle me-2"></i>삭제할 팀정보
            </h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <p><strong>번호:</strong> ${teamInfo.uid}</p>
                    <p><strong>팀구단명:</strong> ${teamInfo.teamName}</p>
                    <p><strong>카테고리:</strong> <span class="badge bg-primary">${teamInfo.categoryName}</span></p>
                </div>
                <div class="col-md-6">
                    <p><strong>경기장명:</strong> ${teamInfo.stadium}</p>
                    <p><strong>도시명:</strong> ${teamInfo.city}</p>
                    <p><strong>등록일:</strong> ${teamInfo.createdAt}</p>
                </div>
            </div>
            
            <!-- 이미지 정보 -->
            <div class="mt-3">
                <h6>이미지 정보:</h6>
                <div class="row">
                    <div class="col-md-6">
                        <p><strong>로고 이미지:</strong> 
                            <c:choose>
                                <c:when test="${not empty teamInfo.logoImg}">
                                    ${teamInfo.logoImg}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">등록된 로고 없음</span>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    <div class="col-md-6">
                        <p><strong>좌석 이미지:</strong> 
                            <c:choose>
                                <c:when test="${not empty teamInfo.seatImg}">
                                    ${teamInfo.seatImg}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">등록된 좌석 이미지 없음</span>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 삭제 확인 폼 -->
    <form method="POST" action="/admin/team_info/delete/${teamInfo.uid}" id="deleteForm">
        <div class="form-check mb-3">
            <input class="form-check-input" type="checkbox" id="confirmDelete" required>
            <label class="form-check-label" for="confirmDelete">
                위 팀정보를 삭제하는 것에 동의합니다.
            </label>
        </div>
        
        <!-- 버튼 그룹 -->
        <div class="d-flex justify-content-between">
            <a href="/admin/team_info/list" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-1"></i>목록으로 돌아가기
            </a>
            <div>
                <a href="/admin/team_info/edit/${teamInfo.uid}" class="btn btn-primary me-2">
                    <i class="fas fa-edit me-1"></i>수정하기
                </a>
                <button type="submit" class="btn btn-danger" id="deleteBtn" disabled>
                    <i class="fas fa-trash me-1"></i>삭제하기
                </button>
            </div>
        </div>
    </form>
</div>

<script>
    // 체크박스 확인 시 삭제 버튼 활성화
    document.getElementById('confirmDelete').addEventListener('change', function() {
        document.getElementById('deleteBtn').disabled = !this.checked;
    });
    
    // 삭제 폼 제출 시 최종 확인
    document.getElementById('deleteForm').addEventListener('submit', function(e) {
        if (!document.getElementById('confirmDelete').checked) {
            e.preventDefault();
            alert('삭제 동의 체크박스를 선택해주세요.');
            return false;
        }
        
        if (!confirm('정말로 이 팀정보를 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.')) {
            e.preventDefault();
            return false;
        }
    });
</script> 