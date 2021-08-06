// create model for roles

'use strict';

module.exports = (sequelize, Sequelize) => {
    const Role = sequelize.define('Role', {
            role_id: {
                type: Sequelize.INTEGER(1),
                primaryKey: true,
                autoIncrement: true
            },
            role_name: {
                type: Sequelize.STRING(20),
                unique: true,
                allowNull: false
            },
            role_description: {
                type: Sequelize.STRING,
            },
        });   

        Role.associate = function (models) {
            Role.hasMany(models.User);
        };

    return Role;
};
