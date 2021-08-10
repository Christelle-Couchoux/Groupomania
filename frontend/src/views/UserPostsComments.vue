<template>

	<div id="user-profile">
		<PostsHeader/>

		<main>

			<section id="user-profile-content" v-for="userInfo in info" :key="userInfo.pseudo">
                <h1>{{ userInfo.pseudo }}</h1>
                
                <div id="user-info">
                    <div id="user-photo">
                            <img :src="userInfo.user_photo" alt="Avatar de l'utilisateur"/>
                    </div>

                    <p class="pseudo">{{ userInfo.pseudo }}</p>

                    <div class="edit-profile-btn" v-if="currentUserId == userId || currentUserRole == 'admin'">
                        <router-link :to="{ name: 'EditProfile', params: { userId: userInfo.user_id } }" title="Éditer le profil">
                            <input type="button" value="Éditer le profil"/>
                        </router-link>
                    </div>

                    <p class="user-bio">
                        <strong>Bio :</strong>  {{ userInfo.bio }}
                    </p>

                    <div class="user-info-errors" v-if="errorMessage">
                        <p>{{ errorMessage }}</p>
                    </div>
                </div>

                <div id="user-posts-comments">

                    <nav class="user-nav">
                        <ul>
                            <li>
                                <router-link :to="{ name: 'UserPosts', params: { userId: userId } }" title="Messages">
                                    <div><p>Messages</p></div>
                                </router-link>
                            </li>
                            <li>
                                <router-link :to="{ name: 'UserPostsComments', params: { userId: userId } }" title="Messages et commentaires">
                                    <div><p>Messages & commentaires</p></div>
                                </router-link>
                            </li>
                            <li>
                                <router-link :to="{ name: 'UserLikes', params: { userId: userId } }" title="J'aime">
                                    <div><p>J'aime</p></div>
                                </router-link>
                            </li>
                        </ul>
                    </nav>

                    <!-- if no posts or comments yet -->
                    <div id="no-posts-comments" v-if="!postsComments">
                        <p>
                            {{ userInfo.pseudo }} n'a pas encore posté de message ou commentaire.
                        </p>
                    </div>

                    <!-- if posts or comments -->
                    <div id="posts-comments">
                        <div class="post" v-for="postComment in postsComments" :key="postComment.id">
                            <router-link :to="{ name: 'Post', params: { postId: postComment.post_id } }" title="Voir le message" class="postComment-router-link">
                                <!-- post -->
                                <div class="delete-post" v-if="postComment.post_user_id == currentUserId || currentUserRole == 'admin'">
                                    <i class="fas fa-times" aria-label="Supprimer" role="button" @click="deletePost"></i>
                                </div>

                                <div class="post__title">
                                    <div class="post__title__photo">
                                        <router-link :to="{ name: 'UserPosts', params: { userId: postComment.post_user_id } }" title="Voir le profil de l'utilisateur">
                                            <img
                                                :src="postComment.post_user_photo"
                                                alt="Avatar de l'utilisateur"
                                            />
                                        </router-link>
                                    </div>
                                    <div class="post__title__txt">
                                        <div class="post__title__pseudo">
                                            <router-link :to="{ name: 'UserPosts', params: { userId: postComment.post_user_id } }" title="Voir le profil de l'utilisateur">
                                                <p>{{ postComment.post_user_pseudo }}</p>
                                            </router-link>
                                        </div>
                                        <div class="post__title__divider">
                                            <p>-</p>
                                        </div>
                                        <div class="post__title__date">
                                            <p>{{ moment(postComment.post_createdAt).fromNow() }}</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="post__text" v-if="postComment.post_text">
                                    <p>
                                        {{ postComment.post_text }}
                                    </p>
                                </div>

                                <div class="post__img" v-if="postComment.post_file">
                                    <img
                                        :src="postCommnet.post_file"
                                    />
                                </div>

                                <div class="post__buttons">
                                    <div class="post__btn post__btn--comment" title="Commenter">
                                        <div class="post__btn__icon">
                                            <i class="far fa-comment" aria-label="Commenter" role="img"></i>
                                        </div>
                                        <div class="post__btn__counter">
                                            <p>1</p>
                                        </div>
                                    </div>
                                    <div class="post__btn post__btn--like" title="Aimer">
                                        <div class="post__btn__icon">
                                            <i class="far fa-heart" aria-label="Aimer" role="img"></i>
                                        </div>
                                        <div class="post__btn__counter">
                                            <p>3</p>
                                        </div>
                                    </div>
                                </div>
                                <!-- post end -->

                                <!-- comment -->
                                <div class="comment" v-if="postComment.comment_id">
                                    <!-- if own comment -->
                                    <div class="delete-comment" v-if="postComment.comment_user_id == currentUserId || currentUserRole == 'admin'">
                                        <i class="fas fa-times" aria-label="Supprimer" role="button"></i>
                                    </div>

                                    <div class="comment__title">
                                        <div class="comment__title__photo">
                                            <router-link :to="{ name: 'UserPosts', params: { userId: postComment.comment_user_id } }" title="Voir le profil de l'utilisateur">
                                                <img
                                                    :src="postComment.comment_user_photo"
                                                    alt="Avatar de l'utilisateur"
                                                />
                                            </router-link>
                                        </div>
                                        <div class="comment__title__txt">
                                            <div class="comment__title__pseudo">
                                                <router-link :to="{ name: 'UserPosts', params: { userId: postComment.comment_user_id } }" title="Voir le profil de l'utilisateur">
                                                    <p>{{ postComment.comment_user_pseudo }}</p>
                                                </router-link>
                                            </div>
                                            <div class="comment__title__divider">
                                                <p>-</p>
                                            </div>
                                            <div class="comment__title__date">
                                                <p>{{ moment(postComment.createdAt).fromNow() }}</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="comment__text">
                                        <p>{{ postComment.comment_text }}</p>
                                    </div>

                                    <div class="comment__likes">
                                        <div class="comment__likes__btn" title="Aimer">
                                            <i class="far fa-heart" aria-label="Aimer" role="img"></i>
                                        </div>
                                        <div class="comment__likes__count" title="Voir les utilisateurs qui aiment ce message">
                                            <router-link to="/posts/:postId/likes" title="Voir les utilisateurs qui aiment ce message">
                                                <p>2 &nbsp; J'aime</p>
                                            </router-link>
                                        </div>
                                    </div>
                                </div>
                                <!-- comment end -->
                            
                            </router-link>
                        </div>


                        <div id="posts-end">
                            <p>Fin des messages et commentaires.</p>
                        </div>
                    </div>
                </div>

            </section>

		</main>

		<ScrollToTopBtn/>

	</div>

