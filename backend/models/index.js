// configure connection to database

'use strict';

const Sequelize = require("sequelize");
const fs = require('fs');
const path = require('path');
const basename = path.basename(__filename);
const db = {};


let sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASSWORD, {
    host: process.env.DB_HOST,
    dialect: 'mysql',
    operatorsAliases: false,

    pool: {
        max: 5,
        min: 0,
        acquire: 30000,
        idle: 10000
    }
});

fs
    .readdirSync( __dirname )
    .filter( function( file ) {
        return ( file.indexOf( '.' ) !== 0 ) && ( file !== basename ) && ( file.slice( -3 ) === '.js' )
    } )
    .forEach( function( file ) {
        const model = sequelize[ 'import' ]( path.join( __dirname, file ) )
        db[ model.name ] = model
    });

Object.keys(db).forEach(modelName => {
    if (db[modelName].associate) {
        db[modelName].associate(db);
  }
});


db.Sequelize = Sequelize;
db.sequelize = sequelize;


module.exports = db;
