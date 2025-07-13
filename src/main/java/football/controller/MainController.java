package football.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import football.dto.ReservationEmailDto;
import football.entity.RegisterSchedule;
import football.entity.ScheduleInfo;
import football.entity.SeatFee;
import football.entity.TeamInfo;
import football.service.EmailService;
import football.service.RegisterScheduleService;
import football.service.ScheduleInfoService;
import football.service.SeatFeeService;
import football.service.TeamInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import football.entity.Faq;
import football.service.FaqService;
import org.springframework.data.domain.Page;
import java.util.stream.Collectors;

@Controller
public class MainController {
    
    private static final Logger logger = LoggerFactory.getLogger(MainController.class);
    
    @Autowired
    private ScheduleInfoService scheduleInfoService;
    
    @Autowired
    private SeatFeeService seatFeeService;
    
    @Autowired
    private TeamInfoService teamInfoService;
    
    @Autowired
    private EmailService emailService;
    
    @Autowired
    private RegisterScheduleService registerScheduleService;
    
    @Autowired
    private FaqService faqService;
    
    @GetMapping("/")
    public String index() {
        return "index";
    }
    
    @GetMapping("/account")
    public String account() {
        return "account";
    }
    
    @GetMapping("/account-list")
    public String accountList(Model model) {
        // 현재 월의 일정 데이터 가져오기
        List<ScheduleInfo> currentMonthSchedules = scheduleInfoService.getSchedulesByCurrentMonth();
        
        // 현재 날짜 정보
        LocalDate now = LocalDate.now();
        String currentYearMonth = now.format(DateTimeFormatter.ofPattern("yyyy년 MM월"));
        
        model.addAttribute("schedules", currentMonthSchedules);
        model.addAttribute("currentYearMonth", currentYearMonth);
        
        return "account-list";
    }
    
    @GetMapping("/account-detail")
    public String accountDetail(@RequestParam Integer uid, Model model) {
        logger.info("account-detail 요청: uid={}", uid);
        
        try {
            // uid로 해당 일정 정보 조회
            Optional<ScheduleInfo> scheduleInfo = scheduleInfoService.findById(uid);
            
            if (scheduleInfo.isPresent()) {
                ScheduleInfo schedule = scheduleInfo.get();
                logger.info("일정 정보 조회 성공: uid={}, homeTeam={}, otherTeam={}, gameDate={}", 
                    schedule.getUid(), schedule.getHomeTeam(), schedule.getOtherTeam(), schedule.getGameDate());
                
                // schedule의 fee 값으로 seat_fee 테이블에서 해당하는 데이터 조회
                if (schedule.getFee() != null) {
                    logger.info("좌석 요금 조회 시도: fee={}", schedule.getFee());
                    Optional<SeatFee> seatFee = seatFeeService.getSeatFeeById(schedule.getFee());
                    if (seatFee.isPresent()) {
                        model.addAttribute("seatFee", seatFee.get());
                        logger.info("좌석 요금 조회 성공: fee={}", schedule.getFee());
                    } else {
                        logger.warn("좌석 요금 정보를 찾을 수 없음: fee={}", schedule.getFee());
                    }
                } else {
                    logger.warn("일정의 fee 값이 null임: uid={}", uid);
                }
                
                // 홈팀의 좌석 이미지 조회
                Optional<TeamInfo> teamInfo = teamInfoService.findByTeamName(schedule.getHomeTeam());
                if (teamInfo.isPresent() && teamInfo.get().getSeatImg() != null) {
                    model.addAttribute("homeTeamSeatImg", teamInfo.get().getSeatImg());
                    logger.info("홈팀 좌석 이미지 조회 성공: team={}, image={}", 
                        schedule.getHomeTeam(), teamInfo.get().getSeatImg());
                } else {
                    logger.warn("홈팀 좌석 이미지를 찾을 수 없음: team={}", schedule.getHomeTeam());
                }
                
                model.addAttribute("schedule", schedule);
                logger.info("account-detail 페이지 렌더링 준비 완료");
                return "account-detail";
            } else {
                logger.warn("일정 정보를 찾을 수 없음: uid={}", uid);
                // 일정을 찾을 수 없는 경우 account-list로 리다이렉트
                return "redirect:/account-list";
            }
        } catch (Exception e) {
            logger.error("account-detail 처리 중 오류 발생: uid={}, error={}", uid, e.getMessage(), e);
            return "redirect:/account-list";
        }
    }

