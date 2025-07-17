<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-reply me-2"></i>답변 등록</h2>
        <p>티켓문의에 대한 답변을 작성합니다.</p>
    </div>
    
    <!-- 원본 문의 정보 -->
    <c:if test="${not empty qna}">
        <div class="card mb-4">
            <div class="card-header bg-light">
                <h5 class="mb-0"><i class="fas fa-question-circle me-2"></i>원본 문의</h5>
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
            </div>
        </div>
    </c:if>
    
    <!-- 답변 작성 폼 -->
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0"><i class="fas fa-edit me-2"></i>답변 작성</h5>
        </div>
        <div class="card-body">
            <form action="/admin/qna/reply/${qna.uid}" method="post">
                <input type="hidden" name="qnaId" value="${qna.uid}">
                
                <div class="form-group mb-3">
                    <label for="replyName" class="form-label"><strong>답변자:</strong></label>
                    <input type="text" class="form-control" id="replyName" name="name" 
                           value="관리자" required>
                </div>
                
                <div class="form-group mb-3">
                    <label for="replyContent" class="form-label"><strong>답변 내용:</strong></label>
                    <textarea class="form-control" id="replyContent" name="content" rows="8" 
                              placeholder="답변 내용을 입력하세요..." required></textarea>
                    <div class="form-text">답변 내용을 상세히 작성해주세요.</div>
                </div>
                
                <div class="d-flex justify-content-between mt-4">
                    <a href="/admin/qna/view/${qna.uid}" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-1"></i>돌아가기
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-1"></i>답변 등록
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- 데이터가 없는 경우 -->
    <c:if test="${empty qna}">
        <div class="alert alert-warning" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>문의 정보를 찾을 수 없습니다.
        </div>
        <div class="text-center">
            <a href="/admin/qna/list" class="btn btn-secondary">
                <i class="fas fa-list me-1"></i>목록으로
            </a>
        </div>
    </c:if>
</div> 