// require strong password to signup

const passwordSchema = require('../models/password');


// verify that the password matches the password schema

module.exports = (req, res, next) => {
    // if password not strong enough
    if (!passwordSchema.validate(req.body.password)) {
        res.status(400).json({ message: 'Votre mot de passe n\'est pas assez fort. Le mot de passe requiert : entre 8 et 20 caractères, au moins une majuscule, une minuscule, un chiffre, et un caractère spécial. Les espaces ne sont pas autorisés.'})
    } else {
        next(); // if password ok, move to next middleware
    }
};
