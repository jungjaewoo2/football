package football.controller;

import football.entity.Qna;
import football.service.QnaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
public class UserQnaController {
    
    @Autowired
    private QnaService qnaService;
    
    // 티켓문의 목록 페이지
    @GetMapping("/ticket-qna")
    public String ticketQna(@RequestParam(defaultValue = "0") int page, 
                           @RequestParam(required = false) String keyword,
                           @RequestParam(defaultValue = "all") String searchType,
                           Model model) {
        
        // 현재 날짜 정보 추가
        LocalDateTime now = LocalDateTime.now();
        model.addAttribute("currentYear", now.getYear());
        model.addAttribute("currentMonth", now.getMonthValue());
        model.addAttribute("currentDate", now);
        
        Page<Qna> qnaPage;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            // 검색이 있는 경우
            switch (searchType) {
                case "title":
                    qnaPage = qnaService.searchByTitle(keyword, page, 10);
                    break;
                case "name":
                    qnaPage = qnaService.searchByName(keyword, page, 10);
                    break;
                case "content":
                    qnaPage = qnaService.searchByContent(keyword, page, 10);
                    break;
                default:
                    qnaPage = qnaService.searchAll(keyword, page, 10);
                    break;
            }
            model.addAttribute("keyword", keyword);
            model.addAttribute("searchType", searchType);
        } else {
            // 검색이 없는 경우
            qnaPage = qnaService.findMainPosts(page, 10);
        }
        
        // 날짜 포맷팅을 위한 DTO 변환 (답글 개수 포함)
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        var qnaDtos = qnaPage.getContent().stream()
            .map(qna -> {
                // 답글 개수 조회
                List<Qna> replies = qnaService.findRepliesByParentId(qna.getUid());
                int replyCount = replies.size();
                
                return new QnaDto(
                    qna.getUid(),
                    qna.getName(),
                    qna.getTitle(),
                    qna.getContent(),
                    qna.getNotice(),
                    qna.getRegdate() != null ? qna.getRegdate().format(formatter) : "",
                    qna.getRef() != null ? qna.getRef() : 0,
                    replyCount,
                    qna.getParentPostId()
                );
            })
            .collect(Collectors.toList());
        
        model.addAttribute("qnas", qnaDtos);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", qnaPage.getTotalPages());
        model.addAttribute("totalItems", qnaPage.getTotalElements());
        model.addAttribute("totalCount", qnaPage.getTotalElements());
        model.addAttribute("hasNext", qnaPage.hasNext());
        model.addAttribute("hasPrevious", qnaPage.hasPrevious());
        
