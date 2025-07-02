-- admin 계정 데이터 삽입 (아이디: admin, 비밀번호: 1234)
INSERT IGNORE INTO admin (id, passwd) VALUES ('admin', '1234');

-- 팀정보 테스트 데이터
INSERT IGNORE INTO team_info (category_name, team_name, stadium, city) VALUES 
('EPL', 'Manchester United', 'Old Trafford', 'Manchester'),
('EPL', 'Liverpool', 'Anfield', 'Liverpool'),
('EPL', 'Arsenal', 'Emirates Stadium', 'London'),
('L.Liga', 'Real Madrid', 'Santiago Bernabéu', 'Madrid'),
('L.Liga', 'Barcelona', 'Camp Nou', 'Barcelona'),
('B.Liga', 'Bayern Munich', 'Allianz Arena', 'Munich'),
('B.Liga', 'Borussia Dortmund', 'Signal Iduna Park', 'Dortmund'),
('ETC', 'Paris Saint-Germain', 'Parc des Princes', 'Paris'),
('웸블리', 'England National Team', 'Wembley Stadium', 'London');

-- 좌석요금 테스트 데이터
INSERT IGNORE INTO seat_fee (seat_name, orange, yellow, green, blue, purple, red, black) VALUES 
('일반석', 50000, 40000, 30000, 25000, 20000, 15000, 10000),
('VIP석', 100000, 80000, 60000, 50000, 40000, 30000, 20000),
('프리미엄석', 150000, 120000, 90000, 75000, 60000, 45000, 30000); 