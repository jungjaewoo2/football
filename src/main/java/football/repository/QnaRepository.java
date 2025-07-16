package football.repository;

import football.entity.Qna;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QnaRepository extends JpaRepository<Qna, Integer> {
    
    // 모든 게시물 조회 - 공지사항 우선 정렬
    @Query("SELECT q FROM Qna q ORDER BY q.notice DESC, q.uid DESC")
    Page<Qna> findMainPosts(Pageable pageable);
    
    // 특정 게시물의 모든 답변 조회
    @Query("SELECT q FROM Qna q WHERE q.parentPostId = :parentId ORDER BY q.regdate ASC")
    List<Qna> findRepliesByParentId(@Param("parentId") Integer parentId);
    
    // 게시물과 답변 개수 조회 - 공지사항 우선 정렬
    @Query("SELECT q, (SELECT COUNT(r) FROM Qna r WHERE r.parentPostId = q.uid) as replyCount FROM Qna q ORDER BY q.notice DESC, q.uid DESC")
    Page<Object[]> findMainPostsWithReplyCount(Pageable pageable);
    
    // 제목으로 검색 - 공지사항 우선 정렬, 모든 글 포함
    @Query("SELECT q FROM Qna q WHERE q.title LIKE %:keyword% ORDER BY q.notice DESC, q.uid DESC")
    Page<Qna> findByTitleContaining(@Param("keyword") String keyword, Pageable pageable);
    
    // 작성자로 검색 - 공지사항 우선 정렬, 모든 글 포함
    @Query("SELECT q FROM Qna q WHERE q.name LIKE %:keyword% ORDER BY q.notice DESC, q.uid DESC")
    Page<Qna> findByNameContaining(@Param("keyword") String keyword, Pageable pageable);
    
    // 내용으로 검색 - 공지사항 우선 정렬, 모든 글 포함
    @Query("SELECT q FROM Qna q WHERE q.content LIKE %:keyword% ORDER BY q.notice DESC, q.uid DESC")
    Page<Qna> findByContentContaining(@Param("keyword") String keyword, Pageable pageable);
} 