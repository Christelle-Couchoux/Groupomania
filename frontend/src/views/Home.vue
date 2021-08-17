<template>
	<div>
		<header id="login-header">
			<LoginLogoTitle/>
		</header>

		<main>

			<section id="home">
                <p>
                    Bienvenue sur le réseau social de Groupomania&nbsp;!<br><br>
                    Pour accéder aux forums, vous devez vous connecter.
                </p>

				<div class="btn-login">
					<router-link to="/login" title ="Connexion">
                        <input type="button" value="Se connecter">
                    </router-link>
				</div>
			</section>

		</main>


	</div>
	
</template>

<script>

import LoginLogoTitle from "../components/LoginLogoTitle.vue"


export default {
	name: 'Home',
	
	components: {
		LoginLogoTitle,
	}
	
};

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#home {
    @include flexbox(column, wrap, center, center);
    margin: auto;
    margin-top: 50px;
    @include size(80%, auto);

    p {
        margin: 0 0 50px 0;
        text-align: center;
        font-size: 1.3rem;
        line-height: 1.5rem;
    };
};



.btn-login{
	@include btn;
	@include btn-login-signup;
};

</style>

