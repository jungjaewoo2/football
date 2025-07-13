package football.repository;

import football.entity.RegisterSchedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RegisterScheduleRepository extends JpaRepository<RegisterSchedule, Long> {
    
    // UID로 예약 조회
    List<RegisterSchedule> findByUid(String uid);
    
    // 이메일로 예약 조회
    List<RegisterSchedule> findByCustomerEmail(String customerEmail);
    
    // 예약자 이름으로 예약 조회
    List<RegisterSchedule> findByCustomerName(String customerName);
    
    // 예약자 전화번호로 예약 조회
    List<RegisterSchedule> findByCustomerPhone(String customerPhone);
} 