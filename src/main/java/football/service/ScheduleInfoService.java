package football.service;

import football.entity.ScheduleInfo;
import football.repository.ScheduleInfoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ScheduleInfoService {
    @Autowired
    private ScheduleInfoRepository scheduleInfoRepository;

    public List<ScheduleInfo> findAll() {
        return scheduleInfoRepository.findAll();
    }

    public Optional<ScheduleInfo> findById(Integer uid) {
        return scheduleInfoRepository.findById(uid);
    }

    public ScheduleInfo save(ScheduleInfo scheduleInfo) {
        return scheduleInfoRepository.save(scheduleInfo);
    }

    public void deleteById(Integer uid) {
        scheduleInfoRepository.deleteById(uid);
    }
} 