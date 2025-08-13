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
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import football.dto.QnaListDto;

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
        
        // QnaListDto로 변환하여 답변 개수 포함 (원본 문의만 표시)
        List<QnaListDto> qnaListDtos = qnaPage.getContent().stream()
            .filter(qna -> qna.getParentPostId() == null) // 원본 문의만 필터링
            .map(qna -> {
                // 답변 개수 조회
                List<Qna> replies = qnaService.findRepliesByParentId(qna.getUid());
                int replyCount = replies.size();
                
                return new QnaListDto(
                    qna.getUid(),
                    qna.getName(),
                    qna.getTitle(),
                    qna.getContent(),
                    qna.getNotice(),
                    qna.getRegdate(),
                    qna.getCreatedAt(),
                    qna.getRef(),
                    qna.getParentPostId(),
                    replyCount,
                    false // 원본 문의는 항상 false
                );
            })
            .sorted((a, b) -> {
                // 공지사항 우선 정렬
                if (a.getNotice().equals("Y") && !b.getNotice().equals("Y")) {
                    return -1;
                }
                if (!a.getNotice().equals("Y") && b.getNotice().equals("Y")) {
                    return 1;
                }
                // 공지사항이 같은 경우 날짜 역순 정렬 (최신순)
                LocalDateTime aDate = a.getRegdate() != null ? a.getRegdate() : a.getCreatedAt();
                LocalDateTime bDate = b.getRegdate() != null ? b.getRegdate() : b.getCreatedAt();
                if (aDate != null && bDate != null) {
                    return bDate.compareTo(aDate);
                }
                return 0;
            })
            .collect(java.util.stream.Collectors.toList());
        
        // 디버깅: 페이징 정보 출력
        System.out.println("=== 관리자 QNA 리스트 디버깅 ===");
        System.out.println("현재 페이지: " + page);
        System.out.println("총 페이지 수: " + qnaPage.getTotalPages());
        System.out.println("총 요소 수: " + qnaPage.getTotalElements());
        System.out.println("현재 페이지 요소 수: " + qnaPage.getContent().size());
        System.out.println("다음 페이지 존재: " + qnaPage.hasNext());
        System.out.println("이전 페이지 존재: " + qnaPage.hasPrevious());
        
        model.addAttribute("qnaList", qnaListDtos);
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
                          @RequestParam(required = false, defaultValue = "N") String notice,
                          RedirectAttributes redirectAttributes) {
        
        System.out.println("=== QNA 등록 요청 받음 ===");
        System.out.println("Title: " + title);
        System.out.println("Name: " + name);
        System.out.println("Content length: " + (content != null ? content.length() : 0));
        System.out.println("Notice: " + notice);
        
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
            
            Qna qna = new Qna(name, title, content, notice);
            System.out.println("QNA 객체 생성 완료");
            
            // 공지사항 값 검증 및 설정
            String noticeValue = "N"; // 기본값
            if (notice != null && notice.trim().equals("Y")) {
                noticeValue = "Y";
            }
            qna.setNotice(noticeValue);
            System.out.println("공지사항 설정: " + noticeValue);
            
            // 관리자 등록이므로 기본값 설정
            qna.setPasswd("admin"); // 기본 비밀번호
            qna.setRegdate(LocalDateTime.now());
            qna.setCreatedAt(LocalDateTime.now());
            qna.setUpdatedAt(LocalDateTime.now());
            qna.setRef(0); // 조회수 초기값
            
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
        System.out.println("=== QNA 상세보기 요청 - uid: " + uid + " ===");
        
        Optional<Qna> qna = qnaService.findQnaById(uid);
        if (qna.isPresent()) {
            Qna qnaEntity = qna.get();
            System.out.println("QNA 조회 성공 - uid: " + qnaEntity.getUid() + ", title: " + qnaEntity.getTitle());
            
            // 날짜를 String으로 변환
            java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd");
            String regdateStr = qnaEntity.getRegdate() != null ? qnaEntity.getRegdate().format(formatter) : ""; // Map으로 변환하여 모델에 담기
            java.util.Map<String, Object> qnaMap = new java.util.HashMap<>();
            qnaMap.put("uid", qnaEntity.getUid());
            qnaMap.put("name", qnaEntity.getName());
            qnaMap.put("title", qnaEntity.getTitle());
            qnaMap.put("content", qnaEntity.getContent());
            qnaMap.put("notice", qnaEntity.getNotice());
            qnaMap.put("regdate", regdateStr);
            qnaMap.put("ref", qnaEntity.getRef());
            
            System.out.println("qnaMap: " + qnaMap);
            model.addAttribute("qna", qnaMap);
            
            // 답변 목록 조회 및 변환
            List<Qna> replies = qnaService.findRepliesByParentId(uid);
            System.out.println("=== 답변 조회 디버깅 ===");
            System.out.println("조회할 parentId: " + uid);
            System.out.println("조회된 답변 개수: " + replies.size());
            
            List<java.util.Map<String, Object>> replyMaps = replies.stream()
                .map(reply -> {
                    java.util.Map<String, Object> replyMap = new java.util.HashMap<>();
                    replyMap.put("uid", reply.getUid());
                    replyMap.put("name", reply.getName());
                    replyMap.put("content", reply.getContent());
                    replyMap.put("regdate", reply.getRegdate() != null ? reply.getRegdate().format(formatter) : "");
                    
                    System.out.println("답변 정보 - uid: " + reply.getUid() + 
                                     ", name: " + reply.getName() + 
                                     ", parentPostId: " + reply.getParentPostId());
                    
                    return replyMap;
                })
                .collect(java.util.stream.Collectors.toList());
            
            System.out.println("replyMaps: " + replyMaps);
            model.addAttribute("replies", replyMaps);
            
            return "admin/qna/view";
        } else {
            System.out.println("QNA를 찾을 수 없음 - uid: " + uid);
            return "redirect:/admin/qna/list";
        }
    }
    
    // QNA 수정 페이지
    @GetMapping("/edit/{uid}")
    public String editForm(@PathVariable Integer uid, Model model) {
        try {
        Optional<Qna> qna = qnaService.findQnaById(uid);
        if (qna.isPresent()) {
                Qna qnaEntity = qna.get();
                
                // 날짜를 String으로 변환
                java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd");
                String regdateStr = qnaEntity.getRegdate() != null ? qnaEntity.getRegdate().format(formatter) : "";
                
                // Map으로 변환하여 모델에 담기
                java.util.Map<String, Object> qnaMap = new java.util.HashMap<>();
                qnaMap.put("uid", qnaEntity.getUid());
                qnaMap.put("name", qnaEntity.getName());
                qnaMap.put("title", qnaEntity.getTitle());
                qnaMap.put("content", qnaEntity.getContent());
                qnaMap.put("notice", qnaEntity.getNotice());
                qnaMap.put("regdate", regdateStr);
                qnaMap.put("ref", qnaEntity.getRef());
                
                model.addAttribute("qna", qnaMap);
            return "admin/qna/edit";
        } else {
                return "redirect:/admin/qna/list";
            }
        } catch (Exception e) {
            return "redirect:/admin/qna/list";
        }
    }
    
    // QNA 수정 처리
    @PostMapping("/edit/{uid}")
    public String edit(@PathVariable Integer uid,
                      @RequestParam String title,
                      @RequestParam String name,
                      @RequestParam String content,
                      @RequestParam(required = false) String notice,
                      RedirectAttributes redirectAttributes) {
        
        System.out.println("=== QNA 수정 요청 받음 ===");
        System.out.println("UID: " + uid);
        System.out.println("Title: " + title);
        System.out.println("Name: " + name);
        System.out.println("Content length: " + (content != null ? content.length() : 0));
        System.out.println("Notice parameter: " + notice);
        
        try {
            if (title == null || title.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "제목은 필수입니다.");
                return "redirect:/admin/qna/edit/" + uid;
            }
            
            if (name == null || name.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "작성자는 필수입니다.");
                return "redirect:/admin/qna/edit/" + uid;
            }
            
            if (content == null || content.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "내용은 필수입니다.");
                return "redirect:/admin/qna/edit/" + uid;
            }
            
            // 기존 QNA 조회
            Optional<Qna> existingQna = qnaService.findQnaById(uid);
            if (!existingQna.isPresent()) {
                redirectAttributes.addFlashAttribute("error", "수정할 QNA를 찾을 수 없습니다.");
                return "redirect:/admin/qna/list";
            }
            
            Qna qna = existingQna.get();
            
            // 공지사항 값 검증 및 설정
            String noticeValue = "N"; // 기본값
            if (notice != null && notice.trim().equals("Y")) {
                noticeValue = "Y";
            }
            
            System.out.println("최종 공지사항 설정: " + noticeValue);
            
            // 수정할 내용 설정
            qna.setTitle(title.trim());
            qna.setName(name.trim());
            qna.setContent(content);
            qna.setNotice(noticeValue);
            qna.setUpdatedAt(LocalDateTime.now());
            
            // QNA 수정
            Qna updatedQna = qnaService.updateQna(qna);
            if (updatedQna != null) {
                System.out.println("QNA 수정 완료 - 공지사항: " + updatedQna.getNotice());
                redirectAttributes.addFlashAttribute("success", "QNA가 성공적으로 수정되었습니다.");
                return "redirect:/admin/qna/view/" + uid;
            } else {
                redirectAttributes.addFlashAttribute("error", "QNA 수정에 실패했습니다.");
                return "redirect:/admin/qna/edit/" + uid;
            }
            
        } catch (Exception e) {
            System.err.println("QNA 수정 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "QNA 수정 중 오류가 발생했습니다: " + e.getMessage());
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
    
    // 답변 등록 페이지
    @GetMapping("/reply/{parentId}")
    public String replyForm(@PathVariable Integer parentId, Model model) {
        System.out.println("=== 답변 등록 페이지 요청 - parentId: " + parentId + " ===");
        
        Optional<Qna> qna = qnaService.findQnaById(parentId);
        if (qna.isPresent()) {
            Qna qnaEntity = qna.get();
            
            // 날짜를 String으로 변환
            java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd");
            String regdateStr = qnaEntity.getRegdate() != null ? qnaEntity.getRegdate().format(formatter) : "";
            
            // Map으로 변환하여 모델에 담기
            java.util.Map<String, Object> qnaMap = new java.util.HashMap<>();
            qnaMap.put("uid", qnaEntity.getUid());
            qnaMap.put("name", qnaEntity.getName());
            qnaMap.put("title", qnaEntity.getTitle());
            qnaMap.put("content", qnaEntity.getContent());
            qnaMap.put("notice", qnaEntity.getNotice());
            qnaMap.put("regdate", regdateStr);
            qnaMap.put("ref", qnaEntity.getRef());
            
            System.out.println("답변 등록을 위한 원본 문의: " + qnaMap);
            model.addAttribute("qna", qnaMap);
            
            return "admin/qna/reply";
        } else {
            System.out.println("원본 문의를 찾을 수 없음 - parentId: " + parentId);
            return "redirect:/admin/qna/list";
        }
    }
    
    // 답변 등록 처리
    @PostMapping("/reply/{parentId}")
    public String addReply(@PathVariable Integer parentId,
                          @RequestParam String name,
                          @RequestParam String content,
                          RedirectAttributes redirectAttributes) {
        
        System.out.println("=== 답변 등록 요청 받음 ===");
        System.out.println("ParentId: " + parentId);
        System.out.println("Name: " + name);
        System.out.println("Content length: " + (content != null ? content.length() : 0));
        
        try {
            // 원본 문의 확인
            Optional<Qna> originalQna = qnaService.findQnaById(parentId);
            if (!originalQna.isPresent()) {
                redirectAttributes.addFlashAttribute("error", "원본 문의를 찾을 수 없습니다.");
                return "redirect:/admin/qna/list";
            }
            
            Qna reply = new Qna();
            reply.setParentPostId(parentId);
            reply.setName(name);
            reply.setContent(content);
            reply.setTitle("답변"); // 답변용 제목 설정
            reply.setPasswd("admin"); // 관리자 답변이므로 기본 비밀번호 설정
            reply.setNotice("N"); // 일반 답변
            reply.setRegdate(LocalDateTime.now());
            reply.setCreatedAt(LocalDateTime.now());
            reply.setUpdatedAt(LocalDateTime.now());
            reply.setRef(0); // 조회수 초기값
            
            System.out.println("답변 객체 생성: " + reply);
            System.out.println("ParentPostId: " + reply.getParentPostId());
            System.out.println("Name: " + reply.getName());
            System.out.println("Content: " + reply.getContent());
            System.out.println("Title: " + reply.getTitle());
            System.out.println("Notice: " + reply.getNotice());
            System.out.println("Regdate: " + reply.getRegdate());
            System.out.println("CreatedAt: " + reply.getCreatedAt());
            System.out.println("UpdatedAt: " + reply.getUpdatedAt());
            System.out.println("Ref: " + reply.getRef());
            
            Qna savedReply = qnaService.saveReply(reply);
            System.out.println("답변 저장 완료 - uid: " + savedReply.getUid());
            System.out.println("저장된 답변의 ParentPostId: " + savedReply.getParentPostId());
            
            redirectAttributes.addFlashAttribute("success", "답변이 성공적으로 등록되었습니다.");
        } catch (Exception e) {
            System.err.println("답변 등록 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "답변 등록 중 오류가 발생했습니다: " + e.getMessage());
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
    
    // 테스트용 메서드
    @GetMapping("/test")
    public String test() {
        return "admin/qna/test";
    }
    
    // 답변 등록 디버깅 페이지
    @GetMapping("/debug")
    public String debug(Model model) {
        // uid 6783에 대한 답변 목록 조회
        List<Qna> replies = qnaService.findRepliesByParentId(6783);
        model.addAttribute("replies", replies);
        return "admin/qna/debug";
    }
} 