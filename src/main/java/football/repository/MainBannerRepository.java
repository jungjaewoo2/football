package football.repository;

import football.entity.MainBanner;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MainBannerRepository extends JpaRepository<MainBanner, Integer> {
    Page<MainBanner> findAllByOrderByUidDesc(Pageable pageable);
    List<MainBanner> findAllByOrderByUidAsc();
} 