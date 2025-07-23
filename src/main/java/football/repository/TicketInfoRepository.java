package football.repository;

import football.entity.TicketInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TicketInfoRepository extends JpaRepository<TicketInfo, Integer> {
    TicketInfo findFirstByOrderByUidAsc();
} 