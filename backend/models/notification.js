// create model for notifications

'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Notification extends Model {
        static associate(models) {
            models.Notification.belongsTo(models.User, { foreingKey: 'fk_recipient_id', onDelete: 'CASCADE' });
            models.Notification.belongsTo(models.User, { foreingKey: 'fk_sender_id', onDelete: 'CASCADE' });
        }
    }
    Notification.init(
        {
            notification_id: {
                type: DataTypes.INTEGER,
                primaryKey: true,
                autoIncrement: true
            },
            type: {
                type: DataTypes.STRING(12),
            },
            seen: {
                type: DataTypes.BOOLEAN,
                defaultValue: false,
                allowNull: false
            },
            fk_recipient_id: {
                type: DataTypes.INTEGER(4),
                allowNull: false
            },
            fk_sender_id: {
                type: DataTypes.INTEGER(4),
                allowNull: false
            },
            original_text:{
                type: DataTypes.STRING,
            },
            original_file:{
                type: DataTypes.STRING(50),
            },
            created_at: {
                type: DataTypes.DATE,
                allowNull: false
            },
        },
        {
            indexes: [
                {
                    name: 'notification_created_at',
                    fields: ['created_at']
                },
            ]
        },
        {
            sequelize,
            modelName: 'Notification',
            tableName: 'Notification',
            createdAt: 'created_at',
            underscore: true,
            updatedAt: false,
        }
    );   
    return Notification
};
