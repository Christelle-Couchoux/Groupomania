const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const db = require('../models');
const User = db.user;
const Post = db.post;
const Comment = db.comment;
const Role = db.role;
const Notification = db.notification;
const Postlike = db.postLike;
const CommentLike = db.commentLike;
const Op = db.sequelize.Op;


// create new user (POST)
// OK

exports.signup = (req, res) => {
    // create admin if not exists
    if (User.length === 0) {
        bcrypt.hash(process.env.ADMIN_PASSWORD, 10)
        .then(hash => {
            User.create({
                pseudo: process.env.ADMIN_PSEUDO,
                email: process.env.ADMIN_EMAIL,
                password: hash,
                fk_user_role: "admin",
            })
        })
    };

    // create new user
    User.findOne({
        where: { email: req.body.email }, // search for user with same email address in db
    })
    .then(user => {
        if(user) { //if user with same email in db
            return res.status(400).json({ error: 'Cette adresse email est déjà utilisée !' });
        } else { //if email address not found in db
            User.findOne({
                where: { pseudo: req.body.pseudo }, // search for user with same pseudo in db
            })
            .then(user => {
                if(user) { // if user with same pseudo in db
                    return res.status(400).json({ error: 'Ce pseudo est déjà utilisé !' });
                } else { // if pseudo not found in db
                    // hash password
                    bcrypt.hash(req.body.password, 10)
                    .then(hash => {
                        // create new user
                        User.create({
                            pseudo: req.body.pseudo,
                            email: req.body.email,
                            password: hash
                        })
                        .then(user => // return
                            res.status(201).json({
                                message: 'Utilisateur créé !',
                                userId: user.user_id, 
                                role: user.fk_user_role,
                                pseudo: user.pseudo,
                                photo: user.user_photo,
                                token: jwt.sign(
                                    { userId: user.user_id }, process.env.RND_TKN, { expiresIn: '24h' }
                                )
                            })
                        )
                        .catch(error => res.status(500).json({ error }));
                    })
                    .catch(error => res.status(500).json({ error }));
                }
            })
            .catch(error => res.status(500).json({ error }));
        }
    })
    .catch(error => res.status(500).json({ error }));
    //sequelize.close();
};



// connect existing user (POST)
// OK

exports.login = (req, res) => {
    User.findOne({
        where: { email: req.body.email }, // search for user with same email address in db
    })
    .then(user => {
        // if user not found in db
        if (!user) {
            return res.status(401).json({ error: 'Utilisateur non trouvé !' });
        }
        // if user found
        // compare hashes to check if they come from the same string (password)
        bcrypt.compare(req.body.password, user.password)
        .then(valid => {
            // if they don't match
            if(!valid) {
                return res.status(401).json({ error: 'Mot de passe incorrect !' });
            }
            // if they match
            res.status(200).json({ // return
                message: 'Utilisateur connecté !',
                userId: user.user_id, 
                role: user.fk_user_role,
                pseudo: user.pseudo,
                photo: user.user_photo,
                token: jwt.sign(
                    { userId: user.user_id }, process.env.RND_TKN, { expiresIn: '24h' }
                )
            });
        })
        .catch(error => res.status(500).json({ error }));
    })
    .catch(error => res.status(500).json({ error }));
    //sequelize.close();
};
