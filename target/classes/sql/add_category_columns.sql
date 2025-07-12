-- schedule_info 테이블에 홈팀 카테고리와 원정팀 카테고리 컬럼 추가
ALTER TABLE schedule_info 
ADD COLUMN home_category VARCHAR(100) COMMENT '홈팀 카테고리',
ADD COLUMN other_category VARCHAR(100) COMMENT '원정팀 카테고리'; 