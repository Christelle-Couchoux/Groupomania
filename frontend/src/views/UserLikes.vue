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

                    <!-- if no posts or comments liked yet -->
                    <div id="no-likes">
                        <p>
                            {{ userInfo.pseudo }} n'a pas encore aimé de message.
                        </p>
                    </div>

                    <!-- if posts or comments liked -->
                    <div id="likes">
                        <div class ="post_liked" v-for="post in posts" :key="post.post_id">

                        </div>

                        <div id="likes-end">
                            <p>Fin des messages aimés.</p>
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
            userInfo:''
        }
    },

    created() {
        this.currentUserId = localStorage.getItem("userId");
        this.currentUserPseudo = localStorage.getItem("pseudo");
        this.currentUserRole = localStorage.getItem("role");

        this.userId = this.$route.params.userId;

        this.getUserInfo();

    },

    methods: {
        getUserInfo() {
            API.get(`users/${this.userId}/info`)
           .then(response => {
                this.info = response.data.info;
            })
            .catch(error => console.log(error));
        },
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

