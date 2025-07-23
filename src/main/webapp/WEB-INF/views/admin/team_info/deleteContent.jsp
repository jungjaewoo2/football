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
        <!-- 체크박스 영역 -->
        <div style="background-color: #fff3cd; border: 2px solid #ffc107; border-radius: 8px; padding: 20px; margin-bottom: 20px; position: relative; z-index: 9999; visibility: visible !important; opacity: 1 !important;">
            <h5 style="color: #856404; margin-bottom: 15px;">
                <i class="fas fa-exclamation-triangle me-2"></i>삭제 동의
            </h5>
            <div style="display: flex; align-items: center;">
                <input type="checkbox" id="confirmDelete" required style="width: 25px; height: 25px; margin-right: 15px; accent-color: #dc3545; visibility: visible !important; opacity: 1 !important; position: relative; z-index: 9999;">
                <label for="confirmDelete" style="font-weight: bold; color: #dc3545; font-size: 18px; margin: 0; visibility: visible !important; opacity: 1 !important;">
                    <i class="fas fa-exclamation-triangle me-2"></i>위 팀정보를 삭제하는 것에 동의합니다.
                </label>
            </div>
        </div>
        
        <!-- 버튼 그룹 -->
        <div style="background-color: #f8f9fa; border: 1px solid #dee2e6; border-radius: 8px; padding: 20px; position: relative; z-index: 9999; visibility: visible !important; opacity: 1 !important;">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <a href="/admin/team_info/list" class="btn btn-secondary" style="padding: 12px 24px; font-size: 16px; visibility: visible !important; opacity: 1 !important; position: relative; z-index: 9999;">
                    <i class="fas fa-arrow-left me-1"></i>목록으로 돌아가기
                </a>
                <div style="display: flex; gap: 10px;">
                    <a href="/admin/team_info/edit/${teamInfo.uid}" class="btn btn-primary" style="padding: 12px 24px; font-size: 16px; visibility: visible !important; opacity: 1 !important; position: relative; z-index: 9999;">
                        <i class="fas fa-edit me-1"></i>수정하기
                    </a>
                    <button type="submit" class="btn btn-danger" id="deleteBtn" style="padding: 12px 24px; font-size: 16px; visibility: visible !important; opacity: 1 !important; position: relative; z-index: 9999;">
                        <i class="fas fa-trash me-1"></i>삭제하기
                    </button>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    // 페이지 로드 시 요소들이 보이도록 강제
    document.addEventListener('DOMContentLoaded', function() {
        // 체크박스 강제 표시
        const checkbox = document.getElementById('confirmDelete');
        if (checkbox) {
            checkbox.style.display = 'block';
            checkbox.style.visibility = 'visible';
            checkbox.style.opacity = '1';
            checkbox.style.position = 'relative';
            checkbox.style.zIndex = '9999';
        }
        
        // 라벨 강제 표시
        const label = document.querySelector('label[for="confirmDelete"]');
        if (label) {
            label.style.display = 'block';
            label.style.visibility = 'visible';
            label.style.opacity = '1';
        }
        
        // 버튼들 강제 표시
        const buttons = document.querySelectorAll('#deleteForm .btn, #deleteForm button');
        buttons.forEach(function(button) {
            button.style.display = 'inline-block';
            button.style.visibility = 'visible';
            button.style.opacity = '1';
            button.style.position = 'relative';
            button.style.zIndex = '9999';
        });
        
        // 폼 영역 강제 표시
        const form = document.getElementById('deleteForm');
        if (form) {
            form.style.display = 'block';
            form.style.visibility = 'visible';
            form.style.opacity = '1';
        }
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