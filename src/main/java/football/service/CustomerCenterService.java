package football.service;

import football.entity.CustomerCenter;
import football.repository.CustomerCenterRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerCenterService {
    
    @Autowired
    private CustomerCenterRepository customerCenterRepository;
    
    // 고객센터 정보 조회
    public CustomerCenter getCustomerCenter() {
        CustomerCenter customerCenter = customerCenterRepository.findFirstByOrderByUidAsc();
        if (customerCenter == null) {
            // 데이터가 없으면 빈 객체 생성
            customerCenter = new CustomerCenter();
            customerCenter.setContent("");
        }
        return customerCenter;
    }
    
    // 고객센터 정보 저장/수정
    public CustomerCenter saveCustomerCenter(CustomerCenter customerCenter) {
        CustomerCenter existing = customerCenterRepository.findFirstByOrderByUidAsc();
        if (existing != null) {
            // 기존 데이터가 있으면 업데이트
            existing.setContent(customerCenter.getContent());
            return customerCenterRepository.save(existing);
        } else {
            // 새로 생성
            return customerCenterRepository.save(customerCenter);
        }
    }
} 