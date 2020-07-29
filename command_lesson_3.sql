USE vk;
SHOW TABLES;
SELECT * FROM users LIMIT 10;
UPDATE users SET updated_at = CURRENT_TIMESTAMP WHERE created_at > updated_at;
SELECT * FROM profiles LIMIT 10;
CREATE TEMPORARY TABLE genders (name CHAR(1));
INSERT INTO genders VALUES ('m'), ('f');
UPDATE profiles SET gender = (SELECT name FROM genders ORDER BY RAND() LIMIT 1);
UPDATE profiles SET photo_id = FLOOR(1 + RAND() * 100);
SELECT * FROM messages LIMIT 10;
UPDATE messages SET from_user_id = FLOOR(1 + RAND() * 100);
UPDATE messages SET to_user_id = FLOOR(1 + RAND() * 100);
UPDATE messages SET is_important = FLOOR(1 + RAND() * 2);
UPDATE messages SET is_delivered = FLOOR(1 + RAND() * 2);
SELECT * FROM media LIMIT 10;
TRUNCATE media_types;
INSERT INTO media_types (name) VALUES ('foto'), ('video'), ('audio');
UPDATE media SET media_type_id = FLOOR(1 + RAND() * 3);
UPDATE media SET user_id = FLOOR(1 + RAND() * 100);
CREATE TEMPORARY TABLE extensions (name VARCHAR(10));
INSERT INTO extensions VALUES ('jpeg'), ('mp3'), ('png'), ('avi');
UPDATE media SET filename = CONCAT( 'https://dropbox/vk/', filename, '.', (SELECT name FROM 
extensions ORDER BY RAND() LIMIT 1));
UPDATE media SET size = FLOOR(10000 + RAND() * 100000) WHERE size < 1000;
UPDATE media SET metadata = CONCAT('{"owner":"', (SELECT CONCAT(first_name, ' ', last_name)
FROM users WHERE id = user_id), '"}');

UPDATE friendship SET 
user_id = FLOOR(1 + RAND() * 100),
friend_id = FLOOR(1 + RAND() * 100);
TRUNCATE friendship_statuses;
INSERT INTO friendship_statuses (name) VALUES ('requested'), ('confirmed'), ('rejected');
UPDATE friendship SET status_id = FLOOR(1 + RAND() * 3);
SELECT * FROM friendship LIMIT 10;

CREATE TABLES likes (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Индентификатор строки',
post_id INT, UNSIGNED NOT NULL COMMENT 'ссылка на комментарий',
user_id INT, UNSIGNED NOT NULL COMMENT 'ссылка на на пользователя',
media_id INT, UNSIGNED NOT NULL COMMENT 'ссылка на медиафайл',
created_at DATATIME DEFAULT CURRENT_TIMESTAMP COMMENT 'время создания строки',
updated_at DATATIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
CONSTRAINT post_fk FOREIGN KEY (post_id) REFERENCES users (id),
CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES users (id),  
CONSTRAINT media_fk FOREIGN KEY (media_id) REFERENCES media (id)
) COMMENT 'Лайки';




