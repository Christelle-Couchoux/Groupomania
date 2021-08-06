const db = require('../models');
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
    Post.findAll()
    .then(data => {
        res.send(data);
    })
    .catch((error) => res.status(500).json(error));
};



// add a new post (POST)
/*

exports.createPost = (req, res) => {

};
*/


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
