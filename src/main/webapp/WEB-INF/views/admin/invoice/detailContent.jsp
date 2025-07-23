<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content-card">
    <div class="content-header d-flex justify-content-between align-items-center">
        <div>
            <h2><i class="fas fa-file-invoice me-2"></i>인보이스 상세보기</h2>
            <p>예약 인보이스 상세 정보를 확인합니다.</p>
        </div>
        <div>
            <a href="/admin/invoice/list" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-1"></i>목록으로
            </a>
            <button type="button" class="btn btn-danger" onclick="deleteInvoice('${invoice.id}')">
                <i class="fas fa-trash me-1"></i>삭제
            </button>
        </div>
    </div>
    
    <!-- 인보이스 내용 -->
    <div class="invoice-container" style="max-width: 800px; margin: 0 auto; background: white; border: 1px solid #ddd; border-radius: 8px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
        
        <!-- 인보이스 헤더 -->
        <div class="row mb-4">
            <div class="col-6">
                <h3 class="text-primary mb-2">FOOTBALL TICKET INVOICE</h3>
                <p class="text-muted mb-1">예약번호: INV-${String.format("%06d", invoice.id)}</p>
                <p class="text-muted mb-1">발행일: ${invoice.createdAt}</p>
            </div>
            <div class="col-6 text-end">
                <img src="/assets/images/logo.png" alt="Logo" style="height: 50px; margin-bottom: 10px;">
                <p class="text-muted mb-1">Football Ticket Service</p>
                <p class="text-muted mb-1">강원 춘천시 충혼길 52번길 10(온의동) 드림타워 3층 302호</p>
                <p class="text-muted mb-1">Tel: 070-7779-9614</p>
            </div>
        </div>
        
        <hr class="my-4">
        
        <!-- 고객 정보 -->
        <div class="row mb-4">
            <div class="col-6">
                <h5 class="text-dark mb-3"><i class="fas fa-user me-2"></i>고객 정보</h5>
                <table class="table table-borderless">
                    <tr>
                        <td style="width: 120px; font-weight: bold;">예약자명:</td>
                        <td>${invoice.customerName}</td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold;">연락처:</td>
                        <td>${invoice.customerPhone}</td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold;">이메일:</td>
                        <td>${invoice.customerEmail}</td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold;">주소:</td>
                        <td>${invoice.customerAddress} ${invoice.customerAddressDetail}</td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold;">상세주소:</td>
                        <td>${invoice.customerDetailAddress}</td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold;">영문주소:</td>
                        <td>${invoice.customerEnglishAddress}</td>
                    </tr>
                </table>
            </div>
            <div class="col-6">
                <h5 class="text-dark mb-3"><i class="fas fa-gamepad me-2"></i>경기 정보</h5>
                <table class="table table-borderless">
                    <tr>
                        <td style="width: 120px; font-weight: bold;">경기:</td>
                        <td><strong>${invoice.homeTeam}</strong> vs <strong>${invoice.awayTeam}</strong></td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold;">경기일:</td>
                        <td>${invoice.gameDate}</td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold;">경기시간:</td>
                        <td>${invoice.gameTime}</td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold;">예약상태:</td>
                        <td>
                            <span class="badge ${invoice.reservationStatus == '예약완료' ? 'bg-success' : 'bg-warning'}">
                                ${invoice.reservationStatus}
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold;">결제상태:</td>
                        <td>
                            <span class="badge ${invoice.paymentStatus == '결제완료' ? 'bg-success' : 'bg-warning'}">
                                ${invoice.paymentStatus}
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold;">승인상태:</td>
                        <td>
                            <span class="badge ${invoice.approvalStatus == '승인완료' ? 'bg-success' : 'bg-warning'}">
                                ${invoice.approvalStatus}
                            </span>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        
        <hr class="my-4">
        
        <!-- 티켓 정보 -->
        <div class="row mb-4">
            <div class="col-12">
                <h5 class="text-dark mb-3"><i class="fas fa-ticket-alt me-2"></i>티켓 정보</h5>
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th style="width: 40%; text-align: center;">항목</th>
                                <th style="width: 20%; text-align: center;">수량</th>
                                <th style="width: 20%; text-align: center;">단가</th>
                                <th style="width: 20%; text-align: center;">금액</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>경기 티켓 (${invoice.homeTeam} vs ${invoice.awayTeam})<br>(${invoice.selectedColor})</td>
                                <td class="text-center">${invoice.ticketQuantity}석</td>
                                <td class="text-end"><fmt:formatNumber value="${invoice.seatPrice}" pattern="#,###"/>원</td>
                                <td class="text-end"><fmt:formatNumber value="${invoice.totalPrice}" pattern="#,###"/>원</td>
                            </tr>
                        </tbody>
                        <tfoot class="table-light">
                            <tr>
                                <td colspan="3" class="text-end fw-bold">총 금액:</td>
                                <td class="text-end fw-bold"><fmt:formatNumber value="${invoice.totalPrice}" pattern="#,###"/>원</td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
        
        <!-- 결제 정보 -->
        <div class="row mb-4">
            <div class="col-12">
                <h5 class="text-dark mb-3"><i class="fas fa-credit-card me-2"></i>결제 정보</h5>
                <table class="table table-borderless">
                    <tr>
                        <td style="width: 150px; font-weight: bold;">결제방법:</td>
                        <td>${invoice.paymentMethod}</td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold;">결제금액:</td>
                        <td><strong class="text-primary"><fmt:formatNumber value="${invoice.totalPrice}" pattern="#,###"/>원</strong></td>
                    </tr>
                </table>
            </div>
        </div>
        
        <hr class="my-4">
        
        <!-- 인보이스 푸터 -->
        <div class="row">
            <div class="col-12 text-center">
                <p class="text-muted mb-2">
                    <i class="fas fa-info-circle me-1"></i>
                    이 인보이스는 예약 확인을 위한 것입니다.
                </p>
                <p class="text-muted mb-0">
                    문의사항: 070-7779-9614 | 이메일: premierticket7@gmail.com
                </p>
            </div>
        </div>
        
    </div>
</div>

<script>
function deleteInvoice(id) {
    if (confirm('정말로 이 인보이스를 삭제하시겠습니까?')) {
        fetch(`/admin/invoice/delete/${id}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            }
        })
        .then(response => {
            if (response.ok) {
                alert('인보이스가 삭제되었습니다.');
                window.location.href = '/admin/invoice/list';
            } else {
                alert('삭제 중 오류가 발생했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('삭제 중 오류가 발생했습니다.');
        });
    }
}
</script>

<style>
.invoice-container {
    font-family: 'Arial', sans-serif;
}

.invoice-container h3 {
    color: #2c3e50;
    font-weight: bold;
}

.invoice-container .table-borderless td {
    padding: 0.25rem 0;
}

.invoice-container .badge {
    font-size: 0.8rem;
}
</style> 