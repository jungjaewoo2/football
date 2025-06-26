package football.repository;

import football.entity.SeatFee;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface SeatFeeRepository extends JpaRepository<SeatFee, Integer> {
    
    // 페이징을 위한 메서드
    Page<SeatFee> findAllByOrderByUidDesc(Pageable pageable);
    
    // 좌석명으로 검색
    Page<SeatFee> findBySeatNameContainingOrderByUidDesc(String seatName, Pageable pageable);
    
    // 전체 개수 조회
    @Query("SELECT COUNT(s) FROM SeatFee s")
    long countAllSeatFees();
} 