<template>

	<div id="user-info">
		<div id="user-photo">
			<router-link :to="{ name: 'UserPosts', params: { userId: user.user_id } }"  title="Voir le profil de l'utilisateur">
				<img :src="user.user_photo" alt="Avatar de l'utilisateur"/>
			</router-link>
		</div>

		<p class="pseudo">{{ user.pseudo }}</p>

		<slot></slot>

		<p class="user-bio" v-if="user.bio">
			<strong>Bio :</strong> {{user.bio}}.
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

    &:hover {
        border: solid 5px $color-primary-dark;
        padding: 0;
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



