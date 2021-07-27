// create model for users

'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class User extends Model {
        static associate(models) {
            models.User.hasMany(models.Message);
            models.User.hasMany(models.Comment);
            models.User.hasMany(models.Message_like);
            models.User.hasMany(models.Comment_like);
            models.User.hasMany(models.Notification);
            models.User.belongsTo(models.Role);
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
                allowNull: false,
                unique: true
            },
            first_name:{
                type: DataTypes.STRING,
            },
            last_name: {
                type: DataTypes.STRING,
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
            sequelize,
            modelName: 'User',
            timestamps: false,
        }
    );   
    return User
};
