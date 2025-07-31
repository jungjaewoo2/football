<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-plus me-2"></i>메인 이미지 등록</h2>
        <p>새로운 메인 이미지를 등록할 수 있습니다.</p>
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
    
    <!-- 메인 이미지 등록 폼 -->
    <div class="card">
        <div class="card-header bg-success text-white">
            <h5 class="mb-0">
                <i class="fas fa-images me-2"></i>메인 이미지 등록
            </h5>
        </div>
        <div class="card-body">
            <form method="post" action="/admin/main_img/register" enctype="multipart/form-data" id="registerForm">
                <div class="mb-3">
                    <label for="linkUrl" class="form-label">
                        <i class="fas fa-link me-1"></i>링크 주소
                    </label>
                    <input type="url" class="form-control" id="linkUrl" name="linkUrl" 
                           placeholder="https://example.com (선택사항)">
                    <div class="form-text">
                        <i class="fas fa-info-circle me-1"></i>
                        이미지 클릭 시 이동할 링크 주소를 입력하세요. (선택사항)
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="file" class="form-label">
                        <i class="fas fa-image me-1"></i>이미지 파일
                    </label>
                    <input type="file" class="form-control" id="file" name="file" 
                           accept="image/*" required>
                    <div class="form-text">
                        <i class="fas fa-info-circle me-1"></i>
                        이미지 파일만 업로드 가능합니다. (jpg, jpeg, png, gif)
                    </div>
                </div>
                
                <div class="d-flex justify-content-between">
                    <a href="/admin/main_img/list" class="btn btn-secondary">
                        <i class="fas fa-times me-1"></i>취소
                    </a>
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save me-1"></i>등록
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
document.getElementById('registerForm').addEventListener('submit', function(e) {
    const file = document.getElementById('file').files[0];
    
    if (!file) {
        e.preventDefault();
        alert('이미지 파일을 선택해주세요.');
        return false;
    }
    
    // 파일 크기 체크 (10MB 제한)
    if (file.size > 10 * 1024 * 1024) {
        e.preventDefault();
        alert('파일 크기는 10MB를 초과할 수 없습니다.');
        return false;
    }
    
    // 파일 타입 체크
    const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
    if (!allowedTypes.includes(file.type)) {
        e.preventDefault();
        alert('이미지 파일만 업로드 가능합니다.');
        return false;
    }
});
</script> 