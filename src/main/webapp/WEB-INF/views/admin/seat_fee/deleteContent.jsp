<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-exclamation-triangle me-2"></i>좌석요금 삭제 확인</h2>
        <p>삭제할 좌석요금을 확인하고 삭제를 진행해주세요.</p>
    </div>
    
    <!-- 알림 메시지 -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i>${error}
        </div>
    </c:if>
    
    <!-- 경고 메시지 -->
    <div class="alert alert-warning">
        <h5 class="alert-heading">
            <i class="fas fa-exclamation-triangle me-2"></i>삭제 전 확인사항
        </h5>
        <p class="mb-0">
            아래 좌석요금을 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.
        </p>
    </div>
    
    <!-- 삭제할 좌석요금 정보 -->
    <div class="card mb-4">
        <div class="card-header">
            <h5 class="mb-0">
                <i class="fas fa-info-circle me-2"></i>삭제할 좌석요금 정보
            </h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <p><strong>번호:</strong> ${seatFee.uid}</p>
                    <p><strong>좌석요금명:</strong> ${seatFee.seatName}</p>
                </div>
                <div class="col-md-6">
                    <p><strong>등록일:</strong> ${seatFee.createdAt}</p>
                    <p><strong>수정일:</strong> ${seatFee.updatedAt}</p>
                </div>
            </div>
            


        </div>
    </div>
    
    <!-- 삭제 확인 폼 -->
    <form method="POST" action="/admin/seat_fee/delete/${seatFee.uid}" id="deleteForm">
        
        <!-- 버튼 그룹 -->
        <div class="d-flex justify-content-between">
            <a href="/admin/seat_fee/list" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-1"></i>목록으로 돌아가기
            </a>
            <div>
                <a href="/admin/seat_fee/edit/${seatFee.uid}" class="btn btn-primary me-2">
                    <i class="fas fa-edit me-1"></i>수정하기
                </a>
                <button type="submit" class="btn btn-danger" id="deleteBtn">
                    <i class="fas fa-trash me-1"></i>삭제하기
                </button>
            </div>
        </div>
    </form>
</div>

<script>
    // 삭제 폼 제출 시 최종 확인
    document.getElementById('deleteForm').addEventListener('submit', function(e) {
        if (!confirm('정말로 이 좌석요금을 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.')) {
            e.preventDefault();
            return false;
        }
    });
</script> 