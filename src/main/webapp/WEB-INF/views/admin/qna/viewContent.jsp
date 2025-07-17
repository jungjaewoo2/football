<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-list me-2"></i>티켓문의 상세보기</h2>
        <p>티켓문의 내용과 답변을 확인할 수 있습니다.</p>
    </div>
    
    <!-- 문의 정보 -->
    <c:if test="${not empty qna}">
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="mb-0">문의 정보</h5>
            </div>
            <div class="card-body">
                <div class="row mb-3">
                    <div class="col-md-4">
                        <strong>작성자:</strong> ${qna.name}
                    </div>
                    <div class="col-md-4">
                        <strong>작성일:</strong> ${qna.regdate}
                    </div>
                    <div class="col-md-4">
                        <strong>제목:</strong> ${qna.title}
                    </div>
                </div>
                
                <div class="mb-3">
                    <label class="form-label"><strong>문의내용:</strong></label>
                    <div style="background-color: #f8f9fa; padding: 15px; border-radius: 5px;">
                        <pre style="white-space: pre-wrap; word-wrap: break-word; margin: 0;">${qna.content}</pre>
                    </div>
                </div>
                
                <c:if test="${not empty qna.attachmentUrl}">
                    <div class="mb-3">
                        <label class="form-label"><strong>첨부파일:</strong></label>
                        <p><a href="${qna.attachmentUrl}" target="_blank" class="btn btn-sm btn-secondary">파일 다운로드</a></p>
                    </div>
                </c:if>
            </div>
        </div>
    </c:if>
    
    <!-- 답변 목록 -->
    <c:choose>
        <c:when test="${not empty replies}">
            <div class="card mb-4">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0"><i class="fas fa-reply me-2"></i>답변 내역 (${fn:length(replies)}개)</h5>
                </div>
                <div class="card-body">
                    <c:forEach items="${replies}" var="reply" varStatus="status">
                        <div class="mb-4 ${status.last ? '' : 'border-bottom pb-4'}">
                            <div class="d-flex justify-content-between mb-2">
                                <div>
                                    <strong class="text-primary">관리자 답변</strong>
                                    <small class="text-muted ms-2">(${reply.name})</small>
                                </div>
                                <small class="text-muted">
                                    <i class="fas fa-clock me-1"></i>${reply.regdate}
                                </small>
                            </div>
                            <div style="background-color: #e9ecef; padding: 15px; border-radius: 5px; border-left: 4px solid #28a745;">
                                <pre style="white-space: pre-wrap; word-wrap: break-word; margin: 0;">${reply.content}</pre>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="card mb-4">
                <div class="card-header bg-warning text-dark">
                    <h5 class="mb-0"><i class="fas fa-exclamation-triangle me-2"></i>답변 내역</h5>
                </div>
                <div class="card-body text-center">
                    <p class="text-muted mb-0">
                        <i class="fas fa-info-circle me-2"></i>아직 답변이 등록되지 않았습니다.
                    </p>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
    
    <!-- 답변 작성 버튼 -->
    <div class="card">
        <div class="card-header">
            <h5 class="mb-0">답변 관리</h5>
        </div>
        <div class="card-body">
            <div class="d-flex justify-content-between">
                <a href="/admin/qna/list" class="btn btn-secondary">
                    <i class="fas fa-list me-1"></i>목록으로
                </a>
                <a href="/admin/qna/reply/${qna.uid}" class="btn btn-primary">
                    <i class="fas fa-reply me-1"></i>답변 등록
                </a>
            </div>
        </div>
    </div>
    
    <!-- 데이터가 없는 경우 -->
    <c:if test="${empty qna}">
        <div class="alert alert-warning" role="alert">
            문의 정보를 찾을 수 없습니다.
        </div>
        <div class="text-center">
            <a href="/admin/qna/list" class="btn btn-secondary">목록으로</a>
        </div>
    </c:if>
</div> 