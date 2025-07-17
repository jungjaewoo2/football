package football.service;

import football.entity.Qna;
import football.repository.QnaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class QnaService {
    
    @Autowired
    private QnaRepository qnaRepository;
    
    // 게시물 등록
    public Qna saveQna(Qna qna) {
        if (qna.getRegdate() == null) {
            qna.setRegdate(LocalDateTime.now());
        }
        return qnaRepository.save(qna);
    }
    
    // 게시물 수정
    public Qna updateQna(Qna qna) {
        Optional<Qna> existingQna = qnaRepository.findById(qna.getUid());
        if (existingQna.isPresent()) {
            Qna updatedQna = existingQna.get();
            updatedQna.setTitle(qna.getTitle());
            updatedQna.setContent(qna.getContent());
            updatedQna.setName(qna.getName());
            updatedQna.setNotice(qna.getNotice());
            return qnaRepository.save(updatedQna);
        }
        return null;
    }
    
    // 게시물 삭제 (답변도 함께 삭제)
    public boolean deleteQna(Integer uid) {
        Optional<Qna> qna = qnaRepository.findById(uid);
        if (qna.isPresent()) {
            // 답변들도 함께 삭제
            List<Qna> replies = qnaRepository.findRepliesByParentId(uid);
            qnaRepository.deleteAll(replies);
            qnaRepository.deleteById(uid);
            return true;
        }
        return false;
    }
    
    // 게시물 조회
    public Optional<Qna> findQnaById(Integer uid) {
        return qnaRepository.findById(uid);
    }
    
    // 메인 게시물 목록 조회 (페이징)
    public Page<Qna> findMainPosts(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return qnaRepository.findMainPosts(pageable);
    }
    
    // 게시물과 답변 개수 조회
    public Page<Object[]> findMainPostsWithReplyCount(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return qnaRepository.findMainPostsWithReplyCount(pageable);
    }
    
    // 답변 목록 조회
    public List<Qna> findRepliesByParentId(Integer parentId) {
        return qnaRepository.findRepliesByParentId(parentId);
    }
    
    // 답변 등록
    public Qna saveReply(Qna reply) {
        reply.setRegdate(LocalDateTime.now());
        return qnaRepository.save(reply);
    }
    
    // 답변 삭제
    public boolean deleteReply(Integer uid) {
        Optional<Qna> reply = qnaRepository.findById(uid);
        if (reply.isPresent() && reply.get().getParentPostId() != null) {
            qnaRepository.deleteById(uid);
            return true;
        }
        return false;
    }
    
    // 제목으로 검색
    public Page<Qna> searchByTitle(String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return qnaRepository.findByTitleContaining(keyword, pageable);
    }
    
    // 작성자로 검색
    public Page<Qna> searchByName(String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return qnaRepository.findByNameContaining(keyword, pageable);
    }
    
    // 내용으로 검색
    public Page<Qna> searchByContent(String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return qnaRepository.findByContentContaining(keyword, pageable);
    }
    
    // 전체 검색 (제목, 작성자, 내용)
    public Page<Qna> searchAll(String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        // 제목으로 먼저 검색
        Page<Qna> titleResults = qnaRepository.findByTitleContaining(keyword, pageable);
        if (!titleResults.isEmpty()) {
            return titleResults;
        }
        
        // 작성자로 검색
        Page<Qna> nameResults = qnaRepository.findByNameContaining(keyword, pageable);
        if (!nameResults.isEmpty()) {
            return nameResults;
        }
        
        // 내용으로 검색
        return qnaRepository.findByContentContaining(keyword, pageable);
    }
    
    // 조회수 증가
    public void incrementRef(Integer uid) {
        Optional<Qna> optionalQna = qnaRepository.findById(uid);
        if (optionalQna.isPresent()) {
            Qna qna = optionalQna.get();
            Integer currentRef = qna.getRef();
            qna.setRef(currentRef != null ? currentRef + 1 : 1);
            qnaRepository.save(qna);
        }
    }
    
    // 비밀번호 확인
    public boolean checkPassword(Integer uid, String password) {
        Optional<Qna> qna = qnaRepository.findById(uid);
        if (qna.isPresent()) {
            String storedPassword = qna.get().getPasswd();
            return storedPassword != null && storedPassword.equals(password);
        }
        return false;
    }
} 