package football.service;

import football.entity.Tsc;
import football.repository.TscRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TscService {
    @Autowired
    private TscRepository tscRepository;

    public Tsc getTsc() {
        Tsc tsc = tscRepository.findFirstByOrderByUidAsc();
        if (tsc == null) {
            tsc = new Tsc();
            tsc.setContent("");
        }
        return tsc;
    }

    public Tsc saveTsc(Tsc tsc) {
        Tsc existing = tscRepository.findFirstByOrderByUidAsc();
        if (existing != null) {
            existing.setContent(tsc.getContent());
            return tscRepository.save(existing);
        } else {
            return tscRepository.save(tsc);
        }
    }
} 