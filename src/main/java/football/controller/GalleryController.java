package football.controller;

import football.entity.Gallery;
import football.service.GalleryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.WebDataBinder;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import java.util.Optional;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin/gallery")
public class GalleryController {
    
    @Autowired
    private GalleryService galleryService;
    
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.setDisallowedFields("img");
    }
    
    // 갤러리 목록 페이지 (검색 포함)
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "0") int page, 
                      @RequestParam(required = false) String keyword,
                      @RequestParam(defaultValue = "all") String searchType,
                      Model model) {
        Page<Gallery> galleryPage;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            // 검색이 있는 경우
            switch (searchType) {
                case "title":
                    galleryPage = galleryService.searchByTitle(keyword, page, 10);
                    break;
                case "name":
                    galleryPage = galleryService.searchByName(keyword, page, 10);
                    break;
                default:
                    galleryPage = galleryService.searchByTitleOrName(keyword, page, 10);
                    break;
            }
            model.addAttribute("keyword", keyword);
            model.addAttribute("searchType", searchType);
        } else {
            // 검색이 없는 경우
            galleryPage = galleryService.getAllGalleries(page, 10);
        }
        
        model.addAttribute("galleries", galleryPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", galleryPage.getTotalPages());
        model.addAttribute("totalItems", galleryPage.getTotalElements());
        model.addAttribute("hasNext", galleryPage.hasNext());
        model.addAttribute("hasPrevious", galleryPage.hasPrevious());
        
        return "admin/gallery/list";
    }
    
    // 갤러리 등록 페이지
    @GetMapping("/register")
    public String registerForm(Model model) {
        model.addAttribute("gallery", new Gallery());
        return "admin/gallery/register";
    }
    
    // 갤러리 등록 처리
    @PostMapping("/register")
    public String register(@ModelAttribute("gallery") Gallery gallery, 
                         @RequestParam(value = "img", required = false) MultipartFile file, 
                         Model model) {
        try {
            // 이미지 파일 처리
            if (file != null && !file.isEmpty()) {
                String uploadDir = "src/main/webapp/uploads/gallery";
                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                
                String originalFilename = file.getOriginalFilename();
                String extension = "";
                if (originalFilename != null && originalFilename.contains(".")) {
                    extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                }
                
                String filename = UUID.randomUUID().toString() + extension;
                Path filePath = Paths.get(uploadDir, filename);
                
                Files.copy(file.getInputStream(), filePath);
                gallery.setImg(filename);
            }
            
            galleryService.createGallery(gallery);
            return "redirect:/admin/gallery/list";
        } catch (Exception e) {
            model.addAttribute("error", "갤러리 등록 중 오류가 발생했습니다: " + e.getMessage());
            model.addAttribute("gallery", gallery);
            return "admin/gallery/register";
        }
    }
    
    // 갤러리 상세 보기
    @GetMapping("/view/{uid}")
    public String view(@PathVariable Integer uid, Model model) {
        Optional<Gallery> gallery = galleryService.getGalleryById(uid);
        if (gallery.isPresent()) {
            model.addAttribute("gallery", gallery.get());
            return "admin/gallery/view";
        } else {
            return "redirect:/admin/gallery/list";
        }
    }
    
    // 갤러리 수정 페이지
    @GetMapping("/edit/{uid}")
    public String editForm(@PathVariable Integer uid, Model model) {
        Optional<Gallery> gallery = galleryService.getGalleryById(uid);
        if (gallery.isPresent()) {
            model.addAttribute("gallery", gallery.get());
            return "admin/gallery/edit";
        } else {
            return "redirect:/admin/gallery/list";
        }
    }
    
    // 갤러리 수정 처리
    @PostMapping("/edit/{uid}")
    public String edit(@PathVariable Integer uid, 
                      @ModelAttribute("gallery") Gallery gallery, 
                      @RequestParam(value = "img", required = false) MultipartFile file, 
                      Model model) {
        try {
            // 이미지 파일 처리
            if (file != null && !file.isEmpty()) {
                String uploadDir = "src/main/webapp/uploads/gallery";
                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                
                String originalFilename = file.getOriginalFilename();
                String extension = "";
                if (originalFilename != null && originalFilename.contains(".")) {
                    extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                }
                
                String filename = UUID.randomUUID().toString() + extension;
                Path filePath = Paths.get(uploadDir, filename);
                
                Files.copy(file.getInputStream(), filePath);
                gallery.setImg(filename);
            }
            
            Gallery updatedGallery = galleryService.updateGallery(uid, gallery);
            if (updatedGallery != null) {
                return "redirect:/admin/gallery/list";
            } else {
                model.addAttribute("error", "갤러리를 찾을 수 없습니다.");
                return "admin/gallery/edit";
            }
        } catch (Exception e) {
            model.addAttribute("error", "갤러리 수정 중 오류가 발생했습니다: " + e.getMessage());
            model.addAttribute("gallery", gallery);
            return "admin/gallery/edit";
        }
    }
    
    // 갤러리 삭제 페이지
    @GetMapping("/delete/{uid}")
    public String deleteForm(@PathVariable Integer uid, Model model) {
        Optional<Gallery> gallery = galleryService.getGalleryById(uid);
        if (gallery.isPresent()) {
            model.addAttribute("gallery", gallery.get());
            return "admin/gallery/delete";
        } else {
            return "redirect:/admin/gallery/list";
        }
    }
    
    // 갤러리 삭제 처리
    @PostMapping("/delete/{uid}")
    public String delete(@PathVariable Integer uid) {
        galleryService.deleteGallery(uid);
        return "redirect:/admin/gallery/list";
    }
    
    // GalleryDto 내부 클래스 추가
    public static class GalleryDto {
        private Integer uid;
        private String name;
        private String title;
        private String content;
        private String img;
        private String regdate;
        private Integer ref;
        
        public GalleryDto(Integer uid, String name, String title, String content, String img, String regdate, Integer ref) {
            this.uid = uid;
            this.name = name;
            this.title = title;
            this.content = content;
            this.img = img;
            this.regdate = regdate;
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
        
        public Integer getRef() { return ref; }
        public void setRef(Integer ref) { this.ref = ref; }
    }

} 