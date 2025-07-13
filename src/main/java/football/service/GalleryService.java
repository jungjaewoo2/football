package football.service;

import football.entity.Gallery;
import football.repository.GalleryRepository;
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
public class GalleryService {
    
    @Autowired
    private GalleryRepository galleryRepository;
    
    // 모든 갤러리 목록 조회 (페이징)
    public Page<Gallery> getAllGalleries(int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "regdate"));
        return galleryRepository.findAllByOrderByRegdateDesc(pageable);
    }
    
    // 갤러리 상세 조회
    public Optional<Gallery> getGalleryById(Integer uid) {
        return galleryRepository.findById(uid);
    }
    
    // 갤러리 등록
    public Gallery createGallery(Gallery gallery) {
        // 현재 날짜를 regdate에 설정
        LocalDateTime now = LocalDateTime.now();
        gallery.setRegdate(now);
        gallery.setCreatedAt(now);
        gallery.setUpdatedAt(now);
        return galleryRepository.save(gallery);
    }
    
    // 갤러리 수정
    public Gallery updateGallery(Integer uid, Gallery galleryDetails) {
        Optional<Gallery> optionalGallery = galleryRepository.findById(uid);
        if (optionalGallery.isPresent()) {
            Gallery gallery = optionalGallery.get();
            gallery.setName(galleryDetails.getName());
            gallery.setTitle(galleryDetails.getTitle());
            gallery.setContent(galleryDetails.getContent());
            
            // 이미지가 있는 경우에만 업데이트
            if (galleryDetails.getImg() != null && !galleryDetails.getImg().isEmpty()) {
                gallery.setImg(galleryDetails.getImg());
            }
            
            gallery.setUpdatedAt(LocalDateTime.now());
            return galleryRepository.save(gallery);
        }
        return null;
    }
    
    // 갤러리 삭제
    public boolean deleteGallery(Integer uid) {
        Optional<Gallery> optionalGallery = galleryRepository.findById(uid);
        if (optionalGallery.isPresent()) {
            galleryRepository.deleteById(uid);
            return true;
        }
        return false;
    }
    
    // 제목으로 검색 (페이징)
    public Page<Gallery> searchByTitle(String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "regdate"));
        return galleryRepository.findByTitleContainingOrderByRegdateDesc(keyword, pageable);
    }
    
    // 작성자로 검색 (페이징)
    public Page<Gallery> searchByName(String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "regdate"));
        return galleryRepository.findByNameContainingOrderByRegdateDesc(keyword, pageable);
    }
    
    // 제목과 작성자로 검색 (페이징)
    public Page<Gallery> searchByTitleOrName(String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "regdate"));
        return galleryRepository.findByTitleContainingOrNameContainingOrderByRegdateDesc(keyword, pageable);
    }
    
    // 전체 갤러리 수 조회
    public long getTotalCount() {
        return galleryRepository.count();
    }
} 