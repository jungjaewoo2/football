<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-question-circle me-2"></i>티켓문의 관리</h2>
        <p>사용자들의 티켓 문의를 관리합니다.</p>
    </div>
    
    <!-- 알림 메시지 -->
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
    
    <!-- 검색 및 등록 버튼 -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <!-- 검색 폼 -->
        <form method="GET" action="/admin/qna/list" class="d-flex gap-2">
            <input type="hidden" name="page" value="0">
            <select name="searchType" class="form-select" style="width: auto;">
                <option value="all" ${searchType == 'all' ? 'selected' : ''}>전체</option>
                <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
                <option value="name" ${searchType == 'name' ? 'selected' : ''}>작성자</option>
                <option value="content" ${searchType == 'content' ? 'selected' : ''}>내용</option>
            </select>
            <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="검색어를 입력하세요" style="width: 200px;">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-search me-1"></i>검색
            </button>
            <c:if test="${not empty keyword}">
                <a href="/admin/qna/list" class="btn btn-secondary">
                    <i class="fas fa-times me-1"></i>초기화
                </a>
            </c:if>
        </form>
        
        <!-- 등록 버튼 -->
        <a href="/admin/qna/register" class="btn btn-success">
            <i class="fas fa-plus me-1"></i>새 문의 등록
        </a>
    </div>
    
    <!-- QNA 목록 테이블 -->
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th style="width: 80px; text-align: center;">번호</th>
                    <th style="width: 300px; text-align: center;">제목</th>
                    <th style="width: 120px; text-align: center;">작성자</th>
                    <th style="width: 120px; text-align: center;">등록일</th>
                    <th style="width: 80px; text-align: center;">공지</th>
                    <th style="width: 100px; text-align: center;">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty qnaList}">
                        <tr>
                            <td colspan="6" class="text-center py-4">
                                <i class="fas fa-inbox fa-2x text-muted mb-2"></i>
                                <p class="text-muted">등록된 문의가 없습니다.</p>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="qna" items="${qnaList}" varStatus="status">
                            <tr>
                                <td class="text-center">${totalElements - (currentPage * 10) - status.index}</td>
                                <td>
                                    <a href="/admin/qna/view/${qna.uid}" class="text-decoration-none">
                                        <c:if test="${qna.notice == 'Y'}">
                                            <i class="fas fa-bullhorn me-1 text-warning" title="공지사항"></i>
                                        </c:if>
                                        <i class="fas fa-file-alt me-1 text-primary"></i>
                                        ${qna.title}
                                    </a>
                                </td>
                                <td class="text-center">${qna.name}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${qna.regdate != null}">
                                            <c:set var="regdateStr" value="${qna.regdate}" />
                                            <c:choose>
                                                <c:when test="${fn:contains(regdateStr, 'T')}">
                                                    ${fn:substring(regdateStr, 0, fn:indexOf(regdateStr, 'T'))}
                                                </c:when>
                                                <c:otherwise>
                                                    ${regdateStr}
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${qna.createdAt != null}">
                                            <c:set var="createdAtStr" value="${qna.createdAt}" />
                                            <c:choose>
                                                <c:when test="${fn:contains(createdAtStr, 'T')}">
                                                    ${fn:substring(createdAtStr, 0, fn:indexOf(createdAtStr, 'T'))}
                                                </c:when>
                                                <c:otherwise>
                                                    ${createdAtStr}
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">-</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <c:if test="${qna.notice == 'Y'}">
                                        <span class="badge bg-warning text-dark">
                                            <i class="fas fa-bullhorn me-1"></i>공지
                                        </span>
                                    </c:if>
                                </td>
                                <td class="text-center">
                                    <div class="btn-group btn-group-sm" role="group">
                                        <a href="/admin/qna/view/${qna.uid}" class="btn btn-outline-primary" title="상세보기">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="/admin/qna/edit/${qna.uid}" class="btn btn-outline-warning" title="수정">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <button type="button" class="btn btn-outline-danger" title="삭제" 
                                                onclick="deleteQna(${qna.uid}, '${qna.title}')">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
    
    
    <!-- 페이징 -->
    <c:if test="${totalPages >= 1}">
        <nav aria-label="QNA 페이지 네비게이션">
            <ul class="pagination justify-content-center">
                <!-- 처음 페이지 버튼 -->
                <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                    <a class="page-link" href="/admin/qna/list?page=0&searchType=${searchType}&keyword=${keyword}">
                        <i class="fas fa-angle-double-left"></i>
                    </a>
                </li>
                
                <!-- 이전 페이지 버튼 -->
                <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                    <a class="page-link" href="/admin/qna/list?page=${currentPage - 1}&searchType=${searchType}&keyword=${keyword}">
                        <i class="fas fa-angle-left"></i>
                    </a>
                </li>
                
                <!-- 페이지 번호 (5개씩 그룹화) -->
                <c:set var="startPage" value="${(currentPage / 5) * 5}" />
                <c:set var="endPage" value="${startPage + 4}" />
                <c:if test="${endPage >= totalPages}">
                    <c:set var="endPage" value="${totalPages - 1}" />
                </c:if>
                
                <!-- 페이지 번호들 -->
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                    <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                        <a class="page-link" href="/admin/qna/list?page=${pageNum}&searchType=${searchType}&keyword=${keyword}">
                            ${pageNum + 1}
                        </a>
                    </li>
                </c:forEach>
                
                <!-- 다음 페이지 버튼 -->
                <li class="page-item ${currentPage >= totalPages - 1 ? 'disabled' : ''}">
                    <a class="page-link" href="/admin/qna/list?page=${currentPage + 1}&searchType=${searchType}&keyword=${keyword}">
                        <i class="fas fa-angle-right"></i>
                    </a>
                </li>
                
                <!-- 마지막 페이지 버튼 -->
                <li class="page-item ${currentPage >= totalPages - 1 ? 'disabled' : ''}">
                    <a class="page-link" href="/admin/qna/list?page=${totalPages - 1}&searchType=${searchType}&keyword=${keyword}">
                        <i class="fas fa-angle-double-right"></i>
                    </a>
                </li>
            </ul>
        </nav>
        
        <!-- 페이지 정보 -->
        <div class="text-center text-muted">
            총 ${totalElements}개의 티켓문의 중 ${(currentPage * 10) + 1} - ${Math.min((currentPage + 1) * 10, totalElements)}개 표시
        </div>
    </c:if>
</div>

<!-- 삭제 확인 모달 -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">문의 삭제 확인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>정말로 "<span id="deleteTitle"></span>" 문의를 삭제하시겠습니까?</p>
                <p class="text-danger"><small>삭제된 문의와 관련 답변은 복구할 수 없습니다.</small></p>
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
    function deleteQna(uid, title) {
        document.getElementById('deleteTitle').textContent = title;
        document.getElementById('deleteForm').action = '/admin/qna/delete/' + uid;
        
        var deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        deleteModal.show();
    }
</script> 