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
        // 예약번호가 없으면 자동 생성
        if (registerSchedule.getUid() == null || registerSchedule.getUid().isEmpty()) {
            registerSchedule.setUid(generateReservationUid());
        }
        
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
    
    // 예약상태로 검색 (페이징)
    public Page<RegisterSchedule> searchByReservationStatus(String reservationStatus, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return registerScheduleRepository.findByReservationStatusContainingOrderByCreatedAtDesc(reservationStatus, pageable);
    }
    
    // 승인상태로 검색 (페이징)
    public Page<RegisterSchedule> searchByApprovalStatus(String approvalStatus, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return registerScheduleRepository.findByApprovalStatusContainingOrderByCreatedAtDesc(approvalStatus, pageable);
    }
    
    // 경기날짜로 검색 (페이징)
    public Page<RegisterSchedule> searchByGameDate(String gameDate, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return registerScheduleRepository.findByGameDateContainingOrderByCreatedAtDesc(gameDate, pageable);
    }
    
    // 전체 검색 (페이징)
    public Page<RegisterSchedule> searchByAll(String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return registerScheduleRepository.findByCustomerNameContainingOrHomeTeamContainingOrAwayTeamContainingOrderByCreatedAtDesc(keyword, keyword, keyword, pageable);
    }
    
    // 예약완료 상태인 예약만 조회 (페이징)
    public Page<RegisterSchedule> getReservationsByReservationStatus(String status, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return registerScheduleRepository.findByReservationStatusOrderByCreatedAtDesc(status, pageable);
    }
    
    // 예약자명으로 검색 + 예약완료 상태 필터링 (페이징)
    public Page<RegisterSchedule> searchByCustomerNameAndReservationStatus(String customerName, String status, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return registerScheduleRepository.findByCustomerNameContainingAndReservationStatusOrderByCreatedAtDesc(customerName, status, pageable);
    }
    
    // 홈팀으로 검색 + 예약완료 상태 필터링 (페이징)
    public Page<RegisterSchedule> searchByHomeTeamAndReservationStatus(String homeTeam, String status, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return registerScheduleRepository.findByHomeTeamContainingAndReservationStatusOrderByCreatedAtDesc(homeTeam, status, pageable);
    }
    
    // 원정팀으로 검색 + 예약완료 상태 필터링 (페이징)
    public Page<RegisterSchedule> searchByAwayTeamAndReservationStatus(String awayTeam, String status, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return registerScheduleRepository.findByAwayTeamContainingAndReservationStatusOrderByCreatedAtDesc(awayTeam, status, pageable);
    }
    
    // 전체 검색 + 예약완료 상태 필터링 (페이징)
    public Page<RegisterSchedule> searchByAllAndReservationStatus(String keyword, String status, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return registerScheduleRepository.findByCustomerNameContainingOrHomeTeamContainingOrAwayTeamContainingAndReservationStatusOrderByCreatedAtDesc(keyword, keyword, keyword, status, pageable);
    }
    
    // ID로 예약 조회
    public Optional<RegisterSchedule> getReservationById(Long id) {
        return registerScheduleRepository.findById(id);
    }
    
    // UID로 예약 조회
    public List<RegisterSchedule> getReservationsByUid(String uid) {
        return registerScheduleRepository.findByUid(uid);
    }
    
    // 예약번호 생성 (년월일+ID순번 형태)
    public String generateReservationUid() {
        // 현재 날짜를 년월일 형태로 가져오기
        java.time.LocalDate today = java.time.LocalDate.now();
        String dateStr = today.format(java.time.format.DateTimeFormatter.ofPattern("yyyyMMdd"));
        
        // 오늘 날짜의 예약 건수 조회
        String todayStr = today.format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        long todayCount = registerScheduleRepository.countByCreatedAtBetween(
            java.time.LocalDateTime.of(today, java.time.LocalTime.MIN),
            java.time.LocalDateTime.of(today, java.time.LocalTime.MAX)
        );
        
        // 순번은 1부터 시작하므로 +1
        long sequence = todayCount + 1;
        
        // 2자리 순번으로 포맷팅 (01, 02, ...)
        String sequenceStr = String.format("%02d", sequence);
        
        // 년월일+순번 형태로 반환 (예: 2025072501)
        return dateStr + sequenceStr;
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
    
    // 특정 년/월에 해당하는 경기 수 조회
    public long countByGameDateLike(String yearMonth) {
        return registerScheduleRepository.countByGameDateLike(yearMonth);
    }
    
    // 특정 년/월에 해당하는 경기 수 조회 (더 정확한 쿼리)
    public long countByGameDateStartingWith(String yearMonth) {
        return registerScheduleRepository.countByGameDateStartingWith(yearMonth);
    }
    
    // 특정 년/월에 해당하는 경기 수 조회 (커스텀 쿼리)
    public long countByGameDateLikeWithQuery(String yearMonth) {
        return registerScheduleRepository.countByGameDateLikeWithQuery(yearMonth);
    }
    
    // 특정 년/월에 해당하는 경기 수 조회 (예약완료 상태만)
    public long countByGameDateLikeWithQueryAndStatus(String yearMonth, String status) {
        return registerScheduleRepository.countByGameDateLikeWithQueryAndStatus(yearMonth, status);
    }
    
    // 경기날짜로 검색 + 예약완료 상태 필터링 (페이징)
    public Page<RegisterSchedule> searchByGameDateAndReservationStatus(String gameDate, String status, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return registerScheduleRepository.findByGameDateContainingAndReservationStatusOrderByCreatedAtDesc(gameDate, status, pageable);
    }
    
    // 예약상태 변경
    public void updateReservationStatus(Long id, String status) {
        System.out.println("=== 서비스: 예약 상태 업데이트 시작 ===");
        System.out.println("예약 ID: " + id);
        System.out.println("변경할 상태: " + status);
        System.out.println("현재 시간: " + LocalDateTime.now());
        
        Optional<RegisterSchedule> reservation = registerScheduleRepository.findById(id);
        if (reservation.isPresent()) {
            RegisterSchedule registerSchedule = reservation.get();
            System.out.println("기존 예약 상태: " + registerSchedule.getReservationStatus());
            System.out.println("기존 register_ok 상태: " + registerSchedule.getRegisterOk());
            System.out.println("예약자명: " + registerSchedule.getCustomerName());
            
            registerSchedule.setReservationStatus(status);
            registerSchedule.setUpdatedAt(LocalDateTime.now());
            
            System.out.println("새로운 예약 상태 설정: " + status);
            System.out.println("업데이트 시간 설정: " + registerSchedule.getUpdatedAt());
            
            RegisterSchedule savedReservation = registerScheduleRepository.save(registerSchedule);
            System.out.println("저장 완료 - 새로운 예약 상태: " + savedReservation.getReservationStatus());
            System.out.println("저장 완료 - 업데이트 시간: " + savedReservation.getUpdatedAt());
            System.out.println("=== 서비스: 예약 상태 업데이트 완료 ===");
        } else {
            System.err.println("=== 서비스: 예약 상태 업데이트 실패 ===");
            System.err.println("예약 ID " + id + "를 찾을 수 없습니다.");
        }
    }
    
    // 결제상태 변경
    public void updatePaymentStatus(Long id, String status) {
        System.out.println("=== 서비스: 결제 상태 업데이트 시작 ===");
        System.out.println("예약 ID: " + id);
        System.out.println("변경할 상태: " + status);
        System.out.println("현재 시간: " + LocalDateTime.now());
        
        Optional<RegisterSchedule> reservation = registerScheduleRepository.findById(id);
        if (reservation.isPresent()) {
            RegisterSchedule registerSchedule = reservation.get();
            System.out.println("기존 결제 상태: " + registerSchedule.getPaymentStatus());
            System.out.println("예약자명: " + registerSchedule.getCustomerName());
            
            registerSchedule.setPaymentStatus(status);
            registerSchedule.setUpdatedAt(LocalDateTime.now());
            
            System.out.println("새로운 결제 상태 설정: " + status);
            System.out.println("업데이트 시간 설정: " + registerSchedule.getUpdatedAt());
            
            RegisterSchedule savedReservation = registerScheduleRepository.save(registerSchedule);
            System.out.println("저장 완료 - 새로운 결제 상태: " + savedReservation.getPaymentStatus());
            System.out.println("저장 완료 - 업데이트 시간: " + savedReservation.getUpdatedAt());
            System.out.println("=== 서비스: 결제 상태 업데이트 완료 ===");
        } else {
            System.err.println("=== 서비스: 결제 상태 업데이트 실패 ===");
            System.err.println("예약 ID " + id + "를 찾을 수 없습니다.");
            throw new RuntimeException("예약 ID " + id + "를 찾을 수 없습니다.");
        }
    }
    
    // 승인상태 변경
    public void updateApprovalStatus(Long id, String status) {
        System.out.println("=== 서비스: 승인 상태 업데이트 시작 ===");
        System.out.println("예약 ID: " + id);
        System.out.println("변경할 상태: " + status);
        System.out.println("현재 시간: " + LocalDateTime.now());
        
        Optional<RegisterSchedule> reservation = registerScheduleRepository.findById(id);
        if (reservation.isPresent()) {
            RegisterSchedule registerSchedule = reservation.get();
            System.out.println("기존 승인 상태: " + registerSchedule.getApprovalStatus());
            System.out.println("예약자명: " + registerSchedule.getCustomerName());
            
            registerSchedule.setApprovalStatus(status);
            registerSchedule.setUpdatedAt(LocalDateTime.now());
            
            System.out.println("새로운 승인 상태 설정: " + status);
            System.out.println("업데이트 시간 설정: " + registerSchedule.getUpdatedAt());
            
            RegisterSchedule savedReservation = registerScheduleRepository.save(registerSchedule);
            System.out.println("저장 완료 - 새로운 승인 상태: " + savedReservation.getApprovalStatus());
            System.out.println("저장 완료 - 업데이트 시간: " + savedReservation.getUpdatedAt());
            System.out.println("=== 서비스: 승인 상태 업데이트 완료 ===");
        } else {
            System.err.println("=== 서비스: 승인 상태 업데이트 실패 ===");
            System.err.println("예약 ID " + id + "를 찾을 수 없습니다.");
            throw new RuntimeException("예약 ID " + id + "를 찾을 수 없습니다.");
        }
    }
    
    // register_ok 상태 변경
    public void updateRegisterOk(Long id, String registerOk) {
        System.out.println("=== 서비스: register_ok 상태 업데이트 시작 ===");
        System.out.println("예약 ID: " + id);
        System.out.println("변경할 register_ok: " + registerOk);
        System.out.println("현재 시간: " + LocalDateTime.now());
        
        Optional<RegisterSchedule> reservation = registerScheduleRepository.findById(id);
        if (reservation.isPresent()) {
            RegisterSchedule registerSchedule = reservation.get();
            System.out.println("기존 register_ok 상태: " + registerSchedule.getRegisterOk());
            System.out.println("기존 예약 상태: " + registerSchedule.getReservationStatus());
            System.out.println("예약자명: " + registerSchedule.getCustomerName());
            
            registerSchedule.setRegisterOk(registerOk);
            registerSchedule.setUpdatedAt(LocalDateTime.now());
            
            System.out.println("새로운 register_ok 설정: " + registerOk);
            System.out.println("업데이트 시간 설정: " + registerSchedule.getUpdatedAt());
            
            RegisterSchedule savedReservation = registerScheduleRepository.save(registerSchedule);
            System.out.println("저장 완료 - 새로운 register_ok: " + savedReservation.getRegisterOk());
            System.out.println("저장 완료 - 업데이트 시간: " + savedReservation.getUpdatedAt());
            System.out.println("=== 서비스: register_ok 상태 업데이트 완료 ===");
        } else {
            System.err.println("=== 서비스: register_ok 상태 업데이트 실패 ===");
            System.err.println("예약 ID " + id + "를 찾을 수 없습니다.");
        }
    }
} 