// create model for post likes

'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Post_like extends Model {
        static associate(models) {
            models.Post_like.belongsTo(models.User, { foreingKey: 'fk_user_id', onDelete: 'CASCADE' });
            models.Post_like.belongsTo(models.Post, { foreingKey: 'fk_post_id', onDelete: 'CASCADE' });
        }
    }
    Post_like.init(
        {
            post_like_id: {
                type: DataTypes.INTEGER,
                primaryKey: true,
                autoIncrement: true
            },
            created_at: {
                type: DataTypes.DATE,
                allowNull: false
            },
            fk_user_id: {
                type: DataTypes.INTEGER(4),
                allowNull: false
            },
            fk_post_id: {
                type: DataTypes.INTEGER,
                allowNull: false
            }
        },
        {
            sequelize,
            modelName: 'Post_like',
            tableName: 'Post_like',
            createdAt: 'created_at',
            underscore: true,
            updatedAt: false,

        }
    );   
    return Post_like
};
