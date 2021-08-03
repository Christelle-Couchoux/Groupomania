<template>

    <nav id="login-menu">
        <ul>
            <li><router-link to="/signup" title ="Inscription"><p>Inscription</p></router-link></li>
            <li><router-link to="/login" title ="Connexion"><p>Connexion</p></router-link></li>
        </ul>
    </nav>

</template>


<script>

export default {
    name: 'LoginMenu'
}

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#login-menu {
    font-size: map-get($map: $font-size, $key: login-menu);
    font-weight: 700;
    text-transform: uppercase;

    @include size (100%, auto);
    max-width: 992px;

    ul {
        @include list-style;
        @include flexbox(row, nowrap, space-around, center);
    };

    li {
        @include size(50%, auto);
        text-align: center;
        transition: all 200ms ease-in-out;

        &:hover {
            text-decoration: underline;
            text-underline-offset: 5px;
            text-decoration-thickness: 2px;
            cursor: pointer;

            a {
                color: $color-primary-dark;
            };
        };

        p {
            @include size(100%, auto);
            @include flexbox(row, nowrap, center, center);
            padding: 10px 20px 10px 20px;
        };
    };

    .router-link-active {
        text-decoration: underline;
        text-underline-offset: 5px;
        text-decoration-thickness: 2px;
    };
};

</style>
