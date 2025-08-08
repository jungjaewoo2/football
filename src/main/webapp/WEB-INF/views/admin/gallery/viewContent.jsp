<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
    .gallery-image {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    
    .gallery-image:hover {
        transform: scale(1.02);
        box-shadow: 0 4px 12px rgba(0,0,0,0.15) !important;
    }
    
    .image-box {
        position: relative;
        display: inline-block;
    }
    
    .image-box::after {
        content: "🔍 클릭하여 확대";
        position: absolute;
        bottom: 10px;
        right: 10px;
        background: rgba(0,0,0,0.7);
        color: white;
        padding: 4px 8px;
        border-radius: 4px;
        font-size: 12px;
        opacity: 0;
        transition: opacity 0.3s ease;
    }
    
    .image-box:hover::after {
        opacity: 1;
    }

    .content-area { min-height: 400px; padding: 20px; background-color: #f8f9fa; border-radius: 0.375rem; border: 1px solid #dee2e6; }
    .ck-content { line-height: 1.6; }
    .ck-content img { max-width: 100%; height: auto; border-radius: 0.375rem; margin: 10px 0; }

    /* 이미지 정렬 스타일 - CKEditor 5 실제 출력 형식 지원 */
    .ck-content img.image-style-align-center,
    .ck-content figure.image-style-align-center img,
    .ck-content .image-style-align-center img,
    .ck-content figure[class*="align-center"] img,
    .ck-content figure[class*="center"] img {
        display: block;
        margin: 10px auto;
        text-align: center;
    }

    .ck-content img.image-style-align-left,
    .ck-content figure.image-style-align-left img,
    .ck-content .image-style-align-left img,
    .ck-content figure[class*="align-left"] img,
    .ck-content figure[class*="left"] img {
        float: left;
        margin: 0 1rem 1rem 0;
    }

    .ck-content img.image-style-align-right,
    .ck-content figure.image-style-align-right img,
    .ck-content .image-style-align-right img,
    .ck-content figure[class*="align-right"] img,
    .ck-content figure[class*="right"] img {
        float: right;
        margin: 0 0 1rem 1rem;
    }

    .ck-content img.image-style-block,
    .ck-content figure.image-style-block img,
    .ck-content .image-style-block img {
        display: block;
        margin: 1rem 0;
    }

    .ck-content img.image-style-side,
    .ck-content figure.image-style-side img,
    .ck-content .image-style-side img {
        float: right;
        margin: 0 0 1rem 1rem;
        max-width: 50%;
    }

    /* figure 요소 정렬 스타일 */
    .ck-content figure.image-style-align-center,
    .ck-content figure[class*="align-center"],
    .ck-content figure[class*="center"] {
        text-align: center;
        display: block;
    }

    .ck-content figure.image-style-align-left,
    .ck-content figure[class*="align-left"],
    .ck-content figure[class*="left"] {
        float: left;
        margin: 0 1rem 1rem 0;
    }

    .ck-content figure.image-style-align-right,
    .ck-content figure[class*="align-right"],
    .ck-content figure[class*="right"] {
        float: right;
        margin: 0 0 1rem 1rem;
    }

    /* 이미지 컨테이너 정리 */
    .ck-content figure {
        margin: 1rem 0;
    }

    .ck-content figure img {
        max-width: 100%;
        height: auto;
    }

    /* 추가: CKEditor 5의 새로운 클래스명 지원 */
    .ck-content .image {
        margin: 1rem 0;
    }

    .ck-content .image.image-style-align-center,
    .ck-content .image[class*="align-center"],
    .ck-content .image[class*="center"] {
        text-align: center;
    }

    .ck-content .image.image-style-align-center img,
    .ck-content .image[class*="align-center"] img,
    .ck-content .image[class*="center"] img {
        display: inline-block;
        margin: 0 auto;
    }

    .ck-content .image.image-style-align-left,
    .ck-content .image[class*="align-left"],
    .ck-content .image[class*="left"] {
        float: left;
        margin: 0 1rem 1rem 0;
    }

    .ck-content .image.image-style-align-right,
    .ck-content .image[class*="align-right"],
    .ck-content .image[class*="right"] {
        float: right;
        margin: 0 0 1rem 1rem;
    }

    /* 추가: CKEditor 5의 실제 클래스명 패턴 지원 */
    .ck-content [class*="align-center"],
    .ck-content [class*="center"] {
        text-align: center;
    }

    .ck-content [class*="align-left"],
    .ck-content [class*="left"] {
        float: left;
        margin: 0 1rem 1rem 0;
    }

    .ck-content [class*="align-right"],
    .ck-content [class*="right"] {
        float: right;
        margin: 0 0 1rem 1rem;
    }
    .ck-content h1, .ck-content h2, .ck-content h3, .ck-content h4, .ck-content h5, .ck-content h6 { margin-top: 1.5rem; margin-bottom: 1rem; color: #333; }
    .ck-content p { margin-bottom: 1rem; }
    .ck-content ul, .ck-content ol { margin-bottom: 1rem; padding-left: 2rem; }
    .ck-content blockquote { border-left: 4px solid #007bff; padding-left: 1rem; margin: 1rem 0; font-style: italic; color: #666; }
    .ck-content table { width: 100%; border-collapse: collapse; margin: 1rem 0; }
    .ck-content table th, .ck-content table td { border: 1px solid #dee2e6; padding: 0.75rem; text-align: left; }
    .ck-content table th { background-color: #f8f9fa; font-weight: bold; }
</style>

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

            <!-- 첨부 이미지 -->
            <c:if test="${not empty gallery.img}">
                <div class="mb-3">
                    <label class="form-label">
                        <i class="fas fa-image me-1"></i>첨부 이미지
                    </label>
                    <div class="image-box">
                        <img src="/uploads/gallery/${gallery.img}" alt="관전후기 이미지" 
                             class="img-fluid gallery-image" style="max-width: 100%; max-height: 400px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); cursor: pointer;"
                             onclick="openImageModal('/uploads/gallery/${gallery.img}')">
                    </div>
                </div>
            </c:if>

            <!-- 게시물 내용 -->
            <div class="mb-3">
                <label class="form-label">
                    <i class="fas fa-edit me-1"></i>내용
                </label>
                <div class="content-box">
                    <div class="ck-content">
                        ${gallery.content}
                    </div>
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

<!-- 이미지 확대 모달 -->
<div class="modal fade" id="imageModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">이미지 확대보기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center">
                <img id="modalImage" src="" alt="확대된 이미지" class="img-fluid">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
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
    
    function openImageModal(imageSrc) {
        document.getElementById('modalImage').src = imageSrc;
        var imageModal = new bootstrap.Modal(document.getElementById('imageModal'));
        imageModal.show();
    }
</script> 