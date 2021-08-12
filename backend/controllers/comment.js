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
// OK

exports.deleteComment = (req, res) => {
    Comment.destroy({ where: { comment_id: req.params.commentId } })
    .then(() => res.status(200).json({ message: 'Commentaire supprimé !' }))
    .catch(error => res.status(400). json({ error }));
    //sequelize.close();
};



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
