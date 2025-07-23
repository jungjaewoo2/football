package football.controller;

import football.entity.TeamInfo;
import football.service.TeamInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import java.util.Optional;

@Controller
@RequestMapping("/admin/team_info")
public class TeamInfoController {
    
    @Autowired
    private TeamInfoService teamInfoService;
    
    // 파일 업로드 경로 설정
    private static final String UPLOAD_DIR = "uploads/team_info/";
    
    // 팀정보 목록 페이지
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "0") int page,
                      @RequestParam(required = false) String search,
                      Model model) {
        
        int size = 10; // 한 페이지당 10개로 고정
        Page<TeamInfo> teamInfoPage;
        
        if (search != null && !search.trim().isEmpty()) {
            teamInfoPage = teamInfoService.searchTeamInfosByName(search, page, size);
        } else {
            teamInfoPage = teamInfoService.getAllTeamInfos(page, size);
        }
        
        model.addAttribute("teamInfos", teamInfoPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", teamInfoPage.getTotalPages());
        model.addAttribute("totalItems", teamInfoPage.getTotalElements());
        model.addAttribute("hasNext", teamInfoPage.hasNext());
        model.addAttribute("hasPrevious", teamInfoPage.hasPrevious());
        model.addAttribute("search", search);
        
        return "admin/team_info/list";
    }
    
    // 팀정보 등록 페이지
    @GetMapping("/register")
    public String registerForm(Model model) {
        model.addAttribute("teamInfo", new TeamInfo());
        return "admin/team_info/register";
    }
    
    // 팀정보 등록 처리
    @PostMapping("/register")
    public String register(@RequestParam("teamName") String teamName,
                          @RequestParam(value = "stadium", required = false) String stadium,
                          @RequestParam(value = "city", required = false) String city,
                          @RequestParam(value = "content", required = false) String content,
                          @RequestParam(value = "logoFile", required = false) MultipartFile logoFile,
                          @RequestParam(value = "seatFile", required = false) MultipartFile seatFile,
                          RedirectAttributes redirectAttributes) {
        try {
            TeamInfo teamInfo = new TeamInfo();
            teamInfo.setTeamName(teamName);
            teamInfo.setStadium(stadium);
            teamInfo.setCity(city);
            teamInfo.setContent(content);
            
            // 로고 이미지 처리
            if (logoFile != null && !logoFile.isEmpty()) {
                String logoFileName = saveFile(logoFile, "logo");
                teamInfo.setLogoImg(logoFileName);
            }
            
            // 좌석 이미지 처리
            if (seatFile != null && !seatFile.isEmpty()) {
                String seatFileName = saveFile(seatFile, "seat");
                teamInfo.setSeatImg(seatFileName);
            }
            
            teamInfoService.saveTeamInfo(teamInfo);
            redirectAttributes.addFlashAttribute("message", "팀정보가 성공적으로 등록되었습니다.");
            return "redirect:/admin/team_info/list";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "팀정보 등록 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/admin/team_info/register";
        }
    }
    
    // 팀정보 수정 페이지
    @GetMapping("/edit/{uid}")
    public String editForm(@PathVariable Integer uid, Model model, RedirectAttributes redirectAttributes) {
        Optional<TeamInfo> teamInfoOpt = teamInfoService.getTeamInfoById(uid);
        
        if (teamInfoOpt.isPresent()) {
            model.addAttribute("teamInfo", teamInfoOpt.get());
            return "admin/team_info/edit";
        } else {
            redirectAttributes.addFlashAttribute("error", "팀정보를 찾을 수 없습니다.");
            return "redirect:/admin/team_info/list";
        }
    }
    
    // 팀정보 수정 처리
    @PostMapping("/edit")
    public String edit(@RequestParam("uid") Integer uid,
                      @RequestParam("teamName") String teamName,
                      @RequestParam(value = "stadium", required = false) String stadium,
                      @RequestParam(value = "city", required = false) String city,
                      @RequestParam(value = "content", required = false) String content,
                      @RequestParam(value = "logoFile", required = false) MultipartFile logoFile,
                      @RequestParam(value = "seatFile", required = false) MultipartFile seatFile,
                      RedirectAttributes redirectAttributes) {
        try {
            // 기존 팀정보 조회
            Optional<TeamInfo> existingTeamInfo = teamInfoService.getTeamInfoById(uid);
            if (existingTeamInfo.isPresent()) {
                TeamInfo teamInfo = existingTeamInfo.get();
                teamInfo.setTeamName(teamName);
                teamInfo.setStadium(stadium);
                teamInfo.setCity(city);
                teamInfo.setContent(content);
                
                // 로고 이미지 처리
                if (logoFile != null && !logoFile.isEmpty()) {
                    String logoFileName = saveFile(logoFile, "logo");
                    teamInfo.setLogoImg(logoFileName);
                }
                
                // 좌석 이미지 처리
                if (seatFile != null && !seatFile.isEmpty()) {
                    String seatFileName = saveFile(seatFile, "seat");
                    teamInfo.setSeatImg(seatFileName);
                }
                
                teamInfoService.updateTeamInfo(teamInfo);
                redirectAttributes.addFlashAttribute("message", "팀정보가 성공적으로 수정되었습니다.");
                return "redirect:/admin/team_info/list";
            } else {
                redirectAttributes.addFlashAttribute("error", "팀정보를 찾을 수 없습니다.");
                return "redirect:/admin/team_info/list";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "팀정보 수정 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/admin/team_info/edit/" + uid;
        }
    }
    
    // 팀정보 삭제 페이지
    @GetMapping("/delete/{uid}")
    public String deleteForm(@PathVariable Integer uid, Model model, RedirectAttributes redirectAttributes) {
        Optional<TeamInfo> teamInfoOpt = teamInfoService.getTeamInfoById(uid);
        
        if (teamInfoOpt.isPresent()) {
            model.addAttribute("teamInfo", teamInfoOpt.get());
            return "admin/team_info/delete";
        } else {
            redirectAttributes.addFlashAttribute("error", "팀정보를 찾을 수 없습니다.");
            return "redirect:/admin/team_info/list";
        }
    }
    
    // 팀정보 삭제 처리
    @PostMapping("/delete/{uid}")
    public String delete(@PathVariable Integer uid, RedirectAttributes redirectAttributes) {
        try {
            teamInfoService.deleteTeamInfo(uid);
            redirectAttributes.addFlashAttribute("message", "팀정보가 성공적으로 삭제되었습니다.");
            return "redirect:/admin/team_info/list";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "팀정보 삭제 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/admin/team_info/delete/" + uid;
        }
    }
    
    // 파일 저장 메서드
    private String saveFile(MultipartFile file, String prefix) throws IOException {
        // webapp 경로 기준으로 uploads/team_info 폴더 생성
        String webappPath = System.getProperty("user.dir") + "/src/main/webapp/uploads/team_info";
        Path uploadPath = Paths.get(webappPath);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        // 파일명 생성 (UUID + 원본 확장자)
        String originalFilename = file.getOriginalFilename();
        String extension = getFileExtension(originalFilename);
        String filename = prefix + "_" + UUID.randomUUID().toString() + "." + extension;

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