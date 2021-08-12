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
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;


// display all posts (GET)
// OK
/*
exports.getAllPosts = (req, res) => {
    sequelize.query('CALL get_all_posts()', { type: QueryTypes.SELECT })
    .then(([posts, metadata]) => {
        return res.status(200).json({ posts })
    })
    .catch((error) => res.status(400).json(error));
    //sequelize.close();
}
*/
/*
exports.getAllPosts = (req, res) => {
    sequelize.query('CALL get_all_posts_with_comments_count()', { type: QueryTypes.SELECT })
    .then(([posts, metadata]) => {
        return res.status(200).json({ posts })
    })
    .catch((error) => res.status(400).json(error));
    //sequelize.close();
}
*/

exports.getAllPosts = (req, res) => {
    sequelize.query('CALL get_all_posts_with_comments_and_likes_counts()', { type: QueryTypes.SELECT })
    .then(([posts, metadata]) => {
        return res.status(200).json({ posts })
    })
    .catch((error) => res.status(400).json(error));
    //sequelize.close();
}


/* include doesn't work

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
*/



// add a new post (POST)
// image is displayed and saved
// req is sent but not recorded in db
// req without image is ok

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
        if(fileURL) { console.log(fileURL) }
    });
    //sequelize.close();
};



/*
exports.createPost = (req, res) => {
    let fileURL ='';
    if(req.file) {
        fileURL = `${req.protocol}://${req.get("host")}/images/${req.file.filename}` 
    }
    Post.create({
        post_file: fileURL,
        post_text: req.body.text,
        fk_user_id: req.body.userId,
    })
    .then(() => res.status(201).json({ message: 'Message créé !' }))
    .catch(err => {
        if(err.request){ console.log(err.request) }
        if(err.response){ console.log(err.response) }
        if(fileURL) { console.log(fileURL) }
    });    
};
*/



/*
exports.createPost = (req, res) => {
    if(!req.file) {
        Post.create( {
            post_file: '',
            post_text: req.body.text,
            fk_user_id: req.body.userId
        })
        .then(() => res.status(201).json({ message: 'Message créé !' }))
        .catch(error => res.status(400).json({ error })); 
    } else if(req.file) {
        let fileURL = `${req.protocol}://${req.get('host')}/images/${req.file.filename}`
        Post.create( {
            post_file: fileURL,
            post_text: req.body.text,
            fk_user_id: req.body.userId
        })
        .then(() => res.status(201).json({ message: 'Message créé !' }))
        .catch(error => res.status(400).json({ error })); 
    } 
};
*/



/*
exports.createPost = (req, res) => {
    if(!req.file) {
        Post.create( {
            post_file: '',
            post_text: req.body.text,
            fk_user_id: req.body.userId
        })
        .then(() => res.status(201).json({ message: 'Message créé !' }))
        .catch(error => res.status(400).json({ error })); 
    } else if(req.file) {
        let fileURL = `${req.protocol}://${req.get('host')}/images/${req.file.filename}`
        Post.create( {
            post_file: fileURL,
            post_text: req.body.text,
            fk_user_id: req.body.userId
        })
        .then(() => res.status(201).json({ message: 'Message créé !' }))
        .catch(error => res.status(400).json({ error })); 
    } 
};
*/





// display a post (GET)
// OK

exports.getOnePost = (req, res) => {
    sequelize.query('CALL get_one_post(:postId)',
    {
        replacements: { postId: req.params.postId },
        type: QueryTypes.SELECT 
    })
    .then(([post, metadata]) => { return res.status(200).json({ post }) })
    .catch((error) => res.status(400).json(error));
    //sequelize.close();
};



// delete a post (DELETE)
// OK

exports.deletePost = (req, res) => {
    Post.destroy({ where: { post_id: req.params.postId } })
    .then(() => res.status(200).json({ message: 'Message supprimé !' }))
    .catch(error => res.status(400). json({ error }));
    //sequelize.close();
};


/*
exports.deletePost = (req, res) => {
    //Post.findOne({ where: { post_id: req.params.postId }})
    //.then(post => {
        //const filename = post.post_file.split('/images/')[1];
        //fs.unlink(`images/${ filename }`, () => {
            Post.destroy({ where: { post_id: req.params.postId } })
            .then(() => res.status(200).json({ message: 'Message supprimé !' }))
            .catch(error => res.status(400). json({ error }));
        //});
    //})
    //.catch(error => res.status(500). json({ error }));
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
