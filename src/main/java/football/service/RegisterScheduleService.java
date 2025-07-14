package football.service;

import football.entity.RegisterSchedule;
import football.repository.RegisterScheduleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

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
    
    // 모든 예약 조회 (페이징)
    public Page<RegisterSchedule> getAllReservations(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return registerScheduleRepository.findAllByOrderByCreatedAtDesc(pageable);
    }
    
    // 예약자명으로 검색 (페이징)
    public Page<RegisterSchedule> searchByCustomerName(String customerName, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return registerScheduleRepository.findByCustomerNameContainingOrderByCreatedAtDesc(customerName, pageable);
    }
    
    // 홈팀으로 검색 (페이징)
    public Page<RegisterSchedule> searchByHomeTeam(String homeTeam, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return registerScheduleRepository.findByHomeTeamContainingOrderByCreatedAtDesc(homeTeam, pageable);
    }
    
    // 원정팀으로 검색 (페이징)
    public Page<RegisterSchedule> searchByAwayTeam(String awayTeam, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return registerScheduleRepository.findByAwayTeamContainingOrderByCreatedAtDesc(awayTeam, pageable);
    }
    
    // ID로 예약 조회
    public Optional<RegisterSchedule> getReservationById(Long id) {
        return registerScheduleRepository.findById(id);
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
    
    // 예약상태 변경
    public void updateReservationStatus(Long id, String status) {
        Optional<RegisterSchedule> reservation = registerScheduleRepository.findById(id);
        if (reservation.isPresent()) {
            RegisterSchedule registerSchedule = reservation.get();
            registerSchedule.setReservationStatus(status);
            registerSchedule.setUpdatedAt(LocalDateTime.now());
            registerScheduleRepository.save(registerSchedule);
        }
    }
    
    // 결제상태 변경
    public void updatePaymentStatus(Long id, String status) {
        Optional<RegisterSchedule> reservation = registerScheduleRepository.findById(id);
        if (reservation.isPresent()) {
            RegisterSchedule registerSchedule = reservation.get();
            registerSchedule.setPaymentStatus(status);
            registerSchedule.setUpdatedAt(LocalDateTime.now());
            registerScheduleRepository.save(registerSchedule);
        }
    }
    
    // 승인상태 변경
    public void updateApprovalStatus(Long id, String status) {
        Optional<RegisterSchedule> reservation = registerScheduleRepository.findById(id);
        if (reservation.isPresent()) {
            RegisterSchedule registerSchedule = reservation.get();
            registerSchedule.setApprovalStatus(status);
            registerSchedule.setUpdatedAt(LocalDateTime.now());
            registerScheduleRepository.save(registerSchedule);
        }
    }
} 