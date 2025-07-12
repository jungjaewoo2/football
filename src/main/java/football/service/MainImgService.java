package football.service;

import football.entity.MainImg;
import football.repository.MainImgRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class MainImgService {
    @Autowired
    private MainImgRepository mainImgRepository;

    public Page<MainImg> getMainImgList(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return mainImgRepository.findAllByOrderByUidDesc(pageable);
    }

    public MainImg getMainImg(Integer uid) {
        return mainImgRepository.findById(uid).orElse(null);
    }

    public MainImg saveMainImg(MainImg mainImg) {
        return mainImgRepository.save(mainImg);
    }

    public MainImg updateMainImg(MainImg mainImg) {
        return mainImgRepository.save(mainImg);
    }

    public void deleteMainImg(Integer uid) {
        mainImgRepository.deleteById(uid);
    }
} 