-- schedule_info 테이블에 category 컬럼 추가
ALTER TABLE schedule_info 
ADD COLUMN category VARCHAR(30) COMMENT '카테고리'; 