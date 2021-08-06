<template>

	<nav class="user-nav">
		<ul>
			<li>
				<router-link :to="{ name: 'UserPosts', params: { userId } }" title="Messages">
					<div><p>Messages</p></div>
				</router-link>
			</li>
			<li>
				<router-link :to="{ name: 'UserPostsComments', params: { userId } }" title="Messages et commentaires">
					<div><p>Messages & commentaires</p></div>
				</router-link>
			</li>
			<li>
				<router-link :to="{ name: 'UserLikes', params: { userId } }" title="J'aime">
					<div><p>J'aime</p></div>
				</router-link>
			</li>
		</ul>
	</nav>

</template>


<script>

export default {
    name: 'ProfileNav',
	created() {
        this.userId = localStorage.getItem("userId");
    }
}

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


.user-nav {
    @include size (100%, auto);
    margin: 0 0 15px 0;
    
    ul {
        @include list-style;
        @include flexbox(row, nowrap, space-around, center);
    };

    li {
        transition: all 200ms ease-in-out;
        @include flexbox(row, nowrap, center, center);
        @include size(100%, auto);
        text-align: center;

		div {
			@include size(100%, 50px);
			@include flexbox(row, nowrap, center, center);
		};

		a {
			@include size (100%, auto);
			border-bottom: solid 1px $color-secondary;

			&:hover {
				cursor: pointer;
				font-weight: 700;

				p {
					color: $color-primary-dark;
				};
			};	
        };     
    }; 

    // DO NOT MOVE! 
    // Needs to be outside li to not be overwritten
	/*
    .router-link-active {
        border-bottom: solid 1px $color-primary-dark;

        //a {
            color: $color-primary-dark;
            font-weight: 700;
        //};
    };  
	*/
	.router-link-exact-active {
        border-bottom: solid 1px $color-primary-dark;
        
		p {
			color: $color-primary-dark;
			font-weight: 700;
		};
    }; 
};





</style>




