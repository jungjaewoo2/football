-- register_schedule 테이블에 10개의 테스트 데이터 삽입

INSERT INTO register_schedule (
    uid, home_team, away_team, game_date, game_time, selected_color, seat_price,
    customer_name, customer_gender, customer_passport, customer_phone, customer_email, customer_birth,
    customer_address, customer_address_detail, customer_detail_address, customer_english_address, customer_kakao_id,
    ticket_quantity, total_price, payment_method, seat_alternative, adjacent_seat, additional_requests, companions,
    reservation_status, payment_status, approval_status, register_ok, created_at, updated_at
) VALUES
-- 1번 데이터
('user001', '맨체스터 유나이티드', '리버풀', '2024-03-15', '20:30', '레드', '150,000',
'김철수', '남성', 'M12345678', '010-1234-5678', 'kim@test.com', '1990-01-15',
'서울특별시', '강남구', '테헤란로 123', '123 Teheran-ro, Gangnam-gu, Seoul', 'kimchulsoo',
2, '300,000', '신용카드', '가능', '필요', '창가 자리 부탁드립니다', '[]',
'예약대기', '결제대기', '미승인', 'N', NOW(), NOW()),

-- 2번 데이터
('user002', '아스널', '첼시', '2024-03-16', '21:00', '블루', '180,000',
'이영희', '여성', 'F23456789', '010-2345-6789', 'lee@test.com', '1992-05-20',
'부산광역시', '해운대구', '해운대로 456', '456 Haeundae-ro, Haeundae-gu, Busan', 'leeyounghee',
1, '180,000', '계좌이체', '불가능', '불필요', '', '[]',
'예약완료', '결제완료', '승인', 'Y', NOW(), NOW()),

-- 3번 데이터
('user003', '맨체스터 시티', '토트넘', '2024-03-17', '19:45', '그린', '120,000',
'박민수', '남성', 'M34567890', '010-3456-7890', 'park@test.com', '1988-12-03',
'대구광역시', '수성구', '수성로 789', '789 Suseong-ro, Suseong-gu, Daegu', 'parkminsu',
3, '360,000', '신용카드', '가능', '필요', '연속 좌석 부탁드립니다', '[{"name":"박지영","gender":"여성","birth":"1990-03-15","passport":"F45678901"},{"name":"박준호","gender":"남성","birth":"1992-07-22","passport":"M56789012"}]',
'예약대기', '결제대기', '미승인', 'N', NOW(), NOW()),

-- 4번 데이터
('user004', '리버풀', '에버튼', '2024-03-18', '22:00', '레드', '200,000',
'최수진', '여성', 'F45678901', '010-4567-8901', 'choi@test.com', '1995-08-10',
'인천광역시', '연수구', '연수로 321', '321 Yeonsu-ro, Yeonsu-gu, Incheon', 'choisujin',
1, '200,000', '무통장입금', '가능', '불필요', '조용한 자리 부탁드립니다', '[]',
'예약완료', '결제완료', '승인', 'Y', NOW(), NOW()),

-- 5번 데이터
('user005', '첼시', '웨스트햄', '2024-03-19', '20:15', '블루', '160,000',
'정현우', '남성', 'M56789012', '010-5678-9012', 'jung@test.com', '1987-11-25',
'광주광역시', '서구', '상무로 654', '654 Sangmu-ro, Seo-gu, Gwangju', 'junghyunwoo',
2, '320,000', '신용카드', '가능', '필요', '', '[{"name":"정미영","gender":"여성","birth":"1989-04-18","passport":"F67890123"}]',
'예약대기', '결제대기', '미승인', 'N', NOW(), NOW()),

-- 6번 데이터
('user006', '토트넘', '아스널', '2024-03-20', '21:30', '화이트', '170,000',
'한지민', '여성', 'F67890123', '010-6789-0123', 'han@test.com', '1993-06-12',
'대전광역시', '유성구', '유성대로 987', '987 Yuseong-daero, Yuseong-gu, Daejeon', 'hanjimin',
1, '170,000', '계좌이체', '불가능', '불필요', '좋은 자리 부탁드립니다', '[]',
'예약완료', '결제완료', '승인', 'Y', NOW(), NOW()),

-- 7번 데이터
('user007', '에버튼', '리버풀', '2024-03-21', '19:00', '블루', '140,000',
'윤성호', '남성', 'M78901234', '010-7890-1234', 'yoon@test.com', '1991-09-08',
'울산광역시', '남구', '삼산로 147', '147 Samsan-ro, Nam-gu, Ulsan', 'yoonseongho',
2, '280,000', '신용카드', '가능', '필요', '가족과 함께 관람합니다', '[{"name":"윤소영","gender":"여성","birth":"1994-02-14","passport":"F89012345"}]',
'예약대기', '결제대기', '미승인', 'N', NOW(), NOW()),

-- 8번 데이터
('user008', '웨스트햄', '토트넘', '2024-03-22', '20:45', '클레어트', '130,000',
'송미라', '여성', 'F89012345', '010-8901-2345', 'song@test.com', '1996-12-30',
'세종특별자치시', '한솔동', '한솔로 258', '258 Hansol-ro, Hansol-dong, Sejong', 'songmira',
1, '130,000', '무통장입금', '가능', '불필요', '', '[]',
'예약완료', '결제완료', '승인', 'Y', NOW(), NOW()),

-- 9번 데이터
('user009', '아스널', '맨체스터 유나이티드', '2024-03-23', '22:15', '레드', '190,000',
'임태현', '남성', 'M90123456', '010-9012-3456', 'lim@test.com', '1989-03-22',
'경기도', '수원시', '영통구', '영통로 369', '369 Yeongtong-ro, Yeongtong-gu, Suwon', 'limtaehyeon',
3, '570,000', '신용카드', '가능', '필요', '친구들과 함께 관람', '[{"name":"임지원","gender":"남성","birth":"1990-07-05","passport":"M01234567"},{"name":"임수진","gender":"여성","birth":"1992-11-18","passport":"F12345678"}]',
'예약대기', '결제대기', '미승인', 'N', NOW(), NOW()),

-- 10번 데이터
('user010', '리버풀', '맨체스터 시티', '2024-03-24', '21:00', '레드', '220,000',
'강서연', '여성', 'F01234567', '010-0123-4567', 'kang@test.com', '1994-05-07',
'강원도', '춘천시', '중앙로 741', '741 Jungang-ro, Chuncheon', 'kangseoyeon',
1, '220,000', '계좌이체', '불가능', '불필요', '최고의 경기를 기대합니다', '[]',
'예약완료', '결제완료', '승인', 'Y', NOW(), NOW()); 