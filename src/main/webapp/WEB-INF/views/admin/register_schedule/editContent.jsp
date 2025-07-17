<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">예약 수정</h4>
                </div>
                <div class="card-body">
                    <form action="/admin/register_schedule/edit/${reservation.id}" method="post" id="editForm">
                        <!-- 경기일정 정보 (읽기 전용) -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h5 class="border-bottom pb-2">경기일정 정보</h5>
                                <div class="row">
                                    <div class="col-md-6">
                                        <table class="table table-borderless">
                                            <tr>
                                                <th width="30%">홈팀</th>
                                                <td>${reservation.homeTeam}</td>
                                            </tr>
                                            <tr>
                                                <th>원정팀</th>
                                                <td>${reservation.awayTeam}</td>
                                            </tr>
                                            <tr>
                                                <th>경기날짜</th>
                                                <td>${reservation.gameDate}</td>
                                            </tr>
                                            <tr>
                                                <th>경기시간</th>
                                                <td>${reservation.gameTime}</td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="col-md-6">
                                        <table class="table table-borderless">
                                            <tr>
                                                <th width="30%">선택 좌석</th>
                                                <td>
                                                    ${reservation.selectedColor}
                                                    <input type="hidden" id="selectedColor" name="selectedColor" value="${reservation.selectedColor}">
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>좌석 가격</th>
                                                <td>
                                                    ${reservation.seatPrice}원
                                                    <input type="hidden" id="seatPrice" name="seatPrice" value="${reservation.seatPrice}">
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>티켓 수량</th>
                                                <td><input type="number" class="form-control" id="ticketQuantity" name="ticketQuantity" value="${reservation.ticketQuantity}" min="1" required></td>
                                            </tr>
                                            <tr>
                                                <th>총 금액</th>
                                                <td><input type="text" class="form-control" id="totalPrice" name="totalPrice" value="${reservation.totalPrice}" readonly></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 예약자 정보 -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h5 class="border-bottom pb-2">예약자 정보</h5>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="customerName" class="form-label">예약자명</label>
                                            <input type="text" class="form-control" id="customerName" name="customerName" value="${reservation.customerName}" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="customerGender" class="form-label">성별</label>
                                            <select class="form-control" id="customerGender" name="customerGender" required>
                                                <option value="남" ${reservation.customerGender == '남' ? 'selected' : ''}>남</option>
                                                <option value="여" ${reservation.customerGender == '여' ? 'selected' : ''}>여</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="customerBirth" class="form-label">생년월일</label>
                                            <input type="date" class="form-control" id="customerBirth" name="customerBirth" value="${reservation.customerBirth}" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="customerPassport" class="form-label">여권명</label>
                                            <input type="text" class="form-control" id="customerPassport" name="customerPassport" value="${reservation.customerPassport}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="customerPhone" class="form-label">연락처</label>
                                            <input type="tel" class="form-control" id="customerPhone" name="customerPhone" value="${reservation.customerPhone}" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="customerEmail" class="form-label">이메일</label>
                                            <input type="email" class="form-control" id="customerEmail" name="customerEmail" value="${reservation.customerEmail}" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="customerKakaoId" class="form-label">카카오톡 ID</label>
                                            <input type="text" class="form-control" id="customerKakaoId" name="customerKakaoId" value="${reservation.customerKakaoId}">
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- 주소 정보 -->
                                <div class="row">
                                    <div class="col-12">
                                        <h6 class="border-bottom pb-2">주소 정보</h6>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="customerAddress" class="form-label">우편번호</label>
                                                    <div class="d-flex gap-2">
                                                        <input type="text" class="form-control" id="customerAddress" name="customerAddress" value="${reservation.customerAddress}" readonly required>
                                                        <button type="button" class="btn btn-secondary" onclick="searchAddress()">우편번호 찾기</button>
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="customerAddressDetail" class="form-label">주소</label>
                                                    <input type="text" class="form-control" id="customerAddressDetail" name="customerAddressDetail" value="${reservation.customerAddressDetail}" required>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="customerDetailAddress" class="form-label">상세주소</label>
                                                    <input type="text" class="form-control" id="customerDetailAddress" name="customerDetailAddress" value="${reservation.customerDetailAddress}" required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="customerEnglishAddress" class="form-label">영문주소</label>
                                                    <input type="text" class="form-control" id="customerEnglishAddress" name="customerEnglishAddress" value="${reservation.customerEnglishAddress}" required>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 티켓예약 정보 -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h5 class="border-bottom pb-2">티켓예약 정보</h5>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="paymentMethod" class="form-label">결제방법</label>
                                            <select class="form-control" id="paymentMethod" name="paymentMethod" required>
                                                <option value="신용카드" ${reservation.paymentMethod == '신용카드' ? 'selected' : ''}>신용카드</option>
                                                <option value="계좌이체" ${reservation.paymentMethod == '계좌이체' ? 'selected' : ''}>계좌이체</option>
                                                <option value="무통장입금" ${reservation.paymentMethod == '무통장입금' ? 'selected' : ''}>무통장입금</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="seatAlternative" class="form-label">좌석 대체</label>
                                            <select class="form-control" id="seatAlternative" name="seatAlternative" required>
                                                <option value="예" ${reservation.seatAlternative == '예' ? 'selected' : ''}>예</option>
                                                <option value="아니오" ${reservation.seatAlternative == '아니오' ? 'selected' : ''}>아니오</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="adjacentSeat" class="form-label">연속 좌석</label>
                                            <select class="form-control" id="adjacentSeat" name="adjacentSeat" required>
                                                <option value="예" ${reservation.adjacentSeat == '예' ? 'selected' : ''}>예</option>
                                                <option value="아니오" ${reservation.adjacentSeat == '아니오' ? 'selected' : ''}>아니오</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="additionalRequests" class="form-label">추가 요청사항</label>
                                            <textarea class="form-control" id="additionalRequests" name="additionalRequests" rows="4">${reservation.additionalRequests}</textarea>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- 동행자 정보 -->
                                <div class="row mt-3">
                                    <div class="col-12">
                                        <h6 class="border-bottom pb-2">동행자 정보</h6>
                                        <div id="companionInfoContainer">
                                            <!-- 기존 동행자 정보 표시 -->
                                            <c:forEach var="companion" items="${companions}" varStatus="status">
                                                <div class="row mb-2">
                                                    <div class="col-md-4">
                                                        <input type="text" name="companionName${status.index}" placeholder="이름(영문)" 
                                                               class="form-control" value="${companion.name}" required>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <input type="date" name="companionBirth${status.index}" placeholder="생년월일" 
                                                               class="form-control" value="${companion.birth}" required>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <select name="companionGender${status.index}" class="form-control" required>
                                                            <option value="">성별</option>
                                                            <option value="남" ${companion.gender == '남' ? 'selected' : ''}>남</option>
                                                            <option value="여" ${companion.gender == '여' ? 'selected' : ''}>여</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <div class="text-muted mt-2">* 동행하시는 분들의 이름(영문), 생년월일, 성별을 입력해 주세요.</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 버튼 영역 -->
                        <div class="row">
                            <div class="col-12 text-center">
                                <button type="submit" class="btn btn-primary">수정</button>
                                <a href="/admin/register_schedule/list" class="btn btn-secondary">취소</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 다음 우편번호 API 스크립트 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
