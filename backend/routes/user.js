const express = require('express');
const router = express.Router();

const auth = require('../middleware/auth');
const multer = require('../middleware/multer-config');

const userCtrl = require('../controllers/user');


// user routes

//router.get('/', auth, userCtrl.getAllUsers);
//router.get('/search', auth, userCtrl.searchUser);
//router.get('/:userId', auth, userCtrl.getAllPostsOfUser);
//router.get('/:userId/with_comments', auth, userCtrl.getAllPostsAndCommentsOfUser);
//router.get('/:userId/likes', auth, userCtrl.getAllLikesOfUser);
//router.put('/:userId', auth, multer, userCtrl.modifyUserProfile);
//router.delete('/:userId', auth, userCtrl.deleteUserAccount;


module.exports = router;