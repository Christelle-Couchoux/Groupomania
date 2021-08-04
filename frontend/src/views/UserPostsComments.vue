<template>

	<div id="user-profile">
		<PostsHeader/>

		<main>

			<section id="user-profile-content">
                <h1>Pseudo</h1>
                
                <UserInfo>
                    <template v-slot>
                        <div class="edit-profile-btn">
                            <router-link to="/user/:userId/edit" title="Éditer le profil">
                                <input type="button" value="Éditer le profil"/>
                            </router-link>
                        </div>
                    </template>
                </UserInfo>

                <div id="user-posts">

                    <ProfileNav/>

                    <!-- if no posts or comments liked yet -->
                    <div id="no-posts">
                        <p>
                            Pseudo n'a pas encore posté de message ou commentaire.
                        </p>
                    </div>

                    <!-- if posts or comments liked -->
                    <div id="posts-comments">



                        <div id="posts-end">
                            <p>Fin des messages et commentaires.</p>
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
import UserInfo from "../components/UserInfo.vue"
import ProfileNav from "../components/ProfileNav.vue"


export default {
	name: 'UserPostsComments',
	components: {
		ScrollToTopBtn,
		PostsHeader,
        UserInfo,
        ProfileNav
	}	
};

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#posts-comments {
    @include size (80%, auto);
    margin: 0 0 50px 0;
    @include flexbox(column, nowrap, space-around, center);
};




</style>

