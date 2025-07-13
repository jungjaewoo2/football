-- gallery 테이블에 ref 컬럼 추가
ALTER TABLE gallery ADD COLUMN ref INT DEFAULT 0;

-- 기존 데이터의 ref 값을 0으로 설정
UPDATE gallery SET ref = 0 WHERE ref IS NULL; 