    @GetMapping("/account-detail-2")
    public String accountDetail2(
        @RequestParam(required = false) String scheduleId,
        @RequestParam(required = false) String homeTeam,
        @RequestParam(required = false) String awayTeam,
        @RequestParam(required = false) String gameDate,
        @RequestParam(required = false) String gameTime,
        @RequestParam(required = false) String selectedColor,
        @RequestParam(required = false) String seatPrice,
        Model model
    ) {
        model.addAttribute("scheduleId", scheduleId);
        model.addAttribute("homeTeam", homeTeam);
        model.addAttribute("awayTeam", awayTeam);
        model.addAttribute("gameDate", gameDate);
        model.addAttribute("gameTime", gameTime);
        model.addAttribute("selectedColor", selectedColor);
        model.addAttribute("seatPrice", seatPrice);
        return "account-detail-2";
    }

    @GetMapping("/account-detail-3")
    public String accountDetail3(@RequestParam(required = false) Integer uid,
                                @RequestParam(required = false) String homeTeam,
                                @RequestParam(required = false) String awayTeam,
                                @RequestParam(required = false) String gameDate,
                                @RequestParam(required = false) String gameTime,
                                @RequestParam(required = false) String selectedColor,
                                @RequestParam(required = false) String seatPrice,
                                Model model) {
        try {
            logger.info("account-detail-3 페이지 요청: uid={}", uid);
            
            if (uid != null) {
                // schedule_info 테이블에서 uid로 데이터 조회
                Optional<ScheduleInfo> scheduleInfo = scheduleInfoService.findById(uid);
                if (scheduleInfo.isPresent()) {
                    ScheduleInfo schedule = scheduleInfo.get();
                    model.addAttribute("scheduleInfo", schedule);
                    
                    // 홈팀의 좌석 이미지 조회
                    Optional<TeamInfo> teamInfo = teamInfoService.findByTeamName(schedule.getHomeTeam());
                    if (teamInfo.isPresent() && teamInfo.get().getSeatImg() != null) {
                        model.addAttribute("homeTeamSeatImg", teamInfo.get().getSeatImg());
                        logger.info("홈팀 좌석 이미지 조회 성공: team={}, image={}", 
                            schedule.getHomeTeam(), teamInfo.get().getSeatImg());
                    } else {
                        logger.warn("홈팀 좌석 이미지를 찾을 수 없음: team={}", schedule.getHomeTeam());
                        model.addAttribute("homeTeamSeatImg", "all.jpg"); // 기본 이미지
                    }
                    
                    // 선택된 색상에 따른 가격 설정
                    Integer price = null;
                    switch (selectedColor != null ? selectedColor.toLowerCase() : "") {
                        case "orange":
                            price = schedule.getOrange();
                            break;
                        case "yellow":
                            price = schedule.getYellow();
                            break;
                        case "green":
                            price = schedule.getGreen();
                            break;
                        case "blue":
                            price = schedule.getBlue();
                            break;
                        case "purple":
                            price = schedule.getPurple();
                            break;
                        case "red":
                            price = schedule.getRed();
                            break;
                        case "black":
                            price = schedule.getBlack();
                            break;
                        default:
                            price = schedule.getFee(); // 기본 가격
                    }
                    
                    model.addAttribute("selectedColor", selectedColor);
                    model.addAttribute("seatPrice", price != null ? price : 0);
                }
            } else {
                // URL 파라미터로 전달된 정보 사용
                model.addAttribute("homeTeam", homeTeam);
                model.addAttribute("awayTeam", awayTeam);
                model.addAttribute("gameDate", gameDate);
                model.addAttribute("gameTime", gameTime);
                model.addAttribute("selectedColor", selectedColor);
                model.addAttribute("seatPrice", seatPrice != null ? Integer.parseInt(seatPrice) : 0);
                
                // 홈팀의 좌석 이미지 조회
                if (homeTeam != null) {
                    Optional<TeamInfo> teamInfo = teamInfoService.findByTeamName(homeTeam);
                    if (teamInfo.isPresent() && teamInfo.get().getSeatImg() != null) {
                        model.addAttribute("homeTeamSeatImg", teamInfo.get().getSeatImg());
                    } else {
                        model.addAttribute("homeTeamSeatImg", "all.jpg"); // 기본 이미지
                    }
                }
            }
            
            return "account-detail-3";
        } catch (Exception e) {
            logger.error("account-detail-3 페이지 로드 중 오류 발생", e);
            model.addAttribute("error", "페이지 로드 중 오류가 발생했습니다.");
            return "account-detail-3";
        }
    }
    
