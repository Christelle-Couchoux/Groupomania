<template>

    <button id="scroll-to-top" title="Retour en haut de la page">
        <i class="fas fa-chevron-up" aria-label="Retour en haut de la page" role="img"></i>
    </button>

</template>


<script>

export default {
    name: 'ScrollToTopBtn',

    mounted() {
        document.addEventListener('scroll', this.showBtnScroll);
        const btnScroll = document.getElementById('scroll-to-top');
        btnScroll.addEventListener('click', this.scrollToTop);
    },

    methods: {
        showBtnScroll(){
            const btnScroll = document.getElementById('scroll-to-top');
            if(document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
                btnScroll.style.display = 'block'; // show button
            } else {
                btnScroll.style.display = 'none'; // otherwise hide
            }
        },

        scrollToTop() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        }
    }
};

</script>


<style lang="scss">

@import '@/scss/variables.scss';
@import '@/scss/mixins.scss';


#scroll-to-top {
    display: none; // hidden by default
    font-size: map-get($font-size, scroll-to-top);
    @include color-bg-txt(btn-scroll);
    @include position(fixed, auto, 20px, 20px, auto);
    z-index: 99; // above everything
    @include size(40px);
    border-radius: 50%;
    border: none;
    transition: all 200ms ease-in-out;

    &:hover{
        cursor: pointer;
        background-color: $color-primary-dark,
    };

    .fas{
        padding: 3px 0 0 0;
    };
}

</style>
