package football.controller;

import football.entity.TicketInfo;
import football.service.TicketInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/ticket_info")
public class TicketInfoController {
    @Autowired
    private TicketInfoService ticketInfoService;

    @GetMapping("")
    public String viewTicketInfo(Model model) {
        TicketInfo ticketInfo = ticketInfoService.getTicketInfo();
        model.addAttribute("ticketInfo", ticketInfo);
        return "admin/ticket_info/view";
    }

    @GetMapping("/edit")
    public String editTicketInfo(Model model) {
        TicketInfo ticketInfo = ticketInfoService.getTicketInfo();
        model.addAttribute("ticketInfo", ticketInfo);
        return "admin/ticket_info/edit";
    }

    @PostMapping("/edit")
    public String updateTicketInfo(@ModelAttribute TicketInfo ticketInfo) {
        ticketInfoService.saveTicketInfo(ticketInfo);
        return "redirect:/admin/ticket_info";
    }
} 