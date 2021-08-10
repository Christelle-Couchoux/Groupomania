<template>

	<div id="user-search">
		<PostsHeader/>

		<main>

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

                <div id="users-list">

                    <!-- if no users -->
                    <div id="no-users" v-if="!users">
                        <p>
                            Aucun utilisateur ne correspond à la recherche.
                        </p>
                    </div>

                    <!-- if users -->
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
	name: 'Search',
	components: {
		ScrollToTopBtn,
		PostsHeader,

	},
    data() {
        return {
            users: [],
            user: '',
            search: ''
        }
    },
    created() {
        this.currentUserId = localStorage.getItem("userId");
        this.currentUserPseudo = localStorage.getItem("pseudo");
        this.currentUserRole = localStorage.getItem("role");

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


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#user-search {
    @include main;
};


#user-search-content {
    @include page;
    @include size(100%, auto);

    @include lg {
        @include size(calc(100% - 250px), auto);
    };
};

#search-box {
    @include size(100%);
    @include first-under-h1;
    padding: 5px 0 5px 0;
};


#search-bar {
    @include flexbox(row, nowrap, space-around, center);
    @include size(80%);
    margin: auto;

    i {
        margin: 0 10px 0 10px;
        text-align: center;
    };

    input {
        padding: 5px;
        border: none;
        font-size: map-get($map: $font-size, $key: input);
        font-family: $montserrat;
    };

    #search {
        @include size(100%, 35px);
    };
};


#users-list {
    @include size(100%);
    border-bottom: none;
    //margin: 194px 0 50px 0;
    padding: 5px 0 5px 0;
    @include flexbox(column, nowrap, space-around, center);
    
    @include lg {
        border-left: solid 1px $color-secondary; 
        margin: 0 0 0 0;
    }
};


#no-users {
    @include no-results;
};


.user {
    @include size (80%, auto);
    margin: auto;
    border-bottom: solid 1px $color-secondary;
    padding: 20px 0 20px 0;
    margin: auto;

    &__id {
        @include flexbox(row, wrap, flex-start, center);
        margin: 5px 0 5px 0;

        &__photo {
            @include size(50px);
            border-radius: 50%;
            margin: 0 15px 0 0;
            padding: 1px;
            border: solid 1px $color-basic-dark;
            transition: all 200ms ease-in-out;
        
            &:hover {
                border: solid 2px $color-primary-dark;
                padding: 0;
            };
        
            img {
                @include size(100%);
                object-fit: cover;
                border-radius: 50%;
            };
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

</style>