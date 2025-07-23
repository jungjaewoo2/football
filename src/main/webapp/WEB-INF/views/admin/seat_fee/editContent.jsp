<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-edit me-2"></i>좌석요금 수정</h2>
        <p>좌석요금 정보를 수정해주세요.</p>
    </div>
    
    <!-- 알림 메시지 -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i>${error}
        </div>
    </c:if>
    
    <form method="POST" action="/admin/seat_fee/edit" id="seatFeeForm">
        <input type="hidden" name="uid" value="${seatFee.uid}">
        <input type="hidden" name="seatPrice" id="seatPriceInput" value="${seatFee.seatPrice}">
        
        <div class="row">
            <!-- 좌석요금명 (팀 선택) -->
            <div class="col-12 mb-3">
                <label for="seatName" class="form-group label">
                    <i class="fas fa-chair me-1"></i>팀 선택
                </label>
                <select class="form-control" id="seatName" name="seatName" required>
                    <option value="">팀을 선택해주세요</option>
                    <c:forEach var="team" items="${teamList}">
                        <option value="${team.teamName}" ${seatFee.seatName == team.teamName ? 'selected' : ''}>${team.teamName}</option>
                    </c:forEach>
                </select>
                <div class="text-muted mt-1">좌석요금을 설정할 팀을 선택해주세요.</div>
            </div>
            
            <!-- 좌석명/금액 동적 추가 영역 -->
            <div class="col-12 mb-3">
                <label class="form-group label">
                    <i class="fas fa-plus-circle me-1"></i>좌석명/금액 추가
                </label>
                <!-- 디버깅 정보 -->
                <c:if test="${not empty seatFee.seatPrice}">
                    <div class="alert alert-info">
                        <small>저장된 데이터: ${seatFee.seatPrice}</small>
                    </div>
                </c:if>
                <div id="dynamicFeeRows">
                    <!-- 컨트롤러에서 미리 처리된 데이터 표시 -->
                    <c:forEach var="item" items="${seatPriceItems}">
                        <div class="row mb-2">
                            <div class="col-md-4 mb-2">
                                <input type="text" name="seatNames[]" class="form-control" value="${item.seatName}" required>
                            </div>
                            <div class="col-md-4 mb-2">
                                <input type="number" name="seatPrices[]" class="form-control" value="${item.price}" min="0" required>
                            </div>
                            <div class="col-md-2 mb-2 d-flex align-items-center">
                                <button type="button" class="btn btn-danger btn-sm" onclick="this.parentNode.parentNode.remove()">삭제</button>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <button type="button" class="btn btn-success btn-sm mt-2" onclick="addFeeRow()">+ 좌석/금액 추가</button>
                <div class="text-muted mt-1">좌석명과 금액을 자유롭게 추가할 수 있습니다.</div>
            </div>
            

            
        </div>
        

        
        <!-- 버튼 그룹 -->
        <div class="d-flex justify-content-between mt-4">
            <a href="/admin/seat_fee/list" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-1"></i>목록으로 돌아가기
            </a>
            <div>
                <button type="reset" class="btn btn-secondary me-2">
                    <i class="fas fa-undo me-1"></i>원래대로
                </button>
                <button type="submit" class="btn btn-warning">
                    <i class="fas fa-save me-1"></i>수정하기
                </button>
            </div>
        </div>
    </form>
</div>

<script>
    // 폼 유효성 검사
    document.getElementById('seatFeeForm').addEventListener('submit', function(e) {
        const seatName = document.getElementById('seatName').value;
        
        if (seatName === '') {
            e.preventDefault();
            alert('팀을 선택해주세요.');
            document.getElementById('seatName').focus();
            return false;
        }
        
        // 동적으로 추가된 좌석명/금액을 hidden 필드에 저장
        const seatNames = document.querySelectorAll('input[name="seatNames[]"]');
        const seatPrices = document.querySelectorAll('input[name="seatPrices[]"]');
        let seatPriceData = [];
        
        for (let i = 0; i < seatNames.length; i++) {
            const name = seatNames[i].value.trim();
            const price = seatPrices[i].value.trim();
            if (name && price) {
                seatPriceData.push(name + ':' + price);
            }
        }
        
        document.getElementById('seatPriceInput').value = seatPriceData.join(',');
    });
    
    // 숫자 입력 필드 유효성 검사 (음수 방지)
    document.addEventListener('input', function(e) {
        if (e.target.type === 'number') {
            if (e.target.value < 0) {
                e.target.value = 0;
            }
        }
    });

    // 동적 좌석명/금액 추가 기능
    function addFeeRow() {
        var container = document.getElementById('dynamicFeeRows');
        var row = document.createElement('div');
        row.className = 'row mb-2';
        row.innerHTML = `
            <div class="col-md-4 mb-2">
                <input type="text" name="seatNames[]" class="form-control" placeholder="좌석명 입력" required>
            </div>
            <div class="col-md-4 mb-2">
                <input type="number" name="seatPrices[]" class="form-control" placeholder="금액 입력" min="0" required>
            </div>
            <div class="col-md-2 mb-2 d-flex align-items-center">
                <button type="button" class="btn btn-danger btn-sm" onclick="this.parentNode.parentNode.remove()">삭제</button>
            </div>
        `;
        container.appendChild(row);
    }
    
    // 디버깅용 로그
    console.log('SeatPrice Data from JSP: ${seatFee.seatPrice}');
</script> 