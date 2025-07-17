-- QNA 테이블에 passwd 컬럼 추가 (이미 존재하는 경우 무시)
ALTER TABLE qna ADD COLUMN IF NOT EXISTS passwd VARCHAR(100) DEFAULT 'admin' AFTER name; 