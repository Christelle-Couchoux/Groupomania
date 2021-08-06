// create model for notifications

'use strict';

module.exports = (sequelize, Sequelize) => {
	const Notification = sequelize.define('Notification', {
		notification_id: {
			type: Sequelize.INTEGER,
			primaryKey: true,
			autoIncrement: true
		},
		type: {
			type: Sequelize.STRING(12),
		},
		seen: {
			type: Sequelize.BOOLEAN,
			defaultValue: false,
			allowNull: false
		},
		fk_recipient_id: {
			type: Sequelize.INTEGER(4),
			allowNull: false
		},
		fk_sender_id: {
			type: Sequelize.INTEGER(4),
			allowNull: false
		},
		original_text: {
			type: Sequelize.STRING,
		},
		original_file: {
			type: Sequelize.STRING(50),
		},
	},
	{
		indexes: [
			{
				name: 'notification_createdAt',
				fields: ['createdAt']
			},
		]
	}); 
	
	Notification.associate = function (models) {
		Notification.belongsTo(models.User, { foreingKey: 'fk_recipient_id', onDelete: 'CASCADE' });
		Notification.belongsTo(models.User, { foreingKey: 'fk_sender_id', onDelete: 'CASCADE' });
	};

	return Notification;
};
