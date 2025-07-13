package football.controller;

import football.entity.Gallery;
import football.service.GalleryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.format.DateTimeFormatter;
import java.util.stream.Collectors;

@Controller
public class UserGalleryController {
    
    @Autowired
    private GalleryService galleryService;
    
    // 관전후기 목록 페이지
    @GetMapping("/board")
    public String board(@RequestParam(defaultValue = "0") int page, 
                       @RequestParam(required = false) String keyword,
                       @RequestParam(defaultValue = "all") String searchType,
                       Model model) {
        
        Page<Gallery> galleryPage;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            // 검색이 있는 경우
            switch (searchType) {
                case "title":
                    galleryPage = galleryService.searchByTitle(keyword, page, 9);
                    break;
                case "name":
                    galleryPage = galleryService.searchByName(keyword, page, 9);
                    break;
                default:
                    galleryPage = galleryService.searchByTitleOrName(keyword, page, 9);
                    break;
            }
            model.addAttribute("keyword", keyword);
            model.addAttribute("searchType", searchType);
        } else {
            // 검색이 없는 경우
            galleryPage = galleryService.getAllGalleries(page, 9);
        }
        
        // 날짜 포맷팅을 위한 DTO 변환
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        var galleryDtos = galleryPage.getContent().stream()
            .map(gallery -> {
                return new GalleryDto(
                    gallery.getUid(),
                    gallery.getName(),
                    gallery.getTitle(),
                    gallery.getContent(),
                    gallery.getImg(),
                    gallery.getRegdate() != null ? gallery.getRegdate().format(formatter) : "",
                    gallery.getCreatedAt() != null ? gallery.getCreatedAt().format(formatter) : "",
                    gallery.getRef() != null ? gallery.getRef() : 0
                );
            })
            .collect(Collectors.toList());
        
        model.addAttribute("galleries", galleryDtos);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", galleryPage.getTotalPages());
        model.addAttribute("totalItems", galleryPage.getTotalElements());
        model.addAttribute("hasNext", galleryPage.hasNext());
        model.addAttribute("hasPrevious", galleryPage.hasPrevious());
        
        return "board";
    }
    
    // 관전후기 상세 페이지
    @GetMapping("/board-detail")
    public String boardDetail(@RequestParam Integer uid, Model model) {
        var gallery = galleryService.getGalleryById(uid);
        if (gallery.isPresent()) {
            // 조회수 증가
            galleryService.incrementRef(uid);
            
            Gallery galleryEntity = gallery.get();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            
            GalleryDto galleryDto = new GalleryDto(
                galleryEntity.getUid(),
                galleryEntity.getName(),
                galleryEntity.getTitle(),
                galleryEntity.getContent(),
                galleryEntity.getImg(),
                galleryEntity.getRegdate() != null ? galleryEntity.getRegdate().format(formatter) : "",
                galleryEntity.getCreatedAt() != null ? galleryEntity.getCreatedAt().format(formatter) : "",
                galleryEntity.getRef() != null ? galleryEntity.getRef() : 0
            );
            
            model.addAttribute("gallery", galleryDto);
            return "board-detail";
        } else {
            return "redirect:/board";
        }
    }
    
    // DTO 클래스
    public static class GalleryDto {
        private Integer uid;
        private String name;
        private String title;
        private String content;
        private String img;
        private String regdate;
        private String createdAt;
        private Integer ref;
        
        public GalleryDto(Integer uid, String name, String title, String content, String img, String regdate, String createdAt, Integer ref) {
            this.uid = uid;
            this.name = name;
            this.title = title;
            this.content = content;
            this.img = img;
            this.regdate = regdate;
            this.createdAt = createdAt;
            this.ref = ref;
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
        
        public String getImg() { return img; }
        public void setImg(String img) { this.img = img; }
        
        public String getRegdate() { return regdate; }
        public void setRegdate(String regdate) { this.regdate = regdate; }
        
        public String getCreatedAt() { return createdAt; }
        public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
        
        public Integer getRef() { return ref; }
        public void setRef(Integer ref) { this.ref = ref; }
    }
} 