-- gallery 테이블에 img 컬럼 추가
ALTER TABLE gallery ADD COLUMN img VARCHAR(255) NULL COMMENT '이미지 파일명'; 