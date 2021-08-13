// create model for post likes

'use strict';

module.exports = (sequelize, Sequelize) => {
    const Post_like = sequelize.define('Post_like', {
        post_like_id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
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
                name: 'post_like_createdAt',
                fields: ['createdAt']
            },
        ]
    });
    
    Post_like.associate = function (models) {
        Post_like.belongsTo(models.User, { foreingKey: 'fk_user_id', onDelete: 'CASCADE' });
        Post_like.belongsTo(models.Post, { foreingKey: 'fk_post_id', onDelete: 'CASCADE' });
    };

    return Post_like;
};

