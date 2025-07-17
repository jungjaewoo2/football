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
        return scheduleInfoRepository.save(scheduleInfo);
    }

    public void deleteById(Integer uid) {
        scheduleInfoRepository.deleteById(uid);
    }
    
    // 페이징을 위한 메서드들
    public Page<ScheduleInfo> getAllSchedules(int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "createdAt"));
        return scheduleInfoRepository.findAllByOrderByCreatedAtDesc(pageable);
    }
    
    public Page<ScheduleInfo> searchByTeamName(String teamName, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "createdAt"));
        return scheduleInfoRepository.findByHomeTeamContainingOrOtherTeamContainingOrderByCreatedAtDesc(teamName, teamName, pageable);
    }
    
    public Page<ScheduleInfo> searchByCategory(String category, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "createdAt"));
        return scheduleInfoRepository.findByGameCategoryOrderByCreatedAtDesc(category, pageable);
    }
    
    // 현재 월 기준으로 일정 조회
    public List<ScheduleInfo> getSchedulesByCurrentMonth() {
        LocalDate now = LocalDate.now();
        String currentMonth = now.format(DateTimeFormatter.ofPattern("yyyy-MM"));
        return scheduleInfoRepository.findByGameDateStartingWithOrderByGameDateAsc(currentMonth);
    }
    
    // 특정 월 기준으로 일정 조회
    public List<ScheduleInfo> getSchedulesByMonth(String yearMonth) {
        return scheduleInfoRepository.findByGameDateStartingWithOrderByGameDateAsc(yearMonth);
    }
    
    // 특정 팀의 홈팀 일정 조회
    public List<ScheduleInfo> getSchedulesByHomeTeam(String homeTeam) {
        return scheduleInfoRepository.findByHomeTeamOrderByGameDateAsc(homeTeam);
    }
} 