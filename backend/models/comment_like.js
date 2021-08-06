// create model for comment likes

'use strict';

module.exports = (sequelize, Sequelize) => {
	const Comment_like = sequelize.define('Comment_like', {
		comment_like_id: {
			type: Sequelize.INTEGER,
			primaryKey: true,
			autoIncrement: true
		},
		fk_user_id: {
			type: Sequelize.INTEGER(4),
			allowNull: false
		},
		fk_comment_id: {
			type: Sequelize.INTEGER,
			allowNull: false
		}
	},
	{
		indexes: [
			{
				name: 'comment_like_created_at',
				fields: ['created_at']
			},
		]
	});

	Comment_like.associate = function (models) {
		Comment_like.belongsTo(models.User, { foreingKey: 'fk_user_id', onDelete: 'CASCADE' });
		Comment_like.belongsTo(models.Comment, { foreingKey: 'fk_comment_id', onDelete: 'CASCADE' });
	};

	return Comment_like;
};
