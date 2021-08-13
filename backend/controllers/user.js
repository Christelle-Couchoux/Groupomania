const db = require('../models');
const User = db.user;
const Post = db.post;
const Comment = db.comment;
const Role = db.role;
const Notification = db.notification;
const Postlike = db.postLike;
const CommentLike = db.commentLike;
const { Op } = require('sequelize');
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;


// display all users (GET)
// OK

exports.getAllUsers = (req, res) => {
    User.findAll({
        order: [
            ['createdAt', 'DESC'] // newest user first
        ]
    })
    .then(users => res.status(200).json({ users }))
    .catch(error => res.status(40).json({ error }));
    //sequelize.close();
};



// display info of one user (GET)
// OK

exports.getUserInfo = (req, res) => {
    sequelize.query('CALL get_user_info(:userId)',
    {
        replacements: { userId: req.params.userId },
        type: QueryTypes.SELECT 
    })
    .then(([info, metadata]) => { return res.status(200).json({ info }) })
    .catch((error) => res.status(400).json(error));
    //sequelize.close();
};



// display posts of one user (GET)
// OK

exports.getAllPostsOfUser = (req, res) => {
    sequelize.query('CALL get_all_posts_of_user_with_comments_and_likes_counts(:userId)', 
    {
        replacements: { userId: req.params.userId },
        type: QueryTypes.SELECT 
    })
    .then(([posts, metadata]) => {
        return res.status(200).json({ posts })
    })
    .catch((error) => res.status(400).json(error));
    //sequelize.close();
};



// display comments of one user (GET)
//OK

exports.getAllCommentsOfUser = (req, res) => {
    sequelize.query('CALL get_all_comments_of_user(:userId)', 
    {
        replacements: { userId: req.params.userId },
        type: QueryTypes.SELECT 
    })
    .then(([comments, metadata]) => {
        return res.status(200).json({ comments })
    })
    .catch((error) => res.status(400).json(error));
    //sequelize.close();
};



// display likes of one user (GET)

/*
exports.getAllLikesOfUser = (req, res) => {

};
*/



// modify user profile (PUT)
// OK

exports.modifyUserProfile = (req, res) => {
    const userObject = req.file ? 
    {
        ...req.body.userId,
        bio: req.body.bio,
        user_photo: `${req.protocol}://${req.get("host")}/images/${req.file.filename}`
    } : { ...req.body }
    User.update({ ...userObject, user_id: req.params.userId }, { where: { user_id: req.params.userId } })
    .then(() => res.status(200).json({ message: 'Profil utilisateur modifié !' }))
    .catch(error => res.status(400).json({ error }));
    //sequelize.close();
}


// delete user account (DELETE)
// OK

exports.deleteUserAccount = (req, res) => {
    User.destroy({ where: { user_id: req.params.userId } })
    .then(() => res.status(200).json({ message: 'Utlisateur supprimé !' }))
    .catch(error => res.status(400). json({ error }));
    //sequelize.close();
};
