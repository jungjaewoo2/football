package football.repository;

import football.entity.RegisterSchedule;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
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
    
    // 예약상태로 검색 (페이징)
    Page<RegisterSchedule> findByReservationStatusContainingOrderByCreatedAtDesc(String reservationStatus, Pageable pageable);
    
    // 승인상태로 검색 (페이징)
    Page<RegisterSchedule> findByApprovalStatusContainingOrderByCreatedAtDesc(String approvalStatus, Pageable pageable);
    
    // 경기날짜로 검색 (페이징)
    Page<RegisterSchedule> findByGameDateContainingOrderByCreatedAtDesc(String gameDate, Pageable pageable);
    
    // 전체 검색 (페이징) - 예약자명, 홈팀, 원정팀
    Page<RegisterSchedule> findByCustomerNameContainingOrHomeTeamContainingOrAwayTeamContainingOrderByCreatedAtDesc(String customerName, String homeTeam, String awayTeam, Pageable pageable);
    
    // 예약완료 상태인 예약만 조회 (페이징)
    Page<RegisterSchedule> findByReservationStatusOrderByCreatedAtDesc(String reservationStatus, Pageable pageable);
    
    // 예약자명으로 검색 + 예약완료 상태 필터링 (페이징)
    Page<RegisterSchedule> findByCustomerNameContainingAndReservationStatusOrderByCreatedAtDesc(String customerName, String reservationStatus, Pageable pageable);
    
    // 홈팀으로 검색 + 예약완료 상태 필터링 (페이징)
    Page<RegisterSchedule> findByHomeTeamContainingAndReservationStatusOrderByCreatedAtDesc(String homeTeam, String reservationStatus, Pageable pageable);
    
    // 원정팀으로 검색 + 예약완료 상태 필터링 (페이징)
    Page<RegisterSchedule> findByAwayTeamContainingAndReservationStatusOrderByCreatedAtDesc(String awayTeam, String reservationStatus, Pageable pageable);
    
    // 전체 검색 + 예약완료 상태 필터링 (페이징)
    Page<RegisterSchedule> findByCustomerNameContainingOrHomeTeamContainingOrAwayTeamContainingAndReservationStatusOrderByCreatedAtDesc(String customerName, String homeTeam, String awayTeam, String reservationStatus, Pageable pageable);
    
    // UID로 예약 조회
    List<RegisterSchedule> findByUid(String uid);
    
    // 이메일로 예약 조회
    List<RegisterSchedule> findByCustomerEmail(String customerEmail);
    
    // 예약자 이름으로 예약 조회
    List<RegisterSchedule> findByCustomerName(String customerName);
    
    // 예약자 전화번호로 예약 조회
    List<RegisterSchedule> findByCustomerPhone(String customerPhone);
    
    // 특정 년/월에 해당하는 경기 수 조회
    long countByGameDateLike(String yearMonth);
    
    // 특정 년/월에 해당하는 경기 수 조회 (더 정확한 쿼리)
    long countByGameDateStartingWith(String yearMonth);

    @Query("SELECT COUNT(*) FROM RegisterSchedule rs WHERE rs.gameDate LIKE :yearMonth")
    long countByGameDateLikeWithQuery(@Param("yearMonth") String yearMonth);
    
    @Query("SELECT COUNT(*) FROM RegisterSchedule rs WHERE rs.gameDate LIKE :yearMonth AND rs.reservationStatus = :status")
    long countByGameDateLikeWithQueryAndStatus(@Param("yearMonth") String yearMonth, @Param("status") String status);
    
    // 경기날짜로 검색 + 예약완료 상태 필터링 (페이징)
    Page<RegisterSchedule> findByGameDateContainingAndReservationStatusOrderByCreatedAtDesc(String gameDate, String reservationStatus, Pageable pageable);
    
    // 특정 날짜 범위의 예약 건수 조회
    long countByCreatedAtBetween(java.time.LocalDateTime startDateTime, java.time.LocalDateTime endDateTime);
} 