// 서버에서 전달받은 동행자 정보를 JavaScript 변수로 설정
let serverCompanions = [];
try {
    const companionsJsonStr = '${companionsJson}';
    console.log('받은 JSON 문자열:', companionsJsonStr);
    serverCompanions = JSON.parse(companionsJsonStr);
    console.log('파싱된 동행자 정보:', serverCompanions);
} catch (e) {
    console.error('동행자 정보 파싱 오류:', e);
    serverCompanions = [];
}

// 총 금액 자동 계산
function calculateTotal() {
    const seatPrice = parseInt(document.getElementById('seatPrice').value) || 0;
    const ticketQuantity = parseInt(document.getElementById('ticketQuantity').value) || 0;
    const totalPrice = seatPrice * ticketQuantity;
    document.getElementById('totalPrice').value = totalPrice.toLocaleString() + '원';
}

// 동행자 정보 동적 생성
function updateCompanionInfo() {
    const count = parseInt(document.getElementById('ticketQuantity').value) || 1;
    const container = document.getElementById('companionInfoContainer');
    
    if (container) {
        console.log('기존 동행자 정보:', serverCompanions);
        console.log('티켓 수량:', count);
        
        // 컨테이너 초기화
        container.innerHTML = '';
        
        // 티켓 수량이 1보다 클 때만 동행자 정보 입력란 생성 (예약자 본인 제외)
        if (count > 1) {
            for(let i = 0; i < count - 1; i++) {
                const existingCompanion = serverCompanions[i] || {};
                console.log('동행자 ' + (i+1) + ' 정보:', existingCompanion);
                
                // 안전한 값 추출
                const name = existingCompanion.name || '';
                const birth = existingCompanion.birth || '';
                const gender = existingCompanion.gender || '';
                
                console.log('동행자 ' + (i+1) + ' - 이름: "' + name + '", 생년월일: "' + birth + '", 성별: "' + gender + '"');
                
                const selectedMale = gender === '남' ? 'selected' : '';
                const selectedFemale = gender === '여' ? 'selected' : '';
                
                const companionHtml = '<div class="row mb-2">' +
                    '<div class="col-md-4">' +
                        '<input type="text" name="companionName' + i + '" placeholder="이름(영문)" ' +
                        'class="form-control" value="' + name + '" required>' +
                    '</div>' +
                    '<div class="col-md-4">' +
                        '<input type="date" name="companionBirth' + i + '" placeholder="생년월일" ' +
                        'class="form-control" value="' + birth + '" required>' +
                    '</div>' +
                    '<div class="col-md-4">' +
                        '<select name="companionGender' + i + '" class="form-control" required>' +
                            '<option value="">성별</option>' +
                            '<option value="남" ' + selectedMale + '>남</option>' +
                            '<option value="여" ' + selectedFemale + '>여</option>' +
                        '</select>' +
                    '</div>' +
                '</div>';
                
                console.log('동행자 ' + (i+1) + ' HTML:', companionHtml);
                container.innerHTML += companionHtml;
            }
        }
    }
}

