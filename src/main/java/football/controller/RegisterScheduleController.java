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
import java.time.LocalDate;

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
        
        System.out.println("=== 예약목록 조회 시작 ===");
        System.out.println("요청된 페이지: " + page);
        System.out.println("검색 타입: " + searchType);
        System.out.println("검색 키워드: " + keyword);
        
        Page<RegisterSchedule> reservationPage;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            switch (searchType) {
                case "customerName":
                    reservationPage = registerScheduleService.searchByCustomerName(keyword, page, 50);
                    break;
                case "homeTeam":
                    reservationPage = registerScheduleService.searchByHomeTeam(keyword, page, 50);
                    break;
                case "awayTeam":
                    reservationPage = registerScheduleService.searchByAwayTeam(keyword, page, 50);
                    break;
                default:
                    reservationPage = registerScheduleService.getAllReservations(page, 50);
                    break;
            }
            model.addAttribute("searchType", searchType);
            model.addAttribute("keyword", keyword);
        } else {
            reservationPage = registerScheduleService.getAllReservations(page, 50);
        }
        
        System.out.println("=== 조회 결과 ===");
        System.out.println("전체 데이터 수: " + reservationPage.getTotalElements());
        System.out.println("현재 페이지 데이터 수: " + reservationPage.getContent().size());
        System.out.println("전체 페이지 수: " + reservationPage.getTotalPages());
        System.out.println("현재 페이지: " + reservationPage.getNumber());
        System.out.println("페이지 크기: " + reservationPage.getSize());
        
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
        
        System.out.println("DTO 변환 완료 - 데이터 수: " + reservationDtos.size());
        System.out.println("DTO 내용:");
        for (int i = 0; i < reservationDtos.size(); i++) {
            ReservationDto dto = reservationDtos.get(i);
            System.out.println("  " + (i + 1) + ". ID: " + dto.getId() + ", 이름: " + dto.getCustomerName() + ", 경기: " + dto.getHomeTeam() + " vs " + dto.getAwayTeam());
        }
        
        model.addAttribute("reservations", reservationDtos);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", reservationPage.getTotalPages());
        model.addAttribute("totalItems", reservationPage.getTotalElements());
        model.addAttribute("hasNext", reservationPage.hasNext());
        model.addAttribute("hasPrevious", reservationPage.hasPrevious());
        
        System.out.println("=== 예약목록 조회 완료 ===");
        
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
        System.out.println("=== 예약 상태 업데이트 시작 ===");
        System.out.println("요청된 예약 ID: " + id);
        System.out.println("요청된 상태: " + status);
        System.out.println("현재 시간: " + java.time.LocalDateTime.now());
        
        try {
            System.out.println("서비스 호출 전 - 예약 상태 업데이트");
            registerScheduleService.updateReservationStatus(id, status);
            System.out.println("서비스 호출 완료 - 예약 상태 업데이트");
            
            // register_ok 필드도 함께 업데이트
            if ("예약완료".equals(status)) {
                System.out.println("예약완료 상태 감지 - register_ok 필드 업데이트 시작");
                registerScheduleService.updateRegisterOk(id, "Y");
                System.out.println("register_ok 필드 업데이트 완료");
            } else {
                System.out.println("예약완료 상태가 아님 - register_ok 필드 업데이트 건너뜀");
            }
            
            System.out.println("성공: 예약 상태 업데이트 완료");
            return "success";
        } catch (Exception e) {
            System.err.println("=== 예약 상태 업데이트 실패 ===");
            System.err.println("예외 타입: " + e.getClass().getName());
            System.err.println("예외 메시지: " + e.getMessage());
            System.err.println("예외 스택 트레이스:");
            e.printStackTrace();
            return "error";
        }
    }
    
    // 결제상태 변경
    @PostMapping("/update-payment-status/{id}")
    @ResponseBody
    public String updatePaymentStatus(@PathVariable Long id, @RequestParam String status) {
        System.out.println("=== 컨트롤러: 결제 상태 업데이트 시작 ===");
        System.out.println("요청된 예약 ID: " + id);
        System.out.println("요청된 상태: " + status);
        System.out.println("현재 시간: " + java.time.LocalDateTime.now());
        
        try {
            System.out.println("서비스 호출 전 - 결제 상태 업데이트");
            registerScheduleService.updatePaymentStatus(id, status);
            System.out.println("서비스 호출 완료 - 결제 상태 업데이트");
            
            System.out.println("성공: 결제 상태 업데이트 완료");
            return "success";
        } catch (Exception e) {
            System.err.println("=== 컨트롤러: 결제 상태 업데이트 실패 ===");
            System.err.println("예외 타입: " + e.getClass().getName());
            System.err.println("예외 메시지: " + e.getMessage());
            System.err.println("예외 스택 트레이스:");
            e.printStackTrace();
            return "error";
        }
    }
    
    // 승인상태 변경
    @PostMapping("/update-approval-status/{id}")
    @ResponseBody
    public String updateApprovalStatus(@PathVariable Long id, @RequestParam String status) {
        System.out.println("=== 컨트롤러: 승인 상태 업데이트 시작 ===");
        System.out.println("요청된 예약 ID: " + id);
        System.out.println("요청된 상태: " + status);
        System.out.println("현재 시간: " + java.time.LocalDateTime.now());
        
        try {
            System.out.println("서비스 호출 전 - 승인 상태 업데이트");
            registerScheduleService.updateApprovalStatus(id, status);
            System.out.println("서비스 호출 완료 - 승인 상태 업데이트");
            
            System.out.println("성공: 승인 상태 업데이트 완료");
            return "success";
        } catch (Exception e) {
            System.err.println("=== 컨트롤러: 승인 상태 업데이트 실패 ===");
            System.err.println("예외 타입: " + e.getClass().getName());
            System.err.println("예외 메시지: " + e.getMessage());
            System.err.println("예외 스택 트레이스:");
            e.printStackTrace();
            return "error";
        }
    }
    
    // 테스트 데이터 삽입 (개발용)
    @PostMapping("/insert-test-data")
    @ResponseBody
    public String insertTestData() {
        try {
            System.out.println("=== 실제 축구 예약 데이터 삽입 시작 ===");
            
            // 실제 축구 경기 데이터
            String[][] matches = {
                {"맨체스터 유나이티드", "리버풀", "2024-01-15", "20:00"},
                {"첼시", "아스널", "2024-01-22", "19:30"},
                {"맨체스터 시티", "토트넘", "2024-01-29", "21:00"},
                {"에버튼", "웨스트햄", "2024-02-05", "20:00"},
                {"뉴캐슬", "브라이튼", "2024-02-12", "19:30"},
                {"크리스탈 팰리스", "번리", "2024-02-19", "21:00"},
                {"울버햄튼", "아스톤 빌라", "2024-02-26", "20:00"},
                {"브렌트포드", "풀럼", "2024-03-05", "19:30"},
                {"노팅엄 포레스트", "본머스", "2024-03-12", "21:00"},
                {"셰필드 유나이티드", "루턴 타운", "2024-03-19", "20:00"}
            };
            
            String[] customerNames = {
                "김철수", "이영희", "박민수", "최지영", "정현우",
                "한소영", "윤태호", "임수진", "강동원", "신미영"
            };
            
            String[] phoneNumbers = {
                "010-1234-5678", "010-2345-6789", "010-3456-7890", "010-4567-8901", "010-5678-9012",
                "010-6789-0123", "010-7890-1234", "010-8901-2345", "010-9012-3456", "010-0123-4567"
            };
            
            String[] addresses = {
                "서울특별시 강남구 테헤란로 123", "서울특별시 서초구 서초대로 456", "서울특별시 송파구 올림픽로 789",
                "서울특별시 마포구 와우산로 321", "서울특별시 종로구 종로 654", "서울특별시 용산구 이태원로 987",
                "서울특별시 영등포구 여의대로 147", "서울특별시 광진구 능동로 258", "서울특별시 성동구 왕십리로 369",
                "서울특별시 중구 을지로 741"
            };
            
            // 10개의 실제 데이터 생성
            for (int i = 0; i < 10; i++) {
                RegisterSchedule reservation = new RegisterSchedule();
                
                // 고객 정보
                reservation.setCustomerName(customerNames[i]);
                reservation.setCustomerGender(i % 2 == 0 ? "남성" : "여성");
                reservation.setCustomerPassport("M12345678" + String.format("%02d", i + 1));
                reservation.setCustomerPhone(phoneNumbers[i]);
                reservation.setCustomerEmail("customer" + (i + 1) + "@football.com");
                reservation.setCustomerBirth(LocalDate.of(1985 + (i % 15), 1 + (i % 12), 1 + (i % 28)));
                reservation.setCustomerAddress(addresses[i]);
                reservation.setCustomerAddressDetail((i + 1) + "동 " + (i + 1) + "0" + (i + 1) + "호");
                reservation.setCustomerDetailAddress("상세주소 " + (i + 1));
                reservation.setCustomerEnglishAddress("English Address " + (i + 1));
                reservation.setCustomerKakaoId("kakao" + (i + 1));
                reservation.setUid("UID" + String.format("%06d", i + 1));
                
                // 경기 정보
                reservation.setHomeTeam(matches[i][0]);
                reservation.setAwayTeam(matches[i][1]);
                reservation.setGameDate(matches[i][2]);
                reservation.setGameTime(matches[i][3]);
                reservation.setSelectedColor(i % 3 == 0 ? "빨강" : (i % 3 == 1 ? "파랑" : "초록"));
                reservation.setSeatPrice("50,000원");
                reservation.setTicketQuantity(1 + (i % 3));
                reservation.setTotalPrice(String.valueOf((1 + (i % 3)) * 50000));
                reservation.setPaymentMethod(i % 2 == 0 ? "신용카드" : "계좌이체");
                reservation.setSeatAlternative("Y");
                reservation.setAdjacentSeat("Y");
                reservation.setAdditionalRequests("좋은 자리로 부탁드립니다.");
                
                // 동행자 정보 (JSON 형태)
                if (i % 2 == 0) { // 짝수 인덱스만 동행자 있음
                    String companionsJson = "[{\"name\":\"" + customerNames[i] + " 동행자\",\"passport\":\"M87654321" + String.format("%02d", i + 1) + "\",\"phone\":\"" + phoneNumbers[(i + 1) % 10] + "\"}]";
                    reservation.setCompanions(companionsJson);
                } else {
                    reservation.setCompanions("");
                }
                
                // 상태 정보 (다양한 상태로 설정)
                String[] reservationStatuses = {"예약대기", "예약완료", "예약대기", "예약완료", "예약대기"};
                String[] paymentStatuses = {"미결제", "결제완료", "미결제", "결제완료", "미결제"};
                String[] approvalStatuses = {"대기중", "승인완료", "대기중", "승인완료", "대기중"};
                
                reservation.setReservationStatus(reservationStatuses[i % 5]);
                reservation.setPaymentStatus(paymentStatuses[i % 5]);
                reservation.setApprovalStatus(approvalStatuses[i % 5]);
                reservation.setRegisterOk(reservationStatuses[i % 5].equals("예약완료") ? "Y" : "N");
                
                registerScheduleService.saveReservation(reservation);
                System.out.println("실제 데이터 " + (i + 1) + " 삽입 완료: " + customerNames[i] + " - " + matches[i][0] + " vs " + matches[i][1]);
            }
            
            System.out.println("=== 실제 축구 예약 데이터 삽입 완료 ===");
            return "10개의 실제 축구 예약 데이터가 성공적으로 삽입되었습니다.";
        } catch (Exception e) {
            System.err.println("테스트 데이터 삽입 실패: " + e.getMessage());
            e.printStackTrace();
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