package football.service;

import football.entity.MainBanner;
import football.repository.MainBannerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MainBannerService {
    @Autowired
    private MainBannerRepository mainBannerRepository;

    public Page<MainBanner> getMainBannerList(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return mainBannerRepository.findAllByOrderByUidDesc(pageable);
    }

    public List<MainBanner> getAllMainBanners() {
        return mainBannerRepository.findAllByOrderByUidAsc();
    }

    public MainBanner getMainBanner(Integer uid) {
        return mainBannerRepository.findById(uid).orElse(null);
    }

    public MainBanner saveMainBanner(MainBanner mainBanner) {
        return mainBannerRepository.save(mainBanner);
    }

    public MainBanner updateMainBanner(MainBanner mainBanner) {
        return mainBannerRepository.save(mainBanner);
    }

    public void deleteMainBanner(Integer uid) {
        mainBannerRepository.deleteById(uid);
    }
} 