const express = require('express');
const router = express.Router();

const auth = require('../middleware/auth');
const multer = require('../middleware/multer-config');

const postCtrl = require('../controllers/post');


// post routes

router.get('/', postCtrl.getAllPosts);


router.post('/', multer, postCtrl.createPost);
//router.get('/:postId', auth, postCtrl.getOnePost);
//router.delete('/:postId', auth, postCtrl.deletePost);
//router.get('/:postId/likes', auth, postCtrl.getAllLikesOfPost);
//router.post('/:postId/likes', auth, postCtrl.LikePost);
//router.get('/:postId/comments', auth, postCtrl.getAllCommentsOfPost);
//router.post('/:postId/comments', auth, postCtrl.createComment);


module.exports = router;