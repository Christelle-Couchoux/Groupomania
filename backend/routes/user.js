const express = require('express');
const router = express.Router();

const auth = require('../middleware/auth');
const multer = require('../middleware/multer-config');

const userCtrl = require('../controllers/user');


// user routes

router.get('/', userCtrl.getAllUsers);
router.get('/:userId/posts', userCtrl.getAllPostsOfUser);
router.get('/:userId/info', userCtrl.getUserInfo);
router.get('/:userId/with_comments', userCtrl.getAllPostsAndCommentsOfUser);
//router.get('/:userId/likes', auth, userCtrl.getAllLikesOfUser);
router.put('/:userId', multer, userCtrl.modifyUserProfile);
router.delete('/:userId', userCtrl.deleteUserAccount);


module.exports = router;