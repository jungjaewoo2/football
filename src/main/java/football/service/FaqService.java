package football.service;

import football.entity.Faq;
import football.repository.FaqRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class FaqService {
    
    private static final Logger logger = LoggerFactory.getLogger(FaqService.class);
    
    @Autowired
    private FaqRepository faqRepository;
    
    // 모든 FAQ 목록 조회 (페이징) - 공지사항 우선 정렬
    public Page<Faq> getAllFaqs(int page, int size) {
        try {
            logger.info("FAQ 전체 목록 조회 시작 - page: {}, size: {}", page, size);
            Pageable pageable = PageRequest.of(page, size);
            Page<Faq> result = faqRepository.findAllByOrderByNoticeDescUidDesc(pageable);
            logger.info("FAQ 전체 목록 조회 완료 - 총 개수: {}, 현재 페이지: {}, 총 페이지: {}", 
                       result.getTotalElements(), result.getNumber(), result.getTotalPages());
            return result;
        } catch (Exception e) {
            logger.error("FAQ 전체 목록 조회 중 오류 발생", e);
            throw e;
        }
    }
    
    // FAQ 상세 조회
    public Optional<Faq> getFaqById(Integer uid) {
        try {
            logger.info("FAQ 상세 조회 시작 - uid: {}", uid);
            Optional<Faq> result = faqRepository.findById(uid);
            if (result.isPresent()) {
                logger.info("FAQ 상세 조회 성공 - uid: {}, title: {}, name: {}", 
                    result.get().getUid(), result.get().getTitle(), result.get().getName());
            } else {
                logger.warn("FAQ를 찾을 수 없음 - uid: {}", uid);
            }
            return result;
        } catch (Exception e) {
            logger.error("FAQ 상세 조회 중 오류 발생 - uid: {}", uid, e);
            throw e;
        }
    }
    
    // FAQ 등록
    public Faq createFaq(Faq faq) {
        // 현재 날짜를 regdate에 설정
        LocalDateTime now = LocalDateTime.now();
        faq.setRegdate(now);
        faq.setCreatedAt(now);
        faq.setUpdatedAt(now);
        return faqRepository.save(faq);
    }
    
    // FAQ 수정
    public Faq updateFaq(Integer uid, Faq faqDetails) {
        Optional<Faq> optionalFaq = faqRepository.findById(uid);
        if (optionalFaq.isPresent()) {
            Faq faq = optionalFaq.get();
            faq.setName(faqDetails.getName());
            faq.setTitle(faqDetails.getTitle());
            faq.setContent(faqDetails.getContent());
            faq.setNotice(faqDetails.getNotice());
            faq.setUpdatedAt(LocalDateTime.now());
            return faqRepository.save(faq);
        }
        return null;
    }
    
    // FAQ 삭제
    public boolean deleteFaq(Integer uid) {
        Optional<Faq> optionalFaq = faqRepository.findById(uid);
        if (optionalFaq.isPresent()) {
            faqRepository.deleteById(uid);
            return true;
        }
        return false;
    }
    
    // 모든 FAQ 삭제
    public void deleteAllFaqs() {
        faqRepository.deleteAll();
    }
    
    // 제목으로 검색 (페이징) - 공지사항 우선 정렬
    public Page<Faq> searchByTitle(String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return faqRepository.findByTitleContaining(keyword, pageable);
    }
    
    // 작성자로 검색 (페이징) - 공지사항 우선 정렬
    public Page<Faq> searchByName(String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return faqRepository.findByNameContaining(keyword, pageable);
    }
    
    // 제목과 작성자로 검색 (페이징) - 공지사항 우선 정렬
    public Page<Faq> searchByTitleOrName(String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return faqRepository.findByTitleContainingOrNameContaining(keyword, pageable);
    }
    
    // 전체 FAQ 수 조회
    public long getTotalCount() {
        return faqRepository.count();
    }
} 