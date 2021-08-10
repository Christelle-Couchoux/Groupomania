const express = require('express');
const router = express.Router();

const auth = require('../middleware/auth');
const multer = require('../middleware/multer-config');

const postCtrl = require('../controllers/post');


// post routes

router.get('/', auth, postCtrl.getAllPosts);


router.post('/', multer, postCtrl.createPost);
router.get('/:postId', postCtrl.getOnePost);
router.delete('/:postId', postCtrl.deletePost);
//router.get('/:postId/likes', auth, postCtrl.getAllLikesOfPost);
//router.post('/:postId/likes', auth, postCtrl.LikePost);
router.get('/:postId/comments', postCtrl.getAllCommentsOfPost);
router.post('/:postId/comments', postCtrl.createComment);


module.exports = router;