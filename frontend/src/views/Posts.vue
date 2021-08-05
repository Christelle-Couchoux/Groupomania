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
                    <div id="no-posts">
                        <p>
                            Il n'y a pas encore de message.
                        </p>
                    </div>

                    <!-- if posts -->
                    <div id="posts">

                        <OnePost/>
                        <OnePost/>
                        <OnePost/>

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
import OnePost from "../components/OnePost.vue"



export default {
	name: 'Posts',
	components: {
		ScrollToTopBtn,
		PostsHeader,
        OnePost
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


</style>