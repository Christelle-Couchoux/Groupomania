<template>

	<div id="user-search">

		<PostsHeader/>

		<main v-if="this.currentUserId">

			<section id="user-search-content">
                <h1>Rechercher un utilisateur</h1>

                <div id="search-box">
                    <div id="search-bar">
                        <i id="magnifying-glass" class="fas fa-search" aria-hidden="true"></i>
                        <input
                            type="search"
                            placeholder="Rechercher..."
                            name="search"
                            id="search"
                            v-model.trim="search"
                            @keyup="getAllUsers"
                        >
                    </div>
                </div>

                <!-- if users -->
                <div id="users-list" v-if="users[0]">
                    <div class="user" v-for="user in users" :key="user.user_id">
                        <div class="user__id">
                            <div class="user__id__photo">
                                <router-link :to="{ name: 'UserPosts', params: { userId: user.user_id } }" title="Voir le profil de l'utilisateur">
                                    <img :src="user.user_photo" alt="Avatar de l'utilisateur">
                                </router-link>
                            </div>
                            <div class="user__id__pseudo">
                                <router-link :to="{ name: 'UserPosts', params: { userId: user.user_id } }" title="Voir le profil de l'utilisateur">
                                    <p>{{ user.pseudo }}</p>
                                </router-link>
                            </div>
                        </div>

                        <div class="user__bio" v-if="user.bio">
                            <p>
                                <strong>Bio :</strong> {{ user.bio }}
                            </p>
                        </div>
                    </div>

                    <div id="users-end">
                        <p>Fin des utilisateurs.</p>
                    </div>
                </div>

                <!-- if no users -->
                <div id="no-users" v-else>
                    <p>Aucun utilisateur ne correspond à la recherche.</p>
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

import { API } from '@/axios.config.js'


export default {
	name: 'Search',

	components: {
		ScrollToTopBtn,
		PostsHeader
	},

    data() {
        return {
            users: [],
            user: '',
            search: ''
        }
    },

    created() {
        this.currentUserId = localStorage.getItem('userId');

        this.getAllUsers();
    },

    methods: {
        getAllUsers() {
            API.get(`users/`)
            .then(response => {
                if(this.search) {
                    this.users = response.data.users.filter(users =>
                        users.pseudo.toLowerCase().includes(this.search.toLowerCase())
                    );
                } else {
                    this.users = response.data.users;
                }
            })
            .catch(error => console.log(error));
        }
    }
};

</script>


<style lang='scss'>

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#user-search {
    @include main;
};


#user-search-content {
    @include page;
};


#search-box {
    @include first-under-h1;
    @include size(100%);
    padding: 5px 0 5px 0;
};


#search-bar {
    @include flexbox(row, nowrap, space-around, center);
    @include size(80%);
    margin: auto;

    i {
        text-align: center;
        margin: 0 10px 0 10px;
    };

    input {
        font-size: map-get($map: $font-size, $key: input);
        font-family: $montserrat;
        padding: 5px;
        border: none;
    };

    #search {
        @include size(100%, 35px);
    };
};


#users-list {
    @include flexbox(column, nowrap, space-around, center);
    @include size(100%);
    padding: 5px 0 5px 0;
    border-bottom: none;

    @include lg {
        margin: 0 0 0 0;
        border-left: solid 1px $color-secondary;
    };
};


.user {
    @include size (80%, auto);
    margin: auto;
    padding: 20px 0 20px 0;
    border-bottom: solid 1px $color-secondary;

    &__id {
        @include flexbox(row, wrap, flex-start, center);
        margin: 5px 0 5px 0;

        &__photo {
            @include user-photo;
        };

        &__pseudo {
            @include user-pseudo;
        };
    };

    &__bio {
        margin: 10px 0 0 0;
    };
};


#users-end {
    margin: 50px 0 50px 0;
};


#no-users {
    @include no-results;
    margin:auto;
    margin-top: 30px;
};

</style>
