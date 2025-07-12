<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-plus me-2"></i>팝업 등록</h2>
        <p>새로운 팝업을 등록합니다.</p>
    </div>
    
    <!-- 알림 메시지 -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i>${error}
        </div>
    </c:if>
    
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">
                <i class="fas fa-edit me-2"></i>팝업 정보 입력
            </h5>
        </div>
        <div class="card-body">
            <form action="/admin/popup/register" method="POST" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="popupName" class="form-label">팝업명 <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="popupName" name="popupName" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="img" class="form-label">팝업 이미지</label>
                            <input type="file" class="form-control" id="img" name="img" accept="image/*" onchange="previewImage(this)">
                            <div class="form-text">지원 형식: JPG, PNG, GIF (최대 5MB)</div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">미리보기</label>
                            <div id="imagePreview" class="border rounded p-3 text-center" style="min-height: 200px; background-color: #f8f9fa;">
                                <i class="fas fa-image fa-3x text-muted"></i>
                                <p class="text-muted mt-2">이미지를 선택하면 미리보기가 표시됩니다.</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="d-flex justify-content-between">
                    <a href="/admin/popup/list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-1"></i>목록으로
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-1"></i>등록
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
function previewImage(input) {
    var preview = document.getElementById('imagePreview');
    var file = input.files[0];
    
    if (file) {
        // 파일 타입 검증
        if (!file.type.startsWith('image/')) {
            alert('이미지 파일만 선택할 수 있습니다.');
            input.value = '';
            preview.innerHTML = '<i class="fas fa-image fa-3x text-muted"></i><p class="text-muted mt-2">이미지를 선택하면 미리보기가 표시됩니다.</p>';
            return;
        }
        
        // 파일 크기 검증 (5MB)
        if (file.size > 5 * 1024 * 1024) {
            alert('파일 크기는 5MB 이하여야 합니다.');
            input.value = '';
            preview.innerHTML = '<i class="fas fa-image fa-3x text-muted"></i><p class="text-muted mt-2">이미지를 선택하면 미리보기가 표시됩니다.</p>';
            return;
        }
        
        var reader = new FileReader();
        reader.onload = function(e) {
            preview.innerHTML = '<img src="' + e.target.result + '" class="img-fluid" style="max-height: 200px;"><p class="text-muted mt-2">이미지 미리보기</p>';
        };
        reader.readAsDataURL(file);
    } else {
        preview.innerHTML = '<i class="fas fa-image fa-3x text-muted"></i><p class="text-muted mt-2">이미지를 선택하면 미리보기가 표시됩니다.</p>';
    }
}
</script> 