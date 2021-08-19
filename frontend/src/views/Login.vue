<template>
	<div>
		<header id="login-header">
			<LoginLogoTitle/>
			<LoginMenu/>
		</header>

		<main>

			<section id="login-form">
				<form @submit.prevent="checkForm" novalidate="true">
					<div class="login-errors" v-if="errors.length">
                        <p>Merci de corriger les erreurs suivantes :</p>
                        <ul>
                            <li v-for="error in errors" :key="error.name">{{ error }}</li>
                        </ul>
                    </div>

                    <div class="login-errors" v-if="errorMessage">
                        <p>{{ errorMessage }}</p>
                    </div>
                        
					<div>
						<label for="email">Email :</label>
						<input
                            type="email"
                            name="email"
                            v-model="email"
                            id="email"
                            required
                        >
					</div>
					<div>
						<label for="password">Mot de passe : </label>
						<input
                            type="password"
                            name="password"
                            v-model="password"
                            id="password"
                            required
                        >
					</div>

					<div class="btn-login">
						<input type="submit" value="Se connecter">
					</div>
				</form>

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

import { API } from '@/axios.config.js'
import router from '@/router/index.js'


export default {
	name: 'Login',

	components: {
		ScrollToTopBtn,
		LoginLogoTitle,
		LoginMenu
	},

	data() {
        return {
            email: '',
            password: '',
            errors: [],
            errorMessage: null
        }
    },
    
	methods: {
        checkForm() {
            this.errors = [];
            if(!this.email) {
                this.errors.push('Vous devez indiquer une adresse email.');
            } else if(!this.validEmail(this.email)) {
                this.errors.push('Vous devez indiquer une adresse email valide.')
            }

            if(!this.password) {
                this.errors.push('Vous devez indiquer un mot de passe.');
            } else if(!this.validPassword(this.password)) {
                this.errors.push('Vous devez indiquer un mot de passe valide.')
            }
            
            if(!this.errors.length) { //if no errors
                this.submitLogin(); // send the form
            }
        },

        validPseudo(pseudo) {
            const regex = /^[-\w\sÀÁÂÄÅÇÈÉÊËÌÍÎÏÑŒÒÓÔÕÖØÙÚÛÜàáâäåçèéêëìíîïñœòóôõöøùúûü]{3,16}$/;
            return regex.test(pseudo);
        },

        validEmail(email) {
            const regex = /^([\w-.]+@([\w-]+\.)+[\w-]{2,4})?$/;
            return regex.test(email);
        },

        validPassword(password) {
            const regex = /^(?=.*[a-zàáâäåçèéêëìíîïñœòóôõöøùúûü])(?=.*[A-ZÀÁÂÄÅÇÈÉÊËÌÍÎÏÑŒÒÓÔÕÖØÙÚÛÜ])(?=.*[0-9])(?=.*[!@#$%^&*])(?=.{8,20})/;
            return regex.test(password);
        },

        submitLogin() {
            API.post(`auth/login`, {
                email: this.email,
                password: this.password
            })
            .then(response => {
                localStorage.setItem("token", response.data.token);
                localStorage.setItem("userId", response.data.userId);
                localStorage.setItem("role", response.data.role);
                router.push('/forums');
                //console.log(response)
            })
            .catch(error => {
                this.errorMessage = error.response.data.error;
            })
        }
    }
};

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#login-header {
    @include flexbox(column, nowrap, center, center);
};

#login-form {
    @include form;

	.login-errors {
        @include form-errors;
    };

	.btn-login{
		@include btn;
		@include btn-login-signup;
	};
};

#go-to-signup {
	@include link-login-signup;
};



</style>

