const db = require('../models');
const Comment = db.comment;


// delete a comment (DELETE)

exports.deleteComment = (req, res) => {
    Comment.destroy({ where: { comment_id: req.params.commentId } })
    .then(() => res.status(200).json({ message: 'Commentaire supprimé !' }))
    .catch(error => res.status(400). json({ error }));

    async () => {
        await sequelize.close();
    };
};
