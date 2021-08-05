<template>

	<div id="specific-post">
		<PostsHeader/>

		<main>

			<section id="specific-post-content">
                <h1>Message</h1>

                <div id="specific-post-details">
                    <!-- post -->
                    <div class="specific-post">
                        <!-- if own post -->
                        <div class="delete-specific-post">
                            <i class="fas fa-times" aria-label="Supprimer" role="button"></i>
                        </div>

                        <div class="specific-post__title">
                            <div class="specific-post__title__photo">
                                <router-link to="/user/:userId/" title="Aller au profil utilisateur">
                                    <img src="@/assets/avatar/default-user-avatar3.png" alt="Avatar de l'utilisateur 2">
                                </router-link>
                            </div>

                            <div class="specific-post__title__pseudo">
                                <router-link to="/user/:userId/" title="Aller au profil utilisateur">
                                    <p>Utilisateur3</p>
                                </router-link>
                            </div>
                        </div>

                        <div class="specific-post__date-time">
                            <div class="specific-post__time">
                                <p>hh:mm</p>
                            </div>
                            <div class="specific-post__divider">
                                <p>-</p>
                            </div>
                            <div class="specific-post__date">
                                <p>jj mois aaaa</p>
                            </div>
                        </div>

                        <div class="specific-post__text">
                            <p>
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do 
                                eiusmod tempor incididunt ut labore et dolore magna aliqua.
                            </p>
                        </div>

                        <div class="specific-post__img">
                            <a href="@/assets/images/verdier.jpg" title="Agrandir la photo">
                                <img src="@/assets/images/verdier.jpg" alt="Photo d'un pic-épeiche">
                            </a>
                        </div>

                        <div class="specific-post__likes">
                            <div class="specific-post__likes__btn" title="Aimer">
                                <i class="far fa-heart" aria-label="Aimer" role="img"></i>
                            </div>
                            <div class="specific-post__likes__count" title="Voir les utilisateurs qui aiment ce message">
                                <router-link to="/posts/:postId/likes" title="Voir les utilisateurs qui aiment ce message">
                                    <p>3 &nbsp; J'aime</p>
                                </router-link>
                            </div>
                        </div>
                        

                        
                    </div>
                    <!-- post end -->

                    
                    <div class="add-comment">
                        <div class="add-comment__text">
                            <textarea name="new-comment" id="new-comment" placeholder="Nouveau commentaire"></textarea>
                        </div>
    
                        <div class="add-comment__btn">
                            <input type="submit" value="Envoyer">
                        </div>
                    </div>


                    <!-- comments -->
                    <!-- comment -->
                    <Comment/>
                    <Comment/>
                    <Comment/>
                    <!-- comment end -->
                </div>

            </section>
        </main>

		<ScrollToTopBtn/>

    </div>

</template>




<script>

import ScrollToTopBtn from "../components/ScrollToTopBtn.vue"
import PostsHeader from "../components/PostsHeader.vue"
import Comment from "../components/Comment.vue"



export default {
	name: 'Post',
	components: {
		ScrollToTopBtn,
		PostsHeader,
        Comment

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
    margin: auto;
};


#specific-post-details {
    @include first-under-h1;
    border-bottom: none;
    @include size(100%);
    padding: 0 0 50px 0;
    @include flexbox(column, nowrap, space-around, center);

    .comment {
        @include size (80%, auto);
        margin: auto;

        &:last-child {
            border: none;
        };
    };
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
};


.add-comment {
    @include size (100%, auto);
    padding: 30px 0 30px 0;
    border-bottom: solid 1px $color-secondary;
    border-top: solid 1px $color-secondary;
    margin: 0 0 30px 0;

    &__text {
        @include flexbox(column, nowrap, space-around, center);
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
        @include btn;
        @include btn-new-post-comm;
        margin: 30px 0 0 0;
    };
};





</style>
