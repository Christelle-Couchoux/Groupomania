// create model for messages

'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Message extends Model {
        static associate(models) {
            models.Message.belongsTo(models.User, { foreingKey: 'fk_user_id', onDelete: 'CASCADE' });
            models.Message.hasMany(models.Comment);
            models.Message.hasMany(models.Message_like);
        }
    }
    Message.init(
        {
            message_id: {
                type: DataTypes.INTEGER,
                primaryKey: true,
                autoIncrement: true
            },
            message_file: {
                type: DataTypes.STRING(50),
            },
            message_text:{
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
            modelName: 'Message',
            timestamps: false,
        }
    );   
    return Message
};
