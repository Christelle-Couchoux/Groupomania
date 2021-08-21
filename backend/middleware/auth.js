const jwt = require('jsonwebtoken');


// userId validation with token

module.exports = (req, res, next) => {
    try {
        const token = req.headers.authorization.split(' ')[1];
        const decodedToken = jwt.verify(token, process.env.RND_TKN);
        const userId = decodedToken.userId;
        if(!userId) {
            throw 'User id absent, utilisateur non connecté !';
        } else {
            next();
        }
    } catch(error) {
        res.status(401).json({ error: error | 'Requête non authentifiée !' });
    }
};
