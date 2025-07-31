package football.controller;

import football.entity.MainImg;
import football.service.MainImgService;
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
@RequestMapping("/admin/main_img")
public class MainImgController {
    
    @Autowired
    private MainImgService mainImgService;
    
    // 메인 이미지 목록 페이지
    @GetMapping("/list")
    public String listMainImg(@RequestParam(defaultValue = "0") int page, Model model) {
        Page<MainImg> mainImgPage = mainImgService.getMainImgList(page, 10);
        model.addAttribute("mainImgs", mainImgPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", mainImgPage.getTotalPages());
        model.addAttribute("totalElements", mainImgPage.getTotalElements());
        return "admin/main_img/list";
    }
    
    // 메인 이미지 등록 페이지
    @GetMapping("/register")
    public String registerMainImgForm(Model model) {
        return "admin/main_img/register";
    }
    
    // 메인 이미지 등록 처리
    @PostMapping("/register")
    public String registerMainImg(@RequestParam("file") MultipartFile file,
                                @RequestParam(value = "linkUrl", required = false) String linkUrl,
                                Model model) {
        try {
            // 파일 업로드 처리
            String uploadDir = "src/main/webapp/uploads/main_img";
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
            
            // 원본 파일명에서 확장자를 제거한 이름을 이미지명으로 사용
            String imgName = originalFilename;
            if (imgName != null && imgName.contains(".")) {
                imgName = imgName.substring(0, imgName.lastIndexOf("."));
            }
            
            // 메인 이미지 저장
            MainImg mainImg = new MainImg(imgName, filename, linkUrl);
            mainImgService.saveMainImg(mainImg);
            
            return "redirect:/admin/main_img/list";
            
        } catch (IOException e) {
            model.addAttribute("error", "파일 업로드 중 오류가 발생했습니다.");
            return "admin/main_img/register";
        }
    }
    
    // 메인 이미지 수정 페이지
    @GetMapping("/edit/{uid}")
    public String editMainImgForm(@PathVariable Integer uid, Model model) {
        MainImg mainImg = mainImgService.getMainImg(uid);
        if (mainImg == null) {
            return "redirect:/admin/main_img/list";
        }
        model.addAttribute("mainImg", mainImg);
        return "admin/main_img/edit";
    }
    
    // 메인 이미지 수정 처리
    @PostMapping("/edit/{uid}")
    public String editMainImg(@PathVariable Integer uid,
                             @RequestParam(value = "file", required = false) MultipartFile file,
                             @RequestParam(value = "linkUrl", required = false) String linkUrl,
                             Model model) {
        MainImg mainImg = mainImgService.getMainImg(uid);
        if (mainImg == null) {
            return "redirect:/admin/main_img/list";
        }
        
        mainImg.setLinkUrl(linkUrl);
        
        // 새 파일이 업로드된 경우에만 파일 처리
        if (file != null && !file.isEmpty()) {
            try {
                String uploadDir = "src/main/webapp/uploads/main_img";
                String originalFilename = file.getOriginalFilename();
                String extension = "";
                if (originalFilename != null && originalFilename.contains(".")) {
                    extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                }
                
                String filename = UUID.randomUUID().toString() + extension;
                Path filePath = Paths.get(uploadDir, filename);
                Files.copy(file.getInputStream(), filePath);
                
                mainImg.setImg(filename);
                
            } catch (IOException e) {
                model.addAttribute("error", "파일 업로드 중 오류가 발생했습니다.");
                model.addAttribute("mainImg", mainImg);
                return "admin/main_img/edit";
            }
        }
        
        mainImgService.updateMainImg(mainImg);
        return "redirect:/admin/main_img/list";
    }
    
    // 메인 이미지 삭제 처리
    @PostMapping("/delete/{uid}")
    public String deleteMainImg(@PathVariable Integer uid) {
        mainImgService.deleteMainImg(uid);
        return "redirect:/admin/main_img/list";
    }
} 