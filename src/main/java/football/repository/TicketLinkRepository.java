package football.repository;

import football.entity.TicketLink;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TicketLinkRepository extends JpaRepository<TicketLink, Integer> {
    
    // 페이징을 위한 메서드들 (ID 내림차순)
    Page<TicketLink> findAllByOrderByUidDesc(Pageable pageable);
    
    // 티켓명으로 검색 (ID 내림차순)
    Page<TicketLink> findByTicketNameContainingOrderByUidDesc(String ticketName, Pageable pageable);
    
    // 링크로 검색
    TicketLink findByLink(String link);
} 