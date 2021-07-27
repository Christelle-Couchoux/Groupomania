const express = require('express');
const router = express.Router();

const verifyPassword = require('../middleware/verifyPassword');
const limiter = require('../middleware/rateLimit');

const authCtrl = require('../controllers/auth');


// auth routes

router.post('/signup', verifyPassword, authCtrl.signup);
router.post('/login', limiter, authCtrl.login);


module.exports = router;
