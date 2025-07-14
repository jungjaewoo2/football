-- register_ok 컬럼 추가
ALTER TABLE register_schedule 
ADD COLUMN register_ok VARCHAR(1) NOT NULL DEFAULT 'N';

-- 기존 데이터에 대한 기본값 설정
UPDATE register_schedule 
SET register_ok = 'N'
WHERE register_ok IS NULL; 