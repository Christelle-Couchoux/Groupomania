<template>

    <div id="forums">

        <header id="login-header">
            <LoginLogoTitle/>
        </header>

        <main v-if="this.currentUserId">

            <section id="forums-content">
                <router-link to="/Articles" title ="Forum articles">
                    <div class="forum-option">
                        <i class="far fa-newspaper" aria-hidden="true"></i>
                        <p>Partager des articles</p>
                    </div>
                </router-link>
                <router-link to="/Posts" title ="Forum photos et gifs">
                    <div class="forum-option">
                        <i class="far fa-image" aria-hidden="true"></i>
                        <p>Partager des gifs <br>et des photos</p>
                    </div>
                </router-link>
            </section>

            <div id="logout">
                <router-link to="/" title ="Déconnexion" @click="logout">
                    <p>Se déconnecter&nbsp;?</p>
                </router-link>
            </div>

        </main>

        <div class="access-denied-forums" v-else>
            <p>Vous devez être connecté pour accéder à cette page.</p>
            <div class="btn-login">
				<router-link to="/login" title ="Connexion">
                    <input type="button" value="Se connecter">
                </router-link>
			</div>
        </div>

        <ScrollToTopBtn/>

    </div>

</template>


<script>

import ScrollToTopBtn from '../components/ScrollToTopBtn.vue'
import LoginLogoTitle from '../components/LoginLogoTitle.vue'


export default {
    name: 'Forums',

    components: {
        ScrollToTopBtn,
		LoginLogoTitle
    },

    created() {
        this.currentUserId = localStorage.getItem('userId');
    },

    methods: {
        logout() {
            localStorage.clear();
        }
    }
}

</script>


<style lang='scss'>

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#forums-content {
    @include flexbox(row, nowrap, space-around, center);
    @include size (100%, auto);
    max-width: 992px;
    margin: 0 auto;
};


.forum-option {
    @include flexbox(column, nowrap, center, center);
    @include size(160px, 160px);
    border-radius: 20px;
    transition: all 200ms ease-in-out;

    .far {
        font-size: map-get($font-size, forums-icon);
    };

    p {
        text-align: center;
        margin: 5px 0 0 0;
    };

    &:hover {
        cursor: pointer;
        color: $color-primary-dark;
        border: solid 2px $color-primary-dark;
    };
};


#logout {
 @include link-login-signup;
};


.access-denied-forums {
    @include access-denied;
    @include access-denied-forums;
};

</style>
