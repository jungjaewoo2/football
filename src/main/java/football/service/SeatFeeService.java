package football.service;

import football.entity.SeatFee;
import football.repository.SeatFeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class SeatFeeService {
    
    @Autowired
    private SeatFeeRepository seatFeeRepository;
    
    // 전체 좌석요금 목록 조회 (페이징)
    public Page<SeatFee> getAllSeatFees(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return seatFeeRepository.findAllByOrderByUidDesc(pageable);
    }
    
    // 좌석명으로 검색 (페이징)
    public Page<SeatFee> searchSeatFeesByName(String seatName, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return seatFeeRepository.findBySeatNameContainingOrderByUidDesc(seatName, pageable);
    }
    
    // 특정 좌석요금 조회
    public Optional<SeatFee> getSeatFeeById(Integer uid) {
        return seatFeeRepository.findById(uid);
    }
    
    // 좌석요금 등록
    public SeatFee saveSeatFee(SeatFee seatFee) {
        return seatFeeRepository.save(seatFee);
    }
    
    // 좌석요금 수정
    public SeatFee updateSeatFee(SeatFee seatFee) {
        if (seatFeeRepository.existsById(seatFee.getUid())) {
            return seatFeeRepository.save(seatFee);
        }
        throw new RuntimeException("좌석요금을 찾을 수 없습니다. ID: " + seatFee.getUid());
    }
    
    // 좌석요금 삭제
    public void deleteSeatFee(Integer uid) {
        if (seatFeeRepository.existsById(uid)) {
            seatFeeRepository.deleteById(uid);
        } else {
            throw new RuntimeException("좌석요금을 찾을 수 없습니다. ID: " + uid);
        }
    }
    
    // 전체 개수 조회
    public long getTotalCount() {
        return seatFeeRepository.countAllSeatFees();
    }
    
    // 전체 좌석요금 목록 조회 (페이징 없이)
    public List<SeatFee> findAll() {
        return seatFeeRepository.findAll();
    }
    
    // 팀명으로 좌석 요금 조회
    public Optional<SeatFee> findBySeatName(String seatName) {
        return seatFeeRepository.findBySeatName(seatName);
    }
} 