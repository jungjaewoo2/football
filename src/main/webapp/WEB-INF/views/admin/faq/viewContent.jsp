<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="newLine" value="\n" />

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-eye me-2"></i>FAQ 상세보기</h2>
        <p>FAQ의 상세 정보를 확인합니다.</p>
    </div>
    
    <div class="card">
        <div class="card-header bg-info text-white">
            <h5 class="mb-0">
                <i class="fas fa-question-circle me-2"></i>FAQ 정보
                <c:if test="${faq.notice == 'Y'}">
                    <span class="badge bg-warning text-dark ms-2">
                        <i class="fas fa-bullhorn me-1"></i>공지사항
                    </span>
                </c:if>
            </h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <div class="mb-3">
                        <label class="form-label fw-bold">번호</label>
                        <p class="form-control-plaintext">${faq.uid}</p>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">작성자</label>
                        <p class="form-control-plaintext">${faq.name}</p>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">제목</label>
                        <p class="form-control-plaintext">
                            <c:if test="${faq.notice == 'Y'}">
                                <i class="fas fa-bullhorn me-1 text-warning" title="공지사항"></i>
                            </c:if>
                            ${faq.title}
                        </p>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="mb-3">
                        <label class="form-label fw-bold">등록일</label>
                        <p class="form-control-plaintext">
                            <c:choose>
                                <c:when test="${faq.regdate != null}">
                                    ${faq.regdate}
                                </c:when>
                                <c:when test="${faq.createdAt != null}">
                                    ${faq.createdAt}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">-</span>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">수정일</label>
                        <p class="form-control-plaintext">
                            <c:choose>
                                <c:when test="${faq.updatedAt != null}">
                                    ${faq.updatedAt}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">-</span>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">공지사항</label>
                        <p class="form-control-plaintext">
                            <c:choose>
                                <c:when test="${faq.notice == 'Y'}">
                                    <span class="badge bg-warning text-dark">
                                        <i class="fas fa-bullhorn me-1"></i>공지사항
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">일반</span>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
            </div>
            
            <div class="mb-3">
                <label class="form-label fw-bold">내용</label>
                <div class="border rounded p-3 bg-light">
                    <div class="content-area">
                        <c:choose>
                            <c:when test="${not empty faq.content}">
                                <div class="ck-content">
                                    ${fn:replace(faq.content, newLine, '<br>')}
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-4">
                                    <i class="fas fa-question-circle fa-2x text-muted mb-2"></i>
                                    <p class="text-muted">등록된 FAQ 내용이 없습니다.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <div class="d-flex justify-content-between">
                <a href="/admin/faq/list" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-1"></i>목록으로
                </a>
                <div>
                    <a href="/admin/faq/edit/${faq.uid}" class="btn btn-warning">
                        <i class="fas fa-edit me-1"></i>수정
                    </a>
                    <button type="button" class="btn btn-danger" onclick="deleteFaq(${faq.uid}, '${faq.title}')">
                        <i class="fas fa-trash me-1"></i>삭제
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 삭제 확인 모달 -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">삭제 확인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>정말로 "<span id="deleteTitle"></span>"을(를) 삭제하시겠습니까?</p>
                <p class="text-danger"><small>삭제된 내용은 복구할 수 없습니다.</small></p>
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
function deleteFaq(uid, title) {
    document.getElementById('deleteTitle').textContent = title;
    document.getElementById('deleteForm').action = '/admin/faq/delete/' + uid;
    new bootstrap.Modal(document.getElementById('deleteModal')).show();
}
</script>

<style>
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