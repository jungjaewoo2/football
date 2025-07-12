package football.repository;

import football.entity.Faq;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface FaqRepository extends JpaRepository<Faq, Integer> {
    
    // 기본 페이징 조회 (공지사항 우선, 그 다음 최신순)
    @Query("SELECT f FROM Faq f ORDER BY f.notice DESC, f.uid DESC")
    Page<Faq> findAllByOrderByNoticeDescUidDesc(Pageable pageable);
    
    // 제목으로 검색 (공지사항 우선, 그 다음 최신순)
    @Query("SELECT f FROM Faq f WHERE f.title LIKE %:keyword% ORDER BY f.notice DESC, f.uid DESC")
    Page<Faq> findByTitleContaining(@Param("keyword") String keyword, Pageable pageable);
    
    // 작성자로 검색 (공지사항 우선, 그 다음 최신순)
    @Query("SELECT f FROM Faq f WHERE f.name LIKE %:keyword% ORDER BY f.notice DESC, f.uid DESC")
    Page<Faq> findByNameContaining(@Param("keyword") String keyword, Pageable pageable);
    
    // 제목과 작성자로 검색 (공지사항 우선, 그 다음 최신순)
    @Query("SELECT f FROM Faq f WHERE f.title LIKE %:keyword% OR f.name LIKE %:keyword% ORDER BY f.notice DESC, f.uid DESC")
    Page<Faq> findByTitleContainingOrNameContaining(@Param("keyword") String keyword, Pageable pageable);
} 