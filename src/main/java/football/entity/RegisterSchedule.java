package football.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "register_schedule")
public class RegisterSchedule {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "uid", nullable = false)
    private String uid;
    
    @Column(name = "home_team", nullable = false)
    private String homeTeam;
    
    @Column(name = "away_team", nullable = false)
    private String awayTeam;
    
    @Column(name = "game_date", nullable = false)
    private String gameDate;
    
    @Column(name = "game_time", nullable = false)
    private String gameTime;
    
    @Column(name = "selected_color", nullable = false)
    private String selectedColor;
    
    @Column(name = "seat_price", nullable = false)
    private String seatPrice;
    
    // 예약자 정보
    @Column(name = "customer_name", nullable = false)
    private String customerName;
    
    @Column(name = "customer_gender", nullable = false)
    private String customerGender;
    
    @Column(name = "customer_passport", nullable = false)
    private String customerPassport;
    
    @Column(name = "customer_phone", nullable = false)
    private String customerPhone;
    
    @Column(name = "customer_email", nullable = false)
    private String customerEmail;
    
    @Column(name = "customer_birth", nullable = false)
    private LocalDate customerBirth;
    
    @Column(name = "customer_address", nullable = false)
    private String customerAddress;
    
    @Column(name = "customer_address_detail", nullable = false)
    private String customerAddressDetail;
    
    @Column(name = "customer_detail_address", nullable = false)
    private String customerDetailAddress;
    
    @Column(name = "customer_english_address", nullable = false)
    private String customerEnglishAddress;
    
    @Column(name = "customer_kakao_id")
    private String customerKakaoId;
    
    // 티켓 예약 정보
    @Column(name = "ticket_quantity", nullable = false)
    private Integer ticketQuantity;
    
    @Column(name = "total_price", nullable = false)
    private String totalPrice;
    
    @Column(name = "payment_method", nullable = false)
    private String paymentMethod;
    
    @Column(name = "seat_alternative", nullable = false)
    private String seatAlternative;
    
    @Column(name = "adjacent_seat", nullable = false)
    private String adjacentSeat;
    
    @Column(name = "additional_requests", columnDefinition = "TEXT")
    private String additionalRequests;
    
    @Column(name = "companions", columnDefinition = "TEXT")
    private String companions;
    
    @Column(name = "reservation_status", nullable = false)
    private String reservationStatus = "예약대기"; // 예약대기, 예약확정
    
    @Column(name = "payment_status", nullable = false)
    private String paymentStatus = "결제대기"; // 결제대기, 결제완료
    
    @Column(name = "approval_status", nullable = false)
    private String approvalStatus = "미승인"; // 미승인, 승인
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    // 기본 생성자
    public RegisterSchedule() {}
    
    // Getter와 Setter 메서드들
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getUid() {
        return uid;
    }
    
    public void setUid(String uid) {
        this.uid = uid;
    }
    
    public String getHomeTeam() {
        return homeTeam;
    }
    
    public void setHomeTeam(String homeTeam) {
        this.homeTeam = homeTeam;
    }
    
    public String getAwayTeam() {
        return awayTeam;
    }
    
    public void setAwayTeam(String awayTeam) {
        this.awayTeam = awayTeam;
    }
    
    public String getGameDate() {
        return gameDate;
    }
    
    public void setGameDate(String gameDate) {
        this.gameDate = gameDate;
    }
    
    public String getGameTime() {
        return gameTime;
    }
    
    public void setGameTime(String gameTime) {
        this.gameTime = gameTime;
    }
    
    public String getSelectedColor() {
        return selectedColor;
    }
    
    public void setSelectedColor(String selectedColor) {
        this.selectedColor = selectedColor;
    }
    
    public String getSeatPrice() {
        return seatPrice;
    }
    
    public void setSeatPrice(String seatPrice) {
        this.seatPrice = seatPrice;
    }
    
    public String getCustomerName() {
        return customerName;
    }
    
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }
    
    public String getCustomerGender() {
        return customerGender;
    }
    
    public void setCustomerGender(String customerGender) {
        this.customerGender = customerGender;
    }
    
    public String getCustomerPassport() {
        return customerPassport;
    }
    
    public void setCustomerPassport(String customerPassport) {
        this.customerPassport = customerPassport;
    }
    
    public String getCustomerPhone() {
        return customerPhone;
    }
    
    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }
    
    public String getCustomerEmail() {
        return customerEmail;
    }
    
    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }
    
    public LocalDate getCustomerBirth() {
        return customerBirth;
    }
    
    public void setCustomerBirth(LocalDate customerBirth) {
        this.customerBirth = customerBirth;
    }
    
    public String getCustomerAddress() {
        return customerAddress;
    }
    
    public void setCustomerAddress(String customerAddress) {
        this.customerAddress = customerAddress;
    }
    
    public String getCustomerAddressDetail() {
        return customerAddressDetail;
    }
    
    public void setCustomerAddressDetail(String customerAddressDetail) {
        this.customerAddressDetail = customerAddressDetail;
    }
    
    public String getCustomerDetailAddress() {
        return customerDetailAddress;
    }
    
    public void setCustomerDetailAddress(String customerDetailAddress) {
        this.customerDetailAddress = customerDetailAddress;
    }
    
    public String getCustomerEnglishAddress() {
        return customerEnglishAddress;
    }
    
    public void setCustomerEnglishAddress(String customerEnglishAddress) {
        this.customerEnglishAddress = customerEnglishAddress;
    }
    
    public String getCustomerKakaoId() {
        return customerKakaoId;
    }
    
    public void setCustomerKakaoId(String customerKakaoId) {
        this.customerKakaoId = customerKakaoId;
    }
    
    public Integer getTicketQuantity() {
        return ticketQuantity;
    }
    
    public void setTicketQuantity(Integer ticketQuantity) {
        this.ticketQuantity = ticketQuantity;
    }
    
    public String getTotalPrice() {
        return totalPrice;
    }
    
    public void setTotalPrice(String totalPrice) {
        this.totalPrice = totalPrice;
    }
    
    public String getPaymentMethod() {
        return paymentMethod;
    }
    
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    
    public String getSeatAlternative() {
        return seatAlternative;
    }
    
    public void setSeatAlternative(String seatAlternative) {
        this.seatAlternative = seatAlternative;
    }
    
    public String getAdjacentSeat() {
        return adjacentSeat;
    }
    
    public void setAdjacentSeat(String adjacentSeat) {
        this.adjacentSeat = adjacentSeat;
    }
    
    public String getAdditionalRequests() {
        return additionalRequests;
    }
    
    public void setAdditionalRequests(String additionalRequests) {
        this.additionalRequests = additionalRequests;
    }
    
    public String getCompanions() {
        return companions;
    }
    
    public void setCompanions(String companions) {
        this.companions = companions;
    }
    
    public String getReservationStatus() {
        return reservationStatus;
    }
    
    public void setReservationStatus(String reservationStatus) {
        this.reservationStatus = reservationStatus;
    }
    
    public String getPaymentStatus() {
        return paymentStatus;
    }
    
    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
    
    public String getApprovalStatus() {
        return approvalStatus;
    }
    
    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
} 