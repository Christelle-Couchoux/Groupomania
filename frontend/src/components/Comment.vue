<template>
	<div class="comment">
		<!-- if own comment -->
        <div class="delete-comment">
            <i class="fas fa-times" aria-label="Supprimer" role="button"></i>
        </div>

		<div class="comment__title">
			<div class="comment__title__photo">
				<router-link to="/user/:userId/" title="Aller au profil utilisateur">
					<img
						src="@/assets/avatar/default-user-avatar3.png"
						alt="Avatar de l'utilisateur"
					/>
				</router-link>
			</div>
			<div class="comment__title__txt">
				<div class="comment__title__pseudo">
					<router-link to="/user/:userId/" title="Aller au profil utilisateur">
						<p>Utilisateur3</p>
					</router-link>
				</div>
				<div class="comment__title__divider">
					<p>-</p>
				</div>
				<div class="comment__title__date">
					<p>xx min</p>
				</div>
			</div>
		</div>

		<div class="comment__text">
			<p>
				Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
				tempor incididunt ut labore et dolore magna aliqua.
			</p>
		</div>

		<div class="comment__likes">
            <div class="comment__likes__btn" title="Aimer">
                <i class="far fa-heart" aria-label="Aimer" role="img"></i>
            </div>
            <div class="comment__likes__count" title="Voir les utilisateurs qui aiment ce message">
                <router-link to="/posts/:postId/likes" title="Voir les utilisateurs qui aiment ce message">
                    <p>2 &nbsp; J'aime</p>
                </router-link>
            </div>
		</div>
	</div>
</template>


<script>

export default {
	name: 'Comment',	
};

</script>



<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


.comment {
    @include position(relative, auto, auto, auto, auto);
    @include size (100%, auto);
    padding: 0 0 20px 0;

    &:last-child {
        border-bottom: solid 1px $color-secondary; // add bottom line to last comment
    };

    //@include flexbox(column, nowrap, space-around, center);

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

    &__likes {
        @include btn-like-count;
	};
    
    .delete-comment {
        @include delete-post-comment;
    };
};

</style>
