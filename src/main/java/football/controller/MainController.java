package football.controller;

import football.dto.ReservationEmailDto;
import football.entity.ScheduleInfo;
import football.entity.SeatFee;
import football.entity.TeamInfo;
import football.service.EmailService;
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
    public String accountDetail3(
        @RequestParam(required = false) String scheduleId,
        @RequestParam(required = false) String homeTeam,
        @RequestParam(required = false) String awayTeam,
        @RequestParam(required = false) String gameDate,
        @RequestParam(required = false) String gameTime,
        @RequestParam(required = false) String selectedColor,
        @RequestParam(required = false) String seatPrice,
        @RequestParam(required = false) Integer uid,
        Model model
    ) {
        logger.info("account-detail-3 요청: uid={}, scheduleId={}", uid, scheduleId);
        
        try {
            // uid가 있으면 실제 데이터베이스에서 조회
            if (uid != null) {
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
                    
                    // URL 파라미터로 전달된 정보도 함께 사용
                    model.addAttribute("scheduleId", scheduleId != null ? scheduleId : String.valueOf(schedule.getUid()));
                    model.addAttribute("homeTeam", homeTeam != null ? homeTeam : schedule.getHomeTeam());
                    model.addAttribute("awayTeam", awayTeam != null ? awayTeam : schedule.getOtherTeam());
                    model.addAttribute("gameDate", gameDate != null ? gameDate : schedule.getGameDate());
                    model.addAttribute("gameTime", gameTime != null ? gameTime : schedule.getGameTime());
                    model.addAttribute("selectedColor", selectedColor);
                    model.addAttribute("seatPrice", seatPrice);
                    
                    logger.info("account-detail-3 페이지 렌더링 준비 완료");
                    return "account-detail-3";
                } else {
                    logger.warn("일정 정보를 찾을 수 없음: uid={}", uid);
                    return "redirect:/account-list";
                }
            } else {
                // URL 파라미터로만 전달된 경우
                model.addAttribute("scheduleId", scheduleId);
                model.addAttribute("homeTeam", homeTeam);
                model.addAttribute("awayTeam", awayTeam);
                model.addAttribute("gameDate", gameDate);
                model.addAttribute("gameTime", gameTime);
                model.addAttribute("selectedColor", selectedColor);
                model.addAttribute("seatPrice", seatPrice);
                return "account-detail-3";
            }
        } catch (Exception e) {
            logger.error("account-detail-3 처리 중 오류 발생: uid={}, error={}", uid, e.getMessage(), e);
            return "redirect:/account-list";
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
} 