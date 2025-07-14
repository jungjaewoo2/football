package football.controller;

import football.entity.RegisterSchedule;
import football.service.RegisterScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin/register_schedule")
public class RegisterScheduleController {
    
    @Autowired
    private RegisterScheduleService registerScheduleService;
    
    // 예약목록 리스트 페이지
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "0") int page,
                      @RequestParam(required = false) String searchType,
                      @RequestParam(required = false) String keyword,
                      Model model) {
        
        Page<RegisterSchedule> reservationPage;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            switch (searchType) {
                case "customerName":
                    reservationPage = registerScheduleService.searchByCustomerName(keyword, page, 10);
                    break;
                case "homeTeam":
                    reservationPage = registerScheduleService.searchByHomeTeam(keyword, page, 10);
                    break;
                case "awayTeam":
                    reservationPage = registerScheduleService.searchByAwayTeam(keyword, page, 10);
                    break;
                default:
                    reservationPage = registerScheduleService.getAllReservations(page, 10);
                    break;
            }
            model.addAttribute("searchType", searchType);
            model.addAttribute("keyword", keyword);
        } else {
            reservationPage = registerScheduleService.getAllReservations(page, 10);
        }
        
        // 날짜 포맷팅을 위한 DTO 변환
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        var reservationDtos = reservationPage.getContent().stream()
            .map(reservation -> {
                return new ReservationDto(
                    reservation.getId(),
                    reservation.getCustomerName(),
                    reservation.getCustomerGender(),
                    reservation.getCustomerPassport(),
                    reservation.getCustomerPhone(),
                    reservation.getCustomerEmail(),
                    reservation.getCustomerBirth() != null ? reservation.getCustomerBirth().format(formatter) : "",
                    reservation.getCustomerAddress(),
                    reservation.getCustomerAddressDetail(),
                    reservation.getCustomerDetailAddress(),
                    reservation.getCustomerEnglishAddress(),
                    reservation.getCustomerKakaoId(),
                    reservation.getUid(),
                    reservation.getHomeTeam(),
                    reservation.getAwayTeam(),
                    reservation.getGameDate(),
                    reservation.getGameTime(),
                    reservation.getSelectedColor(),
                    reservation.getSeatPrice(),
                    reservation.getTicketQuantity(),
                    reservation.getTotalPrice(),
                    reservation.getPaymentMethod(),
                    reservation.getSeatAlternative(),
                    reservation.getAdjacentSeat(),
                    reservation.getAdditionalRequests(),
                    reservation.getCompanions(),
                    reservation.getReservationStatus(),
                    reservation.getPaymentStatus(),
                    reservation.getApprovalStatus(),
                    reservation.getCreatedAt() != null ? reservation.getCreatedAt().format(formatter) : ""
                );
            })
            .collect(Collectors.toList());
        
        model.addAttribute("reservations", reservationDtos);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", reservationPage.getTotalPages());
        model.addAttribute("totalItems", reservationPage.getTotalElements());
        model.addAttribute("hasNext", reservationPage.hasNext());
        model.addAttribute("hasPrevious", reservationPage.hasPrevious());
        
        return "admin/register_schedule/list";
    }
    
    // 예약 상세보기 페이지
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Long id, Model model) {
        Optional<RegisterSchedule> reservation = registerScheduleService.getReservationById(id);
        if (reservation.isPresent()) {
            RegisterSchedule reservationEntity = reservation.get();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            
            ReservationDto reservationDto = new ReservationDto(
                reservationEntity.getId(),
                reservationEntity.getCustomerName(),
                reservationEntity.getCustomerGender(),
                reservationEntity.getCustomerPassport(),
                reservationEntity.getCustomerPhone(),
                reservationEntity.getCustomerEmail(),
                reservationEntity.getCustomerBirth() != null ? reservationEntity.getCustomerBirth().format(formatter) : "",
                reservationEntity.getCustomerAddress(),
                reservationEntity.getCustomerAddressDetail(),
                reservationEntity.getCustomerDetailAddress(),
                reservationEntity.getCustomerEnglishAddress(),
                reservationEntity.getCustomerKakaoId(),
                reservationEntity.getUid(),
                reservationEntity.getHomeTeam(),
                reservationEntity.getAwayTeam(),
                reservationEntity.getGameDate(),
                reservationEntity.getGameTime(),
                reservationEntity.getSelectedColor(),
                reservationEntity.getSeatPrice(),
                reservationEntity.getTicketQuantity(),
                reservationEntity.getTotalPrice(),
                reservationEntity.getPaymentMethod(),
                reservationEntity.getSeatAlternative(),
                reservationEntity.getAdjacentSeat(),
                reservationEntity.getAdditionalRequests(),
                reservationEntity.getCompanions(),
                reservationEntity.getReservationStatus(),
                reservationEntity.getPaymentStatus(),
                reservationEntity.getApprovalStatus(),
                reservationEntity.getCreatedAt() != null ? reservationEntity.getCreatedAt().format(formatter) : ""
            );
            
            model.addAttribute("reservation", reservationDto);
            
            // 동행자 정보 파싱 (JSON 형태로 저장된 경우)
            if (reservationEntity.getCompanions() != null && !reservationEntity.getCompanions().isEmpty()) {
                // JSON 파싱 로직 추가 필요
                model.addAttribute("companions", List.of()); // 임시로 빈 리스트
            }
            
            return "admin/register_schedule/detail";
        } else {
            return "redirect:/admin/register_schedule/list";
        }
    }
    
    // 예약 수정 페이지
    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        Optional<RegisterSchedule> reservation = registerScheduleService.getReservationById(id);
        if (reservation.isPresent()) {
            RegisterSchedule reservationEntity = reservation.get();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            
            ReservationDto reservationDto = new ReservationDto(
                reservationEntity.getId(),
                reservationEntity.getCustomerName(),
                reservationEntity.getCustomerGender(),
                reservationEntity.getCustomerPassport(),
                reservationEntity.getCustomerPhone(),
                reservationEntity.getCustomerEmail(),
                reservationEntity.getCustomerBirth() != null ? reservationEntity.getCustomerBirth().format(formatter) : "",
                reservationEntity.getCustomerAddress(),
                reservationEntity.getCustomerAddressDetail(),
                reservationEntity.getCustomerDetailAddress(),
                reservationEntity.getCustomerEnglishAddress(),
                reservationEntity.getCustomerKakaoId(),
                reservationEntity.getUid(),
                reservationEntity.getHomeTeam(),
                reservationEntity.getAwayTeam(),
                reservationEntity.getGameDate(),
                reservationEntity.getGameTime(),
                reservationEntity.getSelectedColor(),
                reservationEntity.getSeatPrice(),
                reservationEntity.getTicketQuantity(),
                reservationEntity.getTotalPrice(),
                reservationEntity.getPaymentMethod(),
                reservationEntity.getSeatAlternative(),
                reservationEntity.getAdjacentSeat(),
                reservationEntity.getAdditionalRequests(),
                reservationEntity.getCompanions(),
                reservationEntity.getReservationStatus(),
                reservationEntity.getPaymentStatus(),
                reservationEntity.getApprovalStatus(),
                reservationEntity.getCreatedAt() != null ? reservationEntity.getCreatedAt().format(formatter) : ""
            );
            
            model.addAttribute("reservation", reservationDto);
            return "admin/register_schedule/edit";
        } else {
            return "redirect:/admin/register_schedule/list";
        }
    }
    
    // 예약 수정 처리
    @PostMapping("/edit/{id}")
    public String edit(@PathVariable Long id, @ModelAttribute ReservationDto reservationDto, 
                      HttpServletRequest request) {
        Optional<RegisterSchedule> existingReservation = registerScheduleService.getReservationById(id);
        if (existingReservation.isPresent()) {
            RegisterSchedule reservation = existingReservation.get();
            
            // 예약자 정보 업데이트
            reservation.setCustomerName(reservationDto.getCustomerName());
            reservation.setCustomerGender(reservationDto.getCustomerGender());
            reservation.setCustomerPassport(reservationDto.getCustomerPassport());
            reservation.setCustomerPhone(reservationDto.getCustomerPhone());
            reservation.setCustomerEmail(reservationDto.getCustomerEmail());
            reservation.setCustomerAddress(reservationDto.getCustomerAddress());
            reservation.setCustomerDetailAddress(reservationDto.getCustomerDetailAddress());
            reservation.setCustomerKakaoId(reservationDto.getCustomerKakaoId());
            
            // 티켓예약 정보 업데이트 (경기일정 정보는 수정하지 않음)
            reservation.setSelectedColor(reservationDto.getSelectedColor());
            reservation.setSeatPrice(reservationDto.getSeatPrice());
            reservation.setTicketQuantity(reservationDto.getTicketQuantity());
            reservation.setTotalPrice(reservationDto.getTotalPrice());
            reservation.setPaymentMethod(reservationDto.getPaymentMethod());
            reservation.setSeatAlternative(reservationDto.getSeatAlternative());
            reservation.setAdjacentSeat(reservationDto.getAdjacentSeat());
            reservation.setAdditionalRequests(reservationDto.getAdditionalRequests());
            
            // 동행자 정보 처리
            int ticketQuantity = reservationDto.getTicketQuantity();
            if (ticketQuantity > 1) {
                StringBuilder companionsJson = new StringBuilder();
                companionsJson.append("[");
                
                for (int i = 0; i < ticketQuantity - 1; i++) {
                    String name = request.getParameter("companionName" + i);
                    String birth = request.getParameter("companionBirth" + i);
                    String gender = request.getParameter("companionGender" + i);
                    
                    if (name != null && !name.trim().isEmpty()) {
                        if (companionsJson.length() > 1) {
                            companionsJson.append(",");
                        }
                        companionsJson.append("{");
                        companionsJson.append("\"name\":\"").append(name).append("\",");
                        companionsJson.append("\"birth\":\"").append(birth).append("\",");
                        companionsJson.append("\"gender\":\"").append(gender).append("\"");
                        companionsJson.append("}");
                    }
                }
                
                companionsJson.append("]");
                reservation.setCompanions(companionsJson.toString());
            } else {
                reservation.setCompanions("[]");
            }
            
            registerScheduleService.saveReservation(reservation);
        }
        
        return "redirect:/admin/register_schedule/list";
    }
    
    // 예약 삭제 처리
    @PostMapping("/delete/{id}")
    @ResponseBody
    public String delete(@PathVariable Long id) {
        try {
            registerScheduleService.deleteReservation(id);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }
    
    // 예약상태 변경
    @PostMapping("/update-reservation-status/{id}")
    @ResponseBody
    public String updateReservationStatus(@PathVariable Long id, @RequestParam String status) {
        try {
            registerScheduleService.updateReservationStatus(id, status);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }
    
    // 결제상태 변경
    @PostMapping("/update-payment-status/{id}")
    @ResponseBody
    public String updatePaymentStatus(@PathVariable Long id, @RequestParam String status) {
        try {
            registerScheduleService.updatePaymentStatus(id, status);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }
    
    // 승인상태 변경
    @PostMapping("/update-approval-status/{id}")
    @ResponseBody
    public String updateApprovalStatus(@PathVariable Long id, @RequestParam String status) {
        try {
            registerScheduleService.updateApprovalStatus(id, status);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }
    
    // DTO 클래스
    public static class ReservationDto {
        private Long id;
        private String customerName;
        private String customerGender;
        private String customerPassport;
        private String customerPhone;
        private String customerEmail;
        private String customerBirth;
        private String customerAddress;
        private String customerAddressDetail;
        private String customerDetailAddress;
        private String customerEnglishAddress;
        private String customerKakaoId;
        private String uid;
        private String homeTeam;
        private String awayTeam;
        private String gameDate;
        private String gameTime;
        private String selectedColor;
        private String seatPrice;
        private Integer ticketQuantity;
        private String totalPrice;
        private String paymentMethod;
        private String seatAlternative;
        private String adjacentSeat;
        private String additionalRequests;
        private String companions;
        private String reservationStatus;
        private String paymentStatus;
        private String approvalStatus;
        private String createdAt;
        
        public ReservationDto(Long id, String customerName, String customerGender, String customerPassport,
                           String customerPhone, String customerEmail, String customerBirth, String customerAddress,
                           String customerAddressDetail, String customerDetailAddress, String customerEnglishAddress,
                           String customerKakaoId, String uid, String homeTeam, String awayTeam, String gameDate,
                           String gameTime, String selectedColor, String seatPrice, Integer ticketQuantity,
                           String totalPrice, String paymentMethod, String seatAlternative, String adjacentSeat,
                           String additionalRequests, String companions, String reservationStatus, String paymentStatus,
                           String approvalStatus, String createdAt) {
            this.id = id;
            this.customerName = customerName;
            this.customerGender = customerGender;
            this.customerPassport = customerPassport;
            this.customerPhone = customerPhone;
            this.customerEmail = customerEmail;
            this.customerBirth = customerBirth;
            this.customerAddress = customerAddress;
            this.customerAddressDetail = customerAddressDetail;
            this.customerDetailAddress = customerDetailAddress;
            this.customerEnglishAddress = customerEnglishAddress;
            this.customerKakaoId = customerKakaoId;
            this.uid = uid;
            this.homeTeam = homeTeam;
            this.awayTeam = awayTeam;
            this.gameDate = gameDate;
            this.gameTime = gameTime;
            this.selectedColor = selectedColor;
            this.seatPrice = seatPrice;
            this.ticketQuantity = ticketQuantity;
            this.totalPrice = totalPrice;
            this.paymentMethod = paymentMethod;
            this.seatAlternative = seatAlternative;
            this.adjacentSeat = adjacentSeat;
            this.additionalRequests = additionalRequests;
            this.companions = companions;
            this.reservationStatus = reservationStatus;
            this.paymentStatus = paymentStatus;
            this.approvalStatus = approvalStatus;
            this.createdAt = createdAt;
        }
        
        // Getter와 Setter
        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }
        
        public String getCustomerName() { return customerName; }
        public void setCustomerName(String customerName) { this.customerName = customerName; }
        
        public String getCustomerGender() { return customerGender; }
        public void setCustomerGender(String customerGender) { this.customerGender = customerGender; }
        
        public String getCustomerPassport() { return customerPassport; }
        public void setCustomerPassport(String customerPassport) { this.customerPassport = customerPassport; }
        
        public String getCustomerPhone() { return customerPhone; }
        public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }
        
        public String getCustomerEmail() { return customerEmail; }
        public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }
        
        public String getCustomerBirth() { return customerBirth; }
        public void setCustomerBirth(String customerBirth) { this.customerBirth = customerBirth; }
        
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
        
        public Integer getTicketQuantity() { return ticketQuantity; }
        public void setTicketQuantity(Integer ticketQuantity) { this.ticketQuantity = ticketQuantity; }
        
        public String getTotalPrice() { return totalPrice; }
        public void setTotalPrice(String totalPrice) { this.totalPrice = totalPrice; }
        
        public String getPaymentMethod() { return paymentMethod; }
        public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
        
        public String getSeatAlternative() { return seatAlternative; }
        public void setSeatAlternative(String seatAlternative) { this.seatAlternative = seatAlternative; }
        
        public String getAdjacentSeat() { return adjacentSeat; }
        public void setAdjacentSeat(String adjacentSeat) { this.adjacentSeat = adjacentSeat; }
        
        public String getAdditionalRequests() { return additionalRequests; }
        public void setAdditionalRequests(String additionalRequests) { this.additionalRequests = additionalRequests; }
        
        public String getCompanions() { return companions; }
        public void setCompanions(String companions) { this.companions = companions; }
        
        public String getReservationStatus() { return reservationStatus; }
        public void setReservationStatus(String reservationStatus) { this.reservationStatus = reservationStatus; }
        
        public String getPaymentStatus() { return paymentStatus; }
        public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
        
        public String getApprovalStatus() { return approvalStatus; }
        public void setApprovalStatus(String approvalStatus) { this.approvalStatus = approvalStatus; }
        
        public String getCreatedAt() { return createdAt; }
        public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
    }
} 