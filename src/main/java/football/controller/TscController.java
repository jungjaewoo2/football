package football.controller;

import football.entity.Tsc;
import football.service.TscService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/tsc")
public class TscController {
    @Autowired
    private TscService tscService;

    @GetMapping("")
    public String viewTsc(Model model) {
        Tsc tsc = tscService.getTsc();
        model.addAttribute("tsc", tsc);
        return "admin/tsc/view";
    }

    @GetMapping("/edit")
    public String editTsc(Model model) {
        Tsc tsc = tscService.getTsc();
        model.addAttribute("tsc", tsc);
        return "admin/tsc/edit";
    }

    @PostMapping("/edit")
    public String updateTsc(@ModelAttribute Tsc tsc) {
        tscService.saveTsc(tsc);
        return "redirect:/admin/tsc";
    }
} 