-- --------------------------------
-- database groupomania
-- --------------------------------

CREATE DATABASE groupomania CHARACTER SET 'utf8';


-- --------------------------------
-- ROLES
-- --------------------------------

-- table Role

DROP TABLE IF EXISTS Role;

CREATE TABLE Role (
    role_id TINYINT(1) UNSIGNED AUTO_INCREMENT,
    role_name VARCHAR(20) NOT NULL,
    role_description TINYTEXT,
    PRIMARY KEY (role_id)
) ENGINE=INNODB;


-- insert roles

LOCK TABLES Role;

INSERT INTO Role
VALUES (1, 'super_admin', 'For web dev in charge of database.'), 
       (2, 'admin', 'For application admin.'), 
       (3, 'user', 'For standard user.');

UNLOCK TABLES;



-- --------------------------------
-- USERS
-- --------------------------------

-- table User

DROP TABLE IF EXISTS User;

CREATE TABLE User (
    user_id SMALLINT(4) UNSIGNED AUTO_INCREMENT,
    pseudo VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(20) NOT NULL, 
    user_photo VARCHAR(50) DEFAULT 'http://127.0.0.1:3000/images/default-user-icon.jpg',
    bio TINYTEXT,
    created_at DATETIME NOT NULL,
    fk_user_role TINYINT(1) UNSIGNED NOT NULL DEFAULT 3,
    PRIMARY KEY (user_id),
    FOREIGN KEY (fk_user_role) REFERENCES Role(role_id),
    INDEX user_first_name (first_name),
    INDEX user_last_name (last_name),
    INDEX user_created_at (created_at)
) ENGINE=INNODB;



-- --------------------------------
-- POSTS
-- --------------------------------

-- table Post

DROP TABLE IF EXISTS Post;

