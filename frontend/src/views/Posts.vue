<template>

	<div id="all-posts">
		<PostsHeader/>

		<main>

			<section id="all-posts-content">
                <h1>Accueil</h1>

                <div class="add-post">
                    <div class="add-post__text">
                        <textarea name="new-post" id="new-post" placeholder="Nouveau message"></textarea>
                    </div>

                    <div class="add-post__btn">
                        <div class="add-post__btn__btn-image" title="Ajouter une image">
                            <label for="post-img">
                                <i class="fas fa-image" aria-label="Ajouter une image" role="img"></i>
                            </label>
                            <input type="file" name="post-img" id="post-img" accept="image/png, image/jpeg, image/jpg">
                        </div>

                        <div class="add-post__btn__btn-send">
                            <input type="submit" value="Envoyer">
                        </div>
                    </div>
                </div>


                <div id="all-posts-list">

                    <!-- if no posts -->
                    <div id="no-posts" v-if="!posts">
                        <p>
                            Il n'y a pas encore de message.
                        </p>
                    </div>

                    <!-- if posts -->
                    <div id="posts">

                        <div class="post" v-for="post in posts" :key="post.post_id">
                            <div class="delete-post" v-if="post.userId === currentUserId || currentUserRole === 'admin'">
                                <i class="fas fa-times" aria-label="Supprimer" role="button"></i>
                            </div>

                            <div class="post__title">
                                <div class="post__title__photo">
                                    <router-link :to="{ name: 'UserPosts', params: { userId: post.userId } }" title="Voir le profil de l'utilisateur">
                                        <img
                                            :src="post.userPhoto"
                                            alt="Avatar de l'utilisateur"
                                        />
                                    </router-link>
                                </div>
                                <div class="post__title__txt">
                                    <div class="post__title__pseudo">
                                        <router-link :to="{ name: 'UserPosts', params: { userId: post.userId } }" title="Voir le profil de l'utilisateur">
                                            <p>{{post.pseudo}}</p>
                                        </router-link>
                                    </div>
                                    <div class="post__title__divider">
                                        <p>-</p>
                                    </div>
                                    <div class="post__title__date">
                                        <p>{{post.createdAt}}</p>
                                    </div>
                                </div>
                            </div>

                            <div class="post__text">
                                <p>
                                    {{post.text}}
                                </p>
                            </div>

                            <div class="post__img">
                                <img
                                    :src="post.file"
                                    alt="Photo d'un pic-épeiche"
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

import { API } from '@/axios.config.js'


export default {
	name: 'Posts',
	components: {
		ScrollToTopBtn,
		PostsHeader,
	},
    data() {
        return {
            Posts: [],
            post: ''
        }
    },
    methods: {
        getAllPosts() {
            API.get(`posts/`)
           .then(response => {
                this.posts = response.data.Posts;
            })
            .catch(error => console.log(error));
        }
    },
    created() {
        this.getAllPosts();
    }
};

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#all-posts {
    @include main   
};


#all-posts-content {
    @include page;
    margin: auto;
};


.add-post {
    @include first-under-h1;
    @include size(100%);
    @include flexbox(row, wrap, space-around, center);
    padding: 30px 0 20px 0;

    &__text {
        @include flexbox(column, nowrap, space-around, center);
        @include size(80%, auto);
        margin: auto;
        
        textarea {
            @include size(100%, 150px);
            margin: 10px 0 10px 0;
            padding: 10px;
            border: solid 1px $color-secondary; 
            font-size: 1rem;
            font-family: $montserrat;
        };
    };


    &__btn {
        @include flexbox(row, nowrap, space-between, center);
        margin: auto;
        @include size(80%, auto);
    
        &__btn-image {
            @include flexbox(row, nowrap, center, center);
            margin: 10px 10px 10px 30px;
            transition: all 200ms ease-in-out;

            input {
                @include size(0);
                opacity: 0;
            };

            i {
                font-size: 3rem;
                text-align: center;
            };

            &:hover {
                color: $color-primary-dark;

                label {
                    cursor: pointer;
                }
            };
        };

        &__btn-send {
            @include btn;
            @include btn-new-post-comm;
            margin: 10px 30px 10px 10px;

        };
    };
};



#all-posts-list {
    border-bottom: none;
    @include size(100%);
    @include flexbox(column, nowrap, space-around, center);

    @include lg {
        border-left: solid 1px $color-secondary; 
    };
};


#no-posts {
    @include no-results;
};




.post {
    @include position(relative, auto, auto, auto, auto);
    @include size (100%, auto);
    border-bottom: solid 1px $color-secondary;
    padding: 30px 0 30px 0;

    &__title {
        @include flexbox(row, wrap, flex-start, center);
        margin: 5px 0 5px 0;

        &__photo {
            @include user-photo;
        };

        &__txt {
            @include flexbox(row, nowrap, flex-start, baseline);
        };

        &__pseudo {
            @include user-pseudo;
        };

        &__divider {
            margin: 0 5px 0 0;
            color: $color-secondary-dark;
        };

        &__date {
            margin: 0 0 0 0;
            color: $color-secondary-dark;
            font-size: 0.9rem;
        };
    };

    &__text {
        margin: 5px 0 5px 0;
    };

    &__img {
        @include post-img;
    };

    &__buttons {
        @include flexbox(row, nowrap, space-around, center);
        margin: auto;
        max-width: 600px;
    };

    &__btn {
        @include flexbox(row, nowrap, center, center);
        padding : 5px 20px 0 20px;
        color: $color-secondary-dark;
        transition: all 200ms ease-in-out;
        
        &:hover {
            cursor: pointer;
        };

        &__icon {
            margin: 0 10px 0 0;
            
            i {
                border-radius: 50%;
                padding: 10px;
            };
        }; 
        
        &--comment {
            &:hover {
                color: $color-basic-dark;

                i {
                    background-color: $color-basic-dark-lighter;
                };
            };
        };
    
        &--like {
            &:hover {
                color: $color-primary-dark;
                i {
                    background-color: $color-primary-light;
                };
            };
        };
    }; 
    
    .delete-post {
        @include delete-post-comment;
        @include position(absolute, 30px, 20px, auto, auto);

    };
};

</style>