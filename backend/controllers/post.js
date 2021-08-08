const db = require('../models');
const post = require('../models/post');
const User = db.user;
const Post = db.post;
const Comment = db.comment;
const Role = db.role;
const Notification = db.notification;
const Postlike = db.postLike;
const CommentLike = db.commentLike;
const Op = db.sequelize.Op;


// display all posts (GET)

exports.getAllPosts = (req, res) => {
    Post.findAll({
        include: [
            { // add comments and likes
                model: User,
                attributes: ['pseudo', 'user_photo', 'user_id']
            },
        ],
        order: [
            ['post_id', 'DESC']
        ]
    })
    .then(posts => {
        const Posts = [];
        posts.forEach((post) =>
            Posts.push( {
                id: post.post_id,
                file:post.post_file,
                text: post.post_text,
                userId: post.User.user_id,
                pseudo: post.User.pseudo,
                userPhoto: post.User.user_photo,
                createdAt: post.createdAt
            })
        );
        return res.status(200).json({ Posts })
    })
    .catch((error) => res.status(400).json(error));
};


// add a new post (POST)

exports.createPost = (req, res) => {
    let uploadedPhoto =''
    if(req.file) {
        uploadedPhoto = `${req.protocol}://${req.get("host")}/images/${req.file.filename}` 
    }
    Post.create({
        fk_user_id: req.body.userId,
        post_file: uploadedPhoto,
        post_text: req.body.text,
    })
    .then(() => 
        res.status(201).json({ message: 'Message créé !' })
    )
    .catch(error => res.status(400).json({ error }));    
};


// display a post (GET)

/*
exports.getOnePost = (req, res) => {

};
*/


// delete a post (DELETE)

/*
exports.deletePost = (req, res) => {

};
*/


// display all likes of a post (GET)

/*
exports.getAllLikesOfPost = (req, res) => {

};
*/


// like or unlike a post (POST)

/*
exports.LikePost = (req, res) => {

};
*/


// display all comments of a post (GET)

/*
exports.getAllCommentsOfPost = (req, res) => {

};
*/


// add a new comment (POST)

/*
exports.createComment = (req, res) => {

};
*/
