const express = require('express');
const router = express.Router();

const auth = require('../middleware/auth');
const multer = require('../middleware/multer-config');

const messageCtrl = require('../controllers/message');


// message routes

router.get('/', auth, messageCtrl.getAllMessages);
router.post('/', auth, multer, messageCtrl.createMessage);
router.get('/:messageId', auth, messageCtrl.getOneMessage);
router.delete('/:messageId', auth, messageCtrl.deleteMessage);
router.get('/:messageId/likes', auth, messageCtrl.getAllLikesOfMessage);
router.post('/:messageId/likes', auth, messageCtrl.LikeMessage);
router.get('/:messageId/comments', auth, messageCtrl.getAllCommentsOfMessage);
router.post('/:messageId/comments', auth, messageCtrl.createComment);


module.exports = router;