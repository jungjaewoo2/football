-- 예약상태, 결제상태, 승인상태 컬럼 추가
ALTER TABLE register_schedule 
ADD COLUMN reservation_status VARCHAR(20) NOT NULL DEFAULT '예약대기',
ADD COLUMN payment_status VARCHAR(20) NOT NULL DEFAULT '결제대기',
ADD COLUMN approval_status VARCHAR(20) NOT NULL DEFAULT '미승인';

-- 기존 데이터에 대한 기본값 설정
UPDATE register_schedule 
SET reservation_status = '예약대기',
    payment_status = '결제대기',
    approval_status = '미승인'
WHERE reservation_status IS NULL 
   OR payment_status IS NULL 
   OR approval_status IS NULL; 