package football.service;

import football.entity.FooterInfo;
import football.repository.FooterInfoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class FooterInfoService {
    private static final Logger logger = LoggerFactory.getLogger(FooterInfoService.class);
    
    @Autowired
    private FooterInfoRepository footerInfoRepository;

    public FooterInfo getFooterInfo() {
        logger.info("FooterInfo 데이터 조회 시작");
        FooterInfo footerInfo = footerInfoRepository.findFirstByOrderByUidAsc();
        if (footerInfo == null) {
            logger.warn("FooterInfo 데이터가 없습니다. 기본 데이터를 생성합니다.");
            footerInfo = createDefaultFooterInfo();
        } else {
            logger.info("FooterInfo 데이터 조회 완료: phone={}, email={}", 
                footerInfo.getPhone(), footerInfo.getEmail());
        }
        return footerInfo;
    }

    private FooterInfo createDefaultFooterInfo() {
        FooterInfo footerInfo = new FooterInfo();
        footerInfo.setPhone("070-7779-9614");
        footerInfo.setEmail("premierticket7@gmail.com");
        FooterInfo saved = footerInfoRepository.save(footerInfo);
        logger.info("기본 FooterInfo 데이터 생성 완료: phone={}, email={}", 
            saved.getPhone(), saved.getEmail());
        return saved;
    }

    public FooterInfo saveFooterInfo(FooterInfo footerInfo) {
        FooterInfo existing = footerInfoRepository.findFirstByOrderByUidAsc();
        if (existing != null) {
            existing.setPhone(footerInfo.getPhone());
            existing.setEmail(footerInfo.getEmail());
            return footerInfoRepository.save(existing);
        } else {
            return footerInfoRepository.save(footerInfo);
        }
    }
} 