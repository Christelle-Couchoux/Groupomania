const db = require('../models');
const User = db.user;
const Post = db.post;
const Comment = db.comment;
const Role = db.role;
const Notification = db.notification;
const Postlike = db.postLike;
const CommentLike = db.commentLike;
const Op = db.sequelize.Op;

// delete a comment (DELETE)

/*
exports.deleteComment = (req, res) => {

};
*/


// display all likes of a comment (GET)

/*
exports.getAllLikesOfComment = (req, res) => {

};
*/


// like or unlike a comment (POST)

/*
exports.LikeComment = (req, res) => {

};


Comment_like.findOne where user_id and comment_like_id
if res, delete like. Destroy where user_id and comment_like_id. truncate?. Return 200 ok, 'Vous n'aimez plus ce message'
else, add like. Comment_like. Create with user_id and comment_like_id. Return 201, 'Vous aimez ce message'


*/
