<template>

	<router-view :key="$route.path"/>

</template>


<style lang='scss'>

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


* {
	box-sizing:border-box;
	margin: 0;
	padding: 0;
};


#app {
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	font-family: $montserrat;
	font-weight: 400;
	font-size: map-get($map: $font-size, $key: basic);
	@include links-style(map-get($color-txt, basic));
	@include color-bg-txt(basic);
	min-width: 320px;
	max-width: 1440px;
	margin: auto;
		
	i {
		display: inline-block;
	};
};

</style>
