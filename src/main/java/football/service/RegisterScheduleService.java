package football.service;

import football.entity.RegisterSchedule;
import football.repository.RegisterScheduleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class RegisterScheduleService {
    
    @Autowired
    private RegisterScheduleRepository registerScheduleRepository;
    
    // 예약 저장
    public RegisterSchedule saveReservation(RegisterSchedule registerSchedule) {
        registerSchedule.setCreatedAt(LocalDateTime.now());
        registerSchedule.setUpdatedAt(LocalDateTime.now());
        return registerScheduleRepository.save(registerSchedule);
    }
    
    // 모든 예약 조회
    public List<RegisterSchedule> getAllReservations() {
        return registerScheduleRepository.findAll();
    }
    
    // ID로 예약 조회
    public RegisterSchedule getReservationById(Long id) {
        return registerScheduleRepository.findById(id).orElse(null);
    }
    
    // UID로 예약 조회
    public List<RegisterSchedule> getReservationsByUid(String uid) {
        return registerScheduleRepository.findByUid(uid);
    }
    
    // 이메일로 예약 조회
    public List<RegisterSchedule> getReservationsByEmail(String email) {
        return registerScheduleRepository.findByCustomerEmail(email);
    }
    
    // 예약자 이름으로 예약 조회
    public List<RegisterSchedule> getReservationsByName(String name) {
        return registerScheduleRepository.findByCustomerName(name);
    }
    
    // 예약자 전화번호로 예약 조회
    public List<RegisterSchedule> getReservationsByPhone(String phone) {
        return registerScheduleRepository.findByCustomerPhone(phone);
    }
    
    // 예약 삭제
    public void deleteReservation(Long id) {
        registerScheduleRepository.deleteById(id);
    }
    
    // 예약 수정
    public RegisterSchedule updateReservation(RegisterSchedule registerSchedule) {
        registerSchedule.setUpdatedAt(LocalDateTime.now());
        return registerScheduleRepository.save(registerSchedule);
    }
} 