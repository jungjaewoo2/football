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
            logger.info("예약 저장 요청: {}", requestBody);
            
            ObjectMapper objectMapper = new ObjectMapper();
            var jsonNode = objectMapper.readTree(requestBody);
            
            // RegisterSchedule 엔티티 생성
            RegisterSchedule registerSchedule = new RegisterSchedule();
            
            // 일정 정보 설정
            registerSchedule.setUid(jsonNode.get("uid").asText());
            registerSchedule.setHomeTeam(jsonNode.get("homeTeam").asText());
            registerSchedule.setAwayTeam(jsonNode.get("awayTeam").asText());
            registerSchedule.setGameDate(jsonNode.get("gameDate").asText());
            registerSchedule.setGameTime(jsonNode.get("gameTime").asText());
            registerSchedule.setSelectedColor(jsonNode.get("selectedColor").asText());
            registerSchedule.setSeatPrice(jsonNode.get("seatPrice").asText());
            
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
            
            // 티켓 예약 정보 설정
            registerSchedule.setTicketQuantity(jsonNode.get("ticketQuantity").asInt());
            registerSchedule.setTotalPrice(jsonNode.get("totalPrice").asText());
            registerSchedule.setPaymentMethod(jsonNode.get("paymentMethod").asText());
            registerSchedule.setSeatAlternative(jsonNode.get("seatAlternative").asText());
            registerSchedule.setAdjacentSeat(jsonNode.get("adjacentSeat").asText());
            registerSchedule.setAdditionalRequests(jsonNode.get("additionalRequests").asText());
            
            // 동행자 정보 JSON으로 저장
            if (jsonNode.has("companions")) {
                registerSchedule.setCompanions(jsonNode.get("companions").toString());
            }
            
            // 데이터베이스에 저장
            RegisterSchedule savedReservation = registerScheduleService.saveReservation(registerSchedule);
            logger.info("예약 저장 성공: ID={}", savedReservation.getId());
            
            // 이메일 발송
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
            
            return "success";
        } catch (Exception e) {
            logger.error("예약 저장 중 오류 발생: {}", e.getMessage(), e);
            return "error";
        }
    }
} 