    @PostMapping("/send-reservation-email")
    @ResponseBody
    public String sendReservationEmail(ReservationEmailDto emailDto) {
        try {
            logger.info("이메일 발송 요청: uid={}, customerEmail={}", emailDto.getUid(), emailDto.getCustomerEmail());
            
            // 이메일 제목 생성
            String subject = "[유로풋볼투어] 축구 티켓 예약 확인";
            
            // HTML 이메일 내용 생성
            String htmlContent = emailService.createHtmlEmailContent(
                emailDto.getHomeTeam(),
                emailDto.getAwayTeam(),
                emailDto.getGameDate(),
                emailDto.getGameTime(),
                emailDto.getSelectedColor(),
                emailDto.getSeatPrice(),
                emailDto.getCustomerName(),
                emailDto.getCustomerEmail(),
                emailDto.getCustomerPhone(),
                emailDto.getCustomerBirth(),
                emailDto.getCustomerPassport(),
                emailDto.getCustomerAddress(),
                emailDto.getCustomerDetailAddress(),
                emailDto.getCustomerEnglishAddress(),
                emailDto.getCustomerKakaoId(),
                emailDto.getCustomerGender(), // 추가
                emailDto.getPaymentMethod(),
                emailDto.getSeatReplacement(), // 추가
                emailDto.getConsecutiveSeats(), // 추가
                emailDto.getSpecialRequests()
            );
            
            // 이메일 발송
            emailService.sendReservationEmail(emailDto.getCustomerEmail(), subject, htmlContent);
            
            logger.info("이메일 발송 성공: {}", emailDto.getCustomerEmail());
            return "success";
            
        } catch (Exception e) {
            logger.error("이메일 발송 실패: {}", e.getMessage(), e);
            return "error";
        }
    }
    
