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
		first_name: {
			type: Sequelize.STRING,
		},
		last_name: {
			type: Sequelize.STRING,
		},
		email: {
			type: Sequelize.STRING,
			allowNull: false,
			unique: true,
		},
		password: {
			type: Sequelize.STRING(20),
			allowNull: false,
			//validate: { verifyPassword }
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
				name: 'user_first_name',
				fields: ['first_name']
			},
			{
				name: 'user_last_name',
				fields: ['last_name']
			},
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
		User.hasMany(models.Comment_like);
		User.hasMany(models.Notification);
		User.belongsTo(models.Role, { foreingKey: 'fk_user_role', targetKey: 'role_name' });
	};

	return User;
};
