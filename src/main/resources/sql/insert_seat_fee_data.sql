-- seat_fee 테이블에 10개의 샘플 데이터 삽입
-- team_info 테이블의 team_name을 참조하여 생성
INSERT INTO seat_fee (seat_name, seat_price, orange, yellow, green, blue, purple, red, black, created_at, updated_at) VALUES
('Manchester United', 'VIP석:150000,일반석:80000,경기석:120000', 150000, 120000, 100000, 80000, 60000, 40000, 20000, NOW(), NOW()),
('Real Madrid', '프리미엄석:200000,일반석:100000,경기석:160000', 200000, 170000, 140000, 100000, 80000, 60000, 40000, NOW(), NOW()),
('Bayern Munich', '프리미엄석:170000,일반석:90000,경기석:140000', 170000, 140000, 120000, 90000, 70000, 50000, 30000, NOW(), NOW()),
('Arsenal', 'VIP석:160000,일반석:85000,경기석:130000', 160000, 130000, 110000, 85000, 65000, 45000, 25000, NOW(), NOW()),
('Barcelona', 'VIP석:190000,일반석:95000,경기석:150000', 190000, 160000, 130000, 95000, 75000, 55000, 35000, NOW(), NOW()); 