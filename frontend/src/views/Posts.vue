<template>

	<div id="all-posts">
		<PostsHeader/>

		<main>

			<section id="all-posts-content">
                <h1>Accueil</h1>

                <div id="all-posts-list">

                    <!-- if no posts -->
                    <div id="no-posts">
                        <p>
                            Il n'y a pas encore de message.
                        </p>
                    </div>

                    <!-- if posts -->
                    <div id="posts">



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



export default {
	name: 'Posts',
	components: {
		ScrollToTopBtn,
		PostsHeader,

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
    @include size(80%, auto);
    @include page;
};


#all-posts-list {
    @include first-under-h1;
    border-bottom: none;
    @include size(100%);
    margin: 194px 0 50px 0;
    padding: 5px 0 50px 0;
    @include flexbox(column, nowrap, space-around, center);
};


#no-posts {
    @include no-results;
};


</style>