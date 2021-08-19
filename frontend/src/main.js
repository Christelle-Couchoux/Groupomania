import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import moment from 'moment'


createApp(App).use(router).mount('#app');

App.moment = moment;
moment.locale('fr');
moment.tz.setDefault();

var VueScrollTo = require('vue-scrollto');
App.use(VueScrollTo);
