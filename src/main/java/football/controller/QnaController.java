package football.controller;

import football.entity.Qna;
import football.service.QnaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/qna")
public class QnaController {
    
    @Autowired
    private QnaService qnaService;
    
    // QNA 목록 페이지
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "0") int page,
                      @RequestParam(required = false) String searchType,
                      @RequestParam(required = false) String keyword,
                      Model model) {
        
        int size = 10; // 한 페이지당 10개로 고정
        
        Page<Qna> qnaPage;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            switch (searchType) {
                case "title":
                    qnaPage = qnaService.searchByTitle(keyword, page, size);
                    break;
                case "name":
                    qnaPage = qnaService.searchByName(keyword, page, size);
                    break;
                case "content":
                    qnaPage = qnaService.searchByContent(keyword, page, size);
                    break;
                default:
                    qnaPage = qnaService.searchAll(keyword, page, size);
                    break;
            }
            model.addAttribute("searchType", searchType);
            model.addAttribute("keyword", keyword);
        } else {
            qnaPage = qnaService.findMainPosts(page, size);
        }
        
        model.addAttribute("qnaList", qnaPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", qnaPage.getTotalPages());
        model.addAttribute("totalElements", qnaPage.getTotalElements());
        model.addAttribute("hasNext", qnaPage.hasNext());
        model.addAttribute("hasPrevious", qnaPage.hasPrevious());
        
        return "admin/qna/list";
    }
    
    // QNA 등록 페이지
    @GetMapping("/register")
    public String registerForm(Model model) {
        return "admin/qna/register";
    }
    
    // QNA 등록 처리
    @PostMapping("/register")
    public String register(@RequestParam String title,
                          @RequestParam String name,
                          @RequestParam String content,
                          RedirectAttributes redirectAttributes) {
        
        System.out.println("=== QNA 등록 요청 받음 ===");
        System.out.println("Title: " + title);
        System.out.println("Name: " + name);
        System.out.println("Content length: " + (content != null ? content.length() : 0));
        
        try {
            if (title == null || title.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "제목은 필수입니다.");
                return "redirect:/admin/qna/register";
            }
            
            if (name == null || name.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "작성자는 필수입니다.");
                return "redirect:/admin/qna/register";
            }
            
            if (content == null || content.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "내용은 필수입니다.");
                return "redirect:/admin/qna/register";
            }
            
            Qna qna = new Qna(name, title, content);
            System.out.println("QNA 객체 생성 완료");
            
            qnaService.saveQna(qna);
            System.out.println("QNA 저장 완료");
            
            redirectAttributes.addFlashAttribute("success", "QNA가 성공적으로 등록되었습니다.");
            return "redirect:/admin/qna/list";
        } catch (Exception e) {
            System.err.println("QNA 등록 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "QNA 등록 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/admin/qna/register";
        }
    }
    
    // QNA 상세보기
    @GetMapping("/view/{uid}")
    public String view(@PathVariable Integer uid, Model model) {
        Optional<Qna> qna = qnaService.findQnaById(uid);
        if (qna.isPresent()) {
            model.addAttribute("qna", qna.get());
            
            // 답변 목록 조회
            List<Qna> replies = qnaService.findRepliesByParentId(uid);
            model.addAttribute("replies", replies);
            
            return "admin/qna/view";
        } else {
            return "redirect:/admin/qna/list";
        }
    }
    
    // QNA 수정 페이지
    @GetMapping("/edit/{uid}")
    public String editForm(@PathVariable Integer uid, Model model) {
        Optional<Qna> qna = qnaService.findQnaById(uid);
        if (qna.isPresent()) {
            model.addAttribute("qna", qna.get());
            return "admin/qna/edit";
        } else {
            return "redirect:/admin/qna/list";
        }
    }
    
    // QNA 수정 처리
    @PostMapping("/edit/{uid}")
    public String edit(@PathVariable Integer uid,
                      @RequestParam String title,
                      @RequestParam String name,
                      @RequestParam String content,
                      RedirectAttributes redirectAttributes) {
        
        try {
            Qna qna = new Qna();
            qna.setUid(uid);
            qna.setTitle(title);
            qna.setName(name);
            qna.setContent(content);
            
            Qna updatedQna = qnaService.updateQna(qna);
            if (updatedQna != null) {
                redirectAttributes.addFlashAttribute("success", "QNA가 성공적으로 수정되었습니다.");
                return "redirect:/admin/qna/view/" + uid;
            } else {
                redirectAttributes.addFlashAttribute("error", "QNA를 찾을 수 없습니다.");
                return "redirect:/admin/qna/list";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "QNA 수정 중 오류가 발생했습니다.");
            return "redirect:/admin/qna/edit/" + uid;
        }
    }
    
    // QNA 삭제
    @PostMapping("/delete/{uid}")
    public String delete(@PathVariable Integer uid, RedirectAttributes redirectAttributes) {
        try {
            boolean deleted = qnaService.deleteQna(uid);
            if (deleted) {
                redirectAttributes.addFlashAttribute("success", "QNA가 성공적으로 삭제되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("error", "QNA를 찾을 수 없습니다.");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "QNA 삭제 중 오류가 발생했습니다.");
        }
        return "redirect:/admin/qna/list";
    }
    
    // 답변 등록
    @PostMapping("/reply/{parentId}")
    public String addReply(@PathVariable Integer parentId,
                          @RequestParam String name,
                          @RequestParam String content,
                          RedirectAttributes redirectAttributes) {
        
        try {
            Qna reply = new Qna();
            reply.setParentPostId(parentId);
            reply.setName(name);
            reply.setContent(content);
            
            qnaService.saveReply(reply);
            redirectAttributes.addFlashAttribute("success", "답변이 성공적으로 등록되었습니다.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "답변 등록 중 오류가 발생했습니다.");
        }
        
        return "redirect:/admin/qna/view/" + parentId;
    }
    
    // 답변 삭제
    @PostMapping("/reply/delete/{uid}")
    public String deleteReply(@PathVariable Integer uid,
                             @RequestParam Integer parentId,
                             RedirectAttributes redirectAttributes) {
        
        try {
            boolean deleted = qnaService.deleteReply(uid);
            if (deleted) {
                redirectAttributes.addFlashAttribute("success", "답변이 성공적으로 삭제되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("error", "답변을 찾을 수 없습니다.");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "답변 삭제 중 오류가 발생했습니다.");
        }
        
        return "redirect:/admin/qna/view/" + parentId;
    }
} 