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
            
            <!-- ORANGE -->
            <div class="col-md-6 mb-3">
                <label for="orange" class="form-group label">
                    <span class="color-badge orange-bg"></span>ORANGE 요금
                </label>
                <div class="input-group">
                    <input type="number" class="form-control" id="orange" name="orange" 
                           value="${seatFee.orange}" placeholder="0" min="0" required>
                    <span class="input-group-text">원</span>
                </div>
            </div>
            
            <!-- YELLOW -->
            <div class="col-md-6 mb-3">
                <label for="yellow" class="form-group label">
                    <span class="color-badge yellow-bg"></span>YELLOW 요금
                </label>
                <div class="input-group">
                    <input type="number" class="form-control" id="yellow" name="yellow" 
                           value="${seatFee.yellow}" placeholder="0" min="0" required>
                    <span class="input-group-text">원</span>
                </div>
            </div>
            
            <!-- GREEN -->
            <div class="col-md-6 mb-3">
                <label for="green" class="form-group label">
                    <span class="color-badge green-bg"></span>GREEN 요금
                </label>
                <div class="input-group">
                    <input type="number" class="form-control" id="green" name="green" 
                           value="${seatFee.green}" placeholder="0" min="0" required>
                    <span class="input-group-text">원</span>
                </div>
            </div>
            
            <!-- BLUE -->
            <div class="col-md-6 mb-3">
                <label for="blue" class="form-group label">
                    <span class="color-badge blue-bg"></span>BLUE 요금
                </label>
                <div class="input-group">
                    <input type="number" class="form-control" id="blue" name="blue" 
                           value="${seatFee.blue}" placeholder="0" min="0" required>
                    <span class="input-group-text">원</span>
                </div>
            </div>
            
            <!-- PURPLE -->
            <div class="col-md-6 mb-3">
                <label for="purple" class="form-group label">
                    <span class="color-badge purple-bg"></span>PURPLE 요금
                </label>
                <div class="input-group">
                    <input type="number" class="form-control" id="purple" name="purple" 
                           value="${seatFee.purple}" placeholder="0" min="0" required>
                    <span class="input-group-text">원</span>
                </div>
            </div>
            
            <!-- RED -->
            <div class="col-md-6 mb-3">
                <label for="red" class="form-group label">
                    <span class="color-badge red-bg"></span>RED 요금
                </label>
                <div class="input-group">
                    <input type="number" class="form-control" id="red" name="red" 
                           value="${seatFee.red}" placeholder="0" min="0" required>
                    <span class="input-group-text">원</span>
                </div>
            </div>
            
            <!-- BLACK -->
            <div class="col-md-6 mb-3">
                <label for="black" class="form-group label">
                    <span class="color-badge black-bg"></span>BLACK 요금
                </label>
                <div class="input-group">
                    <input type="number" class="form-control" id="black" name="black" 
                           value="${seatFee.black}" placeholder="0" min="0" required>
                    <span class="input-group-text">원</span>
                </div>
            </div>
        </div>
        
        <!-- 수정 정보 -->
        <div class="alert alert-info">
            <i class="fas fa-info-circle me-2"></i>
            <strong>수정 정보:</strong> 
            등록일: ${seatFee.createdAt}, 
            마지막 수정일: ${seatFee.updatedAt}
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
        
        // 모든 요금이 0인지 확인
        const fees = ['orange', 'yellow', 'green', 'blue', 'purple', 'red', 'black'];
        let allZero = true;
        
        fees.forEach(fee => {
            if (parseInt(document.getElementById(fee).value) > 0) {
                allZero = false;
            }
        });
        
        if (allZero) {
            e.preventDefault();
            alert('최소 하나의 요금은 0보다 큰 값을 입력해주세요.');
            return false;
        }
    });
    
    // 숫자 입력 필드 유효성 검사 (음수 방지)
    const numberInputs = document.querySelectorAll('input[type="number"]');
    numberInputs.forEach(input => {
        input.addEventListener('input', function() {
            // 음수 입력 방지
            if (this.value < 0) {
                this.value = 0;
            }
        });
    });
</script> 