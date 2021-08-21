<template>

	<div id="user-profile">

		<PostsHeader/>

		<main v-if="this.currentUserId">

			<section id="user-profile-content" v-for="userInfo in info" :key="userInfo.pseudo">
                <h1 v-if="currentUserId == userInfo.user_id" >Mon profil</h1>
                <h1 v-else>Profil - {{ userInfo.pseudo }}</h1>

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

                    <p class="user-bio" v-if="userInfo.bio != null">
                        <strong>Bio :</strong>  {{ userInfo.bio }}
                    </p>
                </div>

                <div id="user-comments">

                    <nav class="user-nav">
                        <ul>
                            <li>
                                <router-link :to="{ name: 'UserPosts', params: { userId: userId } }" title="Messages">
                                    <div><p>Messages</p></div>
                                </router-link>
                            </li>
                            <li>
                                <router-link :to="{ name: 'UserComments', params: { userId: userId } }" title="Commentaires">
                                    <div><p>Commentaires</p></div>
                                </router-link>
                            </li>
                            <li>
                                <router-link :to="{ name: 'UserLikes', params: { userId: userId } }" title="J'aime">
                                    <div><p>J'aime</p></div>
                                </router-link>
                            </li>
                        </ul>
                    </nav>

                    <!-- if comments -->
                    <div id="comments" v-if="comments[0]">
                        <div class="post" v-for="comment in comments" :key="comment.id">
                            <!-- post -->
                            <div
                                class="delete-post"
                                title="Supprimer le message"
                                v-if="comment.post_user_id == currentUserId || currentUserRole == 'admin'"
                                @click.prevent="deletePost(comment)"
                            >
                                <i class="fas fa-times" aria-label="Supprimer le message" role="button" @click="deletePost"></i>
                            </div>

                            <div class="post__title">
                                <div class="post__title__photo">
                                    <router-link :to="{ name: 'UserPosts', params: { userId: comment.post_user_id } }" title="Voir le profil de l'utilisateur">
                                        <img
                                            :src="comment.post_user_photo"
                                            alt="Avatar de l'utilisateur"
                                        />
                                    </router-link>
                                </div>
                                <div class="post__title__txt">
                                    <div class="post__title__pseudo">
                                        <router-link :to="{ name: 'UserPosts', params: { userId: comment.post_user_id } }" title="Voir le profil de l'utilisateur">
                                            <p>{{ comment.post_user_pseudo }}</p>
                                        </router-link>
                                    </div>
                                    <div class="post__title__divider">
                                        <p>-</p>
                                    </div>
                                    <div class="post__title__date">
                                        <p>{{ moment(comment.post_createdAt).fromNow() }}</p>
                                    </div>
                                </div>
                            </div>

                            <div class="post__text" v-if="comment.post_text">
                                <p>{{ comment.post_text }}</p>
                            </div>

                            <div
                                class="post__img"
                                v-if="comment.post_file"
                                @click.prevent="enlarge(comment)"
                            >
                                <img
                                    :src="comment.post_file"
                                    title = "Agrandir l'image"
                                />
                            </div>

                            <!-- popup window enlarge img -->
                            <div
                                id="modal-img"
                                class="modal"
                                title="Fermer l'image"
                                @click.prevent="closeImg"
                            >
                                <img id="img01"/>
                            </div>
                                
                            <router-link :to="{ name: 'Post', params: { postId: comment.post_id } }" title="Commenter et aimer le message" class="comment-router-link">
                                <div class="post__link">
                                    <p>Commenter - Aimer</p>
                                </div>
                            </router-link>
                            <!-- post end -->

                            <!-- comment -->
                            <div class="comment">
                                <!-- if own comment -->
                                <div
                                    class="delete-comment"
                                    title="Supprimer le commentaire"
                                    v-if="comment.comment_user_id == currentUserId || currentUserRole == 'admin'"
                                    @click.prevent="deleteComment(comment)"
                                >
                                    <i class="fas fa-times" aria-label="Supprimer le commentaire" role="button"></i>
                                </div>

                                <div class="comment__title">
                                    <div class="comment__title__photo">
                                        <router-link :to="{ name: 'UserPosts', params: { userId: comment.comment_user_id } }" title="Voir le profil de l'utilisateur">
                                            <img
                                                :src="comment.comment_user_photo"
                                                alt="Avatar de l'utilisateur"
                                            />
                                        </router-link>
                                    </div>
                                    <div class="comment__title__txt">
                                        <div class="comment__title__pseudo">
                                            <router-link :to="{ name: 'UserPosts', params: { userId: comment.comment_user_id } }" title="Voir le profil de l'utilisateur">
                                                <p>{{ comment.comment_user_pseudo }}</p>
                                            </router-link>
                                        </div>
                                        <div class="comment__title__divider">
                                            <p>-</p>
                                        </div>
                                        <div class="comment__title__date">
                                            <p>{{ moment(comment.comment_createdAt).fromNow() }}</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="comment__text">
                                    <p>{{ comment.comment_text }}</p>
                                </div>
                            </div>
                            <!-- comment end -->
                        </div>

                        <div id="posts-end">
                            <p>Fin des commentaires.</p>
                        </div>
                    </div>

                    <!-- if no comments -->
                    <div id="no-comments" v-else>
                        <p>{{ userInfo.pseudo }} n'a pas encore posté de commentaire.</p>
                    </div>

                </div>

            </section>

		</main>

        <div class="access-denied" v-else>
            <p>Vous devez être connecté pour accéder à cette page.</p>
            <div class="btn-login">
				<router-link to="/login" title ="Connexion">
                    <input type="button" value="Se connecter">
                </router-link>
			</div>
        </div>

		<ScrollToTopBtn/>

	</div>

</template>


<script>

import ScrollToTopBtn from '../components/ScrollToTopBtn.vue'
import PostsHeader from '../components/PostsHeader.vue'
import moment from 'moment'

import { API } from '@/axios.config.js'


export default {
	name: 'UserPostsComments',

	components: {
		ScrollToTopBtn,
		PostsHeader
	},

    data() {
        return {
            comments: [],
            comment: '',
            userId: '',
            info: [],
            userInfo:''
        }
    },

    created() {
        this.currentUserId = localStorage.getItem('userId');
        this.currentUserRole = localStorage.getItem('role');

        this.userId = this.$route.params.userId;

        this.getAllCommentsOfUser();
        this.getUserInfo();
        this.moment();
    },

    methods: {
        // display user info

        getUserInfo() {
            API.get(`users/${this.userId}/info`)
           .then(response => {
                this.info = response.data.info;
            })
            .catch(error => console.log(error));    
        },


        // get all comments of user

        getAllCommentsOfUser() {
            API.get(`users/${this.userId}/comments`)
           .then(response => {
                this.comments = response.data.comments;
            })
            .catch(error => console.log(error));
        },

        moment() {
            this.moment = moment;
        },


        // enlarge image in popup

        enlarge(comment) {
            const modal = document.getElementById('modal-img');
            const modalImg = document.getElementById('img01');
            modal.style.display = "flex";
            modalImg.src = comment.post_file;
        },

        closeImg() {
            const modal = document.getElementById('modal-img');
            modal.style.display = "none";
        },


        // delete post

        deletePost(comment) {
            API.delete(`posts/${comment.post_id}`)
            .then(response => {
                console.log(response);
                this.getAllCommentsOfUser();
            })
            .catch(error => console.log(error));
        },


        // delete comment

        deleteComment(comment) {
            API.delete(`comments/${comment.comment_id}`)
            .then(response => {
                console.log(response);
                this.getAllCommentsOfUser();
            })
            .catch(error => console.log(error));
        }
    }
};

</script>


<style lang='scss'>

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#user-comments {
    @include flexbox(column, nowrap, space-around, center);
    @include size(100%);

    @include lg {
        border-left: solid 1px $color-secondary; 
    };
};


#comments {
    @include flexbox(column, nowrap, space-around, center);
    @include size (80%, auto);
    margin: 0 0 50px 0;

    .post {
        padding: 30px 0 30px 0;
    };

    .comment {
        @include position(relative, auto, auto, auto, auto);
        @include size (80%, auto);
        margin: auto;
        margin-top: 10px;
        padding: 20px 0 0 0;
        border-bottom: none;
        border-top: solid 1px $color-secondary;
    };
};


#no-comments {
    @include no-results;
};

</style>
