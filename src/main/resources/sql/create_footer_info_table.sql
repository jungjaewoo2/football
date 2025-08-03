-- footer_info 테이블 생성
CREATE TABLE IF NOT EXISTS footer_info (
    uid INT AUTO_INCREMENT PRIMARY KEY,
    phone VARCHAR(50),
    email VARCHAR(100)
);

-- 기존 content 컬럼이 있다면 제거하고 새로운 컬럼 추가
ALTER TABLE footer_info DROP COLUMN IF EXISTS content;
ALTER TABLE footer_info ADD COLUMN IF NOT EXISTS phone VARCHAR(50);
ALTER TABLE footer_info ADD COLUMN IF NOT EXISTS email VARCHAR(100); 