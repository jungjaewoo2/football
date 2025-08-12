package football.repository;

import football.entity.ScheduleInfo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ScheduleInfoRepository extends JpaRepository<ScheduleInfo, Integer> {
    

    
    // 팀명으로 검색 (홈팀 또는 원정팀, 경기날짜 오름차순)
    Page<ScheduleInfo> findByHomeTeamContainingOrOtherTeamContainingOrderByGameDateAscGameTimeAsc(String homeTeam, String otherTeam, Pageable pageable);
    

    

    
    // 월별 일정 조회 (날짜 오름차순)
    List<ScheduleInfo> findByGameDateStartingWithOrderByGameDateAsc(String yearMonth);
    
    // 월별 일정 조회 (페이징, 날짜 오름차순)
    Page<ScheduleInfo> findByGameDateStartingWithOrderByGameDateAsc(String yearMonth, Pageable pageable);
    
    // 특정 팀의 홈팀 일정 조회 (날짜 오름차순)
    List<ScheduleInfo> findByHomeTeamOrderByGameDateAsc(String homeTeam);
    
    // 특정 팀의 홈팀 일정 조회 (페이징, 날짜 오름차순)
    Page<ScheduleInfo> findByHomeTeamOrderByGameDateAsc(String homeTeam, Pageable pageable);
    
    // 연월과 category로 검색 (페이징, 경기날짜 오름차순)
    Page<ScheduleInfo> findByGameDateStartingWithAndCategoryOrderByGameDateAscGameTimeAsc(String yearMonth, String category, Pageable pageable);
    
    // category만으로 검색 (페이징, 경기날짜 오름차순)
    Page<ScheduleInfo> findByCategoryOrderByGameDateAscGameTimeAsc(String category, Pageable pageable);
    
    // 전체 일정 조회 (페이징, 경기날짜 오름차순)
    Page<ScheduleInfo> findAllByOrderByGameDateAscGameTimeAsc(Pageable pageable);
    
    // 특정 팀의 홈팀 일정 조회 (페이징, 경기날짜 오름차순)
    Page<ScheduleInfo> findByHomeTeamOrderByGameDateAscGameTimeAsc(String homeTeam, Pageable pageable);
    
    // 월별 일정 조회 (페이징, 경기날짜 오름차순)
    Page<ScheduleInfo> findByGameDateStartingWithOrderByGameDateAscGameTimeAsc(String yearMonth, Pageable pageable);
} 