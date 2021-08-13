const express = require('express');
const router = express.Router();

const auth = require('../middleware/auth');
const multer = require('../middleware/multer-config');

const userCtrl = require('../controllers/user');


// user routes

router.get('/', auth, userCtrl.getAllUsers);
router.get('/:userId/info', auth, userCtrl.getUserInfo);
router.get('/:userId/posts', auth, userCtrl.getAllPostsOfUser);
router.get('/:userId/comments', auth, userCtrl.getAllCommentsOfUser);
//router.get('/:userId/likes', auth, userCtrl.getAllLikesOfUser);
router.put('/:userId', auth, multer, userCtrl.modifyUserProfile);
router.delete('/:userId', auth, userCtrl.deleteUserAccount);


module.exports = router;
