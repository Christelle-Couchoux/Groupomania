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
