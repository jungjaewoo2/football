package football.controller;

import football.entity.Popup;
import football.service.PopupService;
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
@RequestMapping("/admin/popup")
public class PopupController {
    @Autowired
    private PopupService popupService;

    // 팝업 목록 페이지 (루트 경로)
    @GetMapping("")
    public String popupIndex(@RequestParam(defaultValue = "0") int page, Model model) {
        Page<Popup> popupPage = popupService.getPopupList(page, 10);
        model.addAttribute("popups", popupPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", popupPage.getTotalPages());
        model.addAttribute("totalElements", popupPage.getTotalElements());
        return "admin/popup/list";
    }

    // 팝업 목록 페이지
    @GetMapping("/list")
    public String listPopup(@RequestParam(defaultValue = "0") int page, Model model) {
        Page<Popup> popupPage = popupService.getPopupList(page, 10);
        model.addAttribute("popups", popupPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", popupPage.getTotalPages());
        model.addAttribute("totalElements", popupPage.getTotalElements());
        return "admin/popup/list";
    }

    // 팝업 등록 페이지
    @GetMapping("/register")
    public String registerPopupForm(Model model) {
        return "admin/popup/register";
    }

    // 팝업 등록 처리
    @PostMapping("/register")
    public String registerPopup(@RequestParam("popupName") String popupName,
                              @RequestParam(value = "img", required = false) MultipartFile file,
                              Model model) {
        try {
            String filename = null;
            if (file != null && !file.isEmpty()) {
                String uploadDir = "src/main/webapp/uploads/popup";
                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                String originalFilename = file.getOriginalFilename();
                String extension = "";
                if (originalFilename != null && originalFilename.contains(".")) {
                    extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                }
                filename = UUID.randomUUID().toString() + extension;
                Path filePath = Paths.get(uploadDir, filename);
                Files.copy(file.getInputStream(), filePath);
            }
            Popup popup = new Popup(popupName, filename);
            popupService.savePopup(popup);
            return "redirect:/admin/popup/list";
        } catch (IOException e) {
            model.addAttribute("error", "파일 업로드 중 오류가 발생했습니다.");
            return "admin/popup/register";
        }
    }

    // 팝업 수정 페이지
    @GetMapping("/edit/{uid}")
    public String editPopupForm(@PathVariable Integer uid, Model model) {
        Popup popup = popupService.getPopup(uid);
        if (popup == null) {
            return "redirect:/admin/popup/list";
        }
        model.addAttribute("popup", popup);
        return "admin/popup/edit";
    }

    // 팝업 수정 처리
    @PostMapping("/edit/{uid}")
    public String editPopup(@PathVariable Integer uid,
                           @RequestParam("popupName") String popupName,
                           @RequestParam(value = "img", required = false) MultipartFile file,
                           Model model) {
        Popup popup = popupService.getPopup(uid);
        if (popup == null) {
            return "redirect:/admin/popup/list";
        }
        popup.setPopupName(popupName);
        if (file != null && !file.isEmpty()) {
            try {
                String uploadDir = "src/main/webapp/uploads/popup";
                String originalFilename = file.getOriginalFilename();
                String extension = "";
                if (originalFilename != null && originalFilename.contains(".")) {
                    extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                }
                String filename = UUID.randomUUID().toString() + extension;
                Path filePath = Paths.get(uploadDir, filename);
                Files.copy(file.getInputStream(), filePath);
                popup.setImg(filename);
            } catch (IOException e) {
                model.addAttribute("error", "파일 업로드 중 오류가 발생했습니다.");
                model.addAttribute("popup", popup);
                return "admin/popup/edit";
            }
        }
        popupService.updatePopup(popup);
        return "redirect:/admin/popup/list";
    }

    // 팝업 삭제 처리
    @PostMapping("/delete/{uid}")
    public String deletePopup(@PathVariable Integer uid) {
        popupService.deletePopup(uid);
        return "redirect:/admin/popup/list";
    }
} 