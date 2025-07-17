-- team_info 테이블에 좌석 이미지 데이터 업데이트
UPDATE team_info SET seat_img = 'seat_b4ef9b04-328e-4f27-ac0f-56d325812cfb.jpg' WHERE team_name = 'Manchester United';
UPDATE team_info SET seat_img = 'seat_6bd1ccdb-a93a-4817-8770-67522733da1c.jpg' WHERE team_name = 'Liverpool';
UPDATE team_info SET seat_img = 'seat_37759646-2db4-4499-b0a9-e87af91bef29.jpg' WHERE team_name = 'Arsenal';
UPDATE team_info SET seat_img = 'seat_03622734-0aba-4f54-bd58-87af557ec13b.jpg' WHERE team_name = 'Real Madrid';
UPDATE team_info SET seat_img = 'seat_e420292e-29ee-4eaa-b057-b43969215bf9.jpg' WHERE team_name = 'Barcelona';
UPDATE team_info SET seat_img = 'seat_980264e1-ae34-4fdc-bcb8-a094e6bef429.jpg' WHERE team_name = 'Bayern Munich';
UPDATE team_info SET seat_img = 'seat_b4ef9b04-328e-4f27-ac0f-56d325812cfb.jpg' WHERE team_name = 'Borussia Dortmund';
UPDATE team_info SET seat_img = 'seat_6bd1ccdb-a93a-4817-8770-67522733da1c.jpg' WHERE team_name = 'Paris Saint-Germain';
UPDATE team_info SET seat_img = 'seat_37759646-2db4-4499-b0a9-e87af91bef29.jpg' WHERE team_name = 'England National Team';

-- 추가 팀들에 대한 좌석 이미지 설정
INSERT IGNORE INTO team_info (team_name, category_name, stadium, city, seat_img) VALUES
('Manchester City', 'EPL', 'Etihad Stadium', 'Manchester', 'seat_03622734-0aba-4f54-bd58-87af557ec13b.jpg'),
('Chelsea', 'EPL', 'Stamford Bridge', 'London', 'seat_e420292e-29ee-4eaa-b057-b43969215bf9.jpg'),
('Tottenham Hotspur', 'EPL', 'Tottenham Hotspur Stadium', 'London', 'seat_980264e1-ae34-4fdc-bcb8-a094e6bef429.jpg'),
('Atletico Madrid', 'L.Liga', 'Wanda Metropolitano', 'Madrid', 'seat_b4ef9b04-328e-4f27-ac0f-56d325812cfb.jpg'),
('Sevilla', 'L.Liga', 'Ramón Sánchez Pizjuán', 'Seville', 'seat_6bd1ccdb-a93a-4817-8770-67522733da1c.jpg'),
('RB Leipzig', 'B.Liga', 'Red Bull Arena', 'Leipzig', 'seat_37759646-2db4-4499-b0a9-e87af91bef29.jpg'),
('Bayer Leverkusen', 'B.Liga', 'BayArena', 'Leverkusen', 'seat_03622734-0aba-4f54-bd58-87af557ec13b.jpg'); 