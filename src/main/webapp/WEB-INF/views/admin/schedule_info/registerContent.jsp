<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-plus-circle me-2"></i>새 일정표 등록</h2>
        <p>축구 경기 일정을 등록해주세요.</p>
    </div>
    
    <!-- 알림 메시지 -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i>${error}
        </div>
    </c:if>
    
    <form method="POST" action="/admin/schedule_info/register" id="scheduleInfoForm" enctype="multipart/form-data">
        <div class="row">
            <!-- 경기분류 -->
            <div class="col-md-6 mb-3">
                <label for="gameCategory" class="form-group label">
                    <i class="fas fa-trophy me-1"></i>경기분류
                </label>
                <select class="form-control" id="gameCategory" name="gameCategory" required>
                    <option value="">경기분류를 선택하세요</option>
                    <option value="UEFA 챔스">UEFA 챔스</option>
                    <option value="UEFA 컵">UEFA 컵</option>
                    <option value="FA컵">FA컵</option>
                    <option value="리그컵">리그컵</option>
                    <option value="커뮤니티 쉴드">커뮤니티 쉴드</option>
                    <option value="A 매치">A 매치</option>
                    <option value="기타">기타</option>
                </select>
                <div class="text-muted mt-1">경기의 종류를 선택하세요.</div>
            </div>
            
            <!-- 홈팀구장명 -->
            <div class="col-md-6 mb-3">
                <label for="homeStadium" class="form-group label">
                    <i class="fas fa-building me-1"></i>홈팀구장명
                </label>
                <input type="text" class="form-control" id="homeStadium" name="homeStadium" 
                       placeholder="예: Old Trafford, Santiago Bernabéu" required>
                <div class="text-muted mt-1">홈팀의 경기장명을 입력하세요.</div>
            </div>
            
            <!-- 홈팀 카테고리 -->
            <div class="col-md-6 mb-3">
                <label for="homeCategory" class="form-group label">
                    <i class="fas fa-home me-1"></i>홈팀 카테고리
                </label>
                <select class="form-control" id="homeCategory" name="homeCategory" required>
                    <option value="">카테고리를 선택하세요</option>
                </select>
                <div class="text-muted mt-1">홈팀이 속한 카테고리를 선택하세요.</div>
            </div>
            
            <!-- 홈팀 -->
            <div class="col-md-6 mb-3">
                <label for="homeTeam" class="form-group label">
                    <i class="fas fa-shield-alt me-1"></i>홈팀
                </label>
                <select class="form-control" id="homeTeam" name="homeTeam" required>
                    <option value="">홈팀을 선택하세요</option>
                </select>
                <div class="text-muted mt-1">홈팀을 선택하세요.</div>
            </div>
            
            <!-- 원정팀 카테고리 -->
            <div class="col-md-6 mb-3">
                <label for="awayCategory" class="form-group label">
                    <i class="fas fa-plane me-1"></i>원정팀 카테고리
                </label>
                <select class="form-control" id="awayCategory" name="otherCategory" required>
                    <option value="">카테고리를 선택하세요</option>
                </select>
                <div class="text-muted mt-1">원정팀이 속한 카테고리를 선택하세요.</div>
            </div>
            
            <!-- 원정팀 -->
            <div class="col-md-6 mb-3">
                <label for="awayTeam" class="form-group label">
                    <i class="fas fa-shield-alt me-1"></i>원정팀
                </label>
                <select class="form-control" id="awayTeam" name="otherTeam" required>
                    <option value="">원정팀을 선택하세요</option>
                </select>
                <div class="text-muted mt-1">원정팀을 선택하세요.</div>
            </div>
            
            <!-- 경기날짜 -->
            <div class="col-md-6 mb-3">
                <label for="gameDate" class="form-group label">
                    <i class="fas fa-calendar me-1"></i>경기날짜
                </label>
                <input type="date" class="form-control" id="gameDate" name="gameDate" required>
                <div class="text-muted mt-1">경기가 열리는 날짜를 선택하세요.</div>
            </div>
            
            <!-- 경기시각 -->
            <div class="col-md-6 mb-3">
                <label for="gameTime" class="form-group label">
                    <i class="fas fa-clock me-1"></i>경기시각
                </label>
                <input type="text" class="form-control" id="gameTime" name="gameTime" 
                       placeholder="예: 19:00" maxlength="5" required>
                <div class="text-muted mt-1">경기 시작 시간을 입력하세요. (HH:MM 형식)</div>
            </div>
            
            <!-- 요금선택 -->
            <div class="col-12 mb-3">
                <label for="fee" class="form-group label">
                    <i class="fas fa-money-bill-wave me-1"></i>요금선택
                </label>
                <select class="form-control" id="fee" name="fee" required>
                    <option value="">요금 정보를 선택하세요</option>
                    <c:forEach var="fee" items="${seatFeeList}">
                        <option value="${fee.uid}">${fee.seatName} | ORANGE: ${fee.orange}원 | YELLOW: ${fee.yellow}원 | GREEN: ${fee.green}원 | BLUE: ${fee.blue}원 | PURPLE: ${fee.purple}원 | RED: ${fee.red}원 | BLACK: ${fee.black}원</option>
                    </c:forEach>
                </select>
                <div class="text-muted mt-1">경기에 적용할 좌석 요금 정보를 선택하세요.</div>
            </div>
            
            <!-- 요금정보 추가 -->
            <div class="col-12 mb-3">
                <label class="form-group label">
                    <i class="fas fa-plus-circle me-1"></i>요금정보 추가 (선택사항)
                </label>
                <div class="row">
                    <div class="col-md-3 col-6 mb-2">
                        <label class="form-label small text-muted">
                            <span class="color-badge orange-bg"></span>ORANGE
                        </label>
                        <div class="input-group">
                            <input type="number" name="orange" class="form-control" placeholder="가격 입력" min="0">
                            <span class="input-group-text">원</span>
                        </div>
                    </div>
                    <div class="col-md-3 col-6 mb-2">
                        <label class="form-label small text-muted">
                            <span class="color-badge yellow-bg"></span>YELLOW
                        </label>
                        <div class="input-group">
                            <input type="number" name="yellow" class="form-control" placeholder="가격 입력" min="0">
                            <span class="input-group-text">원</span>
                        </div>
                    </div>
                    <div class="col-md-3 col-6 mb-2">
                        <label class="form-label small text-muted">
                            <span class="color-badge green-bg"></span>GREEN
                        </label>
                        <div class="input-group">
                            <input type="number" name="green" class="form-control" placeholder="가격 입력" min="0">
                            <span class="input-group-text">원</span>
                        </div>
                    </div>
                    <div class="col-md-3 col-6 mb-2">
                        <label class="form-label small text-muted">
                            <span class="color-badge blue-bg"></span>BLUE
                        </label>
                        <div class="input-group">
                            <input type="number" name="blue" class="form-control" placeholder="가격 입력" min="0">
                            <span class="input-group-text">원</span>
                        </div>
                    </div>
                    <div class="col-md-3 col-6 mb-2">
                        <label class="form-label small text-muted">
                            <span class="color-badge purple-bg"></span>PURPLE
                        </label>
                        <div class="input-group">
                            <input type="number" name="purple" class="form-control" placeholder="가격 입력" min="0">
                            <span class="input-group-text">원</span>
                        </div>
                    </div>
                    <div class="col-md-3 col-6 mb-2">
                        <label class="form-label small text-muted">
                            <span class="color-badge red-bg"></span>RED
                        </label>
                        <div class="input-group">
                            <input type="number" name="red" class="form-control" placeholder="가격 입력" min="0">
                            <span class="input-group-text">원</span>
                        </div>
                    </div>
                    <div class="col-md-3 col-6 mb-2">
                        <label class="form-label small text-muted">
                            <span class="color-badge black-bg"></span>BLACK
                        </label>
                        <div class="input-group">
                            <input type="number" name="black" class="form-control" placeholder="가격 입력" min="0">
                            <span class="input-group-text">원</span>
                        </div>
                    </div>
                </div>
                <div class="text-muted mt-1">추가 요금 정보가 필요한 경우 입력하세요. (기본 요금선택과 별도로 적용)</div>
            </div>
            
            <!-- 배치도 이미지 -->
            <div class="col-12 mb-3">
                <label for="seatImageFile" class="form-group label">
                    <i class="fas fa-image me-1"></i>배치도 이미지
                </label>
                
                <!-- 파일 입력 -->
                <input type="file" class="form-control" id="seatImageFile" name="seatImageFile" 
                       accept="image/*" onchange="previewImage(this)">
                
                <div class="text-muted mt-1">좌석 배치도 이미지를 업로드하세요. (JPG, PNG, GIF)</div>
                
                <!-- 이미지 미리보기 영역 -->
                <div id="imagePreview" class="mt-2">
                    <div class="border rounded p-3 text-center" style="min-height: 150px; background-color: #f8f9fa;">
                        <i class="fas fa-image fa-2x text-muted"></i>
                        <p class="text-muted mt-2">이미지를 선택하면 미리보기가 표시됩니다.</p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 버튼 그룹 -->
        <div class="d-flex justify-content-between mt-4">
            <a href="/admin/schedule_info/list" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-1"></i>목록으로 돌아가기
            </a>
            <div>
                <button type="reset" class="btn btn-secondary me-2">
                    <i class="fas fa-undo me-1"></i>초기화
                </button>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save me-1"></i>등록하기
                </button>
            </div>
        </div>
    </form>
