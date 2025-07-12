<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-edit me-2"></i>메인 이미지 수정</h2>
        <p>메인 이미지 정보를 수정할 수 있습니다.</p>
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
    
    <!-- 메인 이미지 수정 폼 -->
    <div class="card">
        <div class="card-header bg-warning text-dark">
            <h5 class="mb-0">
                <i class="fas fa-edit me-2"></i>메인 이미지 수정
            </h5>
        </div>
        <div class="card-body">
            <form method="post" action="/admin/main_img/edit/${mainImg.uid}" enctype="multipart/form-data" id="editForm">
                <div class="mb-3">
                    <label for="imgName" class="form-label">
                        <i class="fas fa-tag me-1"></i>메인 이미지명
                    </label>
                    <input type="text" class="form-control" id="imgName" name="imgName" 
                           value="${mainImg.imgName}" placeholder="메인 이미지명을 입력하세요" required>
                </div>
                
                <div class="mb-3">
                    <label for="file" class="form-label">
                        <i class="fas fa-image me-1"></i>이미지 파일
                    </label>
                    <input type="file" class="form-control" id="file" name="file" accept="image/*">
                    <div class="form-text">
                        <i class="fas fa-info-circle me-1"></i>
                        새 이미지를 선택하지 않으면 기존 이미지가 유지됩니다.
                    </div>
                </div>
                
                <!-- 현재 이미지 미리보기 -->
                <div class="mb-3">
                    <label class="form-label">
                        <i class="fas fa-eye me-1"></i>현재 이미지
                    </label>
                    <div class="border rounded p-3 bg-light">
                        <img src="/uploads/main_img/${mainImg.img}" 
                             alt="${mainImg.imgName}" 
                             style="max-width: 300px; max-height: 200px; object-fit: cover;">
                        <p class="mt-2 mb-0 text-muted">
                            <small>파일명: ${mainImg.img}</small>
                        </p>
                    </div>
                </div>
                
                <div class="d-flex justify-content-between">
                    <a href="/admin/main_img/list" class="btn btn-secondary">
                        <i class="fas fa-times me-1"></i>취소
                    </a>
                    <button type="submit" class="btn btn-warning">
                        <i class="fas fa-save me-1"></i>수정
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
document.getElementById('editForm').addEventListener('submit', function(e) {
    const imgName = document.getElementById('imgName').value.trim();
    const file = document.getElementById('file').files[0];
    
    if (!imgName) {
        e.preventDefault();
        alert('메인 이미지명을 입력해주세요.');
        return false;
    }
    
    // 새 파일이 선택된 경우에만 파일 검증
    if (file) {
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
    }
});
</script> 