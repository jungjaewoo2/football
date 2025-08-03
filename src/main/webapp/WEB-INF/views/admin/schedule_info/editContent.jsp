<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-edit me-2"></i>일정표 수정</h2>
        <p>축구 경기 일정을 수정해주세요.</p>
    </div>
    
    <!-- 알림 메시지 -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i><c:out value="${error}"/>
        </div>
    </c:if>
    
    <form method="POST" action="/admin/schedule_info/edit/<c:out value='${scheduleInfo.uid}'/>" id="scheduleInfoForm">
        <!-- Hidden 필드들 삭제 (homeCategory, otherCategory) -->
        
        <div class="row">
            <!-- 참가대회종류 -->
            <div class="col-md-6 mb-3">
                <label for="gameCategory" class="form-group label">
                    <i class="fas fa-trophy me-1"></i>대회종류
                </label>
                <select class="form-control" id="gameCategory" name="gameCategory" required>
                    <option value="">대회종류를 선택하세요</option>
                    <option value="국내리그" <c:out value="${scheduleInfo.gameCategory == '국내리그' ? 'selected' : ''}"/>>국내리그</option>
                    <option value="리그컵" <c:out value="${scheduleInfo.gameCategory == '리그컵' ? 'selected' : ''}"/>>리그컵</option>
                    <option value="유럽대항전" <c:out value="${scheduleInfo.gameCategory == '유럽대항전' ? 'selected' : ''}"/>>유럽대항전</option>
                    <option value="국가대항전" <c:out value="${scheduleInfo.gameCategory == '국가대항전' ? 'selected' : ''}"/>>국가대항전</option>
                    <option value="친선경기" <c:out value="${scheduleInfo.gameCategory == '천선경기' ? 'selected' : ''}"/>>친선경기</option>
                </select>
                <div class="text-muted mt-1">경기가 속한 대회 종류를 선택하세요.</div>
            </div>
            
            <!-- 카테고리 -->
            <div class="col-md-6 mb-3">
                <label for="category" class="form-group label">
                    <i class="fas fa-tags me-1"></i>카테고리
                </label>
                <select class="form-control" id="category" name="category" required>
                    <option value="">카테고리를 선택하세요</option>
                    <option value="EPL_1" <c:out value="${scheduleInfo.category == 'EPL_1' ? 'selected' : ''}"/>>EPL (공식) 일정표</option>
                    <option value="EPL_2" <c:out value="${scheduleInfo.category == 'EPL_2' ? 'selected' : ''}"/>>EPL (대행) 일정표</option>
                    <option value="L.Liga" <c:out value="${scheduleInfo.category == 'L.Liga' ? 'selected' : ''}"/>>L Liga(공식) 일정표</option>
                    <option value="ETC" <c:out value="${scheduleInfo.category == 'ETC' ? 'selected' : ''}"/>>OET(공식) 일정표</option>
                </select>
                <div class="text-muted mt-1">경기가 속한 리그를 선택하세요.</div>
            </div>
            
            <!-- 홈팀구장명 -->
            <div class="col-md-6 mb-3">
                <label for="homeStadium" class="form-group label">
                    <i class="fas fa-building me-1"></i>홈팀구장명
                </label>
                <input type="text" class="form-control" id="homeStadium" name="homeStadium" 
                       value="<c:out value='${scheduleInfo.homeStadium}'/>" placeholder="예: Old Trafford, Santiago Bernabéu" required>
                <div class="text-muted mt-1">홈팀의 경기장명을 입력하세요.</div>
            </div>
            
            <!-- 홈팀 -->
            <div class="col-md-6 mb-3">
                <label for="homeTeam" class="form-group label">
                    <i class="fas fa-shield-alt me-1"></i>홈팀
                </label>
                <select class="form-control" id="homeTeam" name="homeTeam" required>
                    <option value="">홈팀을 선택하세요</option>
                    <%-- controller에서 teamList 전달 --%>
                    <c:forEach var="team" items="${teamList}">
                        <option value="<c:out value='${team.teamName}'/>" <c:out value="${scheduleInfo.homeTeam == team.teamName ? 'selected' : ''}"/>><c:out value="${team.teamName}"/></option>
                    </c:forEach>
                </select>
                <div class="text-muted mt-1">홈팀을 선택하세요.</div>
            </div>
            
            <!-- 원정팀 -->
            <div class="col-md-6 mb-3">
                <label for="otherTeam" class="form-group label">
                    <i class="fas fa-shield-alt me-1"></i>원정팀
                </label>
                <select class="form-control" id="otherTeam" name="otherTeam" required>
                    <option value="">원정팀을 선택하세요</option>
                    <c:forEach var="team" items="${teamList}">
                        <option value="<c:out value='${team.teamName}'/>" <c:out value="${scheduleInfo.otherTeam == team.teamName ? 'selected' : ''}"/>><c:out value="${team.teamName}"/></option>
                    </c:forEach>
                </select>
                <div class="text-muted mt-1">원정팀을 선택하세요.</div>
            </div>
            
            <!-- 경기날짜 -->
            <div class="col-md-6 mb-3">
                <label for="gameDate" class="form-group label">
                    <i class="fas fa-calendar me-1"></i>경기날짜
                </label>
                <input type="date" class="form-control" id="gameDate" name="gameDate" 
                       value="<c:out value='${scheduleInfo.gameDate}'/>" required>
                <div class="text-muted mt-1">경기가 열리는 날짜를 선택하세요.</div>
            </div>
            
            <!-- 경기시각 -->
            <div class="col-md-6 mb-3">
                <label for="gameTime" class="form-group label">
                    <i class="fas fa-clock me-1"></i>경기시각
                </label>
                <input type="text" class="form-control" id="gameTime" name="gameTime" 
                       value="<c:out value='${scheduleInfo.gameTime}'/>" placeholder="예: 19:00" maxlength="5" required>
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
                        <option value="<c:out value='${fee.uid}'/>" data-seat-price="<c:out value='${fee.seatPrice}'/>" <c:out value="${scheduleInfo.fee == fee.uid ? 'selected' : ''}"/>>
                            <c:out value="${fee.seatName}"/> - <c:out value="${fee.seatPrice}"/>
                        </option>
                    </c:forEach>
                </select>
                <input type="hidden" name="seatPrice" id="seatPriceHidden" value="<c:out value='${scheduleInfo.seatPrice}'/>">
                <div class="text-muted mt-1">경기에 적용할 좌석 요금 정보를 선택하세요.</div>
            </div>
            
            <!-- 선택된 요금 정보 표시 -->
            <div class="col-12 mb-3">
                <label class="form-group label">
                    <i class="fas fa-info-circle me-1"></i>선택된 요금 정보
                </label>
                <div id="selectedFeeInfo" class="alert alert-info" style="display: none;">
                    <div id="feeDetails"></div>
                </div>
                <input type="hidden" name="seatEtc" id="seatEtcHidden" value="<c:out value='${scheduleInfo.seatEtc}'/>">
            </div>
            
            <!-- 요금정보 추가 -->
            <div class="col-12 mb-3">
                <label class="form-group label">
                    <i class="fas fa-plus-circle me-1"></i>요금정보 추가 (선택사항)
                </label>
                <div id="dynamicFeeRows">
                    <%-- controller에서 seatPriceItems 전달 --%>
                    <c:forEach var="item" items="${seatPriceItems}">
                        <div class="row mb-2">
                            <div class="col-md-4 mb-2">
                                <input type="text" name="seatNames[]" class="form-control" value="<c:out value='${item.seatName}'/>" required>
                            </div>
                            <div class="col-md-4 mb-2">
                                <input type="text" name="seatPrices[]" class="form-control price-input" value="<c:out value='${item.price}'/>" required>
                            </div>
                            <div class="col-md-2 mb-2 d-flex align-items-center">
                                <button type="button" class="btn btn-danger btn-sm" onclick="removeFeeRow(this)">삭제</button>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <button type="button" class="btn btn-success btn-sm mt-2" id="addFeeRowBtn">+ 좌석/금액 추가</button>
                <div class="text-muted mt-1">좌석명과 금액을 자유롭게 추가할 수 있습니다.</div>
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
                <button type="submit" class="btn btn-success">
                    <i class="fas fa-save me-1"></i>수정하기
                </button>
            </div>
        </div>
    </form>
