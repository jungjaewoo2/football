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
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

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
        
        // 조건문 로직을 컨트롤러에서 처리
        List<TeamInfo> teamInfos = teamInfoPage.getContent();
        for (TeamInfo teamInfo : teamInfos) {
            // main 값이 null이거나 빈 문자열인 경우 "N"으로 설정
            if (teamInfo.getMain() == null || teamInfo.getMain().trim().isEmpty()) {
                teamInfo.setMain("N");
            }
        }
        
        // 페이징 관련 조건문 처리
        int totalPages = teamInfoPage.getTotalPages();
        boolean hasNext = teamInfoPage.hasNext();
        boolean hasPrevious = teamInfoPage.hasPrevious();
        
        // 페이징 시작/끝 페이지 계산
        int startPage = (page / 5) * 5;
        int endPage = Math.min(startPage + 4, totalPages - 1);
        
        // 페이징 버튼 disabled 상태 처리
        String firstPageDisabled = (page == 0) ? "disabled" : "";
        String prevPageDisabled = (page == 0) ? "disabled" : "";
        String nextPageDisabled = (page >= totalPages - 1) ? "disabled" : "";
        String lastPageDisabled = (page >= totalPages - 1) ? "disabled" : "";
        
        // main 표시 텍스트 처리
        for (TeamInfo teamInfo : teamInfos) {
            if ("Y".equals(teamInfo.getMain())) {
                teamInfo.setMainDisplay("<span class=\"badge bg-success\"><i class=\"fas fa-check-circle me-1\"></i>노출</span>");
            } else {
                teamInfo.setMainDisplay("<span class=\"badge bg-secondary\"><i class=\"fas fa-times-circle me-1\"></i>비노출</span>");
            }
        }
        
        model.addAttribute("teamInfos", teamInfos);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalItems", teamInfoPage.getTotalElements());
        model.addAttribute("hasNext", hasNext);
        model.addAttribute("hasPrevious", hasPrevious);
        model.addAttribute("search", search);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("firstPageDisabled", firstPageDisabled);
        model.addAttribute("prevPageDisabled", prevPageDisabled);
        model.addAttribute("nextPageDisabled", nextPageDisabled);
        model.addAttribute("lastPageDisabled", lastPageDisabled);
        
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
                          @RequestParam(value = "main", defaultValue = "N") String main,
                          @RequestParam(value = "content", required = false) String content,
                          @RequestParam(value = "logoFile", required = false) MultipartFile logoFile,
                          @RequestParam(value = "seatFile", required = false) MultipartFile seatFile,
                          @RequestParam(value = "seatImg1File", required = false) MultipartFile seatImg1File,
                          RedirectAttributes redirectAttributes) {
        try {
            TeamInfo teamInfo = new TeamInfo();
            teamInfo.setTeamName(teamName);
            teamInfo.setStadium(stadium);
            teamInfo.setMain(main);
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
            
            // 좌석 이미지 기타 처리
            if (seatImg1File != null && !seatImg1File.isEmpty()) {
                String seatImg1FileName = saveFile(seatImg1File, "seatImg1");
                teamInfo.setSeatImg1(seatImg1FileName);
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
            TeamInfo teamInfo = teamInfoOpt.get();
            
            // main 값이 null이거나 빈 문자열인 경우 "N"으로 설정
            if (teamInfo.getMain() == null || teamInfo.getMain().trim().isEmpty()) {
                teamInfo.setMain("N");
            }
            
            // radio button checked 상태 처리
            if ("Y".equals(teamInfo.getMain())) {
                teamInfo.setMainYChecked("checked");
                teamInfo.setMainNChecked("");
            } else {
                teamInfo.setMainNChecked("checked");
                teamInfo.setMainYChecked("");
            }
            
            model.addAttribute("teamInfo", teamInfo);
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
                      @RequestParam(value = "main", defaultValue = "N") String main,
                      @RequestParam(value = "content", required = false) String content,
                      @RequestParam(value = "logoFile", required = false) MultipartFile logoFile,
                      @RequestParam(value = "seatFile", required = false) MultipartFile seatFile,
                      @RequestParam(value = "seatImg1File", required = false) MultipartFile seatImg1File,
                      RedirectAttributes redirectAttributes) {
        try {
            // 기존 팀정보 조회
            Optional<TeamInfo> existingTeamInfo = teamInfoService.getTeamInfoById(uid);
            if (existingTeamInfo.isPresent()) {
                TeamInfo teamInfo = existingTeamInfo.get();
                teamInfo.setTeamName(teamName);
                teamInfo.setStadium(stadium);
                teamInfo.setMain(main);
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
                
                // 좌석 이미지 기타 처리
                if (seatImg1File != null && !seatImg1File.isEmpty()) {
                    String seatImg1FileName = saveFile(seatImg1File, "seatImg1");
                    teamInfo.setSeatImg1(seatImg1FileName);
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

    // 일괄 삭제 기능
    @PostMapping("/bulk-delete")
    @ResponseBody
    public Map<String, Object> bulkDelete(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            System.out.println("=== 팀정보 일괄 삭제 요청 시작 ===");
            
            @SuppressWarnings("unchecked")
            List<Object> rawUids = (List<Object>) request.get("uids");
            
            // String을 Integer로 변환
            List<Integer> uids = new ArrayList<>();
            for (Object rawUid : rawUids) {
                if (rawUid instanceof String) {
                    uids.add(Integer.parseInt((String) rawUid));
                } else if (rawUid instanceof Number) {
                    uids.add(((Number) rawUid).intValue());
                } else {
                    throw new IllegalArgumentException("Invalid UID type: " + rawUid.getClass().getName());
                }
            }
            
            if (uids == null || uids.isEmpty()) {
                System.out.println("삭제할 팀정보 ID가 없습니다.");
                response.put("success", false);
                response.put("message", "삭제할 팀정보를 선택해주세요.");
                return response;
            }
            
            System.out.println("삭제할 팀정보 ID 목록: " + uids);
            
            int deletedCount = 0;
            List<String> failedItems = new ArrayList<>();
            
            for (Integer uid : uids) {
                try {
                    Optional<TeamInfo> teamInfo = teamInfoService.getTeamInfoById(uid);
                    if (teamInfo.isPresent()) {
                        teamInfoService.deleteTeamInfo(uid);
                        deletedCount++;
                        System.out.println("팀정보 삭제 완료: uid=" + uid);
                    } else {
                        failedItems.add("ID " + uid + " (존재하지 않음)");
                        System.out.println("삭제할 팀정보를 찾을 수 없음: uid=" + uid);
                    }
                } catch (Exception e) {
                    failedItems.add("ID " + uid + " (삭제 실패)");
                    System.err.println("팀정보 삭제 중 오류 발생: uid=" + uid + ", 오류: " + e.getMessage());
                    e.printStackTrace();
                }
            }
            
            System.out.println("팀정보 일괄 삭제 완료: 성공 " + deletedCount + "개, 실패 " + failedItems.size() + "개");
            
            response.put("success", true);
            response.put("deletedCount", deletedCount);
            response.put("totalRequested", uids.size());
            response.put("failedItems", failedItems);
            
            if (!failedItems.isEmpty()) {
                response.put("message", String.format("%d개 삭제 완료, %d개 실패", deletedCount, failedItems.size()));
            } else {
                response.put("message", String.format("%d개의 팀정보가 성공적으로 삭제되었습니다.", deletedCount));
            }
            
        } catch (Exception e) {
            System.err.println("팀정보 일괄 삭제 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "일괄 삭제 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return response;
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