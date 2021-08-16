const express = require('express');
const router = express.Router();

const auth = require('../middleware/auth');
const multer = require('../middleware/multer-config');

const postCtrl = require('../controllers/post');


// post routes

router.get('/', auth, postCtrl.getAllPosts);
router.post('/', auth, multer, postCtrl.createPost);
router.get('/:postId', auth, postCtrl.getOnePost);
router.get('/:postId/comments', auth, postCtrl.getAllCommentsOfPost);
router.post('/:postId/comments', postCtrl.createComment);
router.delete('/:postId', auth, postCtrl.deletePost);
router.post('/:postId/likes', postCtrl.likePost);

module.exports = router;
