package football.controller;

import football.entity.Tour;
import football.service.TourService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/tour")
public class TourController {
    @Autowired
    private TourService tourService;

    @GetMapping("")
    public String viewTour(Model model) {
        Tour tour = tourService.getTour();
        model.addAttribute("tour", tour);
        return "admin/tour/view";
    }

    @GetMapping("/edit")
    public String editTour(Model model) {
        Tour tour = tourService.getTour();
        model.addAttribute("tour", tour);
        return "admin/tour/edit";
    }

    @PostMapping("/edit")
    public String updateTour(@ModelAttribute Tour tour) {
        tourService.saveTour(tour);
        return "redirect:/admin/tour";
    }
} 