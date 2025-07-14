package football.repository;

import football.entity.RegisterSchedule;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RegisterScheduleRepository extends JpaRepository<RegisterSchedule, Long> {
    
    // 모든 예약 조회 (생성일 내림차순)
    Page<RegisterSchedule> findAllByOrderByCreatedAtDesc(Pageable pageable);
    
    // 예약자명으로 검색 (페이징)
    Page<RegisterSchedule> findByCustomerNameContainingOrderByCreatedAtDesc(String customerName, Pageable pageable);
    
    // 홈팀으로 검색 (페이징)
    Page<RegisterSchedule> findByHomeTeamContainingOrderByCreatedAtDesc(String homeTeam, Pageable pageable);
    
    // 원정팀으로 검색 (페이징)
    Page<RegisterSchedule> findByAwayTeamContainingOrderByCreatedAtDesc(String awayTeam, Pageable pageable);
    
    // UID로 예약 조회
    List<RegisterSchedule> findByUid(String uid);
    
    // 이메일로 예약 조회
    List<RegisterSchedule> findByCustomerEmail(String customerEmail);
    
    // 예약자 이름으로 예약 조회
    List<RegisterSchedule> findByCustomerName(String customerName);
    
    // 예약자 전화번호로 예약 조회
    List<RegisterSchedule> findByCustomerPhone(String customerPhone);
} 