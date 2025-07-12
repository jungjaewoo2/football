<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-trash me-2"></i>관전후기 삭제</h2>
        <p>관전후기를 삭제합니다.</p>
    </div>
    
    <!-- 경고 메시지 -->
    <div class="alert alert-warning">
        <div class="d-flex align-items-center">
            <i class="fas fa-exclamation-triangle me-2 fa-2x"></i>
            <div>
                <h5 class="mb-1">삭제 확인</h5>
                <p class="mb-0">아래 관전후기를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.</p>
            </div>
        </div>
    </div>
    
    <div class="card">
        <div class="card-header">
            <h5 class="mb-0">삭제할 관전후기 정보</h5>
        </div>
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-md-6">
                    <strong><i class="fas fa-hashtag me-1"></i>번호:</strong> ${gallery.uid}
                </div>
                <div class="col-md-6">
                    <strong><i class="fas fa-user me-1"></i>작성자:</strong> ${gallery.name}
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <strong><i class="fas fa-calendar me-1"></i>등록일:</strong> 
                    ${gallery.regdate}
                </div>
                <div class="col-md-6">
                    <strong><i class="fas fa-clock me-1"></i>수정일:</strong> 
                    ${gallery.updatedAt}
                </div>
            </div>
            <div class="mb-3">
                <strong><i class="fas fa-heading me-1"></i>제목:</strong>
                <div class="mt-1">${gallery.title}</div>
            </div>
            <div class="mb-3">
                <strong><i class="fas fa-edit me-1"></i>내용 미리보기:</strong>
                <div class="content-preview mt-1">
                    ${gallery.content}
                </div>
            </div>
        </div>
    </div>

    <!-- 삭제 확인 폼 -->
    <div class="card mt-4">
        <div class="card-body">
            <form action="/admin/gallery/delete/${gallery.uid}" method="post" id="deleteForm">
                <div class="d-flex justify-content-center gap-3">
                    <a href="/admin/gallery/view/${gallery.uid}" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-1"></i>상세보기로
                    </a>
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash me-1"></i>삭제 확인
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // 삭제 확인
    document.getElementById('deleteForm').addEventListener('submit', function(e) {
        if (!confirm('정말로 이 관전후기를 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.')) {
            e.preventDefault();
        }
    });
</script> 