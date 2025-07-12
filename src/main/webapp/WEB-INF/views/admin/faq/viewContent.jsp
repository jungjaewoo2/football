<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
                    <pre class="mb-0" style="white-space: pre-wrap; font-family: inherit;">${faq.content}</pre>
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