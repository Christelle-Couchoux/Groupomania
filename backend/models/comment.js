// create model for comments

'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Comment extends Model {
        static associate(models) {
            models.Comment.belongsTo(models.User, { foreingKey: 'fk_user_id', onDelete: 'CASCADE' });
            models.Comment.belongsTo(models.Message, { foreingKey: 'fk_message_id', onDelete: 'CASCADE' });
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
            fk_message_id: {
                type: DataTypes.INTEGER,
                allowNull: false
            }
        },
        {
            sequelize,
            modelName: 'Comment',
            timestamps: false,
        }
    );   
    return Comment
};
