-- footer_info 테이블에 테스트 데이터 삽입
INSERT INTO footer_info (phone, email) VALUES ('070-7779-9614', 'premierticket7@gmail.com')
ON DUPLICATE KEY UPDATE phone = VALUES(phone), email = VALUES(email); 