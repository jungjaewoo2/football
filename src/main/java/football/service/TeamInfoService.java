package football.service;

import football.entity.TeamInfo;
import football.repository.TeamInfoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class TeamInfoService {
    
    @Autowired
    private TeamInfoRepository teamInfoRepository;
    
    // 전체 팀정보 목록 조회 (페이징)
    public Page<TeamInfo> getAllTeamInfos(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return teamInfoRepository.findAllByOrderByUidDesc(pageable);
    }
    
    // 팀명으로 검색 (페이징)
    public Page<TeamInfo> searchTeamInfosByName(String teamName, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return teamInfoRepository.findByTeamNameContainingOrderByUidDesc(teamName, pageable);
    }
    
    // 카테고리로 검색 (페이징)
    public Page<TeamInfo> searchTeamInfosByCategory(String categoryName, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return teamInfoRepository.findByCategoryNameOrderByUidDesc(categoryName, pageable);
    }
    
    // 특정 팀정보 조회
    public Optional<TeamInfo> getTeamInfoById(Integer uid) {
        return teamInfoRepository.findById(uid);
    }
    
    // 팀정보 등록
    public TeamInfo saveTeamInfo(TeamInfo teamInfo) {
        return teamInfoRepository.save(teamInfo);
    }
    
    // 팀정보 수정
    public TeamInfo updateTeamInfo(TeamInfo teamInfo) {
        if (teamInfoRepository.existsById(teamInfo.getUid())) {
            return teamInfoRepository.save(teamInfo);
        }
        throw new RuntimeException("팀정보를 찾을 수 없습니다. ID: " + teamInfo.getUid());
    }
    
    // 팀정보 삭제
    public void deleteTeamInfo(Integer uid) {
        if (teamInfoRepository.existsById(uid)) {
            teamInfoRepository.deleteById(uid);
        } else {
            throw new RuntimeException("팀정보를 찾을 수 없습니다. ID: " + uid);
        }
    }
    
    // 전체 개수 조회
    public long getTotalCount() {
        return teamInfoRepository.countAllTeamInfos();
    }
    
    // 카테고리 목록 조회
    public List<String> getCategoryList() {
        return List.of("EPL", "L.Liga", "B.Liga", "ETC", "웸블리");
    }
} 