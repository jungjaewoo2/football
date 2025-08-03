-- ticket_link 테이블에 link 칼럼 추가
ALTER TABLE ticket_link ADD COLUMN link VARCHAR(500) AFTER content;

-- 기존 데이터에 대한 기본값 설정 (필요한 경우)
-- UPDATE ticket_link SET link = '' WHERE link IS NULL; 