const db = require('../models');
const Post = db.post;
const Comment = db.comment;
const Post_like = db.post_like;
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;
const fs = require("fs");


// display all posts (GET)
// OK

exports.getAllPosts = (req, res) => {
    sequelize.query('CALL get_all_posts()', { type: QueryTypes.SELECT })
    .then(([posts, metadata]) => {
        return res.status(200).json({ posts })
    })
    .catch((error) => res.status(400).json(error));
}



// add a new post (POST)
// OK

exports.createPost = (req, res) => {
    let fileURL = ''
    if(req.file) {
        fileURL = `${req.protocol}://${req.get('host')}/images/${req.file.filename}`
    };
    
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
        res.status(500).json({ error })
        console.log(error)
    });
};



// display one post (GET)
// OK

exports.getOnePost = (req, res) => {
    sequelize.query('CALL get_one_post(:postId)',
    {
        replacements: { postId: req.params.postId },
        type: QueryTypes.SELECT 
    })
    .then(([post, metadata]) => { return res.status(200).json({ post }) })
    .catch((error) => res.status(400).json(error));
};



// add a new comment (POST)
// OK
// doesn't work with auth ???????

exports.createComment = (req, res) => {
    Comment.create({
        fk_user_id: req.body.userId,
        fk_post_id: req.body.postId,
        comment_text: req.body.text,
    })
    .then(() => res.status(201).json({ message: 'Commentaire créé !' }))
    .catch(error => res.status(400).json({ error }));
};


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
};
*/



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
};



// like or unlike a post (POST)
// OK
// doesn't work with auth ???????

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



// display if user liked a post (GET)
// OK

exports.getUserLiked = (req, res) => {
    Post_like.findOne({
        where: { 
            fk_post_id: req.params.postId,
            fk_user_id: req.params.userId
        }
    })
    .then((liked) => {
        console.log(liked);
        if(liked) {
            return res.status(200).json("true")
        } else {
            return res.status(200).json("false")
        }
    })
    .catch(error => {
        res.status(500). json({ error })
        console.log(error)
    });
};



// display number of likes of a post (GET)
// OK

exports.getLikesCountOfPost = (req, res) => {
    sequelize.query('CALL get_likes_count_of_one_post(:postId)',
    {
        replacements: { postId: req.params.postId },
        type: QueryTypes.SELECT 
    })
    .then(([likes, metadata]) => { return res.status(200).json({ likes }) })
    .catch((error) => res.status(400).json(error));
};



// display number of comments of a post (GET)
// OK

exports.getCommentsCountOfPost = (req, res) => {
    sequelize.query('CALL get_comments_count_of_one_post(:postId)',
    {
        replacements: { postId: req.params.postId },
        type: QueryTypes.SELECT 
    })
    .then(([commentsCount, metadata]) => { return res.status(200).json({ commentsCount }) })
    .catch((error) => res.status(400).json(error));
};
