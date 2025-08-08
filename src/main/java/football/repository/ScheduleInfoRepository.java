package football.repository;

import football.entity.ScheduleInfo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ScheduleInfoRepository extends JpaRepository<ScheduleInfo, Integer> {
    
    // 페이징을 위한 메서드들 (ID 내림차순)
    Page<ScheduleInfo> findAllByOrderByUidDesc(Pageable pageable);
    
    // 팀명으로 검색 (홈팀 또는 원정팀, 경기날짜 내림차순)
    Page<ScheduleInfo> findByHomeTeamContainingOrOtherTeamContainingOrderByGameDateDescGameTimeDesc(String homeTeam, String otherTeam, Pageable pageable);
    
    // 카테고리로 검색 (ID 내림차순)
    Page<ScheduleInfo> findByGameCategoryOrderByUidDesc(String gameCategory, Pageable pageable);
    
    // category 칼럼으로 검색 (ID 내림차순)
    Page<ScheduleInfo> findByCategoryOrderByUidDesc(String category, Pageable pageable);
    
    // 월별 일정 조회 (날짜 오름차순)
    List<ScheduleInfo> findByGameDateStartingWithOrderByGameDateAsc(String yearMonth);
    
    // 월별 일정 조회 (페이징, 날짜 오름차순)
    Page<ScheduleInfo> findByGameDateStartingWithOrderByGameDateAsc(String yearMonth, Pageable pageable);
    
    // 특정 팀의 홈팀 일정 조회 (날짜 오름차순)
    List<ScheduleInfo> findByHomeTeamOrderByGameDateAsc(String homeTeam);
    
    // 특정 팀의 홈팀 일정 조회 (페이징, 날짜 오름차순)
    Page<ScheduleInfo> findByHomeTeamOrderByGameDateAsc(String homeTeam, Pageable pageable);
    
    // 연월과 category로 검색 (페이징, ID 내림차순)
    Page<ScheduleInfo> findByGameDateStartingWithAndCategoryOrderByUidDesc(String yearMonth, String category, Pageable pageable);
    
    // 연월과 category로 검색 (페이징, 경기날짜 내림차순)
    Page<ScheduleInfo> findByGameDateStartingWithAndCategoryOrderByGameDateDescGameTimeDesc(String yearMonth, String category, Pageable pageable);
    
    // category만으로 검색 (페이징, 경기날짜 내림차순)
    Page<ScheduleInfo> findByCategoryOrderByGameDateDescGameTimeDesc(String category, Pageable pageable);
    
    // 전체 일정 조회 (페이징, 경기날짜 내림차순)
    Page<ScheduleInfo> findAllByOrderByGameDateDescGameTimeDesc(Pageable pageable);
    
    // 특정 팀의 홈팀 일정 조회 (페이징, 경기날짜 내림차순)
    Page<ScheduleInfo> findByHomeTeamOrderByGameDateDescGameTimeDesc(String homeTeam, Pageable pageable);
    
    // 월별 일정 조회 (페이징, 경기날짜 내림차순)
    Page<ScheduleInfo> findByGameDateStartingWithOrderByGameDateDescGameTimeDesc(String yearMonth, Pageable pageable);
} 