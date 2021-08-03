// create model for users

'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class User extends Model {
        static associate(models) {
            models.User.hasMany(models.Post);
            models.User.hasMany(models.Comment);
            models.User.hasMany(models.Post_like);
            models.User.hasMany(models.Comment_like);
            models.User.hasMany(models.Notification);
            models.User.belongsTo(models.Role, { foreingKey: 'fk_user_role' });
        }
    }
    User.init(
        {
            user_id: {
                type: DataTypes.INTEGER(4),
                primaryKey: true,
                autoIncrement: true
            },
            pseudo: {
                type: DataTypes.STRING,
                match: [/^[-\w\sÀÁÂÄÅÇÈÉÊËÌÍÎÏÑŒÒÓÔÕÖØÙÚÛÜàáâäåçèéêëìíîïñœòóôõöøùúûü]+{3,20}$/],
                allowNull: false,
                unique: true
            },
            first_name:{
                type: DataTypes.STRING,
                match: [/^[-\w\sÀÁÂÄÅÇÈÉÊËÌÍÎÏÑŒÒÓÔÕÖØÙÚÛÜàáâäåçèéêëìíîïñœòóôõöøùúûü]+{1,30}$/],
            },
            last_name: {
                type: DataTypes.STRING,
                match: [/^[-\w\sÀÁÂÄÅÇÈÉÊËÌÍÎÏÑŒÒÓÔÕÖØÙÚÛÜàáâäåçèéêëìíîïñœòóôõöøùúûü]+{1,30}$/],
            },
            email: {
                type: DataTypes.STRING,
                allowNull: false,
                unique: true,
                match: [/^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/, "Veuillez saisir une adresse email valide."]
            },
            password: {
                type: DataTypes.STRING,
                allowNull: false,
                validate: { verifyPassword }
            },
            user_photo: {
                type: DataTypes.STRING,
                allowNull: false,
                defaultValue: 'http://127.0.0.1:3000/images/default-user-icon.jpg'
            },
            bio: {
                type: DataTypes.STRING,
                match: [/^[-\w\sÀÁÂÄÅÇÈÉÊËÌÍÎÏÑŒÒÓÔÕÖØÙÚÛÜàáâäåçèéêëìíîïñœòóôõöøùúûü]+{1,255}$/],
            },
            created_at: {
                type: DataTypes.DATE,
                allowNull: false
            },
            fk_user_role: {
                type: DataTypes.INTEGER,
                default: 3,
                allowNull: false
            }
        },
        {
            indexes: [
                {
                    name: 'user_first_name',
                    fields: ['first_name']
                },
                {
                    name: 'user_last_name',
                    fields: ['last_name']
                },
                {
                    name: 'user_created_at',
                    fields: ['created_at']
                },
            ]
        },
        {
            sequelize,
            modelName: 'User',
            tableName: 'User',
            createdAt: 'created_at',
            underscore: true,
            updatedAt: false,
        }
    );   
    return User
};
