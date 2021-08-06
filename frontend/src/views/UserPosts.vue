<template>

	<div id="user-profile">
		<PostsHeader/>

		<main>

			<section id="user-profile-content">
                <h1>{{ pseudo }}</h1>
                
                <UserInfo>
                    <template v-slot>
                        <!-- v-if="userId === posts.userId"  -->
                        <div class="edit-profile-btn">
                            <router-link :to="{ name: 'EditProfile', params: { userId } }" title="Éditer le profil">
                                <input type="button" value="Éditer le profil"/>
                            </router-link>
                        </div>
                    </template>
                </UserInfo>

                <div id="user-posts">

                    <ProfileNav/>
                
                    <!-- if no posts yet -->
                    <div id="no-posts">
                        <p>
                            Pseudomaximum16c n'a pas encore posté de message.
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
import UserInfo from "../components/UserInfo.vue"
import ProfileNav from "../components/ProfileNav.vue"
import OnePost from "../components/OnePost.vue"


export default {
	name: 'UserPosts',
	components: {
		ScrollToTopBtn,
		PostsHeader,
        UserInfo,
        ProfileNav,
        OnePost
	},
    created() {
        this.userId = localStorage.getItem("userId");
        this.pseudo = localStorage.getItem("pseudo");
        this.photo = localStorage.getItem("photo");
    }	
};

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#user-profile {
    @include main   
};


#user-profile-content {
    @include page;
};


.edit-profile-btn {
	@include btn(200px);
	@include btn-edit-profile;
    margin: 20px 10px 10px 10px;

    @include lg {
        order: 2;
    }
};



#user-posts {
    @include size(100%);
    @include flexbox(column, nowrap, space-around, center);

    @include lg {
        border-left: solid 1px $color-secondary; 
    };     
};


#no-posts {
    @include no-results;
};


#posts {
    @include size (80%, auto);
    margin: 0 0 50px 0;
    @include flexbox(column, nowrap, space-around, center);
};


#posts-end {
    margin: 50px 0 0 0;
};


</style>

