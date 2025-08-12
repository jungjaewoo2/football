CREATE TABLE IF NOT EXISTS ticket_link (
    uid INT AUTO_INCREMENT PRIMARY KEY,
    ticket_name VARCHAR(255) NOT NULL,
    ticket_sub_title VARCHAR(255),
    ticket_img VARCHAR(500),
    content TEXT
); 