package football.controller;

import football.entity.MainBanner;
import football.service.MainBannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Controller
@RequestMapping("/admin/main_banner")
public class MainBannerController {
    
    @Autowired
    private MainBannerService mainBannerService;
    
    // 메인 배너 목록 페이지
    @GetMapping("/list")
    public String listMainBanner(@RequestParam(defaultValue = "0") int page, Model model) {
        Page<MainBanner> mainBannerPage = mainBannerService.getMainBannerList(page, 10);
        model.addAttribute("mainBanners", mainBannerPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", mainBannerPage.getTotalPages());
        model.addAttribute("totalElements", mainBannerPage.getTotalElements());
        return "admin/main_banner/list";
    }
    
    // 메인 배너 등록 페이지
    @GetMapping("/register")
    public String registerMainBannerForm(Model model) {
        return "admin/main_banner/register";
    }
    
    // 메인 배너 등록 처리
    @PostMapping("/register")
    public String registerMainBanner(@RequestParam("imgName") String imgName,
                                   @RequestParam("file") MultipartFile file,
                                   Model model) {
        try {
            // 파일 업로드 처리
            String uploadDir = "src/main/webapp/uploads/main_banner";
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
            
            // 메인 배너 저장
            MainBanner mainBanner = new MainBanner(imgName, filename);
            mainBannerService.saveMainBanner(mainBanner);
            
            return "redirect:/admin/main_banner/list";
            
        } catch (IOException e) {
            model.addAttribute("error", "파일 업로드 중 오류가 발생했습니다.");
            return "admin/main_banner/register";
        }
    }
    
    // 메인 배너 수정 페이지
    @GetMapping("/edit/{uid}")
    public String editMainBannerForm(@PathVariable Integer uid, Model model) {
        MainBanner mainBanner = mainBannerService.getMainBanner(uid);
        if (mainBanner == null) {
            return "redirect:/admin/main_banner/list";
        }
        model.addAttribute("mainBanner", mainBanner);
        return "admin/main_banner/edit";
    }
    
    // 메인 배너 수정 처리
    @PostMapping("/edit/{uid}")
    public String editMainBanner(@PathVariable Integer uid,
                                @RequestParam("imgName") String imgName,
                                @RequestParam(value = "file", required = false) MultipartFile file,
                                Model model) {
        MainBanner mainBanner = mainBannerService.getMainBanner(uid);
        if (mainBanner == null) {
            return "redirect:/admin/main_banner/list";
        }
        
        mainBanner.setImgName(imgName);
        
        // 새 파일이 업로드된 경우에만 파일 처리
        if (file != null && !file.isEmpty()) {
            try {
                String uploadDir = "src/main/webapp/uploads/main_banner";
                String originalFilename = file.getOriginalFilename();
                String extension = "";
                if (originalFilename != null && originalFilename.contains(".")) {
                    extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                }
                
                String filename = UUID.randomUUID().toString() + extension;
                Path filePath = Paths.get(uploadDir, filename);
                Files.copy(file.getInputStream(), filePath);
                
                mainBanner.setImg(filename);
                
            } catch (IOException e) {
                model.addAttribute("error", "파일 업로드 중 오류가 발생했습니다.");
                model.addAttribute("mainBanner", mainBanner);
                return "admin/main_banner/edit";
            }
        }
        
        mainBannerService.updateMainBanner(mainBanner);
        return "redirect:/admin/main_banner/list";
    }
    
    // 메인 배너 삭제 처리
    @PostMapping("/delete/{uid}")
    public String deleteMainBanner(@PathVariable Integer uid) {
        mainBannerService.deleteMainBanner(uid);
        return "redirect:/admin/main_banner/list";
    }
} 