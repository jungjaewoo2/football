CREATE TABLE IF NOT EXISTS schedule_info (
    uid INT AUTO_INCREMENT PRIMARY KEY,
    game_category VARCHAR(50) NOT NULL,
    home_stadium VARCHAR(100) NOT NULL,
    home_team VARCHAR(100) NOT NULL,
    other_team VARCHAR(100) NOT NULL,
    game_date VARCHAR(20) NOT NULL,
    game_time VARCHAR(10) NOT NULL,
    fee INT,
    orange INT,
    yellow INT,
    green INT,
    blue INT,
    purple INT,
    red INT,
    black INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
); 