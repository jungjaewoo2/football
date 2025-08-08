package football.service;

import football.entity.TicketLink;
import football.repository.TicketLinkRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class TicketLinkService {
    @Autowired
    private TicketLinkRepository ticketLinkRepository;

    public List<TicketLink> findAll() {
        return ticketLinkRepository.findAll();
    }

    public Optional<TicketLink> findById(Integer uid) {
        return ticketLinkRepository.findById(uid);
    }

    public TicketLink save(TicketLink ticketLink) {
        // 등록/수정 시간 자동 설정
        if (ticketLink.getCreatedAt() == null) {
            ticketLink.setCreatedAt(LocalDateTime.now());
        }
        ticketLink.setUpdatedAt(LocalDateTime.now());
        
        return ticketLinkRepository.save(ticketLink);
    }

    public void deleteById(Integer uid) {
        ticketLinkRepository.deleteById(uid);
    }
    
    // 페이징을 위한 메서드들
    public Page<TicketLink> getAllTicketLinks(int page, int size) {
        try {
            Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "uid"));
            return ticketLinkRepository.findAllByOrderByUidDesc(pageable);
        } catch (Exception e) {
            System.err.println("티켓바로가기 목록 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
    
    public Page<TicketLink> searchByTicketName(String ticketName, int page, int size) {
        try {
            Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "uid"));
            return ticketLinkRepository.findByTicketNameContainingOrderByUidDesc(ticketName, pageable);
        } catch (Exception e) {
            System.err.println("티켓바로가기 검색 중 오류: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
    
    // 링크로 티켓 정보 조회
    public TicketLink findByLink(String link) {
        try {
            return ticketLinkRepository.findByLink(link);
        } catch (Exception e) {
            System.err.println("링크로 티켓 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
} 