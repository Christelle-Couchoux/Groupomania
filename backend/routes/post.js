const express = require('express');
const router = express.Router();

const auth = require('../middleware/auth');
const multer = require('../middleware/multer-config');

const postCtrl = require('../controllers/post');


// post routes

router.get('/', postCtrl.getAllPosts);

/*
router.post('/', multer, postCtrl.createPost, function (req, res) {
    // 10 minutes timeout just for POST to myroute
    req.socket.setTimeout(10 * 60 * 1000);
    upload.single('data');
    console.log(req.file);
});
*/

router.post('/', multer, postCtrl.createPost);
router.get('/:postId', postCtrl.getOnePost);
router.delete('/:postId', postCtrl.deletePost);
//router.get('/:postId/likes', auth, postCtrl.getAllLikesOfPost);
//router.post('/:postId/likes', auth, postCtrl.LikePost);
router.get('/:postId/comments', postCtrl.getAllCommentsOfPost);
router.post('/:postId/comments', postCtrl.createComment);
//router.get('/:postId/comments/count', postCtrl.getCommentsNumber);

module.exports = router;
