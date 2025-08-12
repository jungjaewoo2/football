-- Add missing columns to schedule_info table
ALTER TABLE schedule_info ADD COLUMN category VARCHAR(50) AFTER game_category;
ALTER TABLE schedule_info ADD COLUMN seat_price TEXT AFTER fee;
ALTER TABLE schedule_info ADD COLUMN seat_etc TEXT AFTER seat_price;
ALTER TABLE schedule_info ADD COLUMN img VARCHAR(255) AFTER seat_etc;
ALTER TABLE schedule_info ADD COLUMN seat_img VARCHAR(255) AFTER img;
ALTER TABLE schedule_info ADD COLUMN seat_img1 VARCHAR(255) AFTER seat_img; 