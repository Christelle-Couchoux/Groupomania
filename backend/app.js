const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const helmet = require('helmet');
const cookieSession = require('cookie-session');
const nocache = require('nocache');
require('dotenv').config();

const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/user');
const postRoutes = require('./routes/post');
const commentRoutes = require('./routes/comment');
const notificationRoutes = require('./routes/notification');

const app = express();


// to avoid CORS errors

var cors = require('cors')
app.use(cors()) // Use this after the variable declaration


// secure cookies

app.use(cookieSession({
  keys: [process.env.COOKIE_KEY1, process.env.COOKIE_KEY2],
  cookie: {
    secure: true,
    httpOnly: true,
    domain: 'http://localhost:3000',
    maxAge: 60 * 60 * 1000 // 1 hour in ms
  }
}));


// convert request body to js so can be used

app.use(bodyParser.json());


// secure headers, 11 middlewares

app.use(helmet());


// disable caching

app.use(nocache());


// database

const db = require("./models");
db.sequelize.sync();


// give access to static directory images

app.use('/images', express.static(path.join(__dirname, 'images')));

// define routers

app.use('/api/auth', authRoutes);
app.use('/api/users', userRoutes);
app.use('/api/posts', postRoutes);
app.use('/api/comments', commentRoutes);
app.use('/api/notifications', notificationRoutes);


module.exports = app;
