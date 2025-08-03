<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-edit me-2"></i>카피라이터 관리</h2>
        <p>연락처 정보를 수정할 수 있습니다.</p>
    </div>
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
    <div class="card">
        <div class="card-header bg-warning text-dark">
            <h5 class="mb-0">
                <i class="fas fa-copyright me-2"></i>연락처 정보 수정
            </h5>
        </div>
        <div class="card-body">
            <form id="footerInfoForm" method="post" action="/admin/footer_info/edit">
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="phone" class="form-label">
                                <i class="fas fa-phone me-1"></i>전화번호
                            </label>
                            <input type="tel" id="phone" name="phone" class="form-control" 
                                   placeholder="전화번호를 입력하세요 (예: 070-7779-9614)" 
                                   value="${footerInfo.phone}">
                            <div class="form-text">
                                <i class="fas fa-info-circle me-1"></i>
                                하이픈(-)을 포함하여 입력해주세요.
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="email" class="form-label">
                                <i class="fas fa-envelope me-1"></i>이메일
                            </label>
                            <input type="email" id="email" name="email" class="form-control" 
                                   placeholder="이메일을 입력하세요 (예: info@example.com)" 
                                   value="${footerInfo.email}">
                            <div class="form-text">
                                <i class="fas fa-info-circle me-1"></i>
                                올바른 이메일 형식으로 입력해주세요.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-between">
                    <a href="/admin/footer_info" class="btn btn-secondary">
                        <i class="fas fa-times me-1"></i>취소
                    </a>
                    <button type="submit" class="btn btn-warning">
                        <i class="fas fa-save me-1"></i>저장
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.getElementById('footerInfoForm').addEventListener('submit', function(e) {
        const phone = document.getElementById('phone').value.trim();
        const email = document.getElementById('email').value.trim();
        
        if (!phone && !email) {
            e.preventDefault();
            alert('전화번호 또는 이메일 중 하나는 입력해주세요.');
            return false;
        }
        
        if (email && !isValidEmail(email)) {
            e.preventDefault();
            alert('올바른 이메일 형식으로 입력해주세요.');
            return false;
        }
    });
    
    function isValidEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }
</script>

<style>
.form-control:focus {
    border-color: #86b7fe;
    box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
}
</style> 