<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-edit me-2"></i>팀정보 수정</h2>
        <p>팀정보를 수정해주세요.</p>
    </div>
    
    <!-- 알림 메시지 -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i>${error}
        </div>
    </c:if>
    
    <form method="POST" action="/admin/team_info/edit" id="teamInfoForm" enctype="multipart/form-data">
        <input type="hidden" name="uid" value="${teamInfo.uid}">
        
        <div class="row">
            <!-- 팀구단명 -->
            <div class="col-12 mb-3">
                <label for="teamName" class="form-group label">
                    <i class="fas fa-shield-alt me-1"></i>팀구단명
                </label>
                <input type="text" class="form-control" id="teamName" name="teamName" 
                       value="${teamInfo.teamName}" placeholder="예: Manchester United, Real Madrid" required>
                <div class="text-muted mt-1">팀의 공식 명칭을 입력해주세요.</div>
            </div>
            
            <!-- 카테고리 분류 -->
            <div class="col-md-6 mb-3">
                <label for="categoryName" class="form-group label">
                    <i class="fas fa-tags me-1"></i>카테고리 분류
                </label>
                <select class="form-control" id="categoryName" name="categoryName" required>
                    <option value="">카테고리를 선택하세요</option>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category}" ${teamInfo.categoryName == category ? 'selected' : ''}>${category}</option>
                    </c:forEach>
                </select>
                <div class="text-muted mt-1">팀이 속한 리그나 카테고리를 선택하세요.</div>
            </div>
            
            <!-- 경기장명 -->
            <div class="col-md-6 mb-3">
                <label for="stadium" class="form-group label">
                    <i class="fas fa-building me-1"></i>경기장명
                </label>
                <input type="text" class="form-control" id="stadium" name="stadium" 
                       value="${teamInfo.stadium}" placeholder="예: Old Trafford, Santiago Bernabéu">
                <div class="text-muted mt-1">팀의 홈 경기장명을 입력하세요.</div>
            </div>
            
            <!-- 도시명 -->
            <div class="col-md-6 mb-3">
                <label for="city" class="form-group label">
                    <i class="fas fa-map-marker-alt me-1"></i>도시명
                </label>
                <input type="text" class="form-control" id="city" name="city" 
                       value="${teamInfo.city}" placeholder="예: Manchester, Madrid">
                <div class="text-muted mt-1">팀이 위치한 도시명을 입력하세요.</div>
            </div>
            
            <!-- 로고 이미지 -->
            <div class="col-md-6 mb-3">
                <label for="logoFile" class="form-group label">
                    <i class="fas fa-image me-1"></i>로고 이미지
                </label>
                <input type="file" class="form-control" id="logoFile" name="logoFile" 
                       accept="image/*">
                <div class="text-muted mt-1">팀 로고 이미지를 업로드하세요. (JPG, PNG, GIF)</div>
                <c:if test="${not empty teamInfo.logoImg}">
                    <div class="mt-2">
                        <small class="text-muted">현재 로고: ${teamInfo.logoImg}</small>
                    </div>
                </c:if>
            </div>
            
            <!-- 구장 좌석 이미지 -->
            <div class="col-12 mb-3">
                <label for="seatFile" class="form-group label">
                    <i class="fas fa-chair me-1"></i>구장 좌석 이미지
                </label>
                <input type="file" class="form-control" id="seatFile" name="seatFile" 
                       accept="image/*">
                <div class="text-muted mt-1">경기장 좌석 배치 이미지를 업로드하세요. (JPG, PNG, GIF)</div>
                <c:if test="${not empty teamInfo.seatImg}">
                    <div class="mt-2">
                        <small class="text-muted">현재 좌석 이미지: ${teamInfo.seatImg}</small>
                    </div>
                </c:if>
            </div>
            
            <!-- 내용 -->
            <div class="col-12 mb-3">
                <label for="content" class="form-group label">
                    <i class="fas fa-file-text me-1"></i>내용
                </label>
                <textarea class="form-control" id="content" name="content" rows="5" 
                          placeholder="팀에 대한 상세 정보를 입력하세요...">${teamInfo.content}</textarea>
                <div class="text-muted mt-1">팀에 대한 상세한 설명이나 정보를 입력하세요.</div>
            </div>
        </div>
        

        
        <!-- 버튼 그룹 -->
        <div class="d-flex justify-content-between mt-4">
            <a href="/admin/team_info/list" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-1"></i>목록으로 돌아가기
            </a>
            <div>
                <button type="reset" class="btn btn-secondary me-2">
                    <i class="fas fa-undo me-1"></i>원래대로
                </button>
                <button type="submit" class="btn btn-warning me-2">
                    <i class="fas fa-save me-1"></i>수정하기
                </button>
                <button type="button" class="btn btn-danger" onclick="deleteTeamInfo()">
                    <i class="fas fa-trash me-1"></i>삭제하기
                </button>
            </div>
        </div>
    </form>
</div>

<script>
    // 폼 유효성 검사
    document.getElementById('teamInfoForm').addEventListener('submit', function(e) {
        const teamName = document.getElementById('teamName').value.trim();
        const categoryName = document.getElementById('categoryName').value;
        
        if (teamName === '') {
            e.preventDefault();
            alert('팀구단명을 입력해주세요.');
            document.getElementById('teamName').focus();
            return false;
        }
        
        if (categoryName === '') {
            e.preventDefault();
            alert('카테고리 분류를 선택해주세요.');
            document.getElementById('categoryName').focus();
            return false;
        }
    });
    
    // 파일 업로드 미리보기 (선택사항)
    function previewImage(input, previewId) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const preview = document.getElementById(previewId);
                if (preview) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                }
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
    
    // 로고 이미지 미리보기
    document.getElementById('logoFile').addEventListener('change', function() {
        previewImage(this, 'logoPreview');
    });
    
    // 좌석 이미지 미리보기
    document.getElementById('seatFile').addEventListener('change', function() {
        previewImage(this, 'seatPreview');
    });
    
    // 팀정보 삭제 함수
    function deleteTeamInfo() {
        const teamName = '${teamInfo.teamName}';
        const uid = '${teamInfo.uid}';
        
        if (confirm(`정말로 "${teamName}" 팀정보를 삭제하시겠습니까?\n\n삭제된 데이터는 복구할 수 없습니다.`)) {
            // 삭제 확인 시 폼 생성하여 POST 요청
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '/admin/team_info/delete/' + uid;
            
            // CSRF 토큰이 있다면 추가
            const csrfToken = document.querySelector('meta[name="_csrf"]');
            if (csrfToken) {
                const csrfInput = document.createElement('input');
                csrfInput.type = 'hidden';
                csrfInput.name = '_csrf';
                csrfInput.value = csrfToken.getAttribute('content');
                form.appendChild(csrfInput);
            }
            
            document.body.appendChild(form);
            form.submit();
        }
    }
</script> 