-- seat_image 컬럼명을 img로 변경
ALTER TABLE schedule_info CHANGE seat_image img VARCHAR(500) DEFAULT NULL;

-- 기존 데이터에 대한 기본 이미지 설정 (선택사항)
-- UPDATE schedule_info SET seat_image = 'assets/images/img/all.jpg' WHERE seat_image IS NULL; 