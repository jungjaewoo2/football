-- qna 테이블에 passwd 컬럼 추가
ALTER TABLE qna ADD COLUMN passwd VARCHAR(100) NOT NULL DEFAULT ''; 