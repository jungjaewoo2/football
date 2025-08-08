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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import jakarta.servlet.http.HttpServletRequest;
import football.dto.SeatPriceItem;

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
                      @RequestParam(required = false) String gameCategory,
                      @RequestParam(required = false) String category2,
                      Model model) {
        try {
            logger.info("일정표 목록 페이지 요청 - page: {}, search: {}, gameCategory: {}, category2: {}", 
                       page, search, gameCategory, category2);
            
            int size = 10; // 한 페이지당 10개로 고정
            Page<ScheduleInfo> schedulePage;
            
            if (search != null && !search.trim().isEmpty()) {
                schedulePage = scheduleInfoService.searchByTeamName(search, page, size);
            } else if (gameCategory != null && !gameCategory.trim().isEmpty()) {
                schedulePage = scheduleInfoService.searchByGameCategory(gameCategory, page, size);
            } else if (category2 != null && !category2.trim().isEmpty()) {
                schedulePage = scheduleInfoService.searchByCategory(category2, page, size);
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
            model.addAttribute("gameCategory", gameCategory);
            model.addAttribute("category2", category2);
            
            // 개발 프로세스: ID 내림차순 정렬 확인 로그
            logger.info("=== 개발 프로세스: 일정표 목록 조회 완료 ===");
            logger.info("전체 데이터 수: {}", schedulePage.getTotalElements());
            logger.info("현재 페이지 데이터 수: {}", schedulePage.getContent().size());
            logger.info("전체 페이지 수: {}", schedulePage.getTotalPages());
            logger.info("현재 페이지: {}", page);
            logger.info("정렬 방식: ID 내림차순 (uid DESC)");
            
            // 개발 프로세스: 상위 5개 데이터의 ID 확인
            for (int i = 0; i < Math.min(schedulePage.getContent().size(), 5); i++) {
                ScheduleInfo schedule = schedulePage.getContent().get(i);
                logger.info("  {}위: ID={}, 카테고리={}, 경기={} vs {}", 
                    i + 1, schedule.getUid(), schedule.getGameCategory(), schedule.getHomeTeam(), schedule.getOtherTeam());
            }
            
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
                         @RequestParam("category") String category,
                         @RequestParam("homeStadium") String homeStadium,
                         @RequestParam("homeTeam") String homeTeam,
                         @RequestParam("otherTeam") String otherTeam,
                         @RequestParam("gameDate") String gameDate,
                         @RequestParam("gameTime") String gameTime,
                         @RequestParam(value = "fee", required = false) Integer fee,
                         @RequestParam(value = "seatPrice", required = false) String seatPrice,
                         @RequestParam(value = "seatEtc", required = false) String seatEtc,
                         Model model) {
        try {
            logger.info("일정표 등록 요청 시작");
            
            // ScheduleInfo 객체 생성
            ScheduleInfo scheduleInfo = new ScheduleInfo();
            scheduleInfo.setGameCategory(gameCategory);
            scheduleInfo.setCategory(category);
            scheduleInfo.setHomeStadium(homeStadium);
            scheduleInfo.setHomeTeam(homeTeam);
            scheduleInfo.setOtherTeam(otherTeam);
            scheduleInfo.setGameDate(gameDate);
            scheduleInfo.setGameTime(gameTime);
            scheduleInfo.setFee(fee);
            scheduleInfo.setSeatPrice(seatPrice);
            scheduleInfo.setSeatEtc(seatEtc);
            
            scheduleInfoService.save(scheduleInfo);
            logger.info("일정표 등록 완료");
            return "redirect:/admin/schedule_info/list";
        } catch (Exception e) {
            logger.error("일정표 등록 중 오류 발생", e);
            model.addAttribute("error", "일정표 등록 중 오류가 발생했습니다.");
            
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
                ScheduleInfo schedule = scheduleInfo.get();
                
                // seat_etc 데이터를 미리 처리하여 List<SeatPriceItem>로 변환
                List<SeatPriceItem> seatPriceItems = new ArrayList<>();
                if (schedule.getSeatEtc() != null && !schedule.getSeatEtc().trim().isEmpty()) {
                    String seatEtcData = schedule.getSeatEtc();
                    logger.info("원본 seat_etc 데이터: {}", seatEtcData);
                    
                    // 천 단위 콤마를 제거하고 파싱
                    String cleanedData = seatEtcData.replaceAll("(\\d+),(\\d{3})", "$1$2");
                    logger.info("콤마 제거 후 데이터: {}", cleanedData);
                    
                    String[] items = cleanedData.split(",");
                    for (String item : items) {
                        String[] pair = item.split(":");
                        if (pair.length == 2) {
                            String seatName = pair[0].trim();
                            String price = pair[1].trim();
                            logger.info("파싱된 좌석: {}, 가격: {}", seatName, price);
                            seatPriceItems.add(new SeatPriceItem(seatName, price));
                        }
                    }
                }
                
                model.addAttribute("scheduleInfo", schedule);
                model.addAttribute("teamList", teamInfoService.findAll());
                model.addAttribute("seatFeeList", seatFeeService.findAll());
                model.addAttribute("seatPriceItems", seatPriceItems);
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
                      @RequestParam("category") String category,
                      @RequestParam("homeStadium") String homeStadium,
                      @RequestParam("homeTeam") String homeTeam,
                      @RequestParam("otherTeam") String otherTeam,
                      @RequestParam("gameDate") String gameDate,
                      @RequestParam("gameTime") String gameTime,
                      @RequestParam(value = "fee", required = false) Integer fee,
                      @RequestParam(value = "seatPrice", required = false) String seatPrice,
                      @RequestParam(value = "seatEtc", required = false) String seatEtc,
                      HttpServletRequest request,
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
            scheduleInfo.setCategory(category);
            scheduleInfo.setHomeStadium(homeStadium);
            scheduleInfo.setHomeTeam(homeTeam);
            scheduleInfo.setOtherTeam(otherTeam);
            scheduleInfo.setGameDate(gameDate);
            scheduleInfo.setGameTime(gameTime);
            scheduleInfo.setFee(fee);
            scheduleInfo.setSeatPrice(seatPrice);
            scheduleInfo.setSeatEtc(seatEtc);
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

    @PostMapping("/copy/{uid}")
    @ResponseBody
    public Map<String, Object> copySchedule(@PathVariable Integer uid) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            logger.info("일정표 복사 요청: uid={}", uid);
            
            // 기존 일정 정보 조회
            Optional<ScheduleInfo> existingSchedule = scheduleInfoService.findById(uid);
            if (!existingSchedule.isPresent()) {
                logger.warn("복사할 일정표 정보를 찾을 수 없음: uid={}", uid);
                response.put("success", false);
                response.put("message", "복사할 일정표를 찾을 수 없습니다.");
                return response;
            }
            
            ScheduleInfo originalSchedule = existingSchedule.get();
            
            // 새로운 일정 객체 생성 (uid는 자동 생성되므로 null로 설정)
            ScheduleInfo newSchedule = new ScheduleInfo();
            newSchedule.setGameCategory(originalSchedule.getGameCategory());
            newSchedule.setCategory(originalSchedule.getCategory());
            newSchedule.setHomeStadium(originalSchedule.getHomeStadium());
            newSchedule.setHomeTeam(originalSchedule.getHomeTeam());
            newSchedule.setOtherTeam(originalSchedule.getOtherTeam());
            newSchedule.setGameDate(originalSchedule.getGameDate());
            newSchedule.setGameTime(originalSchedule.getGameTime());
            newSchedule.setFee(originalSchedule.getFee());
            newSchedule.setSeatPrice(originalSchedule.getSeatPrice());
            newSchedule.setSeatEtc(originalSchedule.getSeatEtc());
            newSchedule.setImg(originalSchedule.getImg());
            
            // 새로운 일정 저장
            ScheduleInfo savedSchedule = scheduleInfoService.save(newSchedule);
            
            logger.info("일정표 복사 완료: 원본 uid={}, 새 uid={}", uid, savedSchedule.getUid());
            
            response.put("success", true);
            response.put("message", "일정표가 성공적으로 복사되었습니다.");
            response.put("newUid", savedSchedule.getUid());
            response.put("scheduleName", savedSchedule.getHomeTeam() + " vs " + savedSchedule.getOtherTeam());
            
        } catch (Exception e) {
            logger.error("일정표 복사 중 오류 발생: uid={}", uid, e);
            response.put("success", false);
            response.put("message", "일정표 복사 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return response;
    }

    // 일괄 삭제 기능
    @PostMapping("/bulk-delete")
    @ResponseBody
    public Map<String, Object> bulkDelete(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            logger.info("일괄 삭제 요청 시작");
            
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
                logger.warn("삭제할 일정 ID가 없습니다.");
                response.put("success", false);
                response.put("message", "삭제할 일정을 선택해주세요.");
                return response;
            }
            
            logger.info("삭제할 일정 ID 목록: {}", uids);
            
            int deletedCount = 0;
            List<String> failedItems = new ArrayList<>();
            
            for (Integer uid : uids) {
                try {
                    Optional<ScheduleInfo> schedule = scheduleInfoService.findById(uid);
                    if (schedule.isPresent()) {
                        scheduleInfoService.deleteById(uid);
                        deletedCount++;
                        logger.info("일정 삭제 완료: uid={}", uid);
                    } else {
                        failedItems.add("ID " + uid + " (존재하지 않음)");
                        logger.warn("삭제할 일정을 찾을 수 없음: uid={}", uid);
                    }
                } catch (Exception e) {
                    failedItems.add("ID " + uid + " (삭제 실패)");
                    logger.error("일정 삭제 중 오류 발생: uid={}", uid, e);
                }
            }
            
            logger.info("일괄 삭제 완료: 성공 {}개, 실패 {}개", deletedCount, failedItems.size());
            
            response.put("success", true);
            response.put("deletedCount", deletedCount);
            response.put("totalRequested", uids.size());
            response.put("failedItems", failedItems);
            
            if (!failedItems.isEmpty()) {
                response.put("message", String.format("%d개 삭제 완료, %d개 실패", deletedCount, failedItems.size()));
            } else {
                response.put("message", String.format("%d개의 일정이 성공적으로 삭제되었습니다.", deletedCount));
            }
            
        } catch (Exception e) {
            logger.error("일괄 삭제 중 오류 발생", e);
            response.put("success", false);
            response.put("message", "일괄 삭제 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return response;
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
} 