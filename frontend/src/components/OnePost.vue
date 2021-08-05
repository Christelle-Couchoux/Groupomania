<template>

	<div class="post">
        <!-- if own post -->
        <div class="delete-post">
            <i class="fas fa-times" aria-label="Supprimer" role="button"></i>
        </div>

		<div class="post__title">
            <div class="post__title__photo">
                <router-link to="/user/:userId/" title="Aller au profil utilisateur">
                    <img
                        src="@/assets/avatar/default-user-avatar.jpg"
                        alt="Avatar de l'utilisateur"
                    />
                </router-link>
            </div>
            <div class="post__title__txt">
                <div class="post__title__pseudo">
                    <router-link to="/user/:userId/" title="Aller au profil utilisateur">
                        <p>Pseudomaximum16c</p>
                    </router-link>
                </div>
                <div class="post__title__divider">
                    <p>-</p>
                </div>
                <div class="post__title__date">
                    <p>xx min</p>
                </div>
            </div>
		</div>

		<div class="post__text">
			<p>
				Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
				tempor incididunt ut labore et dolore magna aliqua.
			</p>
		</div>

		<div class="post__img">
			<a href="@/assets/images/pic-epeiche.jpg" title="Agrandir la photo">
				<img
				src="@/assets/images/pic-epeiche.jpg"
				alt="Photo d'un pic-épeiche"
				/>
			</a>
		</div>

		<div class="post__buttons">
			<div class="post__btn post__btn--comment" title="Commenter">
				<div class="post__btn__icon">
					<i class="far fa-comment" aria-label="Commenter" role="img"></i>
				</div>
				<div class="post__btn__counter">
					<p>1</p>
				</div>
			</div>
			<div class="post__btn post__btn--like" title="Aimer">
				<div class="post__btn__icon">
					<i class="far fa-heart" aria-label="Aimer" role="img"></i>
				</div>
				<div class="post__btn__counter">
					<p>3</p>
				</div>
			</div>
		</div>
	</div>

</template>


<script>

export default {
    name: 'OnePost'
}

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';



.post {
    @include position(relative, auto, auto, auto, auto);
    @include size (100%, auto);
    border-bottom: solid 1px $color-secondary;
    padding: 30px 0 30px 0;

    &__title {
        @include flexbox(row, wrap, flex-start, center);
        margin: 5px 0 5px 0;

        &__photo {
            @include user-photo;
        };

        &__txt {
            @include flexbox(row, nowrap, flex-start, baseline);
        };

        &__pseudo {
            @include user-pseudo;
        };

        &__divider {
            margin: 0 5px 0 0;
            color: $color-secondary-dark;
        };

        &__date {
            margin: 0 0 0 0;
            color: $color-secondary-dark;
            font-size: 0.9rem;
        };
    };

    &__text {
        margin: 5px 0 5px 0;
    };

    &__img {
        @include post-img;
    };

    &__buttons {
        @include flexbox(row, nowrap, space-around, center);
        margin: auto;
        max-width: 600px;
    };

    &__btn {
        @include flexbox(row, nowrap, center, center);
        padding : 5px 20px 0 20px;
        color: $color-secondary-dark;
        transition: all 200ms ease-in-out;
        
        &:hover {
            cursor: pointer;
        };

        &__icon {
            margin: 0 10px 0 0;
            
            i {
                border-radius: 50%;
                padding: 10px;
            };
        }; 
        
        &--comment {
            &:hover {
                color: $color-basic-dark;

                i {
                    background-color: $color-basic-dark-lighter;
                };
            };
        };
    
        &--like {
            &:hover {
                color: $color-primary-dark;
                i {
                    background-color: $color-primary-light;
                };
            };
        };
    }; 
    
    .delete-post {
        @include delete-post-comment;
        @include position(absolute, 30px, 20px, auto, auto);

    };
};

</style>
