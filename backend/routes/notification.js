const express = require('express');
const router = express.Router();

const auth = require('../middleware/auth');

const notificationCtrl = require('../controllers/notification');


// notification routes

router.get('/', auth, notificationCtrl.getAllNotifications);
router.put('/:notificationId', auth, notificationCtrl.updateNotification);
router.delete('/:notificationId', auth, notificationCtrl.deleteNotification);


module.exports = router;