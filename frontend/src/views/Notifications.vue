<template>

	<div id="notifications">
		<PostsHeader/>

		<main>

			<section id="notifications-content">
                <h1>Notifications</h1>

                <div id="notifications-list">

                    <!-- if no notifications -->
                    <div id="no-notifications">
                        <p>
                            Vous n'avez pas de notification.
                        </p>
                    </div>

                    <!-- if notifications -->
                    <div id="notifications">



                        <div id="notifications-end">
                            <p>Fin des messages.</p>
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



export default {
	name: 'Notifications',
	components: {
		ScrollToTopBtn,
		PostsHeader,

	}	
};

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#notifications {
    @include main   
};


#notifications-content {
    @include size(80%, auto);
    @include page;
};


#notifications-list {
    @include first-under-h1;
    border-bottom: none;
    @include size(100%);
    margin: 194px 0 50px 0;
    padding: 5px 0 5px 0;
    @include flexbox(column, nowrap, space-around, center);
};


#no-notifications {
    @include no-results;
};




#notifications-end {
    margin: 50px 0 0 0;
};

</style>