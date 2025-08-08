package football.controller;

import football.entity.Tour;
import football.service.TourService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import jakarta.servlet.ServletContext;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/admin/tour")
public class TourController {
    @Autowired
    private TourService tourService;
    
    @Autowired
    private ServletContext servletContext;

    @GetMapping({"", "/"})
    public String viewTour(Model model) {
        try {
            Tour tour = tourService.getTour();
            model.addAttribute("tour", tour);
            return "admin/tour/view";
        } catch (Exception e) {
            model.addAttribute("error", "유로풋볼투어 정보를 불러오는 중 오류가 발생했습니다: " + e.getMessage());
            return "admin/tour/view";
        }
    }

    @GetMapping("/edit")
    public String editTour(Model model) {
        try {
            Tour tour = tourService.getTour();
            model.addAttribute("tour", tour);
            return "admin/tour/edit";
        } catch (Exception e) {
            model.addAttribute("error", "유로풋볼투어 정보를 불러오는 중 오류가 발생했습니다: " + e.getMessage());
            return "admin/tour/edit";
        }
    }

    @PostMapping("/edit")
    public String updateTour(@ModelAttribute Tour tour, Model model) {
        try {
            tourService.saveTour(tour);
            return "redirect:/admin/tour?success=success";
        } catch (Exception e) {
            model.addAttribute("error", "유로풋볼투어 수정 중 오류가 발생했습니다: " + e.getMessage());
            model.addAttribute("tour", tour);
            return "admin/tour/edit";
        }
    }
    
    @PostMapping("/upload-image")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> uploadImage(@RequestParam("upload") MultipartFile file) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 파일이 비어있는지 확인
            if (file.isEmpty()) {
                response.put("uploaded", false);
                response.put("error", new HashMap<String, String>() {{
                    put("message", "업로드된 파일이 없습니다.");
                }});
                return ResponseEntity.badRequest().body(response);
            }
            
            // 업로드 디렉토리 생성 - 여러 경로 시도
            String uploadDir = null;
            Path uploadPath = null;
            
            // 1. servletContext.getRealPath() 시도
            String webappPath = servletContext.getRealPath("/");
            if (webappPath != null) {
                uploadDir = webappPath + "uploads/tour";
                uploadPath = Paths.get(uploadDir);
            }
            
            // 2. servletContext.getRealPath()가 null인 경우 현재 작업 디렉토리 사용
            if (uploadPath == null || !Files.exists(uploadPath.getParent())) {
                String currentDir = System.getProperty("user.dir");
                uploadDir = currentDir + "/src/main/webapp/uploads/tour";
                uploadPath = Paths.get(uploadDir);
            }
            
            // 3. 여전히 문제가 있는 경우 절대 경로 사용
            if (uploadPath == null || !Files.exists(uploadPath.getParent())) {
                uploadDir = "D:/Project/Zetta_Git/football/src/main/webapp/uploads/tour";
                uploadPath = Paths.get(uploadDir);
            }
            
            // 디렉토리 생성
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
                response.put("uploaded", false);
                response.put("error", new HashMap<String, String>() {{
                    put("message", "허용되지 않는 파일 형식입니다. (jpg, jpeg, png, gif, webp만 가능)");
                }});
                return ResponseEntity.badRequest().body(response);
            }
            
            // 파일 크기 검사 (10MB 제한)
            if (file.getSize() > 10 * 1024 * 1024) {
                response.put("uploaded", false);
                response.put("error", new HashMap<String, String>() {{
                    put("message", "파일 크기는 10MB를 초과할 수 없습니다.");
                }});
                return ResponseEntity.badRequest().body(response);
            }
            
            // 고유한 파일명 생성
            String filename = UUID.randomUUID().toString() + extension;
            Path filePath = uploadPath.resolve(filename);
            
            // 파일 저장
            Files.copy(file.getInputStream(), filePath, java.nio.file.StandardCopyOption.REPLACE_EXISTING);
            
            // 응답 데이터 설정
            response.put("uploaded", true);
            response.put("url", "/uploads/tour/" + filename);
            
            // 디버깅을 위한 로그
            System.out.println("파일 업로드 성공: " + filePath.toString());
            System.out.println("업로드 URL: " + "/uploads/tour/" + filename);
            
            return ResponseEntity.ok(response);
            
        } catch (IOException e) {
            e.printStackTrace();
            System.err.println("파일 업로드 중 IOException 발생: " + e.getMessage());
            response.put("uploaded", false);
            response.put("error", new HashMap<String, String>() {{
                put("message", "파일 업로드 중 오류가 발생했습니다: " + e.getMessage());
            }});
            return ResponseEntity.internalServerError().body(response);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("파일 업로드 중 예상치 못한 오류 발생: " + e.getMessage());
            response.put("uploaded", false);
            response.put("error", new HashMap<String, String>() {{
                put("message", "예상치 못한 오류가 발생했습니다: " + e.getMessage());
            }});
            return ResponseEntity.internalServerError().body(response);
        }
    }
    
    private boolean isValidImageExtension(String extension) {
        if (extension == null) return false;
        String lowerExtension = extension.toLowerCase();
        return lowerExtension.equals(".jpg") || 
               lowerExtension.equals(".jpeg") || 
               lowerExtension.equals(".png") || 
               lowerExtension.equals(".gif") || 
               lowerExtension.equals(".webp");
    }
} 