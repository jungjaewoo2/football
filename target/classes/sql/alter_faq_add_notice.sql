-- FAQ 테이블에 notice 칼럼 추가
ALTER TABLE faq ADD COLUMN notice CHAR(1) NOT NULL DEFAULT 'N' AFTER content; 