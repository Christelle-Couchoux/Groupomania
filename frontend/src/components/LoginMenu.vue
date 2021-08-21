<template>

    <nav id="login-menu">
        <ul>
            <li>
                <router-link to="/signup" title ="Inscription">
                    <p>Inscription</p>
                </router-link>
            </li>
            <li>
                <router-link to="/login" title ="Connexion">
                    <p>Connexion</p>
                </router-link>
            </li>
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
        text-align: center;
        @include size(50%, auto);
        transition: all 200ms ease-in-out;

        &:hover {
            @include menu-hover;
        };

        p {
            @include flexbox(row, nowrap, center, center);
            @include size(100%, auto);
            padding: 10px 20px 10px 20px;
        };
    };

    .router-link-active {
        @include menu-hover;
    };
};

</style>
