<template>

	<div id="user-search">
		<PostsHeader/>

		<main>

			<section id="user-search-content">
                <h1>Rechercher un utilisateur</h1>

                <div id="search-box">
                    <div id="search-bar">
                        <i id="magnifying-glass" class="fas fa-search" aria-hidden="true"></i>
                        <input type="search" placeholder="Rechercher..." name="search" id="search">
                    </div>
                </div>

                <div id="users-list">

                    <!-- if no notifications -->
                    <div id="no-users">
                        <p>
                            Aucun utilisateur ne correspond à la recherche.
                        </p>
                    </div>

                    <!-- if notifications -->
                    
                    <div id="users-end">
                        <p>Fin des utilisateurs.</p>
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



export default {
	name: 'Search',
	components: {
		ScrollToTopBtn,
		PostsHeader,

	}	
};

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#user-search {
    @include main   
};


#user-search-content {
    @include size(80%, auto);
    @include page;
};



#search-box {
    @include size(100%);
    @include first-under-h1;
    padding: 5px 0 5px 0;
};


#search-bar {
    @include flexbox(row, nowrap, space-around, center);
    @include size(80%);
    margin: auto;

    i {
        margin: 0 10px 0 10px;
        text-align: center;
    };

    input {
        padding: 5px;
        border: none;
        font-size: map-get($map: $font-size, $key: input);
        font-family: $montserrat;
    };

    #search {
        @include size(100%, 35px);
    };
};




#users-list {
    @include size(100%);
    border-bottom: none;
    margin: 194px 0 50px 0;
    padding: 5px 0 5px 0;
    @include flexbox(column, nowrap, space-around, center);
    
    @include lg {
        border-left: solid 1px $color-secondary; 
        margin: 0 0 0 0;
    }
};

#no-users {
    @include no-results;
};



#users-end {
    margin: 50px 0 50px 0;
};

</style>