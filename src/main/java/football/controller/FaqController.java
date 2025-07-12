package football.controller;

import football.entity.Faq;
import football.service.FaqService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Optional;

@Controller
@RequestMapping("/admin/faq")
public class FaqController {
    
    @Autowired
    private FaqService faqService;
    
    // FAQ 목록 페이지 (검색 포함)
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "0") int page, 
                      @RequestParam(required = false) String keyword,
                      @RequestParam(defaultValue = "all") String searchType,
                      Model model) {
        Page<Faq> faqPage;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            // 검색이 있는 경우
            switch (searchType) {
                case "title":
                    faqPage = faqService.searchByTitle(keyword, page, 10);
                    break;
                case "name":
                    faqPage = faqService.searchByName(keyword, page, 10);
                    break;
                default:
                    faqPage = faqService.searchByTitleOrName(keyword, page, 10);
                    break;
            }
            model.addAttribute("keyword", keyword);
            model.addAttribute("searchType", searchType);
        } else {
            // 검색이 없는 경우
            faqPage = faqService.getAllFaqs(page, 10);
        }
        
        model.addAttribute("faqs", faqPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", faqPage.getTotalPages());
        model.addAttribute("totalItems", faqPage.getTotalElements());
        model.addAttribute("hasNext", faqPage.hasNext());
        model.addAttribute("hasPrevious", faqPage.hasPrevious());
        
        return "admin/faq/list";
    }
    
    // FAQ 등록 페이지
    @GetMapping("/register")
    public String registerForm(Model model) {
        model.addAttribute("faq", new Faq());
        return "admin/faq/register";
    }
    
    // FAQ 등록 처리
    @PostMapping("/register")
    public String register(@ModelAttribute Faq faq, Model model) {
        try {
            faqService.createFaq(faq);
            return "redirect:/admin/faq/list";
        } catch (Exception e) {
            model.addAttribute("error", "FAQ 등록 중 오류가 발생했습니다: " + e.getMessage());
            model.addAttribute("faq", faq);
            return "admin/faq/register";
        }
    }
    
    // FAQ 상세 보기
    @GetMapping("/view/{uid}")
    public String view(@PathVariable Integer uid, Model model) {
        Optional<Faq> faq = faqService.getFaqById(uid);
        if (faq.isPresent()) {
            model.addAttribute("faq", faq.get());
            return "admin/faq/view";
        } else {
            return "redirect:/admin/faq/list";
        }
    }
    
    // FAQ 수정 페이지
    @GetMapping("/edit/{uid}")
    public String editForm(@PathVariable Integer uid, Model model) {
        Optional<Faq> faq = faqService.getFaqById(uid);
        if (faq.isPresent()) {
            model.addAttribute("faq", faq.get());
            return "admin/faq/edit";
        } else {
            return "redirect:/admin/faq/list";
        }
    }
    
    // FAQ 수정 처리
    @PostMapping("/edit/{uid}")
    public String edit(@PathVariable Integer uid, @ModelAttribute Faq faq, Model model) {
        try {
            Faq updatedFaq = faqService.updateFaq(uid, faq);
            if (updatedFaq != null) {
                return "redirect:/admin/faq/list";
            } else {
                model.addAttribute("error", "FAQ를 찾을 수 없습니다.");
                return "admin/faq/edit";
            }
        } catch (Exception e) {
            model.addAttribute("error", "FAQ 수정 중 오류가 발생했습니다: " + e.getMessage());
            model.addAttribute("faq", faq);
            return "admin/faq/edit";
        }
    }
    
    // FAQ 삭제 페이지
    @GetMapping("/delete/{uid}")
    public String deleteForm(@PathVariable Integer uid, Model model) {
        Optional<Faq> faq = faqService.getFaqById(uid);
        if (faq.isPresent()) {
            model.addAttribute("faq", faq.get());
            return "admin/faq/delete";
        } else {
            return "redirect:/admin/faq/list";
        }
    }
    
    // FAQ 삭제 처리
    @PostMapping("/delete/{uid}")
    public String delete(@PathVariable Integer uid) {
        faqService.deleteFaq(uid);
        return "redirect:/admin/faq/list";
    }
} 