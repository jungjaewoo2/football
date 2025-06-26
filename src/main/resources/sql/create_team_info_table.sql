CREATE TABLE IF NOT EXISTS team_info (
    uid INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL,
    category_name VARCHAR(50) NOT NULL,
    logo_img VARCHAR(255),
    stadium VARCHAR(100),
    city VARCHAR(50),
    seat_img VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 샘플 데이터 삽입
INSERT INTO team_info (team_name, category_name, logo_img, stadium, city, seat_img) VALUES
('Manchester United', 'EPL', 'man_utd_logo.png', 'Old Trafford', 'Manchester', 'old_trafford_seats.jpg'),
('Real Madrid', 'L.Liga', 'real_madrid_logo.png', 'Santiago Bernabéu', 'Madrid', 'bernabeu_seats.jpg'),
('Bayern Munich', 'B.Liga', 'bayern_logo.png', 'Allianz Arena', 'Munich', 'allianz_seats.jpg'),
('Arsenal', 'EPL', 'arsenal_logo.png', 'Emirates Stadium', 'London', 'emirates_seats.jpg'),
('Barcelona', 'L.Liga', 'barcelona_logo.png', 'Camp Nou', 'Barcelona', 'camp_nou_seats.jpg'); 