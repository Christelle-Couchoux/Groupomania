// create schema for password

const passwordValidator = require('password-validator');


const passwordSchema = new passwordValidator();

passwordSchema
.is().min(8)                                    // Minimum length 8
.is().max(20)                                   // Maximum length 20
.has().uppercase()                              // Must have at least 1 uppercase letter
.has().lowercase()                              // Must have at least 1 lowercase letter
.has().digits()                                 // Must have at least 1 digit
.has().symbols()                                // Must have at least 1 symbol
.has().not().spaces()                           // Should not have spaces

module.exports = passwordSchema;
