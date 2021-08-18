<template>

    <div id="articles">
        
        <header id="login-header">
            <LoginLogoTitle/>
        </header>

        <main v-if="this.currentUserId">
            <section id="articles-content">
                <p>Le forum articles n'est pas encore disponible...</p>
            </section>

            <div id="go-back">
                <router-link to="/Forums" title ="Forums">
                    Retour
                </router-link>
            </div>
            
        </main>

        <div class="access-denied-forums" v-else>
            <p>
                Vous devez être connecté pour accéder à cette page.
            </p>
        </div>

        <ScrollToTopBtn/>

    </div>

</template>


<script>

import ScrollToTopBtn from "../components/ScrollToTopBtn.vue"
import LoginLogoTitle from "../components/LoginLogoTitle.vue"


export default {
    name: 'Articles',

    components: {
        ScrollToTopBtn,
		LoginLogoTitle,
    },

    created() {
        this.currentUserId = localStorage.getItem("userId");
        this.currentUserPseudo = localStorage.getItem("pseudo");
        this.currentUserRole = localStorage.getItem("role");
    },
}

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#articles-content {
    text-align: center;
    font-size: map-get($font-size, articles-text);
};


#go-back {
    font-size: map-get($font-size, articles-go-back);
    text-align: center;
    margin: 80px 0 80px 0;
    text-decoration: underline;
    text-decoration-thickness: 2px;
    text-underline-offset: 5px;
    transition: all 200ms ease-in-out;

    a:hover {
        cursor: pointer;
        color: $color-primary-dark;
    };    
};


#articles {
    .access-denied-forums {
        @include access-denied-forums;
    }
};

</style>

