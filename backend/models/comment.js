// create model for comments

'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Comment extends Model {
        static associate(models) {
            models.Comment.belongsTo(models.User, { foreingKey: 'fk_user_id', onDelete: 'CASCADE' });
            models.Comment.belongsTo(models.Post, { foreingKey: 'fk_post_id', onDelete: 'CASCADE' });
            models.Comment.hasMany(models.Comment_like);
        }
    }
    Comment.init(
        {
            comment_id: {
                type: DataTypes.INTEGER,
                primaryKey: true,
                autoIncrement: true
            },
            comment_text:{
                type: DataTypes.STRING,
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
            indexes: [
                {
                    name: 'comment_created_at',
                    fields: ['created_at']
                },
            ]
        },
        {
            sequelize,
            modelName: 'Comment',
            tableName: 'Comment',
            createdAt: 'created_at',
            underscore: true,
            updatedAt: false,
        }
    );   
    return Comment
};
