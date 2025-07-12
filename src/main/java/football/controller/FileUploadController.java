package football.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/admin/upload")
public class FileUploadController {
    
    @Value("${file.upload.path:/uploads/qna}")
    private String uploadPath;
    
    @Value("${file.upload.gallery.path:/uploads/gallery}")
    private String galleryUploadPath;
    
    @Value("${file.upload.customer-center.path:/uploads/customer-center}")
    private String customerCenterUploadPath;
    
    @Value("${file.upload.popup.path:/uploads/popup}")
    private String popupUploadPath;
    
    @PostMapping("/image")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> uploadImage(@RequestParam("upload") MultipartFile file) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 업로드 디렉토리 생성
            String uploadDir = uploadPath;
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            
            // 파일 확장자 검사
            String originalFilename = file.getOriginalFilename();
            String extension = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            }
            
            // 허용된 이미지 확장자 검사
            if (!isValidImageExtension(extension)) {
                response.put("error", "허용되지 않는 파일 형식입니다. (jpg, jpeg, png, gif만 가능)");
                return ResponseEntity.badRequest().body(response);
            }
            
            // 파일 크기 검사 (5MB 제한)
            if (file.getSize() > 5 * 1024 * 1024) {
                response.put("error", "파일 크기는 5MB를 초과할 수 없습니다.");
                return ResponseEntity.badRequest().body(response);
            }
            
            // 고유한 파일명 생성
            String filename = UUID.randomUUID().toString() + extension;
            Path filePath = Paths.get(uploadDir, filename);
            
            // 파일 저장
            Files.copy(file.getInputStream(), filePath);
            
            // 응답 데이터 설정
            response.put("url", "/uploads/qna/" + filename);
            response.put("uploaded", true);
            
            return ResponseEntity.ok(response);
            
        } catch (IOException e) {
            response.put("error", "파일 업로드 중 오류가 발생했습니다.");
            return ResponseEntity.internalServerError().body(response);
        }
    }
    
    @PostMapping("/gallery/image")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> uploadGalleryImage(@RequestParam("upload") MultipartFile file) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 업로드 디렉토리 생성
            String uploadDir = galleryUploadPath;
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            
            // 파일 확장자 검사
            String originalFilename = file.getOriginalFilename();
            String extension = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            }
            
            // 허용된 이미지 확장자 검사
            if (!isValidImageExtension(extension)) {
                response.put("error", "허용되지 않는 파일 형식입니다. (jpg, jpeg, png, gif만 가능)");
                return ResponseEntity.badRequest().body(response);
            }
            
            // 파일 크기 검사 (10MB 제한 - gallery는 더 큰 이미지 허용)
            if (file.getSize() > 10 * 1024 * 1024) {
                response.put("error", "파일 크기는 10MB를 초과할 수 없습니다.");
                return ResponseEntity.badRequest().body(response);
            }
            
            // 고유한 파일명 생성
            String filename = UUID.randomUUID().toString() + extension;
            Path filePath = Paths.get(uploadDir, filename);
            
            // 파일 저장
            Files.copy(file.getInputStream(), filePath);
            
            // 응답 데이터 설정
            response.put("url", "/uploads/gallery/" + filename);
            response.put("uploaded", true);
            
            return ResponseEntity.ok(response);
            
        } catch (IOException e) {
            response.put("error", "파일 업로드 중 오류가 발생했습니다.");
            return ResponseEntity.internalServerError().body(response);
        }
    }
    
    @PostMapping("/customer-center/image")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> uploadCustomerCenterImage(@RequestParam("upload") MultipartFile file) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 업로드 디렉토리 생성
            String uploadDir = customerCenterUploadPath;
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            
            // 파일 확장자 검사
            String originalFilename = file.getOriginalFilename();
            String extension = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            }
            
            // 허용된 이미지 확장자 검사
            if (!isValidImageExtension(extension)) {
                response.put("error", "허용되지 않는 파일 형식입니다. (jpg, jpeg, png, gif만 가능)");
                return ResponseEntity.badRequest().body(response);
            }
            
            // 파일 크기 검사 (10MB 제한)
            if (file.getSize() > 10 * 1024 * 1024) {
                response.put("error", "파일 크기는 10MB를 초과할 수 없습니다.");
                return ResponseEntity.badRequest().body(response);
            }
            
            // 고유한 파일명 생성
            String filename = UUID.randomUUID().toString() + extension;
            Path filePath = Paths.get(uploadDir, filename);
            
            // 파일 저장
            Files.copy(file.getInputStream(), filePath);
            
            // 응답 데이터 설정
            response.put("url", "/uploads/customer-center/" + filename);
            response.put("uploaded", true);
            
            return ResponseEntity.ok(response);
            
        } catch (IOException e) {
            response.put("error", "파일 업로드 중 오류가 발생했습니다.");
            return ResponseEntity.internalServerError().body(response);
        }
    }
    
    @PostMapping("/popup/image")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> uploadPopupImage(@RequestParam("upload") MultipartFile file) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 업로드 디렉토리 생성
            String uploadDir = popupUploadPath;
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            
            // 파일 확장자 검사
            String originalFilename = file.getOriginalFilename();
            String extension = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            }
            
            // 허용된 이미지 확장자 검사
            if (!isValidImageExtension(extension)) {
                response.put("error", "허용되지 않는 파일 형식입니다. (jpg, jpeg, png, gif만 가능)");
                return ResponseEntity.badRequest().body(response);
            }
            
            // 파일 크기 검사 (10MB 제한)
            if (file.getSize() > 10 * 1024 * 1024) {
                response.put("error", "파일 크기는 10MB를 초과할 수 없습니다.");
                return ResponseEntity.badRequest().body(response);
            }
            
            // 고유한 파일명 생성
            String filename = UUID.randomUUID().toString() + extension;
            Path filePath = Paths.get(uploadDir, filename);
            
            // 파일 저장
            Files.copy(file.getInputStream(), filePath);
            
            // 응답 데이터 설정
            response.put("url", "/uploads/popup/" + filename);
            response.put("uploaded", true);
            
            return ResponseEntity.ok(response);
            
        } catch (IOException e) {
            response.put("error", "파일 업로드 중 오류가 발생했습니다.");
            return ResponseEntity.internalServerError().body(response);
        }
    }
    
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