const db = require('../models');
const User = db.user;
const Post = db.post;
const Comment = db.comment;
const Role = db.role;
const Notification = db.notification;
const Postlike = db.postLike;
const CommentLike = db.commentLike;
const { Op } = require('sequelize');


// display all users (GET)

exports.getAllUsers = (req, res) => {
    User.findAll({
        order: [
            ['createdAt', 'DESC'] // newest user first
        ]
    })
    .then(users => res.status(200).json({ users }))
    .catch(error => res.status(40).json({ error }));
};



// display posts of one user (GET)

/*
exports.getAllPostsOfUser = (req, res) => {

};
*/



// display posts and comments of one user (GET)

/*
exports.getAllPostsAndCommentsOfUser = (req, res) => {

};
*/


// display likes of one user (GET)

/*
exports.getAllLikesOfUser = (req, res) => {

};
*/


// modify user profile (PUT)


exports.modifyUserProfile = (req, res) => {
    const userObject = req.file ? 
    {
        ...req.body.userId,
        user_photo: `${req.protocol}://${req.get("host")}/images/${req.file.filename}`
    } : { ...req.body }
    User.update({ ...userObject, user_id: req.params.userId }, { where: { user_id: req.params.userId } })
    .then(() => res.status(200).json({ message: 'Profil utilisateur modifié !' }))
    .catch(error => res.status(400).json({ error }));
}



// delete user profile (DELETE)

exports.deleteUserAccount = (req, res) => {
    User.destroy({ where: { user_id: req.params.userId } })
    .then(() => res.status(200).json({ message: 'Utilisateur supprimé !' }))
    .catch(error => res.status(400).json({ error }));
};