// 기존 동행자 정보로 입력란 채우기 (더 이상 필요하지 않음)
function fillExistingCompanionData() {
    // 이 함수는 더 이상 사용하지 않음
    console.log('fillExistingCompanionData 함수는 더 이상 사용하지 않습니다.');
}

// 주소 검색 함수
function searchAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = data.roadAddress ? data.roadAddress : data.jibunAddress;
            // 우편번호는 우편번호 입력란에만 입력
            document.getElementById('customerAddress').value = data.zonecode;
            // 주소는 주소 입력란에 입력
            document.getElementById('customerAddressDetail').value = addr;
            // 영문 주소 자동 입력 제거 - 사용자가 직접 입력하도록 함
            // var englishAddr = convertToEnglishAddress(addr);
            // document.getElementById('customerEnglishAddress').value = englishAddr;
            // 상세주소 입력란에 포커스
            document.getElementById('customerDetailAddress').focus();
        }
    }).open();
}

// 한글 주소를 영문으로 변환하는 함수 (더 이상 사용하지 않음)
function convertToEnglishAddress(koreanAddress) {
    // 이 함수는 더 이상 사용하지 않음
    return koreanAddress;
}

// 이벤트 리스너 등록
document.addEventListener('DOMContentLoaded', function() {
    // 초기 계산
    calculateTotal();
    
    // 페이지 로드 시에는 동행자 정보를 덮어쓰지 않음 (서버 사이드 렌더링 유지)
    // updateCompanionInfo(); // 이 줄을 주석 처리
    
    // 좌석 가격 변경 시 재계산
    document.getElementById('seatPrice').addEventListener('input', calculateTotal);
    
    // 티켓 수량 변경 시 재계산 및 동행자 정보 업데이트
    document.getElementById('ticketQuantity').addEventListener('input', function() {
        calculateTotal();
        updateCompanionInfo(); // 티켓 수량 변경 시에만 동행자 정보 업데이트
    });
    
    // 좌석 색상 변경 시 재계산 (selectedColor 요소가 있는 경우에만)
    const selectedColorElement = document.getElementById('selectedColor');
    if (selectedColorElement) {
        selectedColorElement.addEventListener('change', function() {
            // 좌석 색상에 따른 가격 변경 로직 추가 가능
            calculateTotal();
        });
    }
});

