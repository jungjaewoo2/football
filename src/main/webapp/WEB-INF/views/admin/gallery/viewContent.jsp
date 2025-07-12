<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-eye me-2"></i>관전후기 상세보기</h2>
        <p>관전후기 상세 정보를 확인합니다.</p>
    </div>
    
    <div class="card">
        <div class="card-header">
            <h4 class="mb-0">${gallery.title}</h4>
        </div>
        <div class="card-body">
            <!-- 게시물 정보 -->
            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="info-row d-flex">
                        <span class="info-label">
                            <i class="fas fa-hashtag me-1"></i>번호:
                        </span>
                        <span>${gallery.uid}</span>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="info-row d-flex">
                        <span class="info-label">
                            <i class="fas fa-user me-1"></i>작성자:
                        </span>
                        <span>${gallery.name}</span>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="info-row d-flex">
                        <span class="info-label">
                            <i class="fas fa-calendar me-1"></i>등록일:
                        </span>
                        <span>
                            ${gallery.regdate}
                        </span>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="info-row d-flex">
                        <span class="info-label">
                            <i class="fas fa-clock me-1"></i>수정일:
                        </span>
                        <span>
                            ${gallery.updatedAt}
                        </span>
                    </div>
                </div>
            </div>

            <!-- 게시물 내용 -->
            <div class="mb-3">
                <label class="form-label">
                    <i class="fas fa-edit me-1"></i>내용
                </label>
                <div class="content-box">
                    ${gallery.content}
                </div>
            </div>
        </div>
    </div>

    <!-- 이전/다음 게시물 네비게이션 -->
    <div class="card mt-4">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <c:if test="${gallery.uid > 1}">
                        <a href="/admin/gallery/view/${gallery.uid - 1}" class="btn btn-outline-primary">
                            <i class="fas fa-chevron-left me-1"></i>이전 글
                        </a>
                    </c:if>
                </div>
                <div class="col-md-6 text-end">
                    <a href="/admin/gallery/view/${gallery.uid + 1}" class="btn btn-outline-primary">
                        다음 글<i class="fas fa-chevron-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- 관리 버튼 -->
    <div class="d-flex justify-content-end gap-2 mt-4">
        <a href="/admin/gallery/edit/${gallery.uid}" class="btn btn-warning">
            <i class="fas fa-edit me-1"></i>수정
        </a>
        <button type="button" class="btn btn-danger" onclick="deleteGallery(${gallery.uid}, '${gallery.title}')">
            <i class="fas fa-trash me-1"></i>삭제
        </button>
        <a href="/admin/gallery/list" class="btn btn-outline-secondary">
            <i class="fas fa-arrow-left me-1"></i>목록으로
        </a>
    </div>
</div>

<!-- 삭제 확인 모달 -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">관전후기 삭제 확인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>정말로 "<span id="deleteTitle"></span>" 관전후기를 삭제하시겠습니까?</p>
                <p class="text-danger"><small>삭제된 관전후기는 복구할 수 없습니다.</small></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <form method="POST" id="deleteForm" style="display: inline;">
                    <button type="submit" class="btn btn-danger">삭제</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function deleteGallery(uid, title) {
        document.getElementById('deleteTitle').textContent = title;
        document.getElementById('deleteForm').action = '/admin/gallery/delete/' + uid;
        
        var deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        deleteModal.show();
    }
</script> 