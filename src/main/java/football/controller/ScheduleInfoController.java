package football.controller;

import football.entity.ScheduleInfo;
import football.entity.TeamInfo;
import football.entity.SeatFee;
import football.service.ScheduleInfoService;
import football.service.TeamInfoService;
import football.service.SeatFeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.Map;
import java.util.HashMap;
import org.springframework.http.ResponseEntity;

@Controller
@RequestMapping("/admin/schedule_info")
public class ScheduleInfoController {
    private static final Logger logger = LoggerFactory.getLogger(ScheduleInfoController.class);
    
    @Autowired
    private ScheduleInfoService scheduleInfoService;
    @Autowired
    private TeamInfoService teamInfoService;
    @Autowired
    private SeatFeeService seatFeeService;

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "0") int page,
                      @RequestParam(required = false) String search,
                      @RequestParam(required = false) String category,
                      Model model) {
        try {
            logger.info("일정표 목록 페이지 요청 - page: {}, search: {}, category: {}", page, search, category);
            
            int size = 10; // 한 페이지당 10개로 고정
            Page<ScheduleInfo> schedulePage;
            
            if (search != null && !search.trim().isEmpty()) {
                schedulePage = scheduleInfoService.searchByTeamName(search, page, size);
            } else if (category != null && !category.trim().isEmpty()) {
                schedulePage = scheduleInfoService.searchByCategory(category, page, size);
            } else {
                schedulePage = scheduleInfoService.getAllSchedules(page, size);
            }
            
            model.addAttribute("scheduleList", schedulePage.getContent());
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", schedulePage.getTotalPages());
            model.addAttribute("totalItems", schedulePage.getTotalElements());
            model.addAttribute("hasNext", schedulePage.hasNext());
            model.addAttribute("hasPrevious", schedulePage.hasPrevious());
            model.addAttribute("search", search);
            model.addAttribute("category", category);
            
            logger.info("일정표 목록 조회 완료: {}개, 총 {}페이지", schedulePage.getContent().size(), schedulePage.getTotalPages());
            return "admin/schedule_info/list";
        } catch (Exception e) {
            logger.error("일정표 목록 조회 중 오류 발생", e);
            model.addAttribute("error", "일정표 목록을 불러오는 중 오류가 발생했습니다.");
            return "admin/schedule_info/list";
        }
    }

    @GetMapping("/register")
    public String registerForm(Model model) {
        try {
            logger.info("일정표 등록 페이지 요청");
            
            // 응답 헤더 설정으로 캐시 방지
            List<TeamInfo> teamList = teamInfoService.findAll();
            List<SeatFee> seatFeeList = seatFeeService.findAll();
            
            logger.info("팀 정보 조회 완료: {}개", teamList.size());
            logger.info("좌석 요금 정보 조회 완료: {}개", seatFeeList.size());
            
            model.addAttribute("scheduleInfo", new ScheduleInfo());
            model.addAttribute("teamList", teamList);
            model.addAttribute("seatFeeList", seatFeeList);
            
            logger.info("일정표 등록 페이지 데이터 설정 완료");
            return "admin/schedule_info/register";
        } catch (Exception e) {
            logger.error("일정표 등록 페이지 로드 중 오류 발생", e);
            model.addAttribute("error", "데이터를 불러오는 중 오류가 발생했습니다: " + e.getMessage());
            return "admin/schedule_info/register";
        }
    }

    @PostMapping("/register")
    public String register(@RequestParam("gameCategory") String gameCategory,
                         @RequestParam("homeStadium") String homeStadium,
                         @RequestParam("homeCategory") String homeCategory,
                         @RequestParam("homeTeam") String homeTeam,
                         @RequestParam("otherCategory") String otherCategory,
                         @RequestParam("otherTeam") String otherTeam,
                         @RequestParam("gameDate") String gameDate,
                         @RequestParam("gameTime") String gameTime,
                         @RequestParam(value = "fee", required = false) Integer fee,
                         @RequestParam(value = "orange", required = false) Integer orange,
                         @RequestParam(value = "yellow", required = false) Integer yellow,
                         @RequestParam(value = "green", required = false) Integer green,
                         @RequestParam(value = "blue", required = false) Integer blue,
                         @RequestParam(value = "purple", required = false) Integer purple,
                         @RequestParam(value = "red", required = false) Integer red,
                         @RequestParam(value = "black", required = false) Integer black,
                         @RequestParam(value = "seatImageFile", required = false) MultipartFile seatImageFile,
                         Model model) {
        try {
            logger.info("일정표 등록 요청 시작");
            logger.info("파일 업로드 정보 - seatImageFile: {}, isEmpty: {}, size: {}", 
                       seatImageFile != null ? seatImageFile.getOriginalFilename() : "null", 
                       seatImageFile != null ? seatImageFile.isEmpty() : "N/A",
                       seatImageFile != null ? seatImageFile.getSize() : "N/A");
            
            String filename = null;
            if (seatImageFile != null && !seatImageFile.isEmpty()) {
                logger.info("파일 업로드 처리 시작 - 원본파일명: {}, 크기: {} bytes", 
                           seatImageFile.getOriginalFilename(), seatImageFile.getSize());
                
                String uploadDir = "src/main/webapp/uploads/schedule_info";
                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    boolean created = dir.mkdirs();
                    logger.info("업로드 디렉토리 생성: {} - 성공: {}", uploadDir, created);
                }
                
                String originalFilename = seatImageFile.getOriginalFilename();
                String extension = "";
                if (originalFilename != null && originalFilename.contains(".")) {
                    extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                }
                filename = UUID.randomUUID().toString() + extension;
                Path filePath = Paths.get(uploadDir, filename);
                
                logger.info("파일 저장 경로: {}", filePath.toString());
                Files.copy(seatImageFile.getInputStream(), filePath);
                logger.info("파일 업로드 완료 - 저장된 파일명: {}", filename);
            } else {
                logger.info("파일 업로드 없음");
            }
            
            // ScheduleInfo 객체 생성
            ScheduleInfo scheduleInfo = new ScheduleInfo();
            scheduleInfo.setGameCategory(gameCategory);
            scheduleInfo.setHomeStadium(homeStadium);
            scheduleInfo.setHomeCategory(homeCategory);
            scheduleInfo.setHomeTeam(homeTeam);
            scheduleInfo.setOtherCategory(otherCategory);
            scheduleInfo.setOtherTeam(otherTeam);
            scheduleInfo.setGameDate(gameDate);
            scheduleInfo.setGameTime(gameTime);
            scheduleInfo.setFee(fee);
            scheduleInfo.setOrange(orange);
            scheduleInfo.setYellow(yellow);
            scheduleInfo.setGreen(green);
            scheduleInfo.setBlue(blue);
            scheduleInfo.setPurple(purple);
            scheduleInfo.setRed(red);
            scheduleInfo.setBlack(black);
            scheduleInfo.setImg(filename);
            
            scheduleInfoService.save(scheduleInfo);
            logger.info("일정표 등록 완료");
            return "redirect:/admin/schedule_info/list";
        } catch (IOException e) {
            logger.error("일정표 등록 중 오류 발생", e);
            model.addAttribute("error", "파일 업로드 중 오류가 발생했습니다.");
            
            // 등록 실패 시 다시 등록 페이지로 이동하면서 데이터 유지
            try {
                List<TeamInfo> teamList = teamInfoService.findAll();
                List<SeatFee> seatFeeList = seatFeeService.findAll();
                model.addAttribute("teamList", teamList);
                model.addAttribute("seatFeeList", seatFeeList);
            } catch (Exception ex) {
                logger.error("등록 실패 후 데이터 재로드 중 오류", ex);
            }
            
            return "admin/schedule_info/register";
        }
    }

    @GetMapping("/edit/{uid}")
    public String editForm(@PathVariable Integer uid, Model model) {
        try {
            logger.info("일정표 수정 페이지 요청: uid={}", uid);
            Optional<ScheduleInfo> scheduleInfo = scheduleInfoService.findById(uid);
            if (scheduleInfo.isPresent()) {
                model.addAttribute("scheduleInfo", scheduleInfo.get());
                model.addAttribute("teamList", teamInfoService.findAll());
                model.addAttribute("seatFeeList", seatFeeService.findAll());
                logger.info("일정표 수정 페이지 데이터 설정 완료");
                return "admin/schedule_info/edit";
            } else {
                logger.warn("일정표 정보를 찾을 수 없음: uid={}", uid);
                return "redirect:/admin/schedule_info/list";
            }
        } catch (Exception e) {
            logger.error("일정표 수정 페이지 로드 중 오류 발생", e);
            model.addAttribute("error", "일정표 정보를 불러오는 중 오류가 발생했습니다.");
            return "redirect:/admin/schedule_info/list";
        }
    }

    @PostMapping("/edit/{uid}")
    public String edit(@PathVariable Integer uid,
                      @RequestParam("gameCategory") String gameCategory,
                      @RequestParam("homeStadium") String homeStadium,
                      @RequestParam("homeCategory") String homeCategory,
                      @RequestParam("homeTeam") String homeTeam,
                      @RequestParam("otherCategory") String otherCategory,
                      @RequestParam("otherTeam") String otherTeam,
                      @RequestParam("gameDate") String gameDate,
                      @RequestParam("gameTime") String gameTime,
                      @RequestParam(value = "fee", required = false) Integer fee,
                      @RequestParam(value = "orange", required = false) Integer orange,
                      @RequestParam(value = "yellow", required = false) Integer yellow,
                      @RequestParam(value = "green", required = false) Integer green,
                      @RequestParam(value = "blue", required = false) Integer blue,
                      @RequestParam(value = "purple", required = false) Integer purple,
                      @RequestParam(value = "red", required = false) Integer red,
                      @RequestParam(value = "black", required = false) Integer black,
                      @RequestParam(value = "seatImageFile", required = false) MultipartFile seatImageFile,
                      Model model) {
        try {
            logger.info("일정표 수정 요청 시작: uid={}", uid);
            // 기존 일정 정보 조회
            Optional<ScheduleInfo> existingSchedule = scheduleInfoService.findById(uid);
            if (!existingSchedule.isPresent()) {
                logger.warn("수정할 일정표 정보를 찾을 수 없음: uid={}", uid);
                return "redirect:/admin/schedule_info/list";
            }
            ScheduleInfo scheduleInfo = existingSchedule.get();
            logger.info("기존 일정표 정보 조회 완료: uid={}, 기존 이미지: {}", uid, scheduleInfo.getImg());
            // 일정 정보 업데이트
            scheduleInfo.setGameCategory(gameCategory);
            scheduleInfo.setHomeStadium(homeStadium);
            scheduleInfo.setHomeCategory(homeCategory);
            scheduleInfo.setHomeTeam(homeTeam);
            scheduleInfo.setOtherCategory(otherCategory);
            scheduleInfo.setOtherTeam(otherTeam);
            scheduleInfo.setGameDate(gameDate);
            scheduleInfo.setGameTime(gameTime);
            scheduleInfo.setFee(fee);
            scheduleInfo.setOrange(orange);
            scheduleInfo.setYellow(yellow);
            scheduleInfo.setGreen(green);
            scheduleInfo.setBlue(blue);
            scheduleInfo.setPurple(purple);
            scheduleInfo.setRed(red);
            scheduleInfo.setBlack(black);
            // 파일 업로드 처리
            if (seatImageFile != null && !seatImageFile.isEmpty()) {
                String uploadDir = "src/main/webapp/uploads/schedule_info";
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();
                String originalFilename = seatImageFile.getOriginalFilename();
                String extension = "";
                if (originalFilename != null && originalFilename.contains(".")) {
                    extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                }
                String filename = UUID.randomUUID().toString() + extension;
                Path filePath = Paths.get(uploadDir, filename);
                seatImageFile.transferTo(filePath);
                scheduleInfo.setImg(filename);
            }
            scheduleInfoService.save(scheduleInfo);
            logger.info("일정표 수정 완료");
            return "redirect:/admin/schedule_info/list";
        } catch (Exception e) {
            logger.error("일정표 수정 중 오류 발생", e);
            model.addAttribute("error", "일정표 수정 중 오류가 발생했습니다.");
            try {
                Optional<ScheduleInfo> existingSchedule = scheduleInfoService.findById(uid);
                if (existingSchedule.isPresent()) {
                    model.addAttribute("scheduleInfo", existingSchedule.get());
                }
                model.addAttribute("teamList", teamInfoService.findAll());
                model.addAttribute("seatFeeList", seatFeeService.findAll());
            } catch (Exception ex) {
                logger.error("수정 실패 후 데이터 재로드 중 오류", ex);
            }
            return "admin/schedule_info/edit";
        }
    }

    @GetMapping("/delete/{uid}")
    public String deleteForm(@PathVariable Integer uid, Model model) {
        try {
            logger.info("일정표 삭제 확인 페이지 요청: uid={}", uid);
            Optional<ScheduleInfo> scheduleInfo = scheduleInfoService.findById(uid);
            if (scheduleInfo.isPresent()) {
                model.addAttribute("scheduleInfo", scheduleInfo.get());
                return "admin/schedule_info/delete";
            } else {
                logger.warn("삭제할 일정표 정보를 찾을 수 없음: uid={}", uid);
                return "redirect:/admin/schedule_info/list";
            }
        } catch (Exception e) {
            logger.error("일정표 삭제 확인 페이지 로드 중 오류 발생", e);
            return "redirect:/admin/schedule_info/list";
        }
    }

    @PostMapping("/delete/{uid}")
    public String delete(@PathVariable Integer uid) {
        try {
            logger.info("일정표 삭제 요청: uid={}", uid);
            scheduleInfoService.deleteById(uid);
            logger.info("일정표 삭제 완료");
            return "redirect:/admin/schedule_info/list";
        } catch (Exception e) {
            logger.error("일정표 삭제 중 오류 발생", e);
            return "redirect:/admin/schedule_info/list";
        }
    }




    
    // 팀 정보를 JSON으로 반환하는 API
    @GetMapping("/api/teams")
    @ResponseBody
    public List<TeamInfo> getTeams() {
        try {
            logger.info("팀 정보 API 요청");
            List<TeamInfo> teams = teamInfoService.findAll();
            logger.info("팀 정보 API 응답: {}개", teams.size());
            return teams;
        } catch (Exception e) {
            logger.error("팀 정보 API 오류", e);
            throw e;
        }
    }

    // 카테고리별 팀 정보를 JSON으로 반환하는 API
    @GetMapping("/api/teams/{category}")
    @ResponseBody
    public List<TeamInfo> getTeamsByCategory(@PathVariable String category) {
        try {
            logger.info("카테고리별 팀 정보 API 요청: category={}", category);
            List<TeamInfo> teams = teamInfoService.findByCategoryName(category);
            logger.info("카테고리별 팀 정보 API 응답: {}개", teams.size());
            return teams;
        } catch (Exception e) {
            logger.error("카테고리별 팀 정보 API 오류", e);
            throw e;
        }
    }

    // 파일 업로드를 별도로 처리하는 API
    @PostMapping("/upload/image")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> uploadImage(@RequestParam("file") MultipartFile file) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            logger.info("파일 업로드 API 요청 - 원본파일명: {}, 크기: {} bytes", 
                       file.getOriginalFilename(), file.getSize());
            
            String uploadDir = "src/main/webapp/uploads/schedule_info";
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                boolean created = dir.mkdirs();
                logger.info("업로드 디렉토리 생성: {} - 성공: {}", uploadDir, created);
            }
            
            String originalFilename = file.getOriginalFilename();
            String extension = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            }
            String filename = UUID.randomUUID().toString() + extension;
            Path filePath = Paths.get(uploadDir, filename);
            
            logger.info("파일 저장 경로: {}", filePath.toString());
            Files.copy(file.getInputStream(), filePath);
            
            response.put("fileName", filename);
            response.put("success", true);
            logger.info("파일 업로드 완료 - 저장된 파일명: {}", filename);
            
            return ResponseEntity.ok(response);
            
        } catch (IOException e) {
            logger.error("파일 업로드 중 오류 발생", e);
            response.put("error", "파일 업로드 중 오류가 발생했습니다.");
            return ResponseEntity.internalServerError().body(response);
        }
    }
} 