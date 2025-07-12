package football.service;

import football.entity.Tour;
import football.repository.TourRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TourService {
    @Autowired
    private TourRepository tourRepository;

    public Tour getTour() {
        Tour tour = tourRepository.findFirstByOrderByUidAsc();
        if (tour == null) {
            tour = new Tour();
            tour.setContent("");
        }
        return tour;
    }

    public Tour saveTour(Tour tour) {
        Tour existing = tourRepository.findFirstByOrderByUidAsc();
        if (existing != null) {
            existing.setContent(tour.getContent());
            return tourRepository.save(existing);
        } else {
            return tourRepository.save(tour);
        }
    }
} 