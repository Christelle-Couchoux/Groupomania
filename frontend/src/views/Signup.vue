<template>
    <div>
        
        <header id="login-header">
            <LoginLogoTitle/>
            <LoginMenu/>
        </header>

        <main>
            <section id="signup-form">
                <form @submit.prevent="checkForm" novalidate="true">
                    <div class="signup-errors" v-if="errors.length">
                        <p>Merci de corriger les erreurs suivantes :</p>
                        <ul>
                            <li v-for="error in errors" :key="error.name">{{ error }}</li>
                        </ul>
                    </div>

                    <div class="signup-errors" v-if="errorMessage">
                        <p>{{ errorMessage }}</p>
                    </div>

                    <div>
                        <label for="pseudo">Pseudo :</label>
                        <input
                            type="text" 
                            name="pseudo"
                            v-model="pseudo"
                            id="pseudo" 
                            required
                        >
                        <p>
                            3-16&nbsp;caractères.
                        </p>
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
                        <p>
                            8-20&nbsp;caractères. Au&nbsp;moins&nbsp;1&nbsp;chiffre, 
                            1&nbsp;majuscule, 1&nbsp;minuscule et 1&nbsp;caractère spécial. 
                            Pas&nbsp;d'espace.
                        </p>
                    </div>

                    <div class="btn-signup">
                        <input type="submit" value="S'inscrire">
                    </div>
                </form>

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

import { API } from '@/axios.config.js'
import router from '@/router/index.js'


export default {
    name: 'Signup',

    components: {
        ScrollToTopBtn,
		LoginLogoTitle,
        LoginMenu
    },

    data() {
        return {
            pseudo: "",
            email: "",
            password: "",
            errors: [],
            errorMessage: null,
        }
    },
    
    methods: {
        checkForm() {
            this.errors = [];
            if(!this.pseudo) {
                this.errors.push('Vous devez choisir un pseudo.');
            } else if(!this.validPseudo(this.pseudo)) {
                this.errors.push('Vous devez choisir un pseudo valide.')
            }

            if(!this.email) {
                this.errors.push('Vous devez indiquer une adresse email.');
            } else if(!this.validEmail(this.email)) {
                this.errors.push('Vous devez indiquer une adresse email valide.')
            }

            if(!this.password) {
                this.errors.push('Vous devez choisir un mot de passe.');
            } else if(!this.validPassword(this.password)) {
                this.errors.push('Vous devez choisir un mot de passe valide.')
            }
            
            if(!this.errors.length) { //if no errors
                this.submitSignup(); // send the form
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

        submitSignup() {
            API.post(`auth/signup`, {
                pseudo: this.pseudo,
                email: this.email,
                password: this.password
            })
            .then(response => {
                localStorage.setItem("token", response.data.token);
                localStorage.setItem("userId", response.data.userId);
                localStorage.setItem("pseudo", response.data.pseudo);
                localStorage.setItem("role", response.data.role);
                router.push(`/forums`);
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


#signup-form {
    @include form;

    .signup-errors {
        @include form-errors;
    };

    .btn-signup {
        @include btn;
        @include btn-login-signup;
    };   
};

#go-to-login {
	@include link-login-signup;
};

</style>

