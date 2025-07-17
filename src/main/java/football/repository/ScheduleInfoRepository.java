package football.repository;

import football.entity.ScheduleInfo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ScheduleInfoRepository extends JpaRepository<ScheduleInfo, Integer> {
    
    // 페이징을 위한 메서드들
    Page<ScheduleInfo> findAllByOrderByCreatedAtDesc(Pageable pageable);
    
    // 팀명으로 검색 (홈팀 또는 원정팀)
    Page<ScheduleInfo> findByHomeTeamContainingOrOtherTeamContainingOrderByCreatedAtDesc(String homeTeam, String otherTeam, Pageable pageable);
    
    // 카테고리로 검색
    Page<ScheduleInfo> findByGameCategoryOrderByCreatedAtDesc(String gameCategory, Pageable pageable);
    
    // 월별 일정 조회 (날짜 오름차순)
    List<ScheduleInfo> findByGameDateStartingWithOrderByGameDateAsc(String yearMonth);
    
    // 특정 팀의 홈팀 일정 조회 (날짜 오름차순)
    List<ScheduleInfo> findByHomeTeamOrderByGameDateAsc(String homeTeam);
} 