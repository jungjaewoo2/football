package football.repository;

import football.entity.FooterInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FooterInfoRepository extends JpaRepository<FooterInfo, Integer> {
    FooterInfo findFirstByOrderByUidAsc();
} 