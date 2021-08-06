<template>

	<div id="user-info">
		<div id="user-photo">
			<router-link :to="{ name: 'UserPosts', params: { userId } }" title="Aller au profil utilisateur">
				<img src="@/assets/avatar/default-user-avatar.jpg" alt="Avatar de l'utilisateur"/>
			</router-link>
		</div>

		<p class="pseudo">{{ pseudo }}</p>

		<slot></slot>

		<p class="user-bio">
			<strong>Bio :</strong> Lorem ipsum dolor sit amet, consectetur adipiscing
			elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
			Ut enim ad minim veniam.
		</p>
	</div>

</template>


<script>

export default {
	name: "UserInfo",
    created() {
        this.userId = localStorage.getItem("userId");
        this.pseudo = localStorage.getItem("pseudo");
        this.photo = localStorage.getItem("photo");


    }
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



