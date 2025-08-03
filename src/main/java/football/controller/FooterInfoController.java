package football.controller;

import football.entity.FooterInfo;
import football.service.FooterInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/footer_info")
public class FooterInfoController {
    @Autowired
    private FooterInfoService footerInfoService;

    @GetMapping("")
    public String viewFooterInfo(Model model) {
        FooterInfo footerInfo = footerInfoService.getFooterInfo();
        model.addAttribute("footerInfo", footerInfo);
        return "admin/footer_info/view";
    }

    @GetMapping("/edit")
    public String editFooterInfo(Model model) {
        FooterInfo footerInfo = footerInfoService.getFooterInfo();
        model.addAttribute("footerInfo", footerInfo);
        return "admin/footer_info/edit";
    }

    @PostMapping("/edit")
    public String updateFooterInfo(@RequestParam String phone, @RequestParam String email) {
        FooterInfo footerInfo = new FooterInfo();
        footerInfo.setPhone(phone);
        footerInfo.setEmail(email);
        footerInfoService.saveFooterInfo(footerInfo);
        return "redirect:/admin/footer_info";
    }
} 