</div>

<script>
    // 전역 함수로 addFeeRow 정의
    function addFeeRow() {
        var container = document.getElementById('dynamicFeeRows');
        var row = document.createElement('div');
        row.className = 'row mb-2';
        row.innerHTML = 
            '<div class="col-md-4 mb-2">' +
                '<input type="text" name="seatNames[]" class="form-control" placeholder="좌석명 입력" required>' +
            '</div>' +
            '<div class="col-md-4 mb-2">' +
                '<input type="text" name="seatPrices[]" class="form-control price-input" placeholder="금액 입력" required>' +
            '</div>' +
            '<div class="col-md-2 mb-2 d-flex align-items-center">' +
                '<button type="button" class="btn btn-danger btn-sm" onclick="removeFeeRow(this)">삭제</button>' +
            '</div>';
        container.appendChild(row);
        
        // 새로 추가된 행의 가격 입력 필드에 이벤트 리스너 추가
        var newPriceInput = row.querySelector('input[name="seatPrices[]"]');
        setupPriceInputEvents(newPriceInput);
    }
    
    // 행 삭제 함수
    function removeFeeRow(button) {
        button.parentNode.parentNode.remove();
    }
    
    // 가격 입력 필드 이벤트 설정 함수
    function setupPriceInputEvents(input) {
        // 포커스 시 콤마 제거
        input.addEventListener('focus', function() {
            var value = this.value.replace(/,/g, '');
            this.value = value;
        });
        
        // 블러 시 콤마 추가 (값이 있을 때만)
        input.addEventListener('blur', function() {
            var value = this.value.replace(/,/g, '');
            if (value && !isNaN(value)) {
                this.value = parseInt(value).toLocaleString();
            }
        });
        
        // 입력 시 숫자만 허용
        input.addEventListener('input', function() {
            var value = this.value.replace(/[^0-9]/g, '');
            this.value = value;
        });
    }

    // 페이지 로드 시 초기화
    document.addEventListener('DOMContentLoaded', function() {
        var addFeeRowBtn = document.getElementById('addFeeRowBtn');
        if (addFeeRowBtn) {
            addFeeRowBtn.addEventListener('click', addFeeRow);
        }
        
        // 기존 행들의 가격 입력 필드에 이벤트 리스너 추가
        const existingPriceInputs = document.querySelectorAll('input[name="seatPrices[]"]');
        existingPriceInputs.forEach(setupPriceInputEvents);
    });

    // 홈팀 선택 시 구장명 자동 입력
    document.getElementById('homeTeam').addEventListener('change', function() {
        var selectedTeam = this.value;
        var homeStadiumInput = document.getElementById('homeStadium');
        var stadium = '';
        <c:forEach var="team" items="${teamList}">
            if(selectedTeam === "<c:out value='${team.teamName}'/>") stadium = "<c:out value='${team.stadium}'/>";
        </c:forEach>
        homeStadiumInput.value = stadium;
    });

    // 요금선택 시 seat_price hidden 필드에 값 저장
    document.getElementById('fee').addEventListener('change', function() {
        var selectedOption = this.options[this.selectedIndex];
        var seatPrice = selectedOption.getAttribute('data-seat-price');
        var feeDetails = document.getElementById('feeDetails');
        var selectedFeeInfo = document.getElementById('selectedFeeInfo');
        var seatPriceHidden = document.getElementById('seatPriceHidden');
        if (seatPrice && seatPrice.trim() !== '') {
            var items = seatPrice.split(',');
            var html = '<strong>선택된 요금 정보:</strong><br>';
            items.forEach(function(item) {
                var pair = item.split(':');
                if (pair.length === 2) {
                    html += pair[0].trim() + ': ' + parseInt(pair[1].trim()).toLocaleString() + '원<br>';
                }
            });
            feeDetails.innerHTML = html;
            selectedFeeInfo.style.display = 'block';
            seatPriceHidden.value = seatPrice;
        } else {
            selectedFeeInfo.style.display = 'none';
            seatPriceHidden.value = '';
        }
    });

    // 폼 유효성 검사 및 기타 부가 기능
    document.getElementById('scheduleInfoForm').addEventListener('submit', function(e) {
        var gameTime = document.getElementById('gameTime').value;
        var timePattern = /^([01]?[0-9]|2[0-3]):[0-5][0-9]$/;
        if (!timePattern.test(gameTime)) {
            e.preventDefault();
            alert('경기시각은 HH:MM 형식으로 입력해주세요. (예: 19:00)');
            document.getElementById('gameTime').focus();
            return false;
        }
        var homeTeam = document.getElementById('homeTeam').value;
        var otherTeam = document.getElementById('otherTeam').value;
        if (homeTeam && otherTeam && homeTeam === otherTeam) {
            e.preventDefault();
            alert('홈팀과 원정팀은 서로 달라야 합니다.');
            return false;
        }
        
        // 동적으로 추가된 좌석명/금액을 seatEtc에만 저장
        const seatNames = document.querySelectorAll('input[name="seatNames[]"]');
        const seatPrices = document.querySelectorAll('input[name="seatPrices[]"]');
        let seatEtcData = [];
        for (let i = 0; i < seatNames.length; i++) {
            const name = seatNames[i].value.trim();
            const price = seatPrices[i].value.trim().replace(/,/g, ''); // 천 단위 콤마 제거
            if (name && price) {
                seatEtcData.push(name + ':' + price);
            }
        }
        document.getElementById('seatEtcHidden').value = seatEtcData.join(',');
        // seatPriceHidden은 change 이벤트에서 이미 값이 들어가 있으므로 추가 처리 불필요
    });

    // 일반적인 숫자 입력 필드에 천 단위 콤마 추가
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
</script>