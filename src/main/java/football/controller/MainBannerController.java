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
import jakarta.servlet.ServletContext;

@Controller
@RequestMapping("/admin/main_banner")
public class MainBannerController {
    
    @Autowired
    private MainBannerService mainBannerService;
    
    @Autowired
    private ServletContext servletContext;
    
    // 파일 업로드 경로 설정
    private static final String UPLOAD_DIR = "uploads/main_banner/";
    
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
                                   @RequestParam("url") String url,
                                   @RequestParam("file") MultipartFile file,
                                   Model model) {
        try {
            // 파일 업로드 처리
            String filename = saveFile(file);
            
            // 메인 배너 저장
            MainBanner mainBanner = new MainBanner(imgName, filename, url);
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
                                @RequestParam("url") String url,
                                @RequestParam(value = "file", required = false) MultipartFile file,
                                Model model) {
        MainBanner mainBanner = mainBannerService.getMainBanner(uid);
        if (mainBanner == null) {
            return "redirect:/admin/main_banner/list";
        }
        
        mainBanner.setImgName(imgName);
        mainBanner.setUrl(url);
        
        // 새 파일이 업로드된 경우에만 파일 처리
        if (file != null && !file.isEmpty()) {
            try {
                String filename = saveFile(file);
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
    
    // 파일 저장 메서드
    private String saveFile(MultipartFile file) throws IOException {
        // webapp 경로 기준으로 uploads/main_banner 폴더 생성
        String webappPath = servletContext.getRealPath("/") + "uploads/main_banner";
        Path uploadPath = Paths.get(webappPath);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        // 파일명 생성 (UUID + 원본 확장자)
        String originalFilename = file.getOriginalFilename();
        String extension = getFileExtension(originalFilename);
        String filename = UUID.randomUUID().toString() + "." + extension;

        // 파일 저장
        Path filePath = uploadPath.resolve(filename);
        Files.copy(file.getInputStream(), filePath);

        return filename;
    }

    // 파일 확장자 추출 메서드
    private String getFileExtension(String filename) {
        if (filename == null || filename.isEmpty()) return "jpg";
        int lastDot = filename.lastIndexOf('.');
        if (lastDot > 0 && lastDot < filename.length() - 1) {
            return filename.substring(lastDot + 1).toLowerCase();
        }
        return "jpg";
    }
} 