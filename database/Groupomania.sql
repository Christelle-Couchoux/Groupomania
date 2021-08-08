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

CREATE VIEW V_Notifications (notification_id, type, seen, recipient_id, sender_name, notification_text, createdAt)
AS SELECT Notifications.notification_id, Notifications.type, Notifications.seen, Notifications.fk_recipient_id, Senders.pseudo, Notifications.original_text, Notifications.createdAt 
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
