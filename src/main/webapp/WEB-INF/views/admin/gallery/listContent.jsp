<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-images me-2"></i>관전후기 관리</h2>
        <p>사용자들의 관전후기를 관리합니다.</p>
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
        <form method="GET" action="/admin/gallery/list" class="d-flex gap-2">
            <input type="hidden" name="page" value="0">
            <select name="searchType" class="form-select" style="width: auto;">
                <option value="all" ${searchType == 'all' ? 'selected' : ''}>전체</option>
                <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
                <option value="name" ${searchType == 'name' ? 'selected' : ''}>작성자</option>
            </select>
            <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="검색어를 입력하세요" style="width: 200px;">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-search me-1"></i>검색
            </button>
            <c:if test="${not empty keyword}">
                <a href="/admin/gallery/list" class="btn btn-secondary">
                    <i class="fas fa-times me-1"></i>초기화
                </a>
            </c:if>
        </form>
        
        <!-- 등록 버튼 -->
        <a href="/admin/gallery/register" class="btn btn-success">
            <i class="fas fa-plus me-1"></i>새 관전후기 등록
        </a>
    </div>
    
    <!-- Gallery 목록 테이블 -->
    <div class="table-responsive">
        <table class="table table-hover">
            <thead class="table-dark">
                <tr>
                    <th style="width: 80px;">번호</th>
                    <th style="width: 300px;">제목</th>
                    <th style="width: 120px;">작성자</th>
                    <th style="width: 120px;">등록일</th>
                    <th style="width: 100px;">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty galleries}">
                        <tr>
                            <td colspan="5" class="text-center py-4">
                                <i class="fas fa-inbox fa-2x text-muted mb-2"></i>
                                <p class="text-muted">등록된 관전후기가 없습니다.</p>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="gallery" items="${galleries}" varStatus="status">
                            <tr>
                                <td class="text-center">${totalItems - (currentPage * 10) - status.index}</td>
                                <td>
                                    <a href="/admin/gallery/view/${gallery.uid}" class="text-decoration-none">
                                        <i class="fas fa-image me-1 text-primary"></i>
                                        ${gallery.title}
                                    </a>
                                </td>
                                <td class="text-center">${gallery.name}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${gallery.regdate != null}">
                                            ${gallery.regdate}
                                        </c:when>
                                        <c:when test="${gallery.createdAt != null}">
                                            ${gallery.createdAt}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">-</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <div class="btn-group btn-group-sm" role="group">
                                        <a href="/admin/gallery/view/${gallery.uid}" class="btn btn-outline-primary" title="상세보기">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="/admin/gallery/edit/${gallery.uid}" class="btn btn-outline-warning" title="수정">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <button type="button" class="btn btn-outline-danger" title="삭제" 
                                                onclick="deleteGallery(${gallery.uid}, '${gallery.title}')">
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
    <c:if test="${totalPages > 1}">
        <nav aria-label="Gallery 페이지 네비게이션">
            <ul class="pagination justify-content-center">
                <!-- 이전 페이지 -->
                <li class="page-item ${hasPrevious ? '' : 'disabled'}">
                    <a class="page-link" href="/admin/gallery/list?page=${currentPage - 1}&searchType=${searchType}&keyword=${keyword}">
                        <i class="fas fa-chevron-left"></i>
                    </a>
                </li>
                
                <!-- 페이지 번호 (최대 10개, 현재 페이지 중앙 배치) -->
                <c:set var="startPage" value="0" />
                <c:set var="endPage" value="${totalPages - 1}" />
                
                <c:if test="${totalPages > 10}">
                    <c:set var="halfDisplay" value="5" />
                    <c:set var="startPage" value="${currentPage - halfDisplay}" />
                    <c:set var="endPage" value="${currentPage + halfDisplay}" />
                    
                    <c:if test="${startPage < 0}">
                        <c:set var="startPage" value="0" />
                        <c:set var="endPage" value="9" />
                    </c:if>
                    
                    <c:if test="${endPage >= totalPages}">
                        <c:set var="endPage" value="${totalPages - 1}" />
                        <c:set var="startPage" value="${endPage - 9}" />
                        <c:if test="${startPage < 0}">
                            <c:set var="startPage" value="0" />
                        </c:if>
                    </c:if>
                </c:if>
                
                <!-- 첫 페이지로 이동 (생략 표시) -->
                <c:if test="${startPage > 0}">
                    <li class="page-item">
                        <a class="page-link" href="/admin/gallery/list?page=0&searchType=${searchType}&keyword=${keyword}">1</a>
                    </li>
                    <c:if test="${startPage > 1}">
                        <li class="page-item disabled">
                            <span class="page-link">...</span>
                        </li>
                    </c:if>
                </c:if>
                
                <!-- 페이지 번호들 -->
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                    <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                        <a class="page-link" href="/admin/gallery/list?page=${pageNum}&searchType=${searchType}&keyword=${keyword}">
                            ${pageNum + 1}
                        </a>
                    </li>
                </c:forEach>
                
                <!-- 마지막 페이지로 이동 (생략 표시) -->
                <c:if test="${endPage < totalPages - 1}">
                    <c:if test="${endPage < totalPages - 2}">
                        <li class="page-item disabled">
                            <span class="page-link">...</span>
                        </li>
                    </c:if>
                    <li class="page-item">
                        <a class="page-link" href="/admin/gallery/list?page=${totalPages - 1}&searchType=${searchType}&keyword=${keyword}">${totalPages}</a>
                    </li>
                </c:if>
                
                <!-- 다음 페이지 -->
                <li class="page-item ${hasNext ? '' : 'disabled'}">
                    <a class="page-link" href="/admin/gallery/list?page=${currentPage + 1}&searchType=${searchType}&keyword=${keyword}">
                        <i class="fas fa-chevron-right"></i>
                    </a>
                </li>
            </ul>
        </nav>
        
        <!-- 페이지 정보 -->
        <div class="text-center text-muted">
            총 ${totalItems}개의 관전후기 중 ${(currentPage * 10) + 1} - ${Math.min((currentPage + 1) * 10, totalItems)}번째
        </div>
    </c:if>
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