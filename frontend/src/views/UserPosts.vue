<template>

	<div id="user-profile">
<!--
		<PostsHeader/>

		<main>

			<section id="user-profile-content">
                <h1>{{ user.user_id }}</h1>
                
                <UserInfo>
                    <template v-slot>
                        <!- v-if="userId === posts.userId"  
                        <div class="edit-profile-btn" v-if="currentUserId === user.user_id || currentUserRole === 'admin'">
                            <router-link :to="{ name: 'EditProfile', params: { userId: user.user_id } }" title="Éditer le profil">
                                <input type="button" value="Éditer le profil"/>
                            </router-link>
                        </div>
                    </template>
                </UserInfo>

                <div id="user-posts">

                    <ProfileNav/>
                
                    <!- if no posts yet 
                    <div id="no-posts" v-if="!posts">
                        <p>
                            {{ post.pseudo }} n'a pas encore posté de message.
                        </p>
                    </div>

                    <!- if posts 
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
-->
	</div>

</template>

<script>

//import ScrollToTopBtn from "../components/ScrollToTopBtn.vue"
//import PostsHeader from "../components/PostsHeader.vue"
//import UserInfo from "../components/UserInfo.vue"
//import ProfileNav from "../components/ProfileNav.vue"
//import OnePost from "../components/OnePost.vue"


export default {
	name: 'UserPosts',
	components: {
		//ScrollToTopBtn,
		//PostsHeader,
        //UserInfo,
        //ProfileNav,
        //OnePost
	},
    data() {
        return {
            posts: [],
            post: ''
        }
    },
    created() {
        this.currentUserId = localStorage.getItem("userId");
        this.currentUserPseudo = localStorage.getItem("pseudo");
        this.currentUserPhoto = localStorage.getItem("photo");
        this.currentUserRole = localStorage.getItem("role");
    },

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

