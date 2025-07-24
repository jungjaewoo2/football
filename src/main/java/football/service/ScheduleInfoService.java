package football.service;

import football.entity.ScheduleInfo;
import football.repository.ScheduleInfoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

@Service
public class ScheduleInfoService {
    @Autowired
    private ScheduleInfoRepository scheduleInfoRepository;

    public List<ScheduleInfo> findAll() {
        return scheduleInfoRepository.findAll();
    }

    public Optional<ScheduleInfo> findById(Integer uid) {
        return scheduleInfoRepository.findById(uid);
    }

    public ScheduleInfo save(ScheduleInfo scheduleInfo) {
        // 개발 프로세스: 등록/수정 시간 자동 설정
        if (scheduleInfo.getCreatedAt() == null) {
            scheduleInfo.setCreatedAt(LocalDateTime.now());
            System.out.println("개발 프로세스: 새로운 일정 등록 - createdAt 설정: " + scheduleInfo.getCreatedAt());
        }
        scheduleInfo.setUpdatedAt(LocalDateTime.now());
        System.out.println("개발 프로세스: 일정 정보 업데이트 - updatedAt 설정: " + scheduleInfo.getUpdatedAt());
        
        return scheduleInfoRepository.save(scheduleInfo);
    }

    public void deleteById(Integer uid) {
        scheduleInfoRepository.deleteById(uid);
    }
    
    // 페이징을 위한 메서드들
    public Page<ScheduleInfo> getAllSchedules(int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "uid"));
        return scheduleInfoRepository.findAllByOrderByUidDesc(pageable);
    }
    
    public Page<ScheduleInfo> searchByTeamName(String teamName, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "uid"));
        return scheduleInfoRepository.findByHomeTeamContainingOrOtherTeamContainingOrderByUidDesc(teamName, teamName, pageable);
    }
    
    public Page<ScheduleInfo> searchByCategory(String category, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "uid"));
        return scheduleInfoRepository.findByGameCategoryOrderByUidDesc(category, pageable);
    }
    
    // 현재 월 기준으로 일정 조회
    public List<ScheduleInfo> getSchedulesByCurrentMonth() {
        LocalDate now = LocalDate.now();
        String currentMonth = now.format(DateTimeFormatter.ofPattern("yyyy-MM"));
        return scheduleInfoRepository.findByGameDateStartingWithOrderByGameDateAsc(currentMonth);
    }
    
    // 현재 월 기준으로 일정 조회 (페이징)
    public Page<ScheduleInfo> getSchedulesByCurrentMonthWithPaging(int page, int size) {
        LocalDate now = LocalDate.now();
        String currentMonth = now.format(DateTimeFormatter.ofPattern("yyyy-MM"));
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.ASC, "gameDate"));
        return scheduleInfoRepository.findByGameDateStartingWithOrderByGameDateAsc(currentMonth, pageable);
    }
    
    // 특정 월 기준으로 일정 조회
    public List<ScheduleInfo> getSchedulesByMonth(String yearMonth) {
        return scheduleInfoRepository.findByGameDateStartingWithOrderByGameDateAsc(yearMonth);
    }
    
    // 특정 월 기준으로 일정 조회 (페이징)
    public Page<ScheduleInfo> getSchedulesByMonthWithPaging(String yearMonth, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.ASC, "gameDate"));
        return scheduleInfoRepository.findByGameDateStartingWithOrderByGameDateAsc(yearMonth, pageable);
    }
    
    // 특정 팀의 홈팀 일정 조회
    public List<ScheduleInfo> getSchedulesByHomeTeam(String homeTeam) {
        return scheduleInfoRepository.findByHomeTeamOrderByGameDateAsc(homeTeam);
    }
    
    // 특정 팀의 홈팀 일정 조회 (페이징)
    public Page<ScheduleInfo> getSchedulesByHomeTeamWithPaging(String homeTeam, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.ASC, "gameDate"));
        return scheduleInfoRepository.findByHomeTeamOrderByGameDateAsc(homeTeam, pageable);
    }
} 