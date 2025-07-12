package football.controller;

import football.entity.ScheduleInfo;
import football.entity.SeatFee;
import football.service.ScheduleInfoService;
import football.service.SeatFeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

@Controller
public class MainController {
    
    @Autowired
    private ScheduleInfoService scheduleInfoService;
    
    @Autowired
    private SeatFeeService seatFeeService;
    
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
        // uid로 해당 일정 정보 조회
        Optional<ScheduleInfo> scheduleInfo = scheduleInfoService.findById(uid);
        
        if (scheduleInfo.isPresent()) {
            ScheduleInfo schedule = scheduleInfo.get();
            
            // schedule의 fee 값으로 seat_fee 테이블에서 해당하는 데이터 조회
            if (schedule.getFee() != null) {
                Optional<SeatFee> seatFee = seatFeeService.getSeatFeeById(schedule.getFee());
                if (seatFee.isPresent()) {
                    model.addAttribute("seatFee", seatFee.get());
                }
            }
            
            model.addAttribute("schedule", schedule);
            return "account-detail";
        } else {
            // 일정을 찾을 수 없는 경우 account-list로 리다이렉트
            return "redirect:/account-list";
        }
    }
} 