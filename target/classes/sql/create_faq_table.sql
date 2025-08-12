CREATE TABLE IF NOT EXISTS faq (
    uid INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    notice CHAR(1) NOT NULL DEFAULT 'N',
    regdate DATETIME(6),
    created_at DATETIME(6),
    updated_at DATETIME(6)
); 