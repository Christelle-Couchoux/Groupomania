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

                    <div class="edit-profile-btn" v-if="currentUserId == userInfo.user_id || currentUserRole == 'admin'">
                        <router-link :to="{ name: 'EditProfile', params: { userId: userInfo.user_id } }" title="Modifier le profil">
                            <input type="button" value="Modifier le profil"/>
                        </router-link>
                    </div>

                    <p class="user-bio" v-if="userInfo.bio != null">
                        <strong>Bio :</strong>  {{ userInfo.bio }}
                    </p>
                </div>

                <div id="user-posts">

                    <nav class="user-nav">
                        <ul>
                            <li>
                                <router-link :to="{ name: 'UserPosts', params: { userId: userInfo.user_id } }" title="Messages">
                                    <div><p>Messages</p></div>
                                </router-link>
                            </li>
                            <li>
                                <router-link :to="{ name: 'UserComments', params: { userId: userInfo.user_id } }" title="Commentaires">
                                    <div><p>Commentaires</p></div>
                                </router-link>
                            </li>
                            <li>
                                <router-link :to="{ name: 'UserLikes', params: { userId: userInfo.user_id } }" title="J'aime">
                                    <div><p>J'aime</p></div>
                                </router-link>
                            </li>
                        </ul>
                    </nav>

                    <!-- if posts -->
                    <div id="posts" v-if="posts[0]">

                        <div class="post" v-for="post in posts" :key="post.post_id">
                            <div
                                class="delete-post"
                                title="Supprimer le message"
                                v-if="post.fk_user_id == currentUserId || currentUserRole == 'admin'"
                                @click.prevent="deletePost(post)"
                            >
                                <i class="fas fa-times" aria-label="Supprimer le message" role="button" @click="deletePost"></i>
                            </div>

                            <div class="post__title">
                                <div class="post__title__photo">
                                    <router-link :to="{ name: 'UserPosts', params: { userId: post.fk_user_id } }" title="Voir le profil de l'utilisateur">
                                        <img
                                            :src="post.user_photo"
                                            alt="Avatar de l'utilisateur"
                                        />
                                    </router-link>
                                </div>
                                <div class="post__title__txt">
                                    <div class="post__title__pseudo">
                                        <router-link :to="{ name: 'UserPosts', params: { userId: post.fk_user_id } }" title="Voir le profil de l'utilisateur">
                                            <p>{{ post.pseudo }}</p>
                                        </router-link>
                                    </div>
                                    <div class="post__title__divider">
                                        <p>-</p>
                                    </div>
                                    <div class="post__title__date">
                                        <p>{{ moment(post.createdAt).fromNow() }}</p>
                                    </div>
                                </div>
                            </div>

                            <div class="post__text" v-if="post.post_text">
                                <p>{{ post.post_text }}</p>
                            </div>

                            <div
                                class="post__img"
                                v-if="post.post_file"
                                @click.prevent="enlarge(post)"
                            >
                                <img
                                    :src="post.post_file"
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

                            <router-link :to="{ name: 'Post', params: { postId: post.post_id } }" title="Commenter et aimer le message">
                                <div class="post__link">
                                    <p>Commenter - Aimer</p>
                                </div>
                            </router-link>
                        </div>

                        <div id="posts-end">
                            <p>Fin des messages.</p>
                        </div>

                    </div> 

                    <!-- if no posts -->
                    <div id="no-posts" v-else>
                        <p>{{ userInfo.pseudo }} n'a pas encore posté de message.</p>
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
	name: 'UserPosts',

	components: {
		ScrollToTopBtn,
		PostsHeader
	},

    data() {
        return {
            posts: null,
            post: '',
            userId: '',
            info: [],
            userInfo:''
        }
    },

    created() {
        this.currentUserId = localStorage.getItem("userId");
        this.currentUserRole = localStorage.getItem("role");

        this.userId = this.$route.params.userId;

        this.getAllPostsOfUser();
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


        // dispaly all posts of user

        getAllPostsOfUser() {
            API.get(`users/${this.userId}/posts`)
           .then(response => {
                this.posts = response.data.posts;
                //console.log(this.posts);
            })
            .catch(error => console.log(error));
        },

        moment() {
            this.moment = moment;
        },


        // enlarge image in popup

        enlarge(post) {
            const modal = document.getElementById('modal-img');
            const modalImg = document.getElementById('img01');
            modal.style.display = "flex";
            modalImg.src = post.post_file;
        },

        closeImg() {
            const modal = document.getElementById('modal-img');
            modal.style.display = "none";
        },


        // delete post

        deletePost(post) {
            API.delete(`posts/${post.post_id}`)
            .then(response => {
                console.log(response);
                this.getAllPostsOfUser();
            })
            .catch(error => console.log(error));
        }
    }
};

</script>


<style lang='scss'>

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#user-profile {
    @include main;
};


#user-profile-content {
    @include page;
};


#user-info {
	@include first-under-h1;
    @include flexbox(column, wrap, space-around, center);

    @include lg {
        @include flexbox(row, wrap, space-around, center);
    };

    .user-info-errors {
        @include form-errors;
    };

    .edit-profile-btn {
        @include btn(200px);
        @include btn-edit-profile;
        margin: 10px 10px 10px 10px;
    };
};


#user-photo {
    @include size(120px);
    margin: 20px 10px 10px 10px;
    border-radius: 50%;

    @include lg {
        order: 1;
    };

    img {
        @include size(100%);
        object-fit: cover;
        border-radius: 50%;
    };
};


.pseudo {
    font-size: map-get($font-size, pseudo);
    text-align: center;
    color: map-get($color-txt, pseudo);
    @include size(90%, auto);
    margin: 10px 10px 20px 10px;
    transition: all 200ms ease-in-out;

    @include lg {
        order: 3;
    };
};


.user-bio {
    @include size(90%, auto);
    margin: 20px 10px 20px 10px;
    padding: 0 10px;

    @include lg {
        order: 4;
    };
};


#user-posts {
    @include flexbox(column, nowrap, space-around, center);
    @include size(100%);

    @include lg {
        border-left: solid 1px $color-secondary;
    };
};


.user-nav {
    @include size (100%, auto);
    margin: 0 0 15px 0;

    ul {
        @include list-style;
        @include flexbox(row, nowrap, space-around, center);
    };

    li {
        text-align: center;
        @include flexbox(row, nowrap, center, center);
        @include size(100%, auto);
        transition: all 200ms ease-in-out;

		div {
            @include flexbox(row, nowrap, center, center);
			@include size(100%, 50px);
		};

		a {
			@include size (100%, auto);
			border-bottom: solid 1px $color-secondary;

			&:hover {
				cursor: pointer;
				font-weight: 700;

				p {
					color: $color-primary-dark;
				};
			};
        }; 
    };

	.router-link-active {
        border-bottom: solid 1px $color-primary-dark;

		p {
            font-weight: 700;
			color: $color-primary-dark;
		};
    };
};


#posts {
    @include flexbox(column, nowrap, space-around, center);
    @include size (80%, auto);
    margin: 0 0 50px 0;
};


#posts-end {
    margin: 50px 0 0 0;
};

</style>
