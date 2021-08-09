-- --------------------------------
-- database groupomania
-- --------------------------------
-- create db

CREATE DATABASE groupomania CHARACTER SET 'utf8';

-- run server
--  --> create tables


-- insert roles

INSERT INTO Roles
VALUES (1, 'super_admin', 'For web dev in charge of database.', NOW(), NOW()), 
       (2, 'admin', 'For application admin.', NOW(), NOW()), 
       (3, 'user', 'For standard user.', NOW(), NOW());



-- Users





-- insert admin
INSERT INTO Users (pseudo, email, password, createdAt)
VALUES ('Admin', 'admin@groupomania.fr', 'Group*maniaAdm1n', NOW());


INSERT INTO Users (pseudo, email, password, createdAt)
VALUES ('Chris', 'chris@gmail.com', 'Chr*istelle10', NOW());



INSERT INTO Posts (post_text, fk_user_id, createdAt)
VALUES  ("test 1", 1, NOW()),
        ("test 2", 1, NOW());






-- triggers to fill in table Notification (on comment, comment_like et post_like inserts)

DELIMITER //
CREATE TRIGGER after_insert_comment 
AFTER INSERT ON Comments FOR EACH ROW
BEGIN
    INSERT INTO Notifications (type, fk_recipient_id, fk_sender_id, original_text, created_at)
    SELECT ('comment', Posts.fk_user_id, Comments.fk_user_id, Comments.comment_text, Comments.created_at)
    FROM Comments
    INNER JOIN Posts ON Posts.post_id = Comments.fk_post_id;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER after_insert_comment_likes 
AFTER INSERT ON Comment_likes FOR EACH ROW
BEGIN
    INSERT INTO Notifications (type, fk_recipient_id, fk_sender_id, original_text, createdAt)
    SELECT ('comment_like', Comments.fk_user_id, Comment_likes.fk_user_id, Comments.comment_text, Comment_likes.createdAt )
    FROM Comment_likes
    INNER JOIN Comment ON Comments.comment_id = Comment_likes.fk_comment_id;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER after_insert_post_likes 
AFTER INSERT ON Post_likes FOR EACH ROW
BEGIN
    INSERT INTO Notifications (type, fk_recipient_id, fk_sender_id, original_text, createdAt)
    SELECT ('post_like', Posts.fk_user_id, Post_likes.fk_user_id, Posts.post_text, Post_likes.createdAt)
    FROM Post_likes
    INNER JOIN Posts ON Posts.post_id = Post_likes.fk_post_id;
END //
DELIMITER ;


-- view to select columns needed for requests / frontend display

CREATE VIEW V_Notifications (notification_id, type, seen, recipient_id, sender_name, sender_photo, notification_text, createdAt)
AS SELECT Notifications.notification_id, Notifications.type, Notifications.seen, Notifications.fk_recipient_id, Senders.pseudo, Senders.user_photo, Notifications.original_text, Notifications.createdAt 
FROM Notifications
INNER JOIN Users AS Senders 
ON Notifications.fk_sender_id = Senders.user_id;


-- GET api/notifications
-- procedure view V_Notification to get all notif for specific user (param) and display them in reverse chrono order

DELIMITER //
CREATE PROCEDURE get_notifications(IN p_recipient_id INT)
BEGIN
    SELECT *
    FROM V_Notifications
    WHERE recipient_id = p_recipient_id
    ORDER BY createdAt DESC;
END //
DELIMITER;


-- PUT api/notifications/:notificationId
-- proc on table Notification to change seen value to TRUE for specific notification (param)

-- do in js?
DELIMITER //
CREATE PROCEDURE mark_notification_as_seen(IN p_notification_id INT)
BEGIN
    UPDATE Notification
    SET seen = TRUE
    WHERE notification_id = p_notification_id;
END //
DELIMITER;


-- DELETE api/notifications/:notificationId
-- proc on table Notification to delete specific notification (param)

-- do in js
DELIMITER //
CREATE PROCEDURE delete_notification(IN p_notification_id INT)
BEGIN
    DELETE FROM Notification
    WHERE notification_id = p_notification_id;
END //
DELIMITER;



SELECT * FROM Users;

DESCRIBE Users;
DESCRIBE Posts;

SELECT * FROM Posts;






CREATE VIEW V_Notifications (notification_id, type, seen, recipient_id, sender_name, sender_photo, notification_text, createdAt)
AS SELECT Notifications.notification_id, Notifications.type, Notifications.seen, Notifications.fk_recipient_id, Senders.pseudo, Senders.user_photo, Notifications.original_text, Notifications.createdAt 
FROM Notifications
INNER JOIN Users AS Senders 
ON Notifications.fk_sender_id = Senders.user_id;


-- get all posts
DELIMITER //
CREATE PROCEDURE get_all_posts()
BEGIN
    SELECT Posts.post_id, Posts.post_file, Posts.post_text, Posts.fk_user_id AS user_id, Users.pseudo, Users.user_photo, Posts.createdAt
    FROM Posts
    INNER JOIN Users 
    ON Posts.fk_user_id = Users.user_id;
END //
DELIMITER ;


SELECT Posts.post_id, Posts.post_file, Posts.post_text, Users.user_id, Users.pseudo, Users.user_photo, Posts.createdAt
    FROM Posts
    INNER JOIN Users 
    ON Posts.fk_user_id = Users.user_id;


