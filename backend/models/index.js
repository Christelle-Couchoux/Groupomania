// configure connection to database

const dbConfig = require("../config/db.config.js");

const Sequelize = require("sequelize");
const sequelize = new Sequelize(dbConfig.DB, dbConfig.USER, dbConfig.PASSWORD, {
  host: dbConfig.HOST,
  dialect: dbConfig.dialect,
  operatorsAliases: 0,

  pool: {
    max: dbConfig.pool.max,
    min: dbConfig.pool.min,
    acquire: dbConfig.pool.acquire,
    idle: dbConfig.pool.idle
  }
});

const db = {};

db.Sequelize = Sequelize;
db.sequelize = sequelize;

db.comment = require("./comment.js")(sequelize, Sequelize);
db.comment_like = require("./comment_like.js")(sequelize, Sequelize);
db.notification = require("./notification.js")(sequelize, Sequelize);
db.post_like = require("./post_like.js")(sequelize, Sequelize);
db.post = require("./post.js")(sequelize, Sequelize);
db.role = require("./role.js")(sequelize, Sequelize);
db.user = require("./user.js")(sequelize, Sequelize);


module.exports = db;
