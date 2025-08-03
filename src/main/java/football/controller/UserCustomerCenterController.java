package football.controller;

import football.entity.CustomerCenter;
import football.entity.FooterInfo;
import football.service.CustomerCenterService;
import football.service.FooterInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDateTime;

@Controller
public class UserCustomerCenterController {
    
    @Autowired
    private CustomerCenterService customerCenterService;
    
    @Autowired
    private FooterInfoService footerInfoService;
    
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
        
        // footer_info 데이터 추가
        try {
            FooterInfo footerInfo = footerInfoService.getFooterInfo();
            model.addAttribute("footerInfo", footerInfo);
        } catch (Exception e) {
            model.addAttribute("footerInfo", null);
        }
        
        return "customer-center";
    }
} 