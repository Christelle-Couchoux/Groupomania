const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const helmet = require('helmet');
const cookieSession = require('cookie-session');
const nocache = require('nocache');
require('dotenv').config();

const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/user');
const messageRoutes = require('./routes/message')
const commentRoutes = require('./routes/comment')
const notificationRoutes = require('./routes/notification')

const app = express();


// define headers to avoid CORS errors

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*'); // origin allowed = all
    res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content, Accept, Content-Type, Authorization, '); // headers allowed
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS'); // methods allowed
    next();
});


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
app.use('/api/messages', messageRoutes);
app.use('/api/comments', commentRoutes);
app.use('/api/notifications', notificationRoutes);


// connection test

async function dbTest() {
    sequelize
        .authenticate()
        .then(() => {
            console.log('La connexion a été établie avec succès.');
        })
        .catch(err => {
            console.error('Impossible de se connecter à la base de données :', err);
        });
};
dbTest();


module.exports = app;
