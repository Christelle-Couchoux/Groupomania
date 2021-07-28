// create model for posts

'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Post extends Model {
        static associate(models) {
            models.Post.belongsTo(models.User, { foreingKey: 'fk_user_id', onDelete: 'CASCADE' });
            models.Post.hasMany(models.Comment);
            models.Post.hasMany(models.Post_like);
        }
    }
    Post.init(
        {
            post_id: {
                type: DataTypes.INTEGER,
                primaryKey: true,
                autoIncrement: true
            },
            post_file: {
                type: DataTypes.STRING(50),
            },
            post_text:{
                type: DataTypes.STRING,
            },
            created_at: {
                type: DataTypes.DATE,
                allowNull: false
            },
            fk_user_id: {
                type: DataTypes.INTEGER(4),
                allowNull: false
            }
        },
        {
            sequelize,
            modelName: 'Post',
            tableName: 'Post',
            createdAt: 'created_at',
            underscore: true,
            updatedAt: false,
        }
    );   
    return Post
};