</template>

<script>

import ScrollToTopBtn from "../components/ScrollToTopBtn.vue"
import PostsHeader from "../components/PostsHeader.vue"
import moment from 'moment'

import { API } from '@/axios.config.js'


export default {
	name: 'UserPostsComments',

	components: {
		ScrollToTopBtn,
		PostsHeader,
	},

    data() {
        return {
            postsComments: [],
            postComment: '',
            userId: '',
            info: [],
            userInfo:''
        }
    },

    created() {
        this.currentUserId = localStorage.getItem("userId");
        this.currentUserPseudo = localStorage.getItem("pseudo");
        this.currentUserRole = localStorage.getItem("role");

        this.userId = this.$route.params.userId;
        //console.log(this.userId);

        this.getAllPostsCommentsOfUser();
        this.getUserInfo();
        this.moment();
    },
    
    methods: {
        getAllPostsCommentsOfUser() {
            API.get(`users/${this.userId}/with_comments`)
           .then(response => {
                this.postsComments = response.data.postsComments;
            })
            .catch(error => console.log(error));
        },
        

        moment() {
            this.moment = moment;
        },

        getUserInfo() {
            API.get(`users/${this.userId}/info`)
           .then(response => {
                this.info = response.data.info;
                console.log(this.info);
            })
            .catch(error => console.log(error));
            
        },
    }
};

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#user-posts-comments {
    @include size(100%);
    @include flexbox(column, nowrap, space-around, center);

    @include lg {
        border-left: solid 1px $color-secondary; 
    };     
};

#no-posts-comments {
    @include no-results;
};

#posts-comments {
    @include size (80%, auto);
    margin: 0 0 50px 0;
    @include flexbox(column, nowrap, space-around, center);

    .postComment-router-link {
        @include size(100%);
    };

    .comment {
        @include position(relative, auto, auto, auto, auto);
        @include size (80%, auto);
        margin: auto;
        margin-top: 20px;
        padding: 20px 0 0 0;
        border-bottom: none;
        border-top: solid 1px $color-secondary;
    };
};

</style>