        return "ticket-qna";
    }
    
    // 티켓문의 등록 페이지
    @GetMapping("/ticket-qna-new")
    public String ticketQnaNew(Model model) {
        // 현재 날짜 정보 추가
        LocalDateTime now = LocalDateTime.now();
        model.addAttribute("currentYear", now.getYear());
        model.addAttribute("currentMonth", now.getMonthValue());
        model.addAttribute("currentDate", now);
        
        return "ticket-qna-new";
    }
    
    // 티켓문의 등록 처리
    @PostMapping("/ticket-qna-new")
    public String ticketQnaNewSubmit(@RequestParam String title,
                                   @RequestParam String name,
                                   @RequestParam String passwd,
                                   @RequestParam String content,
                                   RedirectAttributes redirectAttributes) {
        
        // 필수 입력 검증
        if (title == null || title.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "제목을 입력해주세요.");
            return "redirect:/ticket-qna-new";
        }
        if (name == null || name.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "작성자를 입력해주세요.");
            return "redirect:/ticket-qna-new";
        }
        if (passwd == null || passwd.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "비밀번호를 입력해주세요.");
            return "redirect:/ticket-qna-new";
        }
        if (content == null || content.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "내용을 입력해주세요.");
            return "redirect:/ticket-qna-new";
        }
        
        try {
            // 디버깅: 받은 내용 확인
            System.out.println("=== 티켓문의 등록 디버깅 ===");
            System.out.println("제목: " + title);
            System.out.println("작성자: " + name);
            System.out.println("내용 길이: " + (content != null ? content.length() : 0));
            System.out.println("내용: " + content);
            System.out.println("줄바꿈 개수: " + (content != null ? content.split("\n").length - 1 : 0));
            
            Qna qna = new Qna();
            qna.setTitle(title.trim());
            qna.setName(name.trim());
            qna.setContent(content);
            qna.setNotice("N"); // 일반글
            qna.setRegdate(LocalDateTime.now());
            qna.setCreatedAt(LocalDateTime.now());
            qna.setUpdatedAt(LocalDateTime.now());
            qna.setRef(0); // 조회수 초기값
            
            qnaService.saveQna(qna);
            
            redirectAttributes.addFlashAttribute("success", "문의가 성공적으로 등록되었습니다.");
            return "redirect:/ticket-qna";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "등록 중 오류가 발생했습니다. 다시 시도해주세요.");
            return "redirect:/ticket-qna-new";
        }
    }
    
    // 비밀번호 확인 페이지
    @GetMapping("/ticket-qna-password")
    public String ticketQnaPassword(@RequestParam Integer uid, Model model) {
        // 현재 날짜 정보 추가
        LocalDateTime now = LocalDateTime.now();
        model.addAttribute("currentYear", now.getYear());
        model.addAttribute("currentMonth", now.getMonthValue());
        model.addAttribute("currentDate", now);
        
        model.addAttribute("uid", uid);
        return "ticket-qna-password";
    }
    
    // 비밀번호 확인 처리
    @PostMapping("/ticket-qna-password")
    public String ticketQnaPasswordSubmit(@RequestParam Integer uid,
                                        @RequestParam String passwd,
                                        RedirectAttributes redirectAttributes) {
        
        if (passwd == null || passwd.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "비밀번호를 입력해주세요.");
            redirectAttributes.addAttribute("uid", uid);
            return "redirect:/ticket-qna-password";
        }
        
        // 비밀번호 확인
        boolean isValidPassword = qnaService.checkPassword(uid, passwd.trim());
        
        if (isValidPassword) {
            // 비밀번호가 맞으면 상세페이지로 이동
            return "redirect:/ticket-qna-detail?uid=" + uid;
        } else {
            // 비밀번호가 틀리면 다시 비밀번호 입력 페이지로
            redirectAttributes.addFlashAttribute("error", "비밀번호가 맞지 않습니다.");
            redirectAttributes.addAttribute("uid", uid);
            return "redirect:/ticket-qna-password";
        }
    }
    
    // 티켓문의 상세 페이지
    @GetMapping("/ticket-qna-detail")
    public String ticketQnaDetail(@RequestParam Integer uid, Model model) {
        // 현재 날짜 정보 추가
        LocalDateTime now = LocalDateTime.now();
        model.addAttribute("currentYear", now.getYear());
        model.addAttribute("currentMonth", now.getMonthValue());
        model.addAttribute("currentDate", now);
        
        var qna = qnaService.findQnaById(uid);
        if (qna.isPresent()) {
            // 조회수 증가
            qnaService.incrementRef(uid);
            
            Qna qnaEntity = qna.get();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            
            // 상세 페이지 QnaDto 생성자
            QnaDto qnaDto = new QnaDto(
                qnaEntity.getUid(),
                qnaEntity.getName(),
                qnaEntity.getTitle(),
                qnaEntity.getContent(),
                qnaEntity.getNotice(),
                qnaEntity.getRegdate() != null ? qnaEntity.getRegdate().format(formatter) : "",
                qnaEntity.getRef() != null ? qnaEntity.getRef() : 0,
                0,
                qnaEntity.getParentPostId()
            );
            
            // 답변 목록 조회
            List<Qna> replies = qnaService.findRepliesByParentId(uid);
            List<QnaDto> replyDtos = replies.stream()
                .map(reply -> new QnaDto(
                    reply.getUid(),
                    reply.getName(),
                    reply.getTitle(),
                    reply.getContent(),
                    reply.getNotice(),
                    reply.getRegdate() != null ? reply.getRegdate().format(formatter) : "",
                    reply.getRef() != null ? reply.getRef() : 0,
                    0,
                    reply.getParentPostId()
                ))
                .collect(Collectors.toList());
            
            model.addAttribute("qna", qnaDto);
            model.addAttribute("replies", replyDtos);
            return "ticket-qna-detail";
        } else {
            return "redirect:/ticket-qna";
        }
    }
    
    // 티켓문의 수정 페이지
    @GetMapping("/ticket-qna-edit")
    public String ticketQnaEdit(@RequestParam Integer uid, Model model) {
        // 현재 날짜 정보 추가
        LocalDateTime now = LocalDateTime.now();
        model.addAttribute("currentYear", now.getYear());
        model.addAttribute("currentMonth", now.getMonthValue());
        model.addAttribute("currentDate", now);
        
        var qna = qnaService.findQnaById(uid);
        if (qna.isPresent()) {
            Qna qnaEntity = qna.get();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            
            // 수정 페이지 QnaDto 생성자
            QnaDto qnaDto = new QnaDto(
                qnaEntity.getUid(),
                qnaEntity.getName(),
                qnaEntity.getTitle(),
                qnaEntity.getContent(),
                qnaEntity.getNotice(),
                qnaEntity.getRegdate() != null ? qnaEntity.getRegdate().format(formatter) : "",
                qnaEntity.getRef() != null ? qnaEntity.getRef() : 0,
                0,
                qnaEntity.getParentPostId()
            );
            
            model.addAttribute("qna", qnaDto);
            return "ticket-qna-edit";
        } else {
            return "redirect:/ticket-qna";
        }
    }
    
    // 티켓문의 수정 처리
    @PostMapping("/ticket-qna-edit")
    public String ticketQnaEditSubmit(@RequestParam Integer uid,
                                    @RequestParam String title,
                                    @RequestParam String content,
                                    RedirectAttributes redirectAttributes) {
        
        // 필수 입력 검증
        if (title == null || title.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "제목을 입력해주세요.");
            redirectAttributes.addAttribute("uid", uid);
            return "redirect:/ticket-qna-edit";
        }
        if (content == null || content.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "내용을 입력해주세요.");
            redirectAttributes.addAttribute("uid", uid);
            return "redirect:/ticket-qna-edit";
        }
        
        try {
            // 디버깅: 받은 내용 확인
            System.out.println("=== 티켓문의 수정 디버깅 ===");
            System.out.println("UID: " + uid);
            System.out.println("제목: " + title);
            System.out.println("내용 길이: " + (content != null ? content.length() : 0));
            System.out.println("내용: " + content);
            System.out.println("줄바꿈 개수: " + (content != null ? content.split("\n").length - 1 : 0));
            
            Optional<Qna> optionalQna = qnaService.findQnaById(uid);
            if (optionalQna.isPresent()) {
                Qna qna = optionalQna.get();
                qna.setTitle(title.trim());
                qna.setContent(content);
                qna.setUpdatedAt(LocalDateTime.now());
                
                qnaService.updateQna(qna);
                
                redirectAttributes.addFlashAttribute("success", "문의가 성공적으로 수정되었습니다.");
                return "redirect:/ticket-qna-detail?uid=" + uid;
            } else {
                redirectAttributes.addFlashAttribute("error", "존재하지 않는 게시글입니다.");
                return "redirect:/ticket-qna";
            }
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "수정 중 오류가 발생했습니다. 다시 시도해주세요.");
            redirectAttributes.addAttribute("uid", uid);
            return "redirect:/ticket-qna-edit";
        }
    }
    
    // 티켓문의 삭제 처리
    @PostMapping("/ticket-qna-delete")
    public String ticketQnaDelete(@RequestParam Integer uid,
                                RedirectAttributes redirectAttributes) {
        
        try {
            boolean deleted = qnaService.deleteQna(uid);
            if (deleted) {
                redirectAttributes.addFlashAttribute("success", "삭제가 되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("error", "삭제 중 오류가 발생했습니다.");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "삭제 중 오류가 발생했습니다.");
        }
        
        return "redirect:/ticket-qna";
    }
    
    // DTO 클래스
    public static class QnaDto {
        private Integer uid;
        private String name;
        private String title;
        private String content;
        private String notice;
        private String regdate;
        private Integer ref;
        private Integer replyCount;
        private Integer parentPostId; // Added parentPostId field
        
        public QnaDto(Integer uid, String name, String title, String content, String notice, String regdate, Integer ref, Integer replyCount, Integer parentPostId) {
            this.uid = uid;
            this.name = name;
            this.title = title;
            this.content = content;
            this.notice = notice;
            this.regdate = regdate;
            this.ref = ref;
            this.replyCount = replyCount;
            this.parentPostId = parentPostId;
        }
        
        // Getter와 Setter
        public Integer getUid() { return uid; }
        public void setUid(Integer uid) { this.uid = uid; }
        
        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
        
        public String getTitle() { return title; }
        public void setTitle(String title) { this.title = title; }
        
        public String getContent() { return content; }
        public void setContent(String content) { this.content = content; }
        
        public String getNotice() { return notice; }
        public void setNotice(String notice) { this.notice = notice; }
        
        public String getRegdate() { return regdate; }
        public void setRegdate(String regdate) { this.regdate = regdate; }
        
        public Integer getRef() { return ref; }
        public void setRef(Integer ref) { this.ref = ref; }
        
        public Integer getReplyCount() { return replyCount; }
        public void setReplyCount(Integer replyCount) { this.replyCount = replyCount; }

        public Integer getParentPostId() { return parentPostId; }
        public void setParentPostId(Integer parentPostId) { this.parentPostId = parentPostId; }
    }
} 