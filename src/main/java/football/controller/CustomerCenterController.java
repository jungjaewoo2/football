package football.controller;

import football.entity.CustomerCenter;
import football.service.CustomerCenterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/customer_center")
public class CustomerCenterController {
    
    @Autowired
    private CustomerCenterService customerCenterService;
    
    // 고객센터 상세보기 페이지
    @GetMapping("")
    public String viewCustomerCenter(Model model) {
        CustomerCenter customerCenter = customerCenterService.getCustomerCenter();
        model.addAttribute("customerCenter", customerCenter);
        return "admin/customer_center/view";
    }
    
    // 고객센터 수정 페이지
    @GetMapping("/edit")
    public String editCustomerCenter(Model model) {
        CustomerCenter customerCenter = customerCenterService.getCustomerCenter();
        model.addAttribute("customerCenter", customerCenter);
        return "admin/customer_center/edit";
    }
    
    // 고객센터 수정 처리
    @PostMapping("/edit")
    public String updateCustomerCenter(@ModelAttribute CustomerCenter customerCenter) {
        customerCenterService.saveCustomerCenter(customerCenter);
        return "redirect:/admin/customer_center";
    }
} 