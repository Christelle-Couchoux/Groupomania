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
					<router-link to="/posts" title="Accueil">
						<i class="fas fa-home" aria-label="Retour à l'accueil" role="img"></i>
						<span>Accueil</span>
					</router-link>
				</li>
				<li>
					<router-link to="/user/:userId/notifications" title="Notifications">
						<span id="bell">
							<i class="fas fa-bell" aria-label="Notifications" role="img"></i>
							<!-- if notifications where seen=false > 0 -->
							<span id="new-notif">
								<i class="fas fa-circle" aria-hidden="true"></i>
							</span>
						</span>
						<span>Notifications</span>
					</router-link>
				</li>
				<li>
					<router-link :to="{ name: 'UserPosts', params: { userId: currentUserId } }" title="Profil">
						<i class="fas fa-user" aria-label="Profil" role="img"></i>
						<span>Profil</span>
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
    data() {

    },
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
    @include size(100%, auto);
    @include position(fixed, 0, auto, auto, auto);
    @include flexbox(column, nowrap, center, center);
    border-bottom: solid 1px $color-secondary;
    background-color: $color-basic-light;
    z-index: 10;

    @include lg {
        border-bottom: none;
        width: 240px;
        @include position(fixed, auto, auto, auto, 0);
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
        transition: all 200ms ease-in-out;

        @include size(100%, auto);
        text-align: center;

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
                text-decoration: underline;
                text-underline-offset: 5px;
                text-decoration-thickness: 2px;
            };

            #new-notif {
                color: $color-basic-dark; 
            }
        };

        i {
            //@include position(relative, auto, auto, auto, auto);
            font-size: map-get($font-size, posts-menu-icon);
            transition: all 200ms ease-in-out;
        };

        span {
            display: none;
            
            @include xl {
                font-size: map-get($font-size, posts-text);
				font-weight: 700;
                display: inline;
                margin: 0 0 0 10px;               
            };
        };

        .router-link-active {
            color: $color-primary-dark;

            #new-notif {
                color: $color-basic-dark;
            };
        };

        #bell {
            @include position(relative, auto, auto, auto, auto);
            display: inline-block;
            margin: 0;
        };

        #new-notif {
            @include position(absolute, -10px, -3px, auto, auto);
            display: block;
            color: $color-primary-dark;
            
            i {
                font-size: 0.6rem;
            };
        };
    };    

};

</style>



