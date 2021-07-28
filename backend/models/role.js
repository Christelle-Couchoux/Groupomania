// create model for roles

'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Role extends Model {
        static associate(models) {
            models.Role.hasMany(models.User);
        }
    }
    Role.init(
        {
            role_id: {
                type: DataTypes.INTEGER(1),
                primaryKey: true,
                autoIncrement: true
            },
            role_name:{
                type: DataTypes.STRING(20),
            },
            role_description: {
                type: DataTypes.STRING,
            },
        },
        {
            sequelize,
            modelName: 'Role',
            tableName: 'Role',
            timestamps: false,
            underscore: true,
        }
    );   
    return Role
};
