-- QNA 테이블 생성
CREATE TABLE IF NOT EXISTS qna (
    uid INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    name VARCHAR(100) NOT NULL,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    notice CHAR(1) NOT NULL DEFAULT 'N',
    regdate DATETIME(6) NOT NULL,
    parent_post_id INT,
    created_at DATETIME(6),
    updated_at DATETIME(6)
); 