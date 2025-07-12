package football.repository;

import football.entity.Popup;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PopupRepository extends JpaRepository<Popup, Integer> {
    Page<Popup> findAllByOrderByUidDesc(Pageable pageable);
} 