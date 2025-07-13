package football.repository;

import football.entity.MainImg;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MainImgRepository extends JpaRepository<MainImg, Integer> {
    Page<MainImg> findAllByOrderByUidDesc(Pageable pageable);
    List<MainImg> findAllByOrderByUidDesc();
} 