SELECT Posts.post_id, Posts.post_file, Posts.post_text, Posts.fk_user_id, Users.pseudo, Users.user_photo, Posts.createdAt
    FROM Posts
    INNER JOIN Users 
    ON Posts.fk_user_id = Users.user_id;




DELIMITER //
CREATE PROCEDURE get_all_posts()
BEGIN
    DECLARE v_interval DATETIME;
    IF TIMEDIFF(Posts.createdAt, NOW()) < '0000-00-00 00:01:00' THEN 
        SELECT TIMESTAMPDIFF(SECOND, NOW(), Posts.createdAt) INTO v_interval
    ELSEIF TIMEDIFF(Posts.createdAt, NOW()) < '0000-00-00 01:00:00' THEN 
        SELECT TIMESTAMPDIFF(MINUTE, NOW(), Posts.createdAt) INTO v_interval
    ELSEIF TIMEDIFF(Posts.createdAt, NOW()) < '0000-00-01 00:00:00' THEN 
        SELECT TIMESTAMPDIFF(HOUR, NOW(), Posts.createdAt) INTO v_interval
    ELSEIF TIMEDIFF(Posts.createdAt, NOW()) < '0000-01-00 00:00:00' THEN 
        SELECT TIMESTAMPDIFF(DAY, NOW(), Posts.createdAt) INTO v_interval
    ELSEIF TIMEDIFF(Posts.createdAt, NOW()) < '0001-00-00 00:00:00' THEN 
        SELECT TIMESTAMPDIFF(MONTH, NOW(), Posts.createdAt) INTO v_interval
    ELSEIF TIMEDIFF(Posts.createdAt, NOW()) > '0001-00-00 00:00:00' THEN 
        SELECT TIMESTAMPDIFF(YEAR, NOW(), Posts.createdAt) INTO v_interval;

    SELECT Posts.post_id, Posts.post_file, Posts.post_text, Posts.fk_user_id, Users.pseudo, Users.user_photo, v_interval
    FROM Posts
    INNER JOIN Users 
    ON Posts.fk_user_id = Users.user_id;
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE get_all_posts()
BEGIN
    DECLARE v_interval DATETIME;
    IF TIMEDIFF('2021-08-09 11:33:00', NOW()) < '0000-00-00 00:01:00' THEN 
        SELECT TIMESTAMPDIFF(SECOND, NOW(), '0000-00-00 00:01:00') INTO v_interval
    ELSE 
        SET v_interval = '0000-00-00 00:02:00';

    SELECT Posts.post_id, Posts.post_file, Posts.post_text, Posts.fk_user_id, Users.pseudo, Users.user_photo, v_interval
    FROM Posts
    INNER JOIN Users 
    ON Posts.fk_user_id = Users.user_id;
END //
DELIMITER ;

SELECT TIMEDIFF(NOW(), '2021-08-09 11:33:00');

IF TIMEDIFF(NOW(), '2021-08-09 11:33:00') < '0000-00-00 00:01:00' THEN

SELECT TIMEDIFF(NOW(), '2021-08-09 11:33:00');
    



DROP PROCEDURE get_all_posts_of_user;



DELIMITER //
CREATE PROCEDURE get_all_posts_of_user(IN p_user_id INT)
BEGIN
    SELECT Posts.post_id, Posts.post_file, Posts.post_text, Posts.fk_user_id, Users.pseudo, Users.user_photo, Users.bio, Posts.createdAt
    FROM Posts
    INNER JOIN Users 
    ON Posts.fk_user_id = Users.user_id
    WHERE Posts.fk_user_id = p_user_id;
END //
DELIMITER ;


CALL get_all_posts_of_user(13);




DELIMITER //
CREATE PROCEDURE get_user_info(IN p_user_id INT)
BEGIN
    SELECT Users.pseudo, Users.user_photo, Users.bio, Users.user_id
    FROM Users
    WHERE Users.user_id = p_user_id;
END //
DELIMITER ;

CALL get_user_info(2);

DROP PROCEDURE get_user_info;




UPDATE Users
SET bio='Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
WHERE user_id=2;


UPDATE Users
SET bio='Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.'
WHERE user_id=11;


UPDATE Users
SET bio='Peut supprimer des utilisateurs et des messages.'
WHERE user_id=1;

SELECT * FROM Users;





DELIMITER //
CREATE PROCEDURE delete_user(IN p_user_id INT)
BEGIN
    DELETE FROM Users
    WHERE Users.user_id = p_user_id;
END //
DELIMITER ;

CALL delete_user(2);

SELECT * FROM Users;




SELECT * FROM Posts;


DELIMITER //
CREATE PROCEDURE delete_post(IN p_post_id INT)
BEGIN
    DELETE FROM Posts
    WHERE Posts.post_id = p_post_id;
END //
DELIMITER ;

CALL delete_post(21);




DELIMITER //
CREATE PROCEDURE get_all_posts()
BEGIN
    SELECT Posts.post_id, Posts.post_file, Posts.post_text, Posts.fk_user_id, Users.pseudo, Users.user_photo, Users.bio, Posts.createdAt
    FROM Posts
    INNER JOIN Users 
    ON Posts.fk_user_id = Users.user_id;
END //
DELIMITER ;

CALL get_all_posts();

DROP PROCEDURE get_all_posts;