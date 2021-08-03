<template>
	<div>
		<header id="login-header">
			<LoginLogoTitle/>
			<LoginMenu/>
		</header>

		<main>

			<section id="login-form">
				<form>
					<div>
						<label for="email">Email :</label>
						<input type="text" name="email" id="email" required>
					</div>
					<div>
						<label for="password">Mot de passe : </label>
						<input type="text" name="password" id="password" required>
					</div>
				</form>

				<div class="btn-login">
					<input type="submit" value="Se connecter">
				</div>
			</section>

			<div id="go-to-signup">
				<router-link to="/signup" title ="Inscription">
					Vous n'avez pas encore de compte&nbsp;?
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
	
};

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#login-form {
    @include form;
};

#go-to-signup {
	@include link-login-signup;
};

.btn-login{
	@include btn;
	@include btn-login-signup;
};

</style>

