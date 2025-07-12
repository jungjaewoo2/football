package football.controller;

import football.entity.Gallery;
import football.service.GalleryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
@RequestMapping("/admin/gallery")
public class GalleryController {
    
    @Autowired
    private GalleryService galleryService;
    
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
    public String register(@ModelAttribute Gallery gallery, Model model) {
        try {
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
    public String edit(@PathVariable Integer uid, @ModelAttribute Gallery gallery, Model model) {
        try {
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
    

} 