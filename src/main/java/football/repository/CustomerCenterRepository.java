package football.repository;

import football.entity.CustomerCenter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CustomerCenterRepository extends JpaRepository<CustomerCenter, Integer> {
    // 첫 번째 레코드를 가져오는 메서드
    CustomerCenter findFirstByOrderByUidAsc();
} 