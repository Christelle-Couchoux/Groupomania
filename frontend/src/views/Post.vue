<template>

	<div id="specific-post">

		<PostsHeader/>

		<main v-if="this.currentUserId">

			<section id="specific-post-content">
                <h1>Message</h1>

                <div id="specific-post-details" v-for="postInfo in post" :key="postInfo.post_id">
                    <div class="specific-post">
                        <div
                            class="delete-specific-post"
                            title="Supprimer le message"
                            v-if="postInfo.user_id == currentUserId || currentUserRole == 'admin'"
                            @click.prevent="deletePost"
                        >
                            <i class="fas fa-times" aria-label="Supprimer le message" role="button"></i>
                        </div>

                        <div class="specific-post__title">
                            <div class="specific-post__title__photo">
                                <router-link :to="{ name: 'UserPosts', params: { userId: postInfo.user_id } }" title="Voir le profil de l'utilisateur">
                                    <img :src="postInfo.user_photo" alt="Avatar de l'utilisateur">
                                </router-link>
                            </div>

                            <div class="specific-post__title__pseudo">
                                <router-link :to="{ name: 'UserPosts', params: { userId: postInfo.user_id } }" title="Voir le profil de l'utilisateur">
                                    <p>{{ postInfo.pseudo }}</p>
                                </router-link>
                            </div>
                        </div>

                        <div class="specific-post__date-time">
                            <div class="specific-post__date">
                                <p>{{ moment(postInfo.createdAt).format('[Le] D MMMM YYYY [à] HH:mm') }}</p>
                            </div>
                        </div>

                        <div class="specific-post__text" v-if="postInfo.post_text">
                            <p>{{ postInfo.post_text }}</p>
                        </div>

                        <div
                            class="specific-post__img"
                            v-if="postInfo.post_file"
                            @click="enlarge"
                        >
                            <img :src="postInfo.post_file"/>
                        </div>

                        <!-- popup window enlarge img -->
                        <div
                            id="modal-img"
                            class="modal"
                            title="Fermer l'image"
                            @click.prevent="closeImg"
                        >
                            <img :src="postInfo.post_file"/>
                        </div>

                        <div class="specific-post__buttons">
                            <div
                                class="specific-post__btn specific-post__btn--comment"
                                title="Voir les commentaires"
                                v-for="commCount in commentsCount" :key="commCount.post_id"
                                @click="scrollMeTo('comments-list')"
                            >
                                <div class="specific-post__btn__icon">
                                    <i class="far fa-comment" aria-label="Voir les commentaires" role="img"></i>
                                </div>
                                <div class="specific-post__btn__counter">
                                    <p>{{ commCount.comments_count }}</p>
                                </div>
                            </div>

                            <div
                                class="specific-post__btn specific-post__btn--like"
                                title="Aimer"
                                @click.prevent="like()"
                                v-for="likeCount in likes" :key="likeCount.post_id"
                            >
                                <div class="specific-post__btn__icon">
                                    <i id="heart-btn" class="far fa-heart" aria-label="Aimer" role="img"></i>
                                </div>
                                <div id="heart-count" class="specific-post__btn__counter">
                                    <p>{{ likeCount.post_likes_count }}</p>
                                </div>
                            </div>
                        </div> 
                    </div>
                    <!-- post end -->

                    <!-- add comment -->
                    <form class="add-comment">
                        <div class="add-comment__text">
                            <textarea
                                name="new-comment"
                                id="new-comment"
                                placeholder="Nouveau commentaire"
                                v-model="text"
                            ></textarea>
                        </div>

                        <div class="add-comment__btn">
                            <div class="add-comment__btn__btn-send">
                                <input type="submit" value="Envoyer" @click.prevent="checkComment">
                            </div>

                            <div class="add-comment__btn__btn-undo">
                                <input type="submit" value="Annuler" @click.prevent="emptyForm">
                            </div>
                        </div>

                        <div class="submit-errors" v-if="errorMessage">
                            <p>{{ errorMessage }}</p>
                        </div>
                    </form>
                    <!-- add comment end -->

                    <!-- comments -->
                    <!-- if comments -->
                    <div id="comments-list" ref="comments-list" v-if="comments[0]">

                        <div class="comment" v-for="comment in comments" :key="comment.comment_id">
                            <!-- if own comment -->
                            <div
                                class="delete-comment"
                                title="Supprimer le commentaire"
                                v-if="comment.user_id == currentUserId || currentUserRole == 'admin'"
                                @click.prevent="deleteComment(comment)"
                            >
                                <i class="fas fa-times" aria-label="Supprimer le commentaire" role="button"></i>
                            </div>

                            <div class="comment__title">
                                <div class="comment__title__photo">
                                    <router-link :to="{ name: 'UserPosts', params: { userId: comment.user_id } }" title="Voir le profil de l'utilisateur">
                                        <img
                                            :src="comment.user_photo"
                                            alt="Avatar de l'utilisateur"
                                        />
                                    </router-link>
                                </div>
                                <div class="comment__title__txt">
                                    <div class="comment__title__pseudo">
                                        <router-link :to="{ name: 'UserPosts', params: { userId: comment.user_id } }" title="Voir le profil de l'utilisateur">
                                            <p>{{ comment.pseudo }}</p>
                                        </router-link>
                                    </div>
                                    <div class="comment__title__divider">
                                        <p>-</p>
                                    </div>
                                    <div class="comment__title__date">
                                        <p>{{ moment(comment.createdAt).fromNow() }}</p>
                                    </div>
                                </div>
                            </div>

                            <div class="comment__text">
                                <p>{{ comment.comment_text }}</p>
                            </div>
                        </div>

                        <div id="comments-end">
                            <p>Fin des commentaires.</p>
                        </div>

                    </div>

                    <!-- if no comments -->
                    <div id="no-comments"  v-else>
                        <p>Ce message n'a pas encore de commentaire.</p>
                    </div>

                   <!-- comments end -->
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
import router from '@/router/index.js'


