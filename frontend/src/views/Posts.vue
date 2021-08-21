<template>

	<div id="all-posts">

		<PostsHeader/>

		<main v-if="this.currentUserId">

			<section id="all-posts-content">
                <h1>Messages</h1>

                <form enctype="multipart/form-data" class="add-post">
                    <div class="add-post__text">
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
                        <div class="add-post__btn__btn-image" title="Ajouter une image (formats .jpeg, .jpg, .png ou .gif)">
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
                    <!-- if posts -->
                    <div id="posts" v-if="posts[0]">

                        <div class="post" v-for="post in posts" :key="post.post_id">
                            <div
                                class="delete-post"
                                title="Supprimer le message"
                                v-if="post.fk_user_id == currentUserId || currentUserRole == 'admin'"
                                @click.prevent="deletePost(post)"
                            >
                                <i class="fas fa-times" aria-label="Supprimer le message" role="button"></i>
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
                        <p>Il n'y a pas encore de message.</p>
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
	name: 'Posts',

	components: {
		ScrollToTopBtn,
		PostsHeader
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
        this.currentUserId = localStorage.getItem('userId');
        this.currentUserRole = localStorage.getItem('role');

        this.getAllPosts();
        this.moment();
    },

    methods: {
        // display all posts

        getAllPosts() {
            API.get(`posts/`)
           .then(response => {
                this.posts = response.data.posts;
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


        // add new post

        handleFileUpload() {
            this.file = this.$refs.file.files[0];
			this.newImage = URL.createObjectURL(this.file);
        },

        checkPost() {
            if(!this.validPost(this.text)) { // if not validated
                this.errorMessage = 'Votre message est trop long (255 caractères maximum) ou comprend des caractères non autorisés.';
            } else { // if ok
                this.createPost(); // send the form
            }
        },

        validPost(text) {
            const regex = /^[-\w\sÀÁÂÄÅÇÈÉÊËÌÍÎÏÑŒÒÓÔÕÖØÙÚÛÜàáâäåçèéêëìíîïñœòóôõöøùúûü.,!"':;\\?/$£€() ]{0,255}$/;
            return regex.test(text);
        },

        createPost() {
            const formData = new FormData();
            formData.append('image', this.file); // must be 'image' because multer save .single('image')
            formData.append('text', this.text);
            formData.append('userId', this.currentUserId);

            if(this.file != '' || this.text != '') { // if post not empty
                API.post(`posts/`, formData)
                .then(response => {
                    console.log(response);
                    this.text = '';
                    this.file = '';
                    this.newImage = '';
                    this.errorMessage = '';
                    this.getAllPosts();
                })
                .catch(error => console.log(error));
            } else {
                this.errorMessage = 'Vous ne pouvez pas envoyer un message vide.';
            }
        },

        emptyForm() {
            this.text = '';
            this.file = '';
            this.newImage = '';
            this.errorMessage = '';
        },


        // delete post

        deletePost(post) {
            API.delete(`posts/${post.post_id}`)
            .then(response => {
                console.log(response);
                this.getAllPosts();
            })
            .catch(error => console.log(error));
        }
    }
};

</script>


<style lang='scss'>

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#all-posts {
    @include main;
};


#all-posts-content {
    @include page;
};


.add-post {
    @include first-under-h1;
    @include flexbox(row, wrap, space-around, center);
    @include size(100%);
    padding: 30px 0 20px 0;

    &__text {
        @include flexbox(column, nowrap, space-around, center);
        @include size(80%, auto);
        margin: auto;

        textarea {
            font-size: map-get($font-size, input);
            font-family: $montserrat;
            @include size(100%, 150px);
            margin: 10px 0 10px 0;
            padding: 10px;
            border: solid 1px $color-secondary;
        };
    };

    &__image {
        @include post-img;
        @include size(80%, auto);
    };

    &__btn {
        @include flexbox(row, wrap, space-around, center);
        @include size(80%, auto);
        margin: auto;
        padding: 0 30px 0 30px;

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
                };
            };
        };

        &__btn-send {
            @include btn;
            @include btn-new-post-comm;
            margin: 10px 10px 10px 10px;
        };

        &__btn-undo {
            @include btn;
            @include btn-undo;
            margin: 10px 10px 10px 10px;
        };
    };

    .submit-errors {
        @include form-errors;
        margin: 20px 0 20px 0;

        @include sm {
            max-width: 480px;
        };
    };
};


#all-posts-list {
    @include flexbox(column, nowrap, space-around, center);
    @include size(100%);
    border-bottom: none;

    @include lg {
        border-left: solid 1px $color-secondary;
    };
};


.post {
    @include position(relative, auto, auto, auto, auto);
    @include size (100%, auto);
    padding: 30px 0 10px 0;
    border-bottom: solid 1px $color-secondary;

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
            color: $color-secondary-dark;
            margin: 0 5px 0 0;
        };

        &__date {
            font-size: map-get($font-size, date);
            color: $color-secondary-dark;
            margin: 0 0 0 0;
        };
    };

    &__text {
        margin: 5px 0 5px 0;
    };

    &__img {
        @include post-img;
    };

    @include enlarge-img;

    &__link {
        @include flexbox(row, nowrap, center, center);

        p {
            font-weight: 500;
            color: $color-secondary-dark;
            padding: 20px 20px 20px 20px;
            transition: all 200ms ease-in-out;

            &:hover {
                @include underlined(1px, 4px);
                color: $color-primary-dark;
            };

            i {
                padding: 0 10px 0 0;
            };
        };
    };

    .delete-post {
        @include delete-post-comment;
        @include position(absolute, 30px, 0px, auto, auto);
    };
};


#no-posts {
    @include no-results;
};


.access-denied {
    @include access-denied;
    @include access-denied-posts;
};

</style>
