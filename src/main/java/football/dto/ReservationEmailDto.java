package football.dto;

public class ReservationEmailDto {
    private String uid;
    private String homeTeam;
    private String awayTeam;
    private String gameDate;
    private String gameTime;
    private String selectedColor;
    private String seatPrice;
    private String customerName;
    private String customerEmail;
    private String customerPhone;
    private String customerBirth;
    private String customerPassport;
    private String customerAddress;
    private String customerAddressDetail; // 추가
    private String customerDetailAddress;
    private String customerEnglishAddress;
    private String customerKakaoId;
    private String customerGender; // 추가
    private String emergencyName;
    private String emergencyPhone;
    private String emergencyBirth;
    private String emergencyPassport;
    private String emergencyAddress;
    private String emergencyDetailAddress;
    private String emergencyEnglishAddress;
    private String emergencyKakaoId;
    private String paymentMethod;
    private String cardNumber;
    private String cardExpiry;
    private String cardCvv;
    private String seatReplacement; // 추가
    private String consecutiveSeats; // 추가
    private String specialRequests;
    private String ticketQuantity;
    private String totalPrice;
    private String companions;
    private String seatAlternative; // 추가
    private String adjacentSeat; // 추가
    private String additionalRequests; // 추가
    
    // Getters and Setters
    public String getUid() { return uid; }
    public void setUid(String uid) { this.uid = uid; }
    
    public String getHomeTeam() { return homeTeam; }
    public void setHomeTeam(String homeTeam) { this.homeTeam = homeTeam; }
    
    public String getAwayTeam() { return awayTeam; }
    public void setAwayTeam(String awayTeam) { this.awayTeam = awayTeam; }
    
    public String getGameDate() { return gameDate; }
    public void setGameDate(String gameDate) { this.gameDate = gameDate; }
    
    public String getGameTime() { return gameTime; }
    public void setGameTime(String gameTime) { this.gameTime = gameTime; }
    
    public String getSelectedColor() { return selectedColor; }
    public void setSelectedColor(String selectedColor) { this.selectedColor = selectedColor; }
    
    public String getSeatPrice() { return seatPrice; }
    public void setSeatPrice(String seatPrice) { this.seatPrice = seatPrice; }
    
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    
    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }
    
    public String getCustomerPhone() { return customerPhone; }
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }
    
    public String getCustomerBirth() { return customerBirth; }
    public void setCustomerBirth(String customerBirth) { this.customerBirth = customerBirth; }
    
    public String getCustomerPassport() { return customerPassport; }
    public void setCustomerPassport(String customerPassport) { this.customerPassport = customerPassport; }
    
    public String getCustomerAddress() { return customerAddress; }
    public void setCustomerAddress(String customerAddress) { this.customerAddress = customerAddress; }
    
    public String getCustomerAddressDetail() { return customerAddressDetail; }
    public void setCustomerAddressDetail(String customerAddressDetail) { this.customerAddressDetail = customerAddressDetail; }
    
    public String getCustomerDetailAddress() { return customerDetailAddress; }
    public void setCustomerDetailAddress(String customerDetailAddress) { this.customerDetailAddress = customerDetailAddress; }
    
    public String getCustomerEnglishAddress() { return customerEnglishAddress; }
    public void setCustomerEnglishAddress(String customerEnglishAddress) { this.customerEnglishAddress = customerEnglishAddress; }
    
    public String getCustomerKakaoId() { return customerKakaoId; }
    public void setCustomerKakaoId(String customerKakaoId) { this.customerKakaoId = customerKakaoId; }
    
    public String getCustomerGender() { return customerGender; }
    public void setCustomerGender(String customerGender) { this.customerGender = customerGender; }
    
    public String getEmergencyName() { return emergencyName; }
    public void setEmergencyName(String emergencyName) { this.emergencyName = emergencyName; }
    
    public String getEmergencyPhone() { return emergencyPhone; }
    public void setEmergencyPhone(String emergencyPhone) { this.emergencyPhone = emergencyPhone; }
    
    public String getEmergencyBirth() { return emergencyBirth; }
    public void setEmergencyBirth(String emergencyBirth) { this.emergencyBirth = emergencyBirth; }
    
    public String getEmergencyPassport() { return emergencyPassport; }
    public void setEmergencyPassport(String emergencyPassport) { this.emergencyPassport = emergencyPassport; }
    
    public String getEmergencyAddress() { return emergencyAddress; }
    public void setEmergencyAddress(String emergencyAddress) { this.emergencyAddress = emergencyAddress; }
    
    public String getEmergencyDetailAddress() { return emergencyDetailAddress; }
    public void setEmergencyDetailAddress(String emergencyDetailAddress) { this.emergencyDetailAddress = emergencyDetailAddress; }
    
    public String getEmergencyEnglishAddress() { return emergencyEnglishAddress; }
    public void setEmergencyEnglishAddress(String emergencyEnglishAddress) { this.emergencyEnglishAddress = emergencyEnglishAddress; }
    
    public String getEmergencyKakaoId() { return emergencyKakaoId; }
    public void setEmergencyKakaoId(String emergencyKakaoId) { this.emergencyKakaoId = emergencyKakaoId; }
    
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    
    public String getCardNumber() { return cardNumber; }
    public void setCardNumber(String cardNumber) { this.cardNumber = cardNumber; }
    
    public String getCardExpiry() { return cardExpiry; }
    public void setCardExpiry(String cardExpiry) { this.cardExpiry = cardExpiry; }
    
    public String getCardCvv() { return cardCvv; }
    public void setCardCvv(String cardCvv) { this.cardCvv = cardCvv; }
    
    public String getSeatReplacement() { return seatReplacement; }
    public void setSeatReplacement(String seatReplacement) { this.seatReplacement = seatReplacement; }
    
    public String getConsecutiveSeats() { return consecutiveSeats; }
    public void setConsecutiveSeats(String consecutiveSeats) { this.consecutiveSeats = consecutiveSeats; }
    
    public String getSpecialRequests() { return specialRequests; }
    public void setSpecialRequests(String specialRequests) { this.specialRequests = specialRequests; }
    
    public String getTicketQuantity() { return ticketQuantity; }
    public void setTicketQuantity(String ticketQuantity) { this.ticketQuantity = ticketQuantity; }
    
    public String getTotalPrice() { return totalPrice; }
    public void setTotalPrice(String totalPrice) { this.totalPrice = totalPrice; }
    
    public String getCompanions() { return companions; }
    public void setCompanions(String companions) { this.companions = companions; }
    
    public String getSeatAlternative() { return seatAlternative; }
    public void setSeatAlternative(String seatAlternative) { this.seatAlternative = seatAlternative; }
    
    public String getAdjacentSeat() { return adjacentSeat; }
    public void setAdjacentSeat(String adjacentSeat) { this.adjacentSeat = adjacentSeat; }
    
    public String getAdditionalRequests() { return additionalRequests; }
    public void setAdditionalRequests(String additionalRequests) { this.additionalRequests = additionalRequests; }
} 