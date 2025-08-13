-- footer_info 테이블에 logo 컬럼 추가
ALTER TABLE footer_info ADD COLUMN IF NOT EXISTS logo VARCHAR(255);
