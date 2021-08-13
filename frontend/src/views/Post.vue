<template>

	<div id="specific-post">
		<PostsHeader/>

		<main>

			<section id="specific-post-content">
                <h1>Message</h1>

                <div id="specific-post-details" v-for="postInfo in post" :key="postInfo.post_id">
                    <div class="specific-post">
                        <div
                            class="delete-specific-post"
                            v-if="postInfo.user_id == currentUserId || currentUserRole == 'admin'"
                            @click.prevent="deletePost"
                        >
                            <i class="fas fa-times" aria-label="Supprimer" role="button"></i>
                        </div>

                        <div class="specific-post__title">
                            <div class="specific-post__title__photo">
                                <router-link :to="{ name: 'UserPosts', params: { userId: postInfo.user_id } }" title="Voir le profil de l'utilisateur">
                                    <img :src="postInfo.user_photo" alt="Avatar de l'utilisateur 2">
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
                            <p>
                                {{ postInfo.post_text }}
                            </p>
                        </div>

                        <div class="specific-post__img" v-if="postInfo.post_file">
                            <img
                                :src="postInfo.post_file"
                            />
                        </div>

                        <div class="specific-post__buttons">
                            <div class="specific-post__btn specific-post__btn--comment" title="Commentaires">
                                <div class="specific-post__btn__icon">
                                    <i class="far fa-comment" aria-label="Commentaires" role="img"></i>
                                </div>
                                <div class="specific-post__btn__counter">
                                    <p>{{ postInfo.comments_count }}</p>
                                </div>
                            </div>
                            <div class="specific-post__btn specific-post__btn--like" title="Aimer">
                                <div class="specific-post__btn__icon">
                                    <i class="far fa-heart" aria-label="Aimer" role="img"></i>
                                </div>
                                <div class="specific-post__btn__counter">
                                    <p>{{ postInfo.post_likes_count }}</p>
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
                    <!-- if no comments -->
                    <div id="no-comments"  v-if="!comments">
                        <p>
                            Il n'y a pas encore de commentaire.
                        </p>
                    </div>

                    <!-- if comments -->
                    <div id="comments-list">

                        <div class="comment" v-for="comment in comments" :key="comment.comment_id">
                            <!-- if own comment -->
                            <div
                                class="delete-comment"
                                v-if="comment.user_id == currentUserId || currentUserRole == 'admin'"
                                @click.prevent="deleteComment(comment)"
                            >
                                <i class="fas fa-times" aria-label="Supprimer" role="button"></i>
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
                   <!-- comments end -->

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
import router from '@/router/index.js'


export default {
	name: 'Post',
	components: {
		ScrollToTopBtn,
		PostsHeader,
	},

    data() {
        return {
            post: {},
            postInfo: '',
            text: '',
            comments: {},
            comment: '',
            errorMessage: null
        }
    },

    created() {
        this.currentUserId = localStorage.getItem("userId");
        this.currentUserPseudo = localStorage.getItem("pseudo");
        this.currentUserRole = localStorage.getItem("role");

        this.postId = this.$route.params.postId;

        this.getOnePost();
        this.moment();
        this.getComments();
    },

    methods: {
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

        checkComment() {
            if(!this.validComment(this.text)) {
                this.errorMessage = 'Votre commentaire doit comprendre entre 1 et 255 caractères.';
            } else { //if no errors
                this.createComment(); // send the form
            }
        },

        validComment(text) {
            const regex = /^[-\w\sÀÁÂÄÅÇÈÉÊËÌÍÎÏÑŒÒÓÔÕÖØÙÚÛÜàáâäåçèéêëìíîïñœòóôõöøùúûü.,!"'\\?/$ ]{0,255}$/;
            return regex.test(text);
        },

        createComment() {
            API.post(`posts/${this.postId}/comments`,
            {
                userId: this.currentUserId,
                postId: this.postId,
                text: this.text
            })
            .then(response => console.log(response))
            .catch(error => console.log(error));
            //window.location.reload();
        },

        emptyForm() {
            this.text = '',
            this.errorMessage = ''
        },

        getComments() {
            API.get(`posts/${this.postId}/comments`)
           .then(response => {
                this.comments = response.data.comments;
            })
            .catch(error => console.log(error));
        }, 

        deletePost() {
            API.delete(`posts/${this.postId}`)
            .then(response => console.log(response))
            .catch(error => console.log(error));
            console.log(this.post_id);

            router.push('/posts');
        },

        deleteComment(comment) {
            API.delete(`comments/${comment.comment_id}`)
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


#specific-post {
    @include main; 
};


#specific-post-content {
    @include page;
    @include size(100%, auto);
    margin: auto;

    @include lg {
        @include size(calc(100% - 250px), auto);
    };
};


#specific-post-details {
    @include first-under-h1;
    border-bottom: none;
    @include size(100%);
    padding: 0 0 50px 0;
    @include flexbox(column, nowrap, space-around, center);
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

    &__likes {
        @include btn-like-count;    
    };

    .delete-specific-post {
        @include delete-post-comment;
        @include position(absolute, 30px, 20px, auto, auto);
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
  
};


.add-comment {
    @include size (100%, auto);
    @include flexbox(column, wrap, space-around, center);
    padding: 30px 0 30px 0;
    border-bottom: solid 1px $color-secondary;
    border-top: solid 1px $color-secondary;
    margin: 0 0 30px 0;

    &__text {
        //@include flexbox(column, nowrap, space-around, center);
        @include size(80%, auto);
        margin: auto;

        textarea {
            @include size(100%, 150px);
            padding: 10px;
            border: solid 1px $color-secondary; 
            font-size: 1rem;
            font-family: $montserrat;
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
            @include btn-undo-profile;
            margin: 30px 10px 0 10px;
        };
    };

    .submit-errors {
        @include form-errors;
        margin: 30px 0 10px 0;
    };
    
};

#comments-list {
    @include size (100%, auto);
    padding: 0 0 30px 0;
    @include flexbox(column, nowrap, space-around, center);

    //border-bottom: solid 1px $color-secondary;
    //border-top: solid 1px $color-secondary;
    margin: 0 0 30px 0;
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

    &__likes {
        @include btn-like-count;
	};
    
    .delete-comment {
        @include delete-post-comment;
    };
};


#comments-end {
    margin: 50px 0 50px 0;
};

</style>
