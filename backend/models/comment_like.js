// create model for comment likes

'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Comment_like extends Model {
        static associate(models) {
            models.Comment_like.belongsTo(models.User, { foreingKey: 'fk_user_id', onDelete: 'CASCADE' });
            models.Comment_like.belongsTo(models.Comment, { foreingKey: 'fk_comment_id', onDelete: 'CASCADE' });
        }
    }
    Comment_like.init(
        {
            comment_like_id: {
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
            fk_comment_id: {
                type: DataTypes.INTEGER,
                allowNull: false
            }
        },
        {
            sequelize,
            modelName: 'Comment_like',
            tableName: 'Comment_like',
            createdAt: 'created_at',
            underscore: true,
            updatedAt: false,
        }
    );   
    return Comment_like
};
