// create model for message likes

'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Message_like extends Model {
        static associate(models) {
            models.Message_like.belongsTo(models.User, { foreingKey: 'fk_user_id', onDelete: 'CASCADE' });
            models.Message_like.belongsTo(models.Message, { foreingKey: 'fk_message_id', onDelete: 'CASCADE' });
        }
    }
    Message_like.init(
        {
            message_like_id: {
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
            fk_message_id: {
                type: DataTypes.INTEGER,
                allowNull: false
            }
        },
        {
            sequelize,
            modelName: 'Message_like',
            timestamps: false,
        }
    );   
    return Message_like
};
