<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content-card">
    <div class="content-header">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h2>🎫 티켓바로가기 수정</h2>
                <p>티켓바로가기 정보를 수정합니다.</p>
            </div>
            <a href="/admin/ticket_link/list" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-2"></i>목록으로 돌아가기
            </a>
        </div>
    </div>
    
    <!-- 알림 메시지 -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i><c:out value="${error}"/>
        </div>
    </c:if>
    
    <!-- 수정 폼 -->
    <form method="POST" action="/admin/ticket_link/edit/${ticketLink.uid}" enctype="multipart/form-data">
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="ticketName">티켓 타이틀 *</label>
                    <input type="text" class="form-control" id="ticketName" name="ticketName" 
                           value="<c:out value='${ticketLink.ticketName}'/>" required>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="ticketSubTitle">티켓 서브타이틀</label>
                    <input type="text" class="form-control" id="ticketSubTitle" name="ticketSubTitle" 
                           value="<c:out value='${ticketLink.ticketSubTitle}'/>">
                </div>
            </div>
        </div>
        
        <div class="form-group">
            <label for="ticketImg">티켓 대표이미지</label>
            <c:if test="${not empty ticketLink.ticketImg}">
                <div class="mb-2">
                    <strong>현재 이미지:</strong>
                    <img src="/uploads/ticket_link/${ticketLink.ticketImg}" 
                         alt="현재 이미지" style="max-width: 200px; max-height: 150px;" class="img-thumbnail">
                </div>
            </c:if>
            <input type="file" class="form-control" id="ticketImg" name="ticketImg" 
                   accept="image/*">
            <small class="form-text text-muted">새 이미지를 선택하면 기존 이미지가 교체됩니다. (JPG, PNG, GIF 등)  이미지 240*260 적정크기  </small>
        </div>
        
        <div class="form-group">
            <label for="link">링크 주소(도메인만 변경하세요)</label>
            <input type="url" class="form-control" id="link" name="link" 
                   value="<c:out value='${ticketLink.link}'/>" 
                   placeholder="https://example.com">
            <small class="form-text text-muted">티켓바로가기 클릭 시 이동할 URL을 입력하세요.</small>
        </div>
        
        <div class="form-group">
            <label for="content">내용</label>
            <textarea class="form-control" id="content" name="content" rows="10" 
                      placeholder="티켓바로가기 내용을 입력하세요..."><c:out value="${ticketLink.content}"/></textarea>
        </div>
        
        <div class="form-group text-center">
            <button type="submit" class="btn btn-primary me-2">
                <i class="fas fa-save me-2"></i>수정하기
            </button>
            <a href="/admin/ticket_link/list" class="btn btn-secondary">
                <i class="fas fa-times me-2"></i>취소
            </a>
        </div>
    </form>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // 이미지 미리보기 기능
    const imageInput = document.getElementById('ticketImg');
    const previewContainer = document.createElement('div');
    previewContainer.className = 'mt-2';
    imageInput.parentNode.appendChild(previewContainer);
    
    imageInput.addEventListener('change', function() {
        previewContainer.innerHTML = '';
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const img = document.createElement('img');
                img.src = e.target.result;
                img.style.maxWidth = '200px';
                img.style.maxHeight = '150px';
                img.className = 'img-thumbnail';
                previewContainer.appendChild(img);
            };
            reader.readAsDataURL(file);
        }
    });
});
</script> 