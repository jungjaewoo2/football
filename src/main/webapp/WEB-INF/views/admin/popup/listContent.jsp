<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-window-restore me-2"></i>팝업 관리</h2>
        <p>팝업을 등록, 수정, 삭제할 수 있습니다.</p>
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
    
    <!-- 등록 버튼 -->
    <div class="mb-3">
        <a href="/admin/popup/register" class="btn btn-primary">
            <i class="fas fa-plus me-1"></i>팝업 등록
        </a>
    </div>
    
    <!-- 팝업 목록 -->
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">
                <i class="fas fa-list me-2"></i>팝업 목록 (총 ${totalElements}개)
            </h5>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${empty popups}">
                    <div class="text-center py-4">
                        <i class="fas fa-window-restore fa-2x text-muted mb-2"></i>
                        <p class="text-muted">등록된 팝업이 없습니다.</p>
                        <a href="/admin/popup/register" class="btn btn-primary">
                            <i class="fas fa-plus me-1"></i>첫 번째 팝업 등록하기
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>팝업명</th>
                                    <th>이미지</th>
                                    <th>관리</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="popup" items="${popups}" varStatus="status">
                                    <tr>
                                        <td>${popup.uid}</td>
                                        <td>${popup.popupName}</td>
                                        <td>
                                            <c:if test="${not empty popup.img}">
                                                <img src="/uploads/popup/${popup.img}" 
                                                     alt="${popup.popupName}" 
                                                     style="max-width: 100px; max-height: 60px; object-fit: cover;">
                                            </c:if>
                                        </td>
                                        <td>
                                            <div class="btn-group">
                                                <a href="/admin/popup/edit/${popup.uid}" 
                                                   class="btn btn-warning btn-sm">
                                                    <i class="fas fa-edit"></i> 수정
                                                </a>
                                                <button type="button" 
                                                        class="btn btn-danger btn-sm"
                                                        onclick="deletePopup(${popup.uid}, '${popup.popupName}')">
                                                    <i class="fas fa-trash"></i> 삭제
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- 페이징 -->
                    <c:if test="${totalPages >= 1}">
                        <nav aria-label="팝업 페이지 네비게이션">
                            <ul class="pagination justify-content-center">
                                <!-- 처음 페이지 버튼 -->
                                <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                                    <a class="page-link" href="/admin/popup/list?page=0">
                                        <i class="fas fa-angle-double-left"></i>
                                    </a>
                                </li>
                                
                                <!-- 이전 페이지 버튼 -->
                                <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                                    <a class="page-link" href="/admin/popup/list?page=${currentPage - 1}">
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
                                        <a class="page-link" href="/admin/popup/list?page=${pageNum}">
                                            ${pageNum + 1}
                                        </a>
                                    </li>
                                </c:forEach>
                                
                                <!-- 다음 페이지 버튼 -->
                                <li class="page-item ${currentPage >= totalPages - 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="/admin/popup/list?page=${currentPage + 1}">
                                        <i class="fas fa-angle-right"></i>
                                    </a>
                                </li>
                                
                                <!-- 마지막 페이지 버튼 -->
                                <li class="page-item ${currentPage >= totalPages - 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="/admin/popup/list?page=${totalPages - 1}">
                                        <i class="fas fa-angle-double-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                        
                        <!-- 페이지 정보 -->
                        <div class="text-center text-muted">
                            총 ${totalElements}개의 팝업 중 ${(currentPage * 10) + 1} - ${Math.min((currentPage + 1) * 10, totalElements)}개 표시
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>
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
function deletePopup(uid, title) {
    document.getElementById('deleteTitle').textContent = title;
    document.getElementById('deleteForm').action = '/admin/popup/delete/' + uid;
    new bootstrap.Modal(document.getElementById('deleteModal')).show();
}
</script> 