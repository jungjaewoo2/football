package football.repository;

import football.entity.ScheduleInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ScheduleInfoRepository extends JpaRepository<ScheduleInfo, Integer> {
} 