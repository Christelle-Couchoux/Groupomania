<template>
    
    <div id="login-logo-title">
        
        <div id="logo">
            <img src="@/assets/logo/icon-above-font.png" alt="logo de Groupomania">
        </div>
        
        <h1>Réseau social interne</h1>    
    </div>
    
</template>


<script>

export default {
    name: 'LoginLogoTitle'
}

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#login-logo-title {
    @include flexbox(column, nowrap, center, center);
    @include position(relative, auto, auto, auto, auto);
    @include size(100%, auto);

    h1 {
        font-size: map-get($font-size, h1);
        margin: 0 0 50px 0;
        font-weight: 400;
    };
};

#logo {
    @include position(relative, auto, auto, auto, auto);
    @include size(80%, auto);
    max-width: 400px;
    margin: 30px 0 0 0;

    img {
        @include size(100%);
    };
};

</style>
