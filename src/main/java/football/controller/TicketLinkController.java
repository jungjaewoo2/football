package football.controller;

import football.entity.TicketLink;
import football.service.TicketLinkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Controller
@RequestMapping("/admin/ticket_link")
public class TicketLinkController {
    private static final Logger logger = LoggerFactory.getLogger(TicketLinkController.class);
    
    @Autowired
    private TicketLinkService ticketLinkService;

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "0") int page,
                      @RequestParam(required = false) String search,
                      Model model) {
        try {
            logger.info("티켓바로가기 목록 페이지 요청 - page: {}, search: {}", page, search);
            
            int size = 10; // 한 페이지당 10개로 고정
            Page<TicketLink> ticketLinkPage;
            
            if (search != null && !search.trim().isEmpty()) {
                ticketLinkPage = ticketLinkService.searchByTicketName(search, page, size);
            } else {
                ticketLinkPage = ticketLinkService.getAllTicketLinks(page, size);
            }
            
            // null 체크 추가
            if (ticketLinkPage != null) {
                model.addAttribute("ticketLinkList", ticketLinkPage.getContent());
                model.addAttribute("currentPage", page);
                model.addAttribute("totalPages", ticketLinkPage.getTotalPages());
                model.addAttribute("totalItems", ticketLinkPage.getTotalElements());
                model.addAttribute("hasNext", ticketLinkPage.hasNext());
                model.addAttribute("hasPrevious", ticketLinkPage.hasPrevious());
            } else {
                // 빈 리스트로 초기화
                model.addAttribute("ticketLinkList", new ArrayList<>());
                model.addAttribute("currentPage", 0);
                model.addAttribute("totalPages", 0);
                model.addAttribute("totalItems", 0L);
                model.addAttribute("hasNext", false);
                model.addAttribute("hasPrevious", false);
            }
            model.addAttribute("search", search);
            
            logger.info("티켓바로가기 목록 조회 완료 - 데이터 수: {}", 
                       ticketLinkPage != null ? ticketLinkPage.getContent().size() : 0);
            
            return "admin/ticket_link/list";
        } catch (Exception e) {
            logger.error("티켓바로가기 목록 조회 중 오류 발생", e);
            model.addAttribute("error", "티켓바로가기 목록을 불러오는 중 오류가 발생했습니다: " + e.getMessage());
            // 오류 발생 시 빈 리스트로 초기화
            model.addAttribute("ticketLinkList", new ArrayList<>());
            model.addAttribute("currentPage", 0);
            model.addAttribute("totalPages", 0);
            model.addAttribute("totalItems", 0L);
            model.addAttribute("hasNext", false);
            model.addAttribute("hasPrevious", false);
            model.addAttribute("search", search);
            return "admin/ticket_link/list";
        }
    }

    @GetMapping("/register")
    public String registerForm(Model model) {
        try {
            logger.info("티켓바로가기 등록 페이지 요청");
            model.addAttribute("ticketLink", new TicketLink());
            return "admin/ticket_link/register";
        } catch (Exception e) {
            logger.error("티켓바로가기 등록 페이지 로드 중 오류 발생", e);
            model.addAttribute("error", "페이지를 불러오는 중 오류가 발생했습니다.");
            return "admin/ticket_link/register";
        }
    }

    @PostMapping("/register")
    public String register(@RequestParam("ticketName") String ticketName,
                          @RequestParam("ticketSubTitle") String ticketSubTitle,
                          @RequestParam(value = "ticketImg", required = false) MultipartFile ticketImg,
                          @RequestParam("content") String content,
                          @RequestParam("link") String link,
                          Model model) {
        try {
            logger.info("티켓바로가기 등록 요청 시작");
            
            TicketLink ticketLink = new TicketLink();
            ticketLink.setTicketName(ticketName);
            ticketLink.setTicketSubTitle(ticketSubTitle);
            ticketLink.setContent(content);
            ticketLink.setLink(link);
            
            // 이미지 파일 처리
            if (ticketImg != null && !ticketImg.isEmpty()) {
                String fileName = saveImage(ticketImg);
                ticketLink.setTicketImg(fileName);
            }
            
            ticketLinkService.save(ticketLink);
            logger.info("티켓바로가기 등록 완료");
            return "redirect:/admin/ticket_link/list";
        } catch (Exception e) {
            logger.error("티켓바로가기 등록 중 오류 발생", e);
            model.addAttribute("error", "티켓바로가기 등록 중 오류가 발생했습니다.");
            return "admin/ticket_link/register";
        }
    }

    @GetMapping("/edit/{uid}")
    public String editForm(@PathVariable Integer uid, Model model) {
        try {
            logger.info("티켓바로가기 수정 페이지 요청: uid={}", uid);
            Optional<TicketLink> ticketLink = ticketLinkService.findById(uid);
            if (ticketLink.isPresent()) {
                model.addAttribute("ticketLink", ticketLink.get());
                return "admin/ticket_link/edit";
            } else {
                logger.warn("티켓바로가기 정보를 찾을 수 없음: uid={}", uid);
                return "redirect:/admin/ticket_link/list";
            }
        } catch (Exception e) {
            logger.error("티켓바로가기 수정 페이지 로드 중 오류 발생", e);
            return "redirect:/admin/ticket_link/list";
        }
    }

    @PostMapping("/edit/{uid}")
    public String edit(@PathVariable Integer uid,
                      @RequestParam("ticketName") String ticketName,
                      @RequestParam("ticketSubTitle") String ticketSubTitle,
                      @RequestParam(value = "ticketImg", required = false) MultipartFile ticketImg,
                      @RequestParam("content") String content,
                      @RequestParam("link") String link,
                      Model model) {
        try {
            logger.info("티켓바로가기 수정 요청 시작: uid={}", uid);
            
            Optional<TicketLink> existingTicketLink = ticketLinkService.findById(uid);
            if (!existingTicketLink.isPresent()) {
                logger.warn("수정할 티켓바로가기 정보를 찾을 수 없음: uid={}", uid);
                return "redirect:/admin/ticket_link/list";
            }
            
            TicketLink ticketLink = existingTicketLink.get();
            ticketLink.setTicketName(ticketName);
            ticketLink.setTicketSubTitle(ticketSubTitle);
            ticketLink.setContent(content);
            ticketLink.setLink(link);
            
            // 이미지 파일 처리
            if (ticketImg != null && !ticketImg.isEmpty()) {
                String fileName = saveImage(ticketImg);
                ticketLink.setTicketImg(fileName);
            }
            
            ticketLinkService.save(ticketLink);
            logger.info("티켓바로가기 수정 완료");
            return "redirect:/admin/ticket_link/list";
        } catch (Exception e) {
            logger.error("티켓바로가기 수정 중 오류 발생", e);
            model.addAttribute("error", "티켓바로가기 수정 중 오류가 발생했습니다.");
            return "admin/ticket_link/edit";
        }
    }

    @GetMapping("/delete/{uid}")
    public String deleteForm(@PathVariable Integer uid, Model model) {
        try {
            logger.info("티켓바로가기 삭제 확인 페이지 요청: uid={}", uid);
            Optional<TicketLink> ticketLink = ticketLinkService.findById(uid);
            if (ticketLink.isPresent()) {
                model.addAttribute("ticketLink", ticketLink.get());
                return "admin/ticket_link/delete";
            } else {
                logger.warn("삭제할 티켓바로가기 정보를 찾을 수 없음: uid={}", uid);
                return "redirect:/admin/ticket_link/list";
            }
        } catch (Exception e) {
            logger.error("티켓바로가기 삭제 확인 페이지 로드 중 오류 발생", e);
            return "redirect:/admin/ticket_link/list";
        }
    }

    @PostMapping("/delete/{uid}")
    public String delete(@PathVariable Integer uid) {
        try {
            logger.info("티켓바로가기 삭제 요청: uid={}", uid);
            ticketLinkService.deleteById(uid);
            logger.info("티켓바로가기 삭제 완료");
            return "redirect:/admin/ticket_link/list";
        } catch (Exception e) {
            logger.error("티켓바로가기 삭제 중 오류 발생", e);
            return "redirect:/admin/ticket_link/list";
        }
    }

    // 사용자 페이지용 티켓바로가기 목록 조회
    @GetMapping("/ticket-links")
    public String getTicketLinks(Model model) {
        try {
            logger.info("사용자 페이지 티켓바로가기 목록 요청");
            List<TicketLink> ticketLinks = ticketLinkService.findAll();
            model.addAttribute("ticketLinks", ticketLinks);
            return "ticket-links";
        } catch (Exception e) {
            logger.error("티켓바로가기 목록 조회 중 오류 발생", e);
            model.addAttribute("error", "티켓바로가기 목록을 불러오는 중 오류가 발생했습니다.");
            return "ticket-links";
        }
    }

    // 이미지 파일 저장 메서드
    private String saveImage(MultipartFile file) throws IOException {
        String uploadDir = "src/main/webapp/uploads/ticket_link/";
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        
        String originalFilename = file.getOriginalFilename();
        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String fileName = UUID.randomUUID().toString() + extension;
        
        Path filePath = Paths.get(uploadDir + fileName);
        Files.write(filePath, file.getBytes());
        
        return fileName;
    }
} 