// 폼 제출 전 유효성 검사
document.getElementById('editForm').addEventListener('submit', function(e) {
    console.log('폼 제출 유효성 검사 시작');
    
    const requiredFields = [
        'customerName', 'customerGender', 'customerBirth', 'customerPassport',
        'customerPhone', 'customerEmail', 'customerAddress', 'customerAddressDetail', 
        'customerDetailAddress', 'customerEnglishAddress', 'seatPrice', 
        'ticketQuantity', 'paymentMethod', 'seatAlternative', 'adjacentSeat'
    ];
    
    console.log('검사할 필수 필드들:', requiredFields);
    
    for (const fieldId of requiredFields) {
        const field = document.getElementById(fieldId);
        console.log('필드 ' + fieldId + ':', field);
        console.log('필드 값:', field ? field.value : 'null');
        
        if (!field || !field.value.trim()) {
            console.log('필수 필드 누락:', fieldId);
            alert('모든 필수 정보를 입력해 주세요. (누락된 필드: ' + fieldId + ')');
            if (field) field.focus();
            e.preventDefault();
            return;
        }
    }
    
    // 티켓 수량이 1 이상인지 확인
    const ticketQuantity = parseInt(document.getElementById('ticketQuantity').value);
    if (ticketQuantity < 1) {
        alert('티켓 수량은 1 이상이어야 합니다.');
        document.getElementById('ticketQuantity').focus();
        e.preventDefault();
        return;
    }
    
    // 동행자 정보 필수 체크 (티켓 수량이 1보다 클 때만)
    if (ticketQuantity > 1) {
        console.log('동행자 정보 검사 시작 - 티켓 수량:', ticketQuantity);
        for(let i = 0; i < ticketQuantity - 1; i++) { // 예약자 본인 제외
            const nameEl = document.getElementsByName('companionName'+i)[0];
            const birthEl = document.getElementsByName('companionBirth'+i)[0];
            const genderEl = document.getElementsByName('companionGender'+i)[0];
            
            console.log('동행자 ' + (i+1) + ' 검사:');
            console.log('- 이름 요소:', nameEl);
            console.log('- 이름 값:', nameEl ? nameEl.value : 'null');
            console.log('- 생년월일 요소:', birthEl);
            console.log('- 생년월일 값:', birthEl ? birthEl.value : 'null');
            console.log('- 성별 요소:', genderEl);
            console.log('- 성별 값:', genderEl ? genderEl.value : 'null');
            
            if (!nameEl || !nameEl.value.trim()) {
                alert('동행자 ' + (i+1) + '의 이름을 입력해 주세요.');
                nameEl && nameEl.focus();
                e.preventDefault();
                return;
            }
            if (!birthEl || !birthEl.value.trim()) {
                alert('동행자 ' + (i+1) + '의 생년월일을 입력해 주세요.');
                birthEl && birthEl.focus();
                e.preventDefault();
                return;
            }
            if (!genderEl || !genderEl.value.trim()) {
                alert('동행자 ' + (i+1) + '의 성별을 선택해 주세요.');
                genderEl && genderEl.focus();
                e.preventDefault();
                return;
            }
        }
    }
    
    console.log('폼 유효성 검사 통과');
});
</script> 