CREATE TABLE Post (
    post_id INT UNSIGNED AUTO_INCREMENT,
    post_file VARCHAR(50),
    post_text TINYTEXT,
    created_at DATETIME NOT NULL,
    fk_user_id SMALLINT(4) UNSIGNED NOT NULL,
    PRIMARY KEY (post_id),
    FOREIGN KEY (fk_user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    INDEX post_created_at (created_at)
) ENGINE=INNODB;



-- --------------------------------
-- COMMENTS
-- --------------------------------

-- table Comment

DROP TABLE IF EXISTS Comment;

CREATE TABLE Comment (
    comment_id INT UNSIGNED AUTO_INCREMENT,
    comment_text TINYTEXT,
    created_at DATETIME NOT NULL,
    fk_user_id SMALLINT(4) NOT NULL,
    fk_post_id INT NOT NULL,
    PRIMARY KEY (comment_id),
    FOREIGN KEY (fk_user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (fk_post_id) REFERENCES Post(post_id) ON DELETE CASCADE,
    INDEX comment_created_at (created_at),
) ENGINE=INNODB;



-- --------------------------------
-- POST LIKES
-- --------------------------------

-- table Post_like

DROP TABLE IF EXISTS Post_like;

CREATE TABLE Post_like (
    post_like_id INT UNSIGNED AUTO_INCREMENT,
    created_at DATETIME NOT NULL,
    fk_user_id SMALLINT(4) NOT NULL,
    fk_post_id INT NOT NULL,
    PRIMARY KEY (post_like_id),
    FOREIGN KEY (fk_user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (fk_post_id) REFERENCES Post(post_id) ON DELETE CASCADE,
    INDEX Post_like_created_at (created_at),
) ENGINE=INNODB;



-- --------------------------------
-- COMMENT LIKES
-- --------------------------------

-- table Comment_like

DROP TABLE IF EXISTS Comment_like;

CREATE TABLE Comment_like (
    comment_like_id INT UNSIGNED AUTO_INCREMENT,
    created_at DATETIME NOT NULL,
    fk_user_id SMALLINT(4) NOT NULL,
    fk_comment_id INT NOT NULL,
    PRIMARY KEY (comment_like_id),
    FOREIGN KEY (fk_user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (fk_comment_id) REFERENCES Comment(comment_id) ON DELETE CASCADE,
    INDEX comment_like_created_at (created_at),
) ENGINE=INNODB;



-- --------------------------------
-- NOTIFICATIONS
-- --------------------------------

-- table Notification

DROP TABLE IF EXISTS Notification;

CREATE TABLE Notification (
    notification_id INT UNSIGNED AUTO_INCREMENT,
    type VARCHAR(12) NOT NULL,
    seen BOOLEAN NOT NULL DEFAULT FALSE,
    fk_recipient_id SMALLINT(4) NOT NULL,
    fk_sender_id SMALLINT(4) NOT NULL,
    original_text TINYTEXT,
    original_file VARCHAR(50),
    created_at DATETIME NOT NULL,
    PRIMARY KEY (notification_id),
    FOREIGN KEY (fk_recipient_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (fk_sender_id) REFERENCES User(user_id) ON DELETE CASCADE,
    INDEX notification_created_at (created_at),
) ENGINE=INNODB;


-- triggers to fill in table Notification (on comment, comment_like et post_like inserts)

DELIMITER //
CREATE TRIGGER after_insert_comment 
AFTER INSERT ON Comment FOR EACH ROW
BEGIN
    INSERT INTO Notification (type, fk_recipient_id, fk_sender_id, original_text, created_at)
    SELECT ('comment', Post.fk_user_id, Comment.fk_user_id, Comment.comment_text, Comment.created_at)
    FROM Comment
    INNER JOIN Post ON Post.post_id = Comment.fk_post_id;
END //
DELIMITER;

DELIMITER //
CREATE TRIGGER after_insert_comment_like 
AFTER INSERT ON Comment_like FOR EACH ROW
BEGIN
    INSERT INTO Notification (type, fk_recipient_id, fk_sender_id, original_text, created_at)
    SELECT ('comment_like', Comment.fk_user_id, Comment_like.fk_user_id, Comment.comment_text, Comment_like.created_at )
    FROM Comment_like
    INNER JOIN Comment ON Comment.comment_id = Comment_like.fk_comment_id;
END //
DELIMITER;

DELIMITER //
CREATE TRIGGER after_insert_post_like 
AFTER INSERT ON Post_like FOR EACH ROW
BEGIN
    INSERT INTO Notification (type, fk_recipient_id, fk_sender_id, original_text, original_file, created_at)
    SELECT ('post_like', Post.fk_user_id, Post_like.fk_user_id, Post.post_text, Post.post_file, Post_like.created_at)
    FROM Post_like
    INNER JOIN Post ON Post.post_id = Post_like.fk_post_id;
END //
DELIMITER;


-- view to select columns needed for requests / frontend display

CREATE VIEW V_Notification (notification_id, type, seen, recipient_id, sender_name, notification_text, notification_file, created_at)
AS SELECT Notification.notification_id, Notification.type, Notification.seen, Notification.fk_recipient_id,
          Sender.pseudo, Notification.original_text, Notification.original_file, 
FROM Notification
INNER JOIN User AS Sender ON Notification.fk_sender_id = Sender.user_id;


-- GET api/notifications
-- procedure view V_Notification to get all notif for specific user (param) and display them in reverse chrono order

DELIMITER //
CREATE PROCEDURE get_notifications(IN p_recipient_id INT)
BEGIN
    SELECT *
    FROM V_Notification
    WHERE recipient_id = p_recipient_id
    ORDER BY created_at DESC;
END //
DELIMITER;


-- PUT api/notifications/:notificationId
-- proc on table Notification to change seen value to TRUE for specific notification (param)

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

DELIMITER //
CREATE PROCEDURE delete_notification(IN p_notification_id INT)
BEGIN
    DELETE FROM Notification
    WHERE notification_id = p_notification_id;
END //
DELIMITER;

