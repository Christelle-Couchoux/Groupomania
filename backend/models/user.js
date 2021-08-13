// create model for users

'use strict';

module.exports = (sequelize, Sequelize) => {
	const User = sequelize.define('User', {
		user_id: {
			type: Sequelize.INTEGER(4),
			primaryKey: true,
			autoIncrement: true
		},
		pseudo: {
			type: Sequelize.STRING(16),
			allowNull: false,
			unique: true
		},
		email: {
			type: Sequelize.STRING(50),
			allowNull: false,
			unique: true,
		},
		password: {
			type: Sequelize.STRING,
			allowNull: false,
		},
		user_photo: {
			type: Sequelize.STRING,
			allowNull: false,
			defaultValue: 'http://127.0.0.1:3000/images/default-user-icon.jpg'
			
		},
		bio: {
			type: Sequelize.STRING,
		},
		fk_user_role: {
			type: Sequelize.STRING(20),
			defaultValue: "user",
			allowNull: false
		}
	},
	{
		indexes: [
			{
				name: 'user_createdAt',
				fields: ['createdAt']
			},
		]
	});

	User.associate = function (models) {
		User.hasMany(models.Post);
		User.hasMany(models.Comment);
		User.hasMany(models.Post_like);
		User.belongsTo(models.Role, { foreingKey: 'fk_user_role', targetKey: 'role_name' });
	};

	return User;
};

