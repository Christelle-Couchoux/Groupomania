<template>

	<header id="posts-header">
		<div id="posts-logo">
			<router-link to="/forums" title ="Retour aux forums">
                <img src="@/assets/logo/icon.png" alt="logo de Groupomania">
            </router-link>
		</div>

		<nav id="posts-menu">
			<ul>
				<li>
					<router-link to="/posts" title="Messages">
						<i class="fas fa-home" aria-label="Messages" role="img"></i>
						<span>Messages</span>
					</router-link>
				</li>
				<li>
					<router-link :to="{ name: 'UserPosts', params: { userId: currentUserId } }" title="Mon profil">
						<i class="fas fa-user" aria-label="Mon profil" role="img"></i>
						<span>Mon profil</span>
					</router-link>
				</li>
				<li>
					<router-link to="/search" title="Rechercher un utilisateur">
						<i class="fas fa-search" aria-label="Rechercher un utilisateur" role="img"></i>
						<span>Rechercher</span>
					</router-link>
				</li>
				<li>
					<router-link to="/" title ="Se déconnecter" @click="logout()">
						<i class="fas fa-power-off" aria-label="Se déconnecter" role="img"></i>
						<span>Se déconnecter</span>
					</router-link>
				</li>
			</ul>
		</nav>
	</header>

</template>


<script>

export default {
    name: 'PostsHeader',

    created() {
        this.currentUserId = localStorage.getItem("userId");
    },

    methods: {
        logout() {
            localStorage.clear();
        }
    }
}

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#posts-header {
    background-color: $color-basic-light;
    @include flexbox(column, nowrap, center, center);
    @include position(fixed, 0, auto, auto, auto);
    z-index: 10;
    @include size(100%, auto);
    border-bottom: solid 1px $color-secondary;

    @include lg {
        @include position(fixed, auto, auto, auto, 0);
        width: 240px;
        border-bottom: none;        
    };

    @include xxl {
        @include position(fixed, 0, calc(50% - 720px), auto, calc(50% - 720px));
    };
};


#posts-logo {
    @include size(50px);
    margin: 20px 0 10px 0;
    transition: all 200ms ease-in-out;

    img {
        @include size(100%);
    };

    &:hover {
        transform: scale(1.3);
    };
};


#posts-menu {
    @include size (100%, auto);
    max-height: 500px;
    margin: 10px 0 15px 0;

    ul {
        @include list-style;
        @include flexbox(row, nowrap, space-around, center);
        padding: 0 15px 0 15px;

        @include lg {
            @include flexbox(column, nowrap, space-between, space-around);
        };
    };

    li {
        text-align: center;
        @include size(100%, auto);
        transition: all 200ms ease-in-out;

        @include lg {
            margin: 30px 0 30px ;
        };

        @include xl {
            text-align: left;
        };

        &:hover {
            cursor: pointer;

            a {
                color: $color-primary-dark;
            };

            i {
                transform: scale(1.5);
            };

            span {
                @include menu-hover;
            };
        };

        i {
            font-size: map-get($font-size, posts-menu-icon);
            transition: all 200ms ease-in-out;
        };

        span {
            display: none;
            transition: all 200ms ease-in-out;

            @include xl {
                font-size: map-get($font-size, posts-menu-text);
				font-weight: 700;
                display: inline;
                margin: 0 0 0 10px;
            };
        };

        .router-link-active {
            color: $color-primary-dark;
        };
    };
};

</style>
