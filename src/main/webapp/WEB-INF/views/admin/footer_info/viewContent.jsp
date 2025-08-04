<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-copyright me-2"></i>카피라이터 관리</h2>
        <p>연락처 정보를 확인하고 수정할 수 있습니다.</p>
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
                    <i class="fas fa-copyright me-2"></i>연락처 정보
                </h5>
                <div class="btn-group">
                    <a href="/admin/footer_info/edit" class="btn btn-light btn-sm">
                        <i class="fas fa-edit me-1"></i>수정
                    </a>
                </div>
            </div>
        </div>
        <div class="card-body">
            <div class="content-area">
                <c:choose>
                    <c:when test="${not empty footerInfo.phone or not empty footerInfo.email or not empty footerInfo.address}">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="info-item">
                                    <h6><i class="fas fa-phone me-2"></i>전화번호</h6>
                                    <p class="info-value">${footerInfo.phone}</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-item">
                                    <h6><i class="fas fa-envelope me-2"></i>이메일</h6>
                                    <p class="info-value">${footerInfo.email}</p>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="info-item">
                                    <h6><i class="fas fa-map-marker-alt me-2"></i>주소</h6>
                                    <p class="info-value">${footerInfo.address}</p>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-4">
                            <i class="fas fa-copyright fa-2x text-muted mb-2"></i>
                            <p class="text-muted">등록된 연락처 정보가 없습니다.</p>
                            <a href="/admin/footer_info/edit" class="btn btn-primary">
                                <i class="fas fa-plus me-1"></i>연락처 정보 등록하기
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
.info-item { margin-bottom: 20px; }
.info-item h6 { color: #495057; font-weight: 600; margin-bottom: 8px; }
.info-value { font-size: 1.1rem; color: #333; margin: 0; padding: 10px; background-color: #fff; border-radius: 0.375rem; border: 1px solid #dee2e6; }
</style> 