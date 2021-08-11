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

                    <p class="user-bio">
                        <strong>Bio :</strong>  {{ userInfo.bio }}
                    </p>

                    <div class="user-info-errors" v-if="errorMessage">
                        <p>{{ errorMessage }}</p>
                    </div>
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
                                <router-link :to="{ name: 'UserPostsComments', params: { userId: userInfo.user_id } }" title="Messages et commentaires">
                                    <div><p>Messages & commentaires</p></div>
                                </router-link>
                            </li>
                            <li>
                                <router-link :to="{ name: 'UserLikes', params: { userId: userInfo.user_id } }" title="J'aime">
                                    <div><p>J'aime</p></div>
                                </router-link>
                            </li>
                        </ul>
                    </nav>
                
                    <!-- if no posts yet -->
                    <div id="no-posts" v-if="!posts">
                        <p>
                            {{ userInfo.pseudo }} n'a pas encore posté de message.
                        </p>
                    </div>

                    <!-- if posts -->
                    <div id="posts">

                        <div class="post" v-for="post in posts" :key="post.post_id">
                            <router-link :to="{ name: 'Post', params: { postId: post.post_id } }" title="Voir le message">
                                <div class="delete-post" v-if="post.fk_user_id == currentUserId || currentUserRole == 'admin'">
                                    <i class="fas fa-times" aria-label="Supprimer" role="button" @click="deletePost"></i>
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
                                    <p>
                                        {{ post.post_text }}
                                    </p>
                                </div>

                                <div class="post__img" v-if="post.post_file">
                                    <img
                                        :src="post.post_file"
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
                            </router-link>
                        </div>

                        <div id="posts-end">
                            <p>Fin des messages.</p>
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
	name: 'UserPosts',
	components: {
		ScrollToTopBtn,
		PostsHeader,
	},

    data() {
        return {
            posts: [],
            post: '',
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

        this.getAllPostsOfUser();
        this.getUserInfo();
        this.moment();
    },

    methods: {
        getAllPostsOfUser() {
            
            //console.log(userId);

            API.get(`users/${this.userId}/posts`)
           .then(response => {
                this.posts = response.data.posts;
                console.log(response);
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
            })
            .catch(error => console.log(error));
        },
    }

};

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#user-profile {
    @include main; 
};


#user-profile-content {
    //@include size(100%, auto);

    @include page;
    //margin: auto;

    @include lg {
        @include size(calc(100% - 250px), auto);
    };
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
        margin: 20px 10px 10px 10px;

        @include lg {
            order: 2;
        };
    };
};


#user-photo {
    @include size(120px);
    border-radius: 50%;
    margin: 20px 10px 10px 10px;
    //padding: 2px;
    //border: solid 3px $color-basic-dark;
    //transition: all 200ms ease-in-out;

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
    @include size(90%, auto);
    font-size: map-get($font-size, pseudo);
    color: map-get($color-txt, pseudo);
    margin: 10px;
    text-align: center;
    transition: all 200ms ease-in-out;

    @include lg {
        order: 3;
    }
};


.user-bio {
    @include size(90%, auto);
    margin: 10px 10px 20px 10px;
    padding: 0 10px;

    @include lg {
        order: 4;
    }
};


#user-posts {
    @include size(100%);
    @include flexbox(column, nowrap, space-around, center);

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
        transition: all 200ms ease-in-out;
        @include flexbox(row, nowrap, center, center);
        @include size(100%, auto);
        text-align: center;
		div {
			@include size(100%, 50px);
			@include flexbox(row, nowrap, center, center);
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
    // DO NOT MOVE! 
    // Needs to be outside li to not be overwritten
	/*
    .router-link-active {
        border-bottom: solid 1px $color-primary-dark;
        //a {
            color: $color-primary-dark;
            font-weight: 700;
        //};
    };  
	*/
	.router-link-exact-active {
        border-bottom: solid 1px $color-primary-dark;
        
		p {
			color: $color-primary-dark;
			font-weight: 700;
		};
    }; 
};


#no-posts {
    @include no-results;
};


#posts {
    @include size (80%, auto);
    margin: 0 0 50px 0;
    @include flexbox(column, nowrap, space-around, center);
};


#posts-end {
    margin: 50px 0 0 0;
};


</style>

