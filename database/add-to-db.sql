-- add to db after it's created by sequelize

-- roles
INSERT INTO Roles
VALUES (1, 'super_admin', 'For web dev in charge of database.', NOW(), NOW()), 
       (2, 'admin', 'For application admin.', NOW(), NOW()), 
       (3, 'user', 'For standard user.', NOW(), NOW());



-- notifications

--triggers
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


-- view
CREATE VIEW V_Notifications (notification_id, type, seen, recipient_id, sender_name, sender_photo, notification_text, createdAt)
AS SELECT Notifications.notification_id, Notifications.type, Notifications.seen, Notifications.fk_recipient_id, Senders.pseudo, Senders.user_photo, Notifications.original_text, Notifications.createdAt 
FROM Notifications
INNER JOIN Users AS Senders 
ON Notifications.fk_sender_id = Senders.user_id;


-- get all posts



DELIMITER //
CREATE PROCEDURE get_all_posts()
BEGIN
    SELECT Posts.post_id, Posts.post_file, Posts.post_text, Posts.fk_user_id, Users.pseudo, Users.user_photo, Posts.createdAt
    FROM Posts
    INNER JOIN Users 
    ON Posts.fk_user_id = Users.user_id
    ORDER BY Posts.createdAt DESC;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE get_all_posts_of_user(IN p_user_id INT)
BEGIN
    SELECT Posts.post_id, Posts.post_file, Posts.post_text, Posts.fk_user_id, Users.pseudo, Users.user_photo, Users.bio, Posts.createdAt
    FROM Posts
    INNER JOIN Users 
    ON Posts.fk_user_id = Users.user_id
    WHERE Posts.fk_user_id = p_user_id
    ORDER BY Posts.createdAt DESC;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE get_user_info(IN p_user_id INT)
BEGIN
    SELECT Users.pseudo, Users.user_photo, Users.bio, Users.user_id
    FROM Users
    WHERE Users.user_id = p_user_id;
END //
DELIMITER ;


SET lc_time_names='fr_FR';