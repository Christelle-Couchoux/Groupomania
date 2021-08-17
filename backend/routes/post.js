const express = require('express');
const router = express.Router();

const auth = require('../middleware/auth');
const multer = require('../middleware/multer-config');

const postCtrl = require('../controllers/post');


// post routes

router.get('/', auth, postCtrl.getAllPosts);
router.post('/', auth, multer, postCtrl.createPost);
router.delete('/:postId', auth, postCtrl.deletePost);
router.get('/:postId', auth, postCtrl.getOnePost);
router.post('/:postId/comments', postCtrl.createComment); // not working with auth ???
router.get('/:postId/comments', auth, postCtrl.getAllCommentsOfPost);
router.post('/:postId/likes', postCtrl.likePost); // not working with auth ???
router.get('/:postId/userLiked/:userId', auth, postCtrl.getUserLiked);
router.get('/:postId/likesCount', auth, postCtrl.getLikesCountOfPost);
router.get('/:postId/commentsCount', auth, postCtrl.getCommentsCountOfPost);

module.exports = router;
