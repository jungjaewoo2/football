-- register_schedule 테이블 생성
CREATE TABLE IF NOT EXISTS register_schedule (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    uid VARCHAR(50) NOT NULL COMMENT '일정 고유번호',
    home_team VARCHAR(100) NOT NULL COMMENT '홈팀',
    away_team VARCHAR(100) NOT NULL COMMENT '원정팀',
    game_date VARCHAR(20) NOT NULL COMMENT '경기날짜',
    game_time VARCHAR(10) NOT NULL COMMENT '경기시간',
    selected_color VARCHAR(50) NOT NULL COMMENT '선택된 좌석 색상',
    seat_price VARCHAR(20) NOT NULL COMMENT '좌석 가격',
    
    -- 예약자 정보
    customer_name VARCHAR(100) NOT NULL COMMENT '예약자 이름',
    customer_gender VARCHAR(10) NOT NULL COMMENT '예약자 성별',
    customer_passport VARCHAR(100) NOT NULL COMMENT '예약자 영문이름(여권)',
    customer_phone VARCHAR(20) NOT NULL COMMENT '예약자 휴대전화',
    customer_email VARCHAR(100) NOT NULL COMMENT '예약자 이메일',
    customer_birth DATE NOT NULL COMMENT '예약자 생년월일',
    customer_address VARCHAR(10) NOT NULL COMMENT '예약자 우편번호',
    customer_address_detail VARCHAR(200) NOT NULL COMMENT '예약자 주소',
    customer_detail_address VARCHAR(200) NOT NULL COMMENT '예약자 상세주소',
    customer_english_address VARCHAR(200) NOT NULL COMMENT '예약자 영문주소',
    customer_kakao_id VARCHAR(100) COMMENT '예약자 카카오톡ID',
    
    -- 티켓 예약 정보
    ticket_quantity INT NOT NULL COMMENT '티켓 수량',
    total_price VARCHAR(20) NOT NULL COMMENT '총 가격',
    payment_method VARCHAR(20) NOT NULL COMMENT '결제방법',
    seat_alternative VARCHAR(10) NOT NULL COMMENT '좌석 대체 확보',
    adjacent_seat VARCHAR(10) NOT NULL COMMENT '연석희망여부',
    additional_requests TEXT COMMENT '기타요청사항',
    
    -- 동행자 정보 (JSON 형태로 저장)
    companions TEXT COMMENT '동행자 정보 JSON',
    
    -- 시스템 정보
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    
    INDEX idx_uid (uid),
    INDEX idx_customer_email (customer_email),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='예약 일정 정보'; 