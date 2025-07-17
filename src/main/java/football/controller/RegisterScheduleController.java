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
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;

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
                      @RequestParam(required = false) String gameYear,
                      @RequestParam(required = false) String gameMonth,
                      Model model) {
        try {
            System.out.println("=== 예약목록 조회 시작 ===");
            System.out.println("요청된 페이지: " + page);
            System.out.println("검색 타입: " + searchType);
            System.out.println("검색 키워드: " + keyword);
            System.out.println("경기 년도: " + gameYear);
            System.out.println("경기 월: " + gameMonth);
            
            int size = 10; // 한 페이지당 10개로 변경
            Page<RegisterSchedule> reservationPage;
            
            // 경기날짜 검색 조건 구성
            String gameDateSearch = null;
            if (gameYear != null && !gameYear.trim().isEmpty() && gameMonth != null && !gameMonth.trim().isEmpty()) {
                gameDateSearch = gameYear + "-" + String.format("%02d", Integer.parseInt(gameMonth));
            } else if (gameYear != null && !gameYear.trim().isEmpty()) {
                gameDateSearch = gameYear;
            }
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                // 키워드 검색이 있는 경우
                switch (searchType) {
                    case "customerName":
                        reservationPage = registerScheduleService.searchByCustomerName(keyword, page, size);
                        break;
                    case "homeTeam":
                        reservationPage = registerScheduleService.searchByHomeTeam(keyword, page, size);
                        break;
                    case "awayTeam":
                        reservationPage = registerScheduleService.searchByAwayTeam(keyword, page, size);
                        break;
                    default:
                        reservationPage = registerScheduleService.searchByAll(keyword, page, size);
                        break;
                }
            } else if (gameDateSearch != null && !gameDateSearch.trim().isEmpty()) {
                // 경기날짜 검색이 있는 경우
                reservationPage = registerScheduleService.searchByGameDate(gameDateSearch, page, size);
            } else {
                // 검색이 없는 경우
                reservationPage = registerScheduleService.getAllReservations(page, size);
            }
            
            // DTO 변환
            List<ReservationDto> reservationDtos = reservationPage.getContent().stream()
                .map(reservation -> {
                    String createdAt = null;
                    if (reservation.getCreatedAt() != null) {
                        createdAt = reservation.getCreatedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                    }
                    
                    return new ReservationDto(
                        reservation.getId(),
                        reservation.getCustomerName(),
                        reservation.getCustomerGender(),
                        reservation.getCustomerPassport(),
                        reservation.getCustomerPhone(),
                        reservation.getCustomerEmail(),
                        reservation.getCustomerBirth() != null ? reservation.getCustomerBirth().toString() : null,
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
                        createdAt
                    );
                })
                .collect(Collectors.toList());
            
            System.out.println("=== 조회 결과 ===");
            System.out.println("전체 데이터 수: " + reservationPage.getTotalElements());
            System.out.println("현재 페이지 데이터 수: " + reservationPage.getContent().size());
            System.out.println("전체 페이지 수: " + reservationPage.getTotalPages());
            System.out.println("현재 페이지: " + page);
            System.out.println("페이지 크기: " + size);
            System.out.println("DTO 변환 완료 - 데이터 수: " + reservationDtos.size());
            
            // 디버깅용 DTO 내용 출력
            System.out.println("DTO 내용:");
            for (int i = 0; i < Math.min(reservationDtos.size(), 10); i++) {
                ReservationDto dto = reservationDtos.get(i);
                System.out.println("  " + (i + 1) + ". ID: " + dto.getId() + ", 이름: " + dto.getCustomerName() + ", 경기: " + dto.getHomeTeam() + " vs " + dto.getAwayTeam());
            }
            
            model.addAttribute("reservations", reservationDtos);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", reservationPage.getTotalPages());
            model.addAttribute("totalItems", reservationPage.getTotalElements());
            model.addAttribute("hasNext", reservationPage.hasNext());
            model.addAttribute("hasPrevious", reservationPage.hasPrevious());
            model.addAttribute("searchType", searchType);
            model.addAttribute("keyword", keyword);
            model.addAttribute("gameYear", gameYear);
            model.addAttribute("gameMonth", gameMonth);
            
            System.out.println("=== 예약목록 조회 완료 ===");
            return "admin/register_schedule/list";
        } catch (Exception e) {
            System.err.println("예약목록 조회 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "예약목록을 불러오는 중 오류가 발생했습니다.");
            return "admin/register_schedule/list";
        }
    }
    
    // 예약 상세보기 페이지
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Long id, Model model) {
        System.out.println("=== 예약 상세보기 페이지 요청 ===");
        System.out.println("요청된 예약 ID: " + id);
        
        Optional<RegisterSchedule> reservation = registerScheduleService.getReservationById(id);
        if (reservation.isPresent()) {
            RegisterSchedule reservationEntity = reservation.get();
            System.out.println("예약 정보 찾음: " + reservationEntity.getId());
            System.out.println("예약자명: " + reservationEntity.getCustomerName());
            
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            
            ReservationDto reservationDto = new ReservationDto(
                reservationEntity.getId(),
                reservationEntity.getCustomerName() != null ? reservationEntity.getCustomerName() : "",
                reservationEntity.getCustomerGender() != null ? reservationEntity.getCustomerGender() : "",
                reservationEntity.getCustomerPassport() != null ? reservationEntity.getCustomerPassport() : "",
                reservationEntity.getCustomerPhone() != null ? reservationEntity.getCustomerPhone() : "",
                reservationEntity.getCustomerEmail() != null ? reservationEntity.getCustomerEmail() : "",
                reservationEntity.getCustomerBirth() != null ? reservationEntity.getCustomerBirth().format(dateFormatter) : "",
                reservationEntity.getCustomerAddress() != null ? reservationEntity.getCustomerAddress() : "",
                reservationEntity.getCustomerAddressDetail() != null ? reservationEntity.getCustomerAddressDetail() : "",
                reservationEntity.getCustomerDetailAddress() != null ? reservationEntity.getCustomerDetailAddress() : "",
                reservationEntity.getCustomerEnglishAddress() != null ? reservationEntity.getCustomerEnglishAddress() : "",
                reservationEntity.getCustomerKakaoId() != null ? reservationEntity.getCustomerKakaoId() : "",
                reservationEntity.getUid() != null ? reservationEntity.getUid() : "",
                reservationEntity.getHomeTeam() != null ? reservationEntity.getHomeTeam() : "",
                reservationEntity.getAwayTeam() != null ? reservationEntity.getAwayTeam() : "",
                reservationEntity.getGameDate() != null ? reservationEntity.getGameDate() : "",
                reservationEntity.getGameTime() != null ? reservationEntity.getGameTime() : "",
                reservationEntity.getSelectedColor() != null ? reservationEntity.getSelectedColor() : "",
                reservationEntity.getSeatPrice() != null ? reservationEntity.getSeatPrice() : "",
                reservationEntity.getTicketQuantity() != null ? reservationEntity.getTicketQuantity() : 0,
                reservationEntity.getTotalPrice() != null ? reservationEntity.getTotalPrice() : "",
                reservationEntity.getPaymentMethod() != null ? reservationEntity.getPaymentMethod() : "",
                reservationEntity.getSeatAlternative() != null ? reservationEntity.getSeatAlternative() : "",
                reservationEntity.getAdjacentSeat() != null ? reservationEntity.getAdjacentSeat() : "",
                reservationEntity.getAdditionalRequests() != null ? reservationEntity.getAdditionalRequests() : "",
                reservationEntity.getCompanions() != null ? reservationEntity.getCompanions() : "",
                reservationEntity.getReservationStatus() != null ? reservationEntity.getReservationStatus() : "",
                reservationEntity.getPaymentStatus() != null ? reservationEntity.getPaymentStatus() : "",
                reservationEntity.getApprovalStatus() != null ? reservationEntity.getApprovalStatus() : "",
                reservationEntity.getCreatedAt() != null ? reservationEntity.getCreatedAt().format(dateTimeFormatter) : ""
            );
            
            model.addAttribute("reservation", reservationDto);
            System.out.println("모델에 예약 정보 추가 완료");
            System.out.println("예약자명: " + reservationDto.getCustomerName());
            System.out.println("홈팀: " + reservationDto.getHomeTeam());
            System.out.println("원정팀: " + reservationDto.getAwayTeam());
            System.out.println("경기날짜: " + reservationDto.getGameDate());
            System.out.println("경기시간: " + reservationDto.getGameTime());
            System.out.println("선택 좌석: " + reservationDto.getSelectedColor());
            System.out.println("티켓 수량: " + reservationDto.getTicketQuantity());
            System.out.println("총 금액: " + reservationDto.getTotalPrice());
            
            // 동행자 정보 파싱 (쉼표로 구분된 형태로 저장된 경우)
            List<Map<String, String>> companionsList = new ArrayList<>();
            String companionsJson = "[]";
            if (reservationEntity.getCompanions() != null && !reservationEntity.getCompanions().isEmpty()) {
                try {
                    // 쉼표로 구분된 동행자 정보 파싱
                    String[] companionsArray = reservationEntity.getCompanions().split(",");
                    for (int i = 0; i < companionsArray.length; i += 3) {
                        if (i + 2 < companionsArray.length) {
                            Map<String, String> companion = new HashMap<>();
                            companion.put("name", companionsArray[i].trim());
                            companion.put("birth", companionsArray[i + 1].trim());
                            companion.put("gender", companionsArray[i + 2].trim());
                            companionsList.add(companion);
                        }
                    }
                    companionsJson = reservationEntity.getCompanions();
                    System.out.println("동행자 정보 파싱 완료: " + companionsList.size() + "명");
                } catch (Exception e) {
                    System.err.println("동행자 정보 파싱 오류: " + e.getMessage());
                    // JSON 형태로 저장된 경우도 처리
                    try {
                        ObjectMapper objectMapper = new ObjectMapper();
                        companionsList = objectMapper.readValue(reservationEntity.getCompanions(), 
                            new TypeReference<List<Map<String, String>>>() {});
                        companionsJson = reservationEntity.getCompanions().replace("\"", "\\\"");
                        System.out.println("동행자 정보 JSON 파싱 완료: " + companionsList.size() + "명");
                    } catch (Exception jsonException) {
                        System.err.println("동행자 정보 JSON 파싱 오류: " + jsonException.getMessage());
                    }
                }
            } else {
                System.out.println("동행자 정보 없음");
            }
            model.addAttribute("companions", companionsList);
            model.addAttribute("companionsJson", companionsJson);
            
            System.out.println("상세보기 페이지 반환");
            return "admin/register_schedule/detail";
        } else {
            System.out.println("예약 정보를 찾을 수 없음: " + id);
            return "redirect:/admin/register_schedule/list";
        }
    }
    
    // 예약 수정 페이지
    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        Optional<RegisterSchedule> reservation = registerScheduleService.getReservationById(id);
        if (reservation.isPresent()) {
            RegisterSchedule reservationEntity = reservation.get();
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            
            ReservationDto reservationDto = new ReservationDto(
                reservationEntity.getId(),
                reservationEntity.getCustomerName(),
                reservationEntity.getCustomerGender(),
                reservationEntity.getCustomerPassport(),
                reservationEntity.getCustomerPhone(),
                reservationEntity.getCustomerEmail(),
                reservationEntity.getCustomerBirth() != null ? reservationEntity.getCustomerBirth().format(dateFormatter) : "",
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
                reservationEntity.getCreatedAt() != null ? reservationEntity.getCreatedAt().format(dateTimeFormatter) : ""
            );
            
            model.addAttribute("reservation", reservationDto);
            
            // 동행자 정보 파싱 (JSON 형태로 저장된 경우)
            List<Map<String, String>> companionsList = new ArrayList<>();
            String companionsJson = "[]";
            if (reservationEntity.getCompanions() != null && !reservationEntity.getCompanions().isEmpty()) {
                try {
                    ObjectMapper objectMapper = new ObjectMapper();
                    companionsList = objectMapper.readValue(reservationEntity.getCompanions(), 
                        new TypeReference<List<Map<String, String>>>() {});
                    companionsJson = reservationEntity.getCompanions(); // 원본 JSON 문자열 전달
                } catch (Exception e) {
                    System.err.println("동행자 정보 JSON 파싱 오류: " + e.getMessage());
                }
            }
            model.addAttribute("companions", companionsList);
            model.addAttribute("companionsJson", companionsJson);
            
            return "admin/register_schedule/edit";
        } else {
            return "redirect:/admin/register_schedule/list";
        }
    }
    
    // 예약 수정 처리
    @PostMapping("/edit/{id}")
    public String edit(@PathVariable Long id, @ModelAttribute ReservationDto reservationDto, 
                      HttpServletRequest request) {
        System.out.println("=== 예약 수정 처리 시작 ===");
        System.out.println("예약 ID: " + id);
        System.out.println("받은 selectedColor: " + reservationDto.getSelectedColor());
        
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
            // selectedColor가 null이면 기존 값 유지
            if (reservationDto.getSelectedColor() != null && !reservationDto.getSelectedColor().trim().isEmpty()) {
                reservation.setSelectedColor(reservationDto.getSelectedColor());
                System.out.println("selectedColor 업데이트: " + reservationDto.getSelectedColor());
            } else {
                System.out.println("selectedColor가 null이므로 기존 값 유지: " + reservation.getSelectedColor());
            }
            
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
                System.out.println("동행자 정보 업데이트: " + companionsJson.toString());
            } else {
                reservation.setCompanions("[]");
                System.out.println("동행자 정보 초기화: []");
            }
            
            System.out.println("저장할 예약 정보:");
            System.out.println("- selectedColor: " + reservation.getSelectedColor());
            System.out.println("- seatPrice: " + reservation.getSeatPrice());
            System.out.println("- ticketQuantity: " + reservation.getTicketQuantity());
            
            registerScheduleService.saveReservation(reservation);
            System.out.println("예약 수정 완료");
        }
        
        return "redirect:/admin/register_schedule/list";
    }
    
    // 예약 삭제
    @PostMapping("/delete/{id}")
    @ResponseBody
    public String deleteReservation(@PathVariable Long id) {
        try {
            registerScheduleService.deleteReservation(id);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
    
    // 예약상태 변경
    @PostMapping("/update-reservation-status/{id}")
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<String> updateReservationStatus(@PathVariable Long id, @RequestBody(required = false) Map<String, String> requestBody, @RequestParam(required = false) String status) {
        System.out.println("=== 예약 상태 업데이트 시작 ===");
        System.out.println("요청된 예약 ID: " + id);
        
        // JSON body에서 status를 가져오거나, 파라미터에서 가져오기
        String statusValue = null;
        if (requestBody != null && requestBody.containsKey("status")) {
            statusValue = requestBody.get("status");
            System.out.println("JSON body에서 가져온 상태: " + statusValue);
        } else if (status != null) {
            statusValue = status;
            System.out.println("파라미터에서 가져온 상태: " + statusValue);
        } else {
            System.err.println("오류: status 값이 제공되지 않았습니다.");
            return ResponseEntity.badRequest().body("error");
        }
        
        System.out.println("최종 사용할 상태: " + statusValue);
        System.out.println("현재 시간: " + java.time.LocalDateTime.now());
        
        try {
            System.out.println("서비스 호출 전 - 예약 상태 업데이트");
            registerScheduleService.updateReservationStatus(id, statusValue);
            System.out.println("서비스 호출 완료 - 예약 상태 업데이트");
            
            // register_ok 필드도 함께 업데이트
            if ("예약완료".equals(statusValue)) {
                System.out.println("예약완료 상태 감지 - register_ok 필드 업데이트 시작");
                registerScheduleService.updateRegisterOk(id, "Y");
                System.out.println("register_ok 필드 업데이트 완료");
            } else {
                System.out.println("예약완료 상태가 아님 - register_ok 필드 업데이트 건너뜀");
            }
            
            System.out.println("성공: 예약 상태 업데이트 완료");
            return ResponseEntity.ok().contentType(MediaType.TEXT_PLAIN).body("success");
        } catch (Exception e) {
            System.err.println("=== 예약 상태 업데이트 실패 ===");
            System.err.println("예외 타입: " + e.getClass().getName());
            System.err.println("예외 메시지: " + e.getMessage());
            System.err.println("예외 스택 트레이스:");
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).contentType(MediaType.TEXT_PLAIN).body("error");
        }
    }
    
    // 결제상태 변경
    @PostMapping("/update-payment-status/{id}")
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<String> updatePaymentStatus(@PathVariable Long id, @RequestBody(required = false) Map<String, String> requestBody, @RequestParam(required = false) String status) {
        System.out.println("=== 컨트롤러: 결제 상태 업데이트 시작 ===");
        System.out.println("요청된 예약 ID: " + id);
        
        // JSON body에서 status를 가져오거나, 파라미터에서 가져오기
        String statusValue = null;
        if (requestBody != null && requestBody.containsKey("status")) {
            statusValue = requestBody.get("status");
            System.out.println("JSON body에서 가져온 상태: " + statusValue);
        } else if (status != null) {
            statusValue = status;
            System.out.println("파라미터에서 가져온 상태: " + statusValue);
        } else {
            System.err.println("오류: status 값이 제공되지 않았습니다.");
            return ResponseEntity.badRequest().body("error");
        }
        
        System.out.println("최종 사용할 상태: " + statusValue);
        System.out.println("현재 시간: " + java.time.LocalDateTime.now());
        
        try {
            System.out.println("서비스 호출 전 - 결제 상태 업데이트");
            registerScheduleService.updatePaymentStatus(id, statusValue);
            System.out.println("서비스 호출 완료 - 결제 상태 업데이트");
            
            System.out.println("성공: 결제 상태 업데이트 완료");
            return ResponseEntity.ok().contentType(MediaType.TEXT_PLAIN).body("success");
        } catch (Exception e) {
            System.err.println("=== 컨트롤러: 결제 상태 업데이트 실패 ===");
            System.err.println("예외 타입: " + e.getClass().getName());
            System.err.println("예외 메시지: " + e.getMessage());
            System.err.println("예외 스택 트레이스:");
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).contentType(MediaType.TEXT_PLAIN).body("error");
        }
    }
    
    // 승인상태 변경
    @PostMapping("/update-approval-status/{id}")
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<String> updateApprovalStatus(@PathVariable Long id, @RequestBody(required = false) Map<String, String> requestBody, @RequestParam(required = false) String status) {
        System.out.println("=== 컨트롤러: 승인 상태 업데이트 시작 ===");
        System.out.println("요청된 예약 ID: " + id);
        
        // JSON body에서 status를 가져오거나, 파라미터에서 가져오기
        String statusValue = null;
        if (requestBody != null && requestBody.containsKey("status")) {
            statusValue = requestBody.get("status");
            System.out.println("JSON body에서 가져온 상태: " + statusValue);
        } else if (status != null) {
            statusValue = status;
            System.out.println("파라미터에서 가져온 상태: " + statusValue);
        } else {
            System.err.println("오류: status 값이 제공되지 않았습니다.");
            return ResponseEntity.badRequest().body("error");
        }
        
        System.out.println("최종 사용할 상태: " + statusValue);
        System.out.println("현재 시간: " + java.time.LocalDateTime.now());
        
        try {
            System.out.println("서비스 호출 전 - 승인 상태 업데이트");
            registerScheduleService.updateApprovalStatus(id, statusValue);
            System.out.println("서비스 호출 완료 - 승인 상태 업데이트");
            
            System.out.println("성공: 승인 상태 업데이트 완료");
            return ResponseEntity.ok().contentType(MediaType.TEXT_PLAIN).body("success");
        } catch (Exception e) {
            System.err.println("=== 컨트롤러: 승인 상태 업데이트 실패 ===");
            System.err.println("예외 타입: " + e.getClass().getName());
            System.err.println("예외 메시지: " + e.getMessage());
            System.err.println("예외 스택 트레이스:");
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).contentType(MediaType.TEXT_PLAIN).body("error");
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