// create model for posts

'use strict';

module.exports = (sequelize, Sequelize) => {
	const Post = sequelize.define('Post', {
		post_id: {
			type: Sequelize.INTEGER,
			primaryKey: true,
			autoIncrement: true
		},
		post_file: {
			type: Sequelize.STRING,
		},
		post_text: {
			type: Sequelize.STRING,
		},
		fk_user_id: {
			type: Sequelize.INTEGER(4),
			allowNull: false
		}
	},
	{
		indexes: [
			{
				name: 'post_createdAt',
				fields: ['createdAt']
			},
		]
	});

	Post.associate = function (models) {
		Post.belongsTo(models.User, { foreignKey: 'fk_user_id', targetKey:'user_id', onDelete: 'CASCADE' });
		Post.hasMany(models.Comment);
		Post.hasMany(models.Post_like);
	};

	return Post;
};