</div>

<script>
    // 팀정보관리(team_info)에서 카테고리별 팀명 동적 처리
    var teamList = [];
    
    <c:if test="${not empty teamList}">
        teamList = [
            <c:forEach var="team" items="${teamList}" varStatus="status">
                {
                    "categoryName": "${team.categoryName}",
                    "teamName": "${team.teamName}"
                }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
    </c:if>
    
    // 카테고리별 팀명 동적 처리
    function updateTeamOptions(categorySelectId, teamSelectId) {
        var categorySelect = document.getElementById(categorySelectId);
        var teamSelect = document.getElementById(teamSelectId);
        var selectedCategory = categorySelect.value;
        
        // 팀 옵션 초기화
        teamSelect.innerHTML = '<option value="">팀을 선택하세요</option>';
        
        if (selectedCategory) {
            // 선택된 카테고리에 해당하는 팀들만 필터링
            var filteredTeams = teamList.filter(function(team) {
                return team.categoryName === selectedCategory;
            });
            
            // 필터링된 팀들을 옵션으로 추가
            filteredTeams.forEach(function(team) {
                var option = document.createElement('option');
                option.value = team.teamName;
                option.textContent = team.teamName;
                teamSelect.appendChild(option);
            });
        }
    }
    
    // 페이지 로드 시 카테고리 옵션 설정
    document.addEventListener('DOMContentLoaded', function() {
        // 고유한 카테고리 목록 추출
        var categories = [];
        teamList.forEach(function(team) {
            if (categories.indexOf(team.categoryName) === -1) {
                categories.push(team.categoryName);
            }
        });
        
        // 홈팀 카테고리 옵션 설정
        var homeCategorySelect = document.getElementById('homeCategory');
        categories.forEach(function(category) {
            var option = document.createElement('option');
            option.value = category;
            option.textContent = category;
            homeCategorySelect.appendChild(option);
        });
        
        // 원정팀 카테고리 옵션 설정
        var awayCategorySelect = document.getElementById('awayCategory');
        categories.forEach(function(category) {
            var option = document.createElement('option');
            option.value = category;
            option.textContent = category;
            awayCategorySelect.appendChild(option);
        });
        
        // 카테고리 변경 이벤트 리스너 설정
        homeCategorySelect.addEventListener('change', function() {
            updateTeamOptions('homeCategory', 'homeTeam');
        });
        
        awayCategorySelect.addEventListener('change', function() {
            updateTeamOptions('awayCategory', 'awayTeam');
        });
    });
    
    // 폼 유효성 검사
    document.getElementById('scheduleInfoForm').addEventListener('submit', function(e) {
        var gameTime = document.getElementById('gameTime').value;
        var timePattern = /^([01]?[0-9]|2[0-3]):[0-5][0-9]$/;
        
        if (!timePattern.test(gameTime)) {
            e.preventDefault();
            alert('경기시각은 HH:MM 형식으로 입력해주세요. (예: 19:00)');
            document.getElementById('gameTime').focus();
            return false;
        }
        
        // 홈팀과 원정팀이 같은지 확인
        var homeTeam = document.getElementById('homeTeam').value;
        var awayTeam = document.getElementById('awayTeam').value;
        
        if (homeTeam && awayTeam && homeTeam === awayTeam) {
            e.preventDefault();
            alert('홈팀과 원정팀은 서로 달라야 합니다.');
            return false;
        }
        
        // 경기날짜가 오늘 이후인지 확인
        var gameDate = document.getElementById('gameDate').value;
        var today = new Date().toISOString().split('T')[0];
        
        if (gameDate < today) {
            e.preventDefault();
            alert('경기날짜는 오늘 이후로 설정해주세요.');
            document.getElementById('gameDate').focus();
            return false;
        }
    });
    
    // 숫자 입력 필드에 천 단위 콤마 추가
    const numberInputs = document.querySelectorAll('input[type="number"]');
    numberInputs.forEach(input => {
        input.addEventListener('blur', function() {
            if (this.value) {
                this.value = parseInt(this.value).toLocaleString();
            }
        });
        
        input.addEventListener('focus', function() {
            this.value = this.value.replace(/,/g, '');
        });
    });
    
    // 이미지 미리보기 함수
    function previewImage(input) {
        var preview = document.getElementById('imagePreview');
        var file = input.files[0];
        
        if (file) {
            // 파일 타입 검증
            if (!file.type.startsWith('image/')) {
                alert('이미지 파일만 선택할 수 있습니다.');
                input.value = '';
                preview.innerHTML = '<div class="border rounded p-3 text-center" style="min-height: 150px; background-color: #f8f9fa;"><i class="fas fa-image fa-2x text-muted"></i><p class="text-muted mt-2">이미지를 선택하면 미리보기가 표시됩니다.</p></div>';
                return;
            }
            
            // 파일 크기 검증 (5MB)
            if (file.size > 5 * 1024 * 1024) {
                alert('파일 크기는 5MB 이하여야 합니다.');
                input.value = '';
                preview.innerHTML = '<div class="border rounded p-3 text-center" style="min-height: 150px; background-color: #f8f9fa;"><i class="fas fa-image fa-2x text-muted"></i><p class="text-muted mt-2">이미지를 선택하면 미리보기가 표시됩니다.</p></div>';
                return;
            }
            
            var reader = new FileReader();
            reader.onload = function(e) {
                preview.innerHTML = '<img src="' + e.target.result + '" class="img-fluid" style="max-height: 150px;"><p class="text-muted mt-2">이미지 미리보기</p>';
            };
            reader.readAsDataURL(file);
        } else {
            preview.innerHTML = '<div class="border rounded p-3 text-center" style="min-height: 150px; background-color: #f8f9fa;"><i class="fas fa-image fa-2x text-muted"></i><p class="text-muted mt-2">이미지를 선택하면 미리보기가 표시됩니다.</p></div>';
        }
    }
</script> 