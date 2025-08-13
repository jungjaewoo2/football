package football.controller;

import football.entity.FooterInfo;
import football.service.FooterInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import jakarta.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Controller
@RequestMapping("/admin/footer_info")
public class FooterInfoController {
    @Autowired
    private FooterInfoService footerInfoService;
    
    @Autowired
    private ServletContext servletContext;

    @GetMapping("")
    public String viewFooterInfo(Model model) {
        FooterInfo footerInfo = footerInfoService.getFooterInfo();
        model.addAttribute("footerInfo", footerInfo);
        return "admin/footer_info/view";
    }

    @GetMapping("/edit")
    public String editFooterInfo(Model model) {
        FooterInfo footerInfo = footerInfoService.getFooterInfo();
        model.addAttribute("footerInfo", footerInfo);
        return "admin/footer_info/edit";
    }

    @PostMapping("/edit")
    public String updateFooterInfo(@RequestParam String phone, 
                                   @RequestParam String email, 
                                   @RequestParam String address,
                                   @RequestParam(value = "logo", required = false) MultipartFile logo) {
        try {
            FooterInfo footerInfo = footerInfoService.getFooterInfo();
            
            // 기존 데이터가 있으면 업데이트, 없으면 새로 생성
            if (footerInfo == null) {
                footerInfo = new FooterInfo();
            }
            
            footerInfo.setPhone(phone);
            footerInfo.setEmail(email);
            footerInfo.setAddress(address);
            
            // 로고 파일이 업로드된 경우 처리
            if (logo != null && !logo.isEmpty()) {
                String logoFileName = saveLogoFile(logo);
                if (logoFileName != null) {
                    footerInfo.setLogo(logoFileName);
                }
            }
            
            footerInfoService.saveFooterInfo(footerInfo);
            
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 처리 (필요시 리다이렉트나 에러 페이지로 이동)
        }
        
        return "redirect:/admin/footer_info";
    }
    
    /**
     * 로고 파일을 저장하고 파일명을 반환
     */
    private String saveLogoFile(MultipartFile file) {
        try {
            // 업로드 디렉토리 생성
            String webappPath = servletContext.getRealPath("/") + "uploads/footer_info";
            Path uploadPath = Paths.get(webappPath);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }
            
            // 파일 확장자 검사
            String originalFilename = file.getOriginalFilename();
            String extension = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            }
            
            // 허용된 이미지 확장자 검사
            if (!isValidImageExtension(extension)) {
                System.out.println("허용되지 않는 파일 형식: " + extension);
                return null;
            }
            
            // 파일 크기 검사 (5MB 제한)
            if (file.getSize() > 5 * 1024 * 1024) {
                System.out.println("파일 크기 초과: " + file.getSize());
                return null;
            }
            
            // 고유한 파일명 생성
            String filename = UUID.randomUUID().toString() + extension;
            Path filePath = uploadPath.resolve(filename);
            
            // 파일 저장
            Files.copy(file.getInputStream(), filePath);
            
            System.out.println("로고 파일 저장 성공: " + filename);
            return filename;
            
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * 허용된 이미지 확장자 검사
     */
    private boolean isValidImageExtension(String extension) {
        String[] allowedExtensions = {".jpg", ".jpeg", ".png", ".gif"};
        for (String allowed : allowedExtensions) {
            if (allowed.equalsIgnoreCase(extension)) {
                return true;
            }
        }
        return false;
    }
} 