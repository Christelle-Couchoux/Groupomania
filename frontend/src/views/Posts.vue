<template>

	<div id="all-posts">
		<PostsHeader/>

		<main>

			<section id="all-posts-content">
                <h1>Accueil</h1>

                <form enctype="multipart/form-data" class="add-post">
                    <div class="add-post__text" >
                        <textarea
                            name="new-post"
                            id="new-post"
                            placeholder="Nouveau message"
                            v-model="text"
                        ></textarea>
                    </div>
                    <div class="add-post__image" v-if="newImage">
                        <img :src="newImage">
                    </div>

                    <div class="add-post__btn">
                        <div class="add-post__btn__btn-image" title="Ajouter une image">
                            <label for="file">
                                <i class="fas fa-image" aria-label="Ajouter une image" role="img"></i>
                            </label>
                            <!-- name must be 'image' because multer save .single('image') -->
                            <input
                                type="file"
                                name="image" 
                                id="file"
                                accept="image/png, image/jpeg, image/jpg, image/gif"
                                ref="file"
                                @change="handleFileUpload"
                            >
                        </div>

                        <div class="add-post__btn__btn-send">
                            <input type="submit" value="Envoyer" @click.prevent="checkPost">
                        </div>

                        <div class="add-post__btn__btn-undo">
                            <input type="submit" value="Annuler" @click.prevent="emptyForm">
                        </div>

                    </div>

                    <div class="submit-errors" v-if="errorMessage">
                        <p>{{ errorMessage }}</p>
                    </div>
                </form>


                <div id="all-posts-list">

                    <!-- if no posts -->
                    <div id="no-posts" v-if="!posts">
                        <p>
                            Il n'y a pas encore de message.
                        </p>
                    </div>

                    <!-- if posts -->
                    <div id="posts" v-else>

                        <div class="post" v-for="post in posts" :key="post.post_id">
                            <router-link :to="{ name: 'Post', params: { postId: post.post_id } }" title="Voir le message">
                                <div
                                    class="delete-post"
                                    v-if="post.fk_user_id == currentUserId || currentUserRole == 'admin'"
                                    @click.prevent="deletePost(post)"
                                >
                                    <i class="fas fa-times" aria-label="Supprimer" role="button"></i>
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
                                            <p>{{ post.comments_count }}</p>
                                        </div>
                                    </div>
                                    <div class="post__btn post__btn--like" title="Aimer">
                                        <div class="post__btn__icon">
                                            <i class="far fa-heart" aria-label="Aimer" role="img"></i>
                                        </div>
                                        <div class="post__btn__counter">
                                            <p>{{ post.post_likes_count }}</p>
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
	name: 'Posts',
    
	components: {
		ScrollToTopBtn,
		PostsHeader,
	},

    data() {
        return {
            posts: {},
            post: '',
            file: '',
            text: '',
            userId: '',
            newImage: '',
            errorMessage: null
        }
    },

    created() {
        this.currentUserId = localStorage.getItem("userId");
        this.currentUserPseudo = localStorage.getItem("pseudo");
        this.currentUserRole = localStorage.getItem("role");

        this.getAllPosts();
        this.moment();
    },

    methods: {
        getAllPosts() { // OK
            API.get(`posts/`)
           .then(response => {
                this.posts = response.data.posts;
            })
            .catch(error => console.log(error));
        },

        moment() {
            this.moment = moment;
        },

        handleFileUpload() { // OK
            this.file = this.$refs.file.files[0];
			this.newImage = URL.createObjectURL(this.file);
            //console.log(this.file); // ok
        },

        checkPost() {
            if(!this.validPost(this.text)) {
                this.errorMessage = 'Votre message peut comprendre au maximum 255 caractères.';
            } else { // if no errors
                this.createPost(); // send the form
            }
        },

        validPost(text) {
            const regex = /^[-\w\sÀÁÂÄÅÇÈÉÊËÌÍÎÏÑŒÒÓÔÕÖØÙÚÛÜàáâäåçèéêëìíîïñœòóôõöøùúûü.,!"'\\?/$ ]{0,255}$/;
            return regex.test(text);
        },
        
        createPost() { // NOT WORKING FOR IMAGE, TEXT OK
            const formData = new FormData();
            formData.append('image', this.file) // must be 'image' because multer save .single('image')
            formData.append('text', this.text)
            formData.append('userId', this.currentUserId);

            //for (var value of formData.values()) { console.log(value); } // ok

            if(this.file != '' || this.text != '') {
                API.post(`posts/`, formData)
                .then(response => console.log(response))
                .catch(error => console.log(error));
            } else {
                this.errorMessage = 'Vous ne pouvez pas envoyer un message vide.';
            }
    
            window.location.reload();
        },

        emptyForm() {
            this.file = '',
            this.newImage = '',
            this.text = '',
            this.errorMessage = ''
        },

        deletePost(post) {
            API.delete(`posts/${post.post_id}`)
            .then(response => console.log(response))
            .catch(error => console.log(error));
            console.log();

            window.location.reload();
        }
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
    @include size(100%, auto);
    margin: auto;

    @include lg {
        @include size(calc(100% - 250px), auto);
    };
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

    &__image {
        @include post-img;
        @include size(80%, auto);
    };


    &__btn {
        @include flexbox(row, wrap, space-around, center);
        margin: auto;
        padding: 0 30px 0 30px;
        @include size(80%, auto);
    
        &__btn-image {
            @include flexbox(row, nowrap, center, center);
            margin: 10px 10px 10px 10px;
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
            margin: 10px 10px 10px 10px;

        };

        &__btn-undo {
            @include btn;
            @include btn-undo-profile;
            margin: 10px 10px 10px 10px;
        };
    };

    .submit-errors {
        @include form-errors;
        margin: 20px 0 20px 0;
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