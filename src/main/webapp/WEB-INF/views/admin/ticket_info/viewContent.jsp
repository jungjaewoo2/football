<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="newLine" value="\n" />

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-ticket-alt me-2"></i>티켓구매안내 관리</h2>
        <p>티켓구매안내 내용을 확인하고 수정할 수 있습니다.</p>
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
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0">
                    <i class="fas fa-ticket-alt me-2"></i>티켓구매안내 내용
                </h5>
                <div class="btn-group">
                    <a href="/admin/ticket_info/edit" class="btn btn-light btn-sm">
                        <i class="fas fa-edit me-1"></i>수정
                    </a>
                </div>
            </div>
        </div>
        <div class="card-body">
            <div class="content-area">
                <c:choose>
                    <c:when test="${not empty ticketInfo.content}">
                        <div class="ck-content">
                            ${fn:replace(ticketInfo.content, newLine, '<br>')}
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-4">
                            <i class="fas fa-ticket-alt fa-2x text-muted mb-2"></i>
                            <p class="text-muted">등록된 티켓구매안내 내용이 없습니다.</p>
                            <a href="/admin/ticket_info/edit" class="btn btn-primary">
                                <i class="fas fa-plus me-1"></i>티켓구매안내 내용 등록하기
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <div class="d-flex justify-content-between mt-4">
        <div>

        </div>
    </div>
</div>
<style>
.content-area { min-height: 400px; padding: 20px; background-color: #f8f9fa; border-radius: 0.375rem; border: 1px solid #dee2e6; }
.ck-content { line-height: 1.6; }
.ck-content img { max-width: 100%; height: auto; border-radius: 0.375rem; margin: 10px 0; }
.ck-content h1, .ck-content h2, .ck-content h3, .ck-content h4, .ck-content h5, .ck-content h6 { margin-top: 1.5rem; margin-bottom: 1rem; color: #333; }
.ck-content p { margin-bottom: 1rem; }
.ck-content ul, .ck-content ol { margin-bottom: 1rem; padding-left: 2rem; }
.ck-content blockquote { border-left: 4px solid #007bff; padding-left: 1rem; margin: 1rem 0; font-style: italic; color: #666; }
.ck-content table { width: 100%; border-collapse: collapse; margin: 1rem 0; }
.ck-content table th, .ck-content table td { border: 1px solid #dee2e6; padding: 0.75rem; text-align: left; }
.ck-content table th { background-color: #f8f9fa; font-weight: bold; }
</style> 