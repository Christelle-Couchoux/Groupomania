// create model for comments

'use strict';

module.exports = (sequelize, Sequelize) => {
    const Comment = sequelize.define('Comment', {
        comment_id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        comment_text:{
            type: Sequelize.STRING,
        },
        fk_user_id: {
            type: Sequelize.INTEGER(4),
            allowNull: false
        },
        fk_post_id: {
            type: Sequelize.INTEGER,
            allowNull: false
        }
    },
    {
        indexes: [
            {
                name: 'comment_createdAt',
                fields: ['createdAt']
            },
        ]
    }); 

    Comment.associate = function (models) {
        Comment.belongsTo(models.Post, { foreignKey: 'fk_post_id', onDelete: 'CASCADE' });
        Comment.belongsTo(models.User, { foreignKey: 'fk_user_id', onDelete: 'CASCADE' });
        Comment.hasMany(models.CommentLike);
    };

    return Comment;
};

