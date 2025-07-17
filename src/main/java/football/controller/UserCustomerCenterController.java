package football.controller;

import football.entity.CustomerCenter;
import football.service.CustomerCenterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDateTime;

@Controller
public class UserCustomerCenterController {
    
    @Autowired
    private CustomerCenterService customerCenterService;
    
    // 고객센터 페이지
    @GetMapping("/customer-center")
    public String customerCenter(Model model) {
        // 현재 날짜 정보 추가
        LocalDateTime now = LocalDateTime.now();
        model.addAttribute("currentYear", now.getYear());
        model.addAttribute("currentMonth", now.getMonthValue());
        model.addAttribute("currentDate", now);
        
        CustomerCenter customerCenter = customerCenterService.getCustomerCenter();
        model.addAttribute("customerCenter", customerCenter);
        return "customer-center";
    }
} 