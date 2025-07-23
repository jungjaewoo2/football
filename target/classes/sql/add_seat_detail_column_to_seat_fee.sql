-- seat_fee 테이블에 좌석명/금액 정보 저장 컬럼 추가
ALTER TABLE seat_fee ADD COLUMN seat_detail TEXT COMMENT '좌석명/금액 JSON'; 