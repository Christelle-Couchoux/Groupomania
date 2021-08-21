const rateLimit = require("express-rate-limit");


// limit number of connexions to 10 per hour

const limiter = rateLimit({
    windowMs: 60 * 60 * 1000, // 1 hour
    max: 10
});

module.exports = limiter;
