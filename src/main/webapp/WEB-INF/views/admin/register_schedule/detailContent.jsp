<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4 class="card-title">예약 상세보기</h4>
                    <div>
                        <c:choose>
                            <c:when test="${reservation.reservationStatus == '예약확정'}">
                                <button type="button" class="btn btn-success" disabled>
                                    <i class="fas fa-check me-1"></i>예약확정
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="btn btn-warning" onclick="updateReservationStatus(${reservation.id}, '예약확정')">
                                    <i class="fas fa-clock me-1"></i>예약대기
                                </button>
                            </c:otherwise>
                        </c:choose>
                        <a href="/admin/register_schedule/edit/${reservation.id}" class="btn btn-warning">수정</a>
                        <a href="/admin/register_schedule/list" class="btn btn-secondary">목록</a>
                    </div>
                </div>
                <div class="card-body">
                    <!-- 경기일정 정보 -->
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
                                            <td>${reservation.selectedColor}</td>
                                        </tr>
                                        <tr>
                                            <th>좌석 가격</th>
                                            <td>${reservation.seatPrice}원</td>
                                        </tr>
                                        <tr>
                                            <th>티켓 수량</th>
                                            <td>${reservation.ticketQuantity}장</td>
                                        </tr>
                                        <tr>
                                            <th>총 금액</th>
                                            <td><strong>${reservation.totalPrice}원</strong></td>
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
                                    <table class="table table-borderless">
                                        <tr>
                                            <th width="30%">예약자명</th>
                                            <td>${reservation.customerName}</td>
                                        </tr>
                                        <tr>
                                            <th>성별</th>
                                            <td>${reservation.customerGender}</td>
                                        </tr>
                                        <tr>
                                            <th>생년월일</th>
                                            <td>${reservation.customerBirth}</td>
                                        </tr>
                                        <tr>
                                            <th>여권명</th>
                                            <td>${reservation.customerPassport}</td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-md-6">
                                    <table class="table table-borderless">
                                        <tr>
                                            <th width="30%">연락처</th>
                                            <td>${reservation.customerPhone}</td>
                                        </tr>
                                        <tr>
                                            <th>이메일</th>
                                            <td>${reservation.customerEmail}</td>
                                        </tr>
                                        <tr>
                                            <th>카카오톡 ID</th>
                                            <td>${reservation.customerKakaoId}</td>
                                        </tr>
                                        <tr>
                                            <th>주소</th>
                                            <td>${reservation.customerAddress} ${reservation.customerDetailAddress}</td>
                                        </tr>
                                    </table>
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
                                    <table class="table table-borderless">
                                        <tr>
                                            <th width="30%">결제방법</th>
                                            <td>${reservation.paymentMethod}</td>
                                        </tr>
                                        <tr>
                                            <th>좌석 대체</th>
                                            <td>${reservation.seatAlternative}</td>
                                        </tr>
                                        <tr>
                                            <th>연속 좌석</th>
                                            <td>${reservation.adjacentSeat}</td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-md-6">
                                    <table class="table table-borderless">
                                        <tr>
                                            <th width="30%">등록일</th>
                                            <td>
                                                <fmt:parseDate value="${reservation.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate"/>
                                                <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>추가 요청사항</th>
                                            <td>${reservation.additionalRequests}</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 동행자 정보 -->
                    <c:if test="${not empty reservation.companions}">
                        <div class="row mb-4">
                            <div class="col-12">
                                <h5 class="border-bottom pb-2">동행자 정보</h5>
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead class="table-light">
                                            <tr>
                                                <th>순번</th>
                                                <th>이름</th>
                                                <th>성별</th>
                                                <th>생년월일</th>
                                                <th>여권명</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="companion" items="${companions}" varStatus="status">
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td>${companion.name}</td>
                                                    <td>${companion.gender}</td>
                                                    <td>${companion.birth}</td>
                                                    <td>${companion.passport}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function updateReservationStatus(id, status) {
    if (confirm('예약상태를 변경하시겠습니까?')) {
        fetch(`/admin/register_schedule/update-reservation-status/${id}?status=${status}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            }
        })
        .then(response => {
            if (response.ok) {
                alert('예약상태가 변경되었습니다.');
                location.reload();
            } else {
                alert('상태 변경 중 오류가 발생했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('상태 변경 중 오류가 발생했습니다.');
        });
    }
}
</script> 