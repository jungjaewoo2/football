package football.repository;

import football.entity.Tsc;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TscRepository extends JpaRepository<Tsc, Integer> {
    Tsc findFirstByOrderByUidAsc();
} 