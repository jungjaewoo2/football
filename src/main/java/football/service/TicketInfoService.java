package football.service;

import football.entity.TicketInfo;
import football.repository.TicketInfoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TicketInfoService {
    @Autowired
    private TicketInfoRepository ticketInfoRepository;

    public TicketInfo getTicketInfo() {
        TicketInfo ticketInfo = ticketInfoRepository.findFirstByOrderByUidAsc();
        if (ticketInfo == null) {
            ticketInfo = new TicketInfo();
            ticketInfo.setContent("");
        }
        return ticketInfo;
    }

    public TicketInfo saveTicketInfo(TicketInfo ticketInfo) {
        TicketInfo existing = ticketInfoRepository.findFirstByOrderByUidAsc();
        if (existing != null) {
            existing.setContent(ticketInfo.getContent());
            return ticketInfoRepository.save(existing);
        } else {
            return ticketInfoRepository.save(ticketInfo);
        }
    }
} 