<template>

	<div id="edit-profile">
		<PostsHeader/>

		<main>

			<section id="edit-profile-content">
                <h1>Modifier le profil</h1>
                
                <UserInfo>
                    <template v-slot>
                        <div class="back-to-profile-btn">
                            <router-link :to="{ name: 'UserPosts', params: { currentUserId } }" title="Aller au profil utilisateur">
                                <input type="button" value="Retour au profil"/>
                            </router-link>
                        </div>
                    </template>
                </UserInfo>

                <div id="user-edit">
                    <div id="photo-form">
                        <div id="edit-profile-photo">
                            <img
                                :src="newPhoto"
                                alt="Avatar de l'utilisateur"
                                class="uploading-photo"
                            >
                        </div>

                        <form class="edit-profile-form" enctype="multipart/form-data">
							<div class="edit-errors" v-if="errorMessage">
								<p>{{ errorMessage }}</p>
							</div>

                            <div class="edit-profile-form__field" id="photo-field">
                                <label for="file">
                                    <p>Modifier la photo</p>
                                </label>
                                <input
                                    type="file"
                                    name="file"
                                    id="file"
                                    ref="file"
                                    v-on:change="handleFileUpload()"
                                    accept="image/png, image/jpeg, image/jpg"
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
                                <p id="required-fields">Les champs marqués d'un * sont obligatoires</p>
                            </div>    
                        </form>
                    </div>

                    <div id="edit-buttons">
                        <p id="modifications">Souhaitez-vous enregistrer les changements&nbsp;?</p>
                        <div class="save-profile-btn">
                            <input type="submit" value="Enregistrer" v-on:click="submitFile()">
                        </div>
                        <div class="undo-profile-btn">
                            <input type="submit" value="Annuler">
                        </div>
                    </div>

                    <div id="delete-account">
                        <p id="delete-account-txt">
                            Êtes-vous sûr de vouloir supprimer le compte&nbsp;?<br>
                            La suppression est définitive&nbsp;!
                        </p>
                        <div class="delete-account-btn">
                            <input type="submit" value="Supprimer le compte" v-on:click="deleteAccount()">
                        </div>
                    </div>
                </div>
                

            </section>

		</main>

		<ScrollToTopBtn/>

	</div>

</template>

<script>

import ScrollToTopBtn from "../components/ScrollToTopBtn.vue"
import PostsHeader from "../components/PostsHeader.vue"
import UserInfo from "../components/UserInfo.vue"

import { API } from '@/axios.config.js'
import router from '@/router/index.js'


export default {
	name: 'EditProfile',
    data() {
        return {
            user: '',
            bio: '',
            file: '',
			newPhoto: ''
        }
    },
	components: {
		ScrollToTopBtn,
		PostsHeader,
        UserInfo
	},
	created() {
        this.currentUserId = localStorage.getItem("userId");
        this.currentUserPseudo = localStorage.getItem("pseudo");

		API.get(`users/${this.currentUserId}`)
        .then(response => {
            this.pseudo = response.data.pseudo;
			this.photo = response.data.user_photo;
			this.bio = response.data.bio;
            console.log(response);
        })
        .catch(error => {
            this.errorMessage = error.response.data.error;
        })	
    },
    methods: {
        handleFileUpload() {
            this.file = this.$refs.file.files[0];
			this.newPhoto = URL.createObjectURL(this.file)
        },

        submitFile() {
            let formData = new FormData();
            formData.append('file', this.file);
			formData.append('bio', this.bio)

            API.put(`users/${this.currentUserId}`, formData)
            .then(response => {
                localStorage.setItem("photo", response.data.user_photo);
				localStorage.setItem("bio", response.data.bio);
            })
            .catch(error => {
                this.errorMessage = error.response.data.error;
            })
        },

		deleteAccount() {
			API.delete(`users/${this.currentUserId}`)
			.then(response => {
				console.log(response)
				localStorage.clear();
				router.push('/');
			})
			.catch(error => console.log(error));
			
		}
    }
};

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#edit-profile {
    @include main   
};


#edit-profile-content {
    @include page;
};


.back-to-profile-btn {
	@include btn(200px);
	@include btn-edit-profile;
    margin: 20px 10px 10px 10px;

    @include lg {
        order: 2;
    }
};


#user-edit {
    @include flexbox(column, nowrap, space-around, center);
    padding: 20px 20px 20px 20px;

    @include lg {
        border-left: solid 1px $color-secondary; 
    };
};


#photo-form {
    @include size(100%);
    @include flexbox(column, nowrap, space-between, center);

    @include xl {
        @include flexbox(row, nowrap, space-around, flex-start);
    };
};


#edit-profile-photo {
    @include flexbox(row, nowrap, center, center);
    @include size(150px);
    border-radius: 50%;
    margin: 20px 20px 20px 20px;

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

    @include lg {
        @include size(90%);
    };

    &__field {
        margin: 10px;
    };

    input {
        @include size(100%, 35px);
        margin: 3px 0 3px 0;
        padding: 5px;
        border: solid 1px $color-secondary;
        font-size: map-get($map: $font-size, $key: input);
        font-family: $montserrat;
    };

    textarea {
        @include size(100%, 125px);
        margin: 3px 0 3px 0;
        padding: 5px;
        border: solid 1px $color-secondary;
        font-size: map-get($map: $font-size, $key: input);
        font-family: $montserrat;
    };

    p {
        @include size(100%, auto);
        text-align: left;
        font-style: italic;
        font-size: map-get($font-size, field-constraints);
    };

    #required-fields {
        margin: 20px auto;
    };

    #file {
        @include size(0);
        opacity: 0;
    };

    #photo-field {
        transition: all 200ms ease-in-out;

        &:hover {
            color: $color-primary-dark;

            label {
                cursor: pointer;
            }
        };

        p {
            padding: 5px;
            border: solid 1px $color-secondary;
            text-align: center;
            font-style: normal;
            font-size: 1rem;
        }
    };

	.edit-errors {
        @include form-errors;
    };
};


#edit-buttons {
    @include flexbox(column, nowrap, space-around, center);
};

#modifications {
    @include size(100%, auto);
    margin: 50px 10px 10px 10px;
    text-align: center;
};

.save-profile-btn {
    @include btn;
    @include btn-save-profile;
    margin: 20px 40px 20px 40px;
};

.undo-profile-btn {
    @include btn;
    @include btn-undo-profile;
    margin: 20px 40px 60px 40px;
};

#delete-account {
    @include flexbox(column, nowrap, space-around, center);
    border-top: solid 1px $color-secondary; 
    @include size(100%, auto);
};

#delete-account-txt {
    padding: 60px 10px 20px 10px;
    text-align: center;
    font-weight: 700;
    color: $color-primary-dark;
};

.delete-account-btn {
    @include btn(300px);
    @include btn-delete-account;
    margin: 10px 10px 60px 10px;
};


</style>

