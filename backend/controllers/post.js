const db = require('../models');
const post = require('../models/post');
const User = db.user;
const Post = db.post;
const Comment = db.comment;
const Role = db.role;
const Notification = db.notification;
const Post_like = db.post_like;
const Op = db.sequelize.Op;
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;
const fs = require("fs");


// display all posts (GET)
// OK

exports.getAllPosts = (req, res) => {
    sequelize.query('CALL get_all_posts_with_counts()', { type: QueryTypes.SELECT })
    .then(([posts, metadata]) => {
        return res.status(200).json({ posts })
    })
    .catch((error) => res.status(400).json(error));
    //sequelize.close();
}



// add a new post (POST)
// OK

exports.createPost = (req, res) => {
    //req.socket.setTimeout(10 * 60 * 1000);
    let fileURL = ''
    if(req.file) {
        fileURL = `${req.protocol}://${req.get('host')}/images/${req.file.filename}`
    };
    console.log(fileURL);
    
    sequelize.query('CALL create_post(:file, :text, :userId)',
    {
        replacements: { 
            file: fileURL,
            text: req.body.text,
            userId: req.body.userId
        },
        type: QueryTypes.INSERT
    })
    .then(() => res.status(201).json({ message: 'Message créé !' }))
    .catch(err => {
        if(err.request){ console.log(err.request) }
        if(err.response){ console.log(err.response) }
    });
    //sequelize.close();
};




// display a post (GET)
// OK

exports.getOnePost = (req, res) => {
    sequelize.query('CALL get_one_post_with_counts(:postId)',
    {
        replacements: { postId: req.params.postId },
        type: QueryTypes.SELECT 
    })
    .then(([post, metadata]) => { return res.status(200).json({ post }) })
    .catch((error) => res.status(400).json(error));
    //sequelize.close();
};



// display all comments of a post (GET)
// OK

exports.getAllCommentsOfPost = (req, res) => {
    sequelize.query('CALL get_comments_of_post(:postId)',
    {
        replacements: { postId: req.params.postId },
        type: QueryTypes.SELECT 
    })
    .then(([comments, metadata]) => { return res.status(200).json({ comments }) })
    .catch((error) => res.status(400).json(error));
    //sequelize.close();
};



// add a new comment (POST)
// OK
// doesn't work with auth ???????
/*
exports.createComment = (req, res) => {
    sequelize.query('CALL create_comment(:userId, :postId, :text)',
    {
        replacements: {
            userId: req.body.userId,
            postId: req.body.postId,
            text: req.body.text
        },
        type: QueryTypes.INSERT
    })
    .then(() => res.status(201).json({ message: 'Commentaire créé !' }))
    .catch(err => {
        if(err.request){ console.log(err.request) }
        if(err.response){ console.log(err.response) }
    });
    //sequelize.close();
};
*/

exports.createComment = (req, res) => {
    Comment.create({
        fk_user_id: req.body.userId,
        fk_post_id: req.body.postId,
        comment_text: req.body.text,
    })
    .then(() => res.status(201).json({ message: 'Commentaire créé !' }))
    .catch(error => res.status(400).json({ error }));
    //sequelize.close();  
};





// delete a post (DELETE)
// OK

exports.deletePost = (req, res) => {
    Post.findOne({ where: { post_id: req.params.postId }})
    .then(post => {
        const filename = post.post_file.split('/images/')[1];
        fs.unlink(`images/${ filename }`, () => {
            Post.destroy({ where: { post_id: req.params.postId } })
            .then(() => res.status(200).json({ message: 'Message supprimé !' }))
            .catch(error => res.status(400). json({ error }));
        });
    })
    .catch(error => {
        //res.status(500).json({ error })
        console.log(error)
    });
};



// like or unlike a post (POST)


exports.likePost = (req, res) => {
    Post_like.findOne({
        where: { 
            fk_post_id: req.params.postId,
            fk_user_id: req.body.userId
        }
    })
    .then((liked) => {
        console.log(liked);
        if(liked) {
            liked.destroy()
            .then(() => res.status(200).json({ message: 'J\'aime supprimé !' }))
            .catch(error => res.status(400). json({ error }));
        } else {
            Post_like.create( {
                fk_post_id: req.params.postId,
                fk_user_id: req.body.userId
            })
            .then(() => res.status(200).json({ message: 'J\'aime ajouté !' }))
            .catch(error => res.status(400). json({ error }));
        }
    })
    .catch(error => {
        res.status(500). json({ error })
        console.log(error)
    });
};