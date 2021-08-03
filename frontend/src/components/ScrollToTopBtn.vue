<template>

    <button id="scroll-to-top">
        <i class="fas fa-chevron-up" aria-label="Retour en haut de la page" role="img"></i>
    </button>

</template>


<script>

export default {
    name: 'ScrollToTopBtn'
};

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#scroll-to-top {
    z-index: 99; // above everything
    // display: none; // hidden by default  uncomment when js
    font-size: 1.3rem;
    @include color-bg-txt(btn-scroll);
    @include position(fixed, auto, 20px, 20px, auto);
    @include size(40px);
    border-radius: 50%;
    border: none;
    cursor: pointer;
    transition: all 200ms ease-in-out;

    &:hover{
        background-color: $color-primary-dark,
    };

    .fas{
        padding: 3px 0 0 0;
    };
}

</style>
