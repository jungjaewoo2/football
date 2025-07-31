-- Add category column to schedule_info table
ALTER TABLE schedule_info ADD COLUMN category VARCHAR(50) AFTER game_category; 