    @PostMapping("/save-reservation")
    @ResponseBody
    public String saveReservation(@org.springframework.web.bind.annotation.RequestBody String requestBody) {
        try {
            logger.info("예약 저장 요청 시작");
            logger.info("요청 데이터: {}", requestBody);
            
            ObjectMapper objectMapper = new ObjectMapper();
            var jsonNode = objectMapper.readTree(requestBody);
            
            // RegisterSchedule 엔티티 생성
            RegisterSchedule registerSchedule = new RegisterSchedule();
            
            try {
                // 일정 정보 설정
                registerSchedule.setUid(jsonNode.get("uid").asText());
                registerSchedule.setHomeTeam(jsonNode.get("homeTeam").asText());
                registerSchedule.setAwayTeam(jsonNode.get("awayTeam").asText());
                registerSchedule.setGameDate(jsonNode.get("gameDate").asText());
                registerSchedule.setGameTime(jsonNode.get("gameTime").asText());
                registerSchedule.setSelectedColor(jsonNode.get("selectedColor").asText());
                registerSchedule.setSeatPrice(jsonNode.get("seatPrice").asText());
                
                logger.info("일정 정보 설정 완료: uid={}, homeTeam={}, awayTeam={}", 
                    registerSchedule.getUid(), registerSchedule.getHomeTeam(), registerSchedule.getAwayTeam());
                
                // 예약자 정보 설정
                registerSchedule.setCustomerName(jsonNode.get("customerName").asText());
                registerSchedule.setCustomerGender(jsonNode.get("customerGender").asText());
                registerSchedule.setCustomerPassport(jsonNode.get("customerPassport").asText());
                registerSchedule.setCustomerPhone(jsonNode.get("customerPhone").asText());
                registerSchedule.setCustomerEmail(jsonNode.get("customerEmail").asText());
                registerSchedule.setCustomerBirth(java.time.LocalDate.parse(jsonNode.get("customerBirth").asText()));
                registerSchedule.setCustomerAddress(jsonNode.get("customerAddress").asText());
                registerSchedule.setCustomerAddressDetail(jsonNode.get("customerAddressDetail").asText());
                registerSchedule.setCustomerDetailAddress(jsonNode.get("customerDetailAddress").asText());
                registerSchedule.setCustomerEnglishAddress(jsonNode.get("customerEnglishAddress").asText());
                registerSchedule.setCustomerKakaoId(jsonNode.get("customerKakaoId").asText());
                
                logger.info("예약자 정보 설정 완료: customerName={}, customerEmail={}", 
                    registerSchedule.getCustomerName(), registerSchedule.getCustomerEmail());
                
                // 티켓 예약 정보 설정
                registerSchedule.setTicketQuantity(jsonNode.get("ticketQuantity").asInt());
                registerSchedule.setTotalPrice(jsonNode.get("totalPrice").asText());
                registerSchedule.setPaymentMethod(jsonNode.get("paymentMethod").asText());
                registerSchedule.setSeatAlternative(jsonNode.get("seatAlternative").asText());
                registerSchedule.setAdjacentSeat(jsonNode.get("adjacentSeat").asText());
                registerSchedule.setAdditionalRequests(jsonNode.get("additionalRequests").asText());
                
                logger.info("티켓 예약 정보 설정 완료: ticketQuantity={}, totalPrice={}", 
                    registerSchedule.getTicketQuantity(), registerSchedule.getTotalPrice());
                
                // 동행자 정보 JSON으로 저장
                if (jsonNode.has("companions")) {
                    registerSchedule.setCompanions(jsonNode.get("companions").toString());
                    logger.info("동행자 정보 설정 완료: companions={}", registerSchedule.getCompanions());
                }
                
            } catch (Exception e) {
                logger.error("데이터 매핑 중 오류 발생: {}", e.getMessage(), e);
                return "error: 데이터 매핑 실패 - " + e.getMessage();
            }
            
            // 데이터베이스에 저장
            try {
                logger.info("데이터베이스 저장 시작");
                RegisterSchedule savedReservation = registerScheduleService.saveReservation(registerSchedule);
                logger.info("예약 저장 성공: ID={}", savedReservation.getId());
                
                // 저장된 데이터 확인
                logger.info("저장된 예약 정보: uid={}, customerName={}, customerEmail={}", 
                    savedReservation.getUid(), savedReservation.getCustomerName(), savedReservation.getCustomerEmail());
                
            } catch (Exception e) {
                logger.error("데이터베이스 저장 중 오류 발생: {}", e.getMessage(), e);
                return "error: 데이터베이스 저장 실패 - " + e.getMessage();
            }
            
            // 이메일 발송
            try {
                logger.info("이메일 발송 시작");
                ReservationEmailDto emailDto = new ReservationEmailDto();
                emailDto.setCustomerEmail(registerSchedule.getCustomerEmail());
                emailDto.setCustomerName(registerSchedule.getCustomerName());
                emailDto.setHomeTeam(registerSchedule.getHomeTeam());
                emailDto.setAwayTeam(registerSchedule.getAwayTeam());
                emailDto.setGameDate(registerSchedule.getGameDate());
                emailDto.setGameTime(registerSchedule.getGameTime());
                emailDto.setSelectedColor(registerSchedule.getSelectedColor());
                emailDto.setSeatPrice(registerSchedule.getSeatPrice());
                emailDto.setPaymentMethod(registerSchedule.getPaymentMethod());
                emailDto.setSeatReplacement(registerSchedule.getSeatAlternative());
                emailDto.setConsecutiveSeats(registerSchedule.getAdjacentSeat());
                emailDto.setSpecialRequests(registerSchedule.getAdditionalRequests());
                
                // 이메일 제목 생성
                String subject = "[유로풋볼투어] 축구 티켓 예약 확인";
                
                // HTML 이메일 내용 생성
                String htmlContent = emailService.createHtmlEmailContent(
                    emailDto.getHomeTeam(),
                    emailDto.getAwayTeam(),
                    emailDto.getGameDate(),
                    emailDto.getGameTime(),
                    emailDto.getSelectedColor(),
                    emailDto.getSeatPrice(),
                    emailDto.getCustomerName(),
                    emailDto.getCustomerEmail(),
                    emailDto.getCustomerPhone(),
                    emailDto.getCustomerBirth(),
                    emailDto.getCustomerPassport(),
                    emailDto.getCustomerAddress(),
                    emailDto.getCustomerDetailAddress(),
                    emailDto.getCustomerEnglishAddress(),
                    emailDto.getCustomerKakaoId(),
                    emailDto.getCustomerGender(),
                    emailDto.getPaymentMethod(),
                    emailDto.getSeatReplacement(),
                    emailDto.getConsecutiveSeats(),
                    emailDto.getSpecialRequests()
                );
                
                // 이메일 발송
                emailService.sendReservationEmail(emailDto.getCustomerEmail(), subject, htmlContent);
                logger.info("예약 이메일 발송 완료");
                
            } catch (Exception e) {
                logger.error("이메일 발송 중 오류 발생: {}", e.getMessage(), e);
                // 이메일 발송 실패해도 예약은 성공했으므로 계속 진행
            }
            
            logger.info("예약 저장 및 이메일 발송 완료");
            return "success";
            
        } catch (Exception e) {
            logger.error("예약 저장 중 오류 발생: {}", e.getMessage(), e);
            return "error: " + e.getMessage();
        }
    }

    // 이메일 발송 테스트 엔드포인트
    @GetMapping("/test-email")
    @ResponseBody
    public String testEmail() {
        try {
            logger.info("이메일 발송 테스트 시작");
            
            // 테스트용 이메일 데이터 생성
            ReservationEmailDto emailDto = new ReservationEmailDto();
            emailDto.setCustomerName("테스트 사용자");
            emailDto.setCustomerEmail("test@example.com");
            emailDto.setHomeTeam("맨유");
            emailDto.setAwayTeam("첼시");
            emailDto.setGameDate("2025-07-15");
            emailDto.setGameTime("16:30");
            emailDto.setSelectedColor("yellow");
            emailDto.setSeatPrice("320000");
            emailDto.setCustomerPhone("010-1234-5678");
            emailDto.setCustomerBirth("1990-01-01");
            emailDto.setCustomerPassport("TEST KIM");
            emailDto.setCustomerAddress("12345");
            emailDto.setCustomerAddressDetail("서울시 강남구");
            emailDto.setCustomerDetailAddress("123-456");
            emailDto.setCustomerEnglishAddress("Seoul Gangnam-gu");
            emailDto.setCustomerKakaoId("testkakao");
            emailDto.setCustomerGender("남");
            emailDto.setTicketQuantity("1");
            emailDto.setTotalPrice("320000");
            emailDto.setPaymentMethod("신용카드");
            emailDto.setSeatAlternative("아니오");
            emailDto.setAdjacentSeat("아니오");
            emailDto.setAdditionalRequests("테스트 예약");
            
            // 이메일 발송
            emailService.sendReservationEmail(emailDto);
            
            logger.info("이메일 발송 테스트 성공");
            return "이메일 발송 테스트 성공!";
            
        } catch (Exception e) {
            logger.error("이메일 발송 테스트 실패: {}", e.getMessage(), e);
            return "이메일 발송 테스트 실패: " + e.getMessage();
        }
    }

    // FAQ 목록 페이지
    @GetMapping("/faq")
    public String faq(@RequestParam(defaultValue = "0") int page, 
                     @RequestParam(required = false) String keyword,
                     @RequestParam(defaultValue = "all") String searchType,
                     Model model) {
        try {
            logger.info("FAQ 페이지 요청 - page: {}, keyword: {}, searchType: {}", page, keyword, searchType);
            Page<Faq> faqPage;
            if (keyword != null && !keyword.trim().isEmpty()) {
                // 검색이 있는 경우
                logger.info("FAQ 검색 실행 - keyword: {}", keyword);
                switch (searchType) {
                    case "title":
                        faqPage = faqService.searchByTitle(keyword, page, 10);
                        break;
                    case "name":
                        faqPage = faqService.searchByName(keyword, page, 10);
                        break;
                    default:
                        faqPage = faqService.searchByTitleOrName(keyword, page, 10);
                        break;
                }
                model.addAttribute("keyword", keyword);
                model.addAttribute("searchType", searchType);
            } else {
                // 검색이 없는 경우
                logger.info("FAQ 전체 목록 조회 - page: {}", page);
                faqPage = faqService.getAllFaqs(page, 10);
            }
            logger.info("FAQ 조회 결과 - 총 개수: {}, 현재 페이지: {}, 총 페이지: {}", 
                       faqPage.getTotalElements(), page, faqPage.getTotalPages());
            // FaqDto로 변환
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            var faqDtos = faqPage.getContent().stream()
                .map(faq -> new FaqDto(
                    faq.getUid(),
                    faq.getTitle(),
                    faq.getNotice(),
                    faq.getRegdate() != null ? faq.getRegdate().format(formatter) : "-",
                    faq.getName()
                ))
                .collect(Collectors.toList());
            model.addAttribute("faqs", faqDtos);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", faqPage.getTotalPages());
            model.addAttribute("totalItems", faqPage.getTotalElements());
            model.addAttribute("hasNext", faqPage.hasNext());
            model.addAttribute("hasPrevious", faqPage.hasPrevious());
            logger.info("FAQ 페이지 모델 설정 완료");
            return "faq";
        } catch (Exception e) {
            logger.error("FAQ 페이지 처리 중 오류 발생", e);
            model.addAttribute("error", "FAQ 목록을 불러오는 중 오류가 발생했습니다.");
            return "faq";
        }
    }
    
    // FAQ 상세 보기
    @GetMapping("/faq-detail")
    public String faqDetail(@RequestParam Integer uid, Model model) {
        Optional<Faq> faq = faqService.getFaqById(uid);
        if (faq.isPresent()) {
            model.addAttribute("faq", faq.get());
            return "faq-detail";
        } else {
            return "redirect:/faq";
        }
    }

    // FaqDto 내부 클래스 추가
    public static class FaqDto {
        private Integer uid;
        private String title;
        private String notice;
        private String regdate;
        private String name;
        public FaqDto(Integer uid, String title, String notice, String regdate, String name) {
            this.uid = uid;
            this.title = title;
            this.notice = notice;
            this.regdate = regdate;
            this.name = name;
        }
        public Integer getUid() { return uid; }
        public String getTitle() { return title; }
        public String getNotice() { return notice; }
        public String getRegdate() { return regdate; }
        public String getName() { return name; }
    }
} 