package football.service;

import football.entity.Popup;
import football.repository.PopupRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class PopupService {
    @Autowired
    private PopupRepository popupRepository;

    public Page<Popup> getPopupList(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return popupRepository.findAllByOrderByUidDesc(pageable);
    }

    public Popup getPopup(Integer uid) {
        return popupRepository.findById(uid).orElse(null);
    }

    public Popup savePopup(Popup popup) {
        return popupRepository.save(popup);
    }

    public Popup updatePopup(Popup popup) {
        return popupRepository.save(popup);
    }

    public void deletePopup(Integer uid) {
        popupRepository.deleteById(uid);
    }
} 