const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const helmet = require('helmet');
const cookieSession = require('cookie-session');
const nocache = require('nocache');
require('dotenv').config();
const winston = require('winston');
const expressWinston = require('express-winston');


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






// error logging

/*
// router
const router = express.Router();
router.get('/error', function (req, res, next) {
	// here we cause an error in the pipeline so we see express-winston in action.
	return next(new Error("This is an error and it should be logged to the console"));
});

router.get('/', function (req, res, next) {
	res.write('This is a normal request, it should be logged to the console too');
	res.end();
});

// logger
app.use(expressWinston.logger({
	transports: [
		new winston.transports.Console()
	],
	format: winston.format.combine(
		winston.format.colorize(),
		winston.format.json()
	)
}));


app.use(router);

// errorLogger
app.use(expressWinston.errorLogger({
	transports: [
		new winston.transports.Console()
	],
	format: winston.format.combine(
		winston.format.colorize(),
		winston.format.json()
	)
}));
*/


const consoleTransport = new winston.transports.Console()
const myWinstonOptions = {
    transports: [consoleTransport]
}
const logger = new winston.createLogger(myWinstonOptions)

function logRequest(req, res, next) {
    logger.info(req.url)
    next()
}
app.use(logRequest)

function logError(err, req, res, next) {
    logger.error(err)
    next()
}
app.use(logError)

/*
'use strict'
const remoteLog = new winston.transports.Http({
    host: "localhost",
    port: 3001,
    path: "/errors"
})

const consoleLog = new winston.transports.Console()

module.exports = {
    requestLogger: createRequestLogger([consoleLog]),
    errorLogger: createErrorLogger([remoteLog, consoleLog])
}

function createRequestLogger(transports) {
    const requestLogger = winston.createLogger({
        format: getRequestLogFormatter(),
        transports: transports
    })

    return function logRequest(req, res, next) {
        requestLogger.info({req, res})
        next()
    }
}

function createErrorLogger(transports) {
    const errLogger = winston.createLogger({
        level: 'error',
        transports: transports
    })

    return function logError(err, req, res, next) {
        errLogger.error({err, req, res})
        next()
    }
}

function getRequestLogFormatter() {
    const {combine, timestamp, printf} = winston.format;

    return combine(
        timestamp(),
        printf(info => {
            const {req, res} = info.message;
            //return ${info.timestamp} ${info.level}: ${req.hostname}${req.port || ''}${req.originalUrl};
        })
    );
}
*/









// give access to static directory images

app.use('/images', express.static(path.join(__dirname, 'images')));

// define routers

app.use('/api/auth', authRoutes);
app.use('/api/users', userRoutes);
app.use('/api/posts', postRoutes);
app.use('/api/comments', commentRoutes);
app.use('/api/notifications', notificationRoutes);


module.exports = app;
