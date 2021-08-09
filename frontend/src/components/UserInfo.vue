<template>

	<div id="user-info">
		<div id="user-photo">
			<router-link :to="{ name: 'UserPosts', params: { userId: userId } }"  title="Voir le profil de l'utilisateur">
				<img :src="userPhoto" alt="Avatar de l'utilisateur"/>
			</router-link>
		</div>

		<p class="pseudo">{{ pseudo }}</p>

        <div class="edit-profile-btn" v-if="currentUserId === userId || currentUserRole === 'admin'">
            <router-link :to="{ name: 'EditProfile', params: { userId: userId } }" title="Éditer le profil">
                <input type="button" value="Éditer le profil"/>
            </router-link>
        </div>

		<p class="user-bio">
			<strong>Bio :</strong>  {{ bio }}
		</p>

        <div class="user-info-errors" v-if="errorMessage">
            <p>{{ errorMessage }}</p>
        </div>
	</div>

</template>


<script>
//import { API } from '@/axios.config.js'
//import router from '@/router/index.js'

export default {
	name: "UserInfo",
    props: ['userId', 'userPhoto', 'pseudo', 'bio'],
    data() {
        return {
            errorMessage: null,
        }
    },
    created() {
        this.currentUserId = localStorage.getItem("userId");
        this.currentUserPseudo = localStorage.getItem("pseudo");
    },
};

</script>


<style lang="scss">

@import "@/scss/variables.scss";
@import "@/scss/mixins.scss";


#user-info {
	@include first-under-h1;
    @include flexbox(column, wrap, space-around, center);

    @include lg {
        @include flexbox(row, wrap, space-around, center);
    };

    .user-info-errors {
        @include form-errors;
    };

    .edit-profile-btn {
        @include btn(200px);
        @include btn-edit-profile;
        margin: 20px 10px 10px 10px;

        @include lg {
            order: 2;
        };
    };
};


#user-photo {
    @include size(120px);
    border-radius: 50%;
    margin: 20px 10px 10px 10px;
    padding: 2px;
    border: solid 3px $color-basic-dark;
    transition: all 200ms ease-in-out;

    @include lg {
        order: 1;
    };

    img {
        @include size(100%);
        object-fit: cover;
        border-radius: 50%;
    };
};


.pseudo {
    @include size(90%, auto);
    font-size: map-get($font-size, pseudo);
    color: map-get($color-txt, pseudo);
    margin: 10px;
    text-align: center;
    transition: all 200ms ease-in-out;

    @include lg {
        order: 3;
    }
};


.user-bio {
    @include size(90%, auto);
    margin: 10px 10px 20px 10px;
    padding: 0 10px;

    @include lg {
        order: 4;
    }
};

</style>



