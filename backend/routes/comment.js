const express = require('express');
const router = express.Router();

const auth = require('../middleware/auth');

const commentCtrl = require('../controllers/comment');


// comment routes

router.delete('/:commentId', auth, commentCtrl.deleteComment);
router.get('/:commentId/likes', auth, commentCtrl.getAllLikesOfComment);
router.post('/:commentId/likes', auth, commentCtrl.LikeComment);


module.exports = router;