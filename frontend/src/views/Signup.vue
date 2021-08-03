<template>
    <div>
        
        <header id="login-header">
            <LoginLogoTitle/>
            <LoginMenu/>
        </header>

        <main>
            <section id="signup-form">
                <form>
                    <div>
                        <label for="pseudo">Pseudo :</label>
                        <input type="text" name="pseudo" id="pseudo" required>
                        <p>
                            3-16&nbsp;caractères.
                        </p>
                    </div>
                    <div>
                        <label for="email">Email :</label>
                        <input type="text" name="email" id="email" required>
                    </div>
                    <div>
                        <label for="password">Mot de passe : </label>
                        <input type="text" name="password" id="password" required>
                        <p>
                            8-20&nbsp;caractères. Au&nbsp;moins&nbsp;1&nbsp;chiffre, 
                            1&nbsp;majuscule, 1&nbsp;minuscule et 1&nbsp;caractère spécial. 
                            Pas&nbsp;d'espace.
                        </p>
                    </div>
                </form>

                <div class="btn-signup">
                    <input type="submit" value="S'inscrire">
                </div>
            </section>

            <div id="go-to-login">
                <router-link to="/login" title ="Connexion">
                    Vous avez déjà un compte&nbsp;?
                </router-link>
            </div>
            
        </main>

        <ScrollToTopBtn/>

    </div>

</template>

<script>

import ScrollToTopBtn from "../components/ScrollToTopBtn.vue"
import LoginLogoTitle from "../components/LoginLogoTitle.vue"
import LoginMenu from "../components/LoginMenu.vue"


export default {
  name: 'Login',
  components: {
		ScrollToTopBtn,
		LoginLogoTitle,
        LoginMenu
  }
}

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#signup-form {
    @include form
};

#go-to-login {
	@include link-login-signup;
};

.btn-signup {
	@include btn;
	@include btn-login-signup;
};

</style>

