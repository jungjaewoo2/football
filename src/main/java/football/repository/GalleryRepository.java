package football.repository;

import football.entity.Gallery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface GalleryRepository extends JpaRepository<Gallery, Integer> {
    
    // 페이징 처리를 위한 메서드
    Page<Gallery> findAllByOrderByRegdateDesc(Pageable pageable);
    
    // 제목으로 검색 (페이징 포함)
    @Query("SELECT g FROM Gallery g WHERE g.title LIKE %:keyword% ORDER BY g.regdate DESC")
    Page<Gallery> findByTitleContainingOrderByRegdateDesc(@Param("keyword") String keyword, Pageable pageable);
    
    // 작성자로 검색 (페이징 포함)
    @Query("SELECT g FROM Gallery g WHERE g.name LIKE %:keyword% ORDER BY g.regdate DESC")
    Page<Gallery> findByNameContainingOrderByRegdateDesc(@Param("keyword") String keyword, Pageable pageable);
    
    // 제목과 작성자로 검색 (페이징 포함)
    @Query("SELECT g FROM Gallery g WHERE g.title LIKE %:keyword% OR g.name LIKE %:keyword% ORDER BY g.regdate DESC")
    Page<Gallery> findByTitleContainingOrNameContainingOrderByRegdateDesc(@Param("keyword") String keyword, Pageable pageable);
} 