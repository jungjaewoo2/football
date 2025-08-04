-- footer_info 테이블에 address 컬럼 추가
ALTER TABLE footer_info ADD COLUMN IF NOT EXISTS address VARCHAR(200); 