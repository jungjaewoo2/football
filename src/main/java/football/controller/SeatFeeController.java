package football.controller;

import football.entity.SeatFee;
import football.entity.TeamInfo;
import football.service.SeatFeeService;
import football.service.TeamInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/seat_fee")
public class SeatFeeController {
    
    @Autowired
    private SeatFeeService seatFeeService;
    
    @Autowired
    private TeamInfoService teamInfoService;
    
    // 좌석요금 목록 페이지
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "0") int page,
                      @RequestParam(required = false) String search,
                      Model model) {
        
        int size = 10; // 한 페이지당 10개로 고정
        Page<SeatFee> seatFeePage;
        
        if (search != null && !search.trim().isEmpty()) {
            seatFeePage = seatFeeService.searchSeatFeesByName(search, page, size);
        } else {
            seatFeePage = seatFeeService.getAllSeatFees(page, size);
        }
        
        model.addAttribute("seatFees", seatFeePage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", seatFeePage.getTotalPages());
        model.addAttribute("totalItems", seatFeePage.getTotalElements());
        model.addAttribute("hasNext", seatFeePage.hasNext());
        model.addAttribute("hasPrevious", seatFeePage.hasPrevious());
        model.addAttribute("search", search);
        
        return "admin/seat_fee/list";
    }
    
    // 좌석요금 등록 페이지
    @GetMapping("/register")
    public String registerForm(Model model) {
        // 팀 정보 목록 가져오기
        List<TeamInfo> teamList = teamInfoService.findAll();
        model.addAttribute("teamList", teamList);
        model.addAttribute("seatFee", new SeatFee());
        return "admin/seat_fee/register";
    }
    
    // 좌석요금 등록 처리
    @PostMapping("/register")
    public String register(@ModelAttribute SeatFee seatFee, RedirectAttributes redirectAttributes) {
        try {
            seatFeeService.saveSeatFee(seatFee);
            redirectAttributes.addFlashAttribute("message", "좌석요금이 성공적으로 등록되었습니다.");
            return "redirect:/admin/seat_fee/list";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "좌석요금 등록 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/admin/seat_fee/register";
        }
    }
    
    // 좌석요금 수정 페이지
    @GetMapping("/edit/{uid}")
    public String editForm(@PathVariable Integer uid, Model model, RedirectAttributes redirectAttributes) {
        Optional<SeatFee> seatFeeOpt = seatFeeService.getSeatFeeById(uid);
        
        if (seatFeeOpt.isPresent()) {
            // 팀 정보 목록 가져오기
            List<TeamInfo> teamList = teamInfoService.findAll();
            model.addAttribute("teamList", teamList);
            model.addAttribute("seatFee", seatFeeOpt.get());
            return "admin/seat_fee/edit";
        } else {
            redirectAttributes.addFlashAttribute("error", "좌석요금을 찾을 수 없습니다.");
            return "redirect:/admin/seat_fee/list";
        }
    }
    
    // 좌석요금 수정 처리
    @PostMapping("/edit")
    public String edit(@ModelAttribute SeatFee seatFee, RedirectAttributes redirectAttributes) {
        try {
            seatFeeService.updateSeatFee(seatFee);
            redirectAttributes.addFlashAttribute("message", "좌석요금이 성공적으로 수정되었습니다.");
            return "redirect:/admin/seat_fee/list";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "좌석요금 수정 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/admin/seat_fee/edit/" + seatFee.getUid();
        }
    }
    
    // 좌석요금 삭제 페이지
    @GetMapping("/delete/{uid}")
    public String deleteForm(@PathVariable Integer uid, Model model, RedirectAttributes redirectAttributes) {
        Optional<SeatFee> seatFeeOpt = seatFeeService.getSeatFeeById(uid);
        
        if (seatFeeOpt.isPresent()) {
            model.addAttribute("seatFee", seatFeeOpt.get());
            return "admin/seat_fee/delete";
        } else {
            redirectAttributes.addFlashAttribute("error", "좌석요금을 찾을 수 없습니다.");
            return "redirect:/admin/seat_fee/list";
        }
    }
    
    // 좌석요금 삭제 처리
    @PostMapping("/delete/{uid}")
    public String delete(@PathVariable Integer uid, RedirectAttributes redirectAttributes) {
        try {
            seatFeeService.deleteSeatFee(uid);
            redirectAttributes.addFlashAttribute("message", "좌석요금이 성공적으로 삭제되었습니다.");
            return "redirect:/admin/seat_fee/list";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "좌석요금 삭제 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/admin/seat_fee/delete/" + uid;
        }
    }
} 