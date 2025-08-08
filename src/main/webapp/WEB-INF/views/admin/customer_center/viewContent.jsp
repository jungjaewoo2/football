<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="newLine" value="\n" />

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-headset me-2"></i>고객센터 관리</h2>
        <p>고객센터 내용을 확인하고 수정할 수 있습니다.</p>
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
    
    <!-- 고객센터 내용 -->
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0">
                    <i class="fas fa-headset me-2"></i>고객센터 내용
                </h5>
                <div class="btn-group">
                    <a href="/admin/customer_center/edit" class="btn btn-light btn-sm">
                        <i class="fas fa-edit me-1"></i>수정
                    </a>
                </div>
            </div>
        </div>
        <div class="card-body">
            <div class="content-area">
                <c:choose>
                    <c:when test="${not empty customerCenter.content}">
                        <div class="ck-content">
                            ${fn:replace(customerCenter.content, newLine, '<br>')}
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-4">
                            <i class="fas fa-headset fa-2x text-muted mb-2"></i>
                            <p class="text-muted">등록된 고객센터 내용이 없습니다.</p>
                            <a href="/admin/customer_center/edit" class="btn btn-primary">
                                <i class="fas fa-plus me-1"></i>고객센터 내용 등록하기
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <!-- 하단 버튼 -->
    <div class="d-flex justify-content-between mt-4">
        <div>

        </div>
    </div>
</div>

<style>
    .content-area { min-height: 400px; padding: 20px; background-color: #f8f9fa; border-radius: 0.375rem; border: 1px solid #dee2e6; }
    .ck-content { line-height: 1.6; }
    .ck-content img { max-width: 100%; height: auto; border-radius: 0.375rem; margin: 10px 0; }
    
    /* 이미지 정렬 스타일 - CKEditor 5 실제 출력 형식 지원 */
    .ck-content img.image-style-align-center,
    .ck-content figure.image-style-align-center img,
    .ck-content .image-style-align-center img,
    .ck-content figure[class*="align-center"] img,
    .ck-content figure[class*="center"] img {
        display: block;
        margin: 10px auto;
        text-align: center;
    }
    
    .ck-content img.image-style-align-left,
    .ck-content figure.image-style-align-left img,
    .ck-content .image-style-align-left img,
    .ck-content figure[class*="align-left"] img,
    .ck-content figure[class*="left"] img {
        float: left;
        margin: 0 1rem 1rem 0;
    }
    
    .ck-content img.image-style-align-right,
    .ck-content figure.image-style-align-right img,
    .ck-content .image-style-align-right img,
    .ck-content figure[class*="align-right"] img,
    .ck-content figure[class*="right"] img {
        float: right;
        margin: 0 0 1rem 1rem;
    }
    
    .ck-content img.image-style-block,
    .ck-content figure.image-style-block img,
    .ck-content .image-style-block img {
        display: block;
        margin: 1rem 0;
    }
    
    .ck-content img.image-style-side,
    .ck-content figure.image-style-side img,
    .ck-content .image-style-side img {
        float: right;
        margin: 0 0 1rem 1rem;
        max-width: 50%;
    }
    
    /* figure 요소 정렬 스타일 */
    .ck-content figure.image-style-align-center,
    .ck-content figure[class*="align-center"],
    .ck-content figure[class*="center"] {
        text-align: center;
        display: block;
    }
    
    .ck-content figure.image-style-align-left,
    .ck-content figure[class*="align-left"],
    .ck-content figure[class*="left"] {
        float: left;
        margin: 0 1rem 1rem 0;
    }
    
    .ck-content figure.image-style-align-right,
    .ck-content figure[class*="align-right"],
    .ck-content figure[class*="right"] {
        float: right;
        margin: 0 0 1rem 1rem;
    }
    
    /* 이미지 컨테이너 정리 */
    .ck-content figure {
        margin: 1rem 0;
    }
    
    .ck-content figure img {
        max-width: 100%;
        height: auto;
    }
    
    /* 추가: CKEditor 5의 새로운 클래스명 지원 */
    .ck-content .image {
        margin: 1rem 0;
    }
    
    .ck-content .image.image-style-align-center,
    .ck-content .image[class*="align-center"],
    .ck-content .image[class*="center"] {
        text-align: center;
    }
    
    .ck-content .image.image-style-align-center img,
    .ck-content .image[class*="align-center"] img,
    .ck-content .image[class*="center"] img {
        display: inline-block;
        margin: 0 auto;
    }
    
    .ck-content .image.image-style-align-left,
    .ck-content .image[class*="align-left"],
    .ck-content .image[class*="left"] {
        float: left;
        margin: 0 1rem 1rem 0;
    }
    
    .ck-content .image.image-style-align-right,
    .ck-content .image[class*="align-right"],
    .ck-content .image[class*="right"] {
        float: right;
        margin: 0 0 1rem 1rem;
    }
    
    /* 추가: CKEditor 5의 실제 클래스명 패턴 지원 */
    .ck-content [class*="align-center"],
    .ck-content [class*="center"] {
        text-align: center;
    }
    
    .ck-content [class*="align-left"],
    .ck-content [class*="left"] {
        float: left;
        margin: 0 1rem 1rem 0;
    }
    
    .ck-content [class*="align-right"],
    .ck-content [class*="right"] {
        float: right;
        margin: 0 0 1rem 1rem;
    }
    .ck-content h1, .ck-content h2, .ck-content h3, .ck-content h4, .ck-content h5, .ck-content h6 { margin-top: 1.5rem; margin-bottom: 1rem; color: #333; }
    .ck-content p { margin-bottom: 1rem; }
    .ck-content ul, .ck-content ol { margin-bottom: 1rem; padding-left: 2rem; }
    .ck-content blockquote { border-left: 4px solid #007bff; padding-left: 1rem; margin: 1rem 0; font-style: italic; color: #666; }
    .ck-content table { width: 100%; border-collapse: collapse; margin: 1rem 0; }
    .ck-content table th, .ck-content table td { border: 1px solid #dee2e6; padding: 0.75rem; text-align: left; }
    .ck-content table th { background-color: #f8f9fa; font-weight: bold; }
    </style> 