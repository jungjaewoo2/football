package football.repository;

import football.entity.TeamInfo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface TeamInfoRepository extends JpaRepository<TeamInfo, Integer> {
    
    // 페이징을 위한 메서드
    Page<TeamInfo> findAllByOrderByUidDesc(Pageable pageable);
    
    // 팀명으로 검색
    Page<TeamInfo> findByTeamNameContainingOrderByUidDesc(String teamName, Pageable pageable);
    
    // 카테고리로 검색
    Page<TeamInfo> findByCategoryNameOrderByUidDesc(String categoryName, Pageable pageable);
    
    // 전체 개수 조회
    @Query("SELECT COUNT(t) FROM TeamInfo t")
    long countAllTeamInfos();
    
    // 카테고리별 팀 목록 조회 (페이징 없이)
    List<TeamInfo> findByCategoryName(String categoryName);
    
    // 팀명으로 조회
    Optional<TeamInfo> findByTeamName(String teamName);
} 