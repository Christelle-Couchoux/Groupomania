<template>

	<div id="user-profile">
		<PostsHeader/>

		<main>

			<section id="user-profile-content">
                <h1>{{ currentUserPseudo }}</h1>
                
                <!-- user info -->

                <div id="user-posts">

                    <!-- profil nav -->

                    <!-- if no posts or comments liked yet -->
                    <div id="no-posts">
                        <p>
                            {{currentUserPseudo}} n'a pas encore aimé de message ou commentaire.
                        </p>
                    </div>

                    <!-- if posts or comments liked -->
                    <div id="likes">


                        <div id="posts-end">
                            <p>Fin des messages et commentaires aimés.</p>
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
	name: 'UserLikes',
	components: {
		ScrollToTopBtn,
		PostsHeader,
	},
    created() {
        this.currentUserId = localStorage.getItem("userId");
        this.currentUserPseudo = localStorage.getItem("pseudo");
        this.currentUserPhoto = localStorage.getItem("photo");
    }	
};

</script>


<style scoped lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#likes {
    @include size (80%, auto);
    margin: 0 0 50px 0;
    @include flexbox(column, nowrap, space-around, center);

    .comment {
        padding: 20px 0 20px 0;
        border-bottom: solid 1px $color-secondary;
    };
};

</style>