export default {
	name: 'Post',

	components: {
		ScrollToTopBtn,
		PostsHeader
	},

    data() {
        return {
            post: {},
            postInfo: '',
            text: '',
            comments: {},
            comment: '',
            errorMessage: null,
            likes: [],
            commentsCount: []     
        }
    },

    created() {
        this.currentUserId = localStorage.getItem('userId');
        this.currentUserRole = localStorage.getItem('role');

        this.postId = this.$route.params.postId;

        this.getOnePost();
        this.moment();
        this.getComments();
        this.getLikesCount();
        this.getCommentsCount();
        this.getIfUserLiked();
    },

    methods: {
        // display one post

        getOnePost() {
            API.get(`posts/${this.postId}`)
           .then(response => {
                this.post = response.data.post;
            })
            .catch(error => console.log(error));
        },

        moment() {
            this.moment = moment;
        },


        // enlarge image in popup window

        enlarge() {
            const modal = document.getElementById('modal-img');
            modal.style.display = "flex";
        },

        closeImg() {
            const modal = document.getElementById('modal-img');
            modal.style.display = "none";
        },


        // delete post

        deletePost() {
            API.delete(`posts/${this.postId}`)
            .then(response => {
                console.log(response);
                router.replace('/posts'); // replace so can't go back to deleted page
            })
            .catch(error => console.log(error));
        },


        // scroll to comments list

        scrollMeTo(refName) {
            const el = this.$refs[refName];
            el.scrollIntoView({ behavior: 'smooth' });
        },


        // add new comment

        checkComment() {
            if(!this.validComment(this.text)) { // if not validated
                this.errorMessage = 'Votre commentaire est trop long (255 caractères maximum) ou comprend des caractères non autorisés.';
            } else { //if ok
                this.createComment(); // send the form
            }
        },

        validComment(text) {
            const regex = /^[-\w\sÀÁÂÄÅÇÈÉÊËÌÍÎÏÑŒÒÓÔÕÖØÙÚÛÜàáâäåçèéêëìíîïñœòóôõöøùúûü.,!"':;\\?/$£€() ]{0,255}$/;
            return regex.test(text);
        },

        createComment() {
            if(this.text != '') { // if comment not empty
                API.post(`posts/${this.postId}/comments`,
                {
                    userId: this.currentUserId,
                    postId: this.postId,
                    text: this.text
                })
                .then(response => {
                    console.log(response);
                    this.emptyForm();
                    this.getComments();
                    this.getCommentsCount();
                    this.scrollMeTo('comments-list');
                })
                .catch(error => console.log(error));
            } else {
                this.errorMessage = 'Vous ne pouvez pas envoyer un commentaire vide.';
            }
        },

        emptyForm() {
            this.text = '';
            this.errorMessage = '';
        },


        // display all comments of post

        getComments() {
            API.get(`posts/${this.postId}/comments`)
           .then(response => {
                this.comments = response.data.comments;
            })
            .catch(error => console.log(error));
        },


        // delete comment

        deleteComment(comment) {
            API.delete(`comments/${comment.comment_id}`)
            .then(response => {
                console.log(response);
                this.getComments();
                this.getCommentsCount();
            })
            .catch(error => console.log(error));
        },


        // like post

        like() {
            API.post(`posts/${this.postId}/likes`,
            {
                userId: localStorage.getItem("userId"),
                postId: this.postId
            })
            .then(response => {
                console.log(response);
                this.getLikesCount();
                this.getIfUserLiked();
            })
            .catch(error => console.log(error));    
        },


        // display number of likes and comments of post

        getLikesCount() {
            API.get(`posts/${this.postId}/likesCount`)
           .then(response => {
                this.likes = response.data.likes;
            })
            .catch(error => console.log(error));
        },

        getCommentsCount() {
            API.get(`posts/${this.postId}/commentsCount`)
           .then(response => {
                this.commentsCount = response.data.commentsCount;
            })
            .catch(error => console.log(error));
        },


        // display if current user likes post

        getIfUserLiked() {
            API.get(`posts/${this.postId}/userLiked/${this.currentUserId}`)
            .then(response => {
                if(response.data == "true") {
                    const btn = document.getElementById('heart-btn');
                    btn.classList.remove('far');
                    btn.classList.add('fas');
                    const count = document.getElementById('heart-count');
                    count.classList.add('liked');
                } else if(response.data == "false") {
                    const btn = document.getElementById('heart-btn');
                    btn.classList.remove('fas');
                    btn.classList.add('far');
                    const count = document.getElementById('heart-count');
                    count.classList.remove('liked');
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


#specific-post {
    @include main;
};


#specific-post-content {
    @include page;
};


#specific-post-details {
    @include first-under-h1;
    @include flexbox(column, nowrap, space-around, center);
    @include size(100%);
    border-bottom: none;
};


.specific-post {
    @include position(relative, auto, auto, auto, auto);
    @include size (80%, auto);
    margin: auto;
    padding: 30px 0 30px 0;
    border: none;

    &__title {
        @include flexbox(row, wrap, flex-start, center);
        margin: 5px 0 5px 0;

        &__photo {
            @include user-photo;
        };

        &__pseudo {
            @include user-pseudo;
        };
    };

    &__date-time {
        @include flexbox(row, nowrap, flex-start, baseline);
        color: $color-secondary-dark;

        p {
            margin: 0 5px 0 0;
        };
    };

    &__text {
        margin: 10px 0 5px 0;
    };

    &__img {
        @include post-img;
    };

    @include enlarge-img;

    &__likes {
        @include btn-like-count;
    };

    .delete-specific-post {
        @include delete-post-comment;
        @include position(absolute, 30px, 20px, auto, auto);
    };

    &__buttons {
        @include flexbox(row, nowrap, space-around, center);
        max-width: 600px;
        margin: auto;
    };

    &__btn {
        color: $color-secondary-dark;
        @include flexbox(row, nowrap, center, center);
        padding : 5px 20px 0 20px;
        transition: all 200ms ease-in-out;

        &:hover {
            cursor: pointer;
        };

        &__icon {
            margin: 0 10px 0 0;

            i {
                padding: 10px;
                border-radius: 50%;
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
            .fas {
                color: $color-primary-dark;
            };

            .liked {
                color: $color-primary-dark;
            };

            &:hover {
                color: $color-primary-dark;

                i {
                    background-color: $color-primary-light;
                };
            };
        };
    };
};


.add-comment {
    @include flexbox(column, wrap, space-around, center);
    @include size (100%, auto);
    margin: 0 0 30px 0;
    padding: 30px 0 30px 0;
    border-bottom: solid 1px $color-secondary;
    border-top: solid 1px $color-secondary;

    &__text {
        @include size(80%, auto);
        margin: auto;

        textarea {
            font-size: map-get($font-size, input);
            font-family: $montserrat;
            @include size(100%, 150px);
            padding: 10px;
            border: solid 1px $color-secondary;
        };
    };

    &__btn {
        @include flexbox(row, wrap, space-around, center);
        padding: 0 30px 0 30px;

        &__btn-send {
            @include btn;
            @include btn-new-post-comm;
            margin: 30px 10px 0 10px;
        };

        &__btn-undo {
            @include btn;
            @include btn-undo;
            margin: 30px 10px 0 10px;
        };
    };

    .submit-errors {
        @include form-errors;
        margin: 30px 0 10px 0;

        @include sm {
            max-width: 520px;
        };
    };
};


#comments-list {
    @include flexbox(column, nowrap, space-around, center);
    @include size (100%, auto);
};

  
.comment {
    @include position(relative, auto, auto, auto, auto);
    @include size (80%, auto);
    margin: auto;
    padding: 20px 0 20px 0;
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

    .delete-comment {
        @include delete-post-comment;
        @include position(absolute, 20px, 0px, auto, auto);
    };
};


#comments-end {
    margin: 50px 0 50px 0;
};

</style>
