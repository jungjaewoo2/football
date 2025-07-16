package football.controller;

import football.entity.RegisterSchedule;
import football.service.RegisterScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin/invoice")
public class InvoiceController {
    
    @Autowired
    private RegisterScheduleService registerScheduleService;
    
    // 인보이스 목록 페이지
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "0") int page,
                      @RequestParam(required = false) String searchType,
                      @RequestParam(required = false) String keyword,
                      Model model) {
        
        System.out.println("=== 인보이스 목록 조회 시작 ===");
        System.out.println("요청된 페이지: " + page);
        System.out.println("검색 타입: " + searchType);
        System.out.println("검색 키워드: " + keyword);
        
        Page<RegisterSchedule> reservationPage;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            switch (searchType) {
                case "customerName":
                    reservationPage = registerScheduleService.searchByCustomerNameAndReservationStatus(keyword, "예약완료", page, 10);
                    break;
                case "homeTeam":
                    reservationPage = registerScheduleService.searchByHomeTeamAndReservationStatus(keyword, "예약완료", page, 10);
                    break;
                case "awayTeam":
                    reservationPage = registerScheduleService.searchByAwayTeamAndReservationStatus(keyword, "예약완료", page, 10);
                    break;
                default:
                    reservationPage = registerScheduleService.searchByAllAndReservationStatus(keyword, "예약완료", page, 10);
                    break;
            }
            model.addAttribute("searchType", searchType);
            model.addAttribute("keyword", keyword);
        } else {
            reservationPage = registerScheduleService.getReservationsByReservationStatus("예약완료", page, 10);
        }
        
        System.out.println("=== 조회 결과 ===");
        System.out.println("전체 데이터 수: " + reservationPage.getTotalElements());
        System.out.println("현재 페이지 데이터 수: " + reservationPage.getContent().size());
        System.out.println("전체 페이지 수: " + reservationPage.getTotalPages());
        System.out.println("현재 페이지: " + reservationPage.getNumber());
        
        // 날짜 포맷팅을 위한 DTO 변환
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        var invoiceDtos = reservationPage.getContent().stream()
            .map(reservation -> {
                return new InvoiceDto(
                    reservation.getId(),
                    reservation.getCustomerName(),
                    reservation.getHomeTeam(),
                    reservation.getAwayTeam(),
                    reservation.getGameDate(),
                    reservation.getGameTime(),
                    reservation.getTicketQuantity(),
                    reservation.getTotalPrice(),
                    reservation.getCustomerPhone(),
                    reservation.getCustomerEmail(),
                    reservation.getCustomerAddress(),
                    reservation.getCustomerAddressDetail(),
                    reservation.getCustomerDetailAddress(),
                    reservation.getCustomerEnglishAddress(),
                    reservation.getPaymentMethod(),
                    reservation.getReservationStatus(),
                    reservation.getPaymentStatus(),
                    reservation.getApprovalStatus(),
                    reservation.getCreatedAt() != null ? reservation.getCreatedAt().format(formatter) : ""
                );
            })
            .collect(Collectors.toList());
        
        System.out.println("DTO 변환 완료 - 데이터 수: " + invoiceDtos.size());
        
        model.addAttribute("invoices", invoiceDtos);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", reservationPage.getTotalPages());
        model.addAttribute("totalItems", reservationPage.getTotalElements());
        model.addAttribute("hasNext", reservationPage.hasNext());
        model.addAttribute("hasPrevious", reservationPage.hasPrevious());
        
        System.out.println("=== 인보이스 목록 조회 완료 ===");
        
        return "admin/invoice/list";
    }
    
    // 인보이스 상세보기 페이지
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Long id, Model model) {
        Optional<RegisterSchedule> reservation = registerScheduleService.getReservationById(id);
        if (reservation.isPresent()) {
            RegisterSchedule reservationEntity = reservation.get();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            
            InvoiceDto invoiceDto = new InvoiceDto(
                reservationEntity.getId(),
                reservationEntity.getCustomerName(),
                reservationEntity.getHomeTeam(),
                reservationEntity.getAwayTeam(),
                reservationEntity.getGameDate(),
                reservationEntity.getGameTime(),
                reservationEntity.getTicketQuantity(),
                reservationEntity.getTotalPrice(),
                reservationEntity.getCustomerPhone(),
                reservationEntity.getCustomerEmail(),
                reservationEntity.getCustomerAddress(),
                reservationEntity.getCustomerAddressDetail(),
                reservationEntity.getCustomerDetailAddress(),
                reservationEntity.getCustomerEnglishAddress(),
                reservationEntity.getPaymentMethod(),
                reservationEntity.getReservationStatus(),
                reservationEntity.getPaymentStatus(),
                reservationEntity.getApprovalStatus(),
                reservationEntity.getCreatedAt() != null ? reservationEntity.getCreatedAt().format(formatter) : ""
            );
            
            model.addAttribute("invoice", invoiceDto);
            
            return "admin/invoice/detail";
        } else {
            return "redirect:/admin/invoice/list";
        }
    }
    
    // 인보이스 삭제
    @PostMapping("/delete/{id}")
    @ResponseBody
    public String delete(@PathVariable Long id) {
        try {
            registerScheduleService.deleteReservation(id);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
    
    // DTO 클래스
    public static class InvoiceDto {
        private Long id;
        private String customerName;
        private String homeTeam;
        private String awayTeam;
        private String gameDate;
        private String gameTime;
        private Integer ticketQuantity;
        private String totalPrice;
        private String customerPhone;
        private String customerEmail;
        private String customerAddress;
        private String customerAddressDetail;
        private String customerDetailAddress;
        private String customerEnglishAddress;
        private String paymentMethod;
        private String reservationStatus;
        private String paymentStatus;
        private String approvalStatus;
        private String createdAt;
        
        public InvoiceDto(Long id, String customerName, String homeTeam, String awayTeam, 
                        String gameDate, String gameTime, Integer ticketQuantity, String totalPrice,
                        String customerPhone, String customerEmail, String customerAddress,
                        String customerAddressDetail, String customerDetailAddress, String customerEnglishAddress,
                        String paymentMethod, String reservationStatus, String paymentStatus,
                        String approvalStatus, String createdAt) {
            this.id = id;
            this.customerName = customerName;
            this.homeTeam = homeTeam;
            this.awayTeam = awayTeam;
            this.gameDate = gameDate;
            this.gameTime = gameTime;
            this.ticketQuantity = ticketQuantity;
            this.totalPrice = totalPrice;
            this.customerPhone = customerPhone;
            this.customerEmail = customerEmail;
            this.customerAddress = customerAddress;
            this.customerAddressDetail = customerAddressDetail;
            this.customerDetailAddress = customerDetailAddress;
            this.customerEnglishAddress = customerEnglishAddress;
            this.paymentMethod = paymentMethod;
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
        
        public String getHomeTeam() { return homeTeam; }
        public void setHomeTeam(String homeTeam) { this.homeTeam = homeTeam; }
        
        public String getAwayTeam() { return awayTeam; }
        public void setAwayTeam(String awayTeam) { this.awayTeam = awayTeam; }
        
        public String getGameDate() { return gameDate; }
        public void setGameDate(String gameDate) { this.gameDate = gameDate; }
        
        public String getGameTime() { return gameTime; }
        public void setGameTime(String gameTime) { this.gameTime = gameTime; }
        
        public Integer getTicketQuantity() { return ticketQuantity; }
        public void setTicketQuantity(Integer ticketQuantity) { this.ticketQuantity = ticketQuantity; }
        
        public String getTotalPrice() { return totalPrice; }
        public void setTotalPrice(String totalPrice) { this.totalPrice = totalPrice; }
        
        public String getCustomerPhone() { return customerPhone; }
        public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }
        
        public String getCustomerEmail() { return customerEmail; }
        public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }
        
        public String getCustomerAddress() { return customerAddress; }
        public void setCustomerAddress(String customerAddress) { this.customerAddress = customerAddress; }
        
        public String getCustomerAddressDetail() { return customerAddressDetail; }
        public void setCustomerAddressDetail(String customerAddressDetail) { this.customerAddressDetail = customerAddressDetail; }
        
        public String getCustomerDetailAddress() { return customerDetailAddress; }
        public void setCustomerDetailAddress(String customerDetailAddress) { this.customerDetailAddress = customerDetailAddress; }
        
        public String getCustomerEnglishAddress() { return customerEnglishAddress; }
        public void setCustomerEnglishAddress(String customerEnglishAddress) { this.customerEnglishAddress = customerEnglishAddress; }
        
        public String getPaymentMethod() { return paymentMethod; }
        public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
        
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