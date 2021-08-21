<template>

	<div id="edit-profile">

		<PostsHeader/>

		<main v-if="this.currentUserId">

			<section id="edit-profile-content" v-for="userInfo in info" :key="userInfo.pseudo">
                <h1>Modifier le profil</h1>

                <div id="user-info">
                    <div id="user-photo">
                        <img :src="userInfo.user_photo">
                    </div>

                    <p class="pseudo">{{ userInfo.pseudo }}</p>

                    <div class="edit-profile-btn" v-if="currentUserId == userInfo.user_id || currentUserRole == 'admin'">
                        <router-link :to="{ name: 'UserPosts', params: { userId: userInfo.user_id } }" title="Retour au profil">
                            <input type="button" value="Retour au profil"/>
                        </router-link>
                    </div>

                    <p class="user-bio" v-if="userInfo.bio != null">
                        <strong>Bio :</strong>  {{ userInfo.bio }}
                    </p>

                </div>

                <div id="user-edit" v-if="currentUserId == userInfo.user_id || currentUserRole == 'admin'">
                    <div id="edit-form">
                        <div id="edit-profile-photo" v-if="newPhoto">
                            <img
                                :src="newPhoto"
                                alt="Avatar de l'utilisateur"
                            >
                        </div>

                        <div id="edit-profile-photo" v-else>
                            <img
                                :src="userInfo.user_photo"
                                alt="Avatar de l'utilisateur"
                            >
                        </div>

                        <form class="edit-profile-form" enctype="multipart/form-data">
                            <div class="edit-profile-form__field" id="photo-field">
                                <label for="file">
                                    <p>Modifier l'avatar</p>
                                </label>
                                <!-- name must be 'image' because multer save .single('image') -->
                                <input
                                    type="file"
                                    name="image"
                                    id="file"
                                    ref="file"
                                    @change="handleFileUpload"
                                    accept="image/png, image/jpeg, image/jpg, image/gif"
                                >
                            </div>

                            <div class="edit-profile-form__field">
                                <label for="bio">Bio : </label>
                                <textarea
                                    name="bio"
                                    id="bio"
                                    v-model="bio"
                                    placeholder="Présentez-vous&nbsp;!"
                                ></textarea>
                            </div>

                            <div class="edit-errors" v-if="errorMessage">
                                <p>{{ errorMessage }}</p>
                            </div>
                        </form>
                    </div>

                    <div id="edit-buttons">
                        <p id="modifications">Souhaitez-vous enregistrer les changements&nbsp;?</p>
                        <div class="save-profile-btn">
                            <input type="submit" value="Enregistrer" @click.prevent="checkBio">
                        </div>
                        <div class="undo-profile-btn">
                            <input type="submit" value="Annuler" @click.prevent="emptyForm">
                        </div>
                    </div>

                    <div id="delete-account">
                        <p id="delete-account-txt">
                            Êtes-vous sûr de vouloir supprimer le compte&nbsp;?<br>
                            La suppression est définitive&nbsp;!
                        </p>
                        <div class="delete-account-btn">
                            <input type="submit" value="Supprimer le compte" @click.prevent="deleteAccount">
                        </div>
                    </div>
                </div>
                <div class="unauthorized" v-else>
                    <p>Accès non autorisé&nbsp;!</p>
                    <div id="back-to-profile">
                        <router-link :to="{ name: 'UserPosts', params: { userId: userInfo.user_id } }" title="Retour au profil">
                            Retour au profil
                        </router-link>
                    </div>
                </div>

            </section>

		</main>

        <div class="access-denied" v-else>
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
import PostsHeader from '../components/PostsHeader.vue'

import { API } from '@/axios.config.js'
import router from '@/router/index.js'


export default {
	name: 'EditProfile',

    data() {
        return {
            user: '',
            bio: '',
            file: '',
			newPhoto: '',
            info: [],
            userInfo:'',
            errorMessage: null
        }
    },

	components: {
		ScrollToTopBtn,
		PostsHeader
	},

	created() {
        this.currentUserId = localStorage.getItem('userId');
        this.currentUserRole = localStorage.getItem('role');

        this.getUserInfo();
    },

    methods: {
        // display user info

        getUserInfo() {
            const userId = this.$route.params.userId;
            //console.log(userId);

            API.get(`users/${userId}/info`)
           .then(response => {
                this.info = response.data.info;
            })
            .catch(error => console.log(error));
        },


        // modify profile

        handleFileUpload() {
            this.file = this.$refs.file.files[0];
			this.newPhoto = URL.createObjectURL(this.file);
        },

        checkBio() {
            if(this.bio && !this.validBio(this.bio)) {
                this.errorMessage = 'Votre bio est trop longue (255 caractères maximum) ou comprend des caractères non autorisés.';
            } else { // if no errors
                this.editProfile(); // send the form
            }
        },

        validBio(bio) {
            const regex = /^[-\w\sÀÁÂÄÅÇÈÉÊËÌÍÎÏÑŒÒÓÔÕÖØÙÚÛÜàáâäåçèéêëìíîïñœòóôõöøùúûü.,!"'\\?/$£€() ]{1,255}$/;
            return regex.test(bio);
        },

        emptyForm() {
            this.file = '',
            this.newPhoto = '',
            this.bio = '',
            this.errorMessage = null
        },

        editProfile() {
            const formData = new FormData();
            if(this.file != '') {
                formData.append('image', this.file) // must be 'image' because multer save .single('image')
            }
            formData.append('bio', this.bio);

            API.put(`users/${this.$route.params.userId}`, formData)
            .then(response => {
                console.log(response);
                this.getUserInfo();
            })
            .catch(error => console.log(error));
        },


        // delete account

		deleteAccount() {
			API.delete(`users/${this.$route.params.userId}`)
			.then(response => {
				console.log(response);
                if(this.$route.params.userId == this.currentUserId) {
                    localStorage.clear();
                    router.push('/');
                } else if(this.currentUserRole == 'admin') {
                    router.push('/posts/');
                }
			})
			.catch(error => console.log(error));
		}
    }
};

</script>


<style lang='scss'>

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#edit-profile {
    @include main;
};


#edit-profile-content {
    @include page;
};


.back-to-profile-btn {
	@include btn(200px);
	@include btn-edit-profile;
    margin: 20px 10px 10px 10px;
};


#user-edit {
    @include flexbox(column, nowrap, space-around, center);
    padding: 20px 20px 20px 20px;

    @include lg {
        border-left: solid 1px $color-secondary;
    };
};


#edit-form {
    @include flexbox(column, nowrap, space-between, center);
    @include size(100%);

    @include xl {
        @include flexbox(row, nowrap, space-around, flex-start);
    };
};


#edit-profile-photo {
    @include flexbox(row, nowrap, center, center);
    @include size(150px);
    margin: 20px 20px 20px 20px;
    border-radius: 50%;

    @include lg {
        margin: 20px;
    };

    img {
        @include size(100%);
        object-fit: cover;
        border-radius: 50%;
    };
};


.edit-profile-form {
    @include size(90%);
    max-width: 500px;

    &__field {
        margin: 10px;
    };

    input {
        @include size(100%, 35px);
        @include form-field;
    };

    textarea {
        @include size(100%, 125px);
        @include form-field;
    };

    p {
        @include size(100%, auto);
        text-align: left;
        font-style: italic;
        font-size: map-get($font-size, field-constraints);
    };

    #file { // hide default file input
        @include size(0);
        opacity: 0;
    };

    #photo-field {
        transition: all 200ms ease-in-out;

        &:hover {
            color: $color-primary-dark;

            label {
                cursor: pointer;
            };
        };

        p {
            font-size: map-get($font-size, photo-field);
            font-style: normal;
            text-align: center;
            padding: 5px;
            border: solid 1px $color-secondary;
        };
    };

	.edit-errors {
        @include form-errors;
        margin: auto;
        margin-top: 30px;
        margin-bottom: 10px;

        @include sm {
            max-width: 450px;
        };
    };
};


#edit-buttons {
    @include flexbox(column, nowrap, space-around, center);
};


#modifications {
    text-align: center;
    @include size(100%, auto);
    margin: 30px 10px 10px 10px;
};


.save-profile-btn {
    @include btn;
    @include btn-save-profile;
    margin: 20px 40px 20px 40px;
};


.undo-profile-btn {
    @include btn;
    @include btn-undo;
    margin: 20px 40px 60px 40px;
};


#delete-account {
    @include flexbox(column, nowrap, space-around, center);
    @include size(100%, auto);
    border-top: solid 1px $color-secondary;
};


#delete-account-txt {
    text-align: center;
    font-weight: 700;
    color: $color-primary-dark;
    padding: 60px 10px 20px 10px;
};


.delete-account-btn {
    @include btn(300px);
    @include btn-delete-account;
    margin: 10px 10px 60px 10px;
};

.unauthorized {
    @include flexbox(column, nowrap, space-around, center);

    p {
        color: $color-primary-dark;
        font-size: map-get($font-size, unauthorized);
        margin: 80px 0 0 0;
        padding: 20px;
        border: solid 1px $color-primary-dark;
    };

    #back-to-profile {
        @include underlined(1px, 5px);
        text-align: center;
        margin: 80px 0 80px 0;
        transition: all 200ms ease-in-out;

        a:hover {
            cursor: pointer;
            color: $color-primary-dark;
        };
    };
};

</style>
