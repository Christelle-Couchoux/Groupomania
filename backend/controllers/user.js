const db = require('../models');
const User = db.user;
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

    async () => {
        await sequelize.close();
    };
};



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

    async () => {
        await sequelize.close();
    };
};



// delete user account (DELETE)
// OK

exports.deleteUserAccount = (req, res) => {
    User.destroy({ where: { user_id: req.params.userId } })
    .then(() => res.status(200).json({ message: 'Compte utilisateur supprimé !' }))
    .catch(error => res.status(400). json({ error }));

    async () => {
        await sequelize.close();
    };
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

    async () => {
        await sequelize.close();
    };
};



// display posts of one user (GET)
// OK

exports.getAllPostsOfUser = (req, res) => {
    sequelize.query('CALL get_all_posts_of_user(:userId)', 
    {
        replacements: { userId: req.params.userId },
        type: QueryTypes.SELECT 
    })
    .then(([posts, metadata]) => {
        return res.status(200).json({ posts })
    })
    .catch((error) => res.status(400).json(error));

    async () => {
        await sequelize.close();
    };
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

    async () => {
        await sequelize.close();
    };
};



// display posts liked by one user (GET)
// OK

exports.getAllLikesOfUser = (req, res) => {
    sequelize.query('CALL get_all_likes_of_user(:userId)', 
    {
        replacements: { userId: req.params.userId },
        type: QueryTypes.SELECT 
    })
    .then(([likedPosts, metadata]) => {
        return res.status(200).json({ likedPosts })
    })
    .catch((error) => res.status(400).json(error));

    async () => {
        await sequelize.close();
    };
};
