-- admin 테이블 생성
CREATE TABLE IF NOT EXISTS admin (
    uid INT AUTO_INCREMENT PRIMARY KEY,
    id VARCHAR(50) NOT NULL UNIQUE,
    passwd VARCHAR(255) NOT NULL
);

-- admin 계정 데이터 삽입 (아이디: admin, 비밀번호: 1234)
INSERT INTO admin (id, passwd) VALUES ('admin', '1234'); 