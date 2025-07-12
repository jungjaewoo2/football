<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-trash me-2"></i>FAQ 삭제</h2>
        <p>FAQ를 삭제합니다.</p>
    </div>
    
    <div class="card">
        <div class="card-header bg-danger text-white">
            <h5 class="mb-0">
                <i class="fas fa-exclamation-triangle me-2"></i>삭제 확인
            </h5>
        </div>
        <div class="card-body">
            <div class="alert alert-warning">
                <i class="fas fa-exclamation-triangle me-2"></i>
                <strong>주의:</strong> 이 작업은 되돌릴 수 없습니다.
            </div>
            
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
                        <p class="form-control-plaintext">${faq.title}</p>
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
                <form method="POST" action="/admin/faq/delete/${faq.uid}" style="display: inline;">
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash me-1"></i>삭제
                    </button>
                </form>
            </div>
        </div>
    </div>
</div> 