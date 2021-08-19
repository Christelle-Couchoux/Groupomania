<template>

	<div id="user-profile">
		<PostsHeader/>

		<main v-if="currentUserId">

			<section id="user-profile-content" v-for="userInfo in info" :key="userInfo.pseudo">
                <h1 v-if="currentUserId == userInfo.user_id" >Mon profil</h1>
                <h1 v-else>Profil - {{ userInfo.pseudo }}</h1>
                
                <div id="user-info">
                    <div id="user-photo">
                            <img :src="userInfo.user_photo" alt="Avatar de l'utilisateur"/>
                    </div>

                    <p class="pseudo">{{ userInfo.pseudo }}</p>

                    <div class="edit-profile-btn" v-if="currentUserId == userInfo.user_id || currentUserRole == 'admin'">
                        <router-link :to="{ name: 'EditProfile', params: { userId: userInfo.user_id } }" title="Éditer le profil">
                            <input type="button" value="Éditer le profil"/>
                        </router-link>
                    </div>

                    <p class="user-bio" v-if="userInfo.bio != null">
                        <strong>Bio :</strong>  {{ userInfo.bio }}
                    </p>
                </div>

                <div id="user-likes">

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

                    <!-- if posts liked -->
                    <div id="likes" v-if="likedPosts[0]">
                        <div class ="post" v-for="likedPost in likedPosts" :key="likedPost.post_id">
                                <div
                                    class="delete-post"
                                    title="Supprimer le message"
                                    v-if="likedPost.post_user_id == currentUserId || currentUserRole == 'admin'"
                                    @click.prevent="deletePost(likedPost)"
                                >
                                    <i class="fas fa-times" aria-label="Supprimer le message" role="button" @click="deletePost"></i>
                                </div>

                                <div class="post__title">
                                    <div class="post__title__photo">
                                        <router-link :to="{ name: 'UserPosts', params: { userId: likedPost.post_user_id } }" title="Voir le profil de l'utilisateur">
                                            <img
                                                :src="likedPost.post_user_photo"
                                                alt="Avatar de l'utilisateur"
                                            />
                                        </router-link>
                                    </div>
                                    <div class="post__title__txt">
                                        <div class="post__title__pseudo">
                                            <router-link :to="{ name: 'UserPosts', params: { userId: likedPost.post_user_id } }" title="Voir le profil de l'utilisateur">
                                                <p>{{ likedPost.post_user_pseudo }}</p>
                                            </router-link>
                                        </div>
                                        <div class="post__title__divider">
                                            <p>-</p>
                                        </div>
                                        <div class="post__title__date">
                                            <p>{{ moment(likedPost.post_createdAt).fromNow() }}</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="post__text" v-if="likedPost.post_text">
                                    <p>
                                        {{ likedPost.post_text }}
                                    </p>
                                </div>

                                <div 
                                    class="post__img" 
                                    v-if="likedPost.post_file" 
                                    @click.prevent="enlarge(likedPost)"
                                >
                                    <img
                                        :src="likedPost.post_file"
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

                            <router-link :to="{ name: 'Post', params: { postId: likedPost.post_id } }" title="Commenter et aimer le message">
                                <div class="post__link">
                                    <p>
                                        Commenter / Aimer
                                    </p>
                                </div>
                            </router-link>
                        </div>

                        <div id="likes-end">
                            <p>Fin des messages aimés.</p>
                        </div>

                    </div>

                    <!-- if no posts liked yet -->
                    <div id="no-likes" v-else>
                        <p>
                            {{ userInfo.pseudo }} n'a pas encore aimé de message.
                        </p>
                    </div>

                </div>

            </section>

		</main>

        <div class="access-denied" v-else>
            <p>
                Vous devez être connecté pour accéder à cette page.
            </p>
        </div>


		<ScrollToTopBtn/>

	</div>

</template>

<script>

import ScrollToTopBtn from "../components/ScrollToTopBtn.vue"
import PostsHeader from "../components/PostsHeader.vue"
import moment from 'moment'

import { API } from '@/axios.config.js'


export default {
	name: 'UserLikes',

	components: {
		ScrollToTopBtn,
		PostsHeader,
	},

    data() {
        return {
            userId: '',
            info: [],
            userInfo:'',
            likedPosts: [],
            likedPost: '',
        }
    },

    created() {
        this.currentUserId = localStorage.getItem("userId");
        this.currentUserRole = localStorage.getItem("role");

        this.userId = this.$route.params.userId;

        this.getAllLikesOfUser();
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


        // display posts liked by user

        getAllLikesOfUser() {
            API.get(`users/${this.userId}/likes`)
           .then(response => {
                this.likedPosts = response.data.likedPosts;
                //console.log(response);
            })
            .catch(error => console.log(error));
        },

        moment() {
            this.moment = moment;
        },


        // enlarge image in popup

        enlarge(likedPost) {
            const modal = document.getElementById('modal-img');
            const modalImg = document.getElementById('img01');
            modal.style.display = "flex";
            modalImg.src = likedPost.post_file;
        },

        closeImg() {
            const modal = document.getElementById('modal-img');
            modal.style.display = "none";
        },


        // delete post

        deletePost(likedPost) {
            API.delete(`posts/${likedPost.post_id}`)
            .then(response => console.log(response))
            .catch(error => console.log(error));

            window.location.reload();
        }
    }
};

</script>


<style scoped lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#user-likes {
    @include size(100%);
    @include flexbox(column, nowrap, space-around, center);

    @include lg {
        border-left: solid 1px $color-secondary; 
    };     
};


#no-likes {
    @include no-results;
};


#likes {
    @include size (80%, auto);
    margin: 0 0 50px 0;
    @include flexbox(column, nowrap, space-around, center);

    .post_liked {
        @include position(relative, auto, auto, auto, auto);
        @include size (80%, auto);
        margin: auto;
        margin-top: 20px;
        padding: 20px 0 0 0;
        border-bottom: none;
        border-top: solid 1px $color-secondary;
    };

    #likes-end {
        margin: 50px 0 0 0;
    };

};

</style>

