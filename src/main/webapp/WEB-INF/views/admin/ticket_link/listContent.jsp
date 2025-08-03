<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="content-card">
    <div class="content-header">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h2>🎫 티켓바로가기 관리</h2>
                <p>티켓바로가기 정보를 관리하고 설정할 수 있습니다.</p>
            </div>
            <a href="/admin/ticket_link/register" class="btn btn-primary">
                <i class="fas fa-plus me-2"></i>새 티켓바로가기 등록
            </a>
        </div>
    </div>
    
    <!-- 알림 메시지 -->
    <c:if test="${not empty message}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle me-2"></i><c:out value="${message}"/>
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i><c:out value="${error}"/>
        </div>
    </c:if>
    
    <!-- 검색 폼 -->
    <form method="GET" action="/admin/ticket_link/list" class="mb-4">
        <input type="hidden" name="page" value="0">
        <div class="row">
            <div class="col-md-6">
                <div class="input-group">
                    <input type="text" class="form-control" name="search" 
                           placeholder="티켓명으로 검색..." value="<c:out value='${search}'/>">
                    <button class="btn btn-secondary" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>
        </div>
    </form>
    
    <!-- 티켓바로가기 목록 테이블 -->
    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th width="8%" class="text-center">번호</th>
                    <th width="20%" class="text-center">티켓 타이틀</th>
                    <th width="32%" class="text-center">티켓 서브타이틀</th>
                    <th width="15%" class="text-center">대표이미지</th>
                    <th width="15%" class="text-center">링크</th>
                    <th width="10%" class="text-center">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty ticketLinkList}">
                        <tr>
                            <td colspan="7" class="text-center py-4">
                                <i class="fas fa-ticket-alt fa-2x text-muted mb-2"></i>
                                <p class="text-muted">등록된 티켓바로가기가 없습니다.</p>
                                <p class="text-muted">새로운 티켓바로가기를 등록해보세요!</p>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="ticketLink" items="${ticketLinkList}" varStatus="status">
                            <tr>
                                <td class="text-center"><c:out value="${ticketLink.uid}"/></td>
                                <td class="text-center">
                                    <strong><c:out value="${ticketLink.ticketName}"/></strong>
                                </td>
                                <td class="text-center"><c:out value="${ticketLink.ticketSubTitle}"/></td>
                                <td class="text-center">
                                    <c:if test="${not empty ticketLink.ticketImg}">
                                        <img src="/uploads/ticket_link/${ticketLink.ticketImg}" 
                                             alt="티켓 이미지" style="max-width: 80px; max-height: 60px;">
                                    </c:if>
                                    <c:if test="${empty ticketLink.ticketImg}">
                                        <span class="text-muted">이미지 없음</span>
                                    </c:if>
                                </td>

                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${not empty ticketLink.link}">
                                            <a href="<c:out value='${ticketLink.link}'/>" 
                                               target="_blank" class="btn btn-sm btn-outline-info">
                                                <i class="fas fa-external-link-alt"></i> 링크
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">링크 없음</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <div class="btn-group" role="group">
                                        <a href="/admin/ticket_link/edit/<c:out value='${ticketLink.uid}'/>" 
                                           class="btn btn-sm btn-primary" 
                                           title="수정">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="/admin/ticket_link/delete/<c:out value='${ticketLink.uid}'/>" 
                                           class="btn btn-sm btn-danger" 
                                           title="삭제"
                                           onclick="return confirm('정말 삭제하시겠습니까?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
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
    <c:choose>
        <c:when test="${totalPages >= 1}">
            <nav aria-label="티켓바로가기 목록 페이지 네비게이션">
                <ul class="pagination justify-content-center">
                    <!-- 처음 페이지 버튼 -->
                    <li class="page-item <c:out value="${currentPage == 0 ? 'disabled' : ''}"/>">
                        <a class="page-link" href="/admin/ticket_link/list?page=0&search=<c:out value='${search}'/>">
                            <i class="fas fa-angle-double-left"></i>
                        </a>
                    </li>
                    
                    <!-- 이전 페이지 버튼 -->
                    <li class="page-item <c:out value="${currentPage == 0 ? 'disabled' : ''}"/>">
                        <a class="page-link" href="/admin/ticket_link/list?page=<c:out value='${currentPage - 1}'/>&search=<c:out value='${search}'/>">
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
                        <li class="page-item <c:out value="${pageNum == currentPage ? 'active' : ''}"/>">
                            <a class="page-link" href="/admin/ticket_link/list?page=<c:out value='${pageNum}'/>&search=<c:out value='${search}'/>">
                                <c:out value="${pageNum + 1}"/>
                            </a>
                        </li>
                    </c:forEach>
                    
                    <!-- 다음 페이지 버튼 -->
                    <li class="page-item <c:out value="${currentPage >= totalPages - 1 ? 'disabled' : ''}"/>">
                        <a class="page-link" href="/admin/ticket_link/list?page=<c:out value='${currentPage + 1}'/>&search=<c:out value='${search}'/>">
                            <i class="fas fa-angle-right"></i>
                        </a>
                    </li>
                    
                    <!-- 마지막 페이지 버튼 -->
                    <li class="page-item <c:out value="${currentPage >= totalPages - 1 ? 'disabled' : ''}"/>">
                        <a class="page-link" href="/admin/ticket_link/list?page=<c:out value='${totalPages - 1}'/>&search=<c:out value='${search}'/>">
                            <i class="fas fa-angle-double-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
            
            <!-- 페이지 정보 -->
            <div class="text-center text-muted">
                총 <c:out value="${totalItems}"/>개의 티켓바로가기 중 <c:out value="${(currentPage * 10) + 1}"/> - <c:out value="${Math.min((currentPage + 1) * 10, totalItems)}"/>개 표시
                <br>
                <small><i class="fas fa-sort-amount-down me-1"></i>ID 내림차순으로 정렬됩니다.</small>
            </div>
        </c:when>
        <c:otherwise>
            <!-- 데이터가 없을 때 표시할 정보 -->
            <div class="text-center text-muted">
                <p>현재 등록된 티켓바로가기가 없습니다.</p>
                <p>새로운 티켓바로가기를 등록해보세요!</p>
            </div>
        </c:otherwise>
    </c:choose>
</div> 