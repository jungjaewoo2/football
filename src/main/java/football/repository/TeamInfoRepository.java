package football.repository;

import football.entity.TeamInfo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TeamInfoRepository extends JpaRepository<TeamInfo, Integer> {
    
    // 페이징을 위한 메서드
    Page<TeamInfo> findAllByOrderByUidDesc(Pageable pageable);
    
    // 팀명으로 검색
    Page<TeamInfo> findByTeamNameContainingOrderByUidDesc(String teamName, Pageable pageable);
    
    // 전체 개수 조회
    @Query("SELECT COUNT(t) FROM TeamInfo t")
    long countAllTeamInfos();
    
    // 팀명으로 조회 (중복 허용)
    List<TeamInfo> findByTeamName(String teamName);
} 