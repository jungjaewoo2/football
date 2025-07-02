package football.controller;

import football.entity.ScheduleInfo;
import football.entity.TeamInfo;
import football.entity.SeatFee;
import football.service.ScheduleInfoService;
import football.service.TeamInfoService;
import football.service.SeatFeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Optional;

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
    public String list(Model model) {
        try {
            logger.info("일정표 목록 페이지 요청");
            List<ScheduleInfo> scheduleList = scheduleInfoService.findAll();
            model.addAttribute("scheduleList", scheduleList);
            logger.info("일정표 목록 조회 완료: {}개", scheduleList.size());
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
    public String register(@ModelAttribute ScheduleInfo scheduleInfo, Model model) {
        try {
            logger.info("일정표 등록 요청: {}", scheduleInfo);
            scheduleInfoService.save(scheduleInfo);
            logger.info("일정표 등록 완료");
            return "redirect:/admin/schedule_info/list";
        } catch (Exception e) {
            logger.error("일정표 등록 중 오류 발생", e);
            model.addAttribute("error", "일정표 등록 중 오류가 발생했습니다: " + e.getMessage());
            
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
    public String edit(@PathVariable Integer uid, @ModelAttribute ScheduleInfo scheduleInfo) {
        try {
            logger.info("일정표 수정 요청: uid={}", uid);
            scheduleInfo.setUid(uid);
            scheduleInfoService.save(scheduleInfo);
            logger.info("일정표 수정 완료");
            return "redirect:/admin/schedule_info/list";
        } catch (Exception e) {
            logger.error("일정표 수정 중 오류 발생", e);
            return "redirect:/admin/schedule_info/edit/" + uid;
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
} 