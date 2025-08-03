<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content-card">
    <div class="content-header">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h2>🎫 티켓바로가기 삭제</h2>
                <p>티켓바로가기 정보를 삭제합니다.</p>
            </div>
            <a href="/admin/ticket_link/list" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-2"></i>목록으로 돌아가기
            </a>
        </div>
    </div>
    
    <!-- 삭제 확인 메시지 -->
    <div class="alert alert-warning">
        <i class="fas fa-exclamation-triangle me-2"></i>
        <strong>주의!</strong> 이 작업은 되돌릴 수 없습니다.
    </div>
    
    <!-- 삭제할 정보 표시 -->
    <div class="card">
        <div class="card-header">
            <h5>삭제할 티켓바로가기 정보</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label><strong>티켓 타이틀:</strong></label>
                        <p><c:out value="${ticketLink.ticketName}"/></p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label><strong>티켓 서브타이틀:</strong></label>
                        <p><c:out value="${ticketLink.ticketSubTitle}"/></p>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label><strong>대표이미지:</strong></label>
                <c:if test="${not empty ticketLink.ticketImg}">
                    <div class="mt-2">
                        <img src="/uploads/ticket_link/${ticketLink.ticketImg}" 
                             alt="티켓 이미지" style="max-width: 200px; max-height: 150px;" class="img-thumbnail">
                    </div>
                </c:if>
                <c:if test="${empty ticketLink.ticketImg}">
                    <p class="text-muted">이미지 없음</p>
                </c:if>
            </div>
            
            <div class="form-group">
                <label><strong>링크 주소:</strong></label>
                <div class="border p-3 bg-light">
                    <c:choose>
                        <c:when test="${not empty ticketLink.link}">
                            <a href="<c:out value='${ticketLink.link}'/>" target="_blank">
                                <c:out value="${ticketLink.link}"/>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <span class="text-muted">링크 없음</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <div class="form-group">
                <label><strong>내용:</strong></label>
                <div class="border p-3 bg-light">
                    <c:choose>
                        <c:when test="${not empty ticketLink.content}">
                            <c:out value="${ticketLink.content}"/>
                        </c:when>
                        <c:otherwise>
                            <span class="text-muted">내용 없음</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 삭제 확인 폼 -->
    <form method="POST" action="/admin/ticket_link/delete/${ticketLink.uid}" class="mt-4">
        <div class="form-group text-center">
            <button type="submit" class="btn btn-danger me-2" onclick="return confirm('정말 삭제하시겠습니까?')">
                <i class="fas fa-trash me-2"></i>삭제하기
            </button>
            <a href="/admin/ticket_link/list" class="btn btn-secondary">
                <i class="fas fa-times me-2"></i>취소
            </a>
        </div>
    </form>
</div> 