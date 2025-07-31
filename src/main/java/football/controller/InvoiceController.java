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
import java.time.LocalDate;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;

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
                      @RequestParam(required = false) Integer searchYear,
                      @RequestParam(required = false) Integer searchMonth,
                      Model model) {
        
        System.out.println("=== 인보이스 목록 조회 시작 ===");
        System.out.println("요청된 페이지: " + page);
        System.out.println("검색 타입: " + searchType);
        System.out.println("검색 키워드: " + keyword);
        System.out.println("검색 년도: " + searchYear);
        System.out.println("검색 월: " + searchMonth);
        
        // 현재 년도와 다음 년도 계산
        int thisYear = LocalDate.now().getYear();
        int nextYear = thisYear + 1;
        
        // 선택된 년/월 설정 (파라미터가 없으면 현재 년/월)
        int selectedYear = (searchYear != null) ? searchYear : thisYear;
        int selectedMonth = (searchMonth != null) ? searchMonth : LocalDate.now().getMonthValue();
        
        // 년/월별 경기 수 계산 (예약완료 상태만)
        Map<Integer, Map<Integer, Integer>> yearMonthCounts = new HashMap<>();
        yearMonthCounts.put(thisYear, new HashMap<>());
        yearMonthCounts.put(nextYear, new HashMap<>());
        
        // 각 년/월별 경기 수 조회 (예약완료 상태만)
        for (int year : yearMonthCounts.keySet()) {
            for (int month = 1; month <= 12; month++) {
                String yearMonthStr = String.format("%04d-%02d", year, month);
                // 예약완료 상태인 경기만 카운트
                long count = registerScheduleService.countByGameDateLikeWithQueryAndStatus(yearMonthStr + "%", "예약완료");
                yearMonthCounts.get(year).put(month, (int) count);
                
                // 디버깅용 로그 추가
                System.out.println(year + "년 " + month + "월 인보이스 수: " + count + " (검색 패턴: " + yearMonthStr + "%)");
            }
        }
        
        Page<RegisterSchedule> reservationPage;
        
        // 경기날짜 검색 조건 구성
        String gameDateSearch = null;
        if (searchYear != null && searchMonth != null) {
            gameDateSearch = String.format("%04d-%02d", searchYear, searchMonth);
        }
        
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
        } else if (gameDateSearch != null && !gameDateSearch.trim().isEmpty()) {
            // 경기날짜 검색이 있는 경우 (예약완료 상태만)
            reservationPage = registerScheduleService.searchByGameDateAndReservationStatus(gameDateSearch, "예약완료", page, 10);
        } else {
            // 검색이 없는 경우 (예약완료 상태만)
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
                    reservation.getUid(),
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
                    reservation.getCreatedAt() != null ? reservation.getCreatedAt().format(formatter) : "",
                    reservation.getSeatPrice(),
                    reservation.getSelectedColor()
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
        model.addAttribute("searchType", searchType);
        model.addAttribute("keyword", keyword);
        model.addAttribute("searchYear", searchYear);
        model.addAttribute("searchMonth", searchMonth);
        model.addAttribute("yearMonthCounts", yearMonthCounts);
        model.addAttribute("thisYear", thisYear);
        model.addAttribute("nextYear", nextYear);
        model.addAttribute("selectedYear", selectedYear);
        model.addAttribute("selectedMonth", selectedMonth);
        
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
                reservationEntity.getUid(),
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
                reservationEntity.getCreatedAt() != null ? reservationEntity.getCreatedAt().format(formatter) : "",
                reservationEntity.getSeatPrice(),
                reservationEntity.getSelectedColor()
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

    // 일괄 삭제 기능
    @PostMapping("/bulk-delete")
    @ResponseBody
    public Map<String, Object> bulkDelete(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            System.out.println("=== 인보이스 일괄 삭제 요청 시작 ===");
            
            @SuppressWarnings("unchecked")
            List<Object> rawIds = (List<Object>) request.get("ids");
            
            // String을 Long으로 변환
            List<Long> ids = new ArrayList<>();
            for (Object rawId : rawIds) {
                if (rawId instanceof String) {
                    ids.add(Long.parseLong((String) rawId));
                } else if (rawId instanceof Number) {
                    ids.add(((Number) rawId).longValue());
                } else {
                    throw new IllegalArgumentException("Invalid ID type: " + rawId.getClass().getName());
                }
            }
            
            if (ids == null || ids.isEmpty()) {
                System.out.println("삭제할 인보이스 ID가 없습니다.");
                response.put("success", false);
                response.put("message", "삭제할 인보이스를 선택해주세요.");
                return response;
            }
            
            System.out.println("삭제할 인보이스 ID 목록: " + ids);
            
            int deletedCount = 0;
            List<String> failedItems = new ArrayList<>();
            
            for (Long id : ids) {
                try {
                    Optional<RegisterSchedule> reservation = registerScheduleService.getReservationById(id);
                    if (reservation.isPresent()) {
                        registerScheduleService.deleteReservation(id);
                        deletedCount++;
                        System.out.println("인보이스 삭제 완료: id=" + id);
                    } else {
                        failedItems.add("ID " + id + " (존재하지 않음)");
                        System.out.println("삭제할 인보이스를 찾을 수 없음: id=" + id);
                    }
                } catch (Exception e) {
                    failedItems.add("ID " + id + " (삭제 실패)");
                    System.err.println("인보이스 삭제 중 오류 발생: id=" + id + ", 오류: " + e.getMessage());
                    e.printStackTrace();
                }
            }
            
            System.out.println("인보이스 일괄 삭제 완료: 성공 " + deletedCount + "개, 실패 " + failedItems.size() + "개");
            
            response.put("success", true);
            response.put("deletedCount", deletedCount);
            response.put("totalRequested", ids.size());
            response.put("failedItems", failedItems);
            
            if (!failedItems.isEmpty()) {
                response.put("message", String.format("%d개 삭제 완료, %d개 실패", deletedCount, failedItems.size()));
            } else {
                response.put("message", String.format("%d개의 인보이스가 성공적으로 삭제되었습니다.", deletedCount));
            }
            
        } catch (Exception e) {
            System.err.println("인보이스 일괄 삭제 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "일괄 삭제 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return response;
    }
    
    // DTO 클래스
    public static class InvoiceDto {
        private Long id;
        private String uid;
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
        private String seatPrice;
        private String selectedColor;
        
        public InvoiceDto(Long id, String uid, String customerName, String homeTeam, String awayTeam, 
                        String gameDate, String gameTime, Integer ticketQuantity, String totalPrice,
                        String customerPhone, String customerEmail, String customerAddress,
                        String customerAddressDetail, String customerDetailAddress, String customerEnglishAddress,
                        String paymentMethod, String reservationStatus, String paymentStatus,
                        String approvalStatus, String createdAt, String seatPrice, String selectedColor) {
            this.id = id;
            this.uid = uid;
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
            this.seatPrice = seatPrice;
            this.selectedColor = selectedColor;
        }
        
        // Getter와 Setter
        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }
        
        public String getUid() { return uid; }
        public void setUid(String uid) { this.uid = uid; }
        
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
        
        public String getSeatPrice() { return seatPrice; }
        public void setSeatPrice(String seatPrice) { this.seatPrice = seatPrice; }
        
        public String getSelectedColor() { return selectedColor; }
        public void setSelectedColor(String selectedColor) { this.selectedColor = selectedColor